Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD81C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9746C10EBA9;
	Tue, 30 Jun 2026 08:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="j5ddAt9G";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E037B10EBA4;
 Tue, 30 Jun 2026 08:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782809005; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SCSRk7aTYAhJax/fYc8iCskXLRwLaQQFK+EU68vU0vxhUfK7TtpwqlW7NmfL9onrqlduKaAs+MBU9UQUw+ZIJhZlPSGXQpvEYz6CkR0UPHJ3b5T81xhkhuVimtOq354s7QAXcIYBoVsyCB0TPuwk4pnRAyn3szV1C4J2wQMDfRA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782809005;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3uTzBwtk9xyx4qwH6w0U3TQMKQFtVWsvk7rUOMUPkWc=; 
 b=MyIwurFODDdwuPdmzlJck3lCLzG2tynbmmgqjHZZ26REDGPJA/scBCQ3aeOeXWD/u3TzF4dxg/P3NdT3nU5TEPlipOFe/0uvJ2/ANE9fm9aEtkNMbh4oJVfrG+4/exMMZzYC10dyMlwH88SYlXrPBkH5+PmQPFjK23Z8XBhjkLs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782809005; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=3uTzBwtk9xyx4qwH6w0U3TQMKQFtVWsvk7rUOMUPkWc=;
 b=j5ddAt9Gl27MlGnQ+VWCQgVtc6LYi1RQckPeaU+oufvOLCRDrRHhMcesIMNCc6dx
 +3CCVXoA7COn6lgazocfarDQuQNvNz9kvoe3qNZj8buDyIXFGB48BM7PSCsKF3ol9tm
 Dcrkgvmw8MdBLgs9UAdAXU/JWMrJ6YS+H+hJfJ0Q=
Received: by mx.zohomail.com with SMTPS id 178280900447820.58225834597306;
 Tue, 30 Jun 2026 01:43:24 -0700 (PDT)
From: Robert Mader <robert.mader@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>,
 Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v1 4/4] drm/vkms: Add DRIVER_PLANE_COLOR_PIPELINE driver
 feature
Date: Tue, 30 Jun 2026 10:42:29 +0200
Message-ID: <20260630084229.529682-5-robert.mader@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630084229.529682-1-robert.mader@collabora.com>
References: <20260630084229.529682-1-robert.mader@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Which is now required for DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE. Only
enable it if the enable_plane_pipeline option is enabled so otherwise
the legacy flags COLOR_ENCODING and COLOR_RANGE continue to be
supported.

Signed-off-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 5a640b531d88..00bbde950521 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -91,7 +91,8 @@ static void vkms_atomic_commit_tail(struct drm_atomic_commit *old_state)
 }
 
 static const struct drm_driver vkms_driver = {
-	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
+	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM |
+				  DRIVER_PLANE_COLOR_PIPELINE,
 	.fops			= &vkms_driver_fops,
 	DRM_GEM_SHMEM_DRIVER_OPS,
 	DRM_FBDEV_SHMEM_DRIVER_OPS,
@@ -184,6 +185,9 @@ int vkms_create(struct vkms_config *config)
 	vkms_device->config = config;
 	config->dev = vkms_device;
 
+	if (!enable_plane_pipeline)
+		vkms_device->drm.driver_features &= ~DRIVER_PLANE_COLOR_PIPELINE;
+
 	ret = dma_coerce_mask_and_coherent(vkms_device->drm.dev,
 					   DMA_BIT_MASK(64));
 
-- 
2.54.0

