Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273C3606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oj3sQTgg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585BA10E7F2;
	Thu, 29 Oct 2026 10:52:10 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B7A1121A2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:18:37 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b1f31c63ebso911334a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793269115; x=1793873915; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tLSIccFHorX+6O5ooGIFQ+bO/vHG9UJYFlcd1fhhBi4=;
 b=oj3sQTggVxBTQb+EwMR674xBEYVqrgeeYxBTMEmU40N2bhWvmCDOTsJtB+pT5EHg8D
 SWHmView+pRyYj9pglW1CKjzTPotiynWyllf2XnFUs2yAGvLlJrsoecTY9/DHEGr0Rug
 n080YjxOkGDc5bEwIvcBUqlnqenjnkaKK8noPAjflki6q1gFXMy393y50dnPoRPUGM0V
 21L8Pg9VoBK9kEwTI+AWnfZxKVsAn6gk96Zt/qFpGUkh4xQymtMWi7VrrmDCqV/ynaJm
 LW6jWPftot8RtoxYaIyGQM+Q3hPLVPKaURl1WjXx62OM13yju1BTfR6wqF/D2e5CGbzN
 +grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793269115; x=1793873915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tLSIccFHorX+6O5ooGIFQ+bO/vHG9UJYFlcd1fhhBi4=;
 b=uGojBVXnK1jpLXY47n5KFh091iHCiqr2CQe/2WCzyDn4zw/kQeFg2A6i49ZPbR04J6
 XMA9LoaRMp2vCSW8i269P00z5p2vM1sNsGmgsQgCmIDuVd/iYzuoVfNmStxMn+6xlM/T
 ynw1oadSmXrDdBTlbtNMAONwonMJAjsm2xCX1SgDvrBYJq74elOPQVN6rVFm6oUgmI5a
 N2DiTmXPMmPXUeKHvCUbcDxVufInZRpYxB2dQbaxsBkrbiKenAc8BelR3HAB9DgcG/g5
 DAy9epba1KS+UQEr8jme/AsE2FWL+WjYCF7Bb2t/+tB6TmQRHgXRkdgW96e5fjxviErq
 3XGw==
X-Gm-Message-State: AFq9FYJ714KlmrhCfd3XyWmruoT2kGksZXu6bqNvpGKCfPaHltwoVsf7
 AoQzCp+RMBDSdL2uwll2P5r4abuse+d8Qo1s/w5NmSznrpXW6ZuhY0ZVgeSafghC
X-Gm-Gg: AYBFou28yzH0lXnYVoQWEw3+8W54rjm6PqfjrIxRLvLw+W3HWaKXbV4olAOccgj6dQp
 eunWV53WcAszBf0/ALvCQ4LgCT4ZXkDrpP9RRd3PajaRSki0KB+qXr8PR7AWxCVvqbkHYtstSXm
 SyrbgBsZKx3cDQ5gtIcmP8ImcLLTgb3/A18v6fG0cMQdmpzK0igak1KC0iK9M2cZKLAOL+zZZd4
 VjiRKbzYpHsqYfBvadrcFhJ1V50tWVh4AHEUpi0ykSu8qEbZsYewtwGPO14RiJrNJLtTs7mqicS
 3JBx+6ThQfpfdKH7zDRHrrfdntLdx/0KY4MqPFlFehnHg2dWLmIT2HzffT5bVgj/kNyl/NOHX9a
 4sqqqc+IuTau06aKwmpff+e5qY9wlrU/3NojXFC1lq+IA6g7BAdFMhHLAm52fBG8PC29NwQHUmP
 wBbvyqhLjhmczLGvMJeU6YdPeazunPhuYvvShsruyTQVZfceH8MfBSDlVMyFBQkIaV6fhGRGBr6
 IwEgSnSq6gMderaKsCHpPdTqUeGqkluziTO8sfd1dUM42kjCzHUA4GG3skFDJ0iWTQoTY+HIQuW
 yxGLBFM0grJKVAC5VtPiBx5sDY7xtfMNXj/J98sOseMzlTZYDJoGxFP8ULLpAyk=
X-Received: by 2002:a17:907:80e:b0:c2e:62af:b6fe with SMTP id
 a640c23a62f3a-c49d11324e8mr178671366b.8.1793269115238; 
 Thu, 29 Oct 2026 03:18:35 -0700 (PDT)
Received: from localhost.localdomain ([46.205.195.0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd66c6dbsm712145966b.59.2026.10.29.03.18.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 03:18:34 -0700 (PDT)
From: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
Subject: [PATCH v2 4/5] drm/gma500: Use drm_dp_enhanced_frame_cap()
Date: Thu, 29 Oct 2026 11:18:25 +0100
Message-ID: <20261029101826.72773-5-dmitrymalovanyy@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
References: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 10:51:56 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the helper instead of open coding the check, so enhanced framing is
used for all DPCD r1.2+ sinks as the spec requires.

The helper takes DP_RECEIVER_CAP_SIZE bytes and gcc warns about reading
past dpcd[4] (-Wstringop-overread), so read the full receiver caps like
the other drivers do. That is 15 bytes, it fits in one AUX transfer.

Compile tested only.

Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index 8d0626ddf..0973598c7 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -262,7 +262,7 @@ struct cdv_intel_dp {
 	uint32_t color_range;
 	uint8_t link_bw;
 	uint8_t lane_count;
-	uint8_t dpcd[4];
+	uint8_t dpcd[DP_RECEIVER_CAP_SIZE];
 	struct gma_encoder *encoder;
 	struct i2c_adapter adapter;
 	struct i2c_algo_dp_aux_data algo;
@@ -1070,11 +1070,7 @@ cdv_intel_dp_mode_set(struct drm_encoder *encoder, struct drm_display_mode *mode
 	intel_dp->link_configuration[0] = intel_dp->link_bw;
 	intel_dp->link_configuration[1] = intel_dp->lane_count;
 
-	/*
-	 * Check for DPCD version > 1.1 and enhanced framing support
-	 */
-	if (intel_dp->dpcd[DP_DPCD_REV] >= 0x11 &&
-	    (intel_dp->dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP)) {
+	if (drm_dp_enhanced_frame_cap(intel_dp->dpcd)) {
 		intel_dp->link_configuration[1] |= DP_LANE_COUNT_ENHANCED_FRAME_EN;
 		intel_dp->DP |= DP_ENHANCED_FRAMING;
 	}
-- 
2.50.1 (Apple Git-155)

