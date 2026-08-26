Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C695AC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B7B510E895;
	Wed, 26 Aug 2026 10:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wik+GUOL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF0F10E895
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 10:54:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3922601E9;
 Wed, 26 Aug 2026 10:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DD91F000E9;
 Wed, 26 Aug 2026 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787741667;
 bh=zBtPu+db9RSzD3FBUi4xb2NNk9iniOP6mDk0cqAmda4=;
 h=From:To:Cc:Subject:Date;
 b=Wik+GUOLq906uOZTbmIGKVULn7zt46W/+9bvBjXazjucCVYx7DQkKdU2u5V8o2bgg
 uPSkdET2q6rzHS3Sp6DkCZt12eh2hvpbuosscpHcpZtOCM3i7zJ6J/GqPq8Htgy8c3
 lFj0BF3L2Y1KDmwTSKwmdXMSbH2JgcqqKMWkm2XOuagdjT9jQDDI2JTo94u+/Z6B5G
 t/ih6v9QhDO0oOO+Vvu0Yuhz3rn54CL2tUZqL1oXzJVYaLI9Bp+bMNpMsgmB1/6cms
 4rhfAATGnbLY8lZ5nhW7pTDuRSbyRQQJsrHlB17RTGO5Lf2oEvZ6OWKVVdBaUJvGnK
 tqNRXIJEXKYnA==
From: Thierry Reding <thierry.reding@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH] drm/tegra: Add blend mode properties
Date: Wed, 26 Aug 2026 12:54:21 +0200
Message-ID: <20260826105421.1825331-1-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.55.0
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

From: Thierry Reding <treding@nvidia.com>

The default programming in the driver matches the "coverage" blend mode,
so add the corresponding pixel blend mode property to let userspace know
about it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/tegra/dc.c  | 6 ++++++
 drivers/gpu/drm/tegra/hub.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 0b3fcc7011b35..fefc3761a4bc7 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -904,6 +904,7 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
 						    struct tegra_dc *dc)
 {
 	unsigned long possible_crtcs = tegra_plane_get_possible_crtcs(drm);
+	unsigned int blend_caps = BIT(DRM_MODE_BLEND_COVERAGE);
 	enum drm_plane_type type = DRM_PLANE_TYPE_PRIMARY;
 	struct tegra_plane *plane;
 	unsigned int num_formats;
@@ -939,6 +940,7 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(&plane->base, &tegra_plane_helper_funcs);
+	drm_plane_create_blend_mode_property(&plane->base, blend_caps);
 	drm_plane_create_zpos_property(&plane->base, plane->index, 0, 255);
 
 	err = drm_plane_create_rotation_property(&plane->base,
@@ -1209,6 +1211,7 @@ static struct drm_plane *tegra_dc_cursor_plane_create(struct drm_device *drm,
 						      struct tegra_dc *dc)
 {
 	unsigned long possible_crtcs = tegra_plane_get_possible_crtcs(drm);
+	unsigned int blend_caps = BIT(DRM_MODE_BLEND_COVERAGE);
 	struct tegra_plane *plane;
 	unsigned int num_formats;
 	const u32 *formats;
@@ -1252,6 +1255,7 @@ static struct drm_plane *tegra_dc_cursor_plane_create(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(&plane->base, &tegra_cursor_plane_helper_funcs);
+	drm_plane_create_blend_mode_property(&plane->base, blend_caps);
 	drm_plane_create_zpos_immutable_property(&plane->base, 255);
 
 	return &plane->base;
@@ -1356,6 +1360,7 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
 						       bool cursor)
 {
 	unsigned long possible_crtcs = tegra_plane_get_possible_crtcs(drm);
+	unsigned int blend_caps = BIT(DRM_MODE_BLEND_COVERAGE);
 	struct tegra_plane *plane;
 	unsigned int num_formats;
 	enum drm_plane_type type;
@@ -1394,6 +1399,7 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(&plane->base, &tegra_plane_helper_funcs);
+	drm_plane_create_blend_mode_property(&plane->base, blend_caps);
 	drm_plane_create_zpos_property(&plane->base, plane->index, 0, 255);
 
 	err = drm_plane_create_rotation_property(&plane->base,
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index bd442bfd45407..448f49f3a7d7e 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -759,6 +759,7 @@ struct drm_plane *tegra_shared_plane_create(struct drm_device *drm,
 					    unsigned int index,
 					    enum drm_plane_type type)
 {
+	unsigned int blend_caps = BIT(DRM_MODE_BLEND_COVERAGE);
 	struct tegra_drm *tegra = drm->dev_private;
 	struct tegra_display_hub *hub = tegra->hub;
 	struct tegra_shared_plane *plane;
@@ -797,6 +798,7 @@ struct drm_plane *tegra_shared_plane_create(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(p, &tegra_shared_plane_helper_funcs);
+	drm_plane_create_blend_mode_property(p, blend_caps);
 	drm_plane_create_zpos_property(p, 0, 0, 255);
 
 	return p;
-- 
2.55.0

