Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAC0606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=UEdEcvKB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A01110E0DA;
	Wed, 25 Nov 2026 14:01:46 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83D7510FC7B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:01:34 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id F072FC2BB3D;
 Wed, 25 Nov 2026 14:01:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 17B9C60480;
 Wed, 25 Nov 2026 14:01:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0102711E6938B; Wed, 25 Nov 2026 15:01:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795615287; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+3kyzjg3dtcYpCdDljWXckSn2UKrKCqRAGKJNdgkqoM=;
 b=UEdEcvKBip+siBljfMxcHfWcykH6NfD/m5mICWve0fWs3KPwdEiOLc83Uaiq97aHmZRLzE
 giJwICakSp46lCQuERUWzEZM+Ns5kIDZq1drtmWixV0myu17Iu85gGOKB1yMbYZ8N0HcOB
 ZcHec9DWVji4XOhFTf9Dh47r+r+jFxkFxT/XRd17VAntNEBv5xUONjuAepRBsQZjHIz1Q/
 4QXUwXb20ctwt1LzaHKQebKsL6nRqEmWCSgOT3O9hDNYAvJB/LMV0Y6ZULpDySfjL7aQgN
 24oIGO++SMVPoJWZHC4Cu5UfW3h8QP9a0E26bvvWI9j2ovK5Rcaj/77K3uYElg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 25 Nov 2026 15:01:05 +0100
Subject: [PATCH v2 01/10] drm/dp: Move max DPRX link rate helper out of
 i915
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-feat_move_i915_helper-v2-1-aa04d39bc415@bootlin.com>
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

Move the drm_dprx_max_rate() helper from the i915 driver into the
generic DRM helpers. It returns the maximum DPRX link rate, either from
the DP tunnel capabilities when bandwidth allocation is enabled or from
the DPCD DP_MAX_LINK_RATE register.

Keep the Intel eDP HBR2 limitation quirk handling in the driver.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 11 +++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 35 +++++++++++----------------------
 include/drm/display/drm_dp_helper.h     |  4 ++++
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 2b6ce05556b0d..e58dabdad1f39 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -37,6 +37,7 @@
 
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
+#include <drm/display/drm_dp_tunnel.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_print.h>
@@ -4914,3 +4915,13 @@ int drm_dp_max_dprx_data_rate(int max_link_rate, int max_lanes)
 				  1000000 * 8);
 }
 EXPORT_SYMBOL(drm_dp_max_dprx_data_rate);
+
+int drm_dprx_max_rate(const struct drm_dp_tunnel *tunnel,
+		      const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+{
+	if (tunnel && drm_dp_tunnel_bw_alloc_is_enabled(tunnel))
+		return drm_dp_tunnel_max_dprx_rate(tunnel);
+	else
+		return drm_dp_bw_code_to_link_rate(dpcd[DP_MAX_LINK_RATE]);
+}
+EXPORT_SYMBOL_GPL(drm_dprx_max_rate);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ef164a7976187..96379c18b8cd4 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -159,28 +159,6 @@ int intel_dp_link_symbol_clock(int rate)
 	return DIV_ROUND_CLOSEST(rate * 10, intel_dp_link_symbol_size(rate));
 }
 
-static int max_dprx_rate(struct intel_dp *intel_dp)
-{
-	struct intel_display *display = to_intel_display(intel_dp);
-	int max_rate;
-
-	if (intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))
-		max_rate = drm_dp_tunnel_max_dprx_rate(intel_dp->tunnel);
-	else
-		max_rate = drm_dp_bw_code_to_link_rate(intel_dp->dpcd[DP_MAX_LINK_RATE]);
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
-	return max_rate;
-}
-
 static int max_dprx_lane_count(struct intel_dp *intel_dp)
 {
 	if (intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))
@@ -221,6 +199,7 @@ static u8 dprx_128b132b_link_rates(struct intel_dp *intel_dp, u8 no_bwa_rates)
 /* update sink rates from dpcd */
 static void intel_dp_set_dpcd_sink_rates(struct intel_dp *intel_dp)
 {
+	struct intel_display *display = to_intel_display(intel_dp);
 	static const int dp_rates[] = {
 		162000, 270000, 540000, 810000
 	};
@@ -241,7 +220,17 @@ static void intel_dp_set_dpcd_sink_rates(struct intel_dp *intel_dp)
 	/*
 	 * Sink rates for 8b/10b.
 	 */
-	max_rate = max_dprx_rate(intel_dp);
+	max_rate = drm_dprx_max_rate(intel_dp->tunnel, intel_dp->dpcd);
+
+	/*
+	 * Some platforms + eDP panels may not reliably support HBR3
+	 * due to signal integrity limitations, despite advertising it.
+	 * Cap the link rate to HBR2 to avoid unstable configurations for the
+	 * known machines.
+	 */
+	if (intel_dp_is_edp(intel_dp) && intel_has_quirk(display, QUIRK_EDP_LIMIT_RATE_HBR2))
+		max_rate = min(max_rate, 540000);
+
 	max_lttpr_rate = drm_dp_lttpr_max_link_rate(intel_dp->lttpr_common_caps);
 	if (max_lttpr_rate)
 		max_rate = min(max_rate, max_lttpr_rate);
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index f497c9f3a5504..fe08a66f2bb1e 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -33,6 +33,7 @@ struct drm_device;
 struct drm_dp_aux;
 struct drm_panel;
 struct drm_printer;
+struct drm_dp_tunnel;
 
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
@@ -701,6 +702,9 @@ static inline int drm_dp_dpcd_write_byte(struct drm_dp_aux *aux,
 int drm_dp_read_dpcd_caps(struct drm_dp_aux *aux,
 			  u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 
+int drm_dprx_max_rate(const struct drm_dp_tunnel *tunnel,
+		      const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
+
 int drm_dp_dpcd_read_link_status(struct drm_dp_aux *aux,
 				 u8 status[DP_LINK_STATUS_SIZE]);
 

-- 
2.43.0

