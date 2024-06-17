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
static const char *ng0 = "D:/Code/verarecovery/src/serpent-bitslices/rtl/serpent_xts_de.v";
static int ng1[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
static int ng2[] = {0, 0, 0, 0, 0, 0, 0, 0};
static unsigned int ng3[] = {0U, 0U};
static unsigned int ng4[] = {0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U};
static int ng5[] = {1, 0};
static unsigned int ng6[] = {1U, 0U};
static int ng7[] = {0, 0};
static unsigned int ng8[] = {2U, 0U};
static unsigned int ng9[] = {4211772127U, 0U, 863141382U, 0U, 1413560344U, 0U, 3361992627U, 0U};
static unsigned int ng10[] = {3U, 0U};
static int ng11[] = {1229212741, 0, 0, 0, 0, 0};
static int ng12[] = {1128352835, 0, 1161907039, 0, 21591, 0};
static int ng13[] = {1346913618, 0, 1096762185, 0, 4473172, 0};
static int ng14[] = {1146048069, 0, 0, 0, 0, 0};



static void Cont_51_0(char *t0)
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

LAB0:    t1 = (t0 + 6112U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 4872);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 7304);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    xsi_vlog_bit_copy(t9, 0, t4, 0, 128);
    xsi_driver_vfirst_trans(t5, 0, 127);
    t10 = (t0 + 7176);
    *((int *)t10) = 1;

LAB1:    return;
}

static void Cont_52_1(char *t0)
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

LAB0:    t1 = (t0 + 6360U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 4392);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 7368);
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
    t18 = (t0 + 7192);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Always_54_2(char *t0)
{
    char t4[8];
    char t32[8];
    char t34[8];
    char t67[64];
    char t70[32];
    char t71[32];
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
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    int t31;
    char *t33;
    char *t35;
    char *t36;
    char *t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    char *t43;
    char *t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    int t53;
    int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    char *t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    char *t68;
    char *t69;

LAB0:    t1 = (t0 + 6608U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(54, ng0);
    t2 = (t0 + 7208);
    *((int *)t2) = 1;
    t3 = (t0 + 6640);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(54, ng0);

LAB5:    xsi_set_current_line(55, ng0);
    t5 = (t0 + 1752U);
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
    t14 = (t6 + 4);
    t15 = *((unsigned int *)t6);
    t16 = (~(t15));
    *((unsigned int *)t4) = t16;
    *((unsigned int *)t13) = 0;
    if (*((unsigned int *)t14) != 0)
        goto LAB11;

LAB10:    t21 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t21 & 1U);
    t22 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t22 & 1U);
    t23 = (t4 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t4);
    t27 = (t26 & t25);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB12;

LAB13:    xsi_set_current_line(61, ng0);

LAB16:    xsi_set_current_line(62, ng0);
    t2 = (t0 + 5032);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);

LAB17:    t6 = ((char*)((ng3)));
    t31 = xsi_vlog_unsigned_case_compare(t5, 2, t6, 2);
    if (t31 == 1)
        goto LAB18;

LAB19:    t2 = ((char*)((ng6)));
    t31 = xsi_vlog_unsigned_case_compare(t5, 2, t2, 2);
    if (t31 == 1)
        goto LAB20;

LAB21:    t2 = ((char*)((ng8)));
    t31 = xsi_vlog_unsigned_case_compare(t5, 2, t2, 2);
    if (t31 == 1)
        goto LAB22;

LAB23:    t2 = ((char*)((ng10)));
    t31 = xsi_vlog_unsigned_case_compare(t5, 2, t2, 2);
    if (t31 == 1)
        goto LAB24;

LAB25:
LAB26:
LAB14:    goto LAB2;

LAB6:    *((unsigned int *)t4) = 1;
    goto LAB9;

LAB11:    t17 = *((unsigned int *)t4);
    t18 = *((unsigned int *)t14);
    *((unsigned int *)t4) = (t17 | t18);
    t19 = *((unsigned int *)t13);
    t20 = *((unsigned int *)t14);
    *((unsigned int *)t13) = (t19 | t20);
    goto LAB10;

LAB12:    xsi_set_current_line(55, ng0);

LAB15:    xsi_set_current_line(56, ng0);
    t29 = ((char*)((ng1)));
    t30 = (t0 + 3752);
    xsi_vlogvar_wait_assign_value(t30, t29, 0, 0, 256, 0LL);
    xsi_set_current_line(57, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3912);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 256, 0LL);
    xsi_set_current_line(58, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4552);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 128, 0LL);
    xsi_set_current_line(59, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4712);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 128, 0LL);
    xsi_set_current_line(60, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 5032);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 2, 0LL);
    goto LAB14;

LAB18:    xsi_set_current_line(63, ng0);

LAB27:    xsi_set_current_line(64, ng0);
    t12 = (t0 + 1912U);
    t13 = *((char **)t12);
    memset(t4, 0, 8);
    t12 = (t13 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t13);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB28;

LAB29:    if (*((unsigned int *)t12) != 0)
        goto LAB30;

LAB31:    t23 = (t4 + 4);
    t15 = *((unsigned int *)t4);
    t16 = *((unsigned int *)t23);
    t17 = (t15 || t16);
    if (t17 > 0)
        goto LAB32;

LAB33:    memcpy(t34, t4, 8);

LAB34:    t61 = (t34 + 4);
    t62 = *((unsigned int *)t61);
    t63 = (~(t62));
    t64 = *((unsigned int *)t34);
    t65 = (t64 & t63);
    t66 = (t65 != 0);
    if (t66 > 0)
        goto LAB42;

LAB43:
LAB44:    goto LAB26;

LAB20:    xsi_set_current_line(72, ng0);

LAB46:    xsi_set_current_line(73, ng0);
    t3 = (t0 + 2872U);
    t6 = *((char **)t3);
    t3 = (t6 + 4);
    t7 = *((unsigned int *)t3);
    t8 = (~(t7));
    t9 = *((unsigned int *)t6);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB47;

LAB48:
LAB49:    goto LAB26;

LAB22:    xsi_set_current_line(80, ng0);

LAB57:    xsi_set_current_line(81, ng0);
    t3 = (t0 + 3032U);
    t6 = *((char **)t3);
    t3 = (t6 + 4);
    t7 = *((unsigned int *)t3);
    t8 = (~(t7));
    t9 = *((unsigned int *)t6);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB58;

LAB59:
LAB60:    goto LAB26;

LAB24:    xsi_set_current_line(89, ng0);

LAB62:    xsi_set_current_line(90, ng0);
    t3 = (t0 + 2072U);
    t6 = *((char **)t3);
    t3 = (t6 + 4);
    t7 = *((unsigned int *)t3);
    t8 = (~(t7));
    t9 = *((unsigned int *)t6);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB63;

LAB64:    xsi_set_current_line(96, ng0);

LAB67:    xsi_set_current_line(97, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 5032);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 2, 0LL);

LAB65:    goto LAB26;

LAB28:    *((unsigned int *)t4) = 1;
    goto LAB31;

LAB30:    t14 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t14) = 1;
    goto LAB31;

LAB32:    t29 = (t0 + 2072U);
    t30 = *((char **)t29);
    memset(t32, 0, 8);
    t29 = (t30 + 4);
    t18 = *((unsigned int *)t29);
    t19 = (~(t18));
    t20 = *((unsigned int *)t30);
    t21 = (t20 & t19);
    t22 = (t21 & 1U);
    if (t22 != 0)
        goto LAB35;

LAB36:    if (*((unsigned int *)t29) != 0)
        goto LAB37;

LAB38:    t24 = *((unsigned int *)t4);
    t25 = *((unsigned int *)t32);
    t26 = (t24 & t25);
    *((unsigned int *)t34) = t26;
    t35 = (t4 + 4);
    t36 = (t32 + 4);
    t37 = (t34 + 4);
    t27 = *((unsigned int *)t35);
    t28 = *((unsigned int *)t36);
    t38 = (t27 | t28);
    *((unsigned int *)t37) = t38;
    t39 = *((unsigned int *)t37);
    t40 = (t39 != 0);
    if (t40 == 1)
        goto LAB39;

LAB40:
LAB41:    goto LAB34;

LAB35:    *((unsigned int *)t32) = 1;
    goto LAB38;

LAB37:    t33 = (t32 + 4);
    *((unsigned int *)t32) = 1;
    *((unsigned int *)t33) = 1;
    goto LAB38;

LAB39:    t41 = *((unsigned int *)t34);
    t42 = *((unsigned int *)t37);
    *((unsigned int *)t34) = (t41 | t42);
    t43 = (t4 + 4);
    t44 = (t32 + 4);
    t45 = *((unsigned int *)t4);
    t46 = (~(t45));
    t47 = *((unsigned int *)t43);
    t48 = (~(t47));
    t49 = *((unsigned int *)t32);
    t50 = (~(t49));
    t51 = *((unsigned int *)t44);
    t52 = (~(t51));
    t53 = (t46 & t48);
    t54 = (t50 & t52);
    t55 = (~(t53));
    t56 = (~(t54));
    t57 = *((unsigned int *)t37);
    *((unsigned int *)t37) = (t57 & t55);
    t58 = *((unsigned int *)t37);
    *((unsigned int *)t37) = (t58 & t56);
    t59 = *((unsigned int *)t34);
    *((unsigned int *)t34) = (t59 & t55);
    t60 = *((unsigned int *)t34);
    *((unsigned int *)t34) = (t60 & t56);
    goto LAB41;

LAB42:    xsi_set_current_line(64, ng0);

LAB45:    xsi_set_current_line(65, ng0);
    t68 = (t0 + 2232U);
    t69 = *((char **)t68);
    xsi_vlog_get_part_select_value(t67, 256, t69, 511, 256);
    t68 = (t0 + 3752);
    xsi_vlogvar_wait_assign_value(t68, t67, 0, 0, 256, 0LL);
    xsi_set_current_line(66, ng0);
    t2 = (t0 + 2232U);
    t3 = *((char **)t2);
    xsi_vlog_get_part_select_value(t67, 256, t3, 255, 0);
    t2 = (t0 + 3912);
    xsi_vlogvar_wait_assign_value(t2, t67, 0, 0, 256, 0LL);
    xsi_set_current_line(67, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 4552);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 128, 0LL);
    xsi_set_current_line(68, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 4072);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(69, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 5032);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 2, 0LL);
    goto LAB44;

LAB47:    xsi_set_current_line(73, ng0);

LAB50:    xsi_set_current_line(74, ng0);
    t12 = (t0 + 2392U);
    t13 = *((char **)t12);
    xsi_vlog_get_part_select_value(t70, 128, t13, 127, 0);
    t12 = (t0 + 3192U);
    t14 = *((char **)t12);
    t15 = 0;

LAB54:    t16 = (t15 < 4);
    if (t16 == 1)
        goto LAB55;

LAB56:    t36 = (t0 + 4712);
    xsi_vlogvar_wait_assign_value(t36, t71, 0, 0, 128, 0LL);
    xsi_set_current_line(75, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 4072);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(76, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 4232);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(77, ng0);
    t2 = ((char*)((ng8)));
    t3 = (t0 + 5032);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 2, 0LL);
    goto LAB49;

LAB51:    t40 = *((unsigned int *)t29);
    t41 = *((unsigned int *)t35);
    *((unsigned int *)t29) = (t40 | t41);

LAB53:    t15 = (t15 + 1);
    goto LAB54;

LAB52:    goto LAB53;

LAB55:    t17 = (t15 * 8);
    t12 = (t70 + t17);
    t23 = (t14 + t17);
    t29 = (t71 + t17);
    t18 = *((unsigned int *)t12);
    t19 = *((unsigned int *)t23);
    t20 = (t18 ^ t19);
    *((unsigned int *)t29) = t20;
    t21 = (t15 * 8);
    t22 = (t21 + 4);
    t30 = (t70 + t22);
    t24 = (t21 + 4);
    t33 = (t14 + t24);
    t25 = (t21 + 4);
    t35 = (t71 + t25);
    t26 = *((unsigned int *)t30);
    t27 = *((unsigned int *)t33);
    t28 = (t26 | t27);
    *((unsigned int *)t35) = t28;
    t38 = *((unsigned int *)t35);
    t39 = (t38 != 0);
    if (t39 == 1)
        goto LAB51;
    else
        goto LAB52;

LAB58:    xsi_set_current_line(81, ng0);

LAB61:    xsi_set_current_line(83, ng0);
    t12 = ((char*)((ng9)));
    t13 = (t0 + 4872);
    xsi_vlogvar_wait_assign_value(t13, t12, 0, 0, 128, 0LL);
    xsi_set_current_line(84, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 4232);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(85, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 4392);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(86, ng0);
    t2 = ((char*)((ng10)));
    t3 = (t0 + 5032);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 2, 0LL);
    goto LAB60;

LAB63:    xsi_set_current_line(90, ng0);

LAB66:    xsi_set_current_line(91, ng0);
    t12 = (t0 + 2232U);
    t13 = *((char **)t12);
    xsi_vlog_get_part_select_value(t67, 256, t13, 511, 256);
    t12 = (t0 + 3752);
    xsi_vlogvar_wait_assign_value(t12, t67, 0, 0, 256, 0LL);
    xsi_set_current_line(92, ng0);
    t2 = (t0 + 2232U);
    t3 = *((char **)t2);
    xsi_vlog_get_part_select_value(t67, 256, t3, 255, 0);
    t2 = (t0 + 3912);
    xsi_vlogvar_wait_assign_value(t2, t67, 0, 0, 256, 0LL);
    xsi_set_current_line(93, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 4552);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 128, 0LL);
    xsi_set_current_line(94, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 4072);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(95, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 5032);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 2, 0LL);
    goto LAB65;

}

static void Always_104_3(char *t0)
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

LAB0:    t1 = (t0 + 6856U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(104, ng0);
    t2 = (t0 + 7224);
    *((int *)t2) = 1;
    t3 = (t0 + 6888);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(104, ng0);

LAB5:    xsi_set_current_line(105, ng0);
    t4 = (t0 + 5032);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);

LAB6:    t7 = ((char*)((ng3)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 2, t7, 2);
    if (t8 == 1)
        goto LAB7;

LAB8:    t2 = ((char*)((ng6)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 2, t2, 2);
    if (t8 == 1)
        goto LAB9;

LAB10:    t2 = ((char*)((ng8)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 2, t2, 2);
    if (t8 == 1)
        goto LAB11;

LAB12:    t2 = ((char*)((ng10)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 2, t2, 2);
    if (t8 == 1)
        goto LAB13;

LAB14:
LAB15:    goto LAB2;

LAB7:    xsi_set_current_line(106, ng0);
    t9 = ((char*)((ng11)));
    t10 = (t0 + 5192);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 96);
    goto LAB15;

LAB9:    xsi_set_current_line(107, ng0);
    t3 = ((char*)((ng12)));
    t4 = (t0 + 5192);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 96);
    goto LAB15;

LAB11:    xsi_set_current_line(108, ng0);
    t3 = ((char*)((ng13)));
    t4 = (t0 + 5192);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 96);
    goto LAB15;

LAB13:    xsi_set_current_line(109, ng0);
    t3 = ((char*)((ng14)));
    t4 = (t0 + 5192);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 96);
    goto LAB15;

}


extern void work_m_00000000002345346916_4025671893_init()
{
	static char *pe[] = {(void *)Cont_51_0,(void *)Cont_52_1,(void *)Always_54_2,(void *)Always_104_3};
	xsi_register_didat("work_m_00000000002345346916_4025671893", "isim/tb_serpent_xts_de_isim_beh.exe.sim/work/m_00000000002345346916_4025671893.didat");
	xsi_register_executes(pe);
}
