Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE2FCD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23EC310E16A;
	Sat, 23 May 2026 02:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="JgmS8NBN";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3990410E16A
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iZ
 Q+09JvOw3FhUhCj63h5crYb6sZ7MTeftkWrJHDQkE=; b=JgmS8NBNb/vhbstIKo
 2AvacCfgxIHZMBg/6gjFgDeORXUguI/FLSXz9Ms+fT7+9+uxruxhLV0b1kTMEAQr
 vYR1/GKGgdEhbUmswXSI8N00I3Oart58+8SG7YtzRFHq9CIM1DHbZLTELlok6DaD
 ms3Dx2im/Zae2ZqJazviSdI3g=
Received: from 163.com (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wCn74P5FhFqeFviCw--.57260S2; 
 Sat, 23 May 2026 10:55:05 +0800 (CST)
From: w15303746062@163.com
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2] drm/vblank: Reject 0-period timers to prevent hrtimer storm
Date: Sat, 23 May 2026 10:54:47 +0800
Message-Id: <20260523025447.581709-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fa91ccc0-7660-44fc-92a8-ab569ebe3a7c@suse.de>
References: <fa91ccc0-7660-44fc-92a8-ab569ebe3a7c@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCn74P5FhFqeFviCw--.57260S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4UKry7tF4xZw1rur47CFg_yoW5JF1kpr
 s7Gryayry0yF4agFnrA3Z3ZFyFkasYqF4xKFyDGw43Aw1DKFy2yr1FkFW3KF47GrsrAw4a
 q3Z3XF4ruas8CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5EfOUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-wmmimoRFwmBcQAA3P
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

Fuzzers like Syzkaller can submit extremely malicious display modes
through DRM_IOCTL_MODE_SETCRTC. If userspace passes a mode with a
massive pixel clock (crtc_clock) and small resolution (htotal/vtotal),
the integer division in drm_calc_timestamping_constants() truncates
the resulting frame duration (vblank->framedur_ns) to 0.

When virtual display drivers (such as vmwgfx or vkms) rely on the DRM
core's software vblank simulation, drm_crtc_vblank_start_timer() is
called. It blindly converts this 0-ns framedur_ns into a ktime interval
and starts the hrtimer. An hrtimer with a 0-period fires instantly and
continuously. Since hrtimer_forward_now() cannot advance time for a
0-period, the CPU gets locked in an infinite hard-IRQ loop, starving
the system and causing massive RCU stalls.

Fix this DoS vulnerability by adding a defensive sanity check in
drm_crtc_vblank_start_timer() to reject a 0-ns frame duration, allowing
the DRM core to gracefully reject the malicious mode.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v2:
- Moved the defensive check from vmwgfx to drm_vblank.c. The timer
  logic was refactored into the DRM core, so placing the check here
  protects all drivers relying on the core software vblank timer.
- Dropped WARN_ON_ONCE() to prevent unprivileged userspace from easily
  triggering kernel panics on systems with panic_on_warn enabled.

 drivers/gpu/drm/drm_vblank.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e42..b38d0b30a651 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2241,6 +2241,16 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
 
+	/*
+	 * DEFENSIVE CHECK:
+	 * drm_calc_timestamping_constants() truncates framedur_ns to 0 if
+	 * userspace provides a malicious mode with a huge crtc_clock and
+	 * small htotal/vtotal. Prevent an infinite hard-IRQ loop from a
+	 * 0-period hrtimer by rejecting such modes.
+	 */
+	if (unlikely(vblank->framedur_ns == 0))
+		return -EINVAL;
+
 	spin_lock_irqsave(&vtimer->interval_lock, flags);
 	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
 	spin_unlock_irqrestore(&vtimer->interval_lock, flags);
-- 
2.34.1

