Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825FC606A682
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=S7SWQWQG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE2910FE86;
	Wed, 25 Nov 2026 17:53:24 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0016E10FE86
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:53:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id BD77A4E41785;
 Wed, 25 Nov 2026 17:53:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8EF1160480;
 Wed, 25 Nov 2026 17:53:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 402C111E6B0D1; Wed, 25 Nov 2026 18:53:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795629190; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=setiKsAawUfI5qZxIEr6a1N6sSJqLT6tqu5WlGOp0jo=;
 b=S7SWQWQGsDNqMVWk/loTHnYutCsPERtqteJuE1IyQNjWRLrRb+y3aBrmuztWlyjGBoGRKF
 EiuLx8ZkNKz0k2jB5Er80bY8ITJDyURXMBIhta/etELZ+HTjcP4yO1QkZyzA3o9yl1rrMA
 w/RSmR7+iVv8ldU+vsxuIaV85Am0TuxujODuxKkG6iM8YjxjWRQcD+n+wnMZ9F30yfjTvB
 Xy3e0dOgqKf5UUHfXSA1vf9USaV38Uxss86wdY/XoGFdIc7WTjfuSnMSBAfTe2HlNdXNS8
 zW21Apble487DaxoOxwaFEt5XxbR9LYGMM0Ss1oBMlOSdKvvcRuNqGW4y14FNA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 25 Nov 2026 18:50:33 +0100
Subject: [PATCH v4 20/32] drm/bridge: add drm_bridge_get_next() and
 supporting func
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-drm-bridge-hotplug-v4-20-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
In-Reply-To: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

For bridge hotplug we need to successfully probe a card with an incomplete
bridge chain, i.e. a chain whose last bridge currently in bridge_chain
needs another bridge at its output. Such a card would have no connector,
and be able to add one as soon as the following bridges are added up to the
bridge that requires no further ones (like a panel or a connector_bridge).

So we need a way to know whether the pipeline is complete in the hardware
(all bridges probed), in order to complete it in software (attach all
bridges not yet attached). Currently common DRM code has no way to know
that.

Add drm_bridge_get_next() and a supporting get_next_bridge func so each
bridge can expose its next bridge, and whether there's supposed to be one.

A subsequent commit will use this function to detect whether the pipeline
is complete in the hardware or not.

Link: https://lore.kernel.org/r/20260624-vagabond-neon-gorilla-cd6487@houat
Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- fix and improve kerneldoc

New patch in v2, replacing the is_tail patch in v1
---
 drivers/gpu/drm/drm_bridge.c | 30 ++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 25 +++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index a50709ac8b06..e0e0dd7fc12b 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -720,6 +720,36 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 	drm_bridge_put(bridge);
 }
 
+/**
+ * drm_bridge_get_next - return the bridge at this bridge's output port
+ * @bridge: the bridge to query
+ *
+ * Return the next bridge, i.e. the bridge that is connected at the output
+ * port of @bridge. Unlike drm_bridge_get_next_bridge(), the next bridge
+ * might or not be in the encoder chain.
+ *
+ * Returns:
+ * * Pointer to a bridge connected to the output port of this bridge,
+ *   with refcount incremented; call drm_bridge_put() when done
+ * * ERR_PTR(-ENODEV): this bridge has an output port where a next bridge
+ *                     needs to be present for video output, but the next
+ *                     bridge is not currently available
+ * * NULL: this bridge does not have an output port where a next bridge
+ *         is expected
+ * * ERR_PTR(-ENOENT): the bridge does not implement the func
+ * * Another negative error returned by the bridge func
+ */
+struct drm_bridge *drm_bridge_get_next(struct drm_bridge *bridge)
+{
+	if (!(bridge->ops & DRM_BRIDGE_OP_GET_NEXT_BRIDGE)) {
+		drm_warn_once(bridge->dev, "get_next_bridge func not implemented!");
+		return ERR_PTR(-ENOENT);
+	}
+
+	return bridge->funcs->get_next_bridge(bridge);
+}
+EXPORT_SYMBOL(drm_bridge_get_next);
+
 /**
  * DOC: bridge operations
  *
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index d6ef020c4cc9..cfa0aff1de4f 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -62,6 +62,25 @@ enum drm_bridge_attach_flags {
  * struct drm_bridge_funcs - drm_bridge control functions
  */
 struct drm_bridge_funcs {
+	/**
+	 * @get_next_bridge:
+	 *
+	 * Return a pointer to the bridge connected at the output port of
+	 * this bridge.
+	 *
+	 * Returns:
+	 * * Pointer to a bridge connected to the output port of this bridge,
+	 *   with refcount incremented; call drm_bridge_put() when done
+	 * * ERR_PTR(-ENODEV): this bridge has an output port where a next
+	 *                     bridge needs to be present for video output,
+	 *                     but the next bridge is not currently
+	 *                     available
+	 * * NULL: this bridge does not have an output port where a next
+	 *         bridge is expected (e.g. a panel)
+	 * * Another negative error returned by the bridge func
+	 */
+	struct drm_bridge *(*get_next_bridge)(struct drm_bridge *bridge);
+
 	/**
 	 * @attach:
 	 *
@@ -1021,6 +1040,11 @@ enum drm_bridge_ops {
 	 * &drm_bridge_funcs->hdmi_clear_spd_infoframe callbacks.
 	 */
 	DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME = BIT(10),
+	/**
+	 * @DRM_BRIDGE_OP_GET_NEXT_BRIDGE: The bridge implements the
+	 * &drm_bridge_funcs->get_next_bridge callback.
+	 */
+	DRM_BRIDGE_OP_GET_NEXT_BRIDGE = BIT(11),
 };
 
 /**
@@ -1272,6 +1296,7 @@ void drm_bridge_remove(struct drm_bridge *bridge);
 int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		      struct drm_bridge *previous,
 		      enum drm_bridge_attach_flags flags);
+struct drm_bridge *drm_bridge_get_next(struct drm_bridge *bridge);
 
 #ifdef CONFIG_OF
 struct drm_bridge *of_drm_find_and_get_bridge(const struct device_node *np);

-- 
2.56.1

