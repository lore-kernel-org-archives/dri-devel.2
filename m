Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E249CCC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375BF10F901;
	Tue, 13 Oct 2026 17:48:29 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 728CA10F901
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:48:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 422A91A1216
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:48:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F351E60362
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:48:16 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
 id 38A4311D71891; Tue, 13 Oct 2026 19:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791913696; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=kdjJLp46k2BPwmLC33J0kywCk31frcLWWFqL0o2dTNE=;
 b=oUbwnfieZ47jQq2rDXsgK+zsykUgpbLp+2Cq1UiJMz4g9gZaW6xYB06a7tjMI5Ibn0Nv6F
 L4i4emrMY4SOUFEa1mJ0I33w50EMqa7UT61IYBSe1Eef+K62TM1KWsYOTYZljddASTTGbs
 YkxmUaDLBdqr8WyOoE0a5ssAnfcTnv7rHjyS6mVd3bi/XHW81A9NFp+VjLs9/qpa04pQsj
 /n0TZPWr5QSHTW1++LDfoupF0UAleGz9w3HA4umAw9LH/sNF1i4fP9+brK1IH4MRWx/pbB
 Nxexu6VONikba16S/WoXZKGIVGPgXw397M3ILEM6WSUcg8uOsy4LmwUHlLRsKg==
Authentication-Results: mail.galae.net;
	none
Received: from mail.galae.net ([172.22.1.253]) by 9e7fea892943 with LMTP
 id 0NzwG6r4zGr4hhEAtaWaaQ (envelope-from <kory.maincent@bootlin.com>)
 for <kory.maincent@bootlin.com>; Mon, 12 Oct 2026 17:11:38 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9240B11D7061E; 
 Mon, 12 Oct 2026 17:11:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791817892; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=kdjJLp46k2BPwmLC33J0kywCk31frcLWWFqL0o2dTNE=;
 b=PTL2csR3qH8J65pkB83hcObsePBvtr4A0P5dmFm/WDHewJNNaoHtmkJ04jKf8Pu3ebnefv
 xMmVTyHrgNGrjulyPTO6ZQTqQBsuPwBznR311eDk8pC8rTYtzjNKpDCaUEujVUPwG/wjHn
 Mq2cjH62ZgdDSoAFiIMvd7zL/pY/Qi3WjsvORV8hMRAfPHaqtR5VR9PeaxOJteM+DKl050
 03lV73RycMzB8Je/mZLmhIkmokTQ4JbbTgwhpUBWFVa9uUMVBSaV2RROWj2RhH7vG+Ys5e
 1BHWIcY42v5hJS7+cusCBzUFN13oezlGL+hbPbGeuxeAeOWYCvFlhE5CC1eMww==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 12 Oct 2026 17:10:56 +0200
Subject: [PATCH RFC v3 1/8] drm: Move sink link rates reading helpers out
 of i915
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-feat_link_cap-v3-1-7517f4aba0f3@bootlin.com>
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
In-Reply-To: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
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
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 38A4311D71891
X-Spamd-Result: default: False [2.50 / 30.00]; SUSPICIOUS_RECIPS(1.50)[];
 DATE_IN_PAST(1.00)[26]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-0.00)[22.08%];
 BCC(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FORWARDED(0.00)[kory.maincent@bootlin.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[35]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,intel.com,ursulin.net,linaro.org,ideasonboard.com,kwiboo.se,bootlin.com,pengutronix.de,collabora.com];
 MID_RHS_MATCH_FROM(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[kory.maincent@bootlin.com];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,bootlin.com:mid,bootlin.com:email];
 MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
 RECEIVED_HELO_LOCALHOST(0.00)[]; NEURAL_HAM(-0.00)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]
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

In preparation for adding generic DRM properties to report source and
sink capabilities, move the sink link rates reading functions out of
the i915 driver into the generic DRM helpers. These functions provide
everything needed to properly extract link rate capabilities from the
DPCD.

Keep the Intel-specific quirk handling in the driver.

No functional change intended.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Change in v3:
- New patch
---
 drivers/gpu/drm/display/drm_dp_helper.c | 237 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 169 ++++++-----------------
 include/drm/display/drm_dp.h            |   1 +
 include/drm/display/drm_dp_helper.h     |  11 ++
 4 files changed, 293 insertions(+), 125 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e623ccb4c1d8a..8ef096a0138e4 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4912,3 +4912,240 @@ int drm_dp_max_dprx_data_rate(int max_link_rate, int max_lanes)
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
+	if (drm_dp_lttpr_count(lttpr_common_caps)) {
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
+ * the capabilities of the LTTPRs if any is present. The rates are stored in
+ * @sink_rates in ascending order.
+ *
+ * The DPCD receiver capabilities, the LTTPR common capabilities and the sink
+ * descriptor are passed by the caller instead of being read from the DPCD.
+ * Drivers which already read them, like i915, can pass them to avoid
+ * duplicate DPCD reads.
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
+	max_rate = drm_dp_bw_code_to_link_rate(dpcd[DP_MAX_LINK_RATE]);
+	if (lttpr_common_caps)
+		max_lttpr_rate = drm_dp_lttpr_max_link_rate(lttpr_common_caps);
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
+ * the DP_SUPPORTED_LINK_RATES register, negative error code otherwise.
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
index 0cd5e6b5034cf..da73ad11e9cac 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -191,102 +191,47 @@ static void intel_dp_set_default_sink_rates(struct intel_dp *intel_dp)
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
+	int max_rate;
+	int i, num;
 
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
 
 	/*
-	 * The following register must be read unconditionally for the later
-	 * DP tunnel 128b132b detection to work, see DP Standard v2.1 5.14.3 .
+	 * Don't limit the rates of sinks with the 3.24 Gbps DPCD quirk
+	 * (needed, e.g., for Apple MBP 2017, 15 inch eDP Retina panels),
+	 * they support rates not advertised by DP_MAX_LINK_RATE.
 	 */
-	drm_dp_dpcd_read_byte(&intel_dp->aux, DP_128B132B_SUPPORTED_LINK_RATES, &uhbr_rates);
+	if (!drm_dp_has_quirk(&intel_dp->desc, DP_DPCD_QUIRK_CAN_DO_MAX_LINK_RATE_3_24_GBPS)) {
+		/*
+		 * Limit the 8b/10b rates to the maximum rate the source can
+		 * drive. The 128b/132b rates are all above the maximum 8b/10b
+		 * rate and are not limited by the source's DP_MAX_LINK_RATE.
+		 */
+		max_rate = max_dprx_rate(intel_dp);
+		num = 0;
+		for (i = 0; i < num_sink_rates; i++) {
+			if (!drm_dp_is_uhbr_rate(intel_dp->sink_rates[i]) &&
+			    intel_dp->sink_rates[i] > max_rate)
+				continue;
 
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
+			intel_dp->sink_rates[num++] = intel_dp->sink_rates[i];
 		}
 
-		if (uhbr_rates & DP_UHBR10)
-			intel_dp->sink_rates[i++] = 1000000;
-		if (uhbr_rates & DP_UHBR13_5)
-			intel_dp->sink_rates[i++] = 1350000;
-		if (uhbr_rates & DP_UHBR20)
-			intel_dp->sink_rates[i++] = 2000000;
+		num_sink_rates = num;
 	}
 
-	intel_dp->num_sink_rates = i;
+	intel_dp->num_sink_rates = num_sink_rates;
 }
 
 static void intel_dp_set_sink_rates(struct intel_dp *intel_dp)
@@ -4722,50 +4667,24 @@ static void
 intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
+	int num_sink_rates;
 
-	intel_dp->num_sink_rates = 0;
-
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
+	num_sink_rates = drm_dp_read_edp_sink_rates(&intel_dp->aux,
+						    intel_dp->edp_dpcd[0],
+						    intel_dp->sink_rates);
+	if (num_sink_rates < 0)
+		num_sink_rates = 0;
 
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
+	/*
+	 * Some platforms cannot reliably drive HBR3 rates due to PHY limitations,
+	 * even if the sink advertises support. Reject any sink rates above HBR2 on
+	 * the known machines for stable output.
+	 */
+	if (num_sink_rates && intel_has_quirk(display, QUIRK_EDP_LIMIT_RATE_HBR2))
+		num_sink_rates = intel_dp_rate_limit_len(intel_dp->sink_rates,
+							 num_sink_rates, 540000);
 
-			intel_dp->sink_rates[i] = rate;
-		}
-		intel_dp->num_sink_rates = i;
-	}
+	intel_dp->num_sink_rates = num_sink_rates;
 
 	/*
 	 * Use DP_LINK_RATE_SET if DP_SUPPORTED_LINK_RATES are available,
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

