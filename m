Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EA1C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 03:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF89F10E444;
	Wed,  2 Sep 2026 03:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="gM0QXyEC";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4CC10E444
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 03:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Xd
 Olvnf0kNLdmnj7QhhCR0Qpd7tZIaYX8X0Qtv2j1ls=; b=gM0QXyEC+cBDkj+xBQ
 PxOl9R32S26qR4laebtgHMsPbH+/KrZ7lwIqUUOsH+7gEXFKGHcxN4EfS8Oshf9c
 CGxnu9gZQu/oqnriKLiTq896cBOnMhO1l/IGUN+DOGnMpzJIyFBiWeHlglkZ2Xbf
 8F4SaqNdw25qrHOgwknzyVs7I=
Received: from localhost.localdomain (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgDnrxQilJdqv626OA--.15776S2;
 Wed, 02 Sep 2026 11:12:35 +0800 (CST)
From: oushixiong1025@163.com
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/modeset-helper: Add blend mode property to the legacy
 primary plane
Date: Wed,  2 Sep 2026 11:12:32 +0800
Message-Id: <20260902031232.165532-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgDnrxQilJdqv626OA--.15776S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy5ArW7Cw4DJrW3ZFW5Jrb_yoW8CryrpF
 sxCFZ8tw1rtFs3Ja4rC392ya15Wan3Ga48Kry2q3sI93ZxKry3Arn8Gr17KFy7Jr4xJr1a
 g39rAr1DZF1UuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFa0PUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-QOtvGqXlCNMxAAA3t
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

The primary plane created by drm_crtc_init() exposes ARGB8888, which
has an alpha channel, but never gets a "pixel blend mode" property, so
drm_mode_config_validate() warns for every driver using this helper
(radeon, gma500, legacy amdgpu DCE). Advertise only
DRM_MODE_BLEND_PREMULTI, the mode userspace always assumed when the
property was absent.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/drm_modeset_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index e54584da4c3d..4c59e82af2f1 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -23,6 +23,7 @@
 #include <linux/export.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_client_event.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -160,6 +161,17 @@ int drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	 */
 	primary->format_default = true;
 
+	/*
+	 * safe_modeset_formats[] includes ARGB8888, which has an alpha
+	 * channel. Advertise the blend mode userspace has always assumed
+	 * for such planes when the "pixel blend mode" property was absent,
+	 * to satisfy drm_mode_config_validate().
+	 */
+	ret = drm_plane_create_blend_mode_property(primary,
+						   BIT(DRM_MODE_BLEND_PREMULTI));
+	if (ret)
+		goto err_drm_plane_cleanup;
+
 	ret = drm_crtc_init_with_planes(dev, crtc, primary, NULL, funcs, NULL);
 	if (ret)
 		goto err_drm_plane_cleanup;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

