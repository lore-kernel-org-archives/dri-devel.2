Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25CAC982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F7B10F3BF;
	Fri, 18 Sep 2026 14:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kxbuRqIL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B4610F3BE
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:18:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C17243771;
 Fri, 18 Sep 2026 14:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5791F000FF;
 Fri, 18 Sep 2026 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789741104;
 bh=OKuaZrfatOHlSR0dx9iMm6UqgMduVRvClEIVFgHduLg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kxbuRqILT7AvQZnCqRCQQR/kAItC02XBOKx51Q3OSfAzM6WkzZSQu0Djm9TYRBh0D
 gB9RiOhvjEwy6WXStqLwOggnVbLkaQ2GIfy2Qcb7aYz+sHuwgl4Cl8S69Y+UhYAm7n
 wZ6xisxRZLgcL+QxuD4WrHN2iK331YHbmtBzkw5/FOc9OyFx1I3HDw3OQABLaPn5Iw
 nTxRt6OPgIdMd/V8wtcXGjXUmexZVOZIPLnwLU2lrK4fcWSwBabGNXWY5OT9BCxaJb
 DiesqSZKHL4r4xxi4fuKV8vCqy6sQ1P0IbbNANqUY2VKyJIDpdxdBzMdKTSoTQ0VHh
 2p6J1JuGtSt4A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 18 Sep 2026 16:17:55 +0200
Subject: [PATCH v4 06/13] drm/atomic: Create function to insert colorop
 state into a commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-drm-reset-state-flag-v4-6-5ad106370f05@kernel.org>
References: <20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org>
In-Reply-To: <20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2881; i=mripard@kernel.org;
 h=from:subject:message-id; bh=V5KSC2Y3Q/9B+8Et2em9ISdPFi1fOLtjjcyNtpS0Gu4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlrPYTSdrrOELLqWfLrwsmom4xPj07s2SAfP6lz03Zm5
 jszlAJ3d0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ/D/D2HCd24lhV8Rlx4IV
 XREh9ocsLH3SZ+tKyewL5Fk+U75a1zrqxMuwS86rFJeG737yuqXrD2ND0+/0PYeSTjL9CbBrZri
 ZVF9hfj7u2KPbu81a+vcdfFYa3sratnFX7jTNJ74FZoKWYdsA
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

drm_atomic_get_colorop_state() allocates a new colorop state by
duplicating the current one and inserts it into the atomic commit as
a single operation.

However, a later change will need to insert a colorop state into a
commit without going through the full allocation and duplication path
in drm_atomic_get_colorop_state().

Extract the state insertion logic into a new static
drm_atomic_commit_set_colorop_state() helper, and convert
drm_atomic_get_colorop_state() to use it.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index b26458ee98d8..807b575ecc54 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -702,10 +702,25 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
 
 	return plane_state;
 }
 EXPORT_SYMBOL(drm_atomic_get_plane_state);
 
+static void drm_atomic_commit_set_colorop_state(struct drm_atomic_commit *commit,
+						struct drm_colorop *colorop,
+						struct drm_colorop_state *colorop_state)
+{
+	int index = drm_colorop_index(colorop);
+
+	drm_modeset_lock_assert_held(&colorop->plane->mutex);
+
+	commit->colorops[index].state_to_destroy = colorop_state;
+	commit->colorops[index].old_state = colorop->state;
+	commit->colorops[index].new_state = colorop_state;
+	commit->colorops[index].ptr = colorop;
+	colorop_state->state = commit;
+}
+
 /**
  * drm_atomic_get_colorop_state - get colorop state
  * @state: global atomic state object
  * @colorop: colorop to get state object for
  *
@@ -721,11 +736,11 @@ EXPORT_SYMBOL(drm_atomic_get_plane_state);
  */
 struct drm_colorop_state *
 drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
 			     struct drm_colorop *colorop)
 {
-	int ret, index = drm_colorop_index(colorop);
+	int ret;
 	struct drm_colorop_state *colorop_state;
 
 	WARN_ON(!state->acquire_ctx);
 
 	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
@@ -738,15 +753,11 @@ drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
 
 	colorop_state = drm_atomic_helper_colorop_duplicate_state(colorop);
 	if (!colorop_state)
 		return ERR_PTR(-ENOMEM);
 
-	state->colorops[index].state_to_destroy = colorop_state;
-	state->colorops[index].ptr = colorop;
-	state->colorops[index].old_state = colorop->state;
-	state->colorops[index].new_state = colorop_state;
-	colorop_state->state = state;
+	drm_atomic_commit_set_colorop_state(state, colorop, colorop_state);
 
 	drm_dbg_atomic(colorop->dev, "Added [COLOROP:%d:%d] %p state to %p\n",
 		       colorop->base.id, colorop->type, colorop_state, state);
 
 	return colorop_state;

-- 
2.55.0

