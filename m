Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB2DC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A4410F2FD;
	Fri, 28 Aug 2026 09:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="l0ME8sGb";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B0910F2FD
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3I
 T5xJtBPEVQ7plUVHJExSO9nfjpim50NPTeHEu7G5U=; b=l0ME8sGbFNYz3p8Z/r
 dLfFnB4xnuyU0y+Df1SvNQ3tX9kZSHOjT8884LGmIzNTfD+awXU+H46F9YZrvl1s
 NW0/z48TN30/mksjzEfEpk7/IX01qyhx0fVsAloyXoOheKhTHfyIZqkziuuOY6QN
 V/gMX8MWu3KIelMJSurrV0YD0=
Received: from localhost.localdomain (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgCXEurETpFqfwmqNQ--.25217S2;
 Fri, 28 Aug 2026 17:03:00 +0800 (CST)
From: oushixiong1025@163.com
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>, Ye Liu <liuye@kylinos.cn>
Subject: [PATCH] drm/vkms: Add pixel blend mode property
Date: Fri, 28 Aug 2026 17:02:57 +0800
Message-Id: <20260828090257.788076-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgCXEurETpFqfwmqNQ--.25217S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy8WF1xur4xKFW8KF1fCrg_yoW8Kr48pF
 W3Aa1FyrW5ArsrX3y5JFWY93yfW3WIgFy8ArW3A3sagrn0yF9rAF1rCF1S9rW5ArWxCw1j
 yF4DGFWDGFWIkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j05l8UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-QTD0mqRTsTXuAAA32
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

The vkms planes expose formats with an alpha channel but do not
create the pixel blend mode property. Since
commit 860e748bddcc ("drm: ensure blend mode supported if pixel
format with alpha exposed") this triggers a warning during
drm_mode_config_validate():

[  993.538979] ------------[ cut here ]------------
[  993.539000] [PLANE:35:plane-0] pixel format with alpha exposed but blend mode not setup
[  993.539063] WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate
......
[  993.539578] Call trace:
[  993.539580]  drm_mode_config_validate+0x398/0x558 [drm] (P)
[  993.539707]  drm_dev_register+0x1cc/0x2a0 [drm]
[  993.539832]  vkms_create+0x184/0x1d0 [vkms]
[  993.539854]  vkms_init+0x78/0xff8 [vkms]
......

The vkms composer only blends premultiplied alpha, see
pre_mul_alpha_blend(), so create the property with
DRM_MODE_BLEND_PREMULTI as the only supported mode.

Reported-by: Ye Liu <liuye@kylinos.cn>
Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 6ee5c3f3207c..c4272f5f0354 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -276,6 +276,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_plane *plane;
+	int ret;
 
 	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
 					   &vkms_plane_funcs,
@@ -287,6 +288,15 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 
 	drm_plane_helper_add(&plane->base, &vkms_plane_helper_funcs);
 
+	/*
+	 * The vkms composer only blends premultiplied alpha, see
+	 * pre_mul_alpha_blend(), so that is the only supported mode.
+	 */
+	ret = drm_plane_create_blend_mode_property(&plane->base,
+						   BIT(DRM_MODE_BLEND_PREMULTI));
+	if (ret)
+		return ERR_PTR(ret);
+
 	drm_plane_create_rotation_property(&plane->base, DRM_MODE_ROTATE_0,
 					   DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
 
-- 
2.25.1

No virus found
		Checked by Hillstone Network AntiVirus

