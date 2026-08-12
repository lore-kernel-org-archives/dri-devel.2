Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BDDC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03AD910EFAB;
	Wed, 12 Aug 2026 12:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="am2VnvAg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B97B110EFAB
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:57:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A148A403E8;
 Wed, 12 Aug 2026 12:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C62C1F00A3E;
 Wed, 12 Aug 2026 12:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786539439;
 bh=6s13Q+j8wBnnuEdnJ/nL5ccmcNMkL8DlD+sgq0/D/7I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=am2VnvAgyCIGbMQaX1L3tdBsH5aA9XZTR5Ld7sr1F+fZajZDZc6VhGhaGWeGCxpvM
 oGhOvXA0iajopp0j7rSvKyd0r3yKIRRfpTAALq9hbaaI3+L8H7+n9rm8eLWDCuDIzl
 nksvrKuMnWoGk25Se24/jRbiupF203vKRzq07OKoa0BZAd/gVsX53DIQ3xf9K9dSxx
 S/FtzJRAQOttOLY9CvPmRl8c/7cCoNQq701vNPs3b74nh7KViD+upfUJpAsINxfCLd
 Us5/k0SaLUY3ktAhkMvG3w1r6/zvaDSNRei+yqpmGMJUHL6ueWHGlLgb6XZWvhMnie
 p/eGY3PsjpeuA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 12 Aug 2026 14:57:01 +0200
Subject: [PATCH RFC v2 6/9] drm/atomic: Create function to insert connector
 state into a commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-drm-reset-state-flag-v2-6-e96ce13317dd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4467; i=mripard@kernel.org;
 h=from:subject:message-id; bh=wDaUru3PKCxU0DIl/uXL+Fj/EweBL/7abRjPRJwuSBY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFk1uXMyJHOKLsrc2MinxHnme0jW3fkrjwRm3mWO+v0vZ
 vcR+11ZHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiAsGM9RWM7g0dlrL64TfS
 P3N3F56xXhuub5uckLPu2FH5VH3tFYFrAxamaH/QeKq0iXH3vN1yjA2rD+zqPLtu8QeT4qIl2/7
 Y3XDiYTlYXyQpcKNihfoauRg1qdaeNPmTKemTVu47xdZ+fi0A
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

drm_atomic_get_connector_state() allocates a new connector state by
duplicating the current one and inserts it into the atomic commit as
a single operation.

However, a later change will need to insert a connector state into a
commit without going through the full allocation and duplication path
in drm_atomic_get_connector_state().

Extract the state insertion logic, including the dynamic array
reallocation, into a new static
drm_atomic_commit_set_connector_state() helper, and convert
drm_atomic_get_connector_state() to use it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 67 +++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 88cdb65698c9..e78f7eb6bfd1 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1408,10 +1408,46 @@ drm_atomic_get_new_crtc_for_encoder(struct drm_atomic_commit *state,
 
 	return conn_state->crtc;
 }
 EXPORT_SYMBOL(drm_atomic_get_new_crtc_for_encoder);
 
+static int drm_atomic_commit_set_connector_state(struct drm_atomic_commit *commit,
+						 struct drm_connector *connector,
+						 struct drm_connector_state *connector_state)
+{
+	struct drm_mode_config *config = &connector->dev->mode_config;
+	int index;
+
+	drm_modeset_lock_assert_held(&config->connection_mutex);
+
+	index = drm_connector_index(connector);
+	if (index >= commit->num_connector) {
+		struct __drm_connnectors_state *c;
+		int alloc = max(index + 1, config->num_connector);
+
+		c = krealloc_array(commit->connectors, alloc,
+				   sizeof(*commit->connectors), GFP_KERNEL);
+		if (!c)
+			return -ENOMEM;
+
+		commit->connectors = c;
+		memset(&commit->connectors[commit->num_connector], 0,
+		       sizeof(*commit->connectors) * (alloc - commit->num_connector));
+
+		commit->num_connector = alloc;
+	}
+
+	drm_connector_get(connector);
+	commit->connectors[index].state_to_destroy = connector_state;
+	commit->connectors[index].old_state = connector->state;
+	commit->connectors[index].new_state = connector_state;
+	commit->connectors[index].ptr = connector;
+	connector_state->state = commit;
+
+	return 0;
+}
+
 /**
  * drm_atomic_get_connector_state - get connector state
  * @state: global atomic state object
  * @connector: connector to get state object for
  *
@@ -1426,53 +1462,34 @@ EXPORT_SYMBOL(drm_atomic_get_new_crtc_for_encoder);
  */
 struct drm_connector_state *
 drm_atomic_get_connector_state(struct drm_atomic_commit *state,
 			  struct drm_connector *connector)
 {
-	int ret, index;
+	int ret;
 	struct drm_mode_config *config = &connector->dev->mode_config;
 	struct drm_connector_state *connector_state;
 
 	WARN_ON(!state->acquire_ctx);
 	drm_WARN_ON(state->dev, state->checked);
 
 	ret = drm_modeset_lock(&config->connection_mutex, state->acquire_ctx);
 	if (ret)
 		return ERR_PTR(ret);
 
-	index = drm_connector_index(connector);
-
-	if (index >= state->num_connector) {
-		struct __drm_connnectors_state *c;
-		int alloc = max(index + 1, config->num_connector);
-
-		c = krealloc_array(state->connectors, alloc,
-				   sizeof(*state->connectors), GFP_KERNEL);
-		if (!c)
-			return ERR_PTR(-ENOMEM);
-
-		state->connectors = c;
-		memset(&state->connectors[state->num_connector], 0,
-		       sizeof(*state->connectors) * (alloc - state->num_connector));
-
-		state->num_connector = alloc;
-	}
-
 	connector_state = drm_atomic_get_new_connector_state(state, connector);
 	if (connector_state)
 		return connector_state;
 
 	connector_state = connector->funcs->atomic_duplicate_state(connector);
 	if (!connector_state)
 		return ERR_PTR(-ENOMEM);
 
-	drm_connector_get(connector);
-	state->connectors[index].state_to_destroy = connector_state;
-	state->connectors[index].old_state = connector->state;
-	state->connectors[index].new_state = connector_state;
-	state->connectors[index].ptr = connector;
-	connector_state->state = state;
+	ret = drm_atomic_commit_set_connector_state(state, connector, connector_state);
+	if (ret) {
+		connector->funcs->atomic_destroy_state(connector, connector_state);
+		return ERR_PTR(ret);
+	}
 
 	drm_dbg_atomic(connector->dev, "Added [CONNECTOR:%d:%s] %p state to %p\n",
 			 connector->base.id, connector->name,
 			 connector_state, state);
 

-- 
2.55.0

