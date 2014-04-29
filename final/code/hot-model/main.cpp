//  main.cpp
//  HOT_model
//
//  Created by Andy Reagan on 3/12/13.
//  Copyright (c) 2013 Andy Reagan. All rights reserved.
//
//  Goal: simulate the 1-D HOT Model

// from random import random,randint
#include <cstdlib>
#include <ctime>

// from math import exp
#include <cmath>
#include <list>
#include <vector>

// save this to a file
#include <iostream>
#include <fstream>
#include <iomanip>
#include <string>

// getting environment variables
// actually not going to do this right yet

using namespace std;

// function declarations
int sparkgen ( );
int burner ( int spark );
int optimal_tree_finder( ofstream& outputFile, int test_locs[] );

// global variables
const int N=1000000; // size of forest
const int n=10; // burns to test
const int D=1; // design parameter
double pmf_int[N]; // probablity distribution
bool forest[N] = { false }; // the forest

// main function
int main()
{
    ofstream outputFile;
    
    char ss[100];

    sprintf(ss,"N%dn%dD%d.csv",N,n,D);

    outputFile.open(ss);
    // intialize random seed
    srand((unsigned)time(NULL));
    
    // number of sites
    cout<<"N is "<<N<<"\n";
    cout<<"n is "<<n<<endl;
    cout<<"D is "<<D<<endl;
    cout<<"RUNNING"<<endl;
    
    // normalize the probablity of sparks
    double tmp = 0.0;
    double charac_scale = 2.0*pow(double(10),2); // this power is key
    for (int i = 1; i < N; i++)
    {
        // sum up the probablity distribution
        tmp=tmp+exp(-i/charac_scale);
    }
    // flip this for the contant
    double normalization_constant=double(1)/tmp;
    //cout<<"Normalization constant is "<<normalization_constant<<"\n";
    
    // sample this distibution by
    // dividing the unit interval into chunks
    pmf_int[0]=0;
    // make intervals of with p(i)
    for (int i = 1; i < N; i++)
    { 
        pmf_int[i]=pmf_int[i-1]+normalization_constant*exp(-i/charac_scale);
    }
    
    // check the end of pmf_int
    //cout<<"End of pmf_int is "<<pmf_int[N-30]<<endl;
    
    // test the spark generator
    /* 
    cout<<"test the spark generator"<<endl;
    for (int i = 1; i < 10; i++)
    {
        cout<<sparkgen()<<endl;
    }
    */

    // make a list of where there aren't trees
    std::vector<int> un_treed_locations;
    //build the list
    
    for (int i=1;i<N+1;i++) un_treed_locations.push_back(i);
    
    // cout<<"un treed at 100: "<<un_treed_locations[100]<<endl;
    /*
    int counter = 0;
    int best_yield[D];
    int D_vec[D];
    */
    
    // MAIN JAZZ

    // loop over the size of the forest
    for (int i=1; i<=N; i++)
    {
        //cout<<"Weve filled "<<i-1<<" trees."<<endl;
        outputFile <<i<<",";
        // generate D locations to try
        int test_locs[D] = {0};
        
        // int tmp2; // need for searching
        
        /* to find new locations, I need to check that a random location
         hasn't already been used. towards the end, this gets slow. Need a list, really. */
        
        for (int j=0;j<D;j++)
        {
            /*
            bool new_location=false;
            while (! new_location)
            {
                tmp2=int(double(rand())/double(RAND_MAX)*N);
                if (forest[tmp2] == false)
                {
                    new_location=true;
                }
            }
            test_locs[j]=tmp2;
            */ 
            
            // here's that list
            
            /* test output
            cout<<"-------"<<endl<<un_treed_locations.size()<<endl;
            cout<<int(double(rand())/double(RAND_MAX)*double(un_treed_locations.size()))<<endl;
            cout<<un_treed_locations[int(double(rand())/double(RAND_MAX)*double(un_treed_locations.size()))]<<endl;
            */
            
            test_locs[j]=un_treed_locations[int(double(rand())/double(RAND_MAX)*double(un_treed_locations.size()))];
        } 
        
        // try them to find the best location, plant a tree there
        int totally_the_best_location_ever = optimal_tree_finder(outputFile,test_locs);
        forest[totally_the_best_location_ever] = true;
        // find that location in un_treed_locations
        int tmp_location = 0;
        for (int j=0;j<un_treed_locations.size();j++)
        {
            if (un_treed_locations[j]==totally_the_best_location_ever)
            {
                tmp_location=j;
            }
        }
        // set the last guy where the new tree is, erase the last guy
        un_treed_locations[tmp_location]=un_treed_locations[un_treed_locations.size()-1];
        un_treed_locations.pop_back();
    }
    outputFile.close();
    
    cout<<endl<<"SUCCESS"<<endl;
    return 0;
}

// now sample from that interval
int sparkgen()
{
    double tmp = double(rand())/double(RAND_MAX); // tmp should be uniform in [0,1]
    //cout<<"Uniform random is "<<tmp<<"\n";
    // search for the interval
    int index=0;
    bool interval_flag=false;
    while  (! interval_flag)
    {
        index++;
        if (tmp <= pmf_int[index])
        {
            interval_flag = true;
        }
    }
    // return the index of that interval
    return index;
}

// count the size of the burn, so we'll choose the smallest burn (instead of biggest yield)
int burner(int spark)
{
    spark--; // go back one, since indices start at 0
    
    int burn = 0;
    
    // first we need to have hit a tree
    if (forest[spark])
    {
        // burn that tree
        burn++;
        // burn up
        bool burning = true;
        int tmpup=spark+1;
        while (burning)
        {
            if (forest[tmpup])
            {
                burn++;
                tmpup++;
            }
            else
            {
                burning=false;
            }
        }
        // burn down
        int tmpdown=spark-1;
        burning=true;
        while (burning)
        {
            if (forest[tmpdown])
            {
                burn++;
                tmpdown--;
            }
            else
            {
                burning=false;
            }
        }
    }
    return burn;
}

int optimal_tree_finder( ofstream& outputFile, int test_locs[])
{
    double ave_burn[D] = {0};
    for (int i=0; i<D; i++)
    {
        //cout<<"testing location "<<test_locs[i]<<endl;
        // temporarily put a tree at test location
        forest[test_locs[i]]= true;
        // test n burns, adding the burns
        for (int j=1;j<=n;j++)
        {
            ave_burn[i] = ave_burn[i] + burner(sparkgen());
            
        }
        // remove that tree
        forest[test_locs[i]]= false;
        // weight the average by number of trials
        ave_burn[i]=double(ave_burn[i])/double(n);
        //cout<<"average burn total of "<<ave_burn[i]<<endl;
    }
    // store the location with minimum burn
    int best_location = test_locs[0];
    // find that location
    int tmp = 0;
    for (int i=1;i<D;i++)
        if (ave_burn[i] < ave_burn[tmp])
        {
            tmp = i;
            best_location = test_locs[i];
        }
    //cout<<"best location was "<<best_location<<endl;
    outputFile <<best_location<<","<<ave_burn[tmp]<<endl;
    return best_location;
}
