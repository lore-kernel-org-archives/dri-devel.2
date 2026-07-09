Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90454C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A074410F53A;
	Thu,  9 Jul 2026 11:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O7Xbvvql";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE92310F517
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:51:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8B97407E0;
 Thu,  9 Jul 2026 11:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F401F000E9;
 Thu,  9 Jul 2026 11:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597874;
 bh=CQ9ccz5VX8Iwm/C02NqD176hSVmvymZoxFkWBbYB4iY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=O7Xbvvql9Lenj7Og3t/XIsx54bBvKVu1wALpCOTPzjOI63+7tfW+wCU84USM/iSUx
 SPpRpnV9a1k6U1eZYJ2q7ByojgamqdBvFWvQGW3LxkBatU/A9foQuL4rYiBeDx/Raa
 IScIlgq7Jt2l8y9e7ZGTQf9hsb13M8aUqVyCtnzC8llbNlwwLGQi6XNZ0dWMtVzfo7
 uZFgNdnwez20eB0TMaiZ0mf7jH2V9GLaFDcw41SP0jDlabt5t2sZhlH3zt+eOMYlRO
 10YcVXwGhlMG/q9xy2E4LUrsTPFhtqCsF4wI6HydfWASEDRxKotNCen5Qj7DogoNJ7
 eTqZyu/BHxLQA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:50:31 +0200
Subject: [PATCH 05/60] drm/gem-atomic-helper: Remove
 drm_gem_reset_shadow_plane()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-5-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/vVVzrFLl4CHGzHOnsUQDdiNm1grTDY6kK4pytAM98w=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3dzv3u7QF3zVG2HSee92ctKFsnt/Dxh9u8vJU3QsY
 h+/VfvujqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARxbOMDZv4HCJsXvGE8C3h
 850VL3qDVdVXLa7vqcnzTtZL3SozPX0+TWxcFWj1W3fNOuaH/DN7GOuD3QWq2uavYdsRYrM6MO3
 Q1OtHfp9RffjrnBzLcfPujKe6sRMqrR6za1/7c85JJP3cwxMA
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

drm_gem_reset_shadow_plane() is no longer used: all callers now go
through drm_gem_create_shadow_plane_state() via the
atomic_create_state hook. Remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 23 -----------------------
 include/drm/drm_gem_atomic_helper.h     |  1 -
 2 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index ae854555fd12..3bb6bfd560d3 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -337,33 +337,10 @@ void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
 		__drm_atomic_helper_plane_reset(plane, NULL);
 	}
 }
 EXPORT_SYMBOL(__drm_gem_reset_shadow_plane);
 
-/**
- * drm_gem_reset_shadow_plane - resets a shadow-buffered plane
- * @plane: the plane
- *
- * This function implements struct &drm_plane_funcs.reset_plane for
- * shadow-buffered planes. It assumes the current plane state to be
- * of type struct drm_shadow_plane and it allocates the new state of
- * this type.
- */
-void drm_gem_reset_shadow_plane(struct drm_plane *plane)
-{
-	struct drm_shadow_plane_state *shadow_plane_state;
-
-	if (plane->state) {
-		drm_gem_destroy_shadow_plane_state(plane, plane->state);
-		plane->state = NULL; /* must be set to NULL here */
-	}
-
-	shadow_plane_state = kzalloc_obj(*shadow_plane_state);
-	__drm_gem_reset_shadow_plane(plane, shadow_plane_state);
-}
-EXPORT_SYMBOL(drm_gem_reset_shadow_plane);
-
 /**
  * drm_gem_begin_shadow_fb_access - prepares shadow framebuffers for CPU access
  * @plane: the plane
  * @plane_state: the plane state of type struct drm_shadow_plane_state
  *
diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
index da8a4fb442b4..2deb0cd9ebbe 100644
--- a/include/drm/drm_gem_atomic_helper.h
+++ b/include/drm/drm_gem_atomic_helper.h
@@ -92,11 +92,10 @@ void __drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane,
 					    struct drm_shadow_plane_state *new_shadow_plane_state);
 void __drm_gem_destroy_shadow_plane_state(struct drm_shadow_plane_state *shadow_plane_state);
 void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
 				  struct drm_shadow_plane_state *shadow_plane_state);
 
-void drm_gem_reset_shadow_plane(struct drm_plane *plane);
 void __drm_gem_shadow_plane_state_init(struct drm_plane *plane,
 				       struct drm_shadow_plane_state *shadow_plane_state);
 struct drm_plane_state *drm_gem_create_shadow_plane_state(struct drm_plane *plane);
 struct drm_plane_state *drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane);
 void drm_gem_destroy_shadow_plane_state(struct drm_plane *plane,

-- 
2.54.0

