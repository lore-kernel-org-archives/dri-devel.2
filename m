Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE18CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A7F10F5C6;
	Tue, 13 Oct 2026 07:53:35 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.36 at gabe;
 Tue, 13 Oct 2026 00:01:00 UTC
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 78C0710E60E;
 Tue, 13 Oct 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=CJfL06JPdyNUgB9rTGyzWBVI5MtskF8eKsFORIWNw/I=; b=e27yedtCSGZMT
 yCluQzr0AqY642aF59c3nguLqTCHBf/XL+SzvZdZq5biMAh016vZO8b4XoEtxvSV
 hfDPjyo0pFUFZ7op+HLyKjYEpGjQ4o3Q6GqU56dufHcU9nOPyBk5Tdup5Hgy2bhu
 tHDxAUw/pgNbnOmO0A0T9TFjNfMgtE=
Received: from [127.0.1.1] (unknown [114.214.192.228])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgC3ohkPc81qcXzcAQ--.944S2;
 Tue, 13 Oct 2026 07:53:51 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 dmitry.baryshkov@oss.qualcomm.com, neil.armstrong@linaro.org,
 abelvesa@kernel.org, mitltlatltl@gmail.com
Subject: [REPORT] SM8750 bonded dual-DSI + NT36536: first DCS command-DMA
 timeout on cold boot (DMA engine stays latched; DSI-side reset does not clear
 it)
Date: Tue, 13 Oct 2026 07:53:51 +0800
Message-ID: <179184923104.248043.14168731037113716140@mail.ustc.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CM-TRANSID: 3pYKCgC3ohkPc81qcXzcAQ--.944S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFykKw15CrWrZFyxZr4fKrg_yoWxZF45pF
 WDtwnxCr4kJF1093Z2yw1UWry0qanYyayUJr98Kry8Aa15WF1vvrWIyFyvyayakrn3Xa1Y
 qFZYg3WrWF1YyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
 W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bYYLPUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARESB2rMHwl7FAAms8
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

Hi,

We are bringing up a Lenovo Legion Y700 (2025) tablet, TB322FC / Qualcomm
SM8750P, with a Novatek NT36536 panel (1904x3040, DSC, video mode) driven by
bonded dual DSI (ae94000.dsi master, ae96000.dsi peer).  Our tree is
GEEKiDOS/linux, a 7.2-based tree that carries the bonded command path
(dsi_mgr_bonded_cmd_xfer() plus the "bonded command DMA failed" / "peer command
DMA timeout" messages).  We could not find that path in the vanilla 7.2 sources
we compared against, so question 1 is partly whether it is upstream-supported
at all.

SYMPTOM

On a *cold* boot (power off -> bootloader -> fastboot boot <image>) the very
first DCS command of the panel init intermittently times out and the panel is
never enabled.  Warm reboots do not reproduce this signature (a warm reboot
reproducibly ends up in mode (b) below); all three modes are cold-boot only.
Signature, identical in all failing samples:

  [    9.032148] msm_dsi ae94000.dsi: command DMA timeout: status=0x2200200
  [    9.037910] msm_dsi ae96000.dsi: peer command DMA timeout: status=0x2200200
  [    9.037912] msm_dsi ae94000.dsi: bonded command DMA failed: master=-110 peer=-110
  [    9.037914] panel-novatek-nt36536 ae94000.dsi.0: sending dcs data ff 20 failed: -110
  [    9.096078] panel-novatek-nt36536 ae94000.dsi.0: Failed to initialize panel: -5
  [    9.102187] [drm:dpu_encoder_phys_vid_prepare_for_kickoff:576] [dpu error]enc35 intf1 ctl 1 reset failure: -22
  [   10.176852] msm_dpu ae01000.display-controller: [drm] vblank wait timed out on crtc 0

On a good boot the same step prints "panel prepared: scheduling firmware
upload".  "DSI PLL(0) lock failed" x4 and device-link warnings also appear on
good boots (we treat them as benign noise).

THREE FAILURE MODES, ALL COLD-BOOT ONLY

(a) panel-init timeout with the system up: card0 exists, DSI-1 connected, SSH
    reachable, only backlight - the signature above.  Most common.
(b) no card0 at all (DSI host probe fails earlier).
(c) *new* 2026-10-13: bootloader ACKs the image, but there is no SSH and no
    fastboot at all for 30+ minutes, backlight only.  In this mode the machine
    never reaches userspace, so even an on-device watchdog cannot recover it.

REGISTER-LEVEL EVIDENCE (bad boot, instrumented)

We patched the DSI path to dump state around the failure and to attempt
recovery.  Bad boot, all timestamps in one boot:

  first DCS times out (status=0x2200200)
  before-reset : CTRL=0x175  STATUS0=0x20003  CLK_STATUS=0x3743  CMD_DMA_CTRL=0xd4000000  INTR_CTRL=0x2200200
  after our reset (see below): CTRL=0x0 CLK_CTRL=0x0 CLK_STATUS=0x1403
  after link re-power-on    : CTRL=0x171  STATUS0=0x20003  CLK_STATUS=0x1743  CMD_DMA_CTRL=0x14000000
  retry of the first DCS    : failed: -110 (identical registers, three attempts in a row)

What we did in that window: cleared the driver-side failure latch, powered the
link down and up again (clock rate set, clock enable, PHY reset/re-lock, ctrl
enable), and additionally forced the terminal state of the stock
ctrl_reset() sequence (engines off, CLK_CTRL = 0x00) on both controllers before
re-enabling.  The last step *did* take effect - CLK_STATUS dropped from 0x3743
to 0x1403, i.e. the DYN_PCLK / DYN_CMD_PCLK / CMD_PCLK bits were cleared while
CLK_CTRL was 0 - but as soon as the link is powered on again CLK_STATUS returns
to 0x1743 and STATUS0 stays 0x20003 (ENGINE|DMA busy).

So: the failure is not a state we can clear from inside the DSI controller.  It
looks like the dynamic pixel-clock request is re-asserted during link power-on
and the command engine stays busy; PLL_UNLOCKED is not set (the PLL is locked),
the DSI interrupt counters do not advance while the engine is busy, and the
registers before the first command are byte-identical to those of a good boot.

WHAT WE RULED OUT (controlled, same images)

* Kernel build identity: 2-digit vs 3-digit KBUILD_BUILD_VERSION, same source
  rebuilt, empty-commit / one-line-pr_info arms, 20+ cold boots.  We first
  measured "0 bad / 20+" for 3-digit builds; that window simply contained no
  failure, and the same class of images later failed 4/7.  Pairing #60 against
  a 3-digit arm inside one window showed no measurable identity effect.
* Failures cluster in time: adjacent cold boots fail, and a clean window can
  give 10 good boots in a row.  Rate drifts with session/environment, not with
  the image.
* Upstream 2028280686f4 ("round the byte clock rate after reparenting to the
  PHY PLL"): ported to this tree with upstream semantics (rounding inside
  dsi_link_clk_set_rate_6g(), byte-intf rate from byte_intf_clk_div_2).  First
  cold boot still fails with the identical signature.
* Driver-side recovery: clearing the failure latch and resetting DSI ctrl+PHY
  (both links) + retrying, as described above.
* Forcing the stock ctrl_reset() terminal state (CLK_CTRL = 0x00) before
  re-enabling - the DYN bits come back on power-on (see above).
* Using the standard broadcast command path instead of the tree's custom bonded
  sequence: same hang, different error path.
* Enabling-time dynamic force-on (vendor-style CLK_CTRL force-on around DSI_EN,
  both transient and held for the whole panel-init window): still fails, and the
  DYN bits are latched in the forcing case too.
* ramdisk/initramfs variants, DTB variants, strict 30 s power-off POR: no effect.
* Runtime recovery by rebinding panel / msm_dsi: this tears DRM down (card0
  disappears, fb switches to dummy, GPU hangcheck) instead of recovering.

QUESTIONS

1. Is there a documented ordering requirement for the bonded command path
   (DSI0 master / DSI1 peer) for the *first* DCS after PHY enable / PLL lock?
   Our engine latches with STATUS0 = 0x2200200 and TRIG_DMA never self-clears.
2. Given that a DSI-side reset cannot clear it, is the dynamic pixel-clock
   request supposed to be dropped by the client (dispcc / INTF) side, and is
   there a known issue with that handshake on SM8750?  Should the DSI driver
   wait for the DYN domain to settle before the first command?
3. Should this timeout be recoverable in the driver (reset host/PHY and
   re-issue) instead of failing panel init permanently?  Is there an upstream
   precedent we should follow?
4. Any known SM8750 / DSC video-mode erratum for the first DCS after a cold
   boot?  We looked at the PLL re-lock series (6cd33b6f4155 and 2028280686f4);
   the symptom does not match.
5. Would you like the full dmesg, DSI/PHY register dumps, CLK_STATUS, RPMh
   votes, and our repro scripts, from both a good and a bad boot?  We have both
   and can attach them.

Thanks,
Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>

The bring-up tree is GEEKiDOS/linux plus local patches; we are happy to publish
the repro scripts (cold-boot runner, three-state probe) and the failing-boot
captures if that helps.  Happy to test any patch you suggest on the device.

