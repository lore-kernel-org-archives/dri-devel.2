Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB46FC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4848810EF47;
	Thu, 20 Aug 2026 08:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="HtgVS948";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B117210EF41
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=x9
 qYIvdulKbtYBT6ZR5k3nC2pRYnnyeKh2tY0B5Kakg=; b=HtgVS948z9oV2S41hL
 5/LwSGdDu24bs1ZK17Dz8cl+dY/pgmgCjEqyKnZOIP4rb0+WvJ9q4ucws67SptU3
 87SbJQZKZqyLtPv3eNVC4PL129sNuYDgE4BjPnbAyM63jUw9Rj7/q4mcHkXll+1z
 7nLPgi5/tZjNRae2gkoEerhhc=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wAnGJteu4ZqyKiICg--.32760S2; 
 Thu, 20 Aug 2026 16:31:27 +0800 (CST)
From: oushixiong1025@163.com
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 1/2] drm/vkms: Cache composer line buffers in vkms_output
Date: Thu, 20 Aug 2026 16:31:20 +0800
Message-Id: <20260820083123.544655-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnGJteu4ZqyKiICg--.32760S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw4kXryruw43Wry7Cw4xXrb_yoW7CFWkpF
 sxKr9Fkr4UXr1xXayUArWrZr4fuanYqay0k398K3y3Zr1Fk3sav34qkFy3ZrW5Jr429r13
 tF4UG34DG3W09r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn2-5UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4gBDUmqGu2CZlwAA3K
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

From: Shixiong Ou <oushixiong@kylinos.cn>

compose_active_planes() kvmalloc/kvfree two line buffers every vblank
frame, but their size depends only on hdisplay which changes only on
modeset.  Cache them in vkms_output and reallocate only when the width
changes, avoiding repeated alloc/free overhead.

Register a drmm action to free the buffers when the device is released.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 44 ++++++++++++++++------------
 drivers/gpu/drm/vkms/vkms_crtc.c     | 12 ++++++++
 drivers/gpu/drm/vkms/vkms_drv.h      |  7 +++++
 3 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 83d217085ad0..f3fb203946e8 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -541,11 +541,11 @@ static int check_iosys_map(struct vkms_crtc_state *crtc_state)
 
 static int compose_active_planes(struct vkms_writeback_job *active_wb,
 				 struct vkms_crtc_state *crtc_state,
+				 struct vkms_output *out,
 				 u32 *crc32)
 {
 	size_t line_width, pixel_size = sizeof(struct pixel_argb_u16);
 	struct line_buffer output_buffer, stage_buffer;
-	int ret = 0;
 
 	/*
 	 * This check exists so we can call `crc32_le` for the entire line
@@ -565,27 +565,35 @@ static int compose_active_planes(struct vkms_writeback_job *active_wb,
 	stage_buffer.n_pixels = line_width;
 	output_buffer.n_pixels = line_width;
 
-	stage_buffer.pixels = kvmalloc(line_width * pixel_size, GFP_KERNEL);
-	if (!stage_buffer.pixels) {
-		DRM_ERROR("Cannot allocate memory for the output line buffer");
-		return -ENOMEM;
-	}
+	if (out->composer_buffer_width != line_width) {
+		kvfree(out->composer_stage_buffer);
+		kvfree(out->composer_output_buffer);
+		out->composer_buffer_width = 0;
+
+		out->composer_stage_buffer = kvmalloc(line_width * pixel_size, GFP_KERNEL);
+		if (!out->composer_stage_buffer) {
+			DRM_ERROR("Cannot allocate memory for the output line buffer");
+			return -ENOMEM;
+		}
+
+		out->composer_output_buffer = kvmalloc(line_width * pixel_size, GFP_KERNEL);
+		if (!out->composer_output_buffer) {
+			DRM_ERROR("Cannot allocate memory for intermediate line buffer");
+			kvfree(out->composer_stage_buffer);
+			out->composer_stage_buffer = NULL;
+			return -ENOMEM;
+		}
 
-	output_buffer.pixels = kvmalloc(line_width * pixel_size, GFP_KERNEL);
-	if (!output_buffer.pixels) {
-		DRM_ERROR("Cannot allocate memory for intermediate line buffer");
-		ret = -ENOMEM;
-		goto free_stage_buffer;
+		out->composer_buffer_width = line_width;
 	}
 
+	stage_buffer.pixels = out->composer_stage_buffer;
+	output_buffer.pixels = out->composer_output_buffer;
+
 	blend(active_wb, crtc_state, crc32, &stage_buffer,
 	      &output_buffer, line_width * pixel_size);
 
-	kvfree(output_buffer.pixels);
-free_stage_buffer:
-	kvfree(stage_buffer.pixels);
-
-	return ret;
+	return 0;
 }
 
 /**
@@ -644,9 +652,9 @@ void vkms_composer_worker(struct work_struct *work)
 		return;
 
 	if (wb_pending)
-		ret = compose_active_planes(active_wb, crtc_state, &crc32);
+		ret = compose_active_planes(active_wb, crtc_state, out, &crc32);
 	else
-		ret = compose_active_planes(NULL, crtc_state, &crc32);
+		ret = compose_active_planes(NULL, crtc_state, out, &crc32);
 
 	if (ret)
 		return;
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 079abfba427d..6e03c9a1fbd8 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -13,6 +13,14 @@
 
 #include "vkms_drv.h"
 
+static void vkms_composer_buffers_release(struct drm_device *dev, void *data)
+{
+	struct vkms_output *out = data;
+
+	kvfree(out->composer_stage_buffer);
+	kvfree(out->composer_output_buffer);
+}
+
 static bool vkms_crtc_handle_vblank_timeout(struct drm_crtc *crtc)
 {
 	struct vkms_output *output = drm_crtc_to_vkms_output(crtc);
@@ -237,5 +245,9 @@ struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_plane *pri
 	if (IS_ERR(vkms_out->composer_workq))
 		return ERR_CAST(vkms_out->composer_workq);
 
+	ret = drmm_add_action_or_reset(dev, vkms_composer_buffers_release, vkms_out);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return vkms_out;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 0933e4ce0ff0..e6d58b396451 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -214,6 +214,9 @@ struct vkms_crtc_state {
  *		      writeback)
  * @composer_state: Protected by @lock, current state of this VKMS output
  * @composer_lock: Lock used internally to protect @composer_state members
+ * @composer_stage_buffer: Cached line buffer for plane pixel read and pre-blend transform
+ * @composer_output_buffer: Cached line buffer for blending output
+ * @composer_buffer_width: Current allocated width of the cached buffers (in pixels)
  */
 struct vkms_output {
 	struct drm_crtc crtc;
@@ -226,6 +229,10 @@ struct vkms_output {
 	struct vkms_crtc_state *composer_state;
 
 	spinlock_t composer_lock;
+
+	struct pixel_argb_u16 *composer_stage_buffer;
+	struct pixel_argb_u16 *composer_output_buffer;
+	size_t composer_buffer_width;
 };
 
 struct vkms_config;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

