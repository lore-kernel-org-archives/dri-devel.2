Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43849606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JyVaLNd0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9795F10F854;
	Tue, 17 Nov 2026 17:38:39 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F1610F854
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 17:38:33 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-37071c0f42aso248980eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794937113; x=1795541913; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SSX+d+qRWkdn91G1pK7BnTwO8tnOwfNEC8664ApeNmk=;
 b=JyVaLNd0m9wwePKG9mohrORC1PQ/Tou8vBDjkBPkXHeDPIc/rUOB2XRQa9Qg1pRtyi
 EdXQZAutRLaFAJHvPKoxF437Plw6NukyjfpJDsXyAKiGdPRUQRor1Sj3sAr+BUAVZzAB
 ONb9E6WckwIaYFEYIw1Dz1fL0mCNEVo5qtrlZ06OmiEgiq/ygR/rY9UdmiERn0AkVP9q
 HVBkuSHaFMs18H3VWDY0SLIMJVWd9M765y/BqPjASnTEMYK4OBhyf2kCgnvKj9DSr1vi
 8T6AY+NGFjzop5Ia0abzHGAPENJM4Cq+TpZeAwm8l19lTRfiw1M5ReeE6CtDxY6SUkPU
 Yv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794937113; x=1795541913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SSX+d+qRWkdn91G1pK7BnTwO8tnOwfNEC8664ApeNmk=;
 b=GM+xVXBWBMCETy0MsTUOVMk6ogd3o+lVxdkxJ1/BWI8PulsVdfdvRU82noN8nRygXm
 jttgmAvrK0noe0ea3kzNeCaUbNTNgwLgEmG0ihLNVhkyBJF2FuFcO7Le5bBe1g+uGODj
 YZxyAdmZkRuo/bzx/nwYU3ekNSdHhbChf0MlK42s2W5dvpQKHQv9H2qOALRchNCdyFLc
 idB0DueRVUTlGYrmD4t11lvwdr04088CBFEyXwz0tblb5djNtU2zNFeBiBCl3Dcwn+1A
 RPX6cqG12fY4t/0vRGhH/QCyMakdPDrxXebcKgJRKa6S245xtXBUrLajbFkHVY/4P+If
 1/kw==
X-Forwarded-Encrypted: i=1;
 AL+hErHwPTCs3pFOGuw0uCM5Z3FdtDWzTVnO3fDobbBHC1u9cQfBzp7O/nAYQzWST22j36cwAsiJMhcefI8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+jAJ9WZs+XaBGejy0sP9I3VSTH1lyE44YlqUqpXek+ToeucBLz
 CO7gSq97NR/JXf6m8DJN3KmbYlekKSdYuP1e3dfOOOmfGujQ592QHbYM
X-Gm-Gg: AZFdTZcgDfBoAGYyxKuggOkUdNKub1L8uqUmjwpRiO/KrI67y3bXZJoahxZhrKDMBLX
 zdunPfcBse4+Hcc3S1CfGzM/fyWz71/Fz5KMyUPapdJpUEQviZ4pgHEhtWXsKjtlDrPELpCPXdZ
 xxx0Dr3tz1G/v277i6FLB1TyAet+CYpQM9wFao0dRl0N+zgaJL0e9VQioaNUJI8CZV9SaESKUIp
 j9nggy2W8vp2vWZ4mkHKHUVWIcKRnebimClnfWY3Hr0kSFcm7pAGF4ch/4jv40ZpNFr65eNRJ+s
 B5XtKJJjGfPWfx6yLnStp6W/ThuKau5RZxCe9t2XDxq6SnaC+qT88QQ4wGsH/f0gmkFGajtSCOX
 i0O6XHjbF99MibvbxKMJLESY4gdZogJOzK2re5Q4i3+iicDxBVk/IhO20TR5AcBaT0cAOaa9/pJ
 vayftE271/IGrQ9Heod7W2+0C+nraqz4iHJDptArqOYXohHdHxSbbj3LNhQrNjaPnngUgtqvxZO
 ek0O6IF9budjSmw6Ml+uFZcHNhgV9PMpCGAcxdmLMTKf5s65XDeWmAc2uda5ddoCshmZFuL7/xr
 5Qkgjjxw
X-Received: by 2002:a05:7300:de4c:b0:36a:1f4f:3e9 with SMTP id
 5a478bee46e88-3828101de20mr123080eec.20.1794937112971; 
 Tue, 17 Nov 2026 09:38:32 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm44098373eec.29.2026.11.17.09.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:38:32 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 "H. Nikolaus Schaller" <hns@goldelico.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 linux-mips@vger.kernel.org (open list:INGENIC JZ47xx SoCs),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
Subject: [PATCH v2] drm/ingenic: Allocate and register the internal bridge
 separately
Date: Tue, 17 Nov 2026 09:38:20 -0800
Message-ID: <20261117173822.1816385-1-f.fainelli@gmail.com>
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
Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # CI20 V2a
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
CC: stable@vger.kernel.org
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- collected Reviewed-by and Tested-by tags
- added CC: stable

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

