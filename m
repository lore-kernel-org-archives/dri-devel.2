Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C17CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 03:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CFCA10E63F;
	Wed, 27 May 2026 03:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="a+n083D9";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C339E10E63F
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 03:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+9
 4PQT49xTZArnmRTBiZ3JhWjPs1lnmosX2+YEOSBEc=; b=a+n083D9iRHfRwhNEq
 bL8WxBtj4EcA5DB3vnOiehTWZLtkBZBV55YPp3vCYmIDLIfEm4Lg0cDftf6ND1ht
 PmooPXPdhfUILnPmU6kDJkKCU3H7VwV6sHMQ5YXAREUiiZv7JIMHnniW6o1tY3mb
 2XNAjRzBd1Tp8kl+7GG5QbKYk=
Received: from 163.com (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgA3eu1WaRZq7vVUFQ--.205S2;
 Wed, 27 May 2026 11:47:39 +0800 (CST)
From: w15303746062@163.com
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>, stable@vger.kernel.org
Subject: [PATCH] drm/vkms: sanitize display mode to prevent hrtimer livelock
Date: Wed, 27 May 2026 11:47:33 +0800
Message-Id: <20260527034733.701705-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgA3eu1WaRZq7vVUFQ--.205S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF43Kw4kurW7Kr45tw43Jrb_yoW5CF4Dpa
 17XryakFyUJFWxGan2yF1Sgr1akwn5JFyxKryDK3yav3WrtF43Ca4fZrW3WFW3Wr9rAay2
 qFyfJF98Gw109aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URmh7UUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5BuQdGoWaVvXdAAA32
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

SyzKaller reported an RCU stall caused by a livelock in
vkms_crtc_handle_vblank_timeout.

The root cause is that vkms derives its vblank timer period directly
from the display mode, but does not validate the mode parameters in
its atomic_check. A fuzzer or malicious user can pass a mode with
either an explicit vrefresh > 1000 Hz, or a combination of huge
crtc_clock and tiny htotal/vtotal that causes the computed vrefresh
to overflow or result in a frame duration close to zero.

When the period approaches zero, the hrtimer fires faster than it can
be handled, leading to an interrupt storm that deadlocks the CPU.

Fix this by rejecting modes in atomic_check where:
 - the explicit vrefresh exceeds 1000 Hz, or
 - the implied frame duration (derived from crtc_clock/htotal/vtotal)
   is less than 1 ms (equivalent to >1000 Hz).

This also protects against integer overflow in drm_mode_vrefresh().

SyzKaller logs snippet of the failure:
[  392.807933][    C2] vkms_vblank_simulate: vblank timer overrun
...
[  592.384301][    C3] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  592.438915][    C0] RIP: 0010:native_queued_spin_lock_slowpath+0x23e/0x9c0
[  592.440560][    C0] Call Trace:
[  592.440570][    C0]  <IRQ>
[  592.448399][    C0]  drm_handle_vblank+0x132/0xc70
[  592.449106][    C0]  __hrtimer_run_queues+0x1f5/0xb30

Fixes: 02e2681ffe1a ("drm/vkms: Convert to DRM's vblank timer")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 35ddc553a5e6..20b97dd0cc5f 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -116,9 +116,31 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
 									  crtc);
 	struct vkms_crtc_state *vkms_state = to_vkms_crtc_state(crtc_state);
+	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	struct drm_plane *plane;
 	struct drm_plane_state *plane_state;
 	int i = 0, ret;
+	int vrefresh;
+	u64 frame_ns;
+
+	/*
+	 * Reject modes that would cause an hrtimer storm.
+	 * A virtual display cannot meaningfully refresh at >1000 Hz,
+	 * and an extremely high vrefresh (or a crafted combination of
+	 * crtc_clock/htotal/vtotal that overflows the vrefresh computation)
+	 * would produce a frame duration close to zero, locking the CPU
+	 * in an interrupt loop.
+	 */
+	if (crtc_state->enable) {
+		vrefresh = drm_mode_vrefresh(mode);
+		if (vrefresh > 1000)
+			return -EINVAL;
+		if (!mode->crtc_clock || !mode->htotal || !mode->vtotal)
+			return -EINVAL;
+		frame_ns = div_u64((u64)mode->htotal * mode->vtotal * 1000000ULL, mode->crtc_clock);
+		if (frame_ns < 1000000) /* <1 ms => refresh >1000 Hz */
+			return -EINVAL;
+	}
 
 	if (vkms_state->active_planes)
 		return 0;
-- 
2.34.1

