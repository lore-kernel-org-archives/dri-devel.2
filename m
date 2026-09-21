Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EE6C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C6010EAAC;
	Mon, 21 Sep 2026 15:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="GdeTVI9/";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B41510EA83;
 Mon, 21 Sep 2026 15:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790006019; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FTQ+bvPpqX8tKRr0WxT41jf+nn2CdZ26Q9PHySm9ZIiIFUbLRnbR75xkBQu9GHzeR/tTUKZcwo2nflRM1dZJoRuQmwVGlh9KPMNxgnyFXevwStMe9LrL/oy9dzqrgrUAvd3e+lJCx6ihylP04I21TFz/xGE9ig3bKvURuGKUbPQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790006019;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Y6pNKsL2/kxw9VEVLNj37g/I6SH0Xh54QzUA4fywo6s=; 
 b=gjteqq/+Zr4bW7WKNFL6tCXHISRNB5IvV0jawTTOaHkdzDrSTDtXSbZlZhGMfZEM6hw0ROZK2JQ/X35/S5SspXl0jOL/mrw+ESKF2ButbTsltpsCZYV0akSKwYXNNTbYucAUmGxnfrd0B43tCS5j6wTbO45vqdHizRXIMoHu5tA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006019; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Y6pNKsL2/kxw9VEVLNj37g/I6SH0Xh54QzUA4fywo6s=;
 b=GdeTVI9/ySknEWMlLie5aNFu0UnUhp3eVj85hhAUq7Ruz/ayGx7l5QYlKQYEsktZ
 IL9UF1L0Q8W6KLD5qzQYegcca7z+sGXmF+rnPaofApYn7kNqM0stlzXAOmhbSkRwznm
 E+ApJk2uanDoXaBpZIaQz5AMYqiCB0UfZvTgswao=
Received: by smtp.zohomail.com with SMTPS id 1790006017269820.087454670457;
 Mon, 21 Sep 2026 08:53:37 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:43 +0200
Subject: [PATCH RFC 17/25] drm/connector: Add "qms_enabled" drm property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-17-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

HDMI includes a feature called "Quick Media Switching", or QMS for
short, which builds upon the existing VRR to allow for quick switching
between a select few common frame rates.

Add a DRM property to the connector to allow userspace to request the
kernel to use QMS. Only connectors of sources which do support QMS
should register this property, though whether a specific sink supports
QMS is orthogonal to this.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_atomic_helper.c |  3 +++
 drivers/gpu/drm/drm_atomic_uapi.c   |  4 ++++
 drivers/gpu/drm/drm_connector.c     | 48 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h         | 23 ++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 0664d5779282..a2919e3975a8 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -749,6 +749,9 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 			    new_connector_state->color_format)
 				new_crtc_state->connectors_changed = true;
 
+			if (old_connector_state->hdmi.qms_enabled !=
+			    new_connector_state->hdmi.qms_enabled)
+				new_crtc_state->connectors_changed = true;
 		}
 
 		if (funcs->atomic_check)
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index c9eb01d740b3..fe9516475451 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -993,6 +993,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->hdmi.broadcast_rgb = val;
 	} else if (property == connector->color_format_property) {
 		state->color_format = val;
+	} else if (property == connector->qms_enabled_property) {
+		state->hdmi.qms_enabled = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -1080,6 +1082,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->hdmi.broadcast_rgb;
 	} else if (property == connector->color_format_property) {
 		*val = state->color_format;
+	} else if (property == connector->qms_enabled_property) {
+		*val = state->hdmi.qms_enabled;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 5c07bd221977..7ea235a58781 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2605,6 +2605,8 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
  *	numerator/denominator pair of a frame rate to set as the minimum VRR
  *	target rate. Set to 0 to disable.
  *
+ * .. _VRR-MIN-DENOMINATOR:
+ *
  * "VRR_MIN_DENOMINATOR":
  *	Default &drm_crtc integer property forming the denominator of a
  *	numerator/denominator pair of a frame rate to set as the minimum VRR
@@ -2619,11 +2621,30 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
  *	numerator/denominator pair of a frame rate to set as the maximum VRR
  *	target rate. Set to 0 to disable.
  *
+ * .. _VRR-MAX-DENOMINATOR:
+ *
  * "VRR_MAX_DENOMINATOR":
  *	Default &drm_crtc integer property forming the denominator of a
  *	numerator/denominator pair of a frame rate to set as the maximum VRR
  *	target rate. If :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` is not
  *	zero, it must be non-zero. Otherwise, must also be zero.
+ *
+ * "qms_enabled":
+ *	Optional &drm_connector boolean property that drivers should attach with
+ *	drm_connector_attach_qms_enabled_property() on connectors that support
+ *	HDMI Quick Media Switching (QMS). Present only depending on source
+ *	capability, with no regards to sink capability. Userspace may set it to
+ *	true if the variable refresh target rate that's expressed through
+ *	:ref:`VRR_MIN_NUMERATOR <VRR-MIN-NUMERATOR>` divided by
+ *	:ref:`VRR_MIN_DENOMINATOR <VRR-MIN-DENOMINATOR>` (which, in this case,
+ *	should be equal to :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` divided
+ *	by :ref:`VRR_MAX_DENOMINATOR <VRR-MAX-DENOMINATOR>` to signal a fixed
+ *	rate) should be achieved with signaling for HDMI Quick Media Switching.
+ *
+ *	Attempting to enable QMS when the attached display is not QMS capable,
+ *	or when the set fixed target rate is not possible with QMS, will result
+ *	in an error during the atomic check phase that will be passed up to
+ *	userspace to handle.
  */
 
 /**
@@ -3318,6 +3339,33 @@ int drm_connector_attach_color_format_property(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_connector_attach_color_format_property);
 
+/**
+ * drm_connector_attach_qms_enabled_property - attach "qms_enabled" property
+ * @connector: pointer to &struct drm_connector to attach this property on.
+ *
+ * Create and attach the "qms_enabled" property to the given @connector, which
+ * can be used by userspace to signal that it would like to achieve the CRTC's
+ * desired VRR target frame rate with HDMI "Quick Media Switching".
+ *
+ * Should only be called if the source actually supports generating the packets
+ * needed for QMS, but is present regardless of sink support for QMS.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_qms_enabled_property(struct drm_connector *connector)
+{
+	connector->qms_enabled_property =
+		drm_property_create_bool(connector->dev, 0, "qms_enabled");
+	if (!connector->qms_enabled_property)
+		return -ENOMEM;
+
+	drm_object_attach_property(&connector->base, connector->qms_enabled_property, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_qms_enabled_property);
+
 /**
  * drm_connector_atomic_hdr_metadata_equal - checks if the hdr metadata changed
  * @old_state: old connector state to compare
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8439c82db905..a5631bebb4df 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1238,6 +1238,18 @@ struct drm_connector_hdmi_state {
 	 * deliberately not requested by the helper.
 	 */
 	bool scrambler_needed;
+
+	/**
+	 * @qms_tfr_byte: Target frame rate byte for HDMI QMS, or 0 if QMS is
+	 * not in use.
+	 */
+	u8 qms_tfr_byte;
+
+	/**
+	 * @qms_enabled: Whether or not userspace requests to use HDMI Quick
+	 * Media Switching to achieve the target frame rate.
+	 */
+	bool qms_enabled;
 };
 
 /**
@@ -2490,6 +2502,16 @@ struct drm_connector {
 	 */
 	struct drm_property *vrr_capable_property;
 
+	/**
+	 * @qms_enabled_property: Optional atomic boolean property through which
+	 * userspace can indicate that HDMI "Quick Media Switching" should be
+	 * used to achieve the CRTC's target frame rate.
+	 *
+	 * Only HDMI connectors of sources capable of generating the right HDMI
+	 * signalling packets should register this property.
+	 */
+	struct drm_property *qms_enabled_property;
+
 	/**
 	 * @colorspace_property: Connector property to set the suitable
 	 * colorspace supported by the sink.
@@ -3016,6 +3038,7 @@ const char *drm_get_colorspace_name(enum drm_colorspace colorspace);
 
 int drm_connector_attach_color_format_property(struct drm_connector *connector,
 					       unsigned long supported_color_formats);
+int drm_connector_attach_qms_enabled_property(struct drm_connector *connector);
 
 /**
  * drm_for_each_connector_iter - connector_list iterator macro

-- 
2.55.0

