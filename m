Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D9606A334
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yD+eDj3t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE27D10FADC;
	Wed, 18 Nov 2026 10:37:02 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA2F10E9A1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:36:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5DBB04E4163F;
 Wed, 18 Nov 2026 10:36:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 343035FE9B;
 Wed, 18 Nov 2026 10:36:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CF95611BC10FF; Wed, 18 Nov 2026 11:36:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794998212; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=05Ho8/errHzZmgbANHpoqmN2h9/8KsF2xlUzSjWS4Fw=;
 b=yD+eDj3tzNCp8uQg5BET4XxGtCtPj3embr7SPwvP7hM0pHL2bCom7ERlou7tPadFpLPreD
 HyZhBcddj0TYOx00fq7SoYoWotliTu7D7mm2LQ+BBt6e4RwJg5TJaqZ+xJ1shYyVySD5xC
 pUPa11D2K70i1HwwxMe04hqh5fTUGxaBqGX2rS8OuJ7PvszjaxE/Wujasuf3SlltXsXvn/
 gzJgbS1vNHShORwHvWKROg8feq5Um8g4B/z8hjAkkpDdj8P65hMLDVZcibBya/GBxDum9g
 478uMdmTq18GLk5eEk3nCbvnZ9obRY4eqjaBa5b/PyrtMm0pc70zXhcEsn4GaA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 18 Nov 2026 11:36:29 +0100
Subject: [PATCH 2/8] drm/dp: Move DPRX 128b/132b link rates helper out of i915
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-feat_move_i915_helper-v1-2-652177f3107a@bootlin.com>
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

Move the drm_dprx_128b132b_link_rates() helper from the i915 driver
into the generic DRM helpers. It returns the DPRX supported 128b/132b
UHBR rate mask, either from the DP tunnel capabilities when bandwidth
allocation is enabled or from the mask passed by the caller.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 14 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 17 +----------------
 include/drm/display/drm_dp_helper.h     |  2 ++
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e58dabdad1f39..86260ffd57cdc 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4925,3 +4925,17 @@ int drm_dprx_max_rate(const struct drm_dp_tunnel *tunnel,
 		return drm_dp_bw_code_to_link_rate(dpcd[DP_MAX_LINK_RATE]);
 }
 EXPORT_SYMBOL_GPL(drm_dprx_max_rate);
+
+u8 drm_dprx_128b132b_link_rates(const struct drm_dp_tunnel *tunnel,
+				u8 uhbr_rates)
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
+EXPORT_SYMBOL_GPL(drm_dprx_128b132b_link_rates);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 96379c18b8cd4..e124e7dced178 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -181,21 +181,6 @@ static bool dprx_supports_128b132b(struct intel_dp *intel_dp)
 		return drm_dp_128b132b_supported(intel_dp->dpcd);
 }
 
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
@@ -254,7 +239,7 @@ static void intel_dp_set_dpcd_sink_rates(struct intel_dp *intel_dp)
 	if (dprx_supports_128b132b(intel_dp)) {
 		BUILD_BUG_ON(ARRAY_SIZE(intel_dp->sink_rates) < ARRAY_SIZE(dp_rates) + 3);
 
-		uhbr_rates = dprx_128b132b_link_rates(intel_dp, uhbr_rates);
+		uhbr_rates = drm_dprx_128b132b_link_rates(intel_dp->tunnel, uhbr_rates);
 
 		if (drm_dp_lttpr_count(intel_dp->lttpr_common_caps)) {
 			/* We have a repeater */
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index fe08a66f2bb1e..7985bb269fdf2 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -704,6 +704,8 @@ int drm_dp_read_dpcd_caps(struct drm_dp_aux *aux,
 
 int drm_dprx_max_rate(const struct drm_dp_tunnel *tunnel,
 		      const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
+u8 drm_dprx_128b132b_link_rates(const struct drm_dp_tunnel *tunnel,
+				u8 uhbr_rates);
 
 int drm_dp_dpcd_read_link_status(struct drm_dp_aux *aux,
 				 u8 status[DP_LINK_STATUS_SIZE]);

-- 
2.43.0

