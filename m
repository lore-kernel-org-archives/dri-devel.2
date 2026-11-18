Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4E606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=owaRB0KV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4310D10FAE0;
	Wed, 18 Nov 2026 10:37:17 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C11F10FADB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:37:02 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 16FA51A16D1;
 Wed, 18 Nov 2026 10:37:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E0EBE5FE9B;
 Wed, 18 Nov 2026 10:37:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2B6E011BC1100; Wed, 18 Nov 2026 11:36:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794998218; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=MrMW3cGtg/ftU5RE/X9Qfx6ZTl0a0ljqmUg5Sq83jFI=;
 b=owaRB0KVoEV1IUBg7i5gzouDGkHCI2z09YYLtHm5gwsq6ehJTKVHsRotLIDHXiXKX5fUxM
 FtWD2nEaPK8GtN8XHeXbYSqzGAgV/wSCV2JtkslvRUa20pE1jMd7SDEZiN1Sb/Y5r74ajG
 U4M6MXORQY4FVlxP1YCocPm1/dYPD1vhr3Jt83i2H672QNUgWMzGcEZTMrwcn05gdanmfx
 1guR0W+1PwzRXMXndIyFeZjT2R7U0nYzW6BYmwTdVkuOxK0kQyF1zEZMs/Ea8CBp/o1SmB
 brZoGE3X6tZDqlF3nmHkZRRQbt0blRO0KiLvpc8eW/3JkwSSCkYQP5W2Na5asg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 18 Nov 2026 11:36:31 +0100
Subject: [PATCH 4/8] drm/dp: Move supported 128b/132b link rates helper out
 of i915
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-feat_move_i915_helper-v1-4-652177f3107a@bootlin.com>
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

Move the drm_dp_get_128b132b_link_rates() helper from the i915 driver
into the generic DRM helpers. It limits the UHBR rate mask by the
capabilities of the DP tunnel and of the LTTPRs, if any is present,
then expands the remaining rates in ascending order.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 52 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 25 +++-------------
 include/drm/display/drm_dp.h            |  2 ++
 include/drm/display/drm_dp_helper.h     |  4 +++
 4 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index c92d89ecf96e4..a0afb5eff5bb4 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4949,3 +4949,55 @@ bool drm_dprx_supports_128b132b(const struct drm_dp_tunnel *tunnel,
 		return drm_dp_128b132b_supported(dpcd);
 }
 EXPORT_SYMBOL_GPL(drm_dprx_supports_128b132b);
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
+int
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
+		if (lttpr_common_caps[0] >= DP_LTTPR_REV_SUP_128B132B &&
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
+EXPORT_SYMBOL_GPL(drm_dp_get_128b132b_link_rates);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 2ba89fee097d6..7ef06e68878d4 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -233,27 +233,10 @@ static void intel_dp_set_dpcd_sink_rates(struct intel_dp *intel_dp)
 
 		uhbr_rates = drm_dprx_128b132b_link_rates(intel_dp->tunnel, uhbr_rates);
 
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
+		i += drm_dp_get_128b132b_link_rates(intel_dp->lttpr_common_caps,
+						    intel_dp->tunnel,
+						    uhbr_rates,
+						    &intel_dp->sink_rates[i]);
 	}
 
 	intel_dp->num_sink_rates = i;
diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index e63c7f075f54c..7a4849695444c 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1228,6 +1228,7 @@
 # define DP_UHBR10                             (1 << 0)
 # define DP_UHBR20                             (1 << 1)
 # define DP_UHBR13_5                           (1 << 2)
+# define DP_MAX_128B132B_SUPPORTED_RATES	3
 
 #define DP_128B132B_TRAINING_AUX_RD_INTERVAL                    0x2216 /* 2.0 */
 # define DP_128B132B_TRAINING_AUX_RD_INTERVAL_1MS_UNIT          (1 << 7)
@@ -1528,6 +1529,7 @@
 
 /* LTTPR: Link Training (LT)-tunable PHY Repeaters */
 #define DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV 0xf0000 /* 1.3 */
+#define  DP_LTTPR_REV_SUP_128B132B			    0x20
 #define DP_MAX_LINK_RATE_PHY_REPEATER			    0xf0001 /* 1.4a */
 #define DP_PHY_REPEATER_CNT				    0xf0002 /* 1.3 */
 #define DP_PHY_REPEATER_MODE				    0xf0003 /* 1.3 */
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index b67bb06f6e07e..a8c382a2c916f 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -708,6 +708,10 @@ u8 drm_dprx_128b132b_link_rates(const struct drm_dp_tunnel *tunnel,
 				u8 uhbr_rates);
 bool drm_dprx_supports_128b132b(const struct drm_dp_tunnel *tunnel,
 				const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
+int drm_dp_get_128b132b_link_rates(const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],
+				   const struct drm_dp_tunnel *tunnel,
+				   u8 uhbr_rates,
+				   int link_rates[DP_MAX_128B132B_SUPPORTED_RATES]);
 
 int drm_dp_dpcd_read_link_status(struct drm_dp_aux *aux,
 				 u8 status[DP_LINK_STATUS_SIZE]);

-- 
2.43.0

