Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDAF606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XMzb6KrT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F31010FC81;
	Wed, 25 Nov 2026 14:02:30 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29DE310FCB8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:02:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id DA52E4E4177F;
 Wed, 25 Nov 2026 14:02:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AF38A60480;
 Wed, 25 Nov 2026 14:02:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BB60B11E69662; Wed, 25 Nov 2026 15:02:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795615332; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=r5vFQTalA5nmOSZ8PtDn3EC1/PGLeVCX5Rep/ovoFr0=;
 b=XMzb6KrTZBrf6dPxbfhKNTWowugMz2ERvqti+4VPAXkvGKxiYV6U+h3gWyOotsf6CxhW8p
 milR0an3dj8QGizbuVHnXY5k2BxecaY4twx4CBl/7+Vd0aUHMrqk8t/E8nLhM72+6f17LD
 2sQ4kjQUQ0Hf1yumtNr10SBcXyGRdpwo5nPQIhYtxcxXx4J1jX9V/5gCR2tVg4sfuxzRVj
 rUg4m5y2pQ3Ba082STLqaLM+45sopTXbWuROA6JeIJ3ahesuxbxNiqAaFWd/3y8uRJYJOb
 S3ZQaX7FgnDAdVCEOi0dA1iZbXX71qyt8APc7ByZKIL9TmgQcIOyYt5UV6LaUg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 25 Nov 2026 15:01:14 +0100
Subject: [PATCH v2 10/10] drm: Move DSC capability reading helper out of i915
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-feat_move_i915_helper-v2-10-aa04d39bc415@bootlin.com>
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

Move the DSC capability reading helper out of the i915 driver into the
generic DRM helpers.

No functional change intended.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Fix a kdoc typo
---
 drivers/gpu/drm/display/drm_dp_helper.c | 30 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 27 ++++-----------------------
 include/drm/display/drm_dp_helper.h     |  2 ++
 3 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 9938f3be8836a..599918353d34d 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -5144,3 +5144,33 @@ int drm_dp_read_edp_sink_rates(struct drm_dp_aux *aux, u8 edp_dpcd_rev,
 	return num_sink_rates;
 }
 EXPORT_SYMBOL_GPL(drm_dp_read_edp_sink_rates);
+
+/**
+ * drm_dp_dsc_read_dpcd() - read the DSC capabilities from the DPCD
+ * @aux: DisplayPort AUX channel
+ * @dsc_dpcd: Buffer to store the DSC capabilities read from the DPCD
+ *
+ * Attempts to read the sink DSC capabilities from the DPCD of @aux.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int drm_dp_dsc_read_dpcd(struct drm_dp_aux *aux,
+			 u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE])
+{
+	int ret;
+
+	ret = drm_dp_dpcd_read_data(aux, DP_DSC_SUPPORT, dsc_dpcd,
+				    DP_DSC_RECEIVER_CAP_SIZE);
+	if (ret < 0) {
+		drm_dbg_kms(aux->drm_dev,
+			    "Could not read DSC DPCD register 0x%x Error: %pe\n",
+			    DP_DSC_SUPPORT, ERR_PTR(ret));
+		return ret;
+	}
+
+	drm_dbg_kms(aux->drm_dev, "DSC DPCD: %*ph\n",
+		    DP_DSC_RECEIVER_CAP_SIZE,
+		    dsc_dpcd);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drm_dp_dsc_read_dpcd);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index db72e7d152689..61f0b8a2b7916 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4572,25 +4572,6 @@ static bool intel_dp_get_sst_split_sdp_status(u8 dprx)
 	return dprx & DP_SST_SPLIT_SDP_CAP;
 }
 
-static int intel_dp_read_dsc_dpcd(struct drm_dp_aux *aux,
-				  u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE])
-{
-	int ret;
-
-	ret = drm_dp_dpcd_read_data(aux, DP_DSC_SUPPORT, dsc_dpcd, DP_DSC_RECEIVER_CAP_SIZE);
-	if (ret < 0) {
-		drm_dbg_kms(aux->drm_dev,
-			    "Could not read DSC DPCD register 0x%x Error: %pe\n",
-			    DP_DSC_SUPPORT, ERR_PTR(ret));
-		return ret;
-	}
-
-	drm_dbg_kms(aux->drm_dev, "DSC DPCD: %*ph\n",
-		    DP_DSC_RECEIVER_CAP_SIZE,
-		    dsc_dpcd);
-	return 0;
-}
-
 static void init_dsc_overall_throughput_limits(struct intel_connector *connector, bool is_branch)
 {
 	u8 branch_caps[DP_DSC_BRANCH_CAP_SIZE];
@@ -4641,8 +4622,8 @@ void intel_dp_get_dsc_sink_cap(u8 dpcd_rev,
 	if (dpcd_rev < DP_DPCD_REV_14)
 		return;
 
-	ret = intel_dp_read_dsc_dpcd(connector->dp.dsc_decompression_aux,
-				     connector->dp.dsc_dpcd);
+	ret = drm_dp_dsc_read_dpcd(connector->dp.dsc_decompression_aux,
+				   connector->dp.dsc_dpcd);
 	if (ret < 0)
 		return;
 
@@ -4676,8 +4657,8 @@ static void intel_edp_get_dsc_sink_cap(u8 edp_dpcd_rev, struct intel_connector *
 	if (edp_dpcd_rev < DP_EDP_14)
 		return;
 
-	if (intel_dp_read_dsc_dpcd(connector->dp.dsc_decompression_aux,
-				   connector->dp.dsc_dpcd) < 0)
+	if (drm_dp_dsc_read_dpcd(connector->dp.dsc_decompression_aux,
+				 connector->dp.dsc_dpcd) < 0)
 		return;
 
 	if (connector->dp.dsc_dpcd[0] & DP_DSC_DECOMPRESSION_IS_SUPPORTED)
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 81fe87ad47050..4e2762d493bf3 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -216,6 +216,8 @@ drm_dp_is_branch(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 }
 
 /* DP/eDP DSC support */
+int drm_dp_dsc_read_dpcd(struct drm_dp_aux *aux,
+			 u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE]);
 u8 drm_dp_dsc_sink_bpp_incr(const u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE]);
 u32 drm_dp_dsc_slice_count_to_mask(int slice_count);
 u32 drm_dp_dsc_sink_slice_count_mask(const u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE],

-- 
2.43.0

