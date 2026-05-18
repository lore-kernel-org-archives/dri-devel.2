Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC14CD4F48
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45FFC10E2E8;
	Mon, 18 May 2026 07:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="mg7S4DdU";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9745C10E2E8
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nG
 SgpaIBk8nLNUChGbs1Wkv6iohQmuUEhuRd5jny1pg=; b=mg7S4DdUTca+aU45q1
 m5RqCAZDzZIEM2B2Kkc+fqMjAfgWBPHakO9X3HKxAZeGthCh2xnrDyFRiEu52FEY
 gR4eEwgEnlOLJ+MMEWy9e+3CbhyQc+qN+WpYwFkJ87hTvBYJS/wt7bh6Ey7apgLF
 kUavFYhnPtvryJTbHKbZl/NWc=
Received: from 163.com (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD3f8gYvQpqmkBDCA--.6152S2; 
 Mon, 18 May 2026 15:17:52 +0800 (CST)
From: w15303746062@163.com
To: zack.rusin@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] drm/vmwgfx: Fix hrtimer interrupt storm due to 0-period vblank
Date: Mon, 18 May 2026 15:17:41 +0800
Message-Id: <20260518071741.441794-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3f8gYvQpqmkBDCA--.6152S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4UKF15tF15KFyDCrW5Awb_yoW5ArWfpr
 WDKr9rtr1jyFW2ga9rAwn3uFn5Wws5GFy7tFZ7KwnrZw4qkFy7A3WrKF45KFy7Cr4DA3yI
 qF48Jrs8uF4jkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeSoXUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wCUeGoKvSCBLwAA3c
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

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

When vmwgfx is configured to use VKMS for vblank simulation, it relies
on drm_calc_timestamping_constants() to calculate the frame duration
(vblank->framedur_ns).

However, Fuzzers (like Syzkaller) can submit extremely malicious
display modes through DRM_IOCTL_MODE_SETCRTC. If the user-space passes
a mode with a massive pixel clock (crtc_clock) and small resolution
(htotal/vtotal), the integer division in drm_calc_timestamping_constants()
truncates the result to 0.

Consequently, vmw_vkms_enable_vblank() blindly sets the hrtimer period
to 0. When the timer is started, it fires instantly and continuously.
Because hrtimer_forward_now() cannot advance time for a 0-period,
the overrun value skyrockets, locking the CPU in an infinite hard-IRQ
loop (vkms_vblank_simulate() -> HRTIMER_RESTART).

This completely starves the CPU, leading to massive RCU stalls and
blocking other essential tasks (like jbd2 and writeback workers)
indefinitely:

  [ C1] vkms_vblank_simulate: vblank timer overrun
  ...
  INFO: task kworker/u18:2:50 blocked for more than 143 seconds.
  Workqueue: writeback wb_workfn (flush-8:0)
  Call Trace:
   <TASK>
   __schedule+0x1044/0x5bb0
   wbt_wait+0x1c8/0x3b0
   blk_mq_submit_bio+0x29fa/0x31f0
   submit_bio_noacct+0xca7/0x1f90
   ext4_bio_write_folio+0x95a/0x1d10
   ...

  NMI backtrace for cpu 1
  Call Trace:
   <IRQ>
   vkms_vblank_simulate+0x8f/0x390
   __hrtimer_run_queues+0x1f5/0xb30
   hrtimer_interrupt+0x39a/0x880

Fix this DoS vulnerability by adding a defensive sanity check in
vmw_vkms_enable_vblank() to reject a 0-ns frame duration, allowing
DRM core to gracefully fallback/reject the mode without crashing.

Fixes: cd2eb57df1b8 ("drm/vmwgfx: Implement virtual kms")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 5abd7f5ad2db..b3950ae424f3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -288,6 +288,16 @@ vmw_vkms_enable_vblank(struct drm_crtc *crtc)
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
 
+	/*
+	 * DEFENSIVE CHECK:
+	 * drm_calc_timestamping_constants() can calculate a framedur_ns
+	 * of 0 if user-space provides a malicious mode with a huge
+	 * crtc_clock and small htotal/vtotal due to integer division
+	 * truncation. Prevent hrtimer interrupt storms by refusing such modes.
+	 */
+	if (WARN_ON_ONCE(vblank->framedur_ns == 0))
+		return -EINVAL;
+
 	hrtimer_setup(&du->vkms.timer, &vmw_vkms_vblank_simulate, CLOCK_MONOTONIC,
 		      HRTIMER_MODE_REL);
 	du->vkms.period_ns = ktime_set(0, vblank->framedur_ns);
-- 
2.34.1

