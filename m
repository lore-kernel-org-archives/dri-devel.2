Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B42C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47F910EFA8;
	Wed, 12 Aug 2026 12:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nbqcEObF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E53010EFA8
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:57:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B689760DB5;
 Wed, 12 Aug 2026 12:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E885B1F000E9;
 Wed, 12 Aug 2026 12:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786539432;
 bh=6DKdJj5MKpM3O0y8X5AkvQk6AWDM1oJJkPw2hvfmZUU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nbqcEObFKKHSMqErcO0BKj8aN0Nax6lKBcjUilQlN+3jRD0xAlJGXDhvLuQrkxUY0
 Rr/upbaVW1tDqIUSNH3/4BMu/PkGblqExzBmsjyQq1DnJHBN0gS6jSQR8TkYCNmJs3
 DO7oKJxu/to2HuPYGDpRFYTIr2jWTtuZb5sHk7a1mNOn9lCQjrZO5H0fEXV8vvtHCQ
 bGW4lBBqxzzo634Ur7JZ6ewKnChGrMyACqR0bZII7cqymKIxdmDCPgTWqtQ8KKOvQh
 kA2B6W6lokuA/zALJpPr6KAHYNLnf8kmxmoFJIlcdUwekycgl8pWJgd3mP83dLwJrC
 sXWDTpN6Vkg3w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 12 Aug 2026 14:56:58 +0200
Subject: [PATCH RFC v2 3/9] drm/atomic: Create function to insert plane
 state into a commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-drm-reset-state-flag-v2-3-e96ce13317dd@kernel.org>
References: <20260812-drm-reset-state-flag-v2-0-e96ce13317dd@kernel.org>
In-Reply-To: <20260812-drm-reset-state-flag-v2-0-e96ce13317dd@kernel.org>
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
 h=from:subject:message-id; bh=v7jESdL4cHOWjb/Oz/3ZTHuGWO1WGBzHffGrF2n3Bi0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFk1ubPPvLheEf5lsfL5JTJv6rcvPu1S/GSTa5X0uy+8d
 r+9noVf7JjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT4TRnrC/oVj94UnvtTOb+
 210/FLgVAss5972dqLusLe8+ZxvnppOVoiEzzPbeXnbG/86nl6p1TYwNB2q8Vx1c+OlDl0wU91T
 rlq8HL9/WPSpYx7e84qPe9pt1P/0+vfkTJbk+MFXSY3L5FiNFAA==
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
index 91219c382d14..2ac26ed64823 100644
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

