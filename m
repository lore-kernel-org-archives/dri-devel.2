Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF0606A335
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KK46J3Pg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D1710E429;
	Thu,  5 Nov 2026 20:35:58 +0000 (UTC)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7389A10E429
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:35:52 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1a8cc11ac42so973c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793910951; x=1794515751; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sJJKjK0K6EALIuHLfHejOsTyjBZ8Ozdl83llEgi1uXM=;
 b=KK46J3Pgl9rCz2i+Yo0ilW7QI3Cpo4fNClWYO+HL0TqFYAUHm7sgnMlv5cWeJewfib
 QCqogLYSjy7e3s2i/ot3V8TtFkMA/3ZIpruxqnvqWSf4VxABIruISqosSoNQ0n3rsS4G
 6TzETS5EiFPgt0Ljq9VvT+2J9it2O6XnzcRYl3OnO+UQRiZLlMGEZ6wq2TURsdYTILi6
 UEMhajrjnbqowKrQ2KYadBiGY1ur5oxe4JdDVzcUWwgc6iAb7NONOs8jxclWh4qVHtP7
 gRX9QpKvPdprYk3nmBpHzJT57tJIZTf9+4uYjIYAEYTKj3Dfzqkg6TQCdmxekFvqGz9X
 DOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793910951; x=1794515751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sJJKjK0K6EALIuHLfHejOsTyjBZ8Ozdl83llEgi1uXM=;
 b=FUa8s0qGEIIz6vKbhNp9CE3sL9Xx3BC8Kz8vYnfUADqyqcbDR8qPy7D8Nvji3cnmsK
 fA03XL7OcF9bFQ3ZdXWfbygL4mzki97v0ayef1d+Xi7qgICMFFt5y2pZpMLPR2ro019A
 ZrNVvG5UIyZfbFY7ytE3S2hy2eyLMUDCNVpCHzYC0B196U+y5YQxnvfEo/LFg6AmNod6
 vDN6gi3aV13YG/MQDaSFL2S2a1usVdN4cPi+xfYDDZVmH66p2iQDQsotioJtCY3oSSQY
 6nmgj9hH3nlQik6cc5PZ+n3WJl8VkzB9ukYjpCJUO1/rysgjNuvUPHlE9fqGQmEukq0z
 UTHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVoVBKuSYyH9QhutN6R3Z0AhVO7HAylxIHBpBqmMuHJpFTJlSkXQ3qQyuXP8PHigeV+RpIeW1fljM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Eu/OZ+2g0ndjIrjNhoPs6JFg8VaCZW/sLj7zpL/NISWpwmRho
 gPI2oiXXe73vKvVBUU+wzSSKwRC6NTjWRj54hnt+HKjR9G6rE9DxpH/7
X-Gm-Gg: AYBFou0k+GdFaxKH6IpIexowOHH68IxU839PG1eusVbdo2Vpe6C5KsirzTgOAJfpvsJ
 v5sXMV3qqcoNPA2qi4I8mcWeY6192U9HcAJoUvJMK3XNhnvsyvbZZomaunBbpiXoUyArMKLiOgT
 jMIB/p3Jdpn72k2JgWtmzKtgBr0yHMKlkpVaSm2HGTw6yyjY9g9hcqnrzPHP8N96oVw2GRrAPLy
 PvJ4WqKzd90z8IMBrRXmtB9onqBZayvRw3oCXtE5cUfIQ4A4RQ0ijw3tbpWy2/eieRfMk8/G6da
 1lwKsSOFRheaHrVuCSU+odMWoynseYgu4CIMZ6AjvgJpBYrMFFfP7IaY13FzN2fcvs5HdA9+jOc
 vKqK3owF/thwQge0ZKwdee/FO5cpR9yzu9Vrf3JuhdFZnW4b/ak7iobqZ8GOsQOz17r+U1HNugT
 RQQTpFEvnshs3O1Kfe14+3xmqP/Bh8x+v9mEtmEyxQbh9svPm8Rs49MaQbFvi8vaQ/lYMes/X4j
 C9Qw6ycdtMsU43KGSj1t+sEBalJmjsf7HRzAi1p7PTDlMcfx/TQRgpRmLJ+h8oE8nvSR3uKZY40
 yBx4G9kb
X-Received: by 2002:a05:701a:c90a:b0:15b:7f7a:730d with SMTP id
 a92af1059eb24-1b25d342861mr126756c88.28.1793910951382; 
 Thu, 05 Nov 2026 12:35:51 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245b86fbesm19778365c88.1.2026.11.05.12.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:35:50 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 "H. Nikolaus Schaller" <hns@goldelico.com>,
 Paul Boddie <paul@boddie.org.uk>, paul@crapouillou.net,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-mips@vger.kernel.org (open list:INGENIC JZ47xx SoCs),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
Subject: [PATCH] drm/ingenic: Allocate and register the internal bridge
 separately
Date: Thu,  5 Nov 2026 12:35:17 -0800
Message-ID: <20261105203517.2293404-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The LCD controller's internal bridge is embedded in an object allocated
with drmm_encoder_alloc(). This initializes the encoder but leaves the
bridge's reference count at zero. Since drm_bridge_attach() takes a
reference, probing the CI20 display produces addition-on-zero and
underflow warnings and fails to attach the HDMI bridge chain.

Allocate the internal bridge with devm_drm_bridge_alloc() and register
it with devm_drm_bridge_add() before attaching it. Keep the encoder in a
separate DRM-managed allocation: encoder cleanup can drop the final
bridge reference before it has finished accessing the encoder. Find
the internal bridge through the encoder's bridge chain during mode
setting, and use the bridge argument directly in bridge callbacks.

Fixes: 94d50c1a2ca3 ("drm/bridge: get/put the bridge reference in drm_bridge_attach/detach()")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 31 +++++++++++++++--------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 625ec76cf04d..520912f9ed0d 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -121,16 +121,15 @@ struct ingenic_drm {
 };
 
 struct ingenic_drm_bridge {
-	struct drm_encoder encoder;
 	struct drm_bridge bridge, *next_bridge;
 
 	struct drm_bus_cfg bus_cfg;
 };
 
 static inline struct ingenic_drm_bridge *
-to_ingenic_drm_bridge(struct drm_encoder *encoder)
+to_ingenic_drm_bridge(struct drm_bridge *bridge)
 {
-	return container_of(encoder, struct ingenic_drm_bridge, encoder);
+	return container_of(bridge, struct ingenic_drm_bridge, bridge);
 }
 
 static inline struct ingenic_drm_private_state *
@@ -738,7 +737,9 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
 {
 	struct ingenic_drm *priv = drm_device_get_priv(encoder->dev);
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
-	struct ingenic_drm_bridge *bridge = to_ingenic_drm_bridge(encoder);
+	struct drm_bridge *first_bridge __free(drm_bridge_put) =
+		drm_bridge_chain_get_first_bridge(encoder);
+	struct ingenic_drm_bridge *bridge = to_ingenic_drm_bridge(first_bridge);
 	unsigned int cfg, rgbcfg = 0;
 
 	priv->panel_is_sharp = bridge->bus_cfg.flags & DRM_BUS_FLAG_SHARP_SIGNALS;
@@ -799,7 +800,7 @@ static int ingenic_drm_bridge_attach(struct drm_bridge *bridge,
 				     struct drm_encoder *encoder,
 				     enum drm_bridge_attach_flags flags)
 {
-	struct ingenic_drm_bridge *ib = to_ingenic_drm_bridge(encoder);
+	struct ingenic_drm_bridge *ib = to_ingenic_drm_bridge(bridge);
 
 	return drm_bridge_attach(encoder, ib->next_bridge,
 				 &ib->bridge, flags);
@@ -811,7 +812,7 @@ static int ingenic_drm_bridge_atomic_check(struct drm_bridge *bridge,
 					   struct drm_connector_state *conn_state)
 {
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
-	struct ingenic_drm_bridge *ib = to_ingenic_drm_bridge(bridge->encoder);
+	struct ingenic_drm_bridge *ib = to_ingenic_drm_bridge(bridge);
 
 	ib->bus_cfg = bridge_state->output_bus_cfg;
 
@@ -1303,22 +1304,32 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 			drm_panel_put(panel);
 		}
 
-		ib = drmm_encoder_alloc(drm, struct ingenic_drm_bridge, encoder,
-					NULL, DRM_MODE_ENCODER_DPI, NULL);
+		ib = devm_drm_bridge_alloc(dev, struct ingenic_drm_bridge, bridge,
+					   &ingenic_drm_bridge_funcs);
 		if (IS_ERR(ib)) {
 			ret = PTR_ERR(ib);
+			dev_err(dev, "Failed to allocate bridge: %d\n", ret);
+			goto err_drvdata;
+		}
+
+		encoder = drmm_plain_encoder_alloc(drm, NULL,
+						   DRM_MODE_ENCODER_DPI, NULL);
+		if (IS_ERR(encoder)) {
+			ret = PTR_ERR(encoder);
 			dev_err(dev, "Failed to init encoder: %d\n", ret);
 			goto err_drvdata;
 		}
 
-		encoder = &ib->encoder;
 		encoder->possible_crtcs = drm_crtc_mask(&priv->crtc);
 
 		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
 
-		ib->bridge.funcs = &ingenic_drm_bridge_funcs;
 		ib->next_bridge = bridge;
 
+		ret = devm_drm_bridge_add(dev, &ib->bridge);
+		if (ret)
+			goto err_drvdata;
+
 		ret = drm_bridge_attach(encoder, &ib->bridge, NULL,
 					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret) {
-- 
2.53.0

