Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC40C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22DC210F1B5;
	Wed,  8 Jul 2026 16:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aICbbck2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9748110F1B5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:08:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F37D601D9;
 Wed,  8 Jul 2026 16:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A251F000E9;
 Wed,  8 Jul 2026 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783526938;
 bh=gKSeSbYXgSfM92sgbcX2oAZv75cRfJIEeGO45LS1JR4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=aICbbck2G1ogn4pOF0EQLv0ASmJTLd3TQEwWdDD/zf3LKbjwoKYhEcNmgeNE0zGFg
 77AowNjgTCYW/lu/lFnmrhTDMBw+SUeRq8Ja+T03VA2aN4r7cpkPOVZPjnCxGdExBd
 AsIGUzwGNWtjBlzLFXtpJ0k4gIUnK5TPyInNFflk54XCk61u7E1sH+/ReUHU7m4F9h
 iK60u80ccIADb1CYMjiHY11uLKXGZ4XYaI+q5IHvA8PI3Y2C+A0p7/jNI0amO4Isgo
 Eg7W2WD0Ndc2fjA9bdLwyaPep5chjPmOSP4g9qIVuvsnWTkJ6wi9Iz/fAX9ILhYwi7
 W/E6yMmzBMqEA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 08 Jul 2026 18:08:40 +0200
Subject: [PATCH RFC 3/8] drm/atomic: Create function to insert plane state
 into a commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-drm-reset-state-flag-v1-3-c37dc985485d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2806; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+m3EkhPCSKnDM62Sj8VCyS0IMXT5OeoiJOPJ7/JI43k=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl+ZXyiq4z59y8u3Pbe5H9PyfXvU7Yp/L/+5Qan4+aMo
 +F3rv5Z1TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmsqGMseHYtfqJ97v7ciue
 b1h7VFTxQtakadf6q/bqHjt66ZnenX/X1Vpulq5mKtW4funo6r7T7i8YG1Y7mHM1ZjbIbi/yDKm
 9XvfjbfZZ2Wz21odyE3r2TP115oCpxf5L0rfYTZISjAyPNd6WBgA=
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
index 4ffe5147ab16..56542494ab56 100644
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
2.54.0

