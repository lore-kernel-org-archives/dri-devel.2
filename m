Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43F606A332
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IV7kLhGB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE29210FAC7;
	Wed, 18 Nov 2026 10:37:07 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D795E10FAB2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:36:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5F013C4F77B;
 Wed, 18 Nov 2026 10:37:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 94BE65FE9B;
 Wed, 18 Nov 2026 10:36:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B32AF11BC10FE; Wed, 18 Nov 2026 11:36:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794998215; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=653wFHNe58RDGPkNgZywAB9EUf/nkwl86zOUosYCpho=;
 b=IV7kLhGBzXfi1ggACD+FDerNdfNnZc/GLqQ4HLkrmt4TWR3tVKzTEz+0UliBeVbYbp9BDj
 BBjpFbr69yiW2r4L/g0R04dSLr+Km13HYyoarkHLBtIiwc+PAy18XkN2L55+1pquTVF9aF
 201P7lgABwALGwOljB8aWlDkoBkD8wkFfxkWIRCgU5Ccs9D6jQgzeyQ3sDHFWRCNavcqu+
 bcvX0j0c1Q3nTCXMvx7dYMeG40g/gaeDbzgfjLbY3i1WeBipdpmJOlgkNaPyU1DI5jwOS8
 KstRmwxP7CKoSl8REbH+a4i0fKcnfYpvkNfPC6FvN4tTAen+2LzEVNOy4Ti1EA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 18 Nov 2026 11:36:30 +0100
Subject: [PATCH 3/8] drm/dp: Move DPRX 128b/132b support helper out of i915
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-feat_move_i915_helper-v1-3-652177f3107a@bootlin.com>
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

Move the drm_dprx_supports_128b132b() helper from the i915 driver into
the generic DRM helpers. It reports whether the DPRX supports 128b/132b
channel coding, either from the DP tunnel capabilities when bandwidth
allocation is enabled or from the DPCD receiver capabilities.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 10 ++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 10 +---------
 include/drm/display/drm_dp_helper.h     |  2 ++
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 86260ffd57cdc..c92d89ecf96e4 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4939,3 +4939,13 @@ u8 drm_dprx_128b132b_link_rates(const struct drm_dp_tunnel *tunnel,
 	return drm_dp_tunnel_128b132b_dprx_rates(tunnel);
 }
 EXPORT_SYMBOL_GPL(drm_dprx_128b132b_link_rates);
+
+bool drm_dprx_supports_128b132b(const struct drm_dp_tunnel *tunnel,
+				const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+{
+	if (tunnel && drm_dp_tunnel_bw_alloc_is_enabled(tunnel))
+		return drm_dp_tunnel_128b132b_supported(tunnel);
+	else
+		return drm_dp_128b132b_supported(dpcd);
+}
+EXPORT_SYMBOL_GPL(drm_dprx_supports_128b132b);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index e124e7dced178..2ba89fee097d6 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -173,14 +173,6 @@ static void intel_dp_set_default_sink_rates(struct intel_dp *intel_dp)
 	intel_dp->num_sink_rates = 1;
 }
 
-static bool dprx_supports_128b132b(struct intel_dp *intel_dp)
-{
-	if (intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))
-		return drm_dp_tunnel_128b132b_supported(intel_dp->tunnel);
-	else
-		return drm_dp_128b132b_supported(intel_dp->dpcd);
-}
-
 /* update sink rates from dpcd */
 static void intel_dp_set_dpcd_sink_rates(struct intel_dp *intel_dp)
 {
@@ -236,7 +228,7 @@ static void intel_dp_set_dpcd_sink_rates(struct intel_dp *intel_dp)
 	 * Sink rates for 128b/132b. If set, sink should support all 8b/10b
 	 * rates and 10 Gbps.
 	 */
-	if (dprx_supports_128b132b(intel_dp)) {
+	if (drm_dprx_supports_128b132b(intel_dp->tunnel, intel_dp->dpcd)) {
 		BUILD_BUG_ON(ARRAY_SIZE(intel_dp->sink_rates) < ARRAY_SIZE(dp_rates) + 3);
 
 		uhbr_rates = drm_dprx_128b132b_link_rates(intel_dp->tunnel, uhbr_rates);
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 7985bb269fdf2..b67bb06f6e07e 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -706,6 +706,8 @@ int drm_dprx_max_rate(const struct drm_dp_tunnel *tunnel,
 		      const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 u8 drm_dprx_128b132b_link_rates(const struct drm_dp_tunnel *tunnel,
 				u8 uhbr_rates);
+bool drm_dprx_supports_128b132b(const struct drm_dp_tunnel *tunnel,
+				const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 
 int drm_dp_dpcd_read_link_status(struct drm_dp_aux *aux,
 				 u8 status[DP_LINK_STATUS_SIZE]);

-- 
2.43.0

