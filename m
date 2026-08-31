Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86922C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11FD10E9E9;
	Mon, 31 Aug 2026 16:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M6vM3fD2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C9F10E9DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:20:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 121BE414EF;
 Mon, 31 Aug 2026 16:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D241F000E9;
 Mon, 31 Aug 2026 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788193217;
 bh=xHF/LwlZed3XvB//KdmFVhIZ9dOBkaMbyCaUxq0qLXU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=M6vM3fD2Wcms0ESviXhnb2CbdrMjIq0svJbJzV1Bhnif0WljyMiqQN7i7pMwen+Jr
 MolmkRBzVz7q6NagH4wheymAMHll4t9ECM+A9j3WjEF272D59CGUZpbxtnCyKEprxa
 crn/6+f62XfGoOKElWEYFVfjGQ9yWO2fJbm6FdTz5y8M2iyqDjQAw/nk144pfOkgn/
 B8/u6ihVg7RB+lvHD2h1ytvfU0m6GBwRCZ0buD8dwPJw0BXP66Y495J2eXHbzALR5S
 eqKj9gseMcmSIJTsc+7xQCik41vikA+oHPOLL8Cx1IDIN19g+ntm0Pi0RXkiIclw8g
 reV/0mHjo9atQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 18:17:56 +0200
Subject: [PATCH v3 40/40] drm/plane: Remove reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-plane-reset-v3-40-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065; i=mripard@kernel.org;
 h=from:subject:message-id; bh=cLkGIz6wKoYJdWFaZTz3op5g+Abs3/sa9kG/tDWQcb8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlTVyp1f/XK1dBlLX0sOv3slVXSApv6fNqsTh97vjIz4
 dD7wBbvjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRs5GMdcpKq0qf5Kx66FET
 uGN/xZdveSf/WL713uPwRePGL+3UQzW/F85fP92LRVuiZ+atXet83RgbZhgLp6hL9Xcq3/r9LO1
 riMHV4vm68jrnTlXXeN743P1qfp67Cvt/51dtL1YI6G/n9f0DAA==
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
index 366f6d821242..a1e6ea408ece 100644
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

