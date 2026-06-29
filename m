Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD9AC43638
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB85210E760;
	Mon, 29 Jun 2026 08:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I14i4Vm2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE89210E74E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:17:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 626F0600C8;
 Mon, 29 Jun 2026 08:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F5D1F000E9;
 Mon, 29 Jun 2026 08:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721076;
 bh=LmgyDTnYBP4e4qi7BvuszkSCMecTHNTkuQrX+MaCoTc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=I14i4Vm28o2jxLMPVOsugrTbsxQMrcp1fmhUwsQszhcudky2CGq7/Qu2/4bnezr0V
 zxEw9Uk8/TZxOMeBXsJCsdxIHtoSTkyHshwXyB0XN6mLg2oh2HdhK2AYCaSczAx8vI
 nvZxOWiIMLNFXU471B0B+rahzBQ8InEfOi8f/fQCXj4Hag62XfVDIPa7CipBtDTfbr
 fxQwzWSpq26LXgr4hA3GgaEFwjRd+e1MuIio+8AxdVuLnS74zV4o8SiW4jWSSvyUNp
 UFrEuGSvaTr3N38G5slPE9/5ikC0eF+XqnsGeipDH87gwSB4s1vusbopIGL10LE45r
 D/Qc6rrGseXLA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:13 +0200
Subject: [PATCH v4 15/30] drm/bridge: Handle bridges with hardware state
 readout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-15-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5800; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jlrCQQEtRqcpRNFJ2p8VEUf4ldQLrs8n3J5Sfe71FY4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWmxa0t/vzHp0LlB3a617vKamf+5MD9dp4X1TVOe4f
 eVmWsXRMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZSz8PY8PtzI8OMpTc+LNO6
 P63xfUr3nsKCbAfNvXH/Fv6aq+RRvpJNx/xbWQLPmhRR9iv9UltjGBsm9LdK1j2Z6FR00fbsBFn
 TJx/d/T+c/lTEK32fQZ9R/vzMLw5tLfantxSU2yhFWMyp7wAA
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
 drivers/gpu/drm/drm_bridge.c | 81 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index e6f1174be62a..6349f202db0b 100644
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
@@ -548,10 +549,66 @@ drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
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
+		if (encoder == conn_state->best_encoder)
+			return conn_state;
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
@@ -575,10 +632,18 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
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
@@ -586,11 +651,13 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
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
 
 static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
 {
@@ -664,13 +731,19 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		ret = bridge->funcs->attach(bridge, encoder, flags);
 		if (ret < 0)
 			goto err_reset_bridge;
 	}
 
-	if (drm_bridge_is_atomic(bridge))
-		drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
-					    &drm_bridge_priv_state_funcs);
+	if (drm_bridge_is_atomic(bridge)) {
+		if (bridge->funcs &&
+		    bridge->funcs->atomic_sro_readout_state)
+			drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
+						    &drm_bridge_priv_state_funcs_with_sro);
+		else
+			drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
+						    &drm_bridge_priv_state_funcs);
+	}
 
 	return 0;
 
 err_reset_bridge:
 	bridge->dev = NULL;

-- 
2.54.0

