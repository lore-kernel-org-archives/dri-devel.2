Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA8EC5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F68310EF6A;
	Thu, 20 Aug 2026 08:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N9H72cm8";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7927B10E9D9
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:12:26 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2d032846c95so14630375ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787152346; x=1787757146; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qXxMT626CxIJxNtnvKadUbkm5J1eV87PtyZPkHVWvbs=;
 b=N9H72cm83TVfeNRXHKKw8uTwDPjXCDhDTY1jorm2ERSnGJW9GieH67aWUHokLGNytb
 ATXeONz8ytbb/pbEJ4+osAb5V5OiM29p8hw0nuLDZ5Pr5grDt7M5LLFVxKpvPm66qJWg
 nklNWn3h34zJwjCv9tCaRMUdTa8Pv6iTA9hU96mLu9YQmek46l5sbzig1dk9YF1rhAgq
 BjFwQNRWM46DY4HfnUlARWvRgpn1Rpkh6iF3Tcg8c188EyIp9C1l6tXxltYuRHFZCBVc
 jFLKM5SkIA6+2BWW0wSlEAPD9utEQdOsZ3ctDtbAZYDZR6EJOhX11oPmgXKJEaidIqvL
 9KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787152346; x=1787757146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qXxMT626CxIJxNtnvKadUbkm5J1eV87PtyZPkHVWvbs=;
 b=bKob0dT3ySrQEX+03zc7bn8HXmGf5eBZFBXudlh35puwoyKrZlbKfvouJivE/dkIZs
 WZGWGdNdJow3toGCx8DFGrZRBMq6tmhpiA4og5KKoEv6RlfobKYGvoGjiD2FTNnMFZOn
 cqYEEXsS9xLpOo7kME1RZ3b3BvPLf/e9Zs9QSfqubmJCQR13E9wBr3ByHhuJ/hI9HZUt
 b0T3wKcPTDsRK/ZwFC9uIq7sgEMtrG4MOlBR7Cy8H6nEPNwz5Xg2E7G1W+lXAGTPfRHE
 xtwF6f9obpzPY5I9c0SrtfaHQlZ+7mkqCMtMUMeJN6yF29qQbXHJ6HHrCiYXDoh1mhtY
 JsaA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqn+pHquxsHgA6VMG6hvjzqm5KEIrVim03STsDel1Sunt4/7xfAatl8wX9TMO06fPE8FojsT6gMfrI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7bsboWIZ1TpLORMycDZsFTVQHKLlnATAzvbmg59tl0PXHfwaw
 UH+e8CcAz+Ts4CwX1ghHcoeL935uc6lvn1rSuhZCNsFLZ4taEeeJGf6K
X-Gm-Gg: AR+sD10v6UK9hZ4hYBZqE28EtSRiLWK0O4sTyAv9oXBxiq6MsRF8yQ8oE27+5yPjI3a
 yda3//WBymUA5LUjHspsWcBTtTwWTHU1A44eEx4h/d6v5TiZsUhna+6FlweYJa2l324CvO6vWgT
 SFRpD9Z0kftim3bOiPSFM/2q6PCe3UJoqQSPgzK+mT28ev4A+YxrQIAL/YzV5jAxEHfadU5z9jA
 ozvKYVNEM092J9F16BeoPuUHc0uy3W2sK69F5JNnAK7lXkwvr88m3bPqXCY+7x/nJSfX+ZqJTIc
 srinjaQukCRTfTdzta7lEsS6amiftd//0TTDNM7P+AwcoEgf7JfwUU1La0SXWRRGuQGmRd8O4+2
 zWM4KKzYEun2pTwjkZgAsr6c53U06SFP/0ReDnvjhlnGk82BfzYefAIo2xqjw9Wb3SsX8vDOo8N
 8LM5y9bTa8ZLKk/1hl3qw06Xr+mZCqwyFb0qu1/7B94vhpEdrxUgQgVd9TAjLfRwiyvrHT6706a
 XGI2kOIOAHRdjHN77FlTzRysMcdDsn/aDuHSCT4pzxV9WF8c/3L4zHrhw==
X-Received: by 2002:a17:902:da85:b0:2cf:ba10:6d6 with SMTP id
 d9443c01a7336-2d5fd6910b3mr95763645ad.4.1787152345810; 
 Wed, 19 Aug 2026 08:12:25 -0700 (PDT)
Received: from LAPTOP-M4N25KQ5.tail73068d.ts.net
 (1-160-197-194.dynamic-ip.hinet.net. [1.160.197.194])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1e91356sm25236125ad.59.2026.08.19.08.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:12:25 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Liu Ying <victor.liu@nxp.com>,
 Jani Nikula <jani.nikula@intel.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v1] drm: bridge: dw_hdmi: Fix constant truncation warning on
 phy_mask
Date: Wed, 19 Aug 2026 23:12:16 +0800
Message-ID: <20260819151216.56833-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:48:42 +0000
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

In dw_hdmi_probe(), casting the bitwise complement of (HDMI_PHY_HPD |
HDMI_PHY_RX_SENSE) directly to u8 triggers a compiler warning
(-Wconstant-conversion).

Due to C integer promotion rules, the bitwise OR and bitwise NOT are
evaluated as 32-bit signed integers, producing 0xFFFFFF0D before being
cast down to u8.

Fix this by explicitly masking the inverted 32-bit result with 0xFF
to keep only the lower byte and prevent implicit upper-bit truncation.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 34c5f583e910..937d61c42b58 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3353,7 +3353,7 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 	hdmi->channels = 2;
 	hdmi->disabled = true;
 	hdmi->rxsense = true;
-	hdmi->phy_mask = (u8)~(HDMI_PHY_HPD | HDMI_PHY_RX_SENSE);
+	hdmi->phy_mask = ~(HDMI_PHY_HPD | HDMI_PHY_RX_SENSE) & 0xff;
 	hdmi->mc_clkdis = 0x7f;
 	hdmi->last_connector_result = connector_status_disconnected;
 
-- 
2.43.0

