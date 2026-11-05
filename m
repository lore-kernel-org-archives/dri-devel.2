Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D609606A609
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=jpPt807I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A541127DA;
	Thu,  5 Nov 2026 15:53:53 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE3111286D;
 Thu,  5 Nov 2026 15:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793894017; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Rblk8yeKtrVAQjhmQ5k8n0TVHGaa1iBGvZGrbljaDFpI2J3RYx0DsumS6WYRjoD/dZqEfilJ1NBHpT50nh3Kc0N8BUZh+AJI7hE32VF0L6F5h6l2XL30h1eI1GkmHMeyUpk0DP8VD+FJwppIdbZWd4F6hF2JyAstLZxWsIIPRiA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793894017;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=PolKRYw7GBLw5KNxkR/whXtn/+An+bZ1AOUOWliicOA=; 
 b=NEgy1+OSN2SbHFR5aKUnuLhihI+fMnktBn9hQQOaomYgrcigdpLhb15BOTmTNzFYl08ictn5VwLaKOUxm2IosPocJbWEgrx80tEs8HQEkwkLU7bBQX9GXmV3ZKItshRWbe464MpuVAj13IGz1T7gN3yL9D/GE0GQPrteVvftr+8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=jpPt807ICfmpDH0YNA4tNw4rt8wUaSfQCdhHQhSNIATPDEggTv6Bc7X90FvN7Em9HYZcv4DZh8Nls5c76Mkuovh4iz9i+VkURJzsJ7b+Q72vViDqrKGA/664zkovnzWQbyZ49O8tOA69+T2ILin1pIhFJcl+RbeqMQ1m1nmrkBg=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=PolKRYw7GBLw5KNxkR/whXtn/+An+bZ1AOUOWliicOA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894015900246.87112414763692; 
 Thu, 5 Nov 2026 07:53:35 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:01 +0100
Subject: [PATCH v2 10/27] drm/connector: Add vrr_display_{min,max}
 connector properties
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-vrr-limiter-uapi-v2-10-55f4215be2c2@collabora.com>
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

Depending on whichever quirks a driver applies, what the minimum and
maximum display-supported refresh rates for VRR are is not always
obvious to userspace.

To rectify this, add two new read-only connector properties. These
properties specify the smallest, and respectively the largest, integer
refresh rate in Hertz that the current mode is capable of displaying
with Variable Refresh Rate.

Due to how messy and chicken-and-egg it would be to implement it, this
does not consider the fractional rates below VRR min that might be
allowed, the CinemaVRR rates that might be allowed below VRRmin on HDMI
displays with this feature if userspace ends up presenting fixed rate,
or the QMS range.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_helper.c | 55 +++++++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c           | 67 +++++++++++++++++++++++++++++++
 include/drm/display/drm_hdmi_helper.h     |  3 ++
 include/drm/drm_connector.h               | 30 ++++++++++++++
 4 files changed, 155 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
index f85cce3d6254..8f325d5e496d 100644
--- a/drivers/gpu/drm/display/drm_hdmi_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
@@ -730,3 +730,58 @@ int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
 	return ret;
 }
 EXPORT_SYMBOL(drm_connector_hdmi_sync_scdc);
+
+/**
+ * drm_connector_hdmi_update_vrr_limits - update VRR display limit properties
+ * @conn: pointer to the &struct drm_connector to set the properties on
+ * @mode: pointer to the &struct drm_display_mode to consider while updating
+ *
+ * Update the "vrr_display_min" and "vrr_display_max" properties on @conn based
+ * on its HDMI sink info and the current mode. Does not consider any display
+ * protocol other than HDMI.
+ *
+ * Will set both min and max to 0 if max happens to end up below min, which can
+ * happen with CNMVRR==0 and a lower refresh rate @mode.
+ *
+ * Return: %0 on success, negative errno otherwise
+ */
+int drm_connector_hdmi_update_vrr_limits(struct drm_connector *conn,
+					 const struct drm_display_mode *mode)
+{
+	struct drm_mode_object *obj = &conn->base;
+	const struct drm_display_info *info;
+	u16 min_hz, max_hz;
+
+	if (!conn->vrr_display_min_property || !conn->vrr_display_max_property)
+		return -ENOENT;
+
+	info = &conn->display_info;
+
+	if (!info->is_hdmi)
+		return -EINVAL;
+
+	if (conn->status != connector_status_connected ||
+	    !info->hdmi.vrr_cap.supported) {
+		drm_object_property_set_value(obj, conn->vrr_display_min_property, 0);
+		drm_object_property_set_value(obj, conn->vrr_display_max_property, 0);
+
+		return 0;
+	}
+
+	min_hz = info->hdmi.vrr_cap.vrr_min;
+
+	if (info->hdmi.vrr_cap.cnmvrr)
+		max_hz = info->hdmi.vrr_cap.vrr_max;
+	else
+		max_hz = min(drm_mode_vrefresh(mode), info->hdmi.vrr_cap.vrr_max);
+
+	/* VRR is impossible in the current mode */
+	if (max_hz <= min_hz)
+		min_hz = max_hz = 0;
+
+	drm_object_property_set_value(obj, conn->vrr_display_min_property, min_hz);
+	drm_object_property_set_value(obj, conn->vrr_display_max_property, max_hz);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_hdmi_update_vrr_limits);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 33c4195db58b..21222214a843 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2641,6 +2641,20 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
  *	numerator/denominator pair of a frame rate to set as the maximum VRR
  *	target rate. If :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` is not
  *	zero, it must be non-zero.
+ *
+ * "vrr_display_min":
+ *	Optional &drm_connector property that expresses the lowest integer
+ *	frame rate in Hertz that the display can achieve in the current mode
+ *	with VRR. It is highly likely the display can represent rational rates
+ *	below this value (e.g. 24/1.001), which an atomic test commit with the
+ *	limiters set appropriately will reveal. This minimum is assuming
+ *	non-constant frame intervals, i.e. does not consider features like
+ *	CinemaVRR for HDMI.
+ *
+ * "vrr_display_max":
+ *	Optional &drm_connector property that expresses the highest integer
+ *	frame rate in Hertz that the display can achieve in the current mode
+ *	with VRR.
  */
 
 /**
@@ -2737,6 +2751,59 @@ int drm_connector_attach_vrr_display_mode_property(struct drm_connector *connect
 }
 EXPORT_SYMBOL(drm_connector_attach_vrr_display_mode_property);
 
+/**
+ * drm_connector_attach_vrr_display_limits_properties - creates and attaches VRR
+ * display limit properties
+ * @connector: pointer to the &struct drm_connector to attach the properties to
+ *
+ * Creates and attaches the "vrr_display_min" and "vrr_display_max" properties
+ * on @connector. Will either create and attach both, or on failure, neither,
+ * but never just one of the two, unless a connector with just one of the two
+ * already created is passed in.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure
+ */
+int drm_connector_attach_vrr_display_limits_properties(
+	struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *min_p = NULL, *max_p = NULL;
+
+	if (!connector->vrr_display_min_property) {
+		min_p = drm_property_create_range(dev, DRM_MODE_PROP_IMMUTABLE,
+						  "vrr_display_min", 0, U16_MAX);
+
+		if (!min_p)
+			return -ENOMEM;
+	}
+
+	if (!connector->vrr_display_max_property) {
+		max_p = drm_property_create_range(dev, DRM_MODE_PROP_IMMUTABLE,
+						  "vrr_display_max", 0, U16_MAX);
+
+		if (!max_p) {
+			if (min_p)
+				drm_property_destroy(dev, min_p);
+
+			return -ENOMEM;
+		}
+	}
+
+	if (min_p) {
+		connector->vrr_display_min_property = min_p;
+		drm_object_attach_property(&connector->base, min_p, 0);
+	}
+
+	if (max_p) {
+		connector->vrr_display_max_property = max_p;
+		drm_object_attach_property(&connector->base, max_p, 0);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_vrr_display_limits_properties);
+
 /**
  * drm_connector_attach_scaling_mode_property - attach atomic scaling mode property
  * @connector: connector to attach scaling mode property on.
diff --git a/include/drm/display/drm_hdmi_helper.h b/include/drm/display/drm_hdmi_helper.h
index 2cdd6e3bc090..dd96885bb592 100644
--- a/include/drm/display/drm_hdmi_helper.h
+++ b/include/drm/display/drm_hdmi_helper.h
@@ -50,4 +50,7 @@ int
 drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
 			     struct drm_modeset_acquire_ctx *ctx);
 
+int drm_connector_hdmi_update_vrr_limits(struct drm_connector *conn,
+					 const struct drm_display_mode *mode);
+
 #endif
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5b6920c1a996..c0865a2547fd 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2495,6 +2495,34 @@ struct drm_connector {
 	 */
 	struct drm_property *vrr_display_mode_property;
 
+	/**
+	 * @vrr_display_min_property: Optional read-only property to help
+	 * userspace query the minimum supported VRR refresh rate in Hz by the
+	 * display.
+	 *
+	 * Can be attached to a connector by calling
+	 * drm_connector_attach_vrr_display_limits_properties().
+	 *
+	 * Drivers should update it through drm_object_property_set_value()
+	 * or through the helper drm_connector_hdmi_update_vrr_limits() for HDMI
+	 * connectors using standard HDMI VRR.
+	 */
+	struct drm_property *vrr_display_min_property;
+
+	/**
+	 * @vrr_display_max_property: Optional read-only property to help
+	 * userspace query the maximum supported VRR refresh rate in Hz by the
+	 * display.
+	 *
+	 * Can be attached to a connector by calling
+	 * drm_connector_attach_vrr_display_limits_properties().
+	 *
+	 * Drivers should update it through drm_object_property_set_value()
+	 * or through the helper drm_connector_hdmi_update_vrr_limits() for HDMI
+	 * connectors using standard HDMI VRR.
+	 */
+	struct drm_property *vrr_display_max_property;
+
 	/**
 	 * @colorspace_property: Connector property to set the suitable
 	 * colorspace supported by the sink.
@@ -2927,6 +2955,8 @@ int drm_connector_attach_vrr_capable_property(
 		struct drm_connector *connector);
 int drm_connector_attach_vrr_display_mode_property(struct drm_connector *connector,
 						   unsigned int supported_vrr_modes);
+int drm_connector_attach_vrr_display_limits_properties(
+		struct drm_connector *connector);
 void drm_connector_attach_panel_type_property(struct drm_connector *connector);
 int drm_connector_attach_broadcast_rgb_property(struct drm_connector *connector);
 int drm_connector_attach_colorspace_property(struct drm_connector *connector);

-- 
2.56.0

