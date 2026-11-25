Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FB606A327
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=el7WSr4+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 974D510FCB8;
	Wed, 25 Nov 2026 14:02:24 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802F410FCC1;
 Wed, 25 Nov 2026 14:02:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 45D4D4E4177E;
 Wed, 25 Nov 2026 14:02:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 13E8660480;
 Wed, 25 Nov 2026 14:02:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 45BEA11E68C9C; Wed, 25 Nov 2026 15:02:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795615325; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5cWG+sn7xvymJfT2+aJBpSqu/Q4MQkyV5NyLotQtEGI=;
 b=el7WSr4+EvQnuue42TlMESmjLqvMnOeV+7iWy+42UQKZ2gTGMYSFShK3XlX5N/ELDq7fa7
 A7tnwxWs22ZmKjcyaWquuJjJq2+Xzdp6boiccCVsVj5+r5OVzz1kuGfNV2R8jfJsM9mGy3
 YX4VM2skR1KiXc5knsdD7/k5fEVRovzL6h2amAvJ3lzE/he+UCozBp90rt+gHTlQBunExz
 mtqqGBW+o55uhiU8XeZP3JSuD1mmdV12JskSUjhAiDpV7JLdByOmT36oB10Nvuw23OnP7b
 QRkTGU/ayaRBIb+R9iItflhqzALlueP0O0tv1m9xjDyYJaYtlPnPsq/cof4elQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 25 Nov 2026 15:01:13 +0100
Subject: [PATCH v2 09/10] drm/dp: Make the eDP supported link rates helper
 static
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-feat_move_i915_helper-v2-9-aa04d39bc415@bootlin.com>
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

The supported link rates helper is now only used by the eDP sink link
rates reading function, so make it static and remove its declarations from
the public header.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- New patch extracted from the split of the 7
---
 drivers/gpu/drm/display/drm_dp_helper.c | 5 ++---
 include/drm/display/drm_dp_helper.h     | 3 ---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index d26088a1ab232..9938f3be8836a 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4925,8 +4925,8 @@ EXPORT_SYMBOL(drm_dp_max_dprx_data_rate);
  *
  * Returns: The number of supported link rates, negative error code otherwise.
  */
-int drm_dp_read_dpcd_supported_link_rates(struct drm_dp_aux *aux,
-					  int link_rates[DP_MAX_SUPPORTED_RATES])
+static int drm_dp_read_dpcd_supported_link_rates(struct drm_dp_aux *aux,
+						 int link_rates[DP_MAX_SUPPORTED_RATES])
 {
 	__le16 dpcd_link_rates[DP_MAX_SUPPORTED_RATES] = {0};
 	int ret, i;
@@ -4941,7 +4941,6 @@ int drm_dp_read_dpcd_supported_link_rates(struct drm_dp_aux *aux,
 
 	return i;
 }
-EXPORT_SYMBOL_GPL(drm_dp_read_dpcd_supported_link_rates);
 
 static int drm_dprx_max_rate(const struct drm_dp_tunnel *tunnel,
 			     const u8 dpcd[DP_RECEIVER_CAP_SIZE])
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index c3677683c5f80..81fe87ad47050 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -703,9 +703,6 @@ static inline int drm_dp_dpcd_write_byte(struct drm_dp_aux *aux,
 int drm_dp_read_dpcd_caps(struct drm_dp_aux *aux,
 			  u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 
-int drm_dp_read_dpcd_supported_link_rates(struct drm_dp_aux *aux,
-					  int link_rates[DP_MAX_SUPPORTED_RATES]);
-
 int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
 				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 				const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],

-- 
2.43.0

