Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AF0C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F45A10F667;
	Fri, 14 Aug 2026 15:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T3gmL8Y1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BAD310F661
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:00:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E42A40C24;
 Fri, 14 Aug 2026 15:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD99B1F000E9;
 Fri, 14 Aug 2026 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719604;
 bh=qjEannhuhRvjCHA8VMoJu+zV3Xdo6UCoVIbcKPEZQyg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=T3gmL8Y1oJmAPuLbkyA8bXgllxS2LyRuk1S+0NOtaM3ECN0OxdTWyXVqGGLrqUJqN
 LXBE6V1bIWdg+749LXd8vouYUB4rmncY/CZxyVxjDMnz0e4V/kJwDtvVI+2TKa1OCX
 T6erunEnvkbw+vBHtj/Uw2ZuZQV3k0h2VX9ge+/livGtLDIwM+VsrLyPDOZbSCgLlJ
 ST3hPb4cR2+j+KWVBvCn4vlRGOEklNE8IfFjAVvhBEK96f2EH9cs7dD1D/l870K19P
 uGa1nm0mT7h5pwjbU+wnLlbGIFaYGaDut4yb79aiY9XJCOiXQV2OXcMs0IZjUzXuUi
 y40gVRH72mkGQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:57:50 +0200
Subject: [PATCH v2 61/61] drm/plane: Remove reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-61-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065; i=mripard@kernel.org;
 h=from:subject:message-id; bh=fi3OwdsjNuP4NvYOVn/2XNsZ3gTjCvT5vEI6SPsxgw0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1OvfXnc6aKfZj2ia2jcnmCxK8L3x8PyXrtW1ZwYo1U
 meZ/eqsOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEDvsw1uc0z3uySjKb4+XR
 t2Id5rP0LOK6tmx+yyG5y/9H11OPuPMqNrPkLP/2xkyuOPTKWtptA2O9o+ZFMTmGK0dundxQUzP
 lXdnNXXHKGiWOc9PVJnx9vLxNKI35LteR+mXLdJ7GaXvamrsBAA==
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
 drivers/gpu/drm/drm_mode_config.c | 4 +---
 include/drm/drm_plane.h           | 9 ---------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 3bcc7bf0900c..5823bc0e1a6e 100644
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
index e757e9dbf132..a16e96aa7e60 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -357,19 +357,10 @@ struct drm_plane_funcs {
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
-	 */
-	void (*reset)(struct drm_plane *plane);
-
 	/**
 	 * @set_property:
 	 *
 	 * This is the legacy entry point to update a property attached to the
 	 * plane.

-- 
2.55.0

