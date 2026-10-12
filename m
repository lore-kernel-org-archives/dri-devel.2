Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5899CCA9EDF
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A551C10F1BA;
	Mon, 12 Oct 2026 15:11:54 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B0910E5FD;
 Mon, 12 Oct 2026 15:11:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 83C8D1A11E9;
 Mon, 12 Oct 2026 15:11:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4EB3B601A6;
 Mon, 12 Oct 2026 15:11:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A117911D7012D; 
 Mon, 12 Oct 2026 17:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791817900; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Bk2x82OfVzEX8vQFg5r5k8G6Ahg8Yo7o0Nce1j8gVcc=;
 b=MSu2ML6c1w653SFQ6BnfRaoqijHfRCycjnFvgpioFNeDI5rHTcfGoA1H3VQFtOqqy2iJCI
 mkTya1N4+QcXVSQ46ka2NJp7OyGdIHni8M1wW8JHNGcpYhzqLd6ew6ymAqwuwtPBT7Sn9o
 BGd7kQUUuRQGr2wm+rlRNmSVcnChy4LodeQQq7IkFdejdSPlijT7EexmD4UOz27rcBQAI8
 fke1xnFH0582bVkdNCoq79f6OKUFndSZuGA6mNrTN3Fj/sPryTktSnfSPYSbKaUxl2TZ+N
 BnsQbVWO8D5kjgVQiid31iX9sA7bXPISW++lraYHUlgzyqqDzLD5w/kA9bYvmA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 12 Oct 2026 17:10:57 +0200
Subject: [PATCH RFC v3 2/8] drm: Move DSC capability reading helper out of i915
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-feat_link_cap-v3-2-7517f4aba0f3@bootlin.com>
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
sink capabilities, move the DSC capability reading helper out of the
i915 driver into the generic DRM helpers.

No functional change intended.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Change in v3:
- New patch
---
 drivers/gpu/drm/display/drm_dp_helper.c | 30 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 28 ++++------------------------
 include/drm/display/drm_dp_helper.h     |  2 ++
 3 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 8ef096a0138e4..93cf43d166c6e 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -5149,3 +5149,33 @@ int drm_dp_read_edp_sink_rates(struct drm_dp_aux *aux, u8 edp_dpcd_rev,
 	return num_sink_rates;
 }
 EXPORT_SYMBOL_GPL(drm_dp_read_edp_sink_rates);
+
+/**
+ * drm_dp_read_dsc_dpcd() - read the DSC capabilities from the DPCD
+ * @aux: DisplayPort AUX channel
+ * @dsc_dpcd: Buffer to store the DSC capabilities read from the DPCD
+ *
+ * Attempts to read the sink DSC capabilities from the DPCD of @aux.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int drm_dp_read_dsc_dpcd(struct drm_dp_aux *aux,
+			 u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE])
+{
+	int ret;
+
+	ret = drm_dp_dpcd_read_data(aux, DP_DSC_SUPPORT, dsc_dpcd,
+				    DP_DSC_RECEIVER_CAP_SIZE);
+	if (ret) {
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
+EXPORT_SYMBOL_GPL(drm_dp_read_dsc_dpcd);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index da73ad11e9cac..830fe6eda17d7 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4430,26 +4430,6 @@ static bool intel_dp_get_sst_split_sdp_status(u8 dprx)
 	return dprx & DP_SST_SPLIT_SDP_CAP;
 }
 
-static int intel_dp_read_dsc_dpcd(struct drm_dp_aux *aux,
-				  u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE])
-{
-	int ret;
-
-	ret = drm_dp_dpcd_read_data(aux, DP_DSC_SUPPORT, dsc_dpcd,
-				    DP_DSC_RECEIVER_CAP_SIZE);
-	if (ret) {
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
@@ -4498,8 +4478,8 @@ void intel_dp_get_dsc_sink_cap(u8 dpcd_rev,
 	if (dpcd_rev < DP_DPCD_REV_14)
 		return;
 
-	if (intel_dp_read_dsc_dpcd(connector->dp.dsc_decompression_aux,
-				   connector->dp.dsc_dpcd) < 0)
+	if (drm_dp_read_dsc_dpcd(connector->dp.dsc_decompression_aux,
+				 connector->dp.dsc_dpcd) < 0)
 		return;
 
 	if (drm_dp_dpcd_readb(connector->dp.dsc_decompression_aux, DP_FEC_CAPABILITY,
@@ -4530,8 +4510,8 @@ static void intel_edp_get_dsc_sink_cap(u8 edp_dpcd_rev, struct intel_connector *
 	if (edp_dpcd_rev < DP_EDP_14)
 		return;
 
-	if (intel_dp_read_dsc_dpcd(connector->dp.dsc_decompression_aux,
-				   connector->dp.dsc_dpcd) < 0)
+	if (drm_dp_read_dsc_dpcd(connector->dp.dsc_decompression_aux,
+				 connector->dp.dsc_dpcd) < 0)
 		return;
 
 	if (connector->dp.dsc_dpcd[0] & DP_DSC_DECOMPRESSION_IS_SUPPORTED)
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index d7f4c6f2ba4c7..7bc3b36f38b82 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -215,6 +215,8 @@ drm_dp_is_branch(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 }
 
 /* DP/eDP DSC support */
+int drm_dp_read_dsc_dpcd(struct drm_dp_aux *aux,
+			 u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE]);
 u8 drm_dp_dsc_sink_bpp_incr(const u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE]);
 u32 drm_dp_dsc_slice_count_to_mask(int slice_count);
 u32 drm_dp_dsc_sink_slice_count_mask(const u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE],

-- 
2.43.0

