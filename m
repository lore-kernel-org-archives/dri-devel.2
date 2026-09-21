Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5166CC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E988710EAA5;
	Mon, 21 Sep 2026 15:53:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="g6da8j9/";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3086310EA56;
 Mon, 21 Sep 2026 15:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790005997; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XahlPAYNjDzRctea301zGJHETm8cszOEd4hclQSx3BhQlOVrX56sZa2sbC07zTmRiV+6HeM07kk97xl7/zFEp/yVU4nXARI/dfxsX3iGzg6C3HBtjT/DYQ+FHXPE6yfvooAPVmXlz96ycY+/h2g0LO+TwhX6LVElp7GT5Re6DWA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790005997;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/FoKRakhY4NsKczet48wwu0RDCyKt3DGaCiZ6bh1z0o=; 
 b=H8JabL+G3SKEsM9FyVz/le7hCmsTcw9Z4ifRCodVQ8YVtPuvN/EUBrDy4On3i2doLwCi5GCgrx0Fuwm+UeLGvs0hvKC9CSZxj55ITUrME6oRjGdHL2faQpGCDC4mr2YcxMVPi5wUo/q9HKXTvYKeEY/6Sl4IpUdrdg3uvsftH1Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005997; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=/FoKRakhY4NsKczet48wwu0RDCyKt3DGaCiZ6bh1z0o=;
 b=g6da8j9/euUYTP+py59U99/QEd4qOcDh0eHWCJXJ/EJTXlbJ+vX4zTkNXXHltAAf
 sX4+js/MMVyuDAyAIs2UnhE3r/tmZWZk125TOY068BYR2yCtQj0wA/JJRjJ7EFK56h1
 iqyBOvHogPFrzdCS56u6i52IONlqL68S4inX7R7g=
Received: by smtp.zohomail.com with SMTPS id 1790005995550693.3087509800898;
 Mon, 21 Sep 2026 08:53:15 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:39 +0200
Subject: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
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

Userspace may wish to set a target frame rate for the Variable Refresh
Rate mechanism. There are multiple possible ways such a target could be
communicated.

It's desirable for userspace to not only set a fixed target, but a
target range within which VRR may operate. This is because even if a
sink advertises a certain range as supported, said range may not be the
ideal range to use, as numbers on the extreme end of the range may
induce flickering or other glitches.

There's four choices to how one bracketing value for the target range
could be communicated:
1. Target frame rate in something like millihertz
2. Target frame period in something like usecs
3. Target vtotal value
4. Target frame rate as a fraction expressed by two integers

Choice 1 is unpleasant as it would introduce some amount of rounding to
common broadcast framerates like 24/1.001, which seems minor except that
exact matches to standard framerates would rely on making all userspace
and kernel agree on a specific method of rounding. This is sure to go
wrong, so is disqualified.

Choice 2 has the same problem as 1, with the added complication that
the EDID's VRR range is expressed in frames per second, and other HDMI
features express things in frames per second as well, which would
require possibly imprecise computations.

Choice 3 is disqualified as mechanisms other than VRR, such as FVA, may
also modify the vtotal value. Additionally, it has the same drawbacks of
choice 2 and 1.

Choice 4 is therefore what's implemented. The frame rate 24/1.001Hz, for
example, is expressed as nominator=24000 and denominator=1001. As there
is both a minimum and a maximum, there are 4 properties in total: two
numerators, and two denominators. A fixed rate with no variability is
expressed by setting the minimum fractional and the maximum fractional
properties to the same value.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 24 +++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c   | 45 +++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_crtc.c        |  8 +++++++
 drivers/gpu/drm/drm_mode_config.c | 20 +++++++++++++++++
 include/drm/drm_crtc.h            |  4 ++++
 include/drm/drm_mode_config.h     | 45 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 146 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eebcf6f5e05..c9eb01d740b3 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -420,6 +420,22 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		return ret;
 	} else if (property == config->prop_vrr_enabled) {
 		state->vrr_enabled = val;
+	} else if (property == config->prop_vrr_min_numerator) {
+		if (val > U32_MAX)
+			return -EINVAL;
+		state->vrr_state.vrr_min_n = val;
+	} else if (property == config->prop_vrr_min_denominator) {
+		if (val > U32_MAX)
+			return -EINVAL;
+		state->vrr_state.vrr_min_d = val;
+	} else if (property == config->prop_vrr_max_numerator) {
+		if (val > U32_MAX)
+			return -EINVAL;
+		state->vrr_state.vrr_max_n = val;
+	} else if (property == config->prop_vrr_max_denominator) {
+		if (val > U32_MAX)
+			return -EINVAL;
+		state->vrr_state.vrr_max_d = val;
 	} else if (property == config->degamma_lut_property) {
 		const size_t elem_size = sizeof(struct drm_color_lut);
 		u64 lut_size;
@@ -505,6 +521,14 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
 		*val = (state->mode_blob) ? state->mode_blob->base.id : 0;
 	else if (property == config->prop_vrr_enabled)
 		*val = state->vrr_enabled;
+	else if (property == config->prop_vrr_min_numerator)
+		*val = state->vrr_state.vrr_min_n;
+	else if (property == config->prop_vrr_min_denominator)
+		*val = state->vrr_state.vrr_min_d;
+	else if (property == config->prop_vrr_max_numerator)
+		*val = state->vrr_state.vrr_max_n;
+	else if (property == config->prop_vrr_max_denominator)
+		*val = state->vrr_state.vrr_max_d;
 	else if (property == config->degamma_lut_property)
 		*val = (state->degamma_lut) ? state->degamma_lut->base.id : 0;
 	else if (property == config->ctm_property)
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index fc7d9fcf9d9f..5c07bd221977 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2579,6 +2579,51 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
  *
  *	The driver may place further restrictions within these minimum
  *	and maximum bounds.
+ *
+ * VRR Limiter/Target Properties
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * The ``VRR_{MIN,MAX}_{NUMERATOR,DENOMINATOR}`` properties expose a mechanism
+ * through which userspace can control the desired range of refresh rates in
+ * which VRR is allowed to operate. Each rate is expressed as a
+ * numerator/denominator fraction of refresh rates in Hz, allowing for rational
+ * target rates like 24/1.001 Hz with no loss of precision or ambiguity.
+ *
+ * If the minimum and maximum rate are set to the same value (and not 0), they
+ * are understood as a fixed target rate. This is especially useful for media
+ * playback, where the content's frame rate is both constant and known in
+ * advance. In such cases, a refresh rate that is not an integer multiple of the
+ * content's frame rate will introduce judder, since not every frame is
+ * displayed for the same amount of time. A modeset of the display with a
+ * compatible rate may in those cases be either undesirable or impossible, but
+ * the rate can still effectively be reached through VRR.
+ *
+ * .. _VRR-MIN-NUMERATOR:
+ *
+ * "VRR_MIN_NUMERATOR":
+ *	Default &drm_crtc integer property forming the numerator of a
+ *	numerator/denominator pair of a frame rate to set as the minimum VRR
+ *	target rate. Set to 0 to disable.
+ *
+ * "VRR_MIN_DENOMINATOR":
+ *	Default &drm_crtc integer property forming the denominator of a
+ *	numerator/denominator pair of a frame rate to set as the minimum VRR
+ *	target rate. If :ref:`VRR_MIN_NUMERATOR <VRR-MIN-NUMERATOR>` is not
+ *	zero, it must be non-zero.
+ *	Otherwise, must also be zero.
+ *
+ * .. _VRR-MAX-NUMERATOR:
+ *
+ * "VRR_MAX_NUMERATOR":
+ *	Default &drm_crtc integer property forming the numerator of a
+ *	numerator/denominator pair of a frame rate to set as the maximum VRR
+ *	target rate. Set to 0 to disable.
+ *
+ * "VRR_MAX_DENOMINATOR":
+ *	Default &drm_crtc integer property forming the denominator of a
+ *	numerator/denominator pair of a frame rate to set as the maximum VRR
+ *	target rate. If :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` is not
+ *	zero, it must be non-zero. Otherwise, must also be zero.
  */
 
 /**
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 63ead8ba6756..9244fbf97029 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -322,6 +322,14 @@ static int __drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *
 					   config->prop_out_fence_ptr, 0);
 		drm_object_attach_property(&crtc->base,
 					   config->prop_vrr_enabled, 0);
+		drm_object_attach_property(&crtc->base,
+					   config->prop_vrr_min_numerator, 0);
+		drm_object_attach_property(&crtc->base,
+					   config->prop_vrr_min_denominator, 0);
+		drm_object_attach_property(&crtc->base,
+					   config->prop_vrr_max_numerator, 0);
+		drm_object_attach_property(&crtc->base,
+					   config->prop_vrr_max_denominator, 0);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 48a56f23dadb..da967d60f832 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -535,6 +535,26 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
 		return -ENOMEM;
 	dev->mode_config.prop_vrr_enabled = prop;
 
+	prop = drm_property_create_range(dev, 0, "VRR_MIN_NUMERATOR", 0, U32_MAX);
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.prop_vrr_min_numerator = prop;
+
+	prop = drm_property_create_range(dev, 0, "VRR_MIN_DENOMINATOR", 0, U32_MAX);
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.prop_vrr_min_denominator = prop;
+
+	prop = drm_property_create_range(dev, 0, "VRR_MAX_NUMERATOR", 0, U32_MAX);
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.prop_vrr_max_numerator = prop;
+
+	prop = drm_property_create_range(dev, 0, "VRR_MAX_DENOMINATOR", 0, U32_MAX);
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.prop_vrr_max_denominator = prop;
+
 	prop = drm_property_create(dev,
 			DRM_MODE_PROP_BLOB,
 			"DEGAMMA_LUT", 0);
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 9d58158af459..df37f4ebb58e 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -67,6 +67,10 @@ struct drm_crtc_vrr_state {
 	u8 vic;
 	u16 cur_vtotal;
 	u16 max_vtotal;
+	u32 vrr_min_n;
+	u32 vrr_min_d;
+	u32 vrr_max_n;
+	u32 vrr_max_d;
 	u16 base_vtotal;
 	bool dynamic;
 };
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 084517beb924..c8d5286f9267 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -702,6 +702,51 @@ struct drm_mode_config {
 	 */
 	struct drm_property *prop_vrr_enabled;
 
+	/**
+	 * @prop_vrr_min_numerator: Default atomic CRTC property to indicate the
+	 * numerator of a numerator/denominator variable refresh rate minimum
+	 * target frame rate.
+	 *
+	 * If not zero, @prop_vrr_min_numerator divided by
+	 * @prop_vrr_min_denominator must result in a frame rate above the
+	 * sink's minimum VRR rate.
+	 */
+	struct drm_property *prop_vrr_min_numerator;
+
+	/**
+	 * @prop_vrr_min_denominator: Default atomic CRTC property to indicate
+	 * the denominator of a numerator/denominator variable refresh rate
+	 * minimum target frame rate.
+	 *
+	 * If @prop_vrr_min_numerator is set, @prop_vrr_min_denominator must not
+	 * be 0, and @prop_vrr_min_numerator divided by @prop_vrr_min_denominator
+	 * must result in a frame rate above the minimum VRR rate.
+	 */
+	struct drm_property *prop_vrr_min_denominator;
+
+	/**
+	 * @prop_vrr_max_numerator: Default atomic CRTC property to indicate the
+	 * numerator of a numerator/denominator variable refresh rate maximum
+	 * target frame rate range.
+	 *
+	 * The fraction expressed by this property divided by its corresponding
+	 * denominator must be equal to or greater than the value of
+	 * @prop_vrr_min_numerator.
+	 */
+	struct drm_property *prop_vrr_max_numerator;
+
+	/**
+	 * @prop_vrr_max_denominator: Default atomic CRTC property to indicate
+	 * the denominator of a numerator/denominator variable refresh rate
+	 * maximum target frame rate range.
+	 *
+	 * If @prop_vrr_max_numerator is set, @prop_vrr_max_denominator must not
+	 * be 0, and @prop_vrr_max_numerator divided by @prop_vrr_max_denominator
+	 * must result in a frame rate equal to or above @prop_vrr_min_numerator
+	 * divided by @prop_vrr_min_denominator.
+	 */
+	struct drm_property *prop_vrr_max_denominator;
+
 	/**
 	 * @dvi_i_subconnector_property: Optional DVI-I property to
 	 * differentiate between analog or digital mode.

-- 
2.55.0

