Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4A606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qotmU3ei
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49D710FCBF;
	Wed, 25 Nov 2026 14:02:20 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99C210FC91;
 Wed, 25 Nov 2026 14:01:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 53646C2B9C1;
 Wed, 25 Nov 2026 14:02:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6EC1660480;
 Wed, 25 Nov 2026 14:01:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9212B11E6938B; Wed, 25 Nov 2026 15:01:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795615315; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=XMU2yRVG6Y3zFaEsDumfUeq0JoGBtxplJeIUOq/GC2s=;
 b=qotmU3eiLmI/kWBlFIyS9dexmvCJX77fmeClknlXtd8jaF3Q4hqBSCnNmg2bFyBhQasYby
 Haoau2aFrNvk58VL/tn2faGhNJ4VRRUHxQs4OR3UlGYJSuuc+/qiL33GAyLJ8kfqm+kML6
 SMcv/KXaZhHbK8RarxBUx/YU4rfhX7eXUxZPv4MJqn4URqlZvlcfW51jCeVpHgysws7PyS
 WYCVjIeRQa5zsvWiZCcF3kse04+11lrG9gSwB712ywG9asfPoeOiKIw+8f6lD7+UhCYwyK
 x4uWe4eVdMcOc2rZB3zm2e/DEqHSqfpqknp75XTf6psvI7LWobZ7g//jj2xAoA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 25 Nov 2026 15:01:11 +0100
Subject: [PATCH v2 07/10] drm/dp: Add
 drm_dp_read_dpcd_supported_link_rates() helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-feat_move_i915_helper-v2-7-aa04d39bc415@bootlin.com>
References: <20261125-feat_move_i915_helper-v2-0-aa04d39bc415@bootlin.com>
In-Reply-To: <20261125-feat_move_i915_helper-v2-0-aa04d39bc415@bootlin.com>
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

Add a new drm_dp_read_dpcd_supported_link_rates() helper which reads
the DPCD DP_SUPPORTED_LINK_RATES registers and converts their values
into link rates. Use it from the i915 eDP sink rates handling.

The custom Intel eDP HBR2 limitation quirk handling stays in the driver.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v2:
- Fix a small possible issue (sashiko) in case of an intel quirk
  and supported link rates exceeding 540000 kHz
- Split the patch in 3 for readability
---
 drivers/gpu/drm/display/drm_dp_helper.c | 27 +++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 72 +++++++++++++--------------------
 include/drm/display/drm_dp_helper.h     |  3 ++
 3 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 30935d3ae0055..6d684b6b94d0a 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4916,6 +4916,33 @@ int drm_dp_max_dprx_data_rate(int max_link_rate, int max_lanes)
 }
 EXPORT_SYMBOL(drm_dp_max_dprx_data_rate);
 
+/**
+ * drm_dp_read_dpcd_supported_link_rates() - read DPCD supported link rates
+ * @aux: DisplayPort AUX channel
+ * @link_rates: Buffer to store the resulting link rates supported
+ *
+ * Attempts to read the DPCD supported link rates for @aux.
+ *
+ * Returns: The number of supported link rates, negative error code otherwise.
+ */
+int drm_dp_read_dpcd_supported_link_rates(struct drm_dp_aux *aux,
+					  int link_rates[DP_MAX_SUPPORTED_RATES])
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
+EXPORT_SYMBOL_GPL(drm_dp_read_dpcd_supported_link_rates);
+
 static int drm_dprx_max_rate(const struct drm_dp_tunnel *tunnel,
 			     const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 {
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 8fee2d195c944..798274a7b70ea 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4811,6 +4811,24 @@ intel_edp_set_data_override_rates(struct intel_dp *intel_dp)
 	intel_dp->num_sink_rates = count;
 }
 
+/*
+ * Some platforms cannot reliably drive HBR3 rates due to PHY limitations,
+ * even if the sink advertises support. Reject any sink rates above HBR2 on
+ * the known machines for stable output.
+ */
+static void intel_edp_limit_sink_rates_hbr2(struct intel_dp *intel_dp)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	if (!intel_dp->num_sink_rates ||
+	    !intel_has_quirk(display, QUIRK_EDP_LIMIT_RATE_HBR2))
+		return;
+
+	intel_dp->num_sink_rates = intel_dp_rate_limit_len(intel_dp->sink_rates,
+							   intel_dp->num_sink_rates,
+							   540000);
+}
+
 static void
 intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 {
@@ -4819,65 +4837,31 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 	intel_dp->num_sink_rates = 0;
 
 	if (intel_dp->edp_dpcd[0] >= DP_EDP_14) {
-		__le16 sink_rates[DP_MAX_SUPPORTED_RATES];
 		int ret;
-		int i;
 
-		ret = drm_dp_dpcd_read_data(&intel_dp->aux,
-					    DP_SUPPORTED_LINK_RATES,
-					    sink_rates, sizeof(sink_rates));
+		ret = drm_dp_read_dpcd_supported_link_rates(&intel_dp->aux,
+							    intel_dp->sink_rates);
 		if (ret < 0) {
 			drm_dbg_kms(display->drm,
 				    "Unable to read eDP supported link rates, using default rates\n");
-			memset(sink_rates, 0, sizeof(sink_rates));
+			ret = 0;
 		}
 
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
+		intel_dp->num_sink_rates = ret;
 	}
 
+	intel_edp_limit_sink_rates_hbr2(intel_dp);
+
 	/*
 	 * Use DP_LINK_RATE_SET if DP_SUPPORTED_LINK_RATES are available,
 	 * default to DP_MAX_LINK_RATE and DP_LINK_BW_SET otherwise.
 	 */
-	if (intel_dp->num_sink_rates)
+	if (intel_dp->num_sink_rates) {
 		intel_dp->use_rate_select = true;
-	else
+	} else {
 		intel_dp_set_sink_rates(intel_dp);
-
-	/*
-	 * Some platforms cannot reliably drive HBR3 rates due to PHY limitations,
-	 * even if the sink advertises support. Reject any sink rates above HBR2 on
-	 * the known machines for stable output.
-	 */
-	if (intel_dp->num_sink_rates && intel_has_quirk(display, QUIRK_EDP_LIMIT_RATE_HBR2))
-		intel_dp->num_sink_rates = intel_dp_rate_limit_len(intel_dp->sink_rates,
-								   intel_dp->num_sink_rates,
-								   540000);
+		intel_edp_limit_sink_rates_hbr2(intel_dp);
+	}
 
 	intel_edp_set_data_override_rates(intel_dp);
 }
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index dd4c4a6ff17d1..2e018f1e59363 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -703,6 +703,9 @@ static inline int drm_dp_dpcd_write_byte(struct drm_dp_aux *aux,
 int drm_dp_read_dpcd_caps(struct drm_dp_aux *aux,
 			  u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 
+int drm_dp_read_dpcd_supported_link_rates(struct drm_dp_aux *aux,
+					  int link_rates[DP_MAX_SUPPORTED_RATES]);
+
 int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
 				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 				const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],

-- 
2.43.0

