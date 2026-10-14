Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE890CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A54910FEA1;
	Wed, 14 Oct 2026 17:31:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A624210FF12;
 Wed, 14 Oct 2026 17:31:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49911438E6;
 Wed, 14 Oct 2026 17:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A941F000C4;
 Wed, 14 Oct 2026 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999087;
 bh=j+Wtz8SQYtbFs08yWKHqc0eHXgowvnC+4zbFkIxAoeM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=b32Tjb2qnskl+6ljOdyLTX4tif134CLj49PgPQNX/iapXxXyb5OrfQ+/Kqa+UoedW
 149OyAmrSMd/YAtJGzVdJfo8VMfDw7sS/NJkqvVlcA3K9w9btPWL7+jOQHopA5+eEK
 Migzxse7E8qpIY2AqOd04Aw4CTeYIuOmK5laz7AXc2rhxVP3G/XZW8AU8KZn2rNQHB
 MKtBRQpWb77CtN6pqropILfNG1vwm+Fm9/mWbwnd2+781Uan9uQx22FpUSGXPHGogQ
 EFDgZzvqQtgZxiN5eAHQfBaBCn7DCsF3erRvoIYttP2KOtRNu/HBLRNpVT9T+falXF
 G7HMMSprsXKwg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:33 +0200
Subject: [PATCH 70/75] drm/nouveau: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-70-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 nouveau@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5858; i=mripard@kernel.org;
 h=from:subject:message-id; bh=b1ANrMPL/HoPDBmHmDKQIhmMBZPDBs1wNXjFvSoyazk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd2duvpa4avvm3Ts+l/p0Ln0mJvUqLLBEnen1Ls9nr
 w5cF/2d3TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmcsuLseHOolmMsdVtxxju
 ryq5uMRohaKod0PJs1iPQJXE0pLJoVdDH2gcNEo1/up76EefAqtsKGPDxt1XV0q9y9tqbZW+cTP
 T4Vjenv4eqytSe5fmy5l2xZQm6bY+vSPfbD9nybnYn8qnZroBAA==
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

The nouveau connector reset implementation creates a custom state
subclass, but only initializes a pristine state and sets
driver-specific defaults without resetting any hardware. This is
equivalent to what atomic_create_state expects. Convert to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  9 ++++++---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 25 ++++++++++++++-----------
 drivers/gpu/drm/nouveau/nouveau_connector.h |  3 ++-
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e91130f93db6..39a23d0e9be5 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1246,11 +1246,11 @@ nv50_mstc_destroy(struct drm_connector *connector)
 	kfree(mstc);
 }
 
 static const struct drm_connector_funcs
 nv50_mstc = {
-	.reset = nouveau_conn_reset,
+	.atomic_create_state = nouveau_conn_atomic_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = nv50_mstc_destroy,
 	.atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
 	.atomic_destroy_state = nouveau_conn_atomic_destroy_state,
 	.atomic_set_property = nouveau_conn_atomic_set_property,
@@ -1279,12 +1279,15 @@ nv50_mstc_new(struct nv50_mstm *mstm, struct drm_dp_mst_port *port,
 		return ret;
 	}
 
 	drm_connector_helper_add(&mstc->connector, &nv50_mstc_help);
 
-	mstc->connector.funcs->reset(&mstc->connector);
-	nouveau_conn_attach_properties(&mstc->connector);
+	mstc->connector.state = mstc->connector.funcs->atomic_create_state(&mstc->connector);
+	if (IS_ERR(mstc->connector.state)) {
+		drm_connector_cleanup(&mstc->connector);
+		return PTR_ERR(mstc->connector.state);
+	}
 
 	drm_for_each_crtc(crtc, dev) {
 		if (!(mstm->outp->dcb->heads & drm_crtc_mask(crtc)))
 			continue;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index cc3caf8de64b..59c8091c6796 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -240,25 +240,21 @@ nouveau_conn_atomic_duplicate_state(struct drm_connector *connector)
 	asyc->procamp = armc->procamp;
 	asyc->set.mask = 0;
 	return &asyc->state;
 }
 
-void
-nouveau_conn_reset(struct drm_connector *connector)
+struct drm_connector_state *
+nouveau_conn_atomic_create_state(struct drm_connector *connector)
 {
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	struct nouveau_conn_atom *asyc;
 
 	if (drm_drv_uses_atomic_modeset(connector->dev)) {
 		if (WARN_ON(!(asyc = kzalloc_obj(*asyc))))
-			return;
+			return ERR_PTR(-ENOMEM);
 
-		if (connector->state)
-			nouveau_conn_atomic_destroy_state(connector,
-							  connector->state);
-
-		__drm_atomic_helper_connector_reset(connector, &asyc->state);
+		__drm_atomic_helper_connector_state_init(&asyc->state, connector);
 	} else {
 		asyc = &nv_connector->properties_state;
 	}
 
 	asyc->dither.mode = DITHERING_MODE_AUTO;
@@ -276,10 +272,12 @@ nouveau_conn_reset(struct drm_connector *connector)
 			break;
 		default:
 			break;
 		}
 	}
+
+	return &asyc->state;
 }
 
 void
 nouveau_conn_attach_properties(struct drm_connector *connector)
 {
@@ -1228,11 +1226,11 @@ nouveau_connector_helper_funcs = {
 };
 
 static const struct drm_connector_funcs
 nouveau_connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
-	.reset = nouveau_conn_reset,
+	.atomic_create_state = nouveau_conn_atomic_create_state,
 	.detect = nouveau_connector_detect,
 	.force = nouveau_connector_force,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.set_property = nouveau_connector_set_property,
 	.destroy = nouveau_connector_destroy,
@@ -1245,11 +1243,11 @@ nouveau_connector_funcs = {
 };
 
 static const struct drm_connector_funcs
 nouveau_connector_funcs_lvds = {
 	.dpms = drm_helper_connector_dpms,
-	.reset = nouveau_conn_reset,
+	.atomic_create_state = nouveau_conn_atomic_create_state,
 	.detect = nouveau_connector_detect_lvds,
 	.force = nouveau_connector_force,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.set_property = nouveau_connector_set_property,
 	.destroy = nouveau_connector_destroy,
@@ -1519,11 +1517,16 @@ nouveau_connector_create(struct drm_device *dev, int index)
 				goto drm_conn_err;
 			}
 		}
 	}
 
-	connector->funcs->reset(connector);
+	connector->state = connector->funcs->atomic_create_state(connector);
+	if (IS_ERR(connector->state)) {
+		ret = PTR_ERR(connector->state);
+		goto drm_conn_err;
+	}
+
 	nouveau_conn_attach_properties(connector);
 
 	/* Default scaling mode */
 	switch (nv_connector->type) {
 	case DCB_CONNECTOR_LVDS:
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index eb292d2ba4bc..02f843648eb8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -214,11 +214,12 @@ extern int nouveau_tv_disable;
 extern int nouveau_ignorelid;
 extern int nouveau_duallink;
 extern int nouveau_hdmimhz;
 
 void nouveau_conn_attach_properties(struct drm_connector *);
-void nouveau_conn_reset(struct drm_connector *);
+struct drm_connector_state *
+nouveau_conn_atomic_create_state(struct drm_connector *);
 struct drm_connector_state *
 nouveau_conn_atomic_duplicate_state(struct drm_connector *);
 void nouveau_conn_atomic_destroy_state(struct drm_connector *,
 				       struct drm_connector_state *);
 int nouveau_conn_atomic_set_property(struct drm_connector *,

-- 
2.55.0

