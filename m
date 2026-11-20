Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC4606A33F
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2DnFM+9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 169791129F0;
	Fri, 20 Nov 2026 12:56:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A999A1129E5
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:56:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90C4643C4A;
 Fri, 20 Nov 2026 12:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E321F000CF;
 Fri, 20 Nov 2026 12:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179378;
 bh=D2FJoxddejJavfBNkPgy0lNvbhdffeLZ/sI/xAqO+1M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=b2DnFM+9daVNtAIiBNpUMZNQGolrC/ivkdx8opK88S1w+MtRscO5T+Z1ZjRPMCa2r
 JXOIr/QC1JO+vkTvOo/1Ns3tp7mB3v0XPp/0oJft/Fj+INdvhHgvlhjFEs0HUSZKxJ
 fBOvY5h3+obLp0CQO/QubP/M1pXoGjMRUWMWWLgdWguyKq+jj5QAIn7OjhgajKSueT
 ioiQt25T4FSSuCyqdmCUMe0inFAqDc94hAJMdkt//lpBWURwDbpZlDSgm+wF6pO8G6
 tCzAL/aFoZL6udXIMLTo4K64rupsbc+cXQXU6VZn1cUBEbEUNu/kuHdnEXsJs22doe
 21twzUhUySqPQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:09 +0100
Subject: [PATCH v9 17/42] drm/bridge: Handle bridges with hardware state
 readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-17-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9822; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0DIX5fD2XdIr0lof515AJOOpZJwRJPh3HtDKyhy7B5Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzlrlr5N+a3pLmjp7PNkusjv2u9vLKYcbbr2Ynr3w6
 e4gO+cFHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAigQ2M9QU32H+vurmUKyq6
 43bQtpPsNw/0xb9x++uk5K07netJsnrkk/lt860C3gpW+5Vsmh/UwNjw6mXuE560TVuzDk91LS3
 89+b/mkeiHT8/xy+NM71tv+LE0zNRexY5laxKzZG2ueY/c+tEAA==
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

Bridges use drm_private_obj for their atomic state, but their readout
needs special handling compared to other private objects.

Bridge drivers need the CRTC and connector states for their pipeline
to properly read out their own state. Since bridge registration does
not guarantee ordering, the readout must traverse each encoder's
bridge chain to ensure each bridge can query the state of preceding
bridges.

Add a drm_bridge_atomic_readout_priv_state() wrapper that looks up
the connector and CRTC states for the bridge's encoder, then forwards
to the bridge's atomic_sro_readout_state hook. Create a separate
drm_private_state_funcs vtable for bridges that support SRO so that
drm_atomic_sro_device_can_readout() can properly discriminate bridges
with and without SRO support.

The same applies when installing the state. Add an
atomic_sro_install_state hook to drm_bridge_funcs, and a
drm_bridge_atomic_install_priv_state() wrapper in that vtable that
calls it before the state of the bridge is replaced. The wrapper looks
up the connector and CRTC states of the pipeline the bridge is part of,
and only calls the hook if the pipeline was read out as active.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 138 ++++++++++++++++++++++++++++++++++++++++++-
 include/drm/drm_bridge.h     |  27 +++++++++
 2 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index b6cdbc172f68..868558a09f95 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -28,10 +28,11 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/srcu.h>
 
 #include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_atomic_state_readout.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
@@ -562,10 +563,118 @@ drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
 		return ERR_CAST(state);
 
 	return &state->base;
 }
 
+static struct drm_connector_state *
+find_connector_state_for_encoder(struct drm_atomic_sro_state *state,
+				struct drm_encoder *encoder)
+{
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *connector;
+
+	drm_connector_list_iter_begin(drm_atomic_sro_state_get_device(state),
+				      &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		struct drm_connector_state *conn_state =
+			drm_atomic_sro_get_connector_state(state, connector);
+
+		/*
+		 * The connector may not have a state in the readout
+		 * state: when the readout is limited to a commit, only
+		 * the connectors of that commit are read out.
+		 */
+		if (!conn_state)
+			continue;
+
+		if (encoder == conn_state->best_encoder) {
+			drm_connector_list_iter_end(&conn_iter);
+			return conn_state;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return NULL;
+}
+
+static int
+drm_bridge_atomic_readout_priv_state(struct drm_private_obj *obj,
+				     struct drm_atomic_sro_state *state,
+				     struct drm_private_state *priv_state)
+{
+	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
+	struct drm_encoder *encoder = bridge->encoder;
+	const struct drm_bridge_funcs *bridge_funcs = bridge->funcs;
+	struct drm_crtc_state *crtc_state;
+	struct drm_bridge_state *bridge_state;
+	struct drm_connector_state *conn_state;
+	int ret;
+
+	/*
+	 * If the bridge's encoder has no routed connector or no
+	 * active CRTC, the pipeline is disabled and there is nothing
+	 * to read out. Keep the pristine default state created by
+	 * &drm_mode_config_helper_funcs.atomic_sro_build_state.
+	 */
+	conn_state = find_connector_state_for_encoder(state, encoder);
+	if (!conn_state)
+		return 0;
+
+	if (!conn_state->crtc)
+		return 0;
+
+	crtc_state = drm_atomic_sro_get_crtc_state(state, conn_state->crtc);
+	if (!crtc_state)
+		return 0;
+
+	bridge_state = drm_priv_to_bridge_state(priv_state);
+	if (bridge_funcs->atomic_sro_readout_state) {
+		ret = bridge_funcs->atomic_sro_readout_state(
+			bridge, state, bridge_state, crtc_state, conn_state);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void
+drm_bridge_atomic_install_priv_state(struct drm_private_obj *obj,
+				     struct drm_private_state *priv_state)
+{
+	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
+
+	if (!bridge->funcs->atomic_sro_install_state)
+		return;
+
+	/*
+	 * &drm_mode_config_helper_funcs.atomic_sro_install_state
+	 * installs the connector and CRTC states before the private
+	 * objects ones, so we can look up the pipeline through the
+	 * current states. The state readout runs with all the modeset
+	 * locks held, including the connection mutex.
+	 */
+	connector = drm_atomic_get_connector_for_encoder_locked(bridge->encoder);
+	if (IS_ERR(connector))
+		return;
+
+	conn_state = connector->state;
+	if (!conn_state->crtc)
+		return;
+
+	crtc_state = conn_state->crtc->state;
+	if (!crtc_state || !crtc_state->active)
+		return;
+
+	bridge->funcs->atomic_sro_install_state(bridge,
+						drm_priv_to_bridge_state(priv_state),
+						crtc_state, conn_state);
+}
+
 static void
 drm_bridge_atomic_print_priv_state(struct drm_printer *p,
 				   const struct drm_private_state *s)
 {
 	const struct drm_bridge_state *state = drm_priv_to_bridge_state(s);
@@ -589,10 +698,19 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 	.atomic_print_state = drm_bridge_atomic_print_priv_state,
 };
 
+static const struct drm_private_state_funcs drm_bridge_priv_state_funcs_with_sro = {
+	.atomic_sro_readout_state = drm_bridge_atomic_readout_priv_state,
+	.atomic_sro_install_state = drm_bridge_atomic_install_priv_state,
+	.atomic_create_state = drm_bridge_atomic_create_priv_state,
+	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
+	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
+	.atomic_print_state = drm_bridge_atomic_print_priv_state,
+};
+
 /**
  * drm_private_obj_is_bridge - check if a private object backs a bridge
  * @obj: private object to check
  *
  * RETURNS:
@@ -600,11 +718,13 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
  * True if @obj is the &drm_private_obj embedded in a &struct drm_bridge,
  * false otherwise.
  */
 bool drm_private_obj_is_bridge(struct drm_private_obj *obj)
 {
-	return obj && obj->funcs == &drm_bridge_priv_state_funcs;
+	return obj &&
+	       (obj->funcs == &drm_bridge_priv_state_funcs ||
+		obj->funcs == &drm_bridge_priv_state_funcs_with_sro);
 }
 EXPORT_SYMBOL(drm_private_obj_is_bridge);
 
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
@@ -675,15 +795,27 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		ret = bridge->funcs->attach(bridge, encoder, flags);
 		if (ret < 0)
 			goto err_reset_bridge;
 	}
 
-	drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
-				    &drm_bridge_priv_state_funcs);
+	if (bridge->funcs &&
+	    bridge->funcs->atomic_sro_readout_state)
+		ret = drm_atomic_private_obj_init(bridge->dev, &bridge->base,
+						  bridge->name,
+						  &drm_bridge_priv_state_funcs_with_sro);
+	else
+		ret = drm_atomic_private_obj_init(bridge->dev, &bridge->base,
+						  bridge->name,
+						  &drm_bridge_priv_state_funcs);
+	if (ret)
+		goto err_detach_bridge;
 
 	return 0;
 
+err_detach_bridge:
+	if (bridge->funcs->detach)
+		bridge->funcs->detach(bridge);
 err_reset_bridge:
 	bridge->dev = NULL;
 	bridge->encoder = NULL;
 	mutex_lock(&encoder->bridge_chain_mutex);
 	list_del(&bridge->chain_node);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index ab0a6c03c8dd..7e30877a81cc 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -325,10 +325,37 @@ struct drm_bridge_funcs {
 					struct drm_atomic_sro_state *state,
 					struct drm_bridge_state *bridge_state,
 					struct drm_crtc_state *crtc_state,
 					struct drm_connector_state *conn_state);
 
+	/**
+	 * @atomic_sro_install_state:
+	 *
+	 * This optional hook is called when a state read out from
+	 * hardware is about to be installed as the bridge's current
+	 * state, and only if the bridge pipeline was read out as
+	 * active.
+	 *
+	 * It allows drivers to acquire the resources needed to keep
+	 * the current hardware state active, such as power supplies,
+	 * clocks, or interrupts, so that the next disable of the
+	 * pipeline releases resources that were actually acquired.
+	 *
+	 * The @crtc_state and @conn_state parameters point to the CRTC
+	 * and connector states for the pipeline this bridge is part
+	 * of, which have already been installed.
+	 *
+	 * This hook cannot fail. It is called by the
+	 * &drm_mode_config_helper_funcs.atomic_sro_install_state
+	 * implementation, which is part of the hardware state readout
+	 * initialization sequence.
+	 */
+	void (*atomic_sro_install_state)(struct drm_bridge *bridge,
+					 struct drm_bridge_state *bridge_state,
+					 struct drm_crtc_state *crtc_state,
+					 struct drm_connector_state *conn_state);
+
 	/**
 	 * @atomic_duplicate_state:
 	 *
 	 * Duplicate the current bridge state object (which is guaranteed to be
 	 * non-NULL).

-- 
2.56.1

