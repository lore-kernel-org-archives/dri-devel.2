Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E54ECD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 13:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E2B10E188;
	Fri, 15 May 2026 13:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="SCeh9EG0";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 549BD10E1B0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ja
 kKlb9ExpJdgqCHlw9NFJhDcPtPdk/qyu1krp2LcQM=; b=SCeh9EG0GlI+i173Py
 DM1m5RDvvgqKtAPu1WYYXwTSlf0zoiUt1nldNOhrevDL5nwjOzRUs427XR4Tl0hz
 CjDahfvgmr0egogM48AGWK9MbmsVTy6qAYJlkdWSQbyzrpx7QKR/9c97lHSciiuQ
 XsM0TEr/4yuJJ9RKXAGmj7AzU=
Received: from 163.com (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgDX30gjHQdq0w7KEg--.17981S2;
 Fri, 15 May 2026 21:18:39 +0800 (CST)
From: <w15303746062@163.com>
To: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
 melissa.srw@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank disable and
 timer callback
Date: Fri, 15 May 2026 21:18:26 +0800
Message-Id: <20260515131826.388154-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgDX30gjHQdq0w7KEg--.17981S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrW8ZF4kur4kWF4xtFWDArb_yoW5Wr48pw
 s2vryxtr1UZF1jv3ZrAF4kur1S934fXFyfJrW0g34Yyw1rCF4xCFy8ta4agFW5Xr9rZa12
 qr4xtr15Zr1jkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeg4fUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAA+ukmoHHS9FGQAA3w
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

[Note: This patch addresses a legacy VKMS implementation deadlock specific
to older stable trees (e.g., 6.18.y). Mainline has removed this code during
the generic DRM_CRTC_VBLANK_TIMER_FUNCS refactoring.]

During local fuzzing with Syzkaller, an RCU preempt stall (soft lockup)
was observed. This is caused by an ABBA deadlock between the
drm_vblank_disable_and_save() function and the vkms_vblank_simulate()
hrtimer callback.

The race condition occurs as follows:

Thread A (CPU 3 - DRM_IOCTL_MODE_SETCRTC):
  - drm_vblank_disable_and_save() acquires `&dev->vblank_time_lock`.
  - Calls __disable_vblank() -> vkms_disable_vblank().
  - Calls hrtimer_cancel() to synchronously stop the vblank timer.
  - BLOCK: hrtimer_cancel() spins indefinitely waiting for the timer
    callback to finish executing on CPU 0.

Thread B (CPU 0 - hrtimer interrupt):
  - Executes the hrtimer callback vkms_vblank_simulate().
  - Calls drm_crtc_handle_vblank() -> drm_handle_vblank().
  - BLOCK: drm_handle_vblank() tries to acquire `&dev->vblank_time_lock`
    and spins forever because Thread A is holding it.

This patch fixes the deadlock by replacing hrtimer_cancel() with
hrtimer_try_to_cancel(). If the timer callback is running, try_to_cancel()
will safely return -1 and allow Thread A to proceed and release the lock.

Additionally, vkms_vblank_simulate() is modified to conditionally return
HRTIMER_NORESTART if drm_crtc_handle_vblank() fails (which it will,
because Thread A sets `vblank->enabled = false` immediately after
try_to_cancel). This acts as a self-destruct mechanism, preventing the
timer from blindly re-arming itself and causing an infinite loop of
DRM_ERROR messages.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index e60573e0f3e9..a62153b73548 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -57,7 +57,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 
 	dma_fence_end_signalling(fence_cookie);
 
-	return HRTIMER_RESTART;
+	return ret ? HRTIMER_RESTART : HRTIMER_NORESTART;
 }
 
 static int vkms_enable_vblank(struct drm_crtc *crtc)
@@ -77,7 +77,7 @@ static void vkms_disable_vblank(struct drm_crtc *crtc)
 {
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
 
-	hrtimer_cancel(&out->vblank_hrtimer);
+	hrtimer_try_to_cancel(&out->vblank_hrtimer);
 }
 
 static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
-- 
2.34.1

