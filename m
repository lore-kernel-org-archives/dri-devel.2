Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255F606A330
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mrvd22L3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E740610FACF;
	Wed, 18 Nov 2026 10:37:17 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E87810FADB;
 Wed, 18 Nov 2026 10:37:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id BC459C4F77B;
 Wed, 18 Nov 2026 10:37:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 004B05FE9B;
 Wed, 18 Nov 2026 10:37:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9088E11BC10FE; Wed, 18 Nov 2026 11:37:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794998225; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=88dfLPSuqC/WsUy9bGhst7PnDqfekXLs//REVIy7QUc=;
 b=mrvd22L35WcxXFYLw8j/sHPkIKfrkgxwCeaJwP7Rl26bLWnJCUqbs1Nghu+ETfZC7j7/ZA
 OWj1oTOzNEgyLM8vMvJqQ9hLToDM64F12xqreuzny4n9EbCAK1IF89GXoYYaRU70yKm0d3
 29ttn6TpdEAg20XkMmH1irXtm7Y6BJUDyNH35rMpzKHJ7F/krwwFtiFsO/Lg4ik7o080tp
 pCpAdPmOdhZ8SprkT0l3V56vCQ/lzEhIyfgBPpnw4Uz3FmxW2hgav+8sLCFNBUhtWklJnv
 nAWkAHRfDKbdt1lrPqRTNn/+5Q7ix6AJDe0qHnKgco4BhVOOjP2yYNsQUpcAog==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 18 Nov 2026 11:36:33 +0100
Subject: [PATCH 6/8] drm/dp: Make the DPRX link rates helpers static
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-feat_move_i915_helper-v1-6-652177f3107a@bootlin.com>
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

The DPRX link rates helpers are now only used by the DP sink link
rates reading function, so make them static and remove their
declarations from the public header.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 18 +++++++-----------
 include/drm/display/drm_dp_helper.h     | 11 -----------
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e06264c52bf5e..30935d3ae0055 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4916,18 +4916,17 @@ int drm_dp_max_dprx_data_rate(int max_link_rate, int max_lanes)
 }
 EXPORT_SYMBOL(drm_dp_max_dprx_data_rate);
 
-int drm_dprx_max_rate(const struct drm_dp_tunnel *tunnel,
-		      const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+static int drm_dprx_max_rate(const struct drm_dp_tunnel *tunnel,
+			     const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 {
 	if (tunnel && drm_dp_tunnel_bw_alloc_is_enabled(tunnel))
 		return drm_dp_tunnel_max_dprx_rate(tunnel);
 	else
 		return drm_dp_bw_code_to_link_rate(dpcd[DP_MAX_LINK_RATE]);
 }
-EXPORT_SYMBOL_GPL(drm_dprx_max_rate);
 
-u8 drm_dprx_128b132b_link_rates(const struct drm_dp_tunnel *tunnel,
-				u8 uhbr_rates)
+static u8 drm_dprx_128b132b_link_rates(const struct drm_dp_tunnel *tunnel,
+				       u8 uhbr_rates)
 {
 	if (!drm_dp_tunnel_bw_alloc_is_enabled(tunnel))
 		return uhbr_rates;
@@ -4938,17 +4937,15 @@ u8 drm_dprx_128b132b_link_rates(const struct drm_dp_tunnel *tunnel,
 
 	return drm_dp_tunnel_128b132b_dprx_rates(tunnel);
 }
-EXPORT_SYMBOL_GPL(drm_dprx_128b132b_link_rates);
 
-bool drm_dprx_supports_128b132b(const struct drm_dp_tunnel *tunnel,
-				const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+static bool drm_dprx_supports_128b132b(const struct drm_dp_tunnel *tunnel,
+				       const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 {
 	if (tunnel && drm_dp_tunnel_bw_alloc_is_enabled(tunnel))
 		return drm_dp_tunnel_128b132b_supported(tunnel);
 	else
 		return drm_dp_128b132b_supported(dpcd);
 }
-EXPORT_SYMBOL_GPL(drm_dprx_supports_128b132b);
 
 /**
  * drm_dp_get_128b132b_link_rates() - get the supported 128b/132b link rates
@@ -4965,7 +4962,7 @@ EXPORT_SYMBOL_GPL(drm_dprx_supports_128b132b);
  *
  * Returns: The number of link rates stored in @link_rates.
  */
-int
+static int
 drm_dp_get_128b132b_link_rates(const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],
 			       const struct drm_dp_tunnel *tunnel,
 			       u8 uhbr_rates,
@@ -5000,7 +4997,6 @@ drm_dp_get_128b132b_link_rates(const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SI
 
 	return i;
 }
-EXPORT_SYMBOL_GPL(drm_dp_get_128b132b_link_rates);
 
 /**
  * drm_dp_read_dpcd_sink_rates() - read the sink rates from the DPCD
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 5c4cb57f0fc5e..dd4c4a6ff17d1 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -703,17 +703,6 @@ static inline int drm_dp_dpcd_write_byte(struct drm_dp_aux *aux,
 int drm_dp_read_dpcd_caps(struct drm_dp_aux *aux,
 			  u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 
-int drm_dprx_max_rate(const struct drm_dp_tunnel *tunnel,
-		      const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
-u8 drm_dprx_128b132b_link_rates(const struct drm_dp_tunnel *tunnel,
-				u8 uhbr_rates);
-bool drm_dprx_supports_128b132b(const struct drm_dp_tunnel *tunnel,
-				const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
-int drm_dp_get_128b132b_link_rates(const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],
-				   const struct drm_dp_tunnel *tunnel,
-				   u8 uhbr_rates,
-				   int link_rates[DP_MAX_128B132B_SUPPORTED_RATES]);
-
 int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
 				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 				const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],

-- 
2.43.0

