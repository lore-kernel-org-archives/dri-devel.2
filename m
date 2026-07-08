Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A52C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51D110F1C0;
	Wed,  8 Jul 2026 16:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IHtSYZeb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF9C10F1B7
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:09:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70A2840F24;
 Wed,  8 Jul 2026 16:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B3E1F000E9;
 Wed,  8 Jul 2026 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783526945;
 bh=XBNlzrm2VUnzVBrb3FW1lerts2iFVkqleFLxdiQpBp4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IHtSYZebmnZw11RU2iJ+M8pdzcQvKUU1dDyDEX/Qox+08aS6llFDeufE5JBj0PKQm
 wIldvovdnAr8U5TBzIPDCBhGhhC/U2OJzKFStsDTLp8VJtQ74VSy8nOAKUXpCvt3hw
 zWbhFgma0d63TQBikyzYl+BNo8QiWNTavYnhh18edBZy3cw9+mA+sgzBmdHolVU6Y7
 2cjLS1RUSdeK+UIXsPNjxFpk6UPAZhno2YIPXnBd94omfEreWiTgSSjuQbWDJ2A5Mq
 WSDG0QOGJoLUChRLfMEQNuliKhnZeOYOz65Hg2oWZAClItEVz2nW120NKRP41Dcfju
 csuX8exd1xGTw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 08 Jul 2026 18:08:43 +0200
Subject: [PATCH RFC 6/8] drm/atomic: Create function to insert connector
 state into a commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-drm-reset-state-flag-v1-6-c37dc985485d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4467; i=mripard@kernel.org;
 h=from:subject:message-id; bh=G+HVYHInY7UyUBvxRjBWcTIdkFXetkDN+/ALC9mefto=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl+ZfzJYs0i7LdZRNZEnXlUMIFptYXgJ+d+6zwevsVWO
 7fOnHu5YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEyEYxtjfcDy5A/92RYiy+Uv
 bxNS+nPxCZforas/1ndPtnBzb4n0/eg1xTZu6y1xn9Z3P4qqa2/9Y2xYc3nNxr4ly/Y4ercw8qw
 Pn39XJpzhOf+3pRt9ipQMvqh5VO0xEHwUrurAdN07MrdxaRIA
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
index d4dcab2d851c..79971d4b56a4 100644
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
2.54.0

