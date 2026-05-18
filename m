Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67149CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 17:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D1C10E949;
	Mon, 18 May 2026 17:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="QBsh0uCW";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4690D10E949
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 17:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779126908;
 bh=AcqfgZxPqyMzG8mjzHgOU2rztiegbwzki9Ewrc5oGcI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QBsh0uCW3DP36MyK/G+qsrMpjO+e8xWLoH75+rf1wq9nR4wAczooeRkbVo4Y65Rte
 A1jk9N+49X9TAMXJlSGkRxO7lPsW2/nWUKAJkZhlMo77BSMgtOa7BymilvRQc57qkZ
 0nAQ1hEFF8phiQtEUXjvaSUjUCiOJqiFYpGsU/EHTHMl/f2k0QXwsuner+hCEXUSj6
 ExccSyZW7GuVmEd0AZOPQmMiBGZiHF3LORZUyTqA+hr7gILsYHxF1mtwgrqHgaIKzP
 FXYO3DGOLbTXplru9Q1HEuYb6RBSjZ6qc+t2oOIVrnD9kiBjDW6mlC2fpUqfQj40FU
 aavfqzgSn2fTg==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8B03517E0940;
 Mon, 18 May 2026 19:55:04 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, daniels@collabora.com, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] drm/drm_blend: allow blend mode property without
 PREMULTI
Date: Mon, 18 May 2026 14:54:28 -0300
Message-ID: <20260518175429.80615-2-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518175429.80615-1-leandro.ribeiro@collabora.com>
References: <20260518175429.80615-1-leandro.ribeiro@collabora.com>
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

Some hardware only supports the COVERAGE blend mode and lacks PREMULTI
support entirely. DRM currently requires that PREMULTI is present when
creating a blend mode property, which prevents such drivers from being
properly upstreamed.

Remove this restriction and allow drivers to create a blend mode
property without PREMULTI, enabling support for hardware that
implements only COVERAGE blend mode.

This does not introduce a regression, as no existing upstream drivers
expose only COVERAGE. However, userspace that wants to support such kind
of hardware in the future will have to check the supported blend modes
instead of assuming PREMULTI is always supported.

Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/drm_blend.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index 1f3af27d2418..7d4033989749 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -563,10 +563,10 @@ EXPORT_SYMBOL(drm_atomic_normalize_zpos);
 /**
  * drm_plane_create_blend_mode_property - create a new blend mode property
  * @plane: drm plane
- * @supported_modes: bitmask of supported modes, must include
- *		     BIT(DRM_MODE_BLEND_PREMULTI). Current DRM assumption is
- *		     that alpha is premultiplied, and old userspace can break if
- *		     the property defaults to anything else.
+ * @supported_modes: bitmask of supported modes. When
+ *		     BIT(DRM_MODE_BLEND_PREMULTI) is included, it will be used
+ *		     as the default. Otherwise, the default will fallback to one
+ *		     of the supported modes.
  *
  * This creates a new property describing the blend mode.
  *
@@ -599,13 +599,14 @@ int drm_plane_create_blend_mode_property(struct drm_plane *plane,
 		{ DRM_MODE_BLEND_PREMULTI, "Pre-multiplied" },
 		{ DRM_MODE_BLEND_COVERAGE, "Coverage" },
 	};
+	unsigned int default_mode;
 	unsigned int valid_mode_mask = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 				       BIT(DRM_MODE_BLEND_PREMULTI)   |
 				       BIT(DRM_MODE_BLEND_COVERAGE);
 	int i;
 
 	if (WARN_ON((supported_modes & ~valid_mode_mask) ||
-		    ((supported_modes & BIT(DRM_MODE_BLEND_PREMULTI)) == 0)))
+		    (supported_modes == 0)))
 		return -EINVAL;
 
 	prop = drm_property_create(dev, DRM_MODE_PROP_ENUM,
@@ -630,7 +631,14 @@ int drm_plane_create_blend_mode_property(struct drm_plane *plane,
 		}
 	}
 
-	drm_object_attach_property(&plane->base, prop, DRM_MODE_BLEND_PREMULTI);
+	if (supported_modes & BIT(DRM_MODE_BLEND_PREMULTI))
+		default_mode = DRM_MODE_BLEND_PREMULTI;
+	else if (supported_modes & BIT(DRM_MODE_BLEND_COVERAGE))
+		default_mode = DRM_MODE_BLEND_COVERAGE;
+	else
+		default_mode = DRM_MODE_BLEND_PIXEL_NONE;
+
+	drm_object_attach_property(&plane->base, prop, default_mode);
 	plane->blend_mode_property = prop;
 
 	return 0;
-- 
2.54.0

