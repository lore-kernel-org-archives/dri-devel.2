Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFE5C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C465A10E6C2;
	Tue,  8 Sep 2026 14:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BEz2sfP/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7919010E6C2
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:35:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 60B0B43A86;
 Tue,  8 Sep 2026 14:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B860C1F00ACA;
 Tue,  8 Sep 2026 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788878127;
 bh=bqBWshvt3L6MTIRaqkZiDc6MNSNPGD81ogLG36xTIIg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BEz2sfP/ZwE43hDKsTyCe3K9a1usqzxP2GqopSFANewtxzFAF78Rt0Gq3FQqrUZDK
 4fx+h5+G1O6B/wmcVZJUG4e/XPeotusY80Uq3GgBoRGJGAs5sK9u1exr74VDgWOevA
 g+pAAmIh3uwDFUvaTHWQweiDvfR0x9hl//XA2vqHO2I5URSyf7UAYC2OpQxyKZUoaH
 mD5Lq0SXO3O1VgUxeVz+v1my4wJ94UTdLw/rWTRyBaX6gIg8CTa4NxmdpPooyR5FDF
 mxHBXfs13g4LzqZQY7SuhB/Kiw7qYC0sOEJgL5AVN37FMRgP33ECeGhAyPw1Na8WHX
 8JCCFtiIz9s1Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 08 Sep 2026 16:35:04 +0200
Subject: [PATCH v3 03/11] drm/atomic: Create function to insert plane state
 into a commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-reset-state-flag-v3-3-905570f387a4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2806; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SBXepA+Kzx2kmCXRTs2XA6GB/9sKhpv4dQQh4KGM1yE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkLZGUCKrn1cxZYyWvt5SnhZlp0JTpPwP+QjJdmy4sa8
 2Pqxzd1TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInsZWZs+DIlMy7uwq2Cidyz
 g841bbi569PDVKXz1++/XyHHHH6pzCb3mo7xtEsn+7fMF5D72/lLnLFOZV91guXCk3MzamXym1I
 WrX97xGjS37l9r+LuCTO6L1ZLfXNbYf/d8CjtbVJ7XS0WbJMGAA==
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

drm_atomic_get_plane_state() allocates a new plane state by
duplicating the current one and inserts it into the atomic commit as
a single operation.

However, a later change will need to insert a plane state into a
commit without going through the full allocation and duplication path
in drm_atomic_get_plane_state().

Extract the state insertion logic into a new static
drm_atomic_commit_set_plane_state() helper, and convert
drm_atomic_get_plane_state() to use it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 153d959bd4ff..f62323679f44 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -624,10 +624,27 @@ static int drm_atomic_connector_check(struct drm_connector *connector,
 	}
 
 	return 0;
 }
 
+static int drm_atomic_commit_set_plane_state(struct drm_atomic_commit *commit,
+					     struct drm_plane *plane,
+					     struct drm_plane_state *plane_state)
+{
+	int index = drm_plane_index(plane);
+
+	drm_modeset_lock_assert_held(&plane->mutex);
+
+	commit->planes[index].state_to_destroy = plane_state;
+	commit->planes[index].old_state = plane->state;
+	commit->planes[index].new_state = plane_state;
+	commit->planes[index].ptr = plane;
+	plane_state->state = commit;
+
+	return 0;
+}
+
 /**
  * drm_atomic_get_plane_state - get plane state
  * @state: global atomic state object
  * @plane: plane to get state object for
  *
@@ -642,11 +659,11 @@ static int drm_atomic_connector_check(struct drm_connector *connector,
  */
 struct drm_plane_state *
 drm_atomic_get_plane_state(struct drm_atomic_commit *state,
 			  struct drm_plane *plane)
 {
-	int ret, index = drm_plane_index(plane);
+	int ret;
 	struct drm_plane_state *plane_state;
 
 	WARN_ON(!state->acquire_ctx);
 	drm_WARN_ON(state->dev, state->checked);
 
@@ -665,15 +682,15 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
 
 	plane_state = plane->funcs->atomic_duplicate_state(plane);
 	if (!plane_state)
 		return ERR_PTR(-ENOMEM);
 
-	state->planes[index].state_to_destroy = plane_state;
-	state->planes[index].ptr = plane;
-	state->planes[index].old_state = plane->state;
-	state->planes[index].new_state = plane_state;
-	plane_state->state = state;
+	ret = drm_atomic_commit_set_plane_state(state, plane, plane_state);
+	if (ret) {
+		plane->funcs->atomic_destroy_state(plane, plane_state);
+		return ERR_PTR(ret);
+	}
 
 	drm_dbg_atomic(plane->dev, "Added [PLANE:%d:%s] %p state to %p\n",
 		       plane->base.id, plane->name, plane_state, state);
 
 	if (plane_state->crtc) {

-- 
2.55.0

