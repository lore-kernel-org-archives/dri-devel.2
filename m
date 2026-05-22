Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBF9CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 12:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21FC10F682;
	Fri, 22 May 2026 12:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="qPJnuCy8";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58ECA10F682
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jQ
 oeV8+JuevDH2pe0coXHILm+hYLBjsiMm+VXK+GF3I=; b=qPJnuCy8uzXWOPcEFK
 kB0VfiU5VjAHp2U+jjurYYEbnUj/cltd5i1fu+Ph26mvpCSk+D3cXdql/qy3PJGc
 alge+Xi7lIkcPrsKIQMRRWnVQqZnqgLe9K70RY7dbCy2TeTWTRYvgMkeVJG1tXr/
 seu9+srqMeT6gPsw2kGf4n+vs=
Received: from 163.com (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wAXqVuPTRBqlQ52Cw--.30867S2; 
 Fri, 22 May 2026 20:35:36 +0800 (CST)
From: w15303746062@163.com
To: zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 25181214217@stu.xidian.edu.cn
Subject: [PATCH] drm/vmwgfx: Break ABBA deadlock in vblank disable path
Date: Fri, 22 May 2026 20:35:26 +0800
Message-Id: <20260522123526.567109-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXqVuPTRBqlQ52Cw--.30867S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4DCFW5CryxCrW3Xw18Zrb_yoW5Xryrpr
 sFqryxtr1UXF1aganFyF4kWFn5Wws3G342yryxK3s8ZwnFkF1vqF48ZF4YvFZ8urZrA3y2
 qr18tFW8ur4j9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5R6wUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDABgY+2oQTZjggAAA30
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

A severe deadlock occurs when disabling the CRTC while the VKMS vblank
hrtimer is running. The issue is caused by a circular lock dependency
(ABBA) involving the DRM core's dev->vbl_lock and the hrtimer cancellation
sequence.

Stack traces from NMI backtrace confirm the deadlock:
CPU 0 (IRQ Context):
 [ <0>] hrtimer_interrupt
 [ <0>] vkms_vblank_simulate
 [ <0>] drm_crtc_handle_vblank
 [ <0>] _raw_spin_lock_irqsave (waiting for dev->vbl_lock)

CPU 2 (Process Context):
 [ <2>] drm_crtc_vblank_off
 [ <2>] vmw_vkms_disable_vblank
 [ <2>] hrtimer_cancel (blocks waiting for timer callback)

This results in a system lockup and RCU stall:
[ 3367.370429] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks
[ 3367.912523] rcu: rcu_preempt kthread starved for 10504 jiffies!

The driver incorrectly calls the blocking hrtimer_cancel() while holding
dev->vbl_lock inside the disable_vblank() callback.

Fix this by using hrtimer_try_to_cancel() in vmw_vkms_disable_vblank().
This callback must remain non-blocking as it is called with dev->vbl_lock
held by the DRM core. Subsequently, call hrtimer_cancel() in
vmw_vkms_crtc_atomic_disable() *after* drm_crtc_vblank_off() has released
the lock. This ensures the timer is safely and synchronously stopped
without inducing a deadlock.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 5abd7f5ad2db..96fc856b9e06 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -305,7 +305,10 @@ vmw_vkms_disable_vblank(struct drm_crtc *crtc)
 	if (!vmw->vkms_enabled)
 		return;
 
-	hrtimer_cancel(&du->vkms.timer);
+	/*
+	 * Non-blocking cancel to avoid ABBA deadlock while holding vbl_lock.
+	 */
+	hrtimer_try_to_cancel(&du->vkms.timer);
 	du->vkms.surface = NULL;
 	du->vkms.period_ns = ktime_set(0, 0);
 }
@@ -390,9 +393,16 @@ vmw_vkms_crtc_atomic_disable(struct drm_crtc *crtc,
 			     struct drm_atomic_state *state)
 {
 	struct vmw_private *vmw = vmw_priv(crtc->dev);
+	struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
 
-	if (vmw->vkms_enabled)
-		drm_crtc_vblank_off(crtc);
+	if (vmw->vkms_enabled) {
+		drm_crtc_vblank_off(crtc);
+		/*
+		 * Synchronously stop the timer after releasing the vbl_lock
+		 * to ensure no further callbacks occur.
+		 */
+		hrtimer_cancel(&du->vkms.timer);
+	}
 }
 
 static bool
-- 
2.34.1

