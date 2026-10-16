Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AB4CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6768010E202;
	Fri, 16 Oct 2026 07:32:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2637611263A
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:32:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EEE0601FE;
 Fri, 16 Oct 2026 07:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D9F1F000C4;
 Fri, 16 Oct 2026 07:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792135945;
 bh=7BW84V2ROisULkBTaVZHKSFcq1ej0GE9zWxoBRb6B9w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LcU7z/F3dVEFw9dYwM8pRMVK5GoCcTdbd/Dz4I8shGmDjHSTMJn/bBz9fqOiqeeLg
 n5p1xuCkA9QiybSnhHl056I3mH4647YoAA9kUSwqYJYVLZLZ9reTFDKiUjSSu06JDu
 OJiryVCtS/8DmSLUybe+uhlMnpFamvxzFO1flUbNHE6gBbEMNNXLHiDAQSaJyEXo8X
 VPkUFfQpuJYyAF4pyUjL2YCm/zAy7WT5ADkI1XFYWjYZOCXzXHlZ6qmADEbDuT8nLA
 U7PaUaNcHVUiuUcrabIFC75SlxvtOdyKRCDbDXigsLIXo84jWZmeAT3FqsEPFVhbI8
 lPtRRrAFaFNIw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 16 Oct 2026 09:31:39 +0200
Subject: [PATCH v5 07/14] drm/atomic: Create function to insert private obj
 state into a commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-drm-reset-state-flag-v5-7-dad2d64b693b@kernel.org>
References: <20261016-drm-reset-state-flag-v5-0-dad2d64b693b@kernel.org>
In-Reply-To: <20261016-drm-reset-state-flag-v5-0-dad2d64b693b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3836; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1wiVliL0xqxSktWJmPZm/odmf5wb35Kj9QlH1jOLiu0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkXLz3epPWh/trSowUvf71Rj+i3q3u5p1NCtPyDiWOju
 E2xYs/TjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRiTmMDesbREys/Kc9rjv6
 hoMpRdOfQ/Lxo0POW7h/SopxVKh/mM1YmNVokfLt+P+/licenLgZxFhfU8787r7Gj3h+uxuBK2V
 Mf+13kTO/VbL5rc2ksy+vTXt98ULHj9Q9rctdV7/L8+Po/3AUAA==
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

Reviewed-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 53 +++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 807b575ecc54..513e91ad2fdc 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1093,10 +1093,39 @@ drm_atomic_private_obj_fini(struct drm_private_obj *obj)
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
+
+	drm_modeset_lock_assert_held(&obj->lock);
+
+	num_objs = commit->num_private_objs + 1;
+	arr = krealloc_array(commit->private_objs, num_objs,
+			     sizeof(*commit->private_objs), GFP_KERNEL | __GFP_ZERO);
+	if (!arr)
+		return -ENOMEM;
+
+	commit->private_objs = arr;
+	index = commit->num_private_objs;
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
@@ -1109,12 +1138,11 @@ EXPORT_SYMBOL(drm_atomic_private_obj_fini);
  */
 struct drm_private_state *
 drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
 				 struct drm_private_obj *obj)
 {
-	int index, num_objs, ret;
-	struct __drm_private_objs_state *arr;
+	int ret;
 	struct drm_private_state *obj_state;
 
 	WARN_ON(!state->acquire_ctx);
 	drm_WARN_ON(state->dev, state->checked);
 
@@ -1124,30 +1152,19 @@ drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
 
 	ret = drm_modeset_lock(&obj->lock, state->acquire_ctx);
 	if (ret)
 		return ERR_PTR(ret);
 
-	num_objs = state->num_private_objs + 1;
-	arr = krealloc_array(state->private_objs, num_objs,
-			     sizeof(*state->private_objs), GFP_KERNEL | __GFP_ZERO);
-	if (!arr)
-		return ERR_PTR(-ENOMEM);
-
-	state->private_objs = arr;
-	index = state->num_private_objs;
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

