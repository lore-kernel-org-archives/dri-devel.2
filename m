Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62190C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071FB10E33D;
	Mon, 21 Sep 2026 07:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ChchMQK/";
	dkim-atps=neutral
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6363610E91F
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:25:44 +0000 (UTC)
Received: by mail-yx2-f13.google.com with SMTP id
 956f58d0204a3-66f943b286fso781398d50.2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789741543; cv=none;
 d=google.com; s=arc-20260327;
 b=N+NcoZpn1whDi7jqszJces38AA5/DPy5PZmAeOtqoKFIATDQEBfw1s5ph7tSVLPKxV
 j0jlNItVA4klhSx43tVZBTsw9wFcl5dd3mNY+Gye9ee6FBB/HhnFvCaDcXkKKeFoYgd0
 bWg99ZfBS4fmXVkpc4ZKi+UWxXBZOQtvKRUGeNJRoqGUHS+UBju7LI1tAqLX87fY/KKX
 ffXvv4UDfZcNhsuhchfrgjAXAoLcc/q9SH1sduPTOcbMD2ceTUsvWW4Q0zvueoFTTOt1
 rJceStA+xuxqHmBaAaF3V1F/Aad3Y0/OwT67/pN3t4yeSW0ZlTtqQ0DLDr6nCB82f4Da
 Ic9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=8yLmQImS/cva02RgmyxMSXkNs8cVs/ORnlbUr4+Nfrc=;
 fh=29tiuoGjHgfNiWmy4AGK+kAUV+Td0+ZvXYdl8Trm/ps=;
 b=BCiI1MASnxj6a6AGp4M4BLsJcZVyV0Modu0BQIqVVGsvXyVma2mKBVFumwOXgDjWMd
 Q7VgN18RnatdZADTNfLJdhTp9vrXdQbBrKzXcmZ9Lt0HQpj64vyVMBcaQQoBHEvC5V+W
 j1rOcq2cSJjOgp+QcwQpCqRXJGpjt3tKCYh7j4vNaVDOzicKlN7ycxWczf4aHyfyNMcC
 UwAv2FNtPLOJhmBep7kl/MPHD0KcFJFm0vMGWv5dFFnUkwrj97DT1FMQLUe18tlsWsQ3
 rFJt14zHvzI2f1pvRGGt5WJJNgjtt6KP18L7YrsWFk1RfyjfsRdkLXETMnSX6XlI/Wqw
 2Ppw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789741543; x=1790346343; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8yLmQImS/cva02RgmyxMSXkNs8cVs/ORnlbUr4+Nfrc=;
 b=ChchMQK/ayVeuH98IvL6hxgZNL7rhAQkkGK++CiV2zLwGwVlrVarenXHVxLrRnJ0mH
 yjgRcVIOSAwhCsDRofv5AWyhGAaHz+W3Pt+V7SMvOnyUOocTzs66ivjfUqFehNrn1086
 +FbrdAjlLaO31UQ7lk/CUv4fx8ZGQbvDJK1vB++CcTgxTAjhCpWbWCflEKnTcBGxgqLq
 SE0tuyWeGuMYPcopD8BtnDmPfSsX2iFReaq3thfQ/nxzDWH6QMILegk4o+WsWVATsyGR
 Cd0BV8aedRMa5aBthstRSjR6EoSuBm9LL38zK7SZY0+8pivs69DP/cyt8sd3bo+skztl
 WR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741543; x=1790346343;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8yLmQImS/cva02RgmyxMSXkNs8cVs/ORnlbUr4+Nfrc=;
 b=i9/dj2QQduWH0rjUTGYl/+9SDRSec21O5m0QtMrt4M04r9kYRYAyXFbnud4v+7pvUM
 U0fmJQFLvejiZT4J9FND0L01MA8LFboeOWhQFCiJU+8p6E+b85p2i8c92FMM7RXkWdh1
 7jqwjaKXbIkBdDi/EKIS8RIlr39kJ0CmKRGPA4An8btB5ljbeh4f2Tx8WbczUalkA2d7
 UxZ8FJ8D12R/8Rm1FSsPVns4YQJkjANg4wolFPK7G6FOVds2J322mlynEJmZ11mpztmC
 NJxugE33jFn9FV3PzbrboT7dWrS0VZDju6QEcOlc9HrxED4wdm384Yfu6hUs+JWMVbdP
 W2Fw==
X-Gm-Message-State: AFuF++kQhxbiqYDIUwp7goFh0n/7pE0BjsiPmkfrOQALNdvFTXpaTEK5
 jFY22oNzNdCjS/BRKe+YhEZBrwoOMJMckWfZfq73nNt9wZZWJvwPznO0J63O8KlDqzm2OTUsbCB
 v/xMQwmXPnHBkPe38VH7RsX3GWAF38oRtMw==
X-Gm-Gg: AYBFou0452AnROLeOKly6KmpKWUNlBfk1KAg2thYPGDya9jPKRZxQF1LtsLb6/kqrUT
 M0An3ArBoVbJgIrEqKHB42TfJ/nn/VXEoVvF1ij47qFWFLaZpyIBBognF9MRtE+on1sUM3ErxvX
 MR8+5r0qlTcqQCUEE5LvRR2Afo3HKaLEsIO+HOK21Vj5VtNTzZZFzuJXBsy6X3c6ZxrAkFjC6Q1
 rYomC8VU5x0hXXtr3UHHhG24QwZ1u4xXDVOOcZVlcYGepZ32Q3gdg0OF+Jdzt7ueccDZLR7ei8g
 t1IO+GZslGBQ+gdRjr9IQoaBTq5vt94xJbK700LBgX8UbIbdI04OKyO7UkklQXDZl/RZ/Q7klpr
 wqv/2RzB7yDMLZfUYRFlaM37fdJ9GZWVf5JciJdqPjCoGt+QihzmnZ790XJrxXNVbUmXG
X-Received: by 2002:a05:690e:4848:b0:66f:c1be:84e9 with SMTP id
 956f58d0204a3-6717fe06dcamr711135d50.87.1789741542889; Fri, 18 Sep 2026
 07:25:42 -0700 (PDT)
MIME-Version: 1.0
From: Shane Ayerst <shanoes@gmail.com>
Date: Fri, 18 Sep 2026 16:25:34 +0200
X-Gm-Features: AcwNN1WdyN567dNjK4Y-6JB9CHAbSznmnOLJ44Vwjvz-KvK2k8k-40n4EqNJNU8
Message-ID: <CAB4-Kt44sPS7qoL+wNodsx7DwDxkvDD0nNHz05hmv8miaordmQ@mail.gmail.com>
Subject: [BUG] GK107GLM (Quadro K1000M) never reclocks: PWM-flagged v0x50
 voltage table with no VID_PWM GPIO leaves vid_nr == 0
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000e75c77065bc2acde"
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

--000000000000e75c77065bc2acde
Content-Type: text/plain; charset="UTF-8"

Hi All :)

This is a bug report, not a patch submission. Claude Code was used to
assist with the but triage and fix. I did patch a local build to
confirm the diagnosis and I describe it below, but I have only this one
board
and no view of how a real fix should be shaped, so I am not proposing one.

HARDWARE
NVIDIA GK107GLM [Quadro K1000M], 10de:0ffc rev a1, subsystem 103c:176b
(HP mobile workstation). Single GPU, no iGPU.
Kernel 7.2.5 (Arch), in-tree nouveau. Mesa 26.2.2.

SYMPTOM
Every reclock fails with -EINVAL; the card is pinned at core 405 MHz /
memory 810 MHz for the life of the boot. Each pstate asks for a different
voltage and gets the identical error:

nouveau 0000:01:00.0: volt: couldn't set 837500uv
nouveau 0000:01:00.0: clk: failed to raise voltage: -22
nouveau 0000:01:00.0: clk: error setting pstate 0: -22

nouveau 0000:01:00.0: volt: couldn't set 887500uv
nouveau 0000:01:00.0: clk: failed to raise voltage: -22
nouveau 0000:01:00.0: clk: error setting pstate 1: -22

Earlier in the boot log:

nouveau 0000:01:00.0: volt: Type mismatch between the voltage table type
and the GPIO table. Fallback to GPIO mode.

TO REPRODUCE
1. Boot the affected card on nouveau.
2. Confirm no VID table was built:
ls /sys/class/drm/card0/device/hwmon/hwmon*/in0_min
These files are created only when vid_nr > 0. Their absence is the
signature of this bug.
3. Force a real pstate transition (re-requesting the current state is
silent and looks like success):
sudo sh -c 'echo 0f > /sys/kernel/debug/dri/0000:01:00.0/pstate'
4. Read dmesg for the lines above.

Do not judge by the pstate file: it prints '*' against the target even
when the apply failed. dmesg is the only reliable indicator. Also note
"volt: VID" lines are nvkm_debug and invisible at the default loglevel.

ROOT CAUSE
The vBIOS voltage table (BIT 'P' +0x0c -> 0x85e6 here) is version 0x50 with
its flag byte at +0x04 set to 0x01, so nvbios_volt_parse() classifies it as
NVBIOS_VOLT_PWM and reads pwm_freq/pwm_range, leaving vidmask, step and
ranged at zero.

The board has no DCB_GPIO_VID_PWM (tag 0x81) entry at all. It drives the
regulator through three VID GPIO lines (VID_0 line 11, VID_1 line 5,
VID_2 line 6). gk104_volt_new() notices and falls back to GPIO mode - that
is the "Type mismatch" message - but the table has already been parsed as
PWM. This does two separate pieces of damage:

1. In nvkm_volt_parse_bios(), both VID-building branches are gated on
info.vidmask, which is 0, so neither runs and vid_nr stays 0.
nvkm_volt_set() can then satisfy no request at all - hence the identical
-22 whichever voltage is asked for.

2. The PWM branch also sets volt->max_uv = info.base + info.pwm_range,
which here is 306250 + 6250 = 312500 uV. nvkm_cstate_new() rejects any
cstep whose nvkm_volt_map_min() exceeds max_uv, and every cstep on this
card needs more than 0.3125 V, so all of them are dropped and
pstate->list is left empty. nvkm_cstate_prog() then falls back to
&pstate->base. That is why the two requests above are exactly the PERF
table's base voltages (pstate 07 -> vmap id 49 -> 837500 uV;
pstate 0f -> vmap id 56 -> 887500 uV) rather than any cstep's.

The data needed is present in the ROM but never read. The 8 entries start
at table+hdr = 0x8601:

00 43 00 80 / 01 44 80 80 / 02 45 00 81 / 03 46 80 81 /
04 47 00 82 / 05 48 80 82 / 06 49 00 83 / 07 4a 80 83

i.e. { vid:u8, voltage:u8 in 12.5 mV units, unk:u16 }, decoding to
837500..925000 uV for vid 0..7 - a monotonic 12.5 mV ladder, and exactly
the voltages the clock code asks for. nvbios_volt_entry_parse() has
"case 0x50: break;", a deliberate no-op, so those rows are skipped.
envytools' nvbios does not decode them either; it prints all four bytes of
each entry as a single "unk" u32.

Also ruled out: this is not missing headroom. BOOST v11 gives pstate f a
max of 1701 MHz shader (~850 MHz core, the card's rated clock) and CSTEP
v10 a 33-step 540..1690 MHz ladder. And there is no voltage-related
nouveau.config option in this build to work around it.

WHAT I CHANGED LOCALLY (to confirm the diagnosis, not as a proposed fix)
Three files:
- bios/volt.h: carry the GPIO-mode fields alongside a PWM-flagged table.
- bios/volt.c: populate them when parsing a v0x50 PWM table, and implement
case 0x50 in nvbios_volt_entry_parse() with the layout above, trusting
the decode only when the voltage lands inside the table's own min/max.
- volt/base.c: in nvkm_volt_parse_bios(), when the table is PWM-flagged
and nvkm_gpio_find() finds no DCB_GPIO_VID_PWM, re-interpret it as GPIO
before building the VID list.

The GPIO re-interpretation is a guess about intent and the min/max guard is
a heuristic. I can send the diff if it is useful.

RESULTS
An 8-entry VID table (837500..925000 uV) is built and reclocking works.
pstate 0f applies core 645 MHz / memory 1800 MHz at 925 mV.

glmark2 2023.01, Wayland, 800x600 windowed, same session and binary
throughout. pstate 07 is the clock state stock nouveau is stuck in, so this
measures what the bug costs:

pstate 07 (405/810 MHz, 862 mV) Score 944 peak 63 C
pstate 0f (645/1800 MHz, 925 mV) Score 1993 peak 73 C (+111%)

glmark2-es2 at pstate 0f scores 2061. Memory-bound tests gain most:
terrain 43 -> 86 FPS, refract 103 -> 243, desktop-blur 220 -> 492.

Clocks held pstate 0f for 100% of the run, peak 73 C against a 95 C limit.
Transitions 0f -> 07 -> 0f were clean, no GPU hang, compositor survived,
and no new nouveau kernel messages during any run.

Core tops out at 645 MHz rather than the 850 MHz the boost ladder implies,
and this is not a second bug: the ceiling is the top VID, 925000 uV.
nvkm_cstate_find_best() walks down from cstep 33 and stops at cstep 15
(1290 MHz shader = 645 MHz core), whose vmap id 34 evaluates to
887500 + 37500 = exactly 925000 uV. The next cstep up needs more than this
3-bit VID GPIO regulator has wired.

QUESTIONS
- How widespread is this? The combination is "v0x50 voltage table flagged
PWM + no DCB_GPIO_VID_PWM + VID GPIOs wired" - plausibly other Kepler
mobile parts, but I have only the one board.
- What is the right fix: re-interpreting the table as GPIO when the VID_PWM
GPIO is absent, implementing the entry-parse path alone, or catching the
contradiction somewhere earlier?
- Is the { vid, voltage*12.5mV, unk } entry layout documented anywhere?
- Would a warning when vid_nr ends at 0 with a voltage table present be
worth having? Today the only symptom is -EINVAL from every pstate, which
reads like a clock problem rather than a parsing one.

I can supply the vBIOS dump (93696 bytes) and full dmesg on request.


Regards,
Shane Ayerst

--000000000000e75c77065bc2acde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div dir=3D"auto">Hi All :)</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">This is a bug report, not a patch submission. Cl=
aude Code was used to assist with the but triage and fix. I did patch a loc=
al build to<br>confirm the diagnosis and I describe it below, but I have on=
ly this one board<br>and no view of how a real fix should be shaped, so I a=
m not proposing one.<br><br>HARDWARE<br>  NVIDIA GK107GLM [Quadro K1000M], =
10de:0ffc rev a1, subsystem 103c:176b<br>  (HP mobile workstation). Single =
GPU, no iGPU.<br>  Kernel 7.2.5 (Arch), in-tree nouveau. Mesa 26.2.2.<br><b=
r>SYMPTOM<br>  Every reclock fails with -EINVAL; the card is pinned at core=
 405 MHz /<br>  memory 810 MHz for the life of the boot. Each pstate asks f=
or a different<br>  voltage and gets the identical error:<br><br>    nouvea=
u 0000:01:00.0: volt: couldn&#39;t set 837500uv<br>    nouveau 0000:01:00.0=
: clk: failed to raise voltage: -22<br>    nouveau 0000:01:00.0: clk: error=
 setting pstate 0: -22<br><br>    nouveau 0000:01:00.0: volt: couldn&#39;t =
set 887500uv<br>    nouveau 0000:01:00.0: clk: failed to raise voltage: -22=
<br>    nouveau 0000:01:00.0: clk: error setting pstate 1: -22<br><br>  Ear=
lier in the boot log:<br><br>    nouveau 0000:01:00.0: volt: Type mismatch =
between the voltage table type<br>                               and the GP=
IO table. Fallback to GPIO mode.<br><br>TO REPRODUCE<br>  1. Boot the affec=
ted card on nouveau.<br>  2. Confirm no VID table was built:<br>       ls /=
sys/class/drm/card0/device/hwmon/hwmon*/in0_min<br>     These files are cre=
ated only when vid_nr &gt; 0. Their absence is the<br>     signature of thi=
s bug.<br>  3. Force a real pstate transition (re-requesting the current st=
ate is<br>     silent and looks like success):<br>       sudo sh -c &#39;ec=
ho 0f &gt; /sys/kernel/debug/dri/0000:01:00.0/pstate&#39;<br>  4. Read dmes=
g for the lines above.<br><br>  Do not judge by the pstate file: it prints =
&#39;*&#39; against the target even<br>  when the apply failed. dmesg is th=
e only reliable indicator. Also note<br>  &quot;volt: VID&quot; lines are n=
vkm_debug and invisible at the default loglevel.<br><br>ROOT CAUSE<br>  The=
 vBIOS voltage table (BIT &#39;P&#39; +0x0c -&gt; 0x85e6 here) is version 0=
x50 with<br>  its flag byte at +0x04 set to 0x01, so nvbios_volt_parse() cl=
assifies it as<br>  NVBIOS_VOLT_PWM and reads pwm_freq/pwm_range, leaving v=
idmask, step and<br>  ranged at zero.<br><br>  The board has no DCB_GPIO_VI=
D_PWM (tag 0x81) entry at all. It drives the<br>  regulator through three V=
ID GPIO lines (VID_0 line 11, VID_1 line 5,<br>  VID_2 line 6). gk104_volt_=
new() notices and falls back to GPIO mode - that<br>  is the &quot;Type mis=
match&quot; message - but the table has already been parsed as<br>  PWM. Th=
is does two separate pieces of damage:<br><br>  1. In nvkm_volt_parse_bios(=
), both VID-building branches are gated on<br>     info.vidmask, which is 0=
, so neither runs and vid_nr stays 0.<br>     nvkm_volt_set() can then sati=
sfy no request at all - hence the identical<br>     -22 whichever voltage i=
s asked for.<br><br>  2. The PWM branch also sets volt-&gt;max_uv =3D info.=
base + info.pwm_range,<br>     which here is 306250 + 6250 =3D 312500 uV. n=
vkm_cstate_new() rejects any<br>     cstep whose nvkm_volt_map_min() exceed=
s max_uv, and every cstep on this<br>     card needs more than 0.3125 V, so=
 all of them are dropped and<br>     pstate-&gt;list is left empty. nvkm_cs=
tate_prog() then falls back to<br>     &amp;pstate-&gt;base. That is why th=
e two requests above are exactly the PERF<br>     table&#39;s base voltages=
 (pstate 07 -&gt; vmap id 49 -&gt; 837500 uV;<br>     pstate 0f -&gt; vmap =
id 56 -&gt; 887500 uV) rather than any cstep&#39;s.<br><br>  The data neede=
d is present in the ROM but never read. The 8 entries start<br>  at table+h=
dr =3D 0x8601:<br><br>    00 43 00 80 / 01 44 80 80 / 02 45 00 81 / 03 46 8=
0 81 /<br>    04 47 00 82 / 05 48 80 82 / 06 49 00 83 / 07 4a 80 83<br><br>=
  i.e. { vid:u8, voltage:u8 in 12.5 mV units, unk:u16 }, decoding to<br>  8=
37500..925000 uV for vid 0..7 - a monotonic 12.5 mV ladder, and exactly<br>=
  the voltages the clock code asks for. nvbios_volt_entry_parse() has<br>  =
&quot;case 0x50: break;&quot;, a deliberate no-op, so those rows are skippe=
d.<br>  envytools&#39; nvbios does not decode them either; it prints all fo=
ur bytes of<br>  each entry as a single &quot;unk&quot; u32.<br><br>  Also =
ruled out: this is not missing headroom. BOOST v11 gives pstate f a<br>  ma=
x of 1701 MHz shader (~850 MHz core, the card&#39;s rated clock) and CSTEP<=
br>  v10 a 33-step 540..1690 MHz ladder. And there is no voltage-related<br=
>  nouveau.config option in this build to work around it.<br><br>WHAT I CHA=
NGED LOCALLY (to confirm the diagnosis, not as a proposed fix)<br>  Three f=
iles:<br>   - bios/volt.h: carry the GPIO-mode fields alongside a PWM-flagg=
ed table.<br>   - bios/volt.c: populate them when parsing a v0x50 PWM table=
, and implement<br>     case 0x50 in nvbios_volt_entry_parse() with the lay=
out above, trusting<br>     the decode only when the voltage lands inside t=
he table&#39;s own min/max.<br>   - volt/base.c: in nvkm_volt_parse_bios(),=
 when the table is PWM-flagged<br>     and nvkm_gpio_find() finds no DCB_GP=
IO_VID_PWM, re-interpret it as GPIO<br>     before building the VID list.<b=
r><br>  The GPIO re-interpretation is a guess about intent and the min/max =
guard is<br>  a heuristic. I can send the diff if it is useful.<br><br>RESU=
LTS<br>  An 8-entry VID table (837500..925000 uV) is built and reclocking w=
orks.<br>  pstate 0f applies core 645 MHz / memory 1800 MHz at 925 mV.<br><=
br>  glmark2 2023.01, Wayland, 800x600 windowed, same session and binary<br=
>  throughout. pstate 07 is the clock state stock nouveau is stuck in, so t=
his<br>  measures what the bug costs:<br><br>    pstate 07 (405/810 MHz, 86=
2 mV)    Score  944    peak 63 C<br>    pstate 0f (645/1800 MHz, 925 mV)   =
Score 1993    peak 73 C   (+111%)<br><br>  glmark2-es2 at pstate 0f scores =
2061. Memory-bound tests gain most:<br>  terrain 43 -&gt; 86 FPS, refract 1=
03 -&gt; 243, desktop-blur 220 -&gt; 492.<br><br>  Clocks held pstate 0f fo=
r 100% of the run, peak 73 C against a 95 C limit.<br>  Transitions 0f -&gt=
; 07 -&gt; 0f were clean, no GPU hang, compositor survived,<br>  and no new=
 nouveau kernel messages during any run.<br><br>  Core tops out at 645 MHz =
rather than the 850 MHz the boost ladder implies,<br>  and this is not a se=
cond bug: the ceiling is the top VID, 925000 uV.<br>  nvkm_cstate_find_best=
() walks down from cstep 33 and stops at cstep 15<br>  (1290 MHz shader =3D=
 645 MHz core), whose vmap id 34 evaluates to<br>  887500 + 37500 =3D exact=
ly 925000 uV. The next cstep up needs more than this<br>  3-bit VID GPIO re=
gulator has wired.<br><br>QUESTIONS<br>  - How widespread is this? The comb=
ination is &quot;v0x50 voltage table flagged<br>    PWM + no DCB_GPIO_VID_P=
WM + VID GPIOs wired&quot; - plausibly other Kepler<br>    mobile parts, bu=
t I have only the one board.<br>  - What is the right fix: re-interpreting =
the table as GPIO when the VID_PWM<br>    GPIO is absent, implementing the =
entry-parse path alone, or catching the<br>    contradiction somewhere earl=
ier?<br>  - Is the { vid, voltage*12.5mV, unk } entry layout documented any=
where?<br>  - Would a warning when vid_nr ends at 0 with a voltage table pr=
esent be<br>    worth having? Today the only symptom is -EINVAL from every =
pstate, which<br>    reads like a clock problem rather than a parsing one.<=
br><br>I can supply the vBIOS dump (93696 bytes) and full dmesg on request.=
<br></div></div><br><br><div data-smartmail=3D"gmail_signature"><div dir=3D=
"ltr"><div>Regards,</div>Shane Ayerst<br><br></div></div></div>

--000000000000e75c77065bc2acde--
