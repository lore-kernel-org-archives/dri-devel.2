Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF3DC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF74010E802;
	Mon,  7 Sep 2026 13:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eHSDRyTJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637C210E79E
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:24:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C61743B83;
 Mon,  7 Sep 2026 13:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980581F00A3D;
 Mon,  7 Sep 2026 13:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787494;
 bh=Y7doNKQWARSHjr0CXbtFMtMEw0q2eCscafsYPXnUjLs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eHSDRyTJYZL8GCGI9vB8jxLbGC4K+PEYHKbtpsTW2x/SLk5+4Qmqd+uDWLTF3ipO6
 +0+TtUYP8tvL615aO56qPzjpOCxZIW+Hd9BjC9x551jhfAuydfuo0lM8L8oRULGaVk
 qY86IK3voKZZyyUdUiZ3YzqZJpgS7x5Y7yteZxkVFYjk70cpsbUPbX+paCCh0XUIkG
 X9vixfCjgdvwbr8BtYkd2HOT3OjRWXxGcSjvbutdv61FfrmSyI5zx1haWQBpBex59m
 tmbqlwEZbnMFJQvocc860sTLkgw70thxFjX/KZ+2zH5l5YvXfvZ70DaYreGFQWsxnp
 BH3Q+IhWDZpIg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:23:50 +0200
Subject: [PATCH v5 14/33] drm/bridge: Handle bridges with hardware state
 readout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-14-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5769; i=mripard@kernel.org;
 h=from:subject:message-id; bh=h5PVmt5TO4B23PhgZvexvJxLx1j2885vVAXLy6xYPHE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdj3p2WA2U+Xi2g/bIttuWq/48WFzf3yA1ZE1Fq9N1
 iksiLvp0TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAm8n8xY8P2RS77X0+fxpTb
 tu3E83L3b3NlLjKcjGGc2T3RzGeni42muvX+O0ylys0vn9m/d1ysF8/Y0Ci8cW7Nu07vxPgpv/6
 9+xYwubbZILhn28KHv8/OdWE1a9tv/GO7adUPtk9PcuSafdnNAA==
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 80 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 177f018dd3ff..17fef062d7e5 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -27,10 +27,11 @@
 #include <linux/media-bus-format.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/srcu.h>
 
+#include <drm/drm_atomic_sro.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
@@ -548,10 +549,68 @@ drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
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
+	conn_state = find_connector_state_for_encoder(state, encoder);
+	if (!conn_state)
+		return -EINVAL;
+
+	crtc_state = drm_atomic_sro_get_crtc_state(state, conn_state->crtc);
+	if (!crtc_state)
+		return -EINVAL;
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
 				   const struct drm_private_state *s)
 {
 	const struct drm_bridge_state *state = drm_priv_to_bridge_state(s);
@@ -575,10 +634,18 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 	.atomic_print_state = drm_bridge_atomic_print_priv_state,
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
  * @obj: private object to check
  *
  * RETURNS:
@@ -586,11 +653,13 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
  * True if @obj is the &drm_private_obj embedded in a &struct drm_bridge,
  * false otherwise.
  */
 bool drm_private_obj_is_bridge(struct drm_private_obj *obj)
 {
-	return obj->funcs && obj->funcs == &drm_bridge_priv_state_funcs;
+	return obj->funcs &&
+	       (obj->funcs == &drm_bridge_priv_state_funcs ||
+		obj->funcs == &drm_bridge_priv_state_funcs_with_sro);
 }
 EXPORT_SYMBOL(drm_private_obj_is_bridge);
 
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
@@ -659,12 +728,17 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		ret = bridge->funcs->attach(bridge, encoder, flags);
 		if (ret < 0)
 			goto err_reset_bridge;
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
 
 err_reset_bridge:
 	bridge->dev = NULL;

-- 
2.55.0

