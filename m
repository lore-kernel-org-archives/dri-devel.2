Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA7AC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C42710F528;
	Thu,  9 Jul 2026 11:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sb/E+at0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AA510F528
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:51:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A71B941B0E;
 Thu,  9 Jul 2026 11:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C5B1F000E9;
 Thu,  9 Jul 2026 11:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597891;
 bh=Sre25N3GyAviMTDqc/gcSU5qS53O5Ot4VyboU+tKTbo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Sb/E+at0uBwv7f2u4MzZvoCy3ndvVv9TJGf1LntdA5zRaYnOzf1pZmEV55C50L79E
 td8Rl+kzENpv834VVpqaeVWanF6wF2NlvvKszpoBsT5Pb28XGcgdyupUOuhSZG+AB9
 tKLrODDEiO05/8QDnYJ3KYCIxVV6lpy05njpdgnncwvzHjbbXwqJOmRfhz6qKZnORU
 HSD4MX/jdipHM+ECeEhOUPJo4ihAd2BAKwH8cH1rJlWZHM/pKmx9yTJlEd1bZF6Ee+
 VJ4hw7nal3440+Z621gkqRUE2jz5Sw6rkHruZQftcpdK3qQEX8i5yXaTQMV54uyhOc
 AVYEfMJPvWRZg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:50:38 +0200
Subject: [PATCH 12/60] drm/gem-atomic-helper: Remove
 __drm_gem_reset_shadow_plane()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-12-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725; i=mripard@kernel.org;
 h=from:subject:message-id; bh=l9wqFj2snFY+tw7LS/BlNGnyPRA6GDEnx9/akGsXq1M=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3XwVzxWOz2i1nbX/svWGydMKai78XWF6s0ScP4DB6
 tXLDoFXHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiSZMZ6+vXTOR5HDGjOVWx
 X9Rwuc0W/aIXxQ2dR99cPNPreSzh6449Vxc6l3rFatRa3eFWm8Doy1gftmCa49WNjzbUxczj2OA
 TMC+3jV9x/4zNp3USj3UqrnD4n7H22tLJYdcSPy62/Ss3dZEMAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

__drm_gem_reset_shadow_plane() is no longer used: all callers now go
through __drm_gem_shadow_plane_state_init() or
drm_gem_create_shadow_plane_state(). Remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 20 --------------------
 include/drm/drm_gem_atomic_helper.h     |  2 --
 2 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index 3bb6bfd560d3..dd9efa7e3216 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -317,30 +317,10 @@ void drm_gem_destroy_shadow_plane_state(struct drm_plane *plane,
 	__drm_gem_destroy_shadow_plane_state(shadow_plane_state);
 	kfree(shadow_plane_state);
 }
 EXPORT_SYMBOL(drm_gem_destroy_shadow_plane_state);
 
-/**
- * __drm_gem_reset_shadow_plane - resets a shadow-buffered plane
- * @plane: the plane
- * @shadow_plane_state: the shadow-buffered plane state
- *
- * This function resets state for shadow-buffered planes. Helpful
- * for drivers that subclass struct drm_shadow_plane_state.
- */
-void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
-				  struct drm_shadow_plane_state *shadow_plane_state)
-{
-	if (shadow_plane_state) {
-		__drm_atomic_helper_plane_reset(plane, &shadow_plane_state->base);
-		drm_format_conv_state_init(&shadow_plane_state->fmtcnv_state);
-	} else {
-		__drm_atomic_helper_plane_reset(plane, NULL);
-	}
-}
-EXPORT_SYMBOL(__drm_gem_reset_shadow_plane);
-
 /**
  * drm_gem_begin_shadow_fb_access - prepares shadow framebuffers for CPU access
  * @plane: the plane
  * @plane_state: the plane state of type struct drm_shadow_plane_state
  *
diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
index 2deb0cd9ebbe..d41877f77b77 100644
--- a/include/drm/drm_gem_atomic_helper.h
+++ b/include/drm/drm_gem_atomic_helper.h
@@ -89,12 +89,10 @@ to_drm_shadow_plane_state(struct drm_plane_state *state)
 }
 
 void __drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane,
 					    struct drm_shadow_plane_state *new_shadow_plane_state);
 void __drm_gem_destroy_shadow_plane_state(struct drm_shadow_plane_state *shadow_plane_state);
-void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
-				  struct drm_shadow_plane_state *shadow_plane_state);
 
 void __drm_gem_shadow_plane_state_init(struct drm_plane *plane,
 				       struct drm_shadow_plane_state *shadow_plane_state);
 struct drm_plane_state *drm_gem_create_shadow_plane_state(struct drm_plane *plane);
 struct drm_plane_state *drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane);

-- 
2.54.0

