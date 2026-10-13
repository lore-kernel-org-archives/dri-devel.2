Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BD3CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 04:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 846AE10E6F5;
	Tue, 13 Oct 2026 04:35:23 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF4C10E714
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:35:17 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6acbdbc1725so3161513a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791866115; cv=none;
 d=google.com; s=arc-20260327;
 b=tBph3gOmWlIovo7RiA9mv7SUnq6jcAyAEGWnZtplv/l3BugBZGnFM1iV4AXfp8tirJ
 eGekF/7vY0/FDAwQGwk2Mz32FLhW28+ly5Z449h3p5Ks2OIM04JhzhIixEdxEv+W/AY3
 pxYjlyHc+bSxdaDhsSOsnCxX2iD4zoIvKYHzX9IuCYhCZ1nekcue8y0UX61JhVvgjCp4
 hkjAMyb4TGL+sC+TaAo/0neRnDiqRm9ag0BkGdEZVrObr1JEbZcC8URmuZAs6UmD0cyo
 awe0bQhocSNInRF/5cWUSrhtbsnRyGhwfQojzRqNJ+v/FvmQwXYFHf7Lb9GSzPFUoGul
 dB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AQdu3Cn6BCMgBdzZkTGzVwhW9c7f9RIM4c7739SyCYs=;
 fh=Egn/RDuB+WEc65oI8heaktMWLmdNi9bgZUK79NLZUnY=;
 b=RTsEai+tHMsbotHK2h0rwdkJjbaYdi5tN0SaJcy2DID4aKn+baJxtvRgV5nvpsYPx2
 qDqLWF3A+hocEldrQCI56NxzyKr+GAY5rtjvAE7sSVrYnJjQ+LQeSKllDkYL3O9mMLhs
 i+KTGgJcZENK6kMUU+jhV++R0/GhgXfkRUGywQSggY5JUZGGfmPxqOsoHhPJNj6IxabI
 1i0hl+Hjcp48LyDWleDU22PD0H9I24zXsVZ4aSsXQkfsnMH4t9KTa79BAAnKfWJwnJHG
 q/5ApLv7Ejgzy+zv43x2cFVERdXZi9kZvZG/Pqs0Mb5NY3uR64H7m+08EdwD04aYseeU
 dtLg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791866115; x=1792470915; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AQdu3Cn6BCMgBdzZkTGzVwhW9c7f9RIM4c7739SyCYs=;
 b=a1fljnNzJPwaSor/KGQfrOPVEPXxmT6i/eUsv0idcYpR8Fv5e9890Zgeeb0l4qXSIJ
 1bXBgqKD/3A1+lb+pX4bi+gKIxtbXxqq/QoU7CsrDeemlpmFNToOYxzabxwFu1KKy/kY
 THrL/rM35jcbKC6O0M1KJUEVHkTT28BiIh3gnUEmm95JbEdP+NpH8gH9L8atj+bqYAPc
 9iXaxxTYHFy8pclUlNkNbM6/wilLvo3OVVV+JhViTwlRtQ6JPlTNF60S2ZvVRswwYyhx
 FfOJEag9TfCVAAYl5n2LPAier8CnxWAt8FL01Tz+AQUr7PpuHJ4UpdzQdVT2l5kYvMNy
 eE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791866115; x=1792470915;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AQdu3Cn6BCMgBdzZkTGzVwhW9c7f9RIM4c7739SyCYs=;
 b=W+XCiPVFImwE3cNrPIAv9c/1dcH/GCdAyLIIOMTGL8qFQxTRsCsqezxt7HfQmi9b2B
 FGCJAetv9NbO0Z7KPOYAMCtd1vtzALwEQ7/PLWxoH5Rry/1UC0w+/1wsdxtgVC3L6L+e
 BQtMNK53qqXspWs7+ueBSsJSmM++yejq3V+cs6TQK3PDs4AnPBPpGWdLY/c4fPCdTql6
 9wc2k1rU1Kq8C1VrmrY/90nyEg81zWGfJ5U2jkUzJtuejuT/qn22VglEI+tl+vjMxlF2
 GIadUjzfMdXDQRZhVN5KPGd1Xgjo2qz1Mb3g7tZNak9vWKQEg2GOKHSoVh1O0yJitsHC
 7PHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsF7CYym9xPrVSjDS5gSZKlE4316schvbVhTiVajYglkMBE0n4Dxnje2MCCJslhx64dkChp9IqFPM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJijou+jFpK3XQOq9BdzMIElrtmZfrkOiM3zU7Gym0qqNeFw63Z
 o8tD2+2TGs8bK2QzVFwwzAFh4hUNIKIUBRzLUi9rU2eIjhqDkDgIRkIWEE3uvpa4PTeEH5lMtrV
 VldF3/w2y4nIqT4tfaRrSnLonPQd0BZA=
X-Gm-Gg: AYBFou1X0JQweAMExYhVmWuzFBTq8t533v/P4CnL8T2/AR1Afrk/CikcSCnI2H+sk2O
 jgYSn6/huOXT5+o/zUh+0lZ82zlMV9/pLJ1WIxfmgn8psP6qQvyfkv1q7EzcZ/pRsh1OV6OIR0U
 zf0xXgAofaii38Jg8VzqQEkBNfwM+H/boX59Sz7vlI+6mOnfOA35IyDkfqfabeOezVTW2FbM3If
 aNjUWGP9t5E23KvEZt9yY+/bPsbcpxfYe3EHS9p1oHR8aRVFDlPSdZIwkccimVWiw09EZEztk5r
 0jx1AxJG8puKjCY4nCRC7mbANdE2ZUm/Rii+d5Xecoqim5g0OLGnKjRF30ZPRvSgnUkDi2uHioB
 kXVGUUgWE2Dqr
X-Received: by 2002:a05:6402:11ca:b0:6aa:f85a:9e06 with SMTP id
 4fb4d7f45d1cf-6b17c25d5b8mr9436534a12.22.1791866114990; Mon, 12 Oct 2026
 21:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <179184923104.248043.14168731037113716140@mail.ustc.edu.cn>
In-Reply-To: <179184923104.248043.14168731037113716140@mail.ustc.edu.cn>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Tue, 13 Oct 2026 12:34:58 +0800
X-Gm-Features: AclHuK9M-oODPL_1kUCPzBH3DIoST7Vl7UTNmToAHGmTMf_5hcJgrvJZBXIrUxM
Message-ID: <CAH2e8h6_pACX_j8YBDhhSZzbfs45waF-Y6KJo82_2c6BT0suEg@mail.gmail.com>
Subject: Re: [REPORT] SM8750 bonded dual-DSI + NT36536: first DCS command-DMA
 timeout on cold boot (DMA engine stays latched;
 DSI-side reset does not clear it)
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, dmitry.baryshkov@oss.qualcomm.com, 
 neil.armstrong@linaro.org, abelvesa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Oct 13, 2026 at 7:53=E2=80=AFAM Qianhui Xu <xiaqinghuan@mail.ustc.e=
du.cn> wrote:
>
> Hi,
>
> We are bringing up a Lenovo Legion Y700 (2025) tablet, TB322FC / Qualcomm
> SM8750P, with a Novatek NT36536 panel (1904x3040, DSC, video mode) driven=
 by
> bonded dual DSI (ae94000.dsi master, ae96000.dsi peer).  Our tree is
> GEEKiDOS/linux, a 7.2-based tree that carries the bonded command path
> (dsi_mgr_bonded_cmd_xfer() plus the "bonded command DMA failed" / "peer c=
ommand
> DMA timeout" messages).  We could not find that path in the vanilla 7.2 s=
ources
> we compared against, so question 1 is partly whether it is upstream-suppo=
rted
> at all.
>

In a word, the panel driver is supported, the DPU may not be.

I think most drivers for dual dsi dual dsc panels in the upstream are
alright, but they may still not work due to the DPU. Once I upstreamed
partial patches, but it is not enough, we need more, like we need to
hack the dsi clk source select for the 10-bit CPHY plane, etc.
Integrating such kind of patch to upstream is time-consuming and
troublesome for me. Even if it works in Ver, nobody would ensure that
it still works in Ver + 0.1, as there would be many features and
regressions for the DPU when promotion.

I cannot help with this for now, sorry about that, I have not focused
on this for a while due to things irl,  You can find some threads in
LKML about 10bpc 10bpp support on DPU discussions that I was involved
in, it may give you some insight. You can also find some records about
bringup, for instance, please check the image in this thread if you
are confused about if it is __really__ supported(i.e.
https://postimg.cc/xJr11DK5, and another snapshot for GPU bringup
https://postimg.cc/0zz30h8P).

Best wishes,
Pengyu

> SYMPTOM
>
> On a *cold* boot (power off -> bootloader -> fastboot boot <image>) the v=
ery
> first DCS command of the panel init intermittently times out and the pane=
l is
> never enabled.  Warm reboots do not reproduce this signature (a warm rebo=
ot
> reproducibly ends up in mode (b) below); all three modes are cold-boot on=
ly.
> Signature, identical in all failing samples:
>
>   [    9.032148] msm_dsi ae94000.dsi: command DMA timeout: status=3D0x220=
0200
>   [    9.037910] msm_dsi ae96000.dsi: peer command DMA timeout: status=3D=
0x2200200
>   [    9.037912] msm_dsi ae94000.dsi: bonded command DMA failed: master=
=3D-110 peer=3D-110
>   [    9.037914] panel-novatek-nt36536 ae94000.dsi.0: sending dcs data ff=
 20 failed: -110
>   [    9.096078] panel-novatek-nt36536 ae94000.dsi.0: Failed to initializ=
e panel: -5
>   [    9.102187] [drm:dpu_encoder_phys_vid_prepare_for_kickoff:576] [dpu =
error]enc35 intf1 ctl 1 reset failure: -22
>   [   10.176852] msm_dpu ae01000.display-controller: [drm] vblank wait ti=
med out on crtc 0
>
> On a good boot the same step prints "panel prepared: scheduling firmware
> upload".  "DSI PLL(0) lock failed" x4 and device-link warnings also appea=
r on
> good boots (we treat them as benign noise).
>
> THREE FAILURE MODES, ALL COLD-BOOT ONLY
>
> (a) panel-init timeout with the system up: card0 exists, DSI-1 connected,=
 SSH
>     reachable, only backlight - the signature above.  Most common.
> (b) no card0 at all (DSI host probe fails earlier).
> (c) *new* 2026-10-13: bootloader ACKs the image, but there is no SSH and =
no
>     fastboot at all for 30+ minutes, backlight only.  In this mode the ma=
chine
>     never reaches userspace, so even an on-device watchdog cannot recover=
 it.
>
> REGISTER-LEVEL EVIDENCE (bad boot, instrumented)
>
> We patched the DSI path to dump state around the failure and to attempt
> recovery.  Bad boot, all timestamps in one boot:
>
>   first DCS times out (status=3D0x2200200)
>   before-reset : CTRL=3D0x175  STATUS0=3D0x20003  CLK_STATUS=3D0x3743  CM=
D_DMA_CTRL=3D0xd4000000  INTR_CTRL=3D0x2200200
>   after our reset (see below): CTRL=3D0x0 CLK_CTRL=3D0x0 CLK_STATUS=3D0x1=
403
>   after link re-power-on    : CTRL=3D0x171  STATUS0=3D0x20003  CLK_STATUS=
=3D0x1743  CMD_DMA_CTRL=3D0x14000000
>   retry of the first DCS    : failed: -110 (identical registers, three at=
tempts in a row)
>
> What we did in that window: cleared the driver-side failure latch, powere=
d the
> link down and up again (clock rate set, clock enable, PHY reset/re-lock, =
ctrl
> enable), and additionally forced the terminal state of the stock
> ctrl_reset() sequence (engines off, CLK_CTRL =3D 0x00) on both controller=
s before
> re-enabling.  The last step *did* take effect - CLK_STATUS dropped from 0=
x3743
> to 0x1403, i.e. the DYN_PCLK / DYN_CMD_PCLK / CMD_PCLK bits were cleared =
while
> CLK_CTRL was 0 - but as soon as the link is powered on again CLK_STATUS r=
eturns
> to 0x1743 and STATUS0 stays 0x20003 (ENGINE|DMA busy).
>
> So: the failure is not a state we can clear from inside the DSI controlle=
r.  It
> looks like the dynamic pixel-clock request is re-asserted during link pow=
er-on
> and the command engine stays busy; PLL_UNLOCKED is not set (the PLL is lo=
cked),
> the DSI interrupt counters do not advance while the engine is busy, and t=
he
> registers before the first command are byte-identical to those of a good =
boot.
>
> WHAT WE RULED OUT (controlled, same images)
>
> * Kernel build identity: 2-digit vs 3-digit KBUILD_BUILD_VERSION, same so=
urce
>   rebuilt, empty-commit / one-line-pr_info arms, 20+ cold boots.  We firs=
t
>   measured "0 bad / 20+" for 3-digit builds; that window simply contained=
 no
>   failure, and the same class of images later failed 4/7.  Pairing #60 ag=
ainst
>   a 3-digit arm inside one window showed no measurable identity effect.
> * Failures cluster in time: adjacent cold boots fail, and a clean window =
can
>   give 10 good boots in a row.  Rate drifts with session/environment, not=
 with
>   the image.
> * Upstream 2028280686f4 ("round the byte clock rate after reparenting to =
the
>   PHY PLL"): ported to this tree with upstream semantics (rounding inside
>   dsi_link_clk_set_rate_6g(), byte-intf rate from byte_intf_clk_div_2).  =
First
>   cold boot still fails with the identical signature.
> * Driver-side recovery: clearing the failure latch and resetting DSI ctrl=
+PHY
>   (both links) + retrying, as described above.
> * Forcing the stock ctrl_reset() terminal state (CLK_CTRL =3D 0x00) befor=
e
>   re-enabling - the DYN bits come back on power-on (see above).
> * Using the standard broadcast command path instead of the tree's custom =
bonded
>   sequence: same hang, different error path.
> * Enabling-time dynamic force-on (vendor-style CLK_CTRL force-on around D=
SI_EN,
>   both transient and held for the whole panel-init window): still fails, =
and the
>   DYN bits are latched in the forcing case too.
> * ramdisk/initramfs variants, DTB variants, strict 30 s power-off POR: no=
 effect.
> * Runtime recovery by rebinding panel / msm_dsi: this tears DRM down (car=
d0
>   disappears, fb switches to dummy, GPU hangcheck) instead of recovering.
>
> QUESTIONS
>
> 1. Is there a documented ordering requirement for the bonded command path
>    (DSI0 master / DSI1 peer) for the *first* DCS after PHY enable / PLL l=
ock?
>    Our engine latches with STATUS0 =3D 0x2200200 and TRIG_DMA never self-=
clears.
> 2. Given that a DSI-side reset cannot clear it, is the dynamic pixel-cloc=
k
>    request supposed to be dropped by the client (dispcc / INTF) side, and=
 is
>    there a known issue with that handshake on SM8750?  Should the DSI dri=
ver
>    wait for the DYN domain to settle before the first command?
> 3. Should this timeout be recoverable in the driver (reset host/PHY and
>    re-issue) instead of failing panel init permanently?  Is there an upst=
ream
>    precedent we should follow?
> 4. Any known SM8750 / DSC video-mode erratum for the first DCS after a co=
ld
>    boot?  We looked at the PLL re-lock series (6cd33b6f4155 and 202828068=
6f4);
>    the symptom does not match.
> 5. Would you like the full dmesg, DSI/PHY register dumps, CLK_STATUS, RPM=
h
>    votes, and our repro scripts, from both a good and a bad boot?  We hav=
e both
>    and can attach them.
>
> Thanks,
> Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
>
> The bring-up tree is GEEKiDOS/linux plus local patches; we are happy to p=
ublish
> the repro scripts (cold-boot runner, three-state probe) and the failing-b=
oot
> captures if that helps.  Happy to test any patch you suggest on the devic=
e.
>
