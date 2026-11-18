Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F9606A332
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Oumr+jvv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18CEB10FAE4;
	Wed, 18 Nov 2026 10:37:12 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE6B10FAB5;
 Wed, 18 Nov 2026 10:37:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 10AFA1A16E2;
 Wed, 18 Nov 2026 10:37:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DA0ED5FE9B;
 Wed, 18 Nov 2026 10:37:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5876F11BC1111; Wed, 18 Nov 2026 11:36:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794998222; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nKN7YIlJlyocFcQ8ynf0HacwW5lSpAWTTJ+e4/eR4Sk=;
 b=Oumr+jvvR46TJWsLaP31LadsrFg5lQSpE4D2RYWXWYB9pnGvPUTyV6sXLyOjjmWKsa1MXE
 ZNJRVkIkCfE+QmGWtRr4QgwCffmV9P2UB54OwVlTQavr4lTxwK9ej/u/OODg8s6Ho383wa
 sh9XuikNcUbQeAAi+0XshAcmQeqSr0MPlp8wMsbCswE3XomwxM24EeDhxQVRNOeROw52l4
 eR0vsa0LrCK2/T4JWidxtFFEp4JhpSGCalpQ8obHQLgT2R95Ej2nrYqh3CWroaOeDAPgMB
 Oa3OJxEn4a4ZnR8ZDHthN4RYlutnNoCGpIeN06tlcyVHhUXhDlO6Iz0yxKkv/g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 18 Nov 2026 11:36:32 +0100
Subject: [PATCH 5/8] drm/dp: Move DP sink link rates reading helper out of i915
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-feat_move_i915_helper-v1-5-652177f3107a@bootlin.com>
References: <20261118-feat_move_i915_helper-v1-0-652177f3107a@bootlin.com>
In-Reply-To: <20261118-feat_move_i915_helper-v1-0-652177f3107a@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 Manasi Navare <navaremanasi@google.com>, 
 Drew Davenport <ddavenport@google.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Kory Maincent <kory.maincent@bootlin.com>
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

Move the DP sink link rates reading function out of the i915 driver
into the generic DRM helpers. This function provides everything needed
to properly extract link rate capabilities from the DPCD, limited by
the capabilities of the LTTPRs or the DP tunnel when present.

No functional change intended.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 89 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 82 ++++++++----------------------
 include/drm/display/drm_dp.h            |  1 +
 include/drm/display/drm_dp_helper.h     |  8 +++
 4 files changed, 118 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index a0afb5eff5bb4..e06264c52bf5e 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -5001,3 +5001,92 @@ drm_dp_get_128b132b_link_rates(const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SI
 	return i;
 }
 EXPORT_SYMBOL_GPL(drm_dp_get_128b132b_link_rates);
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
+	max_rate = drm_dprx_max_rate(tunnel, dpcd);
+	if (lttpr_common_caps && lttpr_common_caps[0] >= DP_LTTPR_REV_SUP_8B10B)
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
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 7ef06e68878d4..8fee2d195c944 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -176,70 +176,18 @@ static void intel_dp_set_default_sink_rates(struct intel_dp *intel_dp)
 /* update sink rates from dpcd */
 static void intel_dp_set_dpcd_sink_rates(struct intel_dp *intel_dp)
 {
-	struct intel_display *display = to_intel_display(intel_dp);
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
-	max_rate = drm_dprx_max_rate(intel_dp->tunnel, intel_dp->dpcd);
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
-	max_lttpr_rate = drm_dp_lttpr_max_link_rate(intel_dp->lttpr_common_caps);
-	if (max_lttpr_rate)
-		max_rate = min(max_rate, max_lttpr_rate);
+	int num_sink_rates;
 
-	for (i = 0; i < ARRAY_SIZE(dp_rates); i++) {
-		if (dp_rates[i] > max_rate)
-			break;
-		intel_dp->sink_rates[i] = dp_rates[i];
-	}
-
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
-	if (drm_dprx_supports_128b132b(intel_dp->tunnel, intel_dp->dpcd)) {
-		BUILD_BUG_ON(ARRAY_SIZE(intel_dp->sink_rates) < ARRAY_SIZE(dp_rates) + 3);
-
-		uhbr_rates = drm_dprx_128b132b_link_rates(intel_dp->tunnel, uhbr_rates);
-
-		i += drm_dp_get_128b132b_link_rates(intel_dp->lttpr_common_caps,
-						    intel_dp->tunnel,
-						    uhbr_rates,
-						    &intel_dp->sink_rates[i]);
-	}
+	num_sink_rates = drm_dp_read_dpcd_sink_rates(&intel_dp->aux,
+						     intel_dp->dpcd,
+						     intel_dp->lttpr_common_caps,
+						     &intel_dp->desc,
+						     intel_dp->tunnel,
+						     intel_dp->sink_rates);
+	if (num_sink_rates < 0)
+		num_sink_rates = 0;
 
-	intel_dp->num_sink_rates = i;
+	intel_dp->num_sink_rates = num_sink_rates;
 }
 
 static void intel_dp_set_sink_rates(struct intel_dp *intel_dp)
@@ -4921,6 +4869,16 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
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
index 7a4849695444c..6eacaef40eb0d 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1529,6 +1529,7 @@
 
 /* LTTPR: Link Training (LT)-tunable PHY Repeaters */
 #define DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV 0xf0000 /* 1.3 */
+#define  DP_LTTPR_REV_SUP_8B10B				    0x14
 #define  DP_LTTPR_REV_SUP_128B132B			    0x20
 #define DP_MAX_LINK_RATE_PHY_REPEATER			    0xf0001 /* 1.4a */
 #define DP_PHY_REPEATER_CNT				    0xf0002 /* 1.3 */
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index a8c382a2c916f..5c4cb57f0fc5e 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -34,6 +34,7 @@ struct drm_dp_aux;
 struct drm_panel;
 struct drm_printer;
 struct drm_dp_tunnel;
+struct drm_dp_desc;
 
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
@@ -713,6 +714,13 @@ int drm_dp_get_128b132b_link_rates(const u8 lttpr_common_caps[DP_LTTPR_COMMON_CA
 				   u8 uhbr_rates,
 				   int link_rates[DP_MAX_128B132B_SUPPORTED_RATES]);
 
+int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
+				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
+				const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],
+				const struct drm_dp_desc *desc,
+				const struct drm_dp_tunnel *tunnel,
+				int sink_rates[DP_MAX_SUPPORTED_RATES]);
+
 int drm_dp_dpcd_read_link_status(struct drm_dp_aux *aux,
 				 u8 status[DP_LINK_STATUS_SIZE]);
 

-- 
2.43.0

