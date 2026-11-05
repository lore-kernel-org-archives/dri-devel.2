Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A05606A608
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=V0RooOBn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7AA7112837;
	Thu,  5 Nov 2026 15:53:50 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E3011281D;
 Thu,  5 Nov 2026 15:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793894011; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GMwWC5MzETAkaw4tW+qMQ6JD+5BFY1QzOy5b3n0/LgwqXUmY8SIRxH578B7y5QzTLhs1s0gc9ivOyLFuDgLn3HY7GlwbotP646gzgNNjonyJMgCEexSrQ5V1DwDsBGv+OXDV4oYYWXxcjrXfLtxho+7rD0mtVncN274oQcwLSH8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793894011;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7HoI5TguOrq0YzUzCSZ/fSOD4Rb8KCPNHnIXyt5JpJ4=; 
 b=diECQ7YO02tCK+CQHMm9dmDORSlCIXM9oalqP28XTeJ9iMVXXKD/q5ajy9VDPD03d/SNT9YHLPnc6r0MyFi0U9ICZ4PEre3Fbk4iLHoFDdmgl9sMO+43H5gUklKkm64xH3sffSu8Andfvd1nva2P93sGwShVtM78+NUlvZ+xUC8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=V0RooOBnqq4VgjFXn7a6LZGcr5vmVSkL6Qf1fAjHQoZyz3euMZP3o6N4tMSueZ1ifPnRgE8HHcaVUquhdZkUNYCSVfCipl/xbKVwb5xfrLxsPaunuuyLM0tMW+2xGz97M022Pw3EXcLvFOaY8Wi/YcZuwkNU7xFfp0wNTAVM/lU=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=7HoI5TguOrq0YzUzCSZ/fSOD4Rb8KCPNHnIXyt5JpJ4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894009305491.63368064008205; 
 Thu, 5 Nov 2026 07:53:29 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:00 +0100
Subject: [PATCH v2 09/27] drm: Add VRR target frame rate properties
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-vrr-limiter-uapi-v2-9-55f4215be2c2@collabora.com>
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
 drivers/gpu/drm/drm_atomic.c      | 14 ++++++++++++
 drivers/gpu/drm/drm_atomic_uapi.c | 24 ++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c   | 48 +++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_crtc.c        | 34 +++++++++++++++++++++++++++
 drivers/gpu/drm/drm_mode_config.c | 20 ++++++++++++++++
 include/drm/drm_crtc.h            |  6 +++++
 include/drm/drm_mode_config.h     | 45 ++++++++++++++++++++++++++++++++++++
 7 files changed, 191 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9bb761eda59f..da5c6925c349 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -489,6 +489,7 @@ EXPORT_SYMBOL(drm_atomic_get_crtc_state);
 static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_state,
 				 const struct drm_crtc_state *new_crtc_state)
 {
+	const struct drm_crtc_vrr_state *vrr = &new_crtc_state->vrr_state;
 	struct drm_crtc *crtc = new_crtc_state->crtc;
 
 	/* NOTE: we explicitly don't enforce constraints such as primary
@@ -544,6 +545,19 @@ static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_state,
 		return -EINVAL;
 	}
 
+	/*
+	 * Reject VRR limiter ranges that only specify one end of the limit, or
+	 * specify a numerator > 0 with a denominator that is 0.
+	 */
+	if ((!vrr->vrr_min_n || !vrr->vrr_min_d ||
+	     !vrr->vrr_max_n || !vrr->vrr_max_d) &&
+	    (vrr->vrr_min_n > 0 || vrr->vrr_max_n > 0)) {
+		drm_dbg_atomic(crtc->dev,
+			       "[CRTC:%d:%s] incomplete VRR limiter range\n",
+			       crtc->base.id, crtc->name);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 127bdd77802b..c95eaa9697c4 100644
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
index a44afba8c5ff..33c4195db58b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2593,6 +2593,54 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
  *	    - Game - set display to game mode if display supports it,
  *	      regardless of CRTC state
  *	    - Off - set display to VRR disabled mode, regardless of CRTC state
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
+ * If one end of the limit is set (e.g. minimum), the other end (e.g. maximum)
+ * must also be set. Any rational with a numerator of 0 is treated as 0/0
+ * regardless of denominator.
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
+ *	zero, it must be non-zero.
  */
 
 /**
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 5295ec122e0d..4c29c6e15df9 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -324,6 +324,40 @@ static int __drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *
 	return 0;
 }
 
+/**
+ * drm_crtc_attach_vrr_limiter_properties - Attach VRR limiter props to CRTC
+ * @crtc: The CRTC to attach the properties to
+ *
+ * Attach the VRR limiter target minimum and maximum frame rate properties to
+ * @crtc. The driver implementing @crtc must use atomic mode setting.
+ *
+ * This convenience function is to be used by drivers which implement all the
+ * logic required for the VRR limiter uAPI to function.
+ *
+ * Returns:
+ * Zero on success, negative error on failure.
+ */
+int drm_crtc_attach_vrr_limiter_properties(struct drm_crtc *crtc)
+{
+	struct drm_mode_config *config = &crtc->dev->mode_config;
+
+	if (!drm_drv_uses_atomic_modeset(crtc->dev))
+		return -EINVAL;
+
+	drm_object_attach_property(&crtc->base,
+				   config->prop_vrr_min_numerator, 0);
+	drm_object_attach_property(&crtc->base,
+				   config->prop_vrr_min_denominator, 0);
+	drm_object_attach_property(&crtc->base,
+				   config->prop_vrr_max_numerator, 0);
+	drm_object_attach_property(&crtc->base,
+				   config->prop_vrr_max_denominator, 0);
+
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_crtc_attach_vrr_limiter_properties);
+
 /**
  * drm_crtc_init_with_planes - Initialise a new CRTC object with
  *    specified primary and cursor planes.
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
index bfb2b0741625..9004f7c2f21e 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -66,6 +66,10 @@ struct drm_plane_helper_funcs;
 struct drm_crtc_vrr_state {
 	u16 cur_vtotal;
 	u16 max_vtotal;
+	u32 vrr_min_n;
+	u32 vrr_min_d;
+	u32 vrr_max_n;
+	u32 vrr_max_d;
 	u16 base_vtotal;
 	bool dynamic;
 };
@@ -1247,6 +1251,8 @@ struct drm_mode_set {
 
 #define obj_to_crtc(x) container_of(x, struct drm_crtc, base)
 
+int drm_crtc_attach_vrr_limiter_properties(struct drm_crtc *crtc);
+
 __printf(6, 7)
 int drm_crtc_init_with_planes(struct drm_device *dev,
 			      struct drm_crtc *crtc,
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
2.56.0

