Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA9606A334
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FORzT8ku
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB71410FCAE;
	Wed, 25 Nov 2026 14:02:02 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C00610FCA6;
 Wed, 25 Nov 2026 14:01:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DA4051A17F3;
 Wed, 25 Nov 2026 14:01:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AE26260480;
 Wed, 25 Nov 2026 14:01:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DB0A411E68778; Wed, 25 Nov 2026 15:01:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795615313; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=88dfLPSuqC/WsUy9bGhst7PnDqfekXLs//REVIy7QUc=;
 b=FORzT8kuGqGxG/WEA8xwp7xVrO5KIcgbOPGH+33F8ILUNOA2k9tWklEtNeaSTAvSypFD0X
 nI58b5X3BOISNIzBCTZrhLLrZl3uj4CPI8Jfp/EbWgDQibMPPddjTyV5lcaIiuqVN7/4jY
 AND8bpZv9k0jhFD0SbGR89YnIsxhS5kvsgc4HIMHuGBY0g8zoVYP2uLY5g4gWE3eIJVD9y
 G925qNEQhpgml8pgbaHVsxd96aMNmVPctj7JY0JfKid/pFtv7EThNwLLca56OZFGg5JWGO
 8I8Stx0LqHGNPK5AoXosIgsgeh634FQVcKcOmZLyeReQHkOAFaDtxi95XsQijQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 25 Nov 2026 15:01:10 +0100
Subject: [PATCH v2 06/10] drm/dp: Make the DPRX link rates helpers static
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-feat_move_i915_helper-v2-6-aa04d39bc415@bootlin.com>
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

