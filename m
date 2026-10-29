Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC48606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAkPHzKb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FCA110FFDA;
	Thu, 29 Oct 2026 07:35:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D2D10FFDA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:35:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 780C6600D1;
 Thu, 29 Oct 2026 07:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71801F01828;
 Thu, 29 Oct 2026 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259318;
 bh=Y9mQhrtj5YeQLbamPqkNu5JxQzK+kpIv9CRfbBEpFNs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WAkPHzKbfhhVkWpZNB1AZatW8WPNajQsnB4MdEmTWYiTxQFpBuvebZj3T4HtZ/NW0
 uIhBxDkzqFqTmgNu9MfaoUq7WWAk1tSh4mDz75sJstt6Gd8ZfaW0RETKRvJdygZMyu
 f7f0bUU4A7zQmORMtemUlS7xEKnXSLobCw7CTRvthtVdZYBCQnaEy6pLjAq+z+A1dI
 YN836MXh3FkKcK1JKxdL59R/Yt13oZZ473lylE6cFGDKdBaIxxEm5mZjYOxK0P5rNg
 qbThL7hxu4Bffo+C2M7Vrm61fiWSrg5rZo0/IFd4SIfbMk/eBhiqLx5qZVOgQUxksl
 irjEzS/tjSjcA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:34:05 +0100
Subject: [PATCH v7 15/34] drm/bridge: Handle bridges with hardware state
 readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-15-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
In-Reply-To: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5190; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BYHhByh0OLdWy/HL5IA9V1wPrbHbGP9aDWFPrxN/WdI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvn0u3nTnGUvjDOPjnyff+rnw3JRpsu8ZF8vfu1T4x
 PV+x81VTzqmsjAIczLIiimyPJEJO728fXGVg/3KHzBzWJlAhjBwcQrARHrcGeu0Ux4Lhfq9vbVr
 QZIFb/KExCPbMwtmGjH9ucwWo+M0r/jT0qJTNgre9dKWLAqB58qlvjM23Hmmu6IsS+K/5sutDtv
 6tVs3v9v/ftu8uGn1Ju0mssJdGfPatPjY1ot8jfz34ahe1JM7AA==
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

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 89 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index b2d77824e4be..5977157d8e67 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -31,4 +31,5 @@
 
 #include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_atomic_state_readout.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_debugfs.h>
@@ -562,4 +563,71 @@ drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
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
+		if (WARN_ON(!conn_state))
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
+		if (WARN_ON(ret))
+			return ret;
+	}
+
+	return 0;
+}
+
 static void
 drm_bridge_atomic_print_priv_state(struct drm_printer *p,
@@ -589,4 +657,12 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 };
 
+static const struct drm_private_state_funcs drm_bridge_priv_state_funcs_with_sro = {
+	.atomic_sro_readout_state = drm_bridge_atomic_readout_priv_state,
+	.atomic_create_state = drm_bridge_atomic_create_priv_state,
+	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
+	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
+	.atomic_print_state = drm_bridge_atomic_print_priv_state,
+};
+
 /**
  * drm_private_obj_is_bridge - check if a private object backs a bridge
@@ -600,5 +676,7 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 bool drm_private_obj_is_bridge(struct drm_private_obj *obj)
 {
-	return obj && obj->funcs == &drm_bridge_priv_state_funcs;
+	return obj &&
+	       (obj->funcs == &drm_bridge_priv_state_funcs ||
+		obj->funcs == &drm_bridge_priv_state_funcs_with_sro);
 }
 EXPORT_SYMBOL(drm_private_obj_is_bridge);
@@ -673,6 +751,11 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	}
 
-	drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
-				    &drm_bridge_priv_state_funcs);
+	if (bridge->funcs &&
+	    bridge->funcs->atomic_sro_readout_state)
+		drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
+					    &drm_bridge_priv_state_funcs_with_sro);
+	else
+		drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
+					    &drm_bridge_priv_state_funcs);
 
 	return 0;

-- 
2.55.0

