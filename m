Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C2D606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYtohhFS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB3410EA08;
	Fri,  6 Nov 2026 13:15:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C3E810E4FE
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D92C42488;
 Fri,  6 Nov 2026 13:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872AA1F0089F;
 Fri,  6 Nov 2026 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970904;
 bh=Tzzi+q72iXHiFsz8ENn2h2L3JLnJA5jqNgcq6rFSyUw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TYtohhFS9VJPX+Pm1oyiHU7RsiPopwWByBZYe+zkgrKoyUXDXn+XW8rC82JCmdN4F
 vd69Jl/eVueyFuQR3m2HfT6qNCIOons8/6K0mQgTLsYVqRZcz53tT6XaCjcJbryvkS
 jblE2PKYvLxp6uCwU3PiZcjVGPX95RCOMKjKpbkBziwsImvQgJ/DbicmCu6FOt6c9h
 /16UG9TAiBfkUAPN+tLW8LadO92HFdb2EvhbGsmJ87/sTdUliVRTU36eB66KqvvHvX
 g/HEZsiR4QnT9UizMU44Tb6ZOdtQva+AW/Ik8JRdc6n+/8bXRsr/LQ7KXrTHp2d9gW
 Uj3L4yBpnKJmw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:19 +0100
Subject: [PATCH v8 06/39] drm/atomic: Fix private obj error handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-6-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2525; i=mripard@kernel.org;
 h=from:subject:message-id; bh=F2D3zpePnzO3XHf2BSurzq6EE6ySG8V0m2MGQaeHwvU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL62XPRw2u/zRIrfYF3HTuyZFvGfdMK0q3OHs3tlOJ
 32b3nq3dExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJzLvK2DDjp5P9wsCp1W1d
 PtJr5+35NrlULLYr6TXDXbfg42xnfbNa8r2Pf83tUJtb1rdF6465F2OtBOuM/Hk1918pc87zYLo
 mvkdm51m+xQeNQxqjEt57yqX7HJqd4sBgLftv+m1L4Z87dqQBAA==
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_atomic_private_obj_init() initializes the modeset lock and adds the
object to the privobj_list before calling atomic_create_state().

However, if atomic_create_state() fails, the function returns the error
directly without removing the object from the list or cleaning up the
lock. This leaves a dangling entry in privobj_list and a leaked lock.

Fix this by unwinding both operations in an error path.

Fixes: b962a12050a3 ("drm/atomic: integrate modeset lock with private objects")
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 81591173265d..a1f18fc96b4c 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1063,6 +1063,15 @@ int drm_atomic_private_obj_init(struct drm_device *dev,
 {
 	struct drm_private_state *state;
+	int ret;
+
 	memset(obj, 0, sizeof(*obj));
 
+	/*
+	 * Keep the list node in a state drm_atomic_private_obj_fini()
+	 * can safely handle if we fail before adding it to the private
+	 * objects list.
+	 */
+	INIT_LIST_HEAD(&obj->head);
+
 	drm_modeset_lock_init(&obj->lock);
 
@@ -1072,10 +1081,17 @@ int drm_atomic_private_obj_init(struct drm_device *dev,
 
 	state = obj->funcs->atomic_create_state(obj);
-	if (IS_ERR(state))
-		return PTR_ERR(state);
+	if (IS_ERR(state)) {
+		ret = PTR_ERR(state);
+		goto err_list_del;
+	}
 
 	obj->state = state;
 
 	return 0;
+
+err_list_del:
+	list_del_init(&obj->head);
+	drm_modeset_lock_fini(&obj->lock);
+	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_private_obj_init);
@@ -1090,5 +1106,16 @@ void
 drm_atomic_private_obj_fini(struct drm_private_obj *obj)
 {
-	list_del(&obj->head);
+	/*
+	 * Some callers ignore drm_atomic_private_obj_init() failures
+	 * and unconditionally register a teardown action that calls
+	 * this function. Use list_del_init() rather than list_del() so
+	 * that calling drm_atomic_private_obj_fini() twice, after both
+	 * a failed and a successful drm_atomic_private_obj_init(),
+	 * remains safe.
+	 */
+	if (list_empty(&obj->head))
+		return;
+
+	list_del_init(&obj->head);
 	obj->funcs->atomic_destroy_state(obj, obj->state);
 	drm_modeset_lock_fini(&obj->lock);

-- 
2.55.0

