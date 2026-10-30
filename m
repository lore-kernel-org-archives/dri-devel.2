Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F5606A325
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ig3eCdfU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB3611289B;
	Fri, 30 Oct 2026 15:17:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2CC1128BC;
 Fri, 30 Oct 2026 15:15:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 64CD14166E;
 Fri, 30 Oct 2026 15:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEA91F00A15;
 Fri, 30 Oct 2026 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373357;
 bh=OfQfeB/lY4PhSdBThFZ9Gr8J70nQ6YHAF4IvgkivYWg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ig3eCdfUZSqd+ephiIZZBn4F0zrt/e3VDu4w1Wz9yIhFKHLYI7SpjF1T/VJ52OKn3
 zql0xB3rws/5u+YiGux2Lfwdv0ZE+ulU/F71AVpU+BldUVz6E8XRbFuq1fCYrBdE5O
 VGeabBM+q3p2hYDS+YGbXKZGg6CmN7aYK8tF2p7VEetVTbeKBuJhCQop5cOnm5KwDC
 nu8HvGAH50o+z9Grm+HJDGJLFCc/sZ2o+TqpQ0jxlgZC79lbVnCWUH6R1KCR4f6JxG
 6RRLcn2aj8l+8Lj5BIFD2teKhtM9lldzPL4uP4frlM3NGLgWknpp3GXFDiXvoZ7mEl
 IzKC+Caqy3GGg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:14:04 +0100
Subject: [PATCH v3 34/37] drm/nouveau: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-34-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 nouveau@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10409; i=mripard@kernel.org;
 h=from:subject:message-id; bh=llEWuQF9v5JRGFW4LQ7LxQ3LHSyvYVLcf7ZG1Y6VHHE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtuholzXv3Xq5SfZJX3wug+fTq3H7mGdJFb//0ex7P
 PrZY0bDjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRN42MDdsNTzI9475Q+pLz
 Yd/puR/jorXOcnq4m19sDxAK91F2nFg59+u0bXL3A+ZnqalqejbXM9ZZPcn69WbNvL1rMue/eXN
 l2Wp73du9K9lVFPXmHvllyj09N+7WCqZjD4+eYjyl2vfqkfsRAA==
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

The nouveau connector reset implementation creates a custom state
subclass, but only initializes a pristine state and sets
driver-specific defaults without resetting any hardware. This is
equivalent to what atomic_create_state expects. Convert to it.

This is significantly harder than the other drivers though, since
pre-nv50 display doesn't support atomic modesetting. Instead, its
connectors keep their property state embedded in struct
nouveau_connector, and drm_connector.state is left NULL.

Thus, only the atomic path needs to be converted, with the embedded
state initialized at connector creation time for pre-nv50.  Those
connectors are also given connector funcs without atomic_create_state:
the DRM core would otherwise install the embedded state into
drm_connector.state and eventually pass it to atomic_destroy_state,
which frees it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  25 ++++--
 drivers/gpu/drm/nouveau/nouveau_connector.c | 129 +++++++++++++++++++++-------
 drivers/gpu/drm/nouveau/nouveau_connector.h |   3 +-
 3 files changed, 119 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e91130f93db6..98a5188f6523 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1249,7 +1249,7 @@ nv50_mstc_destroy(struct drm_connector *connector)
 static const struct drm_connector_funcs
 nv50_mstc = {
-	.reset = nouveau_conn_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = nv50_mstc_destroy,
+	.atomic_create_state = nouveau_conn_atomic_create_state,
 	.atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
 	.atomic_destroy_state = nouveau_conn_atomic_destroy_state,
@@ -1263,4 +1263,5 @@ nv50_mstc_new(struct nv50_mstm *mstm, struct drm_dp_mst_port *port,
 {
 	struct drm_device *dev = mstm->outp->base.base.dev;
+	struct drm_connector_state *conn_state;
 	struct drm_crtc *crtc;
 	struct nv50_mstc *mstc;
@@ -1274,13 +1275,16 @@ nv50_mstc_new(struct nv50_mstm *mstm, struct drm_dp_mst_port *port,
 	ret = drm_connector_dynamic_init(dev, &mstc->connector, &nv50_mstc,
 					 DRM_MODE_CONNECTOR_DisplayPort, NULL);
-	if (ret) {
-		kfree(*pmstc);
-		*pmstc = NULL;
-		return ret;
-	}
+	if (ret)
+		goto err_free;
 
 	drm_connector_helper_add(&mstc->connector, &nv50_mstc_help);
 
-	mstc->connector.funcs->reset(&mstc->connector);
+	conn_state = mstc->connector.funcs->atomic_create_state(&mstc->connector);
+	if (IS_ERR(conn_state)) {
+		ret = PTR_ERR(conn_state);
+		goto err_cleanup;
+	}
+	mstc->connector.state = conn_state;
+
 	nouveau_conn_attach_properties(&mstc->connector);
 
@@ -1298,4 +1302,11 @@ nv50_mstc_new(struct nv50_mstm *mstm, struct drm_dp_mst_port *port,
 	drm_dp_mst_get_port_malloc(port);
 	return 0;
+
+err_cleanup:
+	drm_connector_cleanup(&mstc->connector);
+err_free:
+	kfree(*pmstc);
+	*pmstc = NULL;
+	return ret;
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index cc3caf8de64b..e472c23c2981 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -243,23 +243,8 @@ nouveau_conn_atomic_duplicate_state(struct drm_connector *connector)
 }
 
-void
-nouveau_conn_reset(struct drm_connector *connector)
+static void
+nouveau_conn_atom_init(struct drm_connector *connector,
+		       struct nouveau_conn_atom *asyc)
 {
-	struct nouveau_connector *nv_connector = nouveau_connector(connector);
-	struct nouveau_conn_atom *asyc;
-
-	if (drm_drv_uses_atomic_modeset(connector->dev)) {
-		if (WARN_ON(!(asyc = kzalloc_obj(*asyc))))
-			return;
-
-		if (connector->state)
-			nouveau_conn_atomic_destroy_state(connector,
-							  connector->state);
-
-		__drm_atomic_helper_connector_reset(connector, &asyc->state);
-	} else {
-		asyc = &nv_connector->properties_state;
-	}
-
 	asyc->dither.mode = DITHERING_MODE_AUTO;
 	asyc->dither.depth = DITHERING_DEPTH_AUTO;
@@ -281,4 +266,19 @@ nouveau_conn_reset(struct drm_connector *connector)
 }
 
+struct drm_connector_state *
+nouveau_conn_atomic_create_state(struct drm_connector *connector)
+{
+	struct nouveau_conn_atom *asyc;
+
+	asyc = kzalloc_obj(*asyc);
+	if (WARN_ON(!asyc))
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_connector_state_init(&asyc->state, connector);
+	nouveau_conn_atom_init(connector, asyc);
+
+	return &asyc->state;
+}
+
 void
 nouveau_conn_attach_properties(struct drm_connector *connector)
@@ -1231,5 +1231,47 @@ static const struct drm_connector_funcs
 nouveau_connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
-	.reset = nouveau_conn_reset,
+	.detect = nouveau_connector_detect,
+	.force = nouveau_connector_force,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.set_property = nouveau_connector_set_property,
+	.destroy = nouveau_connector_destroy,
+	.atomic_create_state = nouveau_conn_atomic_create_state,
+	.atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
+	.atomic_destroy_state = nouveau_conn_atomic_destroy_state,
+	.atomic_set_property = nouveau_conn_atomic_set_property,
+	.atomic_get_property = nouveau_conn_atomic_get_property,
+	.late_register = nouveau_connector_late_register,
+	.early_unregister = nouveau_connector_early_unregister,
+};
+
+static const struct drm_connector_funcs
+nouveau_connector_funcs_lvds = {
+	.dpms = drm_helper_connector_dpms,
+	.detect = nouveau_connector_detect_lvds,
+	.force = nouveau_connector_force,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.set_property = nouveau_connector_set_property,
+	.destroy = nouveau_connector_destroy,
+	.atomic_create_state = nouveau_conn_atomic_create_state,
+	.atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
+	.atomic_destroy_state = nouveau_conn_atomic_destroy_state,
+	.atomic_set_property = nouveau_conn_atomic_set_property,
+	.atomic_get_property = nouveau_conn_atomic_get_property,
+	.late_register = nouveau_connector_late_register,
+	.early_unregister = nouveau_connector_early_unregister,
+};
+
+/*
+ * Pre-nv50 doesn't support atomic modesetting: the connector property state
+ * lives in the embedded struct nouveau_connector.properties_state and
+ * drm_connector.state is left alone, as expected from a legacy driver.
+ *
+ * Those connectors must not expose atomic_create_state: the DRM core would
+ * then install the embedded state into drm_connector.state and eventually
+ * pass it to atomic_destroy_state, which frees it.
+ */
+static const struct drm_connector_funcs
+nouveau_connector_funcs_legacy = {
+	.dpms = drm_helper_connector_dpms,
 	.detect = nouveau_connector_detect,
 	.force = nouveau_connector_force,
@@ -1246,7 +1288,6 @@ nouveau_connector_funcs = {
 
 static const struct drm_connector_funcs
-nouveau_connector_funcs_lvds = {
+nouveau_connector_funcs_lvds_legacy = {
 	.dpms = drm_helper_connector_dpms,
-	.reset = nouveau_conn_reset,
 	.detect = nouveau_connector_detect_lvds,
 	.force = nouveau_connector_force,
@@ -1362,5 +1403,7 @@ nouveau_connector_create(struct drm_device *dev, int index)
 	struct nouveau_display *disp = nouveau_display(dev);
 	struct nouveau_connector *nv_connector = NULL;
+	struct drm_connector_state *conn_state;
 	struct drm_connector *connector;
+	const struct drm_connector_funcs *funcs;
 	struct drm_connector_list_iter conn_iter;
 	int type, ret = 0;
@@ -1459,8 +1502,17 @@ nouveau_connector_create(struct drm_device *dev, int index)
 
 	type = drm_conntype_from_dcb(nv_connector->type);
-	if (type == DRM_MODE_CONNECTOR_LVDS)
-		drm_connector_init(dev, connector, &nouveau_connector_funcs_lvds, type);
-	else
-		drm_connector_init(dev, connector, &nouveau_connector_funcs, type);
+	if (type == DRM_MODE_CONNECTOR_LVDS) {
+		if (drm_drv_uses_atomic_modeset(dev))
+			funcs = &nouveau_connector_funcs_lvds;
+		else
+			funcs = &nouveau_connector_funcs_lvds_legacy;
+	} else {
+		if (drm_drv_uses_atomic_modeset(dev))
+			funcs = &nouveau_connector_funcs;
+		else
+			funcs = &nouveau_connector_funcs_legacy;
+	}
+
+	drm_connector_init(dev, connector, funcs, type);
 
 	switch (type) {
@@ -1514,13 +1566,26 @@ nouveau_connector_create(struct drm_device *dev, int index)
 						   nouveau_connector_irq, NVIF_CONN_EVENT_V0_IRQ,
 						   &nv_connector->irq);
-			if (ret) {
-				nvif_event_dtor(&nv_connector->hpd);
-				nvif_conn_dtor(&nv_connector->conn);
+			if (ret)
 				goto drm_conn_err;
-			}
 		}
 	}
 
-	connector->funcs->reset(connector);
+	if (drm_drv_uses_atomic_modeset(dev)) {
+		conn_state = connector->funcs->atomic_create_state(connector);
+		if (IS_ERR(conn_state)) {
+			ret = PTR_ERR(conn_state);
+			goto drm_conn_err;
+		}
+		connector->state = conn_state;
+	} else {
+		/* Pre-nv50 keeps its property state embedded in struct
+		 * nouveau_connector: drm_connector.state must remain NULL,
+		 * the DRM core expects legacy drivers to use
+		 * drm_connector.encoder.
+		 */
+		nouveau_conn_atom_init(connector,
+				       &nv_connector->properties_state);
+	}
+
 	nouveau_conn_attach_properties(connector);
 
@@ -1567,4 +1632,8 @@ nouveau_connector_create(struct drm_device *dev, int index)
 
 drm_conn_err:
+	nvif_event_dtor(&nv_connector->irq);
+	nvif_event_dtor(&nv_connector->hpd);
+	cancel_work_sync(&nv_connector->irq_work);
+	nvif_conn_dtor(&nv_connector->conn);
 	drm_connector_cleanup(connector);
 	kfree(nv_connector);
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index eb292d2ba4bc..02f843648eb8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -217,5 +217,6 @@ extern int nouveau_hdmimhz;
 
 void nouveau_conn_attach_properties(struct drm_connector *);
-void nouveau_conn_reset(struct drm_connector *);
+struct drm_connector_state *
+nouveau_conn_atomic_create_state(struct drm_connector *);
 struct drm_connector_state *
 nouveau_conn_atomic_duplicate_state(struct drm_connector *);

-- 
2.55.0

