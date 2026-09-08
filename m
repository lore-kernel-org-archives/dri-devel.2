Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05E7C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968C010E9DC;
	Tue,  8 Sep 2026 14:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dAcXXL2P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85FFE10EC26
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:35:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 05E32601DE;
 Tue,  8 Sep 2026 14:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B6B1F00A3E;
 Tue,  8 Sep 2026 14:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788878119;
 bh=rhbPg4XZXLlcdCtHG8r7d95+Q7hYT+p0CMQ+ukMM0+8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dAcXXL2PVD9eNa8FkFtNSvGEAy3REIco//NLmuzoZ0y+sqCNGOXo70KxKPkbshKjb
 7ME4qeK26032suIE27/BdFJPz+JuNtde+5Dy6VvYOZFFdut0Gnh9O7IK9iWt5yxP+S
 up0Nni72Kx/gLFCTz15ymwXjl2phG0KRn5ilQ7f4js28QQhwjMVibRw4jqu9Th5r5G
 ezG8bkqOKmqpCA1vM+0tXC41eUnjsmAwFXuB2+BxK/SgLu47JWM/JGnSIvZXQzDnz9
 lFuE8fzH3kOsfZNhxRHAEFrmAEBPo7F5Q3IxrDkGGxeg0Eaa6pZcd01WMYGzNxBTpL
 /5tLmJ0cq//ZQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 08 Sep 2026 16:35:02 +0200
Subject: [PATCH v3 01/11] drm/atomic: colorop: Rename state to state_to_destroy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-reset-state-flag-v3-1-905570f387a4@kernel.org>
References: <20260908-drm-reset-state-flag-v3-0-905570f387a4@kernel.org>
In-Reply-To: <20260908-drm-reset-state-flag-v3-0-905570f387a4@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3757; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tUdqkKg02G7pZNM/cxmM4hrdK64B6/77cjhDvSy80wQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkLZKV5+ObIWmew+75udTTa2twZEfP4ghLHfe6cpD1LF
 nYuEPfpmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABPZxcjYsNRsylRB30wXEdPd
 Tv+PT2nufr9Hft1iT1dZ9f0vL2Z1HUq9mzml6ajIhH+3b7yr37llI2PD7ufflN9qHSk+m+MtnPD
 q8i7eE32yerwz/lYZXZknfaOLNVvfYe9mLebNzY7fWj5pK6QCAA==
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

The atomic state tracking structures used to have a generic state
field to track the state to free when tearing down the
drm_atomic_commit. It has since been renamed to state_to_destroy in
__drm_planes_state, __drm_crtcs_state, __drm_connnectors_state, and
__drm_private_objs_state to better describe its purpose.

The colorop support has been added after that rename, but
__drm_colorops_state still uses the old state name. Rename it to
state_to_destroy for consistency, and add the matching kerneldoc.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c        |  6 +++---
 drivers/gpu/drm/drm_atomic_helper.c |  2 +-
 include/drm/drm_atomic.h            | 18 +++++++++++++++++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 45df6376f408..5c0f7b7024d1 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -341,13 +341,13 @@ void drm_atomic_commit_default_clear(struct drm_atomic_commit *state)
 
 		if (!colorop)
 			continue;
 
 		drm_colorop_atomic_destroy_state(colorop,
-						 state->colorops[i].state);
+						 state->colorops[i].state_to_destroy);
 		state->colorops[i].ptr = NULL;
-		state->colorops[i].state = NULL;
+		state->colorops[i].state_to_destroy = NULL;
 		state->colorops[i].old_state = NULL;
 		state->colorops[i].new_state = NULL;
 	}
 
 	for (i = 0; i < state->num_private_objs; i++) {
@@ -706,11 +706,11 @@ drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
 
 	colorop_state = drm_atomic_helper_colorop_duplicate_state(colorop);
 	if (!colorop_state)
 		return ERR_PTR(-ENOMEM);
 
-	state->colorops[index].state = colorop_state;
+	state->colorops[index].state_to_destroy = colorop_state;
 	state->colorops[index].ptr = colorop;
 	state->colorops[index].old_state = colorop->state;
 	state->colorops[index].new_state = colorop_state;
 	colorop_state->state = state;
 
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 285aac3554df..c4752bd7d999 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3349,11 +3349,11 @@ int drm_atomic_helper_swap_state(struct drm_atomic_commit *state,
 		WARN_ON(colorop->state != old_colorop_state);
 
 		old_colorop_state->state = state;
 		new_colorop_state->state = NULL;
 
-		state->colorops[i].state = old_colorop_state;
+		state->colorops[i].state_to_destroy = old_colorop_state;
 		colorop->state = new_colorop_state;
 	}
 
 	drm_panic_lock(state->dev, flags);
 	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 88087910ab1a..00b3e9fc429a 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -157,11 +157,27 @@ struct drm_crtc_commit {
 	bool abort_completion;
 };
 
 struct __drm_colorops_state {
 	struct drm_colorop *ptr;
-	struct drm_colorop_state *state, *old_state, *new_state;
+
+	/**
+	 * @state_to_destroy:
+	 *
+	 * Used to track the @drm_colorop_state we will need to free
+	 * when tearing down the associated &drm_atomic_commit in
+	 * $drm_mode_config_funcs.atomic_state_clear or
+	 * drm_atomic_commit_default_clear().
+	 *
+	 * Before a commit, and the call to
+	 * drm_atomic_helper_swap_state() in particular, it points to
+	 * the same state than @new_state. After a commit, it points to
+	 * the same state than @old_state.
+	 */
+	struct drm_colorop_state *state_to_destroy;
+
+	struct drm_colorop_state *old_state, *new_state;
 };
 
 struct __drm_planes_state {
 	struct drm_plane *ptr;
 

-- 
2.55.0

