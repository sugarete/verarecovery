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
static const char *ng0 = "D:/Code/verarecovery/src/pbkdf2_hmac_whirlpool/rtl/key_expansion.v";
static unsigned int ng1[] = {0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U};
static int ng2[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
static unsigned int ng3[] = {0U, 0U};
static int ng4[] = {0, 0};
static unsigned int ng5[] = {0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U};
static unsigned int ng6[] = {1U, 0U};
static int ng7[] = {9, 0};
static int ng8[] = {1, 0};
static unsigned int ng9[] = {2276983119U, 0U, 404997864U, 0U};
static unsigned int ng10[] = {2037354834U, 0U, 916902645U, 0U};
static int ng11[] = {2, 0};
static unsigned int ng12[] = {2735504181U, 0U, 1622973326U, 0U};
static int ng13[] = {3, 0};
static unsigned int ng14[] = {776732247U, 0U, 501274562U, 0U};
static int ng15[] = {4, 0};
static unsigned int ng16[] = {2683325146U, 0U, 360134629U, 0U};
static int ng17[] = {5, 0};
static unsigned int ng18[] = {2980080517U, 0U, 1489578250U, 0U};
static int ng19[] = {6, 0};
static unsigned int ng20[] = {3409839463U, 0U, 3176993012U, 0U};
static int ng21[] = {7, 0};
static unsigned int ng22[] = {2810025432U, 0U, 3827777931U, 0U};
static int ng23[] = {8, 0};
static unsigned int ng24[] = {3709290398U, 0U, 4226710630U, 0U};
static unsigned int ng25[] = {2908390195U, 0U, 3391995655U, 0U};



static void Cont_47_0(char *t0)
{
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

LAB0:    t1 = (t0 + 4856U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(47, ng0);
    t2 = (t0 + 2976);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 6048);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    xsi_vlog_bit_copy(t9, 0, t4, 0, 512);
    xsi_driver_vfirst_trans(t5, 0, 511);
    t10 = (t0 + 5920);
    *((int *)t10) = 1;

LAB1:    return;
}

static void Cont_48_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 5104U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(48, ng0);
    t2 = (t0 + 3456);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 6112);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 1U;
    t11 = t10;
    t12 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t5, 0, 0);
    t18 = (t0 + 5936);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Always_55_2(char *t0)
{
    char t4[8];
    char t24[128];
    char t25[128];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    char *t20;
    int t21;
    char *t22;
    char *t23;
    char *t26;
    char *t27;
    char *t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;

LAB0:    t1 = (t0 + 5352U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(55, ng0);
    t2 = (t0 + 5952);
    *((int *)t2) = 1;
    t3 = (t0 + 5384);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(55, ng0);

LAB5:    xsi_set_current_line(56, ng0);
    t5 = (t0 + 1616U);
    t6 = *((char **)t5);
    memset(t4, 0, 8);
    t5 = (t6 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (~(t7));
    t9 = *((unsigned int *)t6);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB9;

LAB7:    if (*((unsigned int *)t5) == 0)
        goto LAB6;

LAB8:    t12 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t12) = 1;

LAB9:    t13 = (t4 + 4);
    t14 = *((unsigned int *)t13);
    t15 = (~(t14));
    t16 = *((unsigned int *)t4);
    t17 = (t16 & t15);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(63, ng0);

LAB14:    xsi_set_current_line(64, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3456);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(65, ng0);
    t2 = (t0 + 3936);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);

LAB15:    t6 = (t0 + 472);
    t12 = *((char **)t6);
    t21 = xsi_vlog_unsigned_case_compare(t5, 8, t12, 32);
    if (t21 == 1)
        goto LAB16;

LAB17:    t2 = (t0 + 608);
    t3 = *((char **)t2);
    t21 = xsi_vlog_unsigned_case_compare(t5, 8, t3, 32);
    if (t21 == 1)
        goto LAB18;

LAB19:    t2 = (t0 + 744);
    t3 = *((char **)t2);
    t21 = xsi_vlog_unsigned_case_compare(t5, 8, t3, 32);
    if (t21 == 1)
        goto LAB20;

LAB21:
LAB22:
LAB12:    goto LAB2;

LAB6:    *((unsigned int *)t4) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(56, ng0);

LAB13:    xsi_set_current_line(57, ng0);
    t19 = ((char*)((ng1)));
    t20 = (t0 + 2816);
    xsi_vlogvar_wait_assign_value(t20, t19, 0, 0, 512, 0LL);
    xsi_set_current_line(58, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3616);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 512, 0LL);
    xsi_set_current_line(59, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2976);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 512, 0LL);
    xsi_set_current_line(60, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3456);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(61, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 3776);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);
    xsi_set_current_line(62, ng0);
    t2 = (t0 + 472);
    t3 = *((char **)t2);
    t2 = (t0 + 3936);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 8, 0LL);
    goto LAB12;

LAB16:    xsi_set_current_line(66, ng0);

LAB23:    xsi_set_current_line(67, ng0);
    t6 = ((char*)((ng1)));
    t13 = (t0 + 2816);
    xsi_vlogvar_wait_assign_value(t13, t6, 0, 0, 512, 0LL);
    xsi_set_current_line(68, ng0);
    t2 = (t0 + 1936U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t7 = *((unsigned int *)t2);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB24;

LAB25:
LAB26:    goto LAB22;

LAB18:    xsi_set_current_line(70, ng0);

LAB27:    xsi_set_current_line(71, ng0);
    t2 = (t0 + 3776);
    t6 = (t2 + 56U);
    t12 = *((char **)t6);
    memset(t4, 0, 8);
    t13 = (t12 + 4);
    t7 = *((unsigned int *)t13);
    t8 = (~(t7));
    t9 = *((unsigned int *)t12);
    t10 = (t9 & t8);
    t11 = (t10 & 15U);
    if (t11 != 0)
        goto LAB31;

LAB29:    if (*((unsigned int *)t13) == 0)
        goto LAB28;

LAB30:    t19 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t19) = 1;

LAB31:    t20 = (t4 + 4);
    t14 = *((unsigned int *)t20);
    t15 = (~(t14));
    t16 = *((unsigned int *)t4);
    t17 = (t16 & t15);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB32;

LAB33:    xsi_set_current_line(72, ng0);
    t2 = (t0 + 2976);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = (t0 + 2816);
    xsi_vlogvar_wait_assign_value(t12, t6, 0, 0, 512, 0LL);

LAB34:    xsi_set_current_line(73, ng0);
    t2 = (t0 + 744);
    t3 = *((char **)t2);
    t2 = (t0 + 3936);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 8, 0LL);
    goto LAB22;

LAB20:    xsi_set_current_line(75, ng0);

LAB35:    xsi_set_current_line(76, ng0);
    t2 = (t0 + 2416U);
    t6 = *((char **)t2);
    t2 = ((char*)((ng5)));
    t12 = (t0 + 3296);
    t13 = (t12 + 56U);
    t19 = *((char **)t13);
    xsi_vlogtype_concat(t24, 512, 512, 2U, t19, 64, t2, 448);
    t7 = 0;

LAB39:    t8 = (t7 < 16);
    if (t8 == 1)
        goto LAB40;

LAB41:    t36 = (t0 + 2976);
    xsi_vlogvar_wait_assign_value(t36, t25, 0, 0, 512, 0LL);
    xsi_set_current_line(77, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 3456);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(78, ng0);
    t2 = (t0 + 3776);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = ((char*)((ng7)));
    memset(t4, 0, 8);
    t13 = (t6 + 4);
    t19 = (t12 + 4);
    t7 = *((unsigned int *)t6);
    t8 = *((unsigned int *)t12);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t13);
    t11 = *((unsigned int *)t19);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t13);
    t17 = *((unsigned int *)t19);
    t18 = (t16 | t17);
    t29 = (~(t18));
    t30 = (t15 & t29);
    if (t30 != 0)
        goto LAB45;

LAB42:    if (t18 != 0)
        goto LAB44;

LAB43:    *((unsigned int *)t4) = 1;

LAB45:    t22 = (t4 + 4);
    t31 = *((unsigned int *)t22);
    t32 = (~(t31));
    t33 = *((unsigned int *)t4);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB46;

LAB47:    xsi_set_current_line(81, ng0);

LAB50:    xsi_set_current_line(82, ng0);
    t2 = (t0 + 3776);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = ((char*)((ng8)));
    memset(t4, 0, 8);
    xsi_vlog_unsigned_add(t4, 32, t6, 4, t12, 32);
    t13 = (t0 + 3776);
    xsi_vlogvar_wait_assign_value(t13, t4, 0, 0, 4, 0LL);
    xsi_set_current_line(83, ng0);
    t2 = (t0 + 608);
    t3 = *((char **)t2);
    t2 = (t0 + 3936);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 8, 0LL);

LAB48:    goto LAB22;

LAB24:    xsi_set_current_line(68, ng0);
    t6 = (t0 + 608);
    t12 = *((char **)t6);
    t6 = (t0 + 3936);
    xsi_vlogvar_wait_assign_value(t6, t12, 0, 0, 8, 0LL);
    goto LAB26;

LAB28:    *((unsigned int *)t4) = 1;
    goto LAB31;

LAB32:    xsi_set_current_line(71, ng0);
    t22 = (t0 + 1776U);
    t23 = *((char **)t22);
    t22 = (t0 + 2816);
    xsi_vlogvar_wait_assign_value(t22, t23, 0, 0, 512, 0LL);
    goto LAB34;

LAB36:    t34 = *((unsigned int *)t23);
    t35 = *((unsigned int *)t28);
    *((unsigned int *)t23) = (t34 | t35);

LAB38:    t7 = (t7 + 1);
    goto LAB39;

LAB37:    goto LAB38;

LAB40:    t9 = (t7 * 8);
    t20 = (t6 + t9);
    t22 = (t24 + t9);
    t23 = (t25 + t9);
    t10 = *((unsigned int *)t20);
    t11 = *((unsigned int *)t22);
    t14 = (t10 ^ t11);
    *((unsigned int *)t23) = t14;
    t15 = (t7 * 8);
    t16 = (t15 + 4);
    t26 = (t6 + t16);
    t17 = (t15 + 4);
    t27 = (t24 + t17);
    t18 = (t15 + 4);
    t28 = (t25 + t18);
    t29 = *((unsigned int *)t26);
    t30 = *((unsigned int *)t27);
    t31 = (t29 | t30);
    *((unsigned int *)t28) = t31;
    t32 = *((unsigned int *)t28);
    t33 = (t32 != 0);
    if (t33 == 1)
        goto LAB36;
    else
        goto LAB37;

LAB44:    t20 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB45;

LAB46:    xsi_set_current_line(78, ng0);

LAB49:    xsi_set_current_line(79, ng0);
    t23 = ((char*)((ng4)));
    t26 = (t0 + 3776);
    xsi_vlogvar_wait_assign_value(t26, t23, 0, 0, 4, 0LL);
    xsi_set_current_line(80, ng0);
    t2 = (t0 + 472);
    t3 = *((char **)t2);
    t2 = (t0 + 3936);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 8, 0LL);
    goto LAB48;

}

static void Always_90_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    int t8;
    char *t9;
    char *t10;

LAB0:    t1 = (t0 + 5600U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(90, ng0);
    t2 = (t0 + 5968);
    *((int *)t2) = 1;
    t3 = (t0 + 5632);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(90, ng0);

LAB5:    xsi_set_current_line(91, ng0);
    t4 = (t0 + 3776);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);

LAB6:    t7 = ((char*)((ng4)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 4, t7, 32);
    if (t8 == 1)
        goto LAB7;

LAB8:    t2 = ((char*)((ng8)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 4, t2, 32);
    if (t8 == 1)
        goto LAB9;

LAB10:    t2 = ((char*)((ng11)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 4, t2, 32);
    if (t8 == 1)
        goto LAB11;

LAB12:    t2 = ((char*)((ng13)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 4, t2, 32);
    if (t8 == 1)
        goto LAB13;

LAB14:    t2 = ((char*)((ng15)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 4, t2, 32);
    if (t8 == 1)
        goto LAB15;

LAB16:    t2 = ((char*)((ng17)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 4, t2, 32);
    if (t8 == 1)
        goto LAB17;

LAB18:    t2 = ((char*)((ng19)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 4, t2, 32);
    if (t8 == 1)
        goto LAB19;

LAB20:    t2 = ((char*)((ng21)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 4, t2, 32);
    if (t8 == 1)
        goto LAB21;

LAB22:    t2 = ((char*)((ng23)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 4, t2, 32);
    if (t8 == 1)
        goto LAB23;

LAB24:    t2 = ((char*)((ng7)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 4, t2, 32);
    if (t8 == 1)
        goto LAB25;

LAB26:
LAB27:    goto LAB2;

LAB7:    xsi_set_current_line(92, ng0);
    t9 = ((char*)((ng9)));
    t10 = (t0 + 3296);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 64);
    goto LAB27;

LAB9:    xsi_set_current_line(93, ng0);
    t3 = ((char*)((ng10)));
    t4 = (t0 + 3296);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 64);
    goto LAB27;

LAB11:    xsi_set_current_line(94, ng0);
    t3 = ((char*)((ng12)));
    t4 = (t0 + 3296);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 64);
    goto LAB27;

LAB13:    xsi_set_current_line(95, ng0);
    t3 = ((char*)((ng14)));
    t4 = (t0 + 3296);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 64);
    goto LAB27;

LAB15:    xsi_set_current_line(96, ng0);
    t3 = ((char*)((ng16)));
    t4 = (t0 + 3296);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 64);
    goto LAB27;

LAB17:    xsi_set_current_line(97, ng0);
    t3 = ((char*)((ng18)));
    t4 = (t0 + 3296);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 64);
    goto LAB27;

LAB19:    xsi_set_current_line(98, ng0);
    t3 = ((char*)((ng20)));
    t4 = (t0 + 3296);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 64);
    goto LAB27;

LAB21:    xsi_set_current_line(99, ng0);
    t3 = ((char*)((ng22)));
    t4 = (t0 + 3296);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 64);
    goto LAB27;

LAB23:    xsi_set_current_line(100, ng0);
    t3 = ((char*)((ng24)));
    t4 = (t0 + 3296);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 64);
    goto LAB27;

LAB25:    xsi_set_current_line(101, ng0);
    t3 = ((char*)((ng25)));
    t4 = (t0 + 3296);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 64);
    goto LAB27;

}


extern void work_m_00000000002995583802_3321356532_init()
{
	static char *pe[] = {(void *)Cont_47_0,(void *)Cont_48_1,(void *)Always_55_2,(void *)Always_90_3};
	xsi_register_didat("work_m_00000000002995583802_3321356532", "isim/top_whirlpool_hash_tb_isim_beh.exe.sim/work/m_00000000002995583802_3321356532.didat");
	xsi_register_executes(pe);
}
