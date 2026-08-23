Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E812AC5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0C710E010;
	Sun, 23 Aug 2026 12:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lmC+Vl4/";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3876A10E010
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 12:47:29 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-698ae9da373so500508a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 05:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787489247; x=1788094047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=btJKmFZ71PTN81h6iDK1kwNhJfje5OxrPXb/BOZ4f+Y=;
 b=lmC+Vl4/NOESOleUEajfyljN6+rEJYuNdi2BNb9fpNZ7sjb6U1KDFsDAvbQfWHRgeV
 JYJEsKrP+bC+uwPY6FXckXTUTbvV9S2xp22lPv+gWzqRBBlBQvxKELIRE0Ps0a0zc7Ox
 EYf4qELP/MicIDjWFK9IyIGzoWAzd4GDjnVrFZxDXaO6mE1ObN6dWSEkJ41g2G6++cKn
 b+CCiVQXdNdQsrF/HS6zKKkn0D7iidguSRM/Kj6fMeFbXQff8/cuaxPZl4elAa2LRgdV
 on7o8lTmMR4/pidVXV8UhtH61R7I4F01Obc5zRkGdi/MpRN30lsg6mA+raXLl0KQ9+SV
 GuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787489247; x=1788094047;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=btJKmFZ71PTN81h6iDK1kwNhJfje5OxrPXb/BOZ4f+Y=;
 b=IHFQfLut2/ttryAP0IgzvVByIs0h/EwV3E49GKNEdSjzZ+rnBrsj0tIDbpLB1C3E4y
 /VSLDJ+x7hunW6SI1Y3THK7BAxl7bk+RU6wbU1FrAGAM7NUUXBoSAkFzrxH3eXMsiSYu
 Cfkupuek7H84t03Te7lGh432OeAFwNYnDH1uThlu8z5IcmBY+5Uj8wW9V8ygASP1sdRH
 z1TbEMegaQux2VJ3D5FVQJEXDWrXQ41bY13GfZZbkp+JTbysHTjkHiYZOWy/+JtD4uur
 IdVd4afukmpyRSVdGfjReELaJnhKsqIioQKQaTPHo1Oi1MfouXxC9mSpJWV+lEQXKY2T
 ASiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RryFUaN9H1DFfmVnoPAzxzYkhZPRHzRWII3sIjwvB5uyRYjhfnl6elP/OXsn6f4kDKZTINn+0y7PAY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kLNYWb9BJOENvv1N91MNXMZmm5ahYhEAJIg3lrHxGmWDS6oNTH
 /GCI6QAHc6Kxy+d0Pzvc9YD8Zem1ZPQeamnQOrcK3wURIYW1urVEKbNe
X-Gm-Gg: AR+sD13OwPZmWewkKcX6clFJZwJF5UsHPMJ9scI9EGXYNDrqgjwUbED/h/i15XjQS82
 +K/Zji4sMRCkTv07sf0yUcnD1K77qva2PvOLlR/S2ZlidnAKuXOyQDSSuggReFLzfk7YUyxe2cw
 eFro1s5iBIiwYhhdRxWsp7IRhkQEo+U8HPkqqYmZZB0HBxnniKamy1V5DjubXX6KeaZjm2hXNE5
 NryxegTCRA8T+ZZ/siaQqvqMBFmtLLjKxn8OvcSS7xDpqt9EXftW5J+/xtE9oyzzxDkzwsv3dDB
 QPEPpdepZFxdWtOlN0kP8gh9T1yfX3CHtzYmUhTcsu08FfH7Yg98qAToidASDe0TPRJe/vC5gzd
 TAqmxLwbN6dpxo1BfxWhIyhmpOO4GFQzlhAFxAZCn2IvZTaV4bIcHCrqHlmrBWV4a1qhdzgfGy3
 UmSyU83Sf+g0J0K32P08t/yv0rGeC1rA7FgEc90cIULMaIC6Kmdg+C7GzOTJXwyCfoXiZeXcR0k
 mi9ssrYD18uFl9YTu1QZS2YRbw=
X-Received: by 2002:a17:907:d0e:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c246a65fe29mr1194669566b.4.1787489247274; 
 Sun, 23 Aug 2026 05:47:27 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f809bsm881373866b.41.2026.08.23.05.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 05:47:26 -0700 (PDT)
Message-ID: <dea8a038-577b-45da-bff3-703e9099b7e1@gmail.com>
Date: Sun, 23 Aug 2026 14:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] drm/rockchip: rk3066_hdmi: convert to
 devm_drm_bridge_alloc() API
To: heiko@sntech.de
Cc: hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The function devm_drm_bridge_alloc() is the new API for allocating DRM bridges.
This conversion was missed during the initial conversion of all bridges to
the new API.

Signed-off-by: Hüseyin BIYIK <boogiepop@gmx.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index f28d6a883e09..39c65ee07caa 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -703,7 +703,6 @@ rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	hdmi->bridge.driver_private = hdmi;
-	hdmi->bridge.funcs = &rk3066_hdmi_bridge_funcs;
 	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT |
 			   DRM_BRIDGE_OP_EDID |
 			   DRM_BRIDGE_OP_HDMI |
@@ -747,9 +746,10 @@ static int rk3066_hdmi_bind(struct device *dev, struct device *master,
 	int irq;
 	int ret;
 
-	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
-	if (!hdmi)
-		return -ENOMEM;
+	hdmi = devm_drm_bridge_alloc(dev, struct rk3066_hdmi, bridge,
+				     &rk3066_hdmi_bridge_funcs);
+	if (IS_ERR(hdmi))
+		return PTR_ERR(hdmi);
 
 	hdmi->dev = dev;
 	hdmi->drm_dev = drm;
-- 
2.39.5

