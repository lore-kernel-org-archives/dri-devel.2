Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54787606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSrkGYrU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D5E10F4A6;
	Tue, 24 Nov 2026 11:00:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F1610F498;
 Tue, 24 Nov 2026 11:00:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D42962603;
 Tue, 24 Nov 2026 11:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B011F000CF;
 Tue, 24 Nov 2026 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795518017;
 bh=xi/Ursx4fEzBxR9dLzWPFfuKiBUmJqw45mfCVHFQpAI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jSrkGYrUV0Mx8pCwX0guJfm9HfU+serxPSErYTL/J82PqUO6UZxg2F0oNfiBrEfd9
 /qDcRpqwDZ4wfH0N9gr+uP+VDjoua1K0WaaEm6lC53EqF9gkU5Qc3czoA+DErKM+Ni
 JDIXiJW9XTE721EWoSdhb0OJxHQ9RAWKev0vz1guRHwB+ErREBMS/7Tk968T9zIaCV
 fJk98m2FM/vPslGn6FkoNnEnN9+9dNzikK8Bv0YZcBiPtkutnSZKfp2GBtmTkz8+vK
 cC1zL4yob6Uf82fn33HWFOZr1IU4owSvdzgZDQdvlEWq2JoHxZ4ZpQyGcsJP5Lj6IH
 1bSXluwBui1AQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 24 Nov 2026 11:59:54 +0100
Subject: [PATCH 4/6] drm/i915: Implement plane atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-drm-i915-conversion-state-readout-v1-4-b7132f72644d@kernel.org>
References: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
In-Reply-To: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10334; i=mripard@kernel.org;
 h=from:subject:message-id; bh=fzBptSg0bGFpW148Wd+PpoYRR45RtUtNEVQCKbQEUdc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmsebofTL1ev7z5ofDRJ0ad/BPR5dUxRvPM1l7nY668G
 SLwtKO4YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkWT5jwwydhQnfTpdL+QfM
 M374tuie0T3xJ73igTpnmPwm5u3XOvTzsW2Q98Le37OXTnKfd/KnE2N9csIp3rl9vl84c82D9iy
 8kM6/2+PL96BNZ1cd5ncKygg/lXN9op5Hl4vFRZVE2zJRJkcA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The atomic_create_state callback allocates a pristine, initialized,
state for the object it is called on, without any side effect.

The upcoming DRM_MODE_ATOMIC_RESET flag of the atomic ioctl relies on
it to bring the whole device back to its default state, by filling a
commit with such states through
drm_atomic_commit_fill_with_defaults(). Both the reset itself and the
DRM_CAP_ATOMIC_RESET capability reporting are gated on
drm_atomic_implements_create_state(), which requires every plane, CRTC
and connector of the device to implement the hook: without it, the
reset is rejected with -EOPNOTSUPP.

The other atomic_create_state() users don't apply to i915: it reads
the state the firmware left behind out of the hardware at probe time,
so it never goes through drm_mode_config_create_initial_state() nor
the hardware state readout helpers. The atomic reset is thus the only
user the hook enables here.

The i915 plane functions don't implement it, relying on
intel_plane_alloc() initializing the state inline instead.

Provide an intel_plane_create_state() function allocating and
resetting a pristine state, have intel_plane_alloc() rely on it, and
assign it to all the plane functions.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/i915/display/i9xx_plane.c          |  2 ++
 drivers/gpu/drm/i915/display/intel_cursor.c        |  1 +
 drivers/gpu/drm/i915/display/intel_plane.c         | 25 ++++++++++++++++------
 drivers/gpu/drm/i915/display/intel_plane.h         |  1 +
 drivers/gpu/drm/i915/display/intel_sprite.c        |  3 +++
 drivers/gpu/drm/i915/display/skl_universal_plane.c |  3 +++
 6 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/i9xx_plane.c b/drivers/gpu/drm/i915/display/i9xx_plane.c
index 0902b17d0269..bfaa74a669d3 100644
--- a/drivers/gpu/drm/i915/display/i9xx_plane.c
+++ b/drivers/gpu/drm/i915/display/i9xx_plane.c
@@ -882,10 +882,11 @@ static unsigned int i9xx_plane_min_alignment(struct intel_plane *plane,
 
 static const struct drm_plane_funcs i965_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = intel_plane_destroy,
+	.atomic_create_state = intel_plane_create_state,
 	.atomic_duplicate_state = intel_plane_duplicate_state,
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = i965_plane_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
 	DRM_PANIC_PLANE_FUNCS,
@@ -893,10 +894,11 @@ static const struct drm_plane_funcs i965_plane_funcs = {
 
 static const struct drm_plane_funcs i8xx_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = intel_plane_destroy,
+	.atomic_create_state = intel_plane_create_state,
 	.atomic_duplicate_state = intel_plane_duplicate_state,
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = i8xx_plane_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
 	DRM_PANIC_PLANE_FUNCS,
diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index 4afd275de86e..b20c1259284c 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -1124,10 +1124,11 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
 
 static const struct drm_plane_funcs intel_cursor_plane_funcs = {
 	.update_plane = intel_legacy_cursor_update,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = intel_plane_destroy,
+	.atomic_create_state = intel_plane_create_state,
 	.atomic_duplicate_state = intel_plane_duplicate_state,
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = intel_cursor_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
 };
diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index d23de0f34e4b..7cc2d9e96052 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -71,28 +71,39 @@ static void intel_plane_state_reset(struct intel_plane_state *plane_state,
 
 	plane_state->scaler_id = -1;
 	plane_state->fence_id = -1;
 }
 
-struct intel_plane *intel_plane_alloc(void)
+struct drm_plane_state *intel_plane_create_state(struct drm_plane *plane)
 {
 	struct intel_plane_state *plane_state;
+
+	plane_state = kzalloc_obj(*plane_state);
+	if (!plane_state)
+		return ERR_PTR(-ENOMEM);
+
+	intel_plane_state_reset(plane_state, to_intel_plane(plane));
+
+	return &plane_state->uapi;
+}
+
+struct intel_plane *intel_plane_alloc(void)
+{
+	struct drm_plane_state *plane_state;
 	struct intel_plane *plane;
 
 	plane = kzalloc_obj(*plane);
 	if (!plane)
 		return ERR_PTR(-ENOMEM);
 
-	plane_state = kzalloc_obj(*plane_state);
-	if (!plane_state) {
+	plane_state = intel_plane_create_state(&plane->base);
+	if (IS_ERR(plane_state)) {
 		kfree(plane);
-		return ERR_PTR(-ENOMEM);
+		return ERR_CAST(plane_state);
 	}
 
-	intel_plane_state_reset(plane_state, plane);
-
-	plane->base.state = &plane_state->uapi;
+	plane->base.state = plane_state;
 
 	return plane;
 }
 
 void intel_plane_free(struct intel_plane *plane)
diff --git a/drivers/gpu/drm/i915/display/intel_plane.h b/drivers/gpu/drm/i915/display/intel_plane.h
index dba2be24aae2..23595e0a6af7 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.h
+++ b/drivers/gpu/drm/i915/display/intel_plane.h
@@ -61,10 +61,11 @@ void intel_plane_disable_arm(struct intel_dsb *dsb,
 			     struct intel_plane *plane,
 			     const struct intel_crtc_state *crtc_state);
 struct intel_plane *intel_plane_alloc(void);
 void intel_plane_free(struct intel_plane *plane);
 void intel_plane_destroy(struct drm_plane *plane);
+struct drm_plane_state *intel_plane_create_state(struct drm_plane *plane);
 struct drm_plane_state *intel_plane_duplicate_state(struct drm_plane *plane);
 void intel_plane_destroy_state(struct drm_plane *plane,
 			       struct drm_plane_state *state);
 void intel_crtc_planes_update_noarm(struct intel_dsb *dsb,
 				    struct intel_atomic_state *state,
diff --git a/drivers/gpu/drm/i915/display/intel_sprite.c b/drivers/gpu/drm/i915/display/intel_sprite.c
index 2321bfbb8630..971495f23deb 100644
--- a/drivers/gpu/drm/i915/display/intel_sprite.c
+++ b/drivers/gpu/drm/i915/display/intel_sprite.c
@@ -1562,30 +1562,33 @@ static bool vlv_sprite_format_mod_supported(struct drm_plane *_plane,
 
 static const struct drm_plane_funcs g4x_sprite_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = intel_plane_destroy,
+	.atomic_create_state = intel_plane_create_state,
 	.atomic_duplicate_state = intel_plane_duplicate_state,
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = g4x_sprite_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
 };
 
 static const struct drm_plane_funcs snb_sprite_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = intel_plane_destroy,
+	.atomic_create_state = intel_plane_create_state,
 	.atomic_duplicate_state = intel_plane_duplicate_state,
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = snb_sprite_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
 };
 
 static const struct drm_plane_funcs vlv_sprite_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = intel_plane_destroy,
+	.atomic_create_state = intel_plane_create_state,
 	.atomic_duplicate_state = intel_plane_duplicate_state,
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = vlv_sprite_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
 };
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 8bdf1b8a0229..74f53774a6b2 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -2712,10 +2712,11 @@ static bool tgl_plane_format_mod_supported(struct drm_plane *_plane,
 
 static const struct drm_plane_funcs skl_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = intel_plane_destroy,
+	.atomic_create_state = intel_plane_create_state,
 	.atomic_duplicate_state = intel_plane_duplicate_state,
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = skl_plane_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
 	DRM_PANIC_PLANE_FUNCS,
@@ -2723,10 +2724,11 @@ static const struct drm_plane_funcs skl_plane_funcs = {
 
 static const struct drm_plane_funcs icl_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = intel_plane_destroy,
+	.atomic_create_state = intel_plane_create_state,
 	.atomic_duplicate_state = intel_plane_duplicate_state,
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = icl_plane_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
 	DRM_PANIC_PLANE_FUNCS,
@@ -2734,10 +2736,11 @@ static const struct drm_plane_funcs icl_plane_funcs = {
 
 static const struct drm_plane_funcs tgl_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = intel_plane_destroy,
+	.atomic_create_state = intel_plane_create_state,
 	.atomic_duplicate_state = intel_plane_duplicate_state,
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = tgl_plane_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
 	DRM_PANIC_PLANE_FUNCS,

-- 
2.56.1

