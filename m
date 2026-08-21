Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA89C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99BB010F2EA;
	Fri, 21 Aug 2026 14:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lBvVoPrJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9475710E1FA;
 Fri, 21 Aug 2026 14:41:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A48341439;
 Fri, 21 Aug 2026 14:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98741F000E9;
 Fri, 21 Aug 2026 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323268;
 bh=tGZvPsHME2E/wrfelM65p2gpGoM5w0vONoPB5OdwexY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lBvVoPrJigoyaBRny3oaIbULHprhsQh2EGWZl7dUOiEBuK/mL15L/ykeQNKeqbwRd
 pO75rFnBjx3fCocenRh+yGGVWVedhApVBp5j5E8N80js5mDScFogtezgJmQtVozhdM
 zwwStSTUzJOV6P/9LU+dD+M/P/ciMni23/agZ/vj4IrREloZY+A+XQp3NzMfOOqz50
 orMaRMag/YDi+urBMBY53SCZhuB9iyV1c7ksOdZMeOD/2L9LcsldQWRIyweto3K0FJ
 Fv0NYKrDXD8akb+OYRqva5ktmp1ASE//1P1PYR9+gYsM8P3TE4Wu13AMTafguHy6Qz
 gi0nxMM2Kfq6g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:20 +0200
Subject: [PATCH 44/70] drm/amdgpu: dm: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-44-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3189; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7/AkvMrdKLH/gLvmbjptNwVAfTOKamCgfqA8djnBm70=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGqIYwvIu+8bV5B2xGz4MS3RQRHDR+NkAf7e73DwXsVtkDw6s
 4iVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmqIYwsACgkQJ1/OGaI9vnbLfwF/bMhQ
 9V/e9NCTmc79voA/nHovuvElmzvlm11RBhM7zu59FmqZflGvjlrPBfr8SxTXAYCh2fdby3MJY55
 Z2UriR5UuqOEo5XSkLFFXD12k3qPboK8L7c5+2fk2pvQChRitm0Q=
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

The amdgpu display manager crtc implementation provides a custom reset
hook. However, this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 0ad7704800d9..42a908c9d4a9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -438,22 +438,21 @@ static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 
 	drm_crtc_cleanup(crtc);
 	kfree(crtc);
 }
 
-static void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
+static struct drm_crtc_state *amdgpu_dm_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state;
 
 	state = kzalloc_obj(*state);
 	if (!state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	if (crtc->state)
-		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
+	__drm_atomic_helper_crtc_state_init(&state->base, crtc);
 
-	__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	return &state->base;
 }
 
 #ifdef CONFIG_DEBUG_FS
 static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
 {
@@ -527,11 +526,11 @@ amdgpu_dm_atomic_crtc_get_property(struct drm_crtc *crtc,
 }
 #endif
 
 /* Implemented only the options currently available for the driver */
 static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
-	.reset = amdgpu_dm_crtc_reset_state,
+	.atomic_create_state = amdgpu_dm_crtc_create_state,
 	.destroy = amdgpu_dm_crtc_destroy,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = amdgpu_dm_crtc_duplicate_state,
 	.atomic_destroy_state = amdgpu_dm_crtc_destroy_state,
@@ -741,13 +740,13 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 
 	amdgpu_dm_ism_init(&acrtc->ism, &default_ism_config);
 
 	drm_crtc_helper_add(&acrtc->base, &amdgpu_dm_crtc_helper_funcs);
 
-	/* Create (reset) the plane state */
-	if (acrtc->base.funcs->reset)
-		acrtc->base.funcs->reset(&acrtc->base);
+	/* Create the plane state */
+	if (acrtc->base.funcs->atomic_create_state)
+		acrtc->base.funcs->atomic_create_state(&acrtc->base);
 
 	acrtc->max_cursor_width = dm->adev->dm.dc->caps.max_cursor_size;
 	acrtc->max_cursor_height = dm->adev->dm.dc->caps.max_cursor_size;
 
 	acrtc->crtc_id = crtc_index;

-- 
2.55.0

