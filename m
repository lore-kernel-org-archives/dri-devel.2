Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D0BC5321C
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E7310E303;
	Mon, 27 Jul 2026 07:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nF3H2Rvl";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A87410F2E1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 10:08:30 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84e0688b859so104717b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784887710; x=1785492510; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GPKCvlhCvKQtHeiybNzrxgoDIHKyA0cPY2rVSugIzn4=;
 b=nF3H2RvlqVfIFcJbclggcVo23W2poufcL2l5gHJ048WNjPjztqHMGWBgpOEkFt5E5Y
 Q/wmNHCiXb9erhHLI9txTy52ND2MKApllNMMd1nJdzw/+Th4hYIReOI7IrVMcKyxNWQG
 4uypyOgyNIUp5ORGfUnCa5A/hvGmQq0tirCg61d6xpbw6J4pvPzvHFmtb/ZaPJSFfmuy
 fc6MZ9bxZwB5MvDjHAIRpbDgwOftjU6RI4y58L463NysxBgyk4/EvvrvsWC+TbEjZmVD
 c78V7oZzJN0CsKW35HoltJmNB0b5ZAb7G+3Y8Mncm4H+QqRFCJykxzqv4egcbvaEJSZW
 +bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784887710; x=1785492510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GPKCvlhCvKQtHeiybNzrxgoDIHKyA0cPY2rVSugIzn4=;
 b=DlHubxyuA+Rs9E74JnNVVYKjfps0Dx522QsfY2fEbkyRqi1K6uZd+IW9lBV7NSVkD2
 kzubmDRe6K2FiMoTJqVaoEDZzZKGA6Hnsmr4+fgBApv5cUmJp0BlQBMuEVBYiEbI66vV
 4iioQq/lHHbitj/f7xnYVibvIQMK59CfoY186nv/XTedJJcMSq/16UXa3gNWtRrXfozS
 XFA6+lkAvGqIe2AqxOD6zKVhsnJ/MttmoHZBtsG9LFhliWubDE2faZH+5pgHAccvjCak
 mEXKl52nlMXgtKWtwHK7bxogtD9O26fAFDTkX7RTcCwwSwJr3aN31+dlTIoJEWyvtdRH
 0Qsg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+nD5gP87/f05MXCF8oTErkTDx/xBM+/vwtGZ43bqDJ+IU3LdSlf15YUm5pST7++wL3vi2XgAVJpE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSTxCyfmgQSkkm7h4FjMTwhJG0mMppvLmH4N5E+b5PqhahE85Y
 9SEOAxsMHaS5S1rWHAR6sZd4SuY1M3HoKYLttZYMJK5vwQ1oKulSkErf
X-Gm-Gg: AR+sD13P1lmYaLLobvhQFUQ/M9d796FfnnS6exZWM/Jef49o+PBlh0DwMvWdhlDKahA
 rXYeXQpohOjVJRjvjgsuFwYpQ5jmhktcEcUHeJYCfa6+i4zyfRZXGTX4SB8wxHMfJf4eohve72F
 FbEydOy9M2HzquQT0cbWp5YQ+U7LVrQUTbdaLCnQAPW+F/2QE+e3s3QO03RodO9kXi27U0cdLYQ
 eqoqBUYrCv34yPH6Amh3LZcuZ32X9ei+ckowVn8ufEUqR9dedbxEfgJfYow9Ntc6rIW2a6t7dkG
 Qd5yaQdrDUQKEeqTBgCJKe4g5sUMT2EUYV448folqqJWRu9aM7QodjpcjdSaurirZjYyMOYgNnJ
 eJlcV/WzakuRsGjceWwdCZ+0rlOiYMvTH9JBijn9mWkROU2iH+Pn9lIraDt4jm4CI3CfzD4c6kE
 I9eFMnEKLod6lQK9U/KqIHZAA7TJ9/LGdX1Run+M+UqOFXLjM/pLZ76CyVppnBuqzi3rftmAanU
 p8ADi2Yat3qWB6ARAgkBQ==
X-Received: by 2002:a05:6a00:1f0b:b0:84e:23a:14ba with SMTP id
 d2e1a72fcca58-84e2bba3b90mr7354559b3a.55.1784887710170; 
 Fri, 24 Jul 2026 03:08:30 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e175cdc21sm4405335b3a.47.2026.07.24.03.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:08:29 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/2] drm/bridge: adv7511: handle regcache_sync() failure on
 power on
Date: Fri, 24 Jul 2026 17:08:03 +0700
Message-ID: <20260724100803.50169-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724100803.50169-1-phucduc.bui@gmail.com>
References: <20260724100803.50169-1-phucduc.bui@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

From: bui duc phuc <phucduc.bui@gmail.com>

regcache_sync() failure in adv7511_power_on() is silently ignored,
leaving the chip marked as powered on even though register
synchronization may not have completed successfully. Log the error
and attempt to power the chip back off on failure, to avoid the
driver believing the chip is fully configured when it may not be.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index d98a8f7afc7f..3e470366bce0 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -367,12 +367,20 @@ static void __adv7511_power_on(struct adv7511 *adv7511)
 
 static void adv7511_power_on(struct adv7511 *adv7511)
 {
+	int ret;
+
 	__adv7511_power_on(adv7511);
 
 	/*
 	 * Most of the registers are reset during power down or when HPD is low.
 	 */
-	regcache_sync(adv7511->regmap);
+	ret = regcache_sync(adv7511->regmap);
+	if (ret) {
+		dev_err(&adv7511->i2c_main->dev,
+			"Failed to sync register cache: %d\n", ret);
+		__adv7511_power_off(adv7511);
+		return;
+	}
 
 	if (adv7511->info->has_dsi)
 		adv7533_dsi_power_on(adv7511);
-- 
2.43.0

