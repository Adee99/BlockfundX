//web3 logic comes here
import React, { useContext, createContext } from 'react';
import { useAddress, useContract, useMetamask, useContractWrite } from '@thirdweb-dev/react';
import { ethers } from 'ethers';

const StateContext = createContext();
export const StateContextProvider = ({ children }) => {
    const { contract } = useContract('0x22b18C70CF4e25543b14543725B098c6CB3b2ADc');
    const { mutateAsync: createCampaign} = useContractWrite(contract, 'createCampaign');

    const address = useAddress();
    const connect = useMetamask();

    const publishCampaign = async (form) => {
        try{
            const data = await createCampaign([
                address,
                form.title,
                form.description,
                form.target,
                new Date(form.deadline).getTime()/1000, //number of seconds passed since 1970 //how js handles dates
                form.image
            ])
            console.log("Contract Success", data)
        }catch(error){
            console.log("Contract call error occured", data)
        }

    }
    return(
        <StateContext.Provider
        value={{
            address,
            contract,
            connect,
            createCampaign: publishCampaign,
        }}
        >
        {children}
        </StateContext.Provider>
    )
}

export const useStateContext = () => useContext(StateContext);