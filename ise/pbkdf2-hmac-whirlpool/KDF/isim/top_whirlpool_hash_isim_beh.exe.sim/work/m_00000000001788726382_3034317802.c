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
static const char *ng0 = "D:/Code/verarecovery/src/pbkdf2_hmac_whirlpool/rtl/Whirlpool_hash.v";
static unsigned int ng1[] = {0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U};
static unsigned int ng2[] = {0U, 0U};
static int ng3[] = {9, 0};
static int ng4[] = {1, 0};
static unsigned int ng5[] = {1U, 0U};



static void Cont_31_0(char *t0)
{
    char t8[128];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    char *t20;
    unsigned int t21;
    char *t22;
    unsigned int t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;

LAB0:    t1 = (t0 + 4880U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(31, ng0);
    t2 = (t0 + 3480);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 3640);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t9 = 0;

LAB7:    t10 = (t9 < 16);
    if (t10 == 1)
        goto LAB8;

LAB9:    t32 = (t0 + 5808);
    t33 = (t32 + 56U);
    t34 = *((char **)t33);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    xsi_vlog_bit_copy(t36, 0, t8, 0, 512);
    xsi_driver_vfirst_trans(t32, 0, 511);
    t37 = (t0 + 5696);
    *((int *)t37) = 1;

LAB1:    return;
LAB4:    t30 = *((unsigned int *)t14);
    t31 = *((unsigned int *)t24);
    *((unsigned int *)t14) = (t30 | t31);

LAB6:    t9 = (t9 + 1);
    goto LAB7;

LAB5:    goto LAB6;

LAB8:    t11 = (t9 * 8);
    t12 = (t4 + t11);
    t13 = (t7 + t11);
    t14 = (t8 + t11);
    t15 = *((unsigned int *)t12);
    t16 = *((unsigned int *)t13);
    t17 = (t15 ^ t16);
    *((unsigned int *)t14) = t17;
    t18 = (t9 * 8);
    t19 = (t18 + 4);
    t20 = (t4 + t19);
    t21 = (t18 + 4);
    t22 = (t7 + t21);
    t23 = (t18 + 4);
    t24 = (t8 + t23);
    t25 = *((unsigned int *)t20);
    t26 = *((unsigned int *)t22);
    t27 = (t25 | t26);
    *((unsigned int *)t24) = t27;
    t28 = *((unsigned int *)t24);
    t29 = (t28 != 0);
    if (t29 == 1)
        goto LAB4;
    else
        goto LAB5;

}

static void Cont_38_1(char *t0)
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

LAB0:    t1 = (t0 + 5128U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 3800);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 5872);
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
    t18 = (t0 + 5712);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Always_39_2(char *t0)
{
    char t4[8];
    char t23[128];
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
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    unsigned int t30;
    char *t31;
    unsigned int t32;
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
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    char *t52;

LAB0:    t1 = (t0 + 5376U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(39, ng0);
    t2 = (t0 + 5728);
    *((int *)t2) = 1;
    t3 = (t0 + 5408);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(39, ng0);

LAB5:    xsi_set_current_line(40, ng0);
    t5 = (t0 + 1480U);
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

LAB11:    xsi_set_current_line(46, ng0);

LAB14:    xsi_set_current_line(47, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3800);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(48, ng0);
    t2 = (t0 + 3960);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);

LAB15:    t6 = (t0 + 472);
    t12 = *((char **)t6);
    t21 = xsi_vlog_unsigned_case_compare(t5, 1, t12, 32);
    if (t21 == 1)
        goto LAB16;

LAB17:    t2 = (t0 + 608);
    t3 = *((char **)t2);
    t21 = xsi_vlog_unsigned_case_compare(t5, 1, t3, 32);
    if (t21 == 1)
        goto LAB18;

LAB19:
LAB21:
LAB20:    xsi_set_current_line(72, ng0);
    t2 = (t0 + 472);
    t3 = *((char **)t2);
    t2 = (t0 + 3960);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 1, 0LL);

LAB22:
LAB12:    goto LAB2;

LAB6:    *((unsigned int *)t4) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(40, ng0);

LAB13:    xsi_set_current_line(41, ng0);
    t19 = ((char*)((ng1)));
    t20 = (t0 + 3160);
    xsi_vlogvar_wait_assign_value(t20, t19, 0, 0, 512, 0LL);
    xsi_set_current_line(42, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3320);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 5, 0LL);
    xsi_set_current_line(43, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3800);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(44, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3480);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 512, 0LL);
    xsi_set_current_line(45, ng0);
    t2 = (t0 + 472);
    t3 = *((char **)t2);
    t2 = (t0 + 3960);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 1, 0LL);
    goto LAB12;

LAB16:    xsi_set_current_line(49, ng0);

LAB23:    xsi_set_current_line(50, ng0);
    t6 = (t0 + 1640U);
    t13 = *((char **)t6);
    t6 = (t13 + 4);
    t7 = *((unsigned int *)t6);
    t8 = (~(t7));
    t9 = *((unsigned int *)t13);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB24;

LAB25:
LAB26:    goto LAB22;

LAB18:    xsi_set_current_line(55, ng0);

LAB34:    xsi_set_current_line(56, ng0);
    t2 = (t0 + 3320);
    t6 = (t2 + 56U);
    t12 = *((char **)t6);
    t13 = ((char*)((ng3)));
    memset(t4, 0, 8);
    t19 = (t12 + 4);
    if (*((unsigned int *)t19) != 0)
        goto LAB36;

LAB35:    t20 = (t13 + 4);
    if (*((unsigned int *)t20) != 0)
        goto LAB36;

LAB39:    if (*((unsigned int *)t12) < *((unsigned int *)t13))
        goto LAB37;

LAB38:    t24 = (t4 + 4);
    t7 = *((unsigned int *)t24);
    t8 = (~(t7));
    t9 = *((unsigned int *)t4);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB40;

LAB41:    xsi_set_current_line(62, ng0);

LAB54:    xsi_set_current_line(63, ng0);
    t2 = (t0 + 1800U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t7 = *((unsigned int *)t2);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB55;

LAB56:
LAB57:
LAB42:    goto LAB22;

LAB24:    xsi_set_current_line(50, ng0);

LAB27:    xsi_set_current_line(51, ng0);
    t19 = (t0 + 1960U);
    t20 = *((char **)t19);
    t19 = (t0 + 2120U);
    t22 = *((char **)t19);
    t14 = 0;

LAB31:    t15 = (t14 < 16);
    if (t15 == 1)
        goto LAB32;

LAB33:    t41 = (t0 + 3160);
    xsi_vlogvar_wait_assign_value(t41, t23, 0, 0, 512, 0LL);
    xsi_set_current_line(52, ng0);
    t2 = (t0 + 608);
    t3 = *((char **)t2);
    t2 = (t0 + 3960);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 1, 0LL);
    goto LAB26;

LAB28:    t39 = *((unsigned int *)t25);
    t40 = *((unsigned int *)t33);
    *((unsigned int *)t25) = (t39 | t40);

LAB30:    t14 = (t14 + 1);
    goto LAB31;

LAB29:    goto LAB30;

LAB32:    t16 = (t14 * 8);
    t19 = (t20 + t16);
    t24 = (t22 + t16);
    t25 = (t23 + t16);
    t17 = *((unsigned int *)t19);
    t18 = *((unsigned int *)t24);
    t26 = (t17 ^ t18);
    *((unsigned int *)t25) = t26;
    t27 = (t14 * 8);
    t28 = (t27 + 4);
    t29 = (t20 + t28);
    t30 = (t27 + 4);
    t31 = (t22 + t30);
    t32 = (t27 + 4);
    t33 = (t23 + t32);
    t34 = *((unsigned int *)t29);
    t35 = *((unsigned int *)t31);
    t36 = (t34 | t35);
    *((unsigned int *)t33) = t36;
    t37 = *((unsigned int *)t33);
    t38 = (t37 != 0);
    if (t38 == 1)
        goto LAB28;
    else
        goto LAB29;

LAB36:    t22 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t22) = 1;
    goto LAB38;

LAB37:    *((unsigned int *)t4) = 1;
    goto LAB38;

LAB40:    xsi_set_current_line(56, ng0);

LAB43:    xsi_set_current_line(57, ng0);
    t25 = (t0 + 1800U);
    t29 = *((char **)t25);
    t25 = (t29 + 4);
    t14 = *((unsigned int *)t25);
    t15 = (~(t14));
    t16 = *((unsigned int *)t29);
    t17 = (t16 & t15);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB44;

LAB45:
LAB46:    goto LAB42;

LAB44:    xsi_set_current_line(57, ng0);

LAB47:    xsi_set_current_line(58, ng0);
    t31 = (t0 + 2760U);
    t33 = *((char **)t31);
    t31 = (t0 + 2280U);
    t41 = *((char **)t31);
    t26 = 0;

LAB51:    t27 = (t26 < 16);
    if (t27 == 1)
        goto LAB52;

LAB53:    t52 = (t0 + 3160);
    xsi_vlogvar_wait_assign_value(t52, t23, 0, 0, 512, 0LL);
    xsi_set_current_line(59, ng0);
    t2 = (t0 + 3320);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = ((char*)((ng4)));
    memset(t4, 0, 8);
    xsi_vlog_unsigned_add(t4, 32, t6, 5, t12, 32);
    t13 = (t0 + 3320);
    xsi_vlogvar_wait_assign_value(t13, t4, 0, 0, 5, 0LL);
    xsi_set_current_line(60, ng0);
    t2 = (t0 + 608);
    t3 = *((char **)t2);
    t2 = (t0 + 3960);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 1, 0LL);
    goto LAB46;

LAB48:    t50 = *((unsigned int *)t43);
    t51 = *((unsigned int *)t46);
    *((unsigned int *)t43) = (t50 | t51);

LAB50:    t26 = (t26 + 1);
    goto LAB51;

LAB49:    goto LAB50;

LAB52:    t28 = (t26 * 8);
    t31 = (t33 + t28);
    t42 = (t41 + t28);
    t43 = (t23 + t28);
    t30 = *((unsigned int *)t31);
    t32 = *((unsigned int *)t42);
    t34 = (t30 ^ t32);
    *((unsigned int *)t43) = t34;
    t35 = (t26 * 8);
    t36 = (t35 + 4);
    t44 = (t33 + t36);
    t37 = (t35 + 4);
    t45 = (t41 + t37);
    t38 = (t35 + 4);
    t46 = (t23 + t38);
    t39 = *((unsigned int *)t44);
    t40 = *((unsigned int *)t45);
    t47 = (t39 | t40);
    *((unsigned int *)t46) = t47;
    t48 = *((unsigned int *)t46);
    t49 = (t48 != 0);
    if (t49 == 1)
        goto LAB48;
    else
        goto LAB49;

LAB55:    xsi_set_current_line(63, ng0);

LAB58:    xsi_set_current_line(64, ng0);
    t6 = (t0 + 2760U);
    t12 = *((char **)t6);
    t6 = (t0 + 2280U);
    t13 = *((char **)t6);
    t14 = 0;

LAB62:    t15 = (t14 < 16);
    if (t15 == 1)
        goto LAB63;

LAB64:    t29 = (t0 + 3480);
    xsi_vlogvar_wait_assign_value(t29, t23, 0, 0, 512, 0LL);
    xsi_set_current_line(65, ng0);
    t2 = (t0 + 1960U);
    t3 = *((char **)t2);
    t2 = (t0 + 2120U);
    t6 = *((char **)t2);
    t7 = 0;

LAB68:    t8 = (t7 < 16);
    if (t8 == 1)
        goto LAB69;

LAB70:    t24 = (t0 + 3640);
    xsi_vlogvar_wait_assign_value(t24, t23, 0, 0, 512, 0LL);
    xsi_set_current_line(66, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 3800);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(67, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3320);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 5, 0LL);
    xsi_set_current_line(68, ng0);
    t2 = (t0 + 472);
    t3 = *((char **)t2);
    t2 = (t0 + 3960);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 1, 0LL);
    goto LAB57;

LAB59:    t39 = *((unsigned int *)t20);
    t40 = *((unsigned int *)t25);
    *((unsigned int *)t20) = (t39 | t40);

LAB61:    t14 = (t14 + 1);
    goto LAB62;

LAB60:    goto LAB61;

LAB63:    t16 = (t14 * 8);
    t6 = (t12 + t16);
    t19 = (t13 + t16);
    t20 = (t23 + t16);
    t17 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t19);
    t26 = (t17 ^ t18);
    *((unsigned int *)t20) = t26;
    t27 = (t14 * 8);
    t28 = (t27 + 4);
    t22 = (t12 + t28);
    t30 = (t27 + 4);
    t24 = (t13 + t30);
    t32 = (t27 + 4);
    t25 = (t23 + t32);
    t34 = *((unsigned int *)t22);
    t35 = *((unsigned int *)t24);
    t36 = (t34 | t35);
    *((unsigned int *)t25) = t36;
    t37 = *((unsigned int *)t25);
    t38 = (t37 != 0);
    if (t38 == 1)
        goto LAB59;
    else
        goto LAB60;

LAB65:    t34 = *((unsigned int *)t13);
    t35 = *((unsigned int *)t22);
    *((unsigned int *)t13) = (t34 | t35);

LAB67:    t7 = (t7 + 1);
    goto LAB68;

LAB66:    goto LAB67;

LAB69:    t9 = (t7 * 8);
    t2 = (t3 + t9);
    t12 = (t6 + t9);
    t13 = (t23 + t9);
    t10 = *((unsigned int *)t2);
    t11 = *((unsigned int *)t12);
    t14 = (t10 ^ t11);
    *((unsigned int *)t13) = t14;
    t15 = (t7 * 8);
    t16 = (t15 + 4);
    t19 = (t3 + t16);
    t17 = (t15 + 4);
    t20 = (t6 + t17);
    t18 = (t15 + 4);
    t22 = (t23 + t18);
    t26 = *((unsigned int *)t19);
    t27 = *((unsigned int *)t20);
    t28 = (t26 | t27);
    *((unsigned int *)t22) = t28;
    t30 = *((unsigned int *)t22);
    t32 = (t30 != 0);
    if (t32 == 1)
        goto LAB65;
    else
        goto LAB66;

}


extern void work_m_00000000001788726382_3034317802_init()
{
	static char *pe[] = {(void *)Cont_31_0,(void *)Cont_38_1,(void *)Always_39_2};
	xsi_register_didat("work_m_00000000001788726382_3034317802", "isim/top_whirlpool_hash_isim_beh.exe.sim/work/m_00000000001788726382_3034317802.didat");
	xsi_register_executes(pe);
}
