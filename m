Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D75C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A07210EB9B;
	Tue,  1 Sep 2026 07:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="loYwFRNt";
	dkim-atps=neutral
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0016210E981;
 Tue,  1 Sep 2026 06:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788245756; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=rf4WK0KdwAQ6jr0zJzFS4FpQKho5BAQcjv37Xsync5k=;
 b=loYwFRNt9EwiuRKtcocQyrKwTJr1JJRbbeB33lwbh+4034ysgLlutXcJvXC7g9345fPCzfHjOh/eocDZqpelGdRk69OBXw4svxdxOAhAeSFXglE/0lsxWp18Kcmj0ePRU0JPqUrtkftMuj7cjy6Inw+T0oo4vJZTR9NvgLkasx0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=qinyuntan@linux.alibaba.com; NM=1; PH=DS; RN=17; SR=0;
 TI=SMTPD_---0XA4XWTg_1788245451; 
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com
 fp:SMTPD_---0XA4XWTg_1788245451 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 01 Sep 2026 14:50:52 +0800
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, airlied@redhat.com, jfalempe@redhat.com,
 kraxel@redhat.com, dmitry.osipenko@collabora.com, hansg@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 leandro.ribeiro@collabora.com, daniels@collabora.com,
 pekka.paalanen@collabora.com, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH 3/4] drm/virtio: create blend mode property on cursor plane
Date: Tue,  1 Sep 2026 14:50:44 +0800
Message-ID: <20260901065045.1152136-4-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260901065045.1152136-1-qinyuntan@linux.alibaba.com>
References: <20260901065045.1152136-1-qinyuntan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
format with alpha exposed"), drm_mode_config_validate() warns when a
plane exposes an alpha pixel format but not the "pixel blend mode"
property. The virtio-gpu cursor plane (HOST_ARGB8888) trips this.

The cursor has always blended with pre-multiplied alpha and userspace
assumes that blend mode when the property is not attached. Expose a
"pixel blend mode" property advertising only DRM_MODE_BLEND_PREMULTI
to make the existing semantics explicit and silence the warning. The
primary plane only exposes HOST_XRGB8888, so the call is gated to the
cursor. No functional change.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 1d1b27ece62a7..640815af40980 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -24,6 +24,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -609,6 +610,9 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 
 	if (type == DRM_PLANE_TYPE_PRIMARY)
 		drm_plane_enable_fb_damage_clips(plane);
+	else if (type == DRM_PLANE_TYPE_CURSOR)
+		drm_plane_create_blend_mode_property(plane,
+						     BIT(DRM_MODE_BLEND_PREMULTI));
 
 	return plane;
 }
-- 
2.43.7

