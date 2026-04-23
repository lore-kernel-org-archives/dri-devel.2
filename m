Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCBBF99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF0A10F06A;
	Thu, 23 Apr 2026 10:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JJ1FjHOm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE5D10F046
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:08:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4EDC060120;
 Thu, 23 Apr 2026 10:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5468C2BCAF;
 Thu, 23 Apr 2026 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776938881;
 bh=bePbvwOBRVlaWXPTujYtgwL3T/BFFOXE7FNvSU5omaU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JJ1FjHOmab2gbz1N0D+1zPkn2UlNxium3WTGqvw9TymzW8p5DtwU69J/d17oHlNX2
 JcKJLG4B51ZJK9jqlPrOEXpVJCMAT7kY9xPIBsSV1gS0PVOoiw2aA+gkkxoBoeYGeW
 kWyPN0Gvp8oFHokRlner+yZjul8fv9HATT1cA1FZmY+ukP3aciuQPr3/SB61yoWOmC
 Tni2Fo8K4FkOKIYmHk8ysLZCPGznelu4dDx/Rm9jofu2Aw4mI5ntkerTm+6digLgtv
 vPjYXGDO1UdeQ41wacPWk2AOzbEkB7V8qqQsSIWQeXtEJueMEyr8P+gp8XFsTo1D98
 FZokVbDFmgs3w==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:06:53 +0200
Subject: [PATCH v2 15/28] drm/bridge: Handle bridges with hardware state
 readout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-15-6cde1a9910ed@kernel.org>
References: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5800; i=mripard@kernel.org;
 h=from:subject:message-id; bh=bePbvwOBRVlaWXPTujYtgwL3T/BFFOXE7FNvSU5omaU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkv3/syZgqt29q997RA1cLf74Nvbpv4/KuE/EpnRRe/Z
 zueFxqpdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJMK1irPcMFHqYuV5g0ec3
 3IW38nlaT3BNzw/9tOeuuY71pR3Vpv5BE/+t2/NNsDB12oO1wZMapjHWx1eUf+rQEX73min9LFd
 K4annoZGCb+qs1/7fce2tctSfvZ/muf03nKA5da2UVpBXv44jAA==
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
index fba440bddcb3..08226af6b82a 100644
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
@@ -506,10 +507,66 @@ drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
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
@@ -533,10 +590,18 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
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
@@ -544,11 +609,13 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
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
@@ -622,13 +689,19 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
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
2.53.0

