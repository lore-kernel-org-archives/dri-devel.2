Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095D606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JR950Io7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37E7A10FAE6;
	Wed, 18 Nov 2026 10:37:18 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E19EC10FAE5;
 Wed, 18 Nov 2026 10:37:11 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B63FA1A16D0;
 Wed, 18 Nov 2026 10:37:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8C0955FE9B;
 Wed, 18 Nov 2026 10:37:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A08BE11BC10FF; Wed, 18 Nov 2026 11:37:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794998228; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=mtYzpJ24rhMVmapecTwlgUQZoZ29m3Kp8hKu07EX+/M=;
 b=JR950Io72DZ0wCXBTYbH/WRCce/IgwxCsADnVItmHWPOGMOX4Xfre+WsJ9EK0TU2shoOyr
 9+RPQjn0tfqo+Y7tymFUZi2GJpZN11W24raXFOTGnmH0iA1vHoejbi9ucbbuNmds545Nyx
 3CY4pJMIlKJgRb/H/5Gj5DM2ImJKK4HTquOkYJ9QGWPh46ON1k7HqzBoXPveh53aJVlp88
 LI2Q1WMW6lGdBXGNvecVCSYLRolqUt2z53OUHShQfMXc7/hqDeDeQ3kbjiptCICHGpMm44
 OzoCj4H9+1bEcqp5o6KovapUWG4EG84xwtQmtQrCI2D4ibz4fcs4NclUVEc+Hw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 18 Nov 2026 11:36:34 +0100
Subject: [PATCH 7/8] drm/dp: Move eDP sink link rates reading helper out of
 i915
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-feat_move_i915_helper-v1-7-652177f3107a@bootlin.com>
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

Move the eDP sink link rates reading function out of the i915 driver
into the generic DRM helpers. The helper reads the rates from the DPCD
DP_SUPPORTED_LINK_RATES registers, available on eDP 1.4 and later
sinks.

No functional change intended.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 58 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 51 +++++------------------------
 include/drm/display/drm_dp_helper.h     |  2 ++
 3 files changed, 68 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 30935d3ae0055..fc3d4db1c7639 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4916,6 +4916,32 @@ int drm_dp_max_dprx_data_rate(int max_link_rate, int max_lanes)
 }
 EXPORT_SYMBOL(drm_dp_max_dprx_data_rate);
 
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
 static int drm_dprx_max_rate(const struct drm_dp_tunnel *tunnel,
 			     const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 {
@@ -5086,3 +5112,35 @@ int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
 	return i;
 }
 EXPORT_SYMBOL_GPL(drm_dp_read_dpcd_sink_rates);
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
index 8fee2d195c944..225f6ed8c32d8 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4815,56 +4815,21 @@ static void
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
+	num_sink_rates = drm_dp_read_edp_sink_rates(&intel_dp->aux,
+						    intel_dp->edp_dpcd[0],
+						    intel_dp->sink_rates);
+	if (num_sink_rates < 0)
+		num_sink_rates = 0;
 
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
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index dd4c4a6ff17d1..81fe87ad47050 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -709,6 +709,8 @@ int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
 				const struct drm_dp_desc *desc,
 				const struct drm_dp_tunnel *tunnel,
 				int sink_rates[DP_MAX_SUPPORTED_RATES]);
+int drm_dp_read_edp_sink_rates(struct drm_dp_aux *aux, u8 edp_dpcd_rev,
+			       int sink_rates[DP_MAX_SUPPORTED_RATES]);
 
 int drm_dp_dpcd_read_link_status(struct drm_dp_aux *aux,
 				 u8 status[DP_LINK_STATUS_SIZE]);

-- 
2.43.0

