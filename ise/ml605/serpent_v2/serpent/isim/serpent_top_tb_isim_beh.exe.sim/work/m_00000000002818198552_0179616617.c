/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/Code/verarecovery/src/serpent-bitslices/rtl/linear_transform_inverse.v";
static int ng1[] = {7, 0};
static int ng2[] = {3, 0};



static int sp_linear_transform_inverse(char *t1, char *t2)
{
    char t7[8];
    char t8[8];
    char t16[8];
    char t43[32];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    unsigned int t30;
    char *t31;
    char *t32;
    char *t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    char *t41;
    char *t42;

LAB0:    t0 = 1;
    xsi_set_current_line(29, ng0);

LAB2:    xsi_set_current_line(30, ng0);
    t3 = (t1 + 3320);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 3960);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 32);
    xsi_set_current_line(31, ng0);
    t3 = (t1 + 3480);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 4120);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 32);
    xsi_set_current_line(32, ng0);
    t3 = (t1 + 3640);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 4280);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 32);
    xsi_set_current_line(33, ng0);
    t3 = (t1 + 3800);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 4440);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 32);
    xsi_set_current_line(35, ng0);
    t3 = (t1 + 3960);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    memset(t8, 0, 8);
    t6 = (t8 + 4);
    t9 = (t5 + 4);
    t10 = *((unsigned int *)t5);
    t11 = (t10 >> 5);
    *((unsigned int *)t8) = t11;
    t12 = *((unsigned int *)t9);
    t13 = (t12 >> 5);
    *((unsigned int *)t6) = t13;
    t14 = *((unsigned int *)t8);
    *((unsigned int *)t8) = (t14 & 134217727U);
    t15 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t15 & 134217727U);
    t17 = (t1 + 3960);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memset(t16, 0, 8);
    t20 = (t16 + 4);
    t21 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 0);
    *((unsigned int *)t16) = t23;
    t24 = *((unsigned int *)t21);
    t25 = (t24 >> 0);
    *((unsigned int *)t20) = t25;
    t26 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t26 & 31U);
    t27 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t27 & 31U);
    xsi_vlogtype_concat(t7, 32, 32, 2U, t16, 5, t8, 27);
    t28 = (t1 + 3960);
    xsi_vlogvar_assign_value(t28, t7, 0, 0, 32);
    xsi_set_current_line(36, ng0);
    t3 = (t1 + 4280);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    memset(t8, 0, 8);
    t6 = (t8 + 4);
    t9 = (t5 + 4);
    t10 = *((unsigned int *)t5);
    t11 = (t10 >> 22);
    *((unsigned int *)t8) = t11;
    t12 = *((unsigned int *)t9);
    t13 = (t12 >> 22);
    *((unsigned int *)t6) = t13;
    t14 = *((unsigned int *)t8);
    *((unsigned int *)t8) = (t14 & 1023U);
    t15 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t15 & 1023U);
    t17 = (t1 + 4280);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memset(t16, 0, 8);
    t20 = (t16 + 4);
    t21 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 0);
    *((unsigned int *)t16) = t23;
    t24 = *((unsigned int *)t21);
    t25 = (t24 >> 0);
    *((unsigned int *)t20) = t25;
    t26 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t26 & 4194303U);
    t27 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t27 & 4194303U);
    xsi_vlogtype_concat(t7, 32, 32, 2U, t16, 22, t8, 10);
    t28 = (t1 + 4280);
    xsi_vlogvar_assign_value(t28, t7, 0, 0, 32);
    xsi_set_current_line(37, ng0);
    t3 = (t1 + 3960);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 4120);
    t9 = (t6 + 56U);
    t17 = *((char **)t9);
    t10 = *((unsigned int *)t5);
    t11 = *((unsigned int *)t17);
    t12 = (t10 ^ t11);
    *((unsigned int *)t7) = t12;
    t18 = (t5 + 4);
    t19 = (t17 + 4);
    t20 = (t7 + 4);
    t13 = *((unsigned int *)t18);
    t14 = *((unsigned int *)t19);
    t15 = (t13 | t14);
    *((unsigned int *)t20) = t15;
    t22 = *((unsigned int *)t20);
    t23 = (t22 != 0);
    if (t23 == 1)
        goto LAB3;

LAB4:
LAB5:    t21 = (t1 + 4440);
    t28 = (t21 + 56U);
    t29 = *((char **)t28);
    t26 = *((unsigned int *)t7);
    t27 = *((unsigned int *)t29);
    t30 = (t26 ^ t27);
    *((unsigned int *)t8) = t30;
    t31 = (t7 + 4);
    t32 = (t29 + 4);
    t33 = (t8 + 4);
    t34 = *((unsigned int *)t31);
    t35 = *((unsigned int *)t32);
    t36 = (t34 | t35);
    *((unsigned int *)t33) = t36;
    t37 = *((unsigned int *)t33);
    t38 = (t37 != 0);
    if (t38 == 1)
        goto LAB6;

LAB7:
LAB8:    t41 = (t1 + 3960);
    xsi_vlogvar_assign_value(t41, t8, 0, 0, 32);
    xsi_set_current_line(38, ng0);
    t3 = (t1 + 4280);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 4440);
    t9 = (t6 + 56U);
    t17 = *((char **)t9);
    t10 = *((unsigned int *)t5);
    t11 = *((unsigned int *)t17);
    t12 = (t10 ^ t11);
    *((unsigned int *)t7) = t12;
    t18 = (t5 + 4);
    t19 = (t17 + 4);
    t20 = (t7 + 4);
    t13 = *((unsigned int *)t18);
    t14 = *((unsigned int *)t19);
    t15 = (t13 | t14);
    *((unsigned int *)t20) = t15;
    t22 = *((unsigned int *)t20);
    t23 = (t22 != 0);
    if (t23 == 1)
        goto LAB9;

LAB10:
LAB11:    t21 = (t1 + 4120);
    t28 = (t21 + 56U);
    t29 = *((char **)t28);
    t31 = ((char*)((ng1)));
    memset(t8, 0, 8);
    xsi_vlog_unsigned_lshift(t8, 32, t29, 32, t31, 32);
    t26 = *((unsigned int *)t7);
    t27 = *((unsigned int *)t8);
    t30 = (t26 ^ t27);
    *((unsigned int *)t16) = t30;
    t32 = (t7 + 4);
    t33 = (t8 + 4);
    t41 = (t16 + 4);
    t34 = *((unsigned int *)t32);
    t35 = *((unsigned int *)t33);
    t36 = (t34 | t35);
    *((unsigned int *)t41) = t36;
    t37 = *((unsigned int *)t41);
    t38 = (t37 != 0);
    if (t38 == 1)
        goto LAB12;

LAB13:
LAB14:    t42 = (t1 + 4280);
    xsi_vlogvar_assign_value(t42, t16, 0, 0, 32);
    xsi_set_current_line(39, ng0);
    t3 = (t1 + 4120);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    memset(t8, 0, 8);
    t6 = (t8 + 4);
    t9 = (t5 + 4);
    t10 = *((unsigned int *)t5);
    t11 = (t10 >> 1);
    *((unsigned int *)t8) = t11;
    t12 = *((unsigned int *)t9);
    t13 = (t12 >> 1);
    *((unsigned int *)t6) = t13;
    t14 = *((unsigned int *)t8);
    *((unsigned int *)t8) = (t14 & 2147483647U);
    t15 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t15 & 2147483647U);
    t17 = (t1 + 4120);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memset(t16, 0, 8);
    t20 = (t16 + 4);
    t21 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 0);
    t24 = (t23 & 1);
    *((unsigned int *)t16) = t24;
    t25 = *((unsigned int *)t21);
    t26 = (t25 >> 0);
    t27 = (t26 & 1);
    *((unsigned int *)t20) = t27;
    xsi_vlogtype_concat(t7, 32, 32, 2U, t16, 1, t8, 31);
    t28 = (t1 + 4120);
    xsi_vlogvar_assign_value(t28, t7, 0, 0, 32);
    xsi_set_current_line(40, ng0);
    t3 = (t1 + 4440);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    memset(t8, 0, 8);
    t6 = (t8 + 4);
    t9 = (t5 + 4);
    t10 = *((unsigned int *)t5);
    t11 = (t10 >> 7);
    *((unsigned int *)t8) = t11;
    t12 = *((unsigned int *)t9);
    t13 = (t12 >> 7);
    *((unsigned int *)t6) = t13;
    t14 = *((unsigned int *)t8);
    *((unsigned int *)t8) = (t14 & 33554431U);
    t15 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t15 & 33554431U);
    t17 = (t1 + 4440);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memset(t16, 0, 8);
    t20 = (t16 + 4);
    t21 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 0);
    *((unsigned int *)t16) = t23;
    t24 = *((unsigned int *)t21);
    t25 = (t24 >> 0);
    *((unsigned int *)t20) = t25;
    t26 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t26 & 127U);
    t27 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t27 & 127U);
    xsi_vlogtype_concat(t7, 32, 32, 2U, t16, 7, t8, 25);
    t28 = (t1 + 4440);
    xsi_vlogvar_assign_value(t28, t7, 0, 0, 32);
    xsi_set_current_line(41, ng0);
    t3 = (t1 + 4440);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 4280);
    t9 = (t6 + 56U);
    t17 = *((char **)t9);
    t10 = *((unsigned int *)t5);
    t11 = *((unsigned int *)t17);
    t12 = (t10 ^ t11);
    *((unsigned int *)t7) = t12;
    t18 = (t5 + 4);
    t19 = (t17 + 4);
    t20 = (t7 + 4);
    t13 = *((unsigned int *)t18);
    t14 = *((unsigned int *)t19);
    t15 = (t13 | t14);
    *((unsigned int *)t20) = t15;
    t22 = *((unsigned int *)t20);
    t23 = (t22 != 0);
    if (t23 == 1)
        goto LAB15;

LAB16:
LAB17:    t21 = (t1 + 3960);
    t28 = (t21 + 56U);
    t29 = *((char **)t28);
    t31 = ((char*)((ng2)));
    memset(t8, 0, 8);
    xsi_vlog_unsigned_lshift(t8, 32, t29, 32, t31, 32);
    t26 = *((unsigned int *)t7);
    t27 = *((unsigned int *)t8);
    t30 = (t26 ^ t27);
    *((unsigned int *)t16) = t30;
    t32 = (t7 + 4);
    t33 = (t8 + 4);
    t41 = (t16 + 4);
    t34 = *((unsigned int *)t32);
    t35 = *((unsigned int *)t33);
    t36 = (t34 | t35);
    *((unsigned int *)t41) = t36;
    t37 = *((unsigned int *)t41);
    t38 = (t37 != 0);
    if (t38 == 1)
        goto LAB18;

LAB19:
LAB20:    t42 = (t1 + 4440);
    xsi_vlogvar_assign_value(t42, t16, 0, 0, 32);
    xsi_set_current_line(42, ng0);
    t3 = (t1 + 4120);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 3960);
    t9 = (t6 + 56U);
    t17 = *((char **)t9);
    t10 = *((unsigned int *)t5);
    t11 = *((unsigned int *)t17);
    t12 = (t10 ^ t11);
    *((unsigned int *)t7) = t12;
    t18 = (t5 + 4);
    t19 = (t17 + 4);
    t20 = (t7 + 4);
    t13 = *((unsigned int *)t18);
    t14 = *((unsigned int *)t19);
    t15 = (t13 | t14);
    *((unsigned int *)t20) = t15;
    t22 = *((unsigned int *)t20);
    t23 = (t22 != 0);
    if (t23 == 1)
        goto LAB21;

LAB22:
LAB23:    t21 = (t1 + 4280);
    t28 = (t21 + 56U);
    t29 = *((char **)t28);
    t26 = *((unsigned int *)t7);
    t27 = *((unsigned int *)t29);
    t30 = (t26 ^ t27);
    *((unsigned int *)t8) = t30;
    t31 = (t7 + 4);
    t32 = (t29 + 4);
    t33 = (t8 + 4);
    t34 = *((unsigned int *)t31);
    t35 = *((unsigned int *)t32);
    t36 = (t34 | t35);
    *((unsigned int *)t33) = t36;
    t37 = *((unsigned int *)t33);
    t38 = (t37 != 0);
    if (t38 == 1)
        goto LAB24;

LAB25:
LAB26:    t41 = (t1 + 4120);
    xsi_vlogvar_assign_value(t41, t8, 0, 0, 32);
    xsi_set_current_line(43, ng0);
    t3 = (t1 + 4280);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    memset(t8, 0, 8);
    t6 = (t8 + 4);
    t9 = (t5 + 4);
    t10 = *((unsigned int *)t5);
    t11 = (t10 >> 3);
    *((unsigned int *)t8) = t11;
    t12 = *((unsigned int *)t9);
    t13 = (t12 >> 3);
    *((unsigned int *)t6) = t13;
    t14 = *((unsigned int *)t8);
    *((unsigned int *)t8) = (t14 & 536870911U);
    t15 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t15 & 536870911U);
    t17 = (t1 + 4280);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memset(t16, 0, 8);
    t20 = (t16 + 4);
    t21 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 0);
    *((unsigned int *)t16) = t23;
    t24 = *((unsigned int *)t21);
    t25 = (t24 >> 0);
    *((unsigned int *)t20) = t25;
    t26 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t26 & 7U);
    t27 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t27 & 7U);
    xsi_vlogtype_concat(t7, 32, 32, 2U, t16, 3, t8, 29);
    t28 = (t1 + 4280);
    xsi_vlogvar_assign_value(t28, t7, 0, 0, 32);
    xsi_set_current_line(44, ng0);
    t3 = (t1 + 3960);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    memset(t8, 0, 8);
    t6 = (t8 + 4);
    t9 = (t5 + 4);
    t10 = *((unsigned int *)t5);
    t11 = (t10 >> 13);
    *((unsigned int *)t8) = t11;
    t12 = *((unsigned int *)t9);
    t13 = (t12 >> 13);
    *((unsigned int *)t6) = t13;
    t14 = *((unsigned int *)t8);
    *((unsigned int *)t8) = (t14 & 524287U);
    t15 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t15 & 524287U);
    t17 = (t1 + 3960);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memset(t16, 0, 8);
    t20 = (t16 + 4);
    t21 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 0);
    *((unsigned int *)t16) = t23;
    t24 = *((unsigned int *)t21);
    t25 = (t24 >> 0);
    *((unsigned int *)t20) = t25;
    t26 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t26 & 8191U);
    t27 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t27 & 8191U);
    xsi_vlogtype_concat(t7, 32, 32, 2U, t16, 13, t8, 19);
    t28 = (t1 + 3960);
    xsi_vlogvar_assign_value(t28, t7, 0, 0, 32);
    xsi_set_current_line(46, ng0);
    t3 = (t1 + 4440);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 4280);
    t9 = (t6 + 56U);
    t17 = *((char **)t9);
    t18 = (t1 + 4120);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    t21 = (t1 + 3960);
    t28 = (t21 + 56U);
    t29 = *((char **)t28);
    xsi_vlogtype_concat(t43, 128, 128, 4U, t29, 32, t20, 32, t17, 32, t5, 32);
    t31 = (t1 + 3160);
    xsi_vlogvar_assign_value(t31, t43, 0, 0, 128);
    t0 = 0;

LAB1:    return t0;
LAB3:    t24 = *((unsigned int *)t7);
    t25 = *((unsigned int *)t20);
    *((unsigned int *)t7) = (t24 | t25);
    goto LAB5;

LAB6:    t39 = *((unsigned int *)t8);
    t40 = *((unsigned int *)t33);
    *((unsigned int *)t8) = (t39 | t40);
    goto LAB8;

LAB9:    t24 = *((unsigned int *)t7);
    t25 = *((unsigned int *)t20);
    *((unsigned int *)t7) = (t24 | t25);
    goto LAB11;

LAB12:    t39 = *((unsigned int *)t16);
    t40 = *((unsigned int *)t41);
    *((unsigned int *)t16) = (t39 | t40);
    goto LAB14;

LAB15:    t24 = *((unsigned int *)t7);
    t25 = *((unsigned int *)t20);
    *((unsigned int *)t7) = (t24 | t25);
    goto LAB17;

LAB18:    t39 = *((unsigned int *)t16);
    t40 = *((unsigned int *)t41);
    *((unsigned int *)t16) = (t39 | t40);
    goto LAB20;

LAB21:    t24 = *((unsigned int *)t7);
    t25 = *((unsigned int *)t20);
    *((unsigned int *)t7) = (t24 | t25);
    goto LAB23;

LAB24:    t39 = *((unsigned int *)t8);
    t40 = *((unsigned int *)t33);
    *((unsigned int *)t8) = (t39 | t40);
    goto LAB26;

}

static void Cont_16_0(char *t0)
{
    char t25[32];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    int t21;
    char *t22;
    char *t23;
    char *t24;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;

LAB0:    t1 = (t0 + 5360U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(16, ng0);
    t2 = (t0 + 1480U);
    t3 = *((char **)t2);
    t2 = (t0 + 1640U);
    t4 = *((char **)t2);
    t2 = (t0 + 1800U);
    t5 = *((char **)t2);
    t2 = (t0 + 1960U);
    t6 = *((char **)t2);
    t2 = (t0 + 5168);
    t7 = (t0 + 848);
    t8 = xsi_create_subprogram_invocation(t2, 0, t0, t7, 0, 0);
    t9 = (t0 + 3320);
    xsi_vlogvar_assign_value(t9, t3, 0, 0, 32);
    t10 = (t0 + 3480);
    xsi_vlogvar_assign_value(t10, t4, 0, 0, 32);
    t11 = (t0 + 3640);
    xsi_vlogvar_assign_value(t11, t5, 0, 0, 32);
    t12 = (t0 + 3800);
    xsi_vlogvar_assign_value(t12, t6, 0, 0, 32);

LAB4:    t13 = (t0 + 5264);
    t14 = *((char **)t13);
    t15 = (t14 + 80U);
    t16 = *((char **)t15);
    t17 = (t16 + 272U);
    t18 = *((char **)t17);
    t19 = (t18 + 0U);
    t20 = *((char **)t19);
    t21 = ((int  (*)(char *, char *))t20)(t0, t14);
    if (t21 != 0)
        goto LAB6;

LAB5:    t14 = (t0 + 5264);
    t22 = *((char **)t14);
    t14 = (t0 + 3160);
    t23 = (t14 + 56U);
    t24 = *((char **)t23);
    memcpy(t25, t24, 32);
    t26 = (t0 + 848);
    t27 = (t0 + 5168);
    t28 = 0;
    xsi_delete_subprogram_invocation(t26, t22, t0, t27, t28);
    t29 = (t0 + 6816);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    t32 = (t31 + 56U);
    t33 = *((char **)t32);
    xsi_vlog_bit_copy(t33, 0, t25, 0, 128);
    xsi_driver_vfirst_trans(t29, 0, 127);
    t34 = (t0 + 6672);
    *((int *)t34) = 1;

LAB1:    return;
LAB6:    t13 = (t0 + 5360U);
    *((char **)t13) = &&LAB4;
    goto LAB1;

}

static void Cont_18_1(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    t1 = (t0 + 5608U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(18, ng0);
    t2 = (t0 + 2760U);
    t4 = *((char **)t2);
    memset(t3, 0, 8);
    t2 = (t3 + 4);
    t5 = (t4 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (t6 >> 0);
    *((unsigned int *)t3) = t7;
    t8 = *((unsigned int *)t5);
    t9 = (t8 >> 0);
    *((unsigned int *)t2) = t9;
    t10 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t10 & 4294967295U);
    t11 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t11 & 4294967295U);
    t12 = (t0 + 6880);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t3, 8);
    xsi_driver_vfirst_trans(t12, 0, 31);
    t17 = (t0 + 6688);
    *((int *)t17) = 1;

LAB1:    return;
}

static void Cont_19_2(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    t1 = (t0 + 5856U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(19, ng0);
    t2 = (t0 + 2760U);
    t4 = *((char **)t2);
    memset(t3, 0, 8);
    t2 = (t3 + 4);
    t5 = (t4 + 8);
    t6 = (t4 + 12);
    t7 = *((unsigned int *)t5);
    t8 = (t7 >> 0);
    *((unsigned int *)t3) = t8;
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t2) = t10;
    t11 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t11 & 4294967295U);
    t12 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t12 & 4294967295U);
    t13 = (t0 + 6944);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t3, 8);
    xsi_driver_vfirst_trans(t13, 0, 31);
    t18 = (t0 + 6704);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Cont_20_3(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    t1 = (t0 + 6104U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(20, ng0);
    t2 = (t0 + 2760U);
    t4 = *((char **)t2);
    memset(t3, 0, 8);
    t2 = (t3 + 4);
    t5 = (t4 + 16);
    t6 = (t4 + 20);
    t7 = *((unsigned int *)t5);
    t8 = (t7 >> 0);
    *((unsigned int *)t3) = t8;
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t2) = t10;
    t11 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t11 & 4294967295U);
    t12 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t12 & 4294967295U);
    t13 = (t0 + 7008);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t3, 8);
    xsi_driver_vfirst_trans(t13, 0, 31);
    t18 = (t0 + 6720);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Cont_21_4(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    t1 = (t0 + 6352U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(21, ng0);
    t2 = (t0 + 2760U);
    t4 = *((char **)t2);
    memset(t3, 0, 8);
    t2 = (t3 + 4);
    t5 = (t4 + 24);
    t6 = (t4 + 28);
    t7 = *((unsigned int *)t5);
    t8 = (t7 >> 0);
    *((unsigned int *)t3) = t8;
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t2) = t10;
    t11 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t11 & 4294967295U);
    t12 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t12 & 4294967295U);
    t13 = (t0 + 7072);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t3, 8);
    xsi_driver_vfirst_trans(t13, 0, 31);
    t18 = (t0 + 6736);
    *((int *)t18) = 1;

LAB1:    return;
}


extern void work_m_00000000002818198552_0179616617_init()
{
	static char *pe[] = {(void *)Cont_16_0,(void *)Cont_18_1,(void *)Cont_19_2,(void *)Cont_20_3,(void *)Cont_21_4};
	static char *se[] = {(void *)sp_linear_transform_inverse};
	xsi_register_didat("work_m_00000000002818198552_0179616617", "isim/serpent_top_tb_isim_beh.exe.sim/work/m_00000000002818198552_0179616617.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
