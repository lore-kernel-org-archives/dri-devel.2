Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C0EC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE3110F1B7;
	Wed,  8 Jul 2026 16:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bYkqo2SJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E1B10F1B7
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:09:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C34E43E3C;
 Wed,  8 Jul 2026 16:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE371F000E9;
 Wed,  8 Jul 2026 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783526943;
 bh=bJhaJGOcpd7DYv+YzWF0KEhFbZbraRFxmpqaLW2Zs+Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=bYkqo2SJkTlhpj1jdzLRG1pWyO2OPkX8z8qzygof5WyYHNeJLq8CdepI5/Wp7U5cP
 JODXT8v6LFBghYDbnK7qwne11SiiFZptVmjL11MMWcLAFmzmncPUjFRzlrBBE7aKLa
 67OdEAVCxssyiZjD0DLUqgecViw602Hwgkbk63TXkVj8J7+yrrcz2JQF4+jho7mM+Q
 ATa1kwo7v32ZMRyqoxaYWw82sv7Wil6UJ5V+MXrojLRr0zm//qMoshvH2JEt0O280Q
 5HvSv6Wt1zyAlVPvk8676bIA2EApXHJBpMsAt56SrZkLVV6qet3eJOqDamKBSng67J
 4wYYLWMO/iuUw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 08 Jul 2026 18:08:42 +0200
Subject: [PATCH RFC 5/8] drm/atomic: Create function to insert private obj
 state into a commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-drm-reset-state-flag-v1-5-c37dc985485d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3941; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tFHqYNW5dmxUwonpBjXRaJzyfHwYkrZ5+BMI6moJfLo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl+ZfwHj5z8dfbMMtWowNPLLc9suW7B/J6r4NuyqsrFC
 lZvdKfbdkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJsK1ibJi7/vRiq9vfuLJM
 u183vrruMCN9wro/s/1VakR05m+X/MC5K+TNtvT5V6Z8Mzr3KYzlwQbGWvEVqs0ZTk+WLYm5f+1
 yhcbPonATX6b+oEN1SzO08/ZvDOztPTTj9IS0XTYiUxykrQ4+AgA=
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
index f006de9b7263..d4dcab2d851c 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1097,10 +1097,41 @@ drm_atomic_private_obj_fini(struct drm_private_obj *obj)
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
@@ -1113,13 +1144,11 @@ EXPORT_SYMBOL(drm_atomic_private_obj_fini);
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
 
@@ -1129,31 +1158,19 @@ drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
 
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
2.54.0

