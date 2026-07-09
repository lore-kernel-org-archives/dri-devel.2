Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44521C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B222B10F566;
	Thu,  9 Jul 2026 11:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q+90C+qX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 455A210F55A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:53:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2DC68402DE;
 Thu,  9 Jul 2026 11:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3C71F000E9;
 Thu,  9 Jul 2026 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783598002;
 bh=ff8zbwtLb21wzAK4S2RyRGn5tnRxFC6FQtW/06W3WgE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Q+90C+qX+uQnVSh9yLjwsMNDHlnB8iANxB/6B66zeUna7Muw+Tg49LrVcS7sNi+0c
 PV/UKH05QJpAKHRY6ist9AV7W01mf2ed1+s7QBwe9VTs9lbUTwioAMYI44V57xg4RG
 2zKXHHjSlk1M1Zc57s/76Zo7a2Nm0qP+X5NM3HkKsco67BMtxSDVYmc+znV2HwNh1K
 rbLj4dT2BJYmtGq4J2PPIHa8dqbXaUSZpaBf4HdlrZLGmeCMvQSECAinMA8ejeQ3Sp
 hGD2zZnUaCtuKF1ivlj9fxyMI7bFywiIPLMs5feAWDl2atFhokZaQzszFSs5hQPpC3
 fuB9vgv3XFpxw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:51:24 +0200
Subject: [PATCH 58/60] drm/atomic-state-helper: Remove
 __drm_atomic_helper_plane_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-58-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hu4No3BtP5sU5fdRu4co4Y/YmKYd8PekQeVslIXOz44=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3UrV/1WkVPoPz8qcle3HPNOb+6X94xLdLd2vOqJP9
 U4xcjLpmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABM53cVYw8Vw8vW/5Eq+by7X
 13y+duGvvN6cr3mif5Y7nPyef2X7F8fLTN2VPOnbCm0fm4muWbK6kbHeq2PWhDu3HZeuWXlrtZN
 TqfgTNbebq1cvnuh5aLHsGi+OxexK3zt/ff9id3fdgTUPDc+tBQA=
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
index f184ce76e090..afd65f0c8f90 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -322,32 +322,10 @@ void __drm_atomic_helper_plane_state_init(struct drm_plane_state *plane_state,
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
index 60635eb34758..9051217833e3 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -57,12 +57,10 @@ void drm_atomic_helper_crtc_destroy_state(struct drm_crtc *crtc,
 
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
2.54.0

