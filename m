Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BB606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sXPGn+aG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65C41121F4;
	Thu, 29 Oct 2026 10:52:04 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DB41121B1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:18:35 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c423b145922so274966866b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793269113; x=1793873913; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7eDSUJln09vjqS6fT78Hrmt4ANao45wYJuBLIsNkp4w=;
 b=sXPGn+aG2RryGhoMzt8zWc7xFJYHTHCyiOkCC28xVH9zq+//HraZW39czAZhP9fDka
 QJGG5p1O544UTQeaDEHbMOAjuOxXs5G+0AT6KRfBUvo8gsQEB2E5DmxjCrB80msAkyS/
 jd6AoV6By1hXf/5s8xWhvv9YgvX6prnTTVkdVvSR/ZpV9SPKTLwqqWV4JoW40xXk85Be
 WGhDu6/rs983Nre1NMwLfG6WtGXQG425UQFXblA2XP6zuCvLfcXakky6GxSHrmiVwpP7
 bmnefCmPQwYyen6yNMOJwlA+CwjcZN0KLqtE9mQmj4DPmnc30AbRK7rNcxGp8qDvzV4v
 XKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793269113; x=1793873913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7eDSUJln09vjqS6fT78Hrmt4ANao45wYJuBLIsNkp4w=;
 b=YwMcVT02ruOkoTQKaR9k4veffBfOIPS/2G+tyOKP6Do2Zs/htQdEeo0ULqjXTc5fqs
 QYVmzM5AyV4uJVcVzSYl7wFPsyzo5WescAFD2k5qpM8fcz/W+wpDPHUYQ15c9CUyjpn9
 zn9vDlA5URH2OzOG1asydoQ/v3bck9AX6wo9Q9kGXa08Zyme+tZmGOV6+aqbkRHZbpFL
 AsoDeDDham/YDtPFgZELWSf9SOb7jM1tWX6yQ18P9XxD4UXsA8HQ8E983smR/lznc7Nz
 Jr4hocVRjFeU9awBAFP1D4xlXblLEADB/P04rRdboSAsIhKCVa+ZNldXPlk1YqE2K+d9
 berg==
X-Gm-Message-State: AFq9FYKtH+4B50wrAKCqxpNbt07zxVLEC2PYRbByD5NT3qB1CAst6Tmt
 +agxlInMgxmvFugel6NnMn+duzI1DkZa2hvAtbjCoZnjGcQ1qlIM4/jSEBe3ogSP
X-Gm-Gg: AYBFou2FKCpnzjuvqjuI5EsKxWh8k3I8F6nBt0P6qrK93v8nVsy168eaXAPD28jziR1
 DvWG0zDK8+OnZCC7RSFrbaOvwRf4BckiE6Szf60M7OF7xH/NDsQUmN7LzaUHXXjN1jx++jzupuE
 FCs77roIg/DUhHQM3s/DfrxyA+8XmDHyH4hX1BkkHaDOlbCJaSWE7Bxj25UYPtFckOnKLH+4DYg
 9fcLkGYvsuZ7ehu9f0WKiRuvWlqdroKH8JJ78ZBJa7c6oeSOm4DhaJldbPdjty4FN53ZEXxkRE5
 hOdOnXog7mg3ZCj0+mT+Oejd9WjlMIOTwKuK06sQ0K0vpGcgM18/qJndVUejxeGPPw42eJtB/xk
 oqgWtqHtjbgnI7SKWxj1r6hOk2xEDqGowycBGadACsIoXzPoLN2IhSreNhkihIHooWWuAz5DRhh
 05LfbdS9iXXu9XqtLzeCuRIWbHLIywPTQXMwfxWZXi6epuISVZhS0LdyrH3GP2/BcgJ3e73ZyK0
 Z5/NWPuBiCRpMBe+UIA4aGtdi2APd7YwKsp51gKQke5c4fr160w3d5Q6y7iWfSGEAc4A3oa6L5D
 oHfOvr8oY8ZQIsHqsHlw8RRFPVAX+7PN0jNGi/TRF0xa8rh+iNn1ndIm9dCYYT0=
X-Received: by 2002:a17:906:f581:b0:c49:8fa2:4a22 with SMTP id
 a640c23a62f3a-c49bdf569b3mr418814266b.41.1793269113505; 
 Thu, 29 Oct 2026 03:18:33 -0700 (PDT)
Received: from localhost.localdomain ([46.205.195.0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd66c6dbsm712145966b.59.2026.10.29.03.18.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 03:18:33 -0700 (PDT)
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
Subject: [PATCH v2 3/5] drm/bridge: it6505: Use drm_dp_enhanced_frame_cap()
Date: Thu, 29 Oct 2026 11:18:24 +0100
Message-ID: <20261029101826.72773-4-dmitrymalovanyy@gmail.com>
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

Use the helper instead of checking DP_ENHANCED_FRAME_CAP directly, so
enhanced framing is used for all DPCD r1.2+ sinks as the spec requires.

Compile tested only.

Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index e136ac71e..d798a3db7 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1651,7 +1651,7 @@ static void it6505_parse_link_capabilities(struct it6505 *it6505)
 	link->rate = drm_dp_bw_code_to_link_rate(it6505->dpcd[1]);
 	link->num_lanes = it6505->dpcd[2] & DP_MAX_LANE_COUNT_MASK;
 
-	if (it6505->dpcd[2] & DP_ENHANCED_FRAME_CAP)
+	if (drm_dp_enhanced_frame_cap(it6505->dpcd))
 		link->capabilities = DP_ENHANCED_FRAME_CAP;
 
 	DRM_DEV_DEBUG_DRIVER(dev, "DPCD Rev.: %d.%d",
-- 
2.50.1 (Apple Git-155)

