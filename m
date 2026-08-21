Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C54FC5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A44F10F2F9;
	Fri, 21 Aug 2026 14:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nbnbLTTL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A5910F2F4
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:42:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6621140657;
 Fri, 21 Aug 2026 14:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C191F000E9;
 Fri, 21 Aug 2026 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323321;
 bh=4UU4ptqGYUH9MFiZ0T5BWOYTOFszewXRbLXl/DqCDeQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nbnbLTTLiIW9eS+9bDMsoq+Iu/+yBrvpN1Ay6WFlg4CgDIs40+UgpXtvG1NCxmaFl
 iWh4F8XwFmS8Fbxy83DFE6Y69z+AHPCsLUcOXV6jZBnvgidkWcf2potNA8JOXoAh2o
 ALDhhoo/WIkL9mhHyZNKFuewkUDZDhBGJn7qKoFejrsxxXLq2iVgAIuKkL3Uq9nO67
 8al00kYTxdLMRQ/ONG/GqGx4D3L3Gj2fVSXUeh3NLSsaiWb/u093ge8DkXLj4rMWHP
 lxEQxaSNGU81oLVJ+p1RHbxnznNEsqAHrc31JF7tJPGA/s2x22g9cOhmX5upaPz5Jk
 w00e3WlIWzGEg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:42 +0200
Subject: [PATCH 66/70] drm/vc4: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-66-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5164; i=mripard@kernel.org;
 h=from:subject:message-id; bh=OKaaV1zkChMAVewA4aIYGSTgbnQbfAe0HBJ+QTKgjiA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyaL3b7Fpp7RxXHr6bTrj6591ryYXH098tlt11/FLw
 sWc8/65d0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJnPRhbLg8Za3RTs+UfZOE
 jhZ37Xnntjl19dnUmje83Ncc1nn6B7j13jxsfTS95qQiv8H07f8d9zE2/P2qlrpePOzA1S8zNB8
 tc03ZWnDr8fpft/vWcbXcX7K0MtBu5QmRNwuv3an2/qEe4r5jMwA=
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

The vc4 crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), sets the assigned_channel field to
VC4_HVS_CHANNEL_DISABLED, and frees the previous state. It does not
perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
---
 drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c |  2 +-
 drivers/gpu/drm/vc4/vc4_crtc.c            | 14 ++++++--------
 drivers/gpu/drm/vc4/vc4_drv.h             |  2 +-
 drivers/gpu/drm/vc4/vc4_txp.c             |  2 +-
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c b/drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c
index ade3309ae042..247863f8e2c5 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c
@@ -12,11 +12,11 @@ static const struct drm_crtc_helper_funcs vc4_dummy_crtc_helper_funcs = {
 };
 
 static const struct drm_crtc_funcs vc4_dummy_crtc_funcs = {
 	.atomic_destroy_state	= vc4_crtc_destroy_state,
 	.atomic_duplicate_state	= vc4_crtc_duplicate_state,
-	.reset			= vc4_crtc_reset,
+	.atomic_create_state	= vc4_crtc_create_state,
 };
 
 struct vc4_dummy_crtc *vc4_mock_pv(struct kunit *test,
 				   struct drm_device *drm,
 				   struct drm_plane *plane,
diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 4572b0b9bae1..f42cd5353230 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1133,25 +1133,23 @@ void vc4_crtc_destroy_state(struct drm_crtc *crtc,
 	}
 
 	drm_atomic_helper_crtc_destroy_state(crtc, state);
 }
 
-void vc4_crtc_reset(struct drm_crtc *crtc)
+struct drm_crtc_state *vc4_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct vc4_crtc_state *vc4_crtc_state;
 
-	if (crtc->state)
-		vc4_crtc_destroy_state(crtc, crtc->state);
-
 	vc4_crtc_state = kzalloc_obj(*vc4_crtc_state);
 	if (!vc4_crtc_state) {
-		crtc->state = NULL;
-		return;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	vc4_crtc_state->assigned_channel = VC4_HVS_CHANNEL_DISABLED;
-	__drm_atomic_helper_crtc_reset(crtc, &vc4_crtc_state->base);
+	__drm_atomic_helper_crtc_state_init(&vc4_crtc_state->base, crtc);
+
+	return &vc4_crtc_state->base;
 }
 
 int vc4_crtc_late_register(struct drm_crtc *crtc)
 {
 	struct drm_device *drm = crtc->dev;
@@ -1168,11 +1166,11 @@ static const struct drm_crtc_funcs vc4_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = vc4_page_flip,
 	.set_property = NULL,
 	.cursor_set = NULL, /* handled by drm_mode_cursor_universal */
 	.cursor_move = NULL, /* handled by drm_mode_cursor_universal */
-	.reset = vc4_crtc_reset,
+	.atomic_create_state = vc4_crtc_create_state,
 	.atomic_duplicate_state = vc4_crtc_duplicate_state,
 	.atomic_destroy_state = vc4_crtc_destroy_state,
 	.enable_vblank = vc4_enable_vblank,
 	.disable_vblank = vc4_disable_vblank,
 	.get_vblank_timestamp = drm_crtc_vblank_helper_get_vblank_timestamp,
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 0f5958c1e6b6..649032174dbd 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -947,11 +947,11 @@ int vc4_page_flip(struct drm_crtc *crtc,
 int vc4_crtc_atomic_check(struct drm_crtc *crtc,
 			  struct drm_atomic_commit *state);
 struct drm_crtc_state *vc4_crtc_duplicate_state(struct drm_crtc *crtc);
 void vc4_crtc_destroy_state(struct drm_crtc *crtc,
 			    struct drm_crtc_state *state);
-void vc4_crtc_reset(struct drm_crtc *crtc);
+struct drm_crtc_state *vc4_crtc_create_state(struct drm_crtc *crtc);
 void vc4_crtc_handle_vblank(struct vc4_crtc *crtc);
 void vc4_crtc_send_vblank(struct drm_crtc *crtc);
 int vc4_crtc_late_register(struct drm_crtc *crtc);
 void vc4_crtc_get_margins(struct drm_crtc_state *state,
 			  unsigned int *left, unsigned int *right,
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index bc3f366fc3e6..c469f8b1068b 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -423,11 +423,11 @@ static int vc4_txp_enable_vblank(struct drm_crtc *crtc)
 static void vc4_txp_disable_vblank(struct drm_crtc *crtc) {}
 
 static const struct drm_crtc_funcs vc4_txp_crtc_funcs = {
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= vc4_page_flip,
-	.reset			= vc4_crtc_reset,
+	.atomic_create_state	= vc4_crtc_create_state,
 	.atomic_duplicate_state	= vc4_crtc_duplicate_state,
 	.atomic_destroy_state	= vc4_crtc_destroy_state,
 	.enable_vblank		= vc4_txp_enable_vblank,
 	.disable_vblank		= vc4_txp_disable_vblank,
 	.late_register		= vc4_crtc_late_register,

-- 
2.55.0

