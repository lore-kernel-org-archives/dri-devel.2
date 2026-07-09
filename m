Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAEFC44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB0A10F568;
	Thu,  9 Jul 2026 11:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZwxXjLnT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F271B10F55A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:53:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DC42D439C5;
 Thu,  9 Jul 2026 11:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467E21F00A3D;
 Thu,  9 Jul 2026 11:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783598006;
 bh=J0Jx5JLETqFoqTDH2SKzIL5CXQy5efrAeu2f0Mwt05E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZwxXjLnTCwq7WCZfwUBSn4rBMlmvkRZiGWHZ3tqouti6VXsNUijbC/kA/4N0kTLL2
 VImtDBXhrwWJblsiiuw7DDgf0VXn6yaHWxlKqn66USYIVs7SYT5bei47Zw8kEki72y
 vL4C+1i0XGaADJfm0bVJuyyDhym/MMkHcFKHLvHtXnRFqJptYeo7r2q5O6roI/2OMS
 8OARKfHz1jHssSZXsYhygLPsCLgJBLVrtt0ydYzBzjvBH0yXNlHiXFoDIm+IkhZji4
 2/zonSTaq6/lbmSI7vitBVxzEbOTrmPUhxAUJKadd0PFqs3hOG5nQdAISMzhs5ZsNi
 38XCNlZeyOv4g==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:51:26 +0200
Subject: [PATCH 60/60] drm/plane: Remove reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-60-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kBGhFaa+5WijFTaCzGcQIclGiQWWQcSVz2eTk0C+VPc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3cpHtNV0mOYp5EwJuKlbpvX2p8ZCzS3FjDxMzjeNl
 V00+DM6prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwERW/WZsOF3hL9n3QO7V17ln
 /jkdcPjJfuYJ96P3N6+VOm/+c5nlQl3jJt8CWYvb21yEfpsJd5+pY2yYZOXVWpKZ1Za1/z//UdM
 rL/4uF/958vC0K6z3/A8x9HzyLDx0R0at4F3vZYnXDIb227QA
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

All plane drivers now implement the atomic_create_state hook instead of
the reset hook for initial state creation. The reset hook conflated
initial state allocation at probe time with hardware and software reset
during suspend/resume, making error handling difficult since it is not
fallible.

Remove the reset hook from struct drm_plane_funcs and the associated
call in drm_mode_config_reset().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c |  4 +---
 include/drm/drm_plane.h           | 12 ------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index f432f485a914..4b07189e3be5 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -287,13 +287,11 @@ void drm_mode_config_reset(struct drm_device *dev)
 
 	drm_for_each_colorop(colorop, dev)
 		drm_colorop_reset(colorop);
 
 	drm_for_each_plane(plane, dev) {
-		if (plane->funcs->reset)
-			plane->funcs->reset(plane);
-		else if (plane->funcs->atomic_create_state)
+		if (plane->funcs->atomic_create_state)
 			drm_mode_config_plane_reset_with_create_state(plane);
 	}
 
 	drm_for_each_crtc(crtc, dev) {
 		if (crtc->funcs->reset)
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 2c5a5a70a71b..a16e96aa7e60 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -357,22 +357,10 @@ struct drm_plane_funcs {
 	 * through drm_mode_config_cleanup() since a plane cannot be hotplugged
 	 * in DRM.
 	 */
 	void (*destroy)(struct drm_plane *plane);
 
-	/**
-	 * @reset:
-	 *
-	 * Reset plane hardware and software state to off. This function isn't
-	 * called by the core directly, only through drm_mode_config_reset().
-	 * It's not a helper hook only for historical reasons.
-	 *
-	 * Atomic drivers can use drm_atomic_helper_plane_reset() to reset
-	 * atomic state using this hook.
-	 */
-	void (*reset)(struct drm_plane *plane);
-
 	/**
 	 * @set_property:
 	 *
 	 * This is the legacy entry point to update a property attached to the
 	 * plane.

-- 
2.54.0

