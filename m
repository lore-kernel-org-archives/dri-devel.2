Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C737C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54DB10EC29;
	Tue,  8 Sep 2026 14:35:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AD210EC29
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:35:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58181601DB;
 Tue,  8 Sep 2026 14:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8486C1F00A3D;
 Tue,  8 Sep 2026 14:35:34 +0000 (UTC)
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 08 Sep 2026 16:35:06 +0200
Subject: [PATCH v3 05/11] drm/atomic: Create function to insert private obj
 state into a commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-reset-state-flag-v3-5-905570f387a4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3941; i=mripard@kernel.org;
 h=from:subject:message-id; bh=aGtwc+jsBW8u3XkMa+jusPXWSRKAVFkN5fj8q3v+qSA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkLZGU/7Fx554LVxI6NZ29GhIkc87/7gd1swqKnk9cd9
 PExkrQ+1jGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmwrCWsWHC6lvOV6f4v5+l
 /XhOYK6Kuun2hao2EfE8KWd/yspd2Xzo5MNt3G9P3TipObO5b4LIzizGhu0ybKn7V/aV+H/Wm1f
 y7cUmq43tLI93hwroGdXPusDYeIjJ+aXs/mdhoU8+lMQuEr2yHAA=
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

drm_atomic_get_private_obj_state() allocates a new private object
state by duplicating the current one and inserts it into the atomic
commit as a single operation.

However, a later change will need to insert a private object state
into a commit without going through the full allocation and
duplication path in drm_atomic_get_private_obj_state().

Extract the state insertion logic, including the array reallocation,
into a new static drm_atomic_commit_set_private_obj_state() helper,
and convert drm_atomic_get_private_obj_state() to use it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 57 ++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index f6a31c9d477d..1be4af940ed1 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1101,10 +1101,41 @@ drm_atomic_private_obj_fini(struct drm_private_obj *obj)
 	obj->funcs->atomic_destroy_state(obj, obj->state);
 	drm_modeset_lock_fini(&obj->lock);
 }
 EXPORT_SYMBOL(drm_atomic_private_obj_fini);
 
+static int drm_atomic_commit_set_private_obj_state(struct drm_atomic_commit *commit,
+						   struct drm_private_obj *obj,
+						   struct drm_private_state *obj_state)
+{
+	struct __drm_private_objs_state *arr;
+	int index, num_objs;
+	size_t size;
+
+	drm_modeset_lock_assert_held(&obj->lock);
+
+	num_objs = commit->num_private_objs + 1;
+	size = sizeof(*commit->private_objs) * num_objs;
+	arr = krealloc(commit->private_objs, size, GFP_KERNEL);
+	if (!arr)
+		return -ENOMEM;
+
+	commit->private_objs = arr;
+	index = commit->num_private_objs;
+	memset(&commit->private_objs[index], 0, sizeof(*commit->private_objs));
+
+	commit->private_objs[index].state_to_destroy = obj_state;
+	commit->private_objs[index].old_state = obj->state;
+	commit->private_objs[index].new_state = obj_state;
+	commit->private_objs[index].ptr = obj;
+	obj_state->state = commit;
+
+	commit->num_private_objs = num_objs;
+
+	return 0;
+}
+
 /**
  * drm_atomic_get_private_obj_state - get private object state
  * @state: global atomic state
  * @obj: private object to get the state for
  *
@@ -1117,13 +1148,11 @@ EXPORT_SYMBOL(drm_atomic_private_obj_fini);
  */
 struct drm_private_state *
 drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
 				 struct drm_private_obj *obj)
 {
-	int index, num_objs, ret;
-	size_t size;
-	struct __drm_private_objs_state *arr;
+	int ret;
 	struct drm_private_state *obj_state;
 
 	WARN_ON(!state->acquire_ctx);
 	drm_WARN_ON(state->dev, state->checked);
 
@@ -1133,31 +1162,19 @@ drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
 
 	ret = drm_modeset_lock(&obj->lock, state->acquire_ctx);
 	if (ret)
 		return ERR_PTR(ret);
 
-	num_objs = state->num_private_objs + 1;
-	size = sizeof(*state->private_objs) * num_objs;
-	arr = krealloc(state->private_objs, size, GFP_KERNEL);
-	if (!arr)
-		return ERR_PTR(-ENOMEM);
-
-	state->private_objs = arr;
-	index = state->num_private_objs;
-	memset(&state->private_objs[index], 0, sizeof(*state->private_objs));
-
 	obj_state = obj->funcs->atomic_duplicate_state(obj);
 	if (!obj_state)
 		return ERR_PTR(-ENOMEM);
 
-	state->private_objs[index].state_to_destroy = obj_state;
-	state->private_objs[index].old_state = obj->state;
-	state->private_objs[index].new_state = obj_state;
-	state->private_objs[index].ptr = obj;
-	obj_state->state = state;
-
-	state->num_private_objs = num_objs;
+	ret = drm_atomic_commit_set_private_obj_state(state, obj, obj_state);
+	if (ret) {
+		obj->funcs->atomic_destroy_state(obj, obj_state);
+		return ERR_PTR(ret);
+	}
 
 	drm_dbg_atomic(state->dev,
 		       "Added new private object %p state %p to %p\n",
 		       obj, obj_state, state);
 

-- 
2.55.0

