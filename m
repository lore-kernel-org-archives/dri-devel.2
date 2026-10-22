Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66002606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=eOA5GkkB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08891127DA;
	Thu, 22 Oct 2026 16:38:48 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A18411276E;
 Thu, 22 Oct 2026 16:38:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 484E11A12C9;
 Thu, 22 Oct 2026 16:38:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 14DCA60763;
 Thu, 22 Oct 2026 16:38:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DD28C10328EC8; 
 Thu, 22 Oct 2026 18:38:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792687114; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=YJcNexZ2/Nkt5BHYyV8GAYPfBjfMbhaDv/RV5cOUJzU=;
 b=eOA5GkkBm8jBpdR/GEL2KfjQJ8DmGPLqweZ19g8IlM98Lj+6a6YTbRn8QZ7frHFSt9+gE9
 R0I36FK5hzIUHLNt2GhQxfEUJQYlS8zNKdocZ/0EOeNMGn8WheSsah2I0zWI13ovf0tuH9
 9Bs9DGswuoMTHAMyP9RohjkyeitiFHNY6BkiVzjv7No7oO1KRrppT61746gojzL+/HcRIj
 XhDxGAB8bvkJbVUUv0bCSnY/+l+37Q0YTbPqzjKVSOCXHLhBy7+QQRWiyDAM//7sd4nVC2
 lfQwAqrOAg5YnvV5vIyUwYf/ymDBoXXBa93DGr9rd5CLi6WwxzncflVeKQ+E9A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 22 Oct 2026 18:37:57 +0200
Subject: [PATCH v4 1/8] drm: Move sink link rates reading helpers out of i915
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-feat_link_cap-v4-1-a4f3f6e8cad9@bootlin.com>
References: <20261022-feat_link_cap-v4-0-a4f3f6e8cad9@bootlin.com>
In-Reply-To: <20261022-feat_link_cap-v4-0-a4f3f6e8cad9@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Daniel Stone <daniels@collabora.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 Manasi Navare <navaremanasi@google.com>, 
 Drew Davenport <ddavenport@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.16.1-dev-17221
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

In preparation for adding generic DRM properties to report source and
sink capabilities, move the sink link rates reading functions out of
the i915 driver into the generic DRM helpers. These functions provide
everything needed to properly extract link rate capabilities from the
DPCD.

Keep the Intel-specific quirk handling in the driver.

No functional change intended.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Change in v4:
- Modify the series to incorporate the new tunnel features supported in the
  i915 driver.

Change in v3:
- New patch
---
 drivers/gpu/drm/display/drm_dp_helper.c | 254 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 184 ++++-------------------
 include/drm/display/drm_dp.h            |   1 +
 include/drm/display/drm_dp_helper.h     |  11 ++
 4 files changed, 294 insertions(+), 156 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e623ccb4c1d8a..3988da0a01fac 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -37,6 +37,7 @@
 
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
+#include <drm/display/drm_dp_tunnel.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_print.h>
@@ -4912,3 +4913,256 @@ int drm_dp_max_dprx_data_rate(int max_link_rate, int max_lanes)
 				  1000000 * 8);
 }
 EXPORT_SYMBOL(drm_dp_max_dprx_data_rate);
+
+/**
+ * drm_dp_read_dpcd_supported_link_rates() - read DPCD supported link rates
+ * @aux: DisplayPort AUX channel
+ * @link_rates: Buffer to store the resulting link rates supported
+ *
+ * Attempts to read the DPCD supported link rates for @aux.
+ *
+ * Returns: The number or supported link rates, negative error code otherwise.
+ */
+static int drm_dp_read_dpcd_supported_link_rates(struct drm_dp_aux *aux,
+						 int link_rates[DP_MAX_SUPPORTED_RATES])
+{
+	__le16 dpcd_link_rates[DP_MAX_SUPPORTED_RATES] = {0};
+	int ret, i;
+
+	ret = drm_dp_dpcd_read_data(aux, DP_SUPPORTED_LINK_RATES,
+				    dpcd_link_rates, sizeof(dpcd_link_rates));
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(dpcd_link_rates) && dpcd_link_rates[i]; i++)
+		link_rates[i] = le16_to_cpu(dpcd_link_rates[i]) * 20;
+
+	return i;
+}
+
+#if IS_ENABLED(CONFIG_DRM_DISPLAY_DP_TUNNEL)
+
+static int drm_dp_max_dprx_rate(const struct drm_dp_tunnel *tunnel,
+				const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+{
+	if (tunnel && drm_dp_tunnel_bw_alloc_is_enabled(tunnel))
+		return drm_dp_tunnel_max_dprx_rate(tunnel);
+	else
+		return drm_dp_bw_code_to_link_rate(dpcd[DP_MAX_LINK_RATE]);
+}
+
+static u8 drm_dprx_128b132b_link_rates(const struct drm_dp_tunnel *tunnel,
+				       u8 uhbr_rates)
+{
+	if (!drm_dp_tunnel_bw_alloc_is_enabled(tunnel))
+		return uhbr_rates;
+
+	static_assert(DP_TUNNELING_10GBPS_PER_LANE_SUPPORT == DP_UHBR10 &&
+		      DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT == DP_UHBR13_5 &&
+		      DP_TUNNELING_20GBPS_PER_LANE_SUPPORT == DP_UHBR20);
+
+	return drm_dp_tunnel_128b132b_dprx_rates(tunnel);
+}
+
+static bool drm_dprx_supports_128b132b(const struct drm_dp_tunnel *tunnel,
+				       const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+{
+	if (tunnel && drm_dp_tunnel_bw_alloc_is_enabled(tunnel))
+		return drm_dp_tunnel_128b132b_supported(tunnel);
+	else
+		return drm_dp_128b132b_supported(dpcd);
+}
+
+#else
+
+static int drm_dp_max_dprx_rate(const struct drm_dp_tunnel *tunnel,
+				const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+{
+	return drm_dp_bw_code_to_link_rate(dpcd[DP_MAX_LINK_RATE]);
+}
+
+static u8 drm_dprx_128b132b_link_rates(const struct drm_dp_tunnel *tunnel,
+				       u8 uhbr_rates)
+{
+	return uhbr_rates;
+}
+
+static bool drm_dprx_supports_128b132b(const struct drm_dp_tunnel *tunnel,
+				       const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+{
+		return drm_dp_128b132b_supported(dpcd);
+}
+
+#endif
+
+/**
+ * drm_dp_get_128b132b_link_rates() - get the supported 128b/132b link rates
+ * @lttpr_common_caps: LTTPR common capabilities
+ * @tunnel: DP tunnel object (NULL if not supported)
+ * @uhbr_rates: UHBR rate mask read from the DPCD
+ *		DP_128B132B_SUPPORTED_LINK_RATES register
+ * @link_rates: Buffer of DP_MAX_128B132B_SUPPORTED_RATES entries to store the
+ *		resulting link rates
+ *
+ * Limit the UHBR rate mask @uhbr_rates by the capabilities of the DP tunnel
+ * and of the LTTPRs, if any is present, then expand the remaining rates into
+ * @link_rates in ascending order.
+ *
+ * Returns: The number of link rates stored in @link_rates.
+ */
+static int
+drm_dp_get_128b132b_link_rates(const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],
+			       const struct drm_dp_tunnel *tunnel,
+			       u8 uhbr_rates,
+			       int link_rates[DP_MAX_128B132B_SUPPORTED_RATES])
+{
+	int i = 0;
+
+	if (tunnel)
+		uhbr_rates = drm_dprx_128b132b_link_rates(tunnel, uhbr_rates);
+
+	if (lttpr_common_caps && drm_dp_lttpr_count(lttpr_common_caps) > 0) {
+		/* We have a repeater */
+		if (lttpr_common_caps[0] >= 0x20 &&
+		    dp_lttpr_common_cap(lttpr_common_caps,
+					DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER) &
+		    DP_PHY_REPEATER_128B132B_SUPPORTED) {
+			/* Repeater supports 128b/132b, valid UHBR rates */
+			uhbr_rates &= dp_lttpr_common_cap(lttpr_common_caps,
+							  DP_PHY_REPEATER_128B132B_RATES);
+		} else {
+			/* Does not support 128b/132b */
+			uhbr_rates = 0;
+		}
+	}
+
+	if (uhbr_rates & DP_UHBR10)
+		link_rates[i++] = 1000000;
+	if (uhbr_rates & DP_UHBR13_5)
+		link_rates[i++] = 1350000;
+	if (uhbr_rates & DP_UHBR20)
+		link_rates[i++] = 2000000;
+
+	return i;
+}
+
+/**
+ * drm_dp_read_dpcd_sink_rates() - read the sink rates from the DPCD
+ * @aux: DisplayPort AUX channel
+ * @dpcd: DPCD receiver capabilities
+ * @lttpr_common_caps: LTTPR common capabilities
+ * @desc: DisplayPort sink descriptor
+ * @tunnel: Tunnel object (NULL if not supported)
+ * @sink_rates: Array of DP_MAX_SUPPORTED_RATES entries to store the sink rates
+ *
+ * Read the link rates supported by a DisplayPort sink from the DPCD
+ * DP_MAX_LINK_RATE and DP_128B132B_SUPPORTED_LINK_RATES registers, limited by
+ * the capabilities of the LTTPRs or the tunnel if any is present.
+ * The rates are stored in @sink_rates in ascending order.
+ *
+ * The DPCD receiver capabilities, the LTTPR common capabilities, the tunnel
+ * and the sink descriptor are passed by the caller instead of being read
+ * from the DPCD. Drivers which already read them, like i915, can pass them
+ * to avoid duplicate DPCD reads.
+ *
+ * Returns: The number of supported sink rates.
+ */
+int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
+				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
+				const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],
+				const struct drm_dp_desc *desc,
+				const struct drm_dp_tunnel *tunnel,
+				int sink_rates[DP_MAX_SUPPORTED_RATES])
+{
+	static const int dp_rates[] = {
+		162000, 270000, 540000, 810000
+	};
+	int max_rate, max_lttpr_rate = 0, ret, i;
+	u8 uhbr_rates = 0;
+
+	BUILD_BUG_ON(ARRAY_SIZE(dp_rates) + DP_MAX_128B132B_SUPPORTED_RATES >
+		     DP_MAX_SUPPORTED_RATES);
+
+	if (drm_dp_has_quirk(desc, DP_DPCD_QUIRK_CAN_DO_MAX_LINK_RATE_3_24_GBPS)) {
+		/* Needed, e.g., for Apple MBP 2017, 15 inch eDP Retina panel */
+		static const int quirk_rates[] = { 162000, 270000, 324000 };
+
+		memcpy(sink_rates, quirk_rates, sizeof(quirk_rates));
+
+		return ARRAY_SIZE(quirk_rates);
+	}
+
+	/*
+	 * Sink rates for 8b/10b.
+	 */
+	max_rate = drm_dp_max_dprx_rate(tunnel, dpcd);
+	if (lttpr_common_caps)
+		max_lttpr_rate = drm_dp_lttpr_max_link_rate(lttpr_common_caps);
+
+	if (max_lttpr_rate)
+		max_rate = min(max_rate, max_lttpr_rate);
+
+	for (i = 0; i < ARRAY_SIZE(dp_rates); i++) {
+		if (dp_rates[i] > max_rate)
+			break;
+		sink_rates[i] = dp_rates[i];
+	}
+
+	/*
+	 * The following register must be read unconditionally for the later
+	 * DP tunnel 128b132b detection to work, see DP Standard v2.1 5.14.3 .
+	 */
+	ret = drm_dp_dpcd_read_byte(aux, DP_128B132B_SUPPORTED_LINK_RATES,
+				    &uhbr_rates);
+	if (ret < 0) {
+		drm_dbg_kms(aux->drm_dev,
+			    "%s: Failed to read DPCD 128B/132B supported link rates (%d)\n",
+			    aux->name, ret);
+		uhbr_rates = 0;
+	}
+
+	/*
+	 * Sink rates for 128b/132b. If set, sink should support all 8b/10b
+	 * rates and 10 Gbps.
+	 */
+	if (drm_dprx_supports_128b132b(tunnel, dpcd))
+		i += drm_dp_get_128b132b_link_rates(lttpr_common_caps,
+						    tunnel,
+						    uhbr_rates,
+						    &sink_rates[i]);
+
+	return i;
+}
+EXPORT_SYMBOL_GPL(drm_dp_read_dpcd_sink_rates);
+
+/**
+ * drm_dp_read_edp_sink_rates() - read the sink rates from the eDP DPCD
+ * @aux: DisplayPort AUX channel
+ * @edp_dpcd_rev: eDP DPCD revision of the sink
+ * @sink_rates: Array of DP_MAX_SUPPORTED_RATES entries to store the sink rates
+ *
+ * Read the link rates supported by an eDP sink from the DPCD
+ * DP_SUPPORTED_LINK_RATES registers, available on eDP 1.4 and later sinks.
+ *
+ * Returns: The number of supported sink rates, 0 if the sink does not support
+ * the DP_SUPPORTED_LINK_RATES register.
+ */
+int drm_dp_read_edp_sink_rates(struct drm_dp_aux *aux, u8 edp_dpcd_rev,
+			       int sink_rates[DP_MAX_SUPPORTED_RATES])
+{
+	int num_sink_rates;
+
+	if (edp_dpcd_rev < DP_EDP_14)
+		return 0;
+
+	num_sink_rates = drm_dp_read_dpcd_supported_link_rates(aux, sink_rates);
+	if (num_sink_rates < 0) {
+		drm_dbg_kms(aux->drm_dev,
+			    "%s: Unable to read eDP supported link rates (%d)\n",
+			    aux->name, num_sink_rates);
+		return 0;
+	}
+
+	return num_sink_rates;
+}
+EXPORT_SYMBOL_GPL(drm_dp_read_edp_sink_rates);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 0cd5e6b5034cf..087afcea5395f 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -155,28 +155,6 @@ int intel_dp_link_symbol_clock(int rate)
 	return DIV_ROUND_CLOSEST(rate * 10, intel_dp_link_symbol_size(rate));
 }
 
-static int max_dprx_rate(struct intel_dp *intel_dp)
-{
-	struct intel_display *display = to_intel_display(intel_dp);
-	int max_rate;
-
-	if (intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))
-		max_rate = drm_dp_tunnel_max_dprx_rate(intel_dp->tunnel);
-	else
-		max_rate = drm_dp_bw_code_to_link_rate(intel_dp->dpcd[DP_MAX_LINK_RATE]);
-
-	/*
-	 * Some platforms + eDP panels may not reliably support HBR3
-	 * due to signal integrity limitations, despite advertising it.
-	 * Cap the link rate to HBR2 to avoid unstable configurations for the
-	 * known machines.
-	 */
-	if (intel_dp_is_edp(intel_dp) && intel_has_quirk(display, QUIRK_EDP_LIMIT_RATE_HBR2))
-		max_rate = min(max_rate, 540000);
-
-	return max_rate;
-}
-
 static int max_dprx_lane_count(struct intel_dp *intel_dp)
 {
 	if (intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))
@@ -191,102 +169,21 @@ static void intel_dp_set_default_sink_rates(struct intel_dp *intel_dp)
 	intel_dp->num_sink_rates = 1;
 }
 
-static bool dprx_supports_128b132b(struct intel_dp *intel_dp)
-{
-	if (intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))
-		return drm_dp_tunnel_128b132b_supported(intel_dp->tunnel);
-	else
-		return drm_dp_128b132b_supported(intel_dp->dpcd);
-}
-
-static u8 dprx_128b132b_link_rates(struct intel_dp *intel_dp, u8 no_bwa_rates)
-{
-	u8 ret;
-
-	if (!intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))
-		return no_bwa_rates;
-
-	ret = drm_dp_tunnel_128b132b_dprx_rates(intel_dp->tunnel);
-	static_assert(DP_TUNNELING_10GBPS_PER_LANE_SUPPORT == DP_UHBR10 &&
-		      DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT == DP_UHBR13_5 &&
-		      DP_TUNNELING_20GBPS_PER_LANE_SUPPORT == DP_UHBR20);
-
-	return ret;
-}
-
 /* update sink rates from dpcd */
 static void intel_dp_set_dpcd_sink_rates(struct intel_dp *intel_dp)
 {
-	static const int dp_rates[] = {
-		162000, 270000, 540000, 810000
-	};
-	int i, max_rate;
-	int max_lttpr_rate;
-	u8 uhbr_rates = 0;
-
-	if (drm_dp_has_quirk(&intel_dp->desc, DP_DPCD_QUIRK_CAN_DO_MAX_LINK_RATE_3_24_GBPS)) {
-		/* Needed, e.g., for Apple MBP 2017, 15 inch eDP Retina panel */
-		static const int quirk_rates[] = { 162000, 270000, 324000 };
-
-		memcpy(intel_dp->sink_rates, quirk_rates, sizeof(quirk_rates));
-		intel_dp->num_sink_rates = ARRAY_SIZE(quirk_rates);
-
-		return;
-	}
-
-	/*
-	 * Sink rates for 8b/10b.
-	 */
-	max_rate = max_dprx_rate(intel_dp);
-	max_lttpr_rate = drm_dp_lttpr_max_link_rate(intel_dp->lttpr_common_caps);
-	if (max_lttpr_rate)
-		max_rate = min(max_rate, max_lttpr_rate);
+	int num_sink_rates;
 
-	for (i = 0; i < ARRAY_SIZE(dp_rates); i++) {
-		if (dp_rates[i] > max_rate)
-			break;
-		intel_dp->sink_rates[i] = dp_rates[i];
-	}
+	num_sink_rates = drm_dp_read_dpcd_sink_rates(&intel_dp->aux,
+						     intel_dp->dpcd,
+						     intel_dp->lttpr_common_caps,
+						     &intel_dp->desc,
+						     intel_dp->tunnel,
+						     intel_dp->sink_rates);
+	if (num_sink_rates < 0)
+		num_sink_rates = 0;
 
-	/*
-	 * The following register must be read unconditionally for the later
-	 * DP tunnel 128b132b detection to work, see DP Standard v2.1 5.14.3 .
-	 */
-	drm_dp_dpcd_read_byte(&intel_dp->aux, DP_128B132B_SUPPORTED_LINK_RATES, &uhbr_rates);
-
-	/*
-	 * Sink rates for 128b/132b. If set, sink should support all 8b/10b
-	 * rates and 10 Gbps.
-	 */
-	if (dprx_supports_128b132b(intel_dp)) {
-		BUILD_BUG_ON(ARRAY_SIZE(intel_dp->sink_rates) < ARRAY_SIZE(dp_rates) + 3);
-
-		uhbr_rates = dprx_128b132b_link_rates(intel_dp, uhbr_rates);
-
-		if (drm_dp_lttpr_count(intel_dp->lttpr_common_caps)) {
-			/* We have a repeater */
-			if (intel_dp->lttpr_common_caps[0] >= 0x20 &&
-			    intel_dp->lttpr_common_caps[DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER -
-							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV] &
-			    DP_PHY_REPEATER_128B132B_SUPPORTED) {
-				/* Repeater supports 128b/132b, valid UHBR rates */
-				uhbr_rates &= intel_dp->lttpr_common_caps[DP_PHY_REPEATER_128B132B_RATES -
-									  DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-			} else {
-				/* Does not support 128b/132b */
-				uhbr_rates = 0;
-			}
-		}
-
-		if (uhbr_rates & DP_UHBR10)
-			intel_dp->sink_rates[i++] = 1000000;
-		if (uhbr_rates & DP_UHBR13_5)
-			intel_dp->sink_rates[i++] = 1350000;
-		if (uhbr_rates & DP_UHBR20)
-			intel_dp->sink_rates[i++] = 2000000;
-	}
-
-	intel_dp->num_sink_rates = i;
+	intel_dp->num_sink_rates = num_sink_rates;
 }
 
 static void intel_dp_set_sink_rates(struct intel_dp *intel_dp)
@@ -4722,60 +4619,35 @@ static void
 intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
+	int num_sink_rates;
 
-	intel_dp->num_sink_rates = 0;
+	num_sink_rates = drm_dp_read_edp_sink_rates(&intel_dp->aux,
+						    intel_dp->edp_dpcd[0],
+						    intel_dp->sink_rates);
+	if (num_sink_rates < 0)
+		num_sink_rates = 0;
 
-	if (intel_dp->edp_dpcd[0] >= DP_EDP_14) {
-		__le16 sink_rates[DP_MAX_SUPPORTED_RATES];
-		int ret;
-		int i;
-
-		ret = drm_dp_dpcd_read_data(&intel_dp->aux,
-					    DP_SUPPORTED_LINK_RATES,
-					    sink_rates, sizeof(sink_rates));
-		if (ret < 0) {
-			drm_dbg_kms(display->drm,
-				    "Unable to read eDP supported link rates, using default rates\n");
-			memset(sink_rates, 0, sizeof(sink_rates));
-		}
-
-		for (i = 0; i < ARRAY_SIZE(sink_rates); i++) {
-			int rate;
-
-			/* Value read multiplied by 200kHz gives the per-lane
-			 * link rate in kHz. The source rates are, however,
-			 * stored in terms of LS_Clk kHz. The full conversion
-			 * back to symbols is
-			 * (val * 200kHz)*(8/10 ch. encoding)*(1/8 bit to Byte)
-			 */
-			rate = le16_to_cpu(sink_rates[i]) * 200 / 10;
-
-			if (rate == 0)
-				break;
-
-			/*
-			 * Some platforms cannot reliably drive HBR3 rates due to PHY limitations,
-			 * even if the sink advertises support. Reject any sink rates above HBR2 on
-			 * the known machines for stable output.
-			 */
-			if (rate > 540000 &&
-			    intel_has_quirk(display, QUIRK_EDP_LIMIT_RATE_HBR2))
-				break;
-
-			intel_dp->sink_rates[i] = rate;
-		}
-		intel_dp->num_sink_rates = i;
-	}
+	intel_dp->num_sink_rates = num_sink_rates;
 
 	/*
 	 * Use DP_LINK_RATE_SET if DP_SUPPORTED_LINK_RATES are available,
 	 * default to DP_MAX_LINK_RATE and DP_LINK_BW_SET otherwise.
 	 */
-	if (intel_dp->num_sink_rates)
+	if (num_sink_rates)
 		intel_dp->use_rate_select = true;
 	else
 		intel_dp_set_sink_rates(intel_dp);
 
+	/*
+	 * Some platforms cannot reliably drive HBR3 rates due to PHY limitations,
+	 * even if the sink advertises support. Reject any sink rates above HBR2 on
+	 * the known machines for stable output.
+	 */
+	if (intel_dp->num_sink_rates && intel_has_quirk(display, QUIRK_EDP_LIMIT_RATE_HBR2))
+		intel_dp->num_sink_rates = intel_dp_rate_limit_len(intel_dp->sink_rates,
+								   intel_dp->num_sink_rates,
+								   540000);
+
 	intel_edp_set_data_override_rates(intel_dp);
 }
 
diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index e63c7f075f54c..9db924ff7c53e 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1228,6 +1228,7 @@
 # define DP_UHBR10                             (1 << 0)
 # define DP_UHBR20                             (1 << 1)
 # define DP_UHBR13_5                           (1 << 2)
+# define DP_MAX_128B132B_SUPPORTED_RATES	3
 
 #define DP_128B132B_TRAINING_AUX_RD_INTERVAL                    0x2216 /* 2.0 */
 # define DP_128B132B_TRAINING_AUX_RD_INTERVAL_1MS_UNIT          (1 << 7)
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 5b05a7fbe174a..d7f4c6f2ba4c7 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -32,6 +32,8 @@
 struct drm_device;
 struct drm_dp_aux;
 struct drm_panel;
+struct drm_dp_tunnel;
+struct drm_dp_desc;
 
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
@@ -700,6 +702,15 @@ static inline int drm_dp_dpcd_write_byte(struct drm_dp_aux *aux,
 int drm_dp_read_dpcd_caps(struct drm_dp_aux *aux,
 			  u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 
+int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
+				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
+				const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],
+				const struct drm_dp_desc *desc,
+				const struct drm_dp_tunnel *tunnel,
+				int sink_rates[DP_MAX_SUPPORTED_RATES]);
+int drm_dp_read_edp_sink_rates(struct drm_dp_aux *aux, u8 edp_dpcd_rev,
+			       int sink_rates[DP_MAX_SUPPORTED_RATES]);
+
 int drm_dp_dpcd_read_link_status(struct drm_dp_aux *aux,
 				 u8 status[DP_LINK_STATUS_SIZE]);
 

-- 
2.43.0

