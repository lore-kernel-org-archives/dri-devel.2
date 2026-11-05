Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517AF606EE86
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=VH4w9Z32
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 638CD1127D6;
	Thu,  5 Nov 2026 15:53:01 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93FB41127EB;
 Thu,  5 Nov 2026 15:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793893966; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NYhMI3Z0wr6Plj+9b9tIx4LFtoS6gJ2jQIbvxMRhfRVtq3bS4e58KPLLLTw9gzM+zonwbn+f7H+moEScq36ZpblmafvBi6V2QfkdjEejXbRBKY/kbl4GmWwUFop7gUYUlUwcfTZFdom3SUvaJGPoB7leWV6Y2SgTiFwXGtmPz9s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793893966;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qLyaduhUBi+bpCuge3G1zOLHjhJzZY/OT6BcfFj29Qw=; 
 b=imVnztz1pp1JGC4wi2BNIGpD72DicacyXyt7+dBOMSLWwPsWMtUaaQttvneG+HtUFJij+C72UsW5dpyspdRr2H19aj/X+RD8OCUUUNZMeWpYlKSk3bMEZ3CUQAbf+pzlsOJYh9B1vWUFWDqxTibksAKkpubMyZbUJFyLOcUYsQ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=VH4w9Z32gBwoCmVzbyZF7xO2Fh4mZKimSEs7GBpJNDSH6RJeztragkvwplJ8GPILzBNsVLckLkYKJBgkMvYQ9ipUzLMCSPGQu8GeaFLncjxF2AyTC+rFcmb/QMtxMfbEcekDCBDspl149T2xSN0wPWFvs/2UCGE4ViTVDO4Wvgg=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=qLyaduhUBi+bpCuge3G1zOLHjhJzZY/OT6BcfFj29Qw=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179389396485396.56310927072991;
 Thu, 5 Nov 2026 07:52:44 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:51:53 +0100
Subject: [PATCH v2 02/27] drm/connector: add vrr_display_mode connector
 property
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-vrr-limiter-uapi-v2-2-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
In-Reply-To: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
To: Xaver Hugl <xaver.hugl@gmail.com>, Vidith Madhu <vmadhu@nvidia.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It's common to want to keep a VRR-capable display in a specific VRR mode
regardless of whether a CRTC uses VRR presentation, to avoid screen
blanking during switching of the VRR mode. On the other hand, it's also
not always desired to keep a display in VRR mode even when nothing does
VRR presentation, for example in battery-powered systems.

To let userspace control this explicitly, instead of relying on implicit
driver policy, introduce a new connector KMS property: vrr_display_mode.

It defaults to "Game", which matches the behaviour of dGPU drivers,
wherein a VRR-capable display will always be in Game mode. However, it
also has an "Off" mode, with which userspace can explicitly request that
VRR be disabled on the display sink.

The associated connector state member uses an u8 rather than the enum
type in order to fit into the existing 2 bytes of padding there. Once
the kernel mandates compiler versions that have backported C23 features,
the enum can be given an explicit small backing type and the member can
be changed to use the enum type.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c |  4 ++
 drivers/gpu/drm/drm_connector.c   | 77 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h       | 29 +++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eebcf6f5e05..127bdd77802b 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -969,6 +969,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->hdmi.broadcast_rgb = val;
 	} else if (property == connector->color_format_property) {
 		state->color_format = val;
+	} else if (property == connector->vrr_display_mode_property) {
+		state->vrr_display_mode = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -1056,6 +1058,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->hdmi.broadcast_rgb;
 	} else if (property == connector->color_format_property) {
 		*val = state->color_format;
+	} else if (property == connector->vrr_display_mode_property) {
+		*val = state->vrr_display_mode;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 893716a9e489..65c14b6e47a6 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1434,6 +1434,12 @@ static const struct drm_prop_enum_list drm_tv_mode_enum_list[] = {
 };
 DRM_ENUM_NAME_FN(drm_get_tv_mode_name, drm_tv_mode_enum_list)
 
+static const struct drm_prop_enum_list drm_vrr_mode_enum_list[] = {
+	{ VRR_DISPLAY_MODE_GAME,   "Game" },
+	{ VRR_DISPLAY_MODE_OFF,    "Off" },
+};
+DRM_ENUM_NAME_FN(drm_get_vrr_mode_name, drm_vrr_mode_enum_list)
+
 /**
  * drm_get_tv_mode_from_name - Translates a TV mode name into its enum value
  * @name: TV Mode name we want to convert
@@ -2560,6 +2566,14 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
  *
  *	The driver may place further restrictions within these minimum
  *	and maximum bounds.
+ *
+ * "vrr_display_mode":
+ *	Optional &drm_connector enum property that controls which VRR mode, if
+ *	any, a display is in. Possible values::
+ *
+ *	    - Game - set display to game mode if display supports it,
+ *	      regardless of CRTC state
+ *	    - Off - set display to VRR disabled mode, regardless of CRTC state
  */
 
 /**
@@ -2593,6 +2607,69 @@ int drm_connector_attach_vrr_capable_property(
 }
 EXPORT_SYMBOL(drm_connector_attach_vrr_capable_property);
 
+/**
+ * drm_connector_attach_vrr_display_mode_property - creates and attaches VRR
+ * display mode property
+ * @connector: pointer to the &struct drm_connector to attach the property to
+ * @supported_vrr_modes: bitmask of VRR modes the connector supports regardless
+ *			 of sink
+ *
+ * Creates and attaches the "vrr_display_mode" property to @connector. The
+ * property must not already exist on it. @supported_vrr_modes is a bitmask
+ * wherein BIT(VRR_DISPLAY_MODE_FOO) indicates VRR_DISPLAY_MODE_FOO is supported
+ * by the connector.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_vrr_display_mode_property(struct drm_connector *connector,
+						   unsigned int supported_vrr_modes)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_prop_enum_list enum_list[VRR_DISPLAY_MODE_COUNT];
+	unsigned int num_enums = 0;
+	struct drm_property *prop;
+	int i;
+
+	if (supported_vrr_modes & ~(BIT(VRR_DISPLAY_MODE_COUNT) - 1)) {
+		drm_err(dev, "Unknown VRR modes provided on [CONNECTOR:%d:%s]\n",
+			connector->base.id, connector->name);
+		return -EINVAL;
+	}
+
+	if (connector->vrr_display_mode_property) {
+		drm_err(dev, "[CONNECTOR:%d:%s] already has a 'vrr_display_mode' property\n",
+			connector->base.id, connector->name);
+		return -EEXIST;
+	}
+
+	if (!(supported_vrr_modes & BIT(VRR_DISPLAY_MODE_GAME))) {
+		drm_err(dev, "Missing default VRR mode on [CONNECTOR:%d:%s]\n",
+			connector->base.id, connector->name);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < VRR_DISPLAY_MODE_COUNT; i++) {
+		if (BIT(i) & supported_vrr_modes) {
+			enum_list[num_enums].name = drm_get_vrr_mode_name(i);
+			enum_list[num_enums].type = i;
+			num_enums++;
+		}
+	}
+
+	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ENUM, "vrr_display_mode",
+					enum_list, num_enums);
+
+	if (!prop)
+		return -ENOMEM;
+
+	connector->vrr_display_mode_property = prop;
+	drm_object_attach_property(&connector->base, prop, VRR_DISPLAY_MODE_GAME);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_vrr_display_mode_property);
+
 /**
  * drm_connector_attach_scaling_mode_property - attach atomic scaling mode property
  * @connector: connector to attach scaling mode property on.
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aa..8699f35cafcb 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -809,6 +809,15 @@ enum drm_bus_flags {
 	DRM_BUS_FLAG_SHARP_SIGNALS = BIT(8),
 };
 
+enum vrr_display_mode {
+	/** @VRR_DISPLAY_MODE_GAME: Set the display to VRR "Game" mode */
+	VRR_DISPLAY_MODE_GAME = 0,
+	/** @VRR_DISPLAY_MODE_OFF: Turn off VRR on the display */
+	VRR_DISPLAY_MODE_OFF,
+	/** @VRR_DISPLAY_MODE_COUNT: Sentinel, not a valid mode, keep last */
+	VRR_DISPLAY_MODE_COUNT
+};
+
 /**
  * struct drm_amd_vsdb_info - AMD-specific VSDB information
  *
@@ -1352,6 +1361,12 @@ struct drm_connector_state {
 	 */
 	u8 max_bpc;
 
+	/**
+	 * @vrr_display_mode: One of &enum vrr_display_mode to indicate the VRR
+	 * type to use on a VRR-capable display.
+	 */
+	u8 vrr_display_mode;
+
 	/**
 	 * @privacy_screen_sw_state: See :ref:`Standard Connector
 	 * Properties<standard_connector_properties>`
@@ -2454,6 +2469,17 @@ struct drm_connector {
 	 */
 	struct drm_property *vrr_capable_property;
 
+	/**
+	 * @vrr_display_mode_property: Optional property for userspace to set
+	 * a connected display to a specific VRR mode, regardless of the
+	 * connected CRTC's VRR_ENABLED property. Drivers can create and attach
+	 * the property to a connector by calling
+	 * drm_connector_attach_vrr_display_mode_property(). Implementations can
+	 * then read the set display mode (&enum vrr_display_mode) from
+	 * &drm_connector_state.vrr_display_mode.
+	 */
+	struct drm_property *vrr_display_mode_property;
+
 	/**
 	 * @colorspace_property: Connector property to set the suitable
 	 * colorspace supported by the sink.
@@ -2859,6 +2885,7 @@ const char *drm_get_dpms_name(int val);
 const char *drm_get_dvi_i_subconnector_name(int val);
 const char *drm_get_dvi_i_select_name(int val);
 const char *drm_get_tv_mode_name(int val);
+const char *drm_get_vrr_mode_name(int val);
 const char *drm_get_tv_subconnector_name(int val);
 const char *drm_get_tv_select_name(int val);
 const char *drm_get_dp_subconnector_name(int val);
@@ -2883,6 +2910,8 @@ int drm_connector_attach_scaling_mode_property(struct drm_connector *connector,
 					       u32 scaling_mode_mask);
 int drm_connector_attach_vrr_capable_property(
 		struct drm_connector *connector);
+int drm_connector_attach_vrr_display_mode_property(struct drm_connector *connector,
+						   unsigned int supported_vrr_modes);
 void drm_connector_attach_panel_type_property(struct drm_connector *connector);
 int drm_connector_attach_broadcast_rgb_property(struct drm_connector *connector);
 int drm_connector_attach_colorspace_property(struct drm_connector *connector);

-- 
2.56.0

