console.log("Welcome");

//export literals
//module.exports.msg='hello';

//export obj
/*
module.exports=
{
    name:"laptop",
    company: "hp",
    price: 4000
}*/

//export function
const greet=()=>
{
    console.log('how are you');
}
const add=(a,b)=>
{
    console.log(a+b);
}
module.exports={greet,
    add
};