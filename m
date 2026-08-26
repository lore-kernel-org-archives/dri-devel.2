Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30152C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8627C10EC18;
	Wed, 26 Aug 2026 07:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="bZeMPD2W";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3911E10EC18
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=l5
 DCbOFO8G0s/Q8OJxYUOcFzHiGx4ySYHAQkjhp+Hz0=; b=bZeMPD2Wmg8soN8rLo
 Qu16cH07jOlZN203BGEDDeNDfVLsLIPzgqs10WTo8jiAt7gT5kBqht1V6W5WF49/
 c69W2Lh3T5L72Nh1btYhmgxB3CHUfwTzw7vZUDh0YREyyDxAQUg84B2/C1bSNCci
 heOaf+/Ba3dBJcFu5drjbZ5/Q=
Received: from localhost.localdomain (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgDXiekenI5qFXNnNA--.65018S2;
 Wed, 26 Aug 2026 15:56:14 +0800 (CST)
From: oushixiong1025@163.com
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/sysfb: Clear entire framebuffer in atomic_disable
Date: Wed, 26 Aug 2026 15:56:13 +0800
Message-Id: <20260826075613.483617-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgDXiekenI5qFXNnNA--.65018S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy8tF1fCFW5KF1DKFy8Xwb_yoW8Kr48pF
 43CFyqgr4rta1Yg398Cay0vry3Xa98t3y8Jr17t3s3C3Z5Ka4xCF1rGry7CFWDJrWkWr1f
 XwnIyFWDJ3W0kw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um0PDUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-h5se2qOnB6XpgAA3g
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

drm_sysfb_plane_helper_atomic_disable() previously used
plane_state->src_* coordinates to construct the clear rectangle,
which depends on user-controlled input. Instead, clear the entire
visible framebuffer region using fb_mode dimensions, and use
drm_format_info_min_pitch() to compute the safe per-line clear size
without touching non-visible bytes at the end of each line.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index 9a4c210d6f96..c109ecab9d7a 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -376,28 +376,28 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
 	struct drm_device *dev = plane->dev;
 	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(dev);
 	struct iosys_map dst = sysfb->fb_addr;
-	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
 	void __iomem *dst_vmap = dst.vaddr_iomem; /* TODO: Use mapping abstraction */
 	unsigned int dst_pitch = sysfb->fb_pitch;
 	const struct drm_format_info *dst_format = sysfb->fb_format;
 	struct drm_rect dst_clip;
-	unsigned long lines, linepixels, i;
+	unsigned long lines, linepixels, dst_size, i;
 	int idx;
 
-	drm_rect_init(&dst_clip,
-		      plane_state->src_x >> 16, plane_state->src_y >> 16,
-		      plane_state->src_w >> 16, plane_state->src_h >> 16);
+	drm_rect_init(&dst_clip, 0, 0,
+		      sysfb->fb_mode.hdisplay, sysfb->fb_mode.vdisplay);
 
 	lines = drm_rect_height(&dst_clip);
 	linepixels = drm_rect_width(&dst_clip);
+	dst_size = min_t(unsigned long,
+			 drm_format_info_min_pitch(dst_format, 0, linepixels),
+			 dst_pitch);
 
 	if (!drm_dev_enter(dev, &idx))
 		return;
 
 	/* Clear buffer to black if disabled */
-	dst_vmap += drm_fb_clip_offset(dst_pitch, dst_format, &dst_clip);
 	for (i = 0; i < lines; ++i) {
-		memset_io(dst_vmap, 0, linepixels * dst_format->cpp[0]);
+		memset_io(dst_vmap, 0, dst_size);
 		dst_vmap += dst_pitch;
 	}
 
-- 
2.25.1

