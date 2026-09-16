Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53854C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830BC10E6A0;
	Wed, 16 Sep 2026 08:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FpCiZtTf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A23410E480
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:56:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDC7D6053E;
 Wed, 16 Sep 2026 08:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5711F00893;
 Wed, 16 Sep 2026 08:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789548982;
 bh=CrhAgLOa9S0sjkU0cvrpKeYUfcI6Uc5jYrDrZaVEcGk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FpCiZtTf4FSeYQyR8ukydAXA8wpAfc7UBqzydw3Z54AHWkcw/y8vdP4mwOEV9TaJd
 C9w4iAAKEVizCqIBLOwfjCxxotHNdeoMI5UQQrFt+vFncnTjVRNDwTKFzoBrFOX4s3
 GVpHsv4RDDBimY9FStQ6P2qnv3rBNfRJX7kw+CzL0/lX73MHv1g4dshlQMopq0117M
 2mPfpAfGTnYz7+b0U1hefgjQdI1mRDDNa3mO2U+LjDVuGF+/WmBNsU7Xvb/396hfJ9
 KZsa74b4IQ2T/KpOOaqr6AX1qeONzV82Npt7dKVl/yaG1GIauc+n55k4xLKTRkNDsS
 13fkxT6qc81GQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 16 Sep 2026 10:55:50 +0200
Subject: [PATCH v5 7/9] drm/atomic-state-helper: Remove
 drm_atomic_helper_plane_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-no-more-plane-reset-v5-7-f590d2003f2c@kernel.org>
References: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
In-Reply-To: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211; i=mripard@kernel.org;
 h=from:subject:message-id; bh=y0oJlBGeXBOaB8Ct9xA2mu3/aH32ByGXBopelSmsO3s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmrIqcldzeKp1Q1b209JLvXk8dafmKf+bfOFfWbTKrUN
 +0LVL7bMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYy8QljfV28y+VDihoPAuU0
 OJ/z1nd0vC568HQu93X5GfMkl/3of5WX5LFIwHrmBNsWnQcf/VM3MjbsvvLR9MqfUx2vTXeK/FP
 rFt7xftqx4oyKQ3fbT+RH74pl2B+0v+V99E/NtctrntozS3ABAA==
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

drm_atomic_helper_plane_reset() is no longer used: all callers now go
through drm_atomic_helper_plane_create_state(). Remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 19 -------------------
 include/drm/drm_atomic_state_helper.h     |  1 -
 include/drm/drm_plane.h                   |  3 ---
 3 files changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index eb9de78c4d85..ee16f6e644f8 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -306,29 +306,10 @@ void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
 
 	plane->state = plane_state;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_plane_reset);
 
-/**
- * drm_atomic_helper_plane_reset - default &drm_plane_funcs.reset hook for planes
- * @plane: drm plane
- *
- * Resets the atomic state for @plane by freeing the state pointer (which might
- * be NULL, e.g. at driver load time) and allocating a new empty state object.
- */
-void drm_atomic_helper_plane_reset(struct drm_plane *plane)
-{
-	if (plane->state)
-		__drm_atomic_helper_plane_destroy_state(plane->state);
-
-	kfree(plane->state);
-	plane->state = kzalloc_obj(*plane->state);
-	if (plane->state)
-		__drm_atomic_helper_plane_reset(plane, plane->state);
-}
-EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
-
 /**
  * drm_atomic_helper_plane_create_state - default &drm_plane_funcs.atomic_create_state hook for planes
  * @plane: plane object
  *
  * Allocates and initializes pristine @drm_plane_state.
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 480eaae42f45..49acd05552a5 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -56,11 +56,10 @@ void __drm_atomic_helper_plane_state_init(struct drm_plane_state *state,
 					   struct drm_plane *plane);
 struct drm_plane_state *
 drm_atomic_helper_plane_create_state(struct drm_plane *plane);
 void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
 				     struct drm_plane_state *state);
-void drm_atomic_helper_plane_reset(struct drm_plane *plane);
 void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
 					       struct drm_plane_state *state);
 struct drm_plane_state *
 drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane);
 void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state);
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 2c5a5a70a71b..e757e9dbf132 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -363,13 +363,10 @@ struct drm_plane_funcs {
 	 * @reset:
 	 *
 	 * Reset plane hardware and software state to off. This function isn't
 	 * called by the core directly, only through drm_mode_config_reset().
 	 * It's not a helper hook only for historical reasons.
-	 *
-	 * Atomic drivers can use drm_atomic_helper_plane_reset() to reset
-	 * atomic state using this hook.
 	 */
 	void (*reset)(struct drm_plane *plane);
 
 	/**
 	 * @set_property:

-- 
2.55.0

