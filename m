Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC00CCA464
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 793081122E3;
	Thu, 15 Oct 2026 16:15:14 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id C096410E131;
 Thu, 15 Oct 2026 12:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=fZ3FRe0Ls/JmWf3OG+4EyMsl/OFlCN8EX07ivX4RHCw=; b=k2xEWgrAWuAYZ
 CSBhGZcEFBE2dsrBrn9iYtTeEesZLAjfaPZjpbIfH9pJuXCu6o4JXBdrj/g0jzgg
 HDoVCJgNUzCyKwVcEZE3XQ9fnTjQQE7Q66gDs/H/vN0fblp1dbHpjbOIYdUNBeEG
 dYFOIgF56VRfhx+qBYWKrZwNPFiI14=
Received: from [127.0.1.1] (unknown [114.214.188.229])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgA3IBddxdBqXUL1AQ--.1300S2;
 Thu, 15 Oct 2026 20:21:49 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 dmitry.baryshkov@oss.qualcomm.com, neil.armstrong@linaro.org,
 abelvesa@kernel.org, mitltlatltl@gmail.com
Subject: [REPORT v2] SM8750 bonded dual-DSI + NT36536: the command-DMA-timeout
 signature is not the invariant;
 dark panel is not recoverable in software
Date: Thu, 15 Oct 2026 20:21:48 +0800
Message-ID: <179206690897.1177097.7309368787214649515@mail.ustc.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CM-TRANSID: 3pYKCgA3IBddxdBqXUL1AQ--.1300S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW5tr4fAFykZF4rCw1Utrb_yoWfAr4rpF
 Z7KwsIkrWkJryxu3Z7Ar4UX34jyrsYyrZ8tas8KryUAan8GryIvr92kw4q9a45Wrn5Ja1j
 qFZ0qas3Za1kZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgcTQUUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREBB2rQE4plRABDsX
X-Mailman-Approved-At: Thu, 15 Oct 2026 16:15:09 +0000
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

This is a follow-up to our 2026-10-13 report on the same board.  We have since
run controlled single-variable experiments that force us to *correct* the
diagnosis in that report, and we think the corrected picture is more useful to
you.  Summary of what changed:

  - the "first DCS command-DMA timeout" (-110) is NOT the invariant.  We built
    an image that removes that signature entirely, and the panel still does not
    light up.
  - the failure is NOT a driver-side latch that could be cleared.  We built an
    image with a bounded retry instead of the permanent latch, and the retry
    does happen - the panel still does not light up.
  - the failure is NOT recoverable by re-running the modeset.  Restarting the
    compositor (which re-runs panel prepare + full atomic commit) while in the
    bad state fails again exactly the same way.

So we now believe the bad state is a *persistent hardware/power-domain* state
that survives everything we can reach from the DSI/DRM side, and that the
-110 message is a symptom rather than the root cause.  Details and evidence
below; questions at the end.

BOARD / SETUP

Lenovo Legion Y700 (2025), TB322FC, Qualcomm SM8750P.  Panel Novatek NT36536,
1904x3040, DSC, video mode, driven by bonded dual DSI (ae94000.dsi master,
ae96000.dsi peer).  Our tree is GEEKiDOS/linux (7.2-based) plus the bonded
command path; we have since rebased onto 7.3-rc7 and reproduced everything
there, so the observations below are not specific to the 7.2 tree.

All samples below are *cold* boots (power off -> bootloader -> boot).  We do not
use warm resets for these measurements: a warm reset does not clear the DSI
PHY/PLL state, and after a failure a warm reset tends to reproduce a
*different* failure mode (no card0 at all), which makes it useless for A/B
comparison.  Every sample quoted here is a real power-off.

1) THE -110 SIGNATURE IS NOT THE INVARIANT

   We built an image whose only difference is that the vendor bonded command
   write path is disabled, so DCS goes through the standard need_sync double
   write (dsi_manager.c, 3 hunks, single file).  Same config, DTB, ramdisk and
   cmdline, verified byte-identical; same UTS.

   Result on its bad boots: "command DMA timeout" 0 occurrences, "bonded
   command DMA failed" 0 occurrences, "Failed to initialize panel" 0
   occurrences, panel init reports success ("panel prepared").  The DPU side is
   fine too (crtc active, compositor renders, a framebuffer readback from the
   compositor contains real content, DPU frame counters advance).

   And the panel is *still dark*.  Confirmed by eye on the physical device:
   backlight on, power key controls the backlight, volume keys and audio work,
   but there is no image.

   So: removing the bonded command path removes the DMA-timeout message and
   does not fix the panel.  -110 and "panel dark" are separable.

   (Measurements that are "all normal" while the panel is dark, on this board:
   card0-DSI-1 status "connected", DPMS "On", connector "enabled", backlight
   non-zero and controllable, disp_cc_mdss_pclk0/1_clk_src = 172991986 Hz
   claimed by ae94000.dsi/ae96000.dsi, byte clocks claimed, crtc intf_mode 2,
   compositor screenshots succeed.  The only quantity we found that tracks the
   physical state is the DSI interrupt count: 41 when the panel is lit, 0 in
   every dark case.  We mention this because it cost us a false "GOOD" verdict:
   screenshots and frame counters prove the DPU is running, not that the panel
   received valid video.)

2) THE FAILURE IS NOT A DRIVER LATCH

   The tree latches a single bonded-command failure permanently
   (dsi_bonded_cmd_failed is only ever set true) and several bridge callbacks
   early-return on that latch, including power_off/post_disable - so after one
   failure the teardown is skipped as well.  That looked like a plausible
   "unrecoverable by construction" mechanism, so we changed exactly that, in
   two orthogonal ways, single file:

     (a) latch only after a bounded number of failures (3) instead of the
         first one, logging each attempt;
     (b) drop the cmd_failed() early-returns from power_off / pre_enable /
         post_disable so the normal teardown and re-power-up always run.

   On a bad boot the new log shows the retry budget working:

     dsi: bonded command failure 1/3 (command DMA timeout), will retry
     dsi: bonded command failure 2/3 (panel not prepared), will retry

   and "giving up" never appears - i.e. the latch never engages.  The teardown
   is no longer skipped.  The panel is *still dark*.

   Worth noting for the general case: making the failure non-fatal is necessary
   but not sufficient, because nothing re-issues the modeset afterwards.
   drm_panel_prepare() runs once per atomic commit, and after the failure no
   new commit is generated, so even a "retryable" error does not actually get
   retried.  We only got a second attempt by forcing one (next section).

3) THE STATE IS NOT RECOVERABLE BY RE-RUNNING THE MODESET

   While in the bad state we restarted the session (stop greetd, kill phoc,
   start greetd), which releases DRM master and produces a fresh atomic commit
   and a fresh modeset.  The compositor did restart (process count 1 -> 2), so
   the retry genuinely happened.  Result:

     before: panel_prepared 0, dsi interrupts 0, ctl reset failure 268
     after : panel_prepared 0, dsi interrupts 0, ctl reset failure 394

   i.e. the second attempt failed in exactly the same way, and the panel stayed
   dark (confirmed by eye).

   Control, to be fair to the mechanism: the *same* operation on a healthy boot
   is harmless - panel stays lit, DSI interrupts stay at 41, no new errors.  So
   re-running a modeset does not break a working link; it just cannot repair a
   failed one.

4) WHERE WE THINK THIS LEAVES US

   Combining 1-3: neither the command path, nor the driver latch, nor the
   modeset re-entry is the lever.  The bad state appears to be established
   during the first bring-up and to persist, and the DSI controller does not
   appear to be where it lives.  Consistent with your earlier suggestion we
   also checked the PHY clock-source selection (DSI_7nm_PHY_CMN_CLK_CFG1
   DSICLK_SEL and the resulting disp_cc_mdss_pclk*_clk_src): our tree already
   selects SEL=0 / pll_bit for this 30bpp 3-lane C-PHY case, matching the
   downstream driver, and the resulting pclk is correct (756839941/2 * 16/35 =
   172991986 Hz, matching the measured clock exactly).  So that particular
   select is not the gap on this board.

   What we can still see from the DSI registers, on a bad boot, is that
   CLK_STATUS ends up with the DYN_PCLK / DYN_CMD_PCLK bits set together with
   CMD_PCLK, STATUS0 = 0x20003 (engine|DMA busy), no DSI interrupts, and the
   pre-first-command registers are byte-identical to a good boot.  On the DPU
   side we get "hw recovery is not complete for ctl:1"
   (dpu_hw_ctl.c:459, i.e. the CTL soft reset never completes) repeated, with
   "ctl 1 reset failure: -22" and vblank/frame-done timeouts - but we read that
   as a downstream consequence, not a separate fault.

QUESTIONS

1. Given that the -110 command-DMA timeout can be made to disappear while the
   panel stays dark, is the DYN_PCLK / DYN_CMD_PCLK request handshake between
   DSI and dispcc/INTF supposed to be released by the client side?  Is there a
   known ordering requirement on SM8750 for the *first* command after PHY
   enable / PLL lock?  (Our engine latches with STATUS0 = 0x2200200 and the
   trigger never self-clears.)

2. Is there anything we can inspect outside the DSI register block to tell
   whether the pixel-clock domain actually came up - a dispcc/INTF status, a
   vote we can read back, or a documented way to distinguish "request
   asserted" from "request serviced"?  We cannot read MMIO directly from
   userspace here (STRICT_DEVMEM), so a driver-side suggestion would help.

3. Do you know of any SM8750 (or SM8650-family) erratum for cold-boot
   video-mode DSC bring-up on bonded DSI that would put the link into a state
   that only a full SoC reset clears?  We have ruled out the PLL re-lock series
   (6cd33b6f4155, 2028280686f4) as far as we can tell from the symptom.

4. Should a failure like this be surfaced differently by the driver?  Right now
   the failure is reported and then the panel is simply never prepared, while
   everything else reports success (connector connected, DPMS on, compositor
   fine).  If there is a preferred upstream shape for "panel init failed, do
   not pretend the output is up", we would rather implement that than keep
   experimenting locally.

5. Would you like the capture set?  We have full dmesg from lit and dark boots,
   the DSI/PHY register dumps, CLK_STATUS transitions, the probe scripts
   (cold-boot runner, three-state classifier) and both experimental patches
   (command-path removal, bounded retry + non-short-circuited teardown).  Happy
   to send any subset, and happy to test a patch on the device.

Thanks,
Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>

The bring-up tree is GEEKiDOS/linux plus local patches.  We can publish the
repro scripts and the failing-boot captures, and we can run any experiment you
suggest on the hardware.

