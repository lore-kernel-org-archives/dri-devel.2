Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0930C43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1257010F1A7;
	Wed,  8 Jul 2026 16:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XiBgQMro";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5B610F1A7
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:08:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A685C4374F;
 Wed,  8 Jul 2026 16:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CEB1F000E9;
 Wed,  8 Jul 2026 16:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783526933;
 bh=e9LVHQLg2+1ZYF7HK39eNc1XiMoRnpg1/B77Df6e5F4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XiBgQMrocfSxsEfqZYfNFTXjSDqS3eoO7P3sXs6lH1ayX47oXUH5ZuJDVzhYY21oY
 h/Ch5zuBUTXJv3vvCini4F3+aTDJ04/H7Ea55o80Eqn/vjwxkdRnKobx/3u0dFEzUu
 MK9R+Og/tETuE/9zliyfdZlgaHfx+jgGWgO9/A/3AnlulAjSx/Gss6CFBWlNabwpOw
 ZvRh1Edvjo7yWdUrS8LEvLvf2TU+8aCBAXfI+4boAsBetgrHaeeSyINa+TuzCjBZ8g
 ukBMYdVU3INDqUS+6JOY5nl1dmwUAdWymvmgjyjhZ7SARyNMEKTplcOAOQ9DGBxC2w
 2MQeFLa82MFow==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 08 Jul 2026 18:08:38 +0200
Subject: [PATCH RFC 1/8] drm/atomic: colorop: Rename state to state_to_destroy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-drm-reset-state-flag-v1-1-c37dc985485d@kernel.org>
References: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
In-Reply-To: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3248; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9PtCPj01wJRDN2U3FHhpuJ1zKvRXV7fetbVHLeFTn/Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl+Zby9IWs7uYQPGPfLfZftsHeR6M8Sd7teuUX4qERO0
 74VItM6prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwERSNzJWs6w6MX/r/cJ/Ra+f
 eYavCDm4nHnhQYMfwh7bVkUbXOU+0bNjAwujRRtb+4y/T3a2cwgyMjYsjWZS1F1zvOSqKpdNQ6j
 oeZOChYsW2U9w27Ah5l2RbMO7gAWPvCSUJpRwuWUUTZE8nAEA
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
 drivers/gpu/drm/drm_atomic.c        |  4 ++--
 drivers/gpu/drm/drm_atomic_helper.c |  2 +-
 include/drm/drm_atomic.h            | 18 +++++++++++++++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 735ab7badc2e..4bc6bdfb6f1f 100644
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
2.54.0

