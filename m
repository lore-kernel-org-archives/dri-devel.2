Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B495FC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F0510E7F1;
	Wed, 16 Sep 2026 08:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SS7Arvi6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E8110E7F1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:56:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A3C24045D;
 Wed, 16 Sep 2026 08:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD911F00893;
 Wed, 16 Sep 2026 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789548986;
 bh=XHhuwrxfBnQZ8btMboWo35P44c2hutucQpRD2LvaikE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SS7Arvi66PFbggyw0p81ww0NdRjyUANmlv6w7Git9IaWLGHifROqc9povUgfHB6ys
 rr4/1Ul3wOLgZrdALl0vUSfBgjmzpZgfYOsL061JlwnXjG/0lmKjlY5LvUXtJOYgDh
 hxZuFGcSrwJsFIzFqHpAV59VeLus534LTGbITk4DVcXW5Ie7a4F5x8U+7ro2ROoLkK
 bqFjVJceOAD+yU0H7To5hpTemyrTCfIYtLk3xki5IqkKz0xDnS10AgTHM6n2OlXSB9
 q6p9bkDdRRaRd+EQQMSJWU5flB0EUbN1HcyvhpV5SsNA81anKkDfx5jKmbM8+eV4ZT
 X1LnzCz1aVJUQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 16 Sep 2026 10:55:51 +0200
Subject: [PATCH v5 8/9] drm/atomic-state-helper: Remove
 __drm_atomic_helper_plane_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-no-more-plane-reset-v5-8-f590d2003f2c@kernel.org>
References: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
In-Reply-To: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Kx8YIuEvfzuz4VmJO8BD/Ip5YYfU3SntUzkjUis0Vfg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmrIqf7rNs/XSDz3wb/e8p7L39ac0vq+s139Wu9rMXa5
 PLvmrZFdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJWLszNvy5PH2jl9pjt6qW
 mf4Lvyl1ugXdDvb9WTpvV9jDTSF1vQXyEm7T2M523OdqvqAX1HUzlrHhz0+nd+kKV7ZYWYV/E3r
 zM1tvydWCiLvz2vbp+N96p1W68kVzh5taeLDx1Q7nlbwv9QQA
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

__drm_atomic_helper_plane_reset() is no longer used: all callers now go
through __drm_atomic_helper_plane_state_init(). Remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 22 ----------------------
 include/drm/drm_atomic_state_helper.h     |  2 --
 2 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index ee16f6e644f8..406157a3660f 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -284,32 +284,10 @@ void __drm_atomic_helper_plane_state_init(struct drm_plane_state *plane_state,
 			plane_state->hotspot_y = val;
 	}
 }
 EXPORT_SYMBOL(__drm_atomic_helper_plane_state_init);
 
-/**
- * __drm_atomic_helper_plane_reset - reset state on plane
- * @plane: drm plane
- * @plane_state: plane state to assign
- *
- * Initializes the newly allocated @plane_state and assigns it to
- * the &drm_plane->state pointer of @plane, usually required when
- * initializing the drivers or when called from the &drm_plane_funcs.reset
- * hook.
- *
- * This is useful for drivers that subclass the plane state.
- */
-void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
-				     struct drm_plane_state *plane_state)
-{
-	if (plane_state)
-		__drm_atomic_helper_plane_state_init(plane_state, plane);
-
-	plane->state = plane_state;
-}
-EXPORT_SYMBOL(__drm_atomic_helper_plane_reset);
-
 /**
  * drm_atomic_helper_plane_create_state - default &drm_plane_funcs.atomic_create_state hook for planes
  * @plane: plane object
  *
  * Allocates and initializes pristine @drm_plane_state.
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 49acd05552a5..4706eeab52c1 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -54,12 +54,10 @@ void drm_atomic_helper_crtc_destroy_state(struct drm_crtc *crtc,
 
 void __drm_atomic_helper_plane_state_init(struct drm_plane_state *state,
 					   struct drm_plane *plane);
 struct drm_plane_state *
 drm_atomic_helper_plane_create_state(struct drm_plane *plane);
-void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
-				     struct drm_plane_state *state);
 void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
 					       struct drm_plane_state *state);
 struct drm_plane_state *
 drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane);
 void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state);

-- 
2.55.0

