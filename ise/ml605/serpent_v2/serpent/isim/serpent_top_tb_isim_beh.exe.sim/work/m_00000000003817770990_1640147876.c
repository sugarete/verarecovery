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
static const char *ng0 = "D:/Code/verarecovery/src/serpent-bitslices/rtl/serpent_decrypt.v";
static int ng1[] = {0, 0};
static int ng2[] = {0, 0, 0, 0, 0, 0, 0, 0};
static unsigned int ng3[] = {0U, 0U};
static unsigned int ng4[] = {32U, 0U};
static unsigned int ng5[] = {1U, 0U};
static unsigned int ng6[] = {4U, 0U};
static unsigned int ng7[] = {2U, 0U};
static int ng8[] = {1, 0};
static int ng9[] = {1229212741, 0, 0, 0};
static int ng10[] = {1330990660, 0, 82, 0};
static int ng11[] = {1230517042, 0, 77, 0};



static void Cont_44_0(char *t0)
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

LAB0:    t1 = (t0 + 5976U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(44, ng0);
    t2 = (t0 + 3776);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 7432);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 63U;
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
    xsi_driver_vfirst_trans(t5, 0, 5);
    t18 = (t0 + 7288);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Cont_45_1(char *t0)
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

LAB0:    t1 = (t0 + 6224U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(45, ng0);
    t2 = (t0 + 4736);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 7496);
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
    t18 = (t0 + 7304);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Cont_46_2(char *t0)
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

LAB0:    t1 = (t0 + 6472U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(46, ng0);
    t2 = (t0 + 4576);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 7560);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    xsi_vlog_bit_copy(t9, 0, t4, 0, 128);
    xsi_driver_vfirst_trans(t5, 0, 127);
    t10 = (t0 + 7320);
    *((int *)t10) = 1;

LAB1:    return;
}

static void Always_48_3(char *t0)
{
    char t4[8];
    char t32[8];
    char t36[8];
    char t52[8];
    char t60[8];
    char t99[32];
    char t100[8];
    char t102[8];
    char t105[8];
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
    unsigned int t33;
    unsigned int t34;
    char *t35;
    char *t37;
    char *t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    char *t51;
    char *t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    char *t59;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    char *t64;
    char *t65;
    char *t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    char *t74;
    char *t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    int t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    char *t91;
    unsigned int t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    char *t97;
    char *t98;
    char *t101;
    char *t103;
    char *t104;
    char *t106;
    char *t107;
    char *t108;
    char *t109;

LAB0:    t1 = (t0 + 6720U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(48, ng0);
    t2 = (t0 + 7336);
    *((int *)t2) = 1;
    t3 = (t0 + 6752);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(48, ng0);

LAB5:    xsi_set_current_line(49, ng0);
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

LAB13:    xsi_set_current_line(58, ng0);

LAB16:    xsi_set_current_line(59, ng0);
    t2 = (t0 + 4896);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);

LAB17:    t6 = ((char*)((ng3)));
    t31 = xsi_vlog_unsigned_case_compare(t5, 3, t6, 3);
    if (t31 == 1)
        goto LAB18;

LAB19:    t2 = ((char*)((ng6)));
    t31 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t31 == 1)
        goto LAB20;

LAB21:    t2 = ((char*)((ng7)));
    t31 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t31 == 1)
        goto LAB22;

LAB23:
LAB24:
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

LAB12:    xsi_set_current_line(49, ng0);

LAB15:    xsi_set_current_line(50, ng0);
    t29 = ((char*)((ng1)));
    t30 = (t0 + 3776);
    xsi_vlogvar_wait_assign_value(t30, t29, 0, 0, 6, 0LL);
    xsi_set_current_line(51, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3936);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(52, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4096);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(53, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4256);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(54, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4416);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(55, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4576);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 128, 0LL);
    xsi_set_current_line(56, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4736);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(57, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 4896);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);
    goto LAB14;

LAB18:    xsi_set_current_line(60, ng0);

LAB25:    xsi_set_current_line(61, ng0);
    t12 = ((char*)((ng4)));
    t13 = (t0 + 3776);
    xsi_vlogvar_wait_assign_value(t13, t12, 0, 0, 6, 0LL);
    xsi_set_current_line(62, ng0);
    t2 = (t0 + 1776U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng5)));
    memset(t4, 0, 8);
    t6 = (t3 + 4);
    t12 = (t2 + 4);
    t7 = *((unsigned int *)t3);
    t8 = *((unsigned int *)t2);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t6);
    t11 = *((unsigned int *)t12);
    t15 = (t10 ^ t11);
    t16 = (t9 | t15);
    t17 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t12);
    t19 = (t17 | t18);
    t20 = (~(t19));
    t21 = (t16 & t20);
    if (t21 != 0)
        goto LAB29;

LAB26:    if (t19 != 0)
        goto LAB28;

LAB27:    *((unsigned int *)t4) = 1;

LAB29:    memset(t32, 0, 8);
    t14 = (t4 + 4);
    t22 = *((unsigned int *)t14);
    t24 = (~(t22));
    t25 = *((unsigned int *)t4);
    t26 = (t25 & t24);
    t27 = (t26 & 1U);
    if (t27 != 0)
        goto LAB30;

LAB31:    if (*((unsigned int *)t14) != 0)
        goto LAB32;

LAB33:    t29 = (t32 + 4);
    t28 = *((unsigned int *)t32);
    t33 = *((unsigned int *)t29);
    t34 = (t28 || t33);
    if (t34 > 0)
        goto LAB34;

LAB35:    memcpy(t60, t32, 8);

LAB36:    t91 = (t60 + 4);
    t92 = *((unsigned int *)t91);
    t93 = (~(t92));
    t94 = *((unsigned int *)t60);
    t95 = (t94 & t93);
    t96 = (t95 != 0);
    if (t96 > 0)
        goto LAB48;

LAB49:
LAB50:    goto LAB24;

LAB20:    xsi_set_current_line(66, ng0);

LAB52:    xsi_set_current_line(67, ng0);
    t3 = (t0 + 2896U);
    t6 = *((char **)t3);
    t3 = (t0 + 2096U);
    t12 = *((char **)t3);
    memset(t4, 0, 8);
    t3 = (t4 + 4);
    t13 = (t12 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (t7 >> 0);
    *((unsigned int *)t4) = t8;
    t9 = *((unsigned int *)t13);
    t10 = (t9 >> 0);
    *((unsigned int *)t3) = t10;
    t11 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t11 & 4294967295U);
    t15 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t15 & 4294967295U);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t4);
    t18 = (t16 ^ t17);
    *((unsigned int *)t32) = t18;
    t14 = (t6 + 4);
    t23 = (t4 + 4);
    t29 = (t32 + 4);
    t19 = *((unsigned int *)t14);
    t20 = *((unsigned int *)t23);
    t21 = (t19 | t20);
    *((unsigned int *)t29) = t21;
    t22 = *((unsigned int *)t29);
    t24 = (t22 != 0);
    if (t24 == 1)
        goto LAB53;

LAB54:
LAB55:    t30 = (t0 + 3056U);
    t35 = *((char **)t30);
    t30 = (t0 + 2096U);
    t37 = *((char **)t30);
    memset(t36, 0, 8);
    t30 = (t36 + 4);
    t38 = (t37 + 4);
    t27 = *((unsigned int *)t37);
    t28 = (t27 >> 0);
    *((unsigned int *)t36) = t28;
    t33 = *((unsigned int *)t38);
    t34 = (t33 >> 0);
    *((unsigned int *)t30) = t34;
    t39 = *((unsigned int *)t36);
    *((unsigned int *)t36) = (t39 & 4294967295U);
    t40 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t40 & 4294967295U);
    t41 = *((unsigned int *)t35);
    t42 = *((unsigned int *)t36);
    t43 = (t41 ^ t42);
    *((unsigned int *)t52) = t43;
    t51 = (t35 + 4);
    t53 = (t36 + 4);
    t59 = (t52 + 4);
    t44 = *((unsigned int *)t51);
    t45 = *((unsigned int *)t53);
    t46 = (t44 | t45);
    *((unsigned int *)t59) = t46;
    t47 = *((unsigned int *)t59);
    t48 = (t47 != 0);
    if (t48 == 1)
        goto LAB56;

LAB57:
LAB58:    t64 = (t0 + 3216U);
    t65 = *((char **)t64);
    t64 = (t0 + 2096U);
    t66 = *((char **)t64);
    memset(t60, 0, 8);
    t64 = (t60 + 4);
    t74 = (t66 + 4);
    t54 = *((unsigned int *)t66);
    t55 = (t54 >> 0);
    *((unsigned int *)t60) = t55;
    t56 = *((unsigned int *)t74);
    t57 = (t56 >> 0);
    *((unsigned int *)t64) = t57;
    t58 = *((unsigned int *)t60);
    *((unsigned int *)t60) = (t58 & 4294967295U);
    t61 = *((unsigned int *)t64);
    *((unsigned int *)t64) = (t61 & 4294967295U);
    t62 = *((unsigned int *)t65);
    t63 = *((unsigned int *)t60);
    t67 = (t62 ^ t63);
    *((unsigned int *)t100) = t67;
    t75 = (t65 + 4);
    t91 = (t60 + 4);
    t97 = (t100 + 4);
    t68 = *((unsigned int *)t75);
    t69 = *((unsigned int *)t91);
    t70 = (t68 | t69);
    *((unsigned int *)t97) = t70;
    t71 = *((unsigned int *)t97);
    t72 = (t71 != 0);
    if (t72 == 1)
        goto LAB59;

LAB60:
LAB61:    t98 = (t0 + 3376U);
    t101 = *((char **)t98);
    t98 = (t0 + 2096U);
    t103 = *((char **)t98);
    memset(t102, 0, 8);
    t98 = (t102 + 4);
    t104 = (t103 + 4);
    t77 = *((unsigned int *)t103);
    t78 = (t77 >> 0);
    *((unsigned int *)t102) = t78;
    t79 = *((unsigned int *)t104);
    t80 = (t79 >> 0);
    *((unsigned int *)t98) = t80;
    t81 = *((unsigned int *)t102);
    *((unsigned int *)t102) = (t81 & 4294967295U);
    t82 = *((unsigned int *)t98);
    *((unsigned int *)t98) = (t82 & 4294967295U);
    t83 = *((unsigned int *)t101);
    t85 = *((unsigned int *)t102);
    t86 = (t83 ^ t85);
    *((unsigned int *)t105) = t86;
    t106 = (t101 + 4);
    t107 = (t102 + 4);
    t108 = (t105 + 4);
    t87 = *((unsigned int *)t106);
    t88 = *((unsigned int *)t107);
    t89 = (t87 | t88);
    *((unsigned int *)t108) = t89;
    t90 = *((unsigned int *)t108);
    t92 = (t90 != 0);
    if (t92 == 1)
        goto LAB62;

LAB63:
LAB64:    xsi_vlogtype_concat(t99, 128, 128, 4U, t105, 32, t100, 32, t52, 32, t32, 32);
    t109 = (t0 + 4576);
    xsi_vlogvar_wait_assign_value(t109, t99, 0, 0, 128, 0LL);
    xsi_set_current_line(68, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 4896);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);
    goto LAB24;

LAB22:    xsi_set_current_line(70, ng0);

LAB65:    xsi_set_current_line(71, ng0);
    t3 = (t0 + 3776);
    t6 = (t3 + 56U);
    t12 = *((char **)t6);
    t13 = ((char*)((ng4)));
    memset(t4, 0, 8);
    t14 = (t12 + 4);
    t23 = (t13 + 4);
    t7 = *((unsigned int *)t12);
    t8 = *((unsigned int *)t13);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t14);
    t11 = *((unsigned int *)t23);
    t15 = (t10 ^ t11);
    t16 = (t9 | t15);
    t17 = *((unsigned int *)t14);
    t18 = *((unsigned int *)t23);
    t19 = (t17 | t18);
    t20 = (~(t19));
    t21 = (t16 & t20);
    if (t21 != 0)
        goto LAB69;

LAB66:    if (t19 != 0)
        goto LAB68;

LAB67:    *((unsigned int *)t4) = 1;

LAB69:    t30 = (t4 + 4);
    t22 = *((unsigned int *)t30);
    t24 = (~(t22));
    t25 = *((unsigned int *)t4);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB70;

LAB71:    xsi_set_current_line(78, ng0);
    t2 = (t0 + 3776);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = ((char*)((ng1)));
    memset(t4, 0, 8);
    t13 = (t6 + 4);
    if (*((unsigned int *)t13) != 0)
        goto LAB75;

LAB74:    t14 = (t12 + 4);
    if (*((unsigned int *)t14) != 0)
        goto LAB75;

LAB78:    if (*((unsigned int *)t6) > *((unsigned int *)t12))
        goto LAB76;

LAB77:    t29 = (t4 + 4);
    t7 = *((unsigned int *)t29);
    t8 = (~(t7));
    t9 = *((unsigned int *)t4);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB79;

LAB80:    xsi_set_current_line(85, ng0);

LAB95:    xsi_set_current_line(86, ng0);
    t2 = ((char*)((ng8)));
    t3 = (t0 + 4736);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(87, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 4896);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);

LAB81:
LAB72:    goto LAB24;

LAB28:    t13 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t13) = 1;
    goto LAB29;

LAB30:    *((unsigned int *)t32) = 1;
    goto LAB33;

LAB32:    t23 = (t32 + 4);
    *((unsigned int *)t32) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB33;

LAB34:    t30 = (t0 + 1936U);
    t35 = *((char **)t30);
    t30 = ((char*)((ng5)));
    memset(t36, 0, 8);
    t37 = (t35 + 4);
    t38 = (t30 + 4);
    t39 = *((unsigned int *)t35);
    t40 = *((unsigned int *)t30);
    t41 = (t39 ^ t40);
    t42 = *((unsigned int *)t37);
    t43 = *((unsigned int *)t38);
    t44 = (t42 ^ t43);
    t45 = (t41 | t44);
    t46 = *((unsigned int *)t37);
    t47 = *((unsigned int *)t38);
    t48 = (t46 | t47);
    t49 = (~(t48));
    t50 = (t45 & t49);
    if (t50 != 0)
        goto LAB40;

LAB37:    if (t48 != 0)
        goto LAB39;

LAB38:    *((unsigned int *)t36) = 1;

LAB40:    memset(t52, 0, 8);
    t53 = (t36 + 4);
    t54 = *((unsigned int *)t53);
    t55 = (~(t54));
    t56 = *((unsigned int *)t36);
    t57 = (t56 & t55);
    t58 = (t57 & 1U);
    if (t58 != 0)
        goto LAB41;

LAB42:    if (*((unsigned int *)t53) != 0)
        goto LAB43;

LAB44:    t61 = *((unsigned int *)t32);
    t62 = *((unsigned int *)t52);
    t63 = (t61 & t62);
    *((unsigned int *)t60) = t63;
    t64 = (t32 + 4);
    t65 = (t52 + 4);
    t66 = (t60 + 4);
    t67 = *((unsigned int *)t64);
    t68 = *((unsigned int *)t65);
    t69 = (t67 | t68);
    *((unsigned int *)t66) = t69;
    t70 = *((unsigned int *)t66);
    t71 = (t70 != 0);
    if (t71 == 1)
        goto LAB45;

LAB46:
LAB47:    goto LAB36;

LAB39:    t51 = (t36 + 4);
    *((unsigned int *)t36) = 1;
    *((unsigned int *)t51) = 1;
    goto LAB40;

LAB41:    *((unsigned int *)t52) = 1;
    goto LAB44;

LAB43:    t59 = (t52 + 4);
    *((unsigned int *)t52) = 1;
    *((unsigned int *)t59) = 1;
    goto LAB44;

LAB45:    t72 = *((unsigned int *)t60);
    t73 = *((unsigned int *)t66);
    *((unsigned int *)t60) = (t72 | t73);
    t74 = (t32 + 4);
    t75 = (t52 + 4);
    t76 = *((unsigned int *)t32);
    t77 = (~(t76));
    t78 = *((unsigned int *)t74);
    t79 = (~(t78));
    t80 = *((unsigned int *)t52);
    t81 = (~(t80));
    t82 = *((unsigned int *)t75);
    t83 = (~(t82));
    t31 = (t77 & t79);
    t84 = (t81 & t83);
    t85 = (~(t31));
    t86 = (~(t84));
    t87 = *((unsigned int *)t66);
    *((unsigned int *)t66) = (t87 & t85);
    t88 = *((unsigned int *)t66);
    *((unsigned int *)t66) = (t88 & t86);
    t89 = *((unsigned int *)t60);
    *((unsigned int *)t60) = (t89 & t85);
    t90 = *((unsigned int *)t60);
    *((unsigned int *)t60) = (t90 & t86);
    goto LAB47;

LAB48:    xsi_set_current_line(62, ng0);

LAB51:    xsi_set_current_line(63, ng0);
    t97 = ((char*)((ng6)));
    t98 = (t0 + 4896);
    xsi_vlogvar_wait_assign_value(t98, t97, 0, 0, 3, 0LL);
    goto LAB50;

LAB53:    t25 = *((unsigned int *)t32);
    t26 = *((unsigned int *)t29);
    *((unsigned int *)t32) = (t25 | t26);
    goto LAB55;

LAB56:    t49 = *((unsigned int *)t52);
    t50 = *((unsigned int *)t59);
    *((unsigned int *)t52) = (t49 | t50);
    goto LAB58;

LAB59:    t73 = *((unsigned int *)t100);
    t76 = *((unsigned int *)t97);
    *((unsigned int *)t100) = (t73 | t76);
    goto LAB61;

LAB62:    t93 = *((unsigned int *)t105);
    t94 = *((unsigned int *)t108);
    *((unsigned int *)t105) = (t93 | t94);
    goto LAB64;

LAB68:    t29 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t29) = 1;
    goto LAB69;

LAB70:    xsi_set_current_line(71, ng0);

LAB73:    xsi_set_current_line(72, ng0);
    t35 = (t0 + 4576);
    t37 = (t35 + 56U);
    t38 = *((char **)t37);
    memset(t32, 0, 8);
    t51 = (t32 + 4);
    t53 = (t38 + 4);
    t28 = *((unsigned int *)t38);
    t33 = (t28 >> 0);
    *((unsigned int *)t32) = t33;
    t34 = *((unsigned int *)t53);
    t39 = (t34 >> 0);
    *((unsigned int *)t51) = t39;
    t40 = *((unsigned int *)t32);
    *((unsigned int *)t32) = (t40 & 4294967295U);
    t41 = *((unsigned int *)t51);
    *((unsigned int *)t51) = (t41 & 4294967295U);
    t59 = (t0 + 3936);
    xsi_vlogvar_wait_assign_value(t59, t32, 0, 0, 32, 0LL);
    xsi_set_current_line(73, ng0);
    t2 = (t0 + 4576);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    memset(t4, 0, 8);
    t12 = (t4 + 4);
    t13 = (t6 + 8);
    t14 = (t6 + 12);
    t7 = *((unsigned int *)t13);
    t8 = (t7 >> 0);
    *((unsigned int *)t4) = t8;
    t9 = *((unsigned int *)t14);
    t10 = (t9 >> 0);
    *((unsigned int *)t12) = t10;
    t11 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t11 & 4294967295U);
    t15 = *((unsigned int *)t12);
    *((unsigned int *)t12) = (t15 & 4294967295U);
    t23 = (t0 + 4096);
    xsi_vlogvar_wait_assign_value(t23, t4, 0, 0, 32, 0LL);
    xsi_set_current_line(74, ng0);
    t2 = (t0 + 4576);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    memset(t4, 0, 8);
    t12 = (t4 + 4);
    t13 = (t6 + 16);
    t14 = (t6 + 20);
    t7 = *((unsigned int *)t13);
    t8 = (t7 >> 0);
    *((unsigned int *)t4) = t8;
    t9 = *((unsigned int *)t14);
    t10 = (t9 >> 0);
    *((unsigned int *)t12) = t10;
    t11 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t11 & 4294967295U);
    t15 = *((unsigned int *)t12);
    *((unsigned int *)t12) = (t15 & 4294967295U);
    t23 = (t0 + 4256);
    xsi_vlogvar_wait_assign_value(t23, t4, 0, 0, 32, 0LL);
    xsi_set_current_line(75, ng0);
    t2 = (t0 + 4576);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    memset(t4, 0, 8);
    t12 = (t4 + 4);
    t13 = (t6 + 24);
    t14 = (t6 + 28);
    t7 = *((unsigned int *)t13);
    t8 = (t7 >> 0);
    *((unsigned int *)t4) = t8;
    t9 = *((unsigned int *)t14);
    t10 = (t9 >> 0);
    *((unsigned int *)t12) = t10;
    t11 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t11 & 4294967295U);
    t15 = *((unsigned int *)t12);
    *((unsigned int *)t12) = (t15 & 4294967295U);
    t23 = (t0 + 4416);
    xsi_vlogvar_wait_assign_value(t23, t4, 0, 0, 32, 0LL);
    xsi_set_current_line(76, ng0);
    t2 = (t0 + 3776);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = ((char*)((ng8)));
    memset(t4, 0, 8);
    xsi_vlog_unsigned_minus(t4, 32, t6, 6, t12, 32);
    t13 = (t0 + 3776);
    xsi_vlogvar_wait_assign_value(t13, t4, 0, 0, 6, 0LL);
    xsi_set_current_line(77, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 4896);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);
    goto LAB72;

LAB75:    t23 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB77;

LAB76:    *((unsigned int *)t4) = 1;
    goto LAB77;

LAB79:    xsi_set_current_line(78, ng0);

LAB82:    xsi_set_current_line(79, ng0);
    t30 = (t0 + 2896U);
    t35 = *((char **)t30);
    t30 = (t0 + 2096U);
    t37 = *((char **)t30);
    memset(t32, 0, 8);
    t30 = (t32 + 4);
    t38 = (t37 + 4);
    t15 = *((unsigned int *)t37);
    t16 = (t15 >> 0);
    *((unsigned int *)t32) = t16;
    t17 = *((unsigned int *)t38);
    t18 = (t17 >> 0);
    *((unsigned int *)t30) = t18;
    t19 = *((unsigned int *)t32);
    *((unsigned int *)t32) = (t19 & 4294967295U);
    t20 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t20 & 4294967295U);
    t21 = *((unsigned int *)t35);
    t22 = *((unsigned int *)t32);
    t24 = (t21 ^ t22);
    *((unsigned int *)t36) = t24;
    t51 = (t35 + 4);
    t53 = (t32 + 4);
    t59 = (t36 + 4);
    t25 = *((unsigned int *)t51);
    t26 = *((unsigned int *)t53);
    t27 = (t25 | t26);
    *((unsigned int *)t59) = t27;
    t28 = *((unsigned int *)t59);
    t33 = (t28 != 0);
    if (t33 == 1)
        goto LAB83;

LAB84:
LAB85:    t64 = (t0 + 3936);
    xsi_vlogvar_wait_assign_value(t64, t36, 0, 0, 32, 0LL);
    xsi_set_current_line(80, ng0);
    t2 = (t0 + 3056U);
    t3 = *((char **)t2);
    t2 = (t0 + 2096U);
    t6 = *((char **)t2);
    memset(t4, 0, 8);
    t2 = (t4 + 4);
    t12 = (t6 + 8);
    t13 = (t6 + 12);
    t7 = *((unsigned int *)t12);
    t8 = (t7 >> 0);
    *((unsigned int *)t4) = t8;
    t9 = *((unsigned int *)t13);
    t10 = (t9 >> 0);
    *((unsigned int *)t2) = t10;
    t11 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t11 & 4294967295U);
    t15 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t15 & 4294967295U);
    t16 = *((unsigned int *)t3);
    t17 = *((unsigned int *)t4);
    t18 = (t16 ^ t17);
    *((unsigned int *)t32) = t18;
    t14 = (t3 + 4);
    t23 = (t4 + 4);
    t29 = (t32 + 4);
    t19 = *((unsigned int *)t14);
    t20 = *((unsigned int *)t23);
    t21 = (t19 | t20);
    *((unsigned int *)t29) = t21;
    t22 = *((unsigned int *)t29);
    t24 = (t22 != 0);
    if (t24 == 1)
        goto LAB86;

LAB87:
LAB88:    t30 = (t0 + 4096);
    xsi_vlogvar_wait_assign_value(t30, t32, 0, 0, 32, 0LL);
    xsi_set_current_line(81, ng0);
    t2 = (t0 + 3216U);
    t3 = *((char **)t2);
    t2 = (t0 + 2096U);
    t6 = *((char **)t2);
    memset(t4, 0, 8);
    t2 = (t4 + 4);
    t12 = (t6 + 16);
    t13 = (t6 + 20);
    t7 = *((unsigned int *)t12);
    t8 = (t7 >> 0);
    *((unsigned int *)t4) = t8;
    t9 = *((unsigned int *)t13);
    t10 = (t9 >> 0);
    *((unsigned int *)t2) = t10;
    t11 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t11 & 4294967295U);
    t15 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t15 & 4294967295U);
    t16 = *((unsigned int *)t3);
    t17 = *((unsigned int *)t4);
    t18 = (t16 ^ t17);
    *((unsigned int *)t32) = t18;
    t14 = (t3 + 4);
    t23 = (t4 + 4);
    t29 = (t32 + 4);
    t19 = *((unsigned int *)t14);
    t20 = *((unsigned int *)t23);
    t21 = (t19 | t20);
    *((unsigned int *)t29) = t21;
    t22 = *((unsigned int *)t29);
    t24 = (t22 != 0);
    if (t24 == 1)
        goto LAB89;

LAB90:
LAB91:    t30 = (t0 + 4256);
    xsi_vlogvar_wait_assign_value(t30, t32, 0, 0, 32, 0LL);
    xsi_set_current_line(82, ng0);
    t2 = (t0 + 3376U);
    t3 = *((char **)t2);
    t2 = (t0 + 2096U);
    t6 = *((char **)t2);
    memset(t4, 0, 8);
    t2 = (t4 + 4);
    t12 = (t6 + 24);
    t13 = (t6 + 28);
    t7 = *((unsigned int *)t12);
    t8 = (t7 >> 0);
    *((unsigned int *)t4) = t8;
    t9 = *((unsigned int *)t13);
    t10 = (t9 >> 0);
    *((unsigned int *)t2) = t10;
    t11 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t11 & 4294967295U);
    t15 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t15 & 4294967295U);
    t16 = *((unsigned int *)t3);
    t17 = *((unsigned int *)t4);
    t18 = (t16 ^ t17);
    *((unsigned int *)t32) = t18;
    t14 = (t3 + 4);
    t23 = (t4 + 4);
    t29 = (t32 + 4);
    t19 = *((unsigned int *)t14);
    t20 = *((unsigned int *)t23);
    t21 = (t19 | t20);
    *((unsigned int *)t29) = t21;
    t22 = *((unsigned int *)t29);
    t24 = (t22 != 0);
    if (t24 == 1)
        goto LAB92;

LAB93:
LAB94:    t30 = (t0 + 4416);
    xsi_vlogvar_wait_assign_value(t30, t32, 0, 0, 32, 0LL);
    xsi_set_current_line(83, ng0);
    t2 = (t0 + 3776);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t12 = ((char*)((ng8)));
    memset(t4, 0, 8);
    xsi_vlog_unsigned_minus(t4, 32, t6, 6, t12, 32);
    t13 = (t0 + 3776);
    xsi_vlogvar_wait_assign_value(t13, t4, 0, 0, 6, 0LL);
    xsi_set_current_line(84, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 4896);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);
    goto LAB81;

LAB83:    t34 = *((unsigned int *)t36);
    t39 = *((unsigned int *)t59);
    *((unsigned int *)t36) = (t34 | t39);
    goto LAB85;

LAB86:    t25 = *((unsigned int *)t32);
    t26 = *((unsigned int *)t29);
    *((unsigned int *)t32) = (t25 | t26);
    goto LAB88;

LAB89:    t25 = *((unsigned int *)t32);
    t26 = *((unsigned int *)t29);
    *((unsigned int *)t32) = (t25 | t26);
    goto LAB91;

LAB92:    t25 = *((unsigned int *)t32);
    t26 = *((unsigned int *)t29);
    *((unsigned int *)t32) = (t25 | t26);
    goto LAB94;

}

static void Always_94_4(char *t0)
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

LAB0:    t1 = (t0 + 6968U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(94, ng0);
    t2 = (t0 + 7352);
    *((int *)t2) = 1;
    t3 = (t0 + 7000);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(94, ng0);

LAB5:    xsi_set_current_line(95, ng0);
    t4 = (t0 + 4896);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);

LAB6:    t7 = ((char*)((ng3)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 3, t7, 3);
    if (t8 == 1)
        goto LAB7;

LAB8:    t2 = ((char*)((ng7)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 3, t2, 3);
    if (t8 == 1)
        goto LAB9;

LAB10:    t2 = ((char*)((ng6)));
    t8 = xsi_vlog_unsigned_case_compare(t6, 3, t2, 3);
    if (t8 == 1)
        goto LAB11;

LAB12:
LAB14:
LAB13:    xsi_set_current_line(99, ng0);
    t2 = ((char*)((ng9)));
    t3 = (t0 + 5056);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 48);

LAB15:    goto LAB2;

LAB7:    xsi_set_current_line(96, ng0);
    t9 = ((char*)((ng9)));
    t10 = (t0 + 5056);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 48);
    goto LAB15;

LAB9:    xsi_set_current_line(97, ng0);
    t3 = ((char*)((ng10)));
    t4 = (t0 + 5056);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 48);
    goto LAB15;

LAB11:    xsi_set_current_line(98, ng0);
    t3 = ((char*)((ng11)));
    t4 = (t0 + 5056);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 48);
    goto LAB15;

}


extern void work_m_00000000003817770990_1640147876_init()
{
	static char *pe[] = {(void *)Cont_44_0,(void *)Cont_45_1,(void *)Cont_46_2,(void *)Always_48_3,(void *)Always_94_4};
	xsi_register_didat("work_m_00000000003817770990_1640147876", "isim/serpent_top_tb_isim_beh.exe.sim/work/m_00000000003817770990_1640147876.didat");
	xsi_register_executes(pe);
}
