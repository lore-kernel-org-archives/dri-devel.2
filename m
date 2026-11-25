Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E8606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ep40XzS5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEF110FCAD;
	Wed, 25 Nov 2026 14:02:20 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72D610FCB4;
 Wed, 25 Nov 2026 14:02:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 88FF31A17F2;
 Wed, 25 Nov 2026 14:02:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 573C660480;
 Wed, 25 Nov 2026 14:02:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 29EF711E694D7; Wed, 25 Nov 2026 15:01:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795615318; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZEAH5btCz/Jr+8dA4TqNmQCszfWR/ZaZT/crCwz8BIs=;
 b=ep40XzS52idrMTMI4kGVnq2fc+nWXs/qXIbd3dpvYCQ7Bqmp4WSqLH1gzDaJLweaWT50Bg
 w/PTMsWjABJqNxD+KOyjRyCyjTPpYTGp/J1qWvVQZbGiqEeHUyXXQ/IvxYj6gQOI7CEtP3
 nSebyYpJ8qZU0SYp40gmCB5S+Wv3nNEqTWwIs6/lDk0YsTBcM3YUvSmkuU0KpVkHbO17EQ
 oXD6FRA8PHdbWABNRI5/qEzNQkeDSdtzqjiNapzhM069p5YNJy8/8GSNzcP0RyzlfFjFqv
 p39nQ98BZSDZ3JLR4q2NoX9PRCAyBYx0YSkFGOqBGKRUo7yo3bqTKtVrIzmhTg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 25 Nov 2026 15:01:12 +0100
Subject: [PATCH v2 08/10] drm/dp: Move eDP sink link rates reading helper
 out of i915
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-feat_move_i915_helper-v2-8-aa04d39bc415@bootlin.com>
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

Move the eDP sink link rates reading function out of the i915 driver
into the generic DRM helpers. The helper reads the rates from the DPCD
DP_SUPPORTED_LINK_RATES registers, available on eDP 1.4 and later
sinks.

No functional change intended.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- New patch extracted from the split of the 7
---
 drivers/gpu/drm/display/drm_dp_helper.c | 32 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 23 +++++++----------------
 include/drm/display/drm_dp_helper.h     |  2 ++
 3 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 6d684b6b94d0a..d26088a1ab232 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -5113,3 +5113,35 @@ int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
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
index 798274a7b70ea..db72e7d152689 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4832,24 +4832,15 @@ static void intel_edp_limit_sink_rates_hbr2(struct intel_dp *intel_dp)
 static void
 intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 {
-	struct intel_display *display = to_intel_display(intel_dp);
-
-	intel_dp->num_sink_rates = 0;
-
-	if (intel_dp->edp_dpcd[0] >= DP_EDP_14) {
-		int ret;
-
-		ret = drm_dp_read_dpcd_supported_link_rates(&intel_dp->aux,
-							    intel_dp->sink_rates);
-		if (ret < 0) {
-			drm_dbg_kms(display->drm,
-				    "Unable to read eDP supported link rates, using default rates\n");
-			ret = 0;
-		}
+	int num_sink_rates;
 
-		intel_dp->num_sink_rates = ret;
-	}
+	num_sink_rates = drm_dp_read_edp_sink_rates(&intel_dp->aux,
+						    intel_dp->edp_dpcd[0],
+						    intel_dp->sink_rates);
+	if (num_sink_rates < 0)
+		num_sink_rates = 0;
 
+	intel_dp->num_sink_rates = num_sink_rates;
 	intel_edp_limit_sink_rates_hbr2(intel_dp);
 
 	/*
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 2e018f1e59363..c3677683c5f80 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -712,6 +712,8 @@ int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
 				const struct drm_dp_desc *desc,
 				const struct drm_dp_tunnel *tunnel,
 				int sink_rates[DP_MAX_SUPPORTED_RATES]);
+int drm_dp_read_edp_sink_rates(struct drm_dp_aux *aux, u8 edp_dpcd_rev,
+			       int sink_rates[DP_MAX_SUPPORTED_RATES]);
 
 int drm_dp_dpcd_read_link_status(struct drm_dp_aux *aux,
 				 u8 status[DP_LINK_STATUS_SIZE]);

-- 
2.43.0

