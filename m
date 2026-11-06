Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246BC606EE8B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wVu/Qaet
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67AB5112ED8;
	Fri,  6 Nov 2026 16:18:02 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D59C9112ED8
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 16:17:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 17F3B1A14EF;
 Fri,  6 Nov 2026 16:17:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D04BB5FFBC;
 Fri,  6 Nov 2026 16:17:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5D2E7103291BA; Fri,  6 Nov 2026 17:17:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793981869; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=g/mjz1OUUoqXbqPLNSe96R4c6ToI5fSjvGbxgA8nu8U=;
 b=wVu/QaetU10edGf+LE0Wd9jYa7AulpXBXcs3a6FZGn1CLZU5JOKqQ5g3f2t1/hsf04tfq8
 dUbNNZqAxhLhFjT2Gn4hXBze+y6Xc7chmww/FcTRNSIPy7mHRx5pn4A3MyqE8P/uo5wXjT
 yUqPatPiDsdBtrDI7cCebX+EaiRXWzyA/Whuj4azZJlH8nzfZ8bXIejCxd4OI14QIg1Cr0
 RgPhcD31HACdfO+4ywcsvz/om/GzAUaMsg/+Ob+kZfhZpmi72M07k9tZW11rfX/z+iFHQX
 IQPOZ5N5DXZ6Xu6BSqaDgKf3Hm7S+zg/DTfJdaUTHOU1IYmB55gaxGk5Pfziew==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 06 Nov 2026 17:17:05 +0100
Subject: [PATCH 2/3] drm/panel: remove drmm_of_get_bridge()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-2-c0ea3382b798@bootlin.com>
References: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com>
In-Reply-To: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com>
To: Sasha Finkelstein <k@chaosmail.tech>, Janne Grunau <j@jannau.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, asahi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This function is deprecated and has no remaining users.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_panel.c | 40 ----------------------------------------
 include/drm/drm_panel.h     | 10 ----------
 2 files changed, 50 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 560ea57591bd..3a633beed090 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -526,46 +526,6 @@ struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
 }
 EXPORT_SYMBOL(devm_drm_of_get_bridge);
 
-/**
- * drmm_of_get_bridge - Return next bridge in the chain
- * @drm: device to tie the bridge lifetime to
- * @np: device tree node containing encoder output ports
- * @port: port in the device tree node
- * @endpoint: endpoint in the device tree node
- *
- * This function is deprecated. A drm_bridge is embedded into every panel.
- * Don't use it in new drivers and convert your driver to
- * of_drm_get_bridge_by_endpoint().
- *
- * Given a DT node's port and endpoint number, finds the connected node
- * and returns the associated bridge if any, or creates and returns a
- * drm panel bridge instance if a panel is connected.
- *
- * Returns a drmm managed pointer to the bridge if successful, or an error
- * pointer otherwise.
- */
-struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
-				      struct device_node *np,
-				      u32 port, u32 endpoint)
-{
-	struct drm_bridge *bridge;
-	struct drm_panel *panel;
-	int ret;
-
-	ret = drm_of_find_panel_or_bridge(np, port, endpoint,
-					  &panel, &bridge);
-	if (ret)
-		return ERR_PTR(ret);
-
-	if (panel) {
-		bridge = drmm_panel_bridge_add(drm, panel);
-		drm_panel_put(panel);
-	}
-
-	return bridge;
-}
-EXPORT_SYMBOL(drmm_of_get_bridge);
-
 #endif
 
 /**
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 58113ea7d63a..28ecbf2c8a29 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -434,8 +434,6 @@ static inline int drm_panel_bridge_set_orientation(struct drm_connector *connect
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
 struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct device_node *node,
 					  u32 port, u32 endpoint);
-struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm, struct device_node *node,
-				      u32 port, u32 endpoint);
 #else
 static inline struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
 							struct device_node *node,
@@ -444,14 +442,6 @@ static inline struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
 {
 	return ERR_PTR(-ENODEV);
 }
-
-static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
-						    struct device_node *node,
-						    u32 port,
-						    u32 endpoint)
-{
-	return ERR_PTR(-ENODEV);
-}
 #endif
 
 #endif

-- 
2.56.0

