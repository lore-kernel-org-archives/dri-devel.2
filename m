Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CCCC5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1918410F2F4;
	Fri, 21 Aug 2026 14:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S0Rp2KFQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15EA310F2EC;
 Fri, 21 Aug 2026 14:41:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D720140312;
 Fri, 21 Aug 2026 14:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9DC1F00A3A;
 Fri, 21 Aug 2026 14:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323299;
 bh=sILiU5hnk0bK7FJMVer/A2NdMTsPP5tMrf5d+SITn88=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=S0Rp2KFQfr3s8UOm+hXsr9mDfrYyuhTo583wlBZsizqYr2gfVxRmmyUDgu+tkcp+1
 E40SQaaP2/dii/gIGy1qNMR8zafoz0Bl8lR4XIiX5bEM3VWiG9PM2Ob4G31AxkwZeC
 cJCA/RobBJeCpXbTBUnFZ6XaWFVjwR5ojAbRDvKOzTMuKiio/WI6C+/iEd33bedxIx
 IQaSWE7Xy8GKpnp8/iqujJJvH7h8zk+wNnd79nWEaoI/Ut+siCivMOIjTFuHzdmWij
 Py9JQaAQhrr8G0BRnNL9HludcoABkNYDofKp6I94JAffIJ6uUcKSGDpivqkHHNd0gt
 cVnPyyM9SVJJw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:33 +0200
Subject: [PATCH 57/70] drm/nouveau: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-57-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 nouveau@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2669; i=mripard@kernel.org;
 h=from:subject:message-id; bh=VfBq/nJGwnD++v64DCYnhI73vjHwhPomJYcPvum9yCA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyYJ3bKy5fmh9YhU2z0z1D2xm3ll9yFW81yGr5uTJm
 dyJGrM6prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwEQaDjHWpwY+fZijktudd+mp
 jAZfpGug+dGs3Fex6jJH2XqkN+jseuHEcH/n07ytLia/kuweHqhhrK9ZLBk8/+CsttMbz25Zv2L
 y2QkFnXdaVj6e8ttuzrXs75Of7H6r8bb2o+C0L7scZkQtKdsAAA==
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

The nouveau nv50 head implementation provides a custom reset hook.
However, this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org
---
 drivers/gpu/drm/nouveau/dispnv50/head.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/nouveau/dispnv50/head.c
index 1affa0378bd0..6a3a93de0cbf 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
@@ -489,22 +489,20 @@ nv50_head_atomic_duplicate_state(struct drm_crtc *crtc)
 	asyh->clr.mask = 0;
 	asyh->set.mask = 0;
 	return &asyh->state;
 }
 
-static void
-nv50_head_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *nv50_head_create_state(struct drm_crtc *crtc)
 {
 	struct nv50_head_atom *asyh;
 
 	if (WARN_ON(!(asyh = kzalloc_obj(*asyh))))
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	if (crtc->state)
-		nv50_head_atomic_destroy_state(crtc, crtc->state);
+	__drm_atomic_helper_crtc_state_init(&asyh->state, crtc);
 
-	__drm_atomic_helper_crtc_reset(crtc, &asyh->state);
+	return &asyh->state;
 }
 
 static int
 nv50_head_late_register(struct drm_crtc *crtc)
 {
@@ -523,11 +521,11 @@ nv50_head_destroy(struct drm_crtc *crtc)
 	kfree(head);
 }
 
 static const struct drm_crtc_funcs
 nv50_head_func = {
-	.reset = nv50_head_reset,
+	.atomic_create_state = nv50_head_create_state,
 	.destroy = nv50_head_destroy,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = nv50_head_atomic_duplicate_state,
 	.atomic_destroy_state = nv50_head_atomic_destroy_state,
@@ -537,11 +535,11 @@ nv50_head_func = {
 	.late_register = nv50_head_late_register,
 };
 
 static const struct drm_crtc_funcs
 nvd9_head_func = {
-	.reset = nv50_head_reset,
+	.atomic_create_state = nv50_head_create_state,
 	.destroy = nv50_head_destroy,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = nv50_head_atomic_duplicate_state,
 	.atomic_destroy_state = nv50_head_atomic_destroy_state,

-- 
2.55.0

