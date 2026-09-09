Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A29C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085FE10E13C;
	Wed,  9 Sep 2026 20:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CDE38soX";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EB510E13C
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 20:14:14 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso4866837a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788984854; x=1789589654; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=guZfSRNKXMdPmVg1h6Pr0fhBzdAopq3h34A4o0fDPKo=;
 b=CDE38soXpIuqnVEYkvbquYIwf781ycujskQRLV267/ENt6OPMU2Q7EqC38chtb614o
 inU91JPGsurSPMmulAThGGESf/x6t53pSKyfNDMwtwybXl/vwXcUvQy32FDdW7NBk7jM
 NHKZ24Flffz4I6W/KPcUoLAFnzIXFdt35KrERU53iUMG6E/+M6VSEn5DerDvoS4Kh2K3
 IP1j1JJURrHccY8B7hTHVOk9UmH7cSkkP1qnNEI9SK5BEtAYpCEzrs6pQdiFgAm+7NEf
 Wt/tHnScPyPD50tJ0MQV1vamcMsPBDw2Xyg+6FCKg7yyxTFwzimlUAV3UsgPPzVPzr7c
 ihpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788984854; x=1789589654;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=guZfSRNKXMdPmVg1h6Pr0fhBzdAopq3h34A4o0fDPKo=;
 b=E1j6nHp0CZh0KWBzpq/zZ8vDQXI/Kvv8yRaExG/ob+QmktSkXfxr3ZN+u8SUpKxGQZ
 /Pyu1qQrxPlNqlIwwHbskTX130Z2YUkqvrMgBSvsSRhp+J/5qFrn6/zz8ojVXK/n3UwW
 Xhm3T0hYFubOl5Js1cqABQ48yHpqbqhYqqiZwuRFAl2Qt31SugrhKkUwM0fQ1eFEMcie
 8rc1s/d7I/W8Y9tT1oeBIH+oSVyjElo/LCg/ENBCPcbkGj64BcW9zExlA9xHiXKf2Quh
 aevZbMXURmMEOJ7mn65VsC9G1bMWgNyzzHfJdHrh4Wxhke5nx2P5N9wvAQRvmxnespTW
 GdPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBym0RvhNwGd8EgnrbcH2/P8ofKeD4s+yOXpr8T2j0V3WAmtAOZ0cZSIKQg+0YG2YRMbEE422W8CAS8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lydmZOukuaSHkluBnrtD/hnxizLkEA2AAEHJFHM+PFowboiO8Q
 2OIPbBBIE0NNubd0pTw309BROzIIijTfHHAEC0CTz5zDk8jcdsFAqcZ9
X-Gm-Gg: AYBFou3OmElA9x53RVxwwMxoC5H159B+KE9e2Bzb6obmU3omlM0vAY+WfXQVx6bx63S
 W7dlX9yvaTaz1GcnSkam9qv3Nr5Z3Z5VGXCecHprktgqEFxTeg31PIETaLi9FUsEOzSbfXY6DSU
 m4JspbmQgLIbUhCPoigCcI3wGIeJGf06ZKENrI5WobgAPKH+3VsJu/eRZ/alBFMb23WmFfci36N
 o2OtuSnZ9Dh5Q04QTHaMclh87z+YfjJPyWXh1RA1XS020mxhz2yhL6dOE6SRD/ku5jRruzJqZCD
 EuV4DBrUVYGFRAZ3l4BJeOdk05cB/lrBkugicSJXezpEm8nyI09n/1+8ruqEEip5rlkds0Dzb/U
 75lJcnnCfNHX16DixuSNlH5dilOxYaaHtm/9m4JDEFlfUVJyr4AUWw1V/LTLQ0xmLT94sePLOS2
 FqPSPmPMMeGhH8k6YYhH/Qhz9MKH/g268WK00+6E1X2vqWxPEaRjUrl7JKXjkVGrerHNkDGogTr
 TCJXqlHuKTztnz8kzt2GRIPONz3/wbcdUCxIN38t6SZB8Jy
X-Received: by 2002:a17:90b:4e8f:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-39b261ba63bmr56325924a91.11.1788984853726; 
 Wed, 09 Sep 2026 13:14:13 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a803:6c49:659c:692c:9416:2f0d])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbf1feesm46840513eec.26.2026.09.09.13.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 13:14:12 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, dri-devel@lists.freedesktop.org,
 Fabio Estevam <festevam@nabladev.com>, stable@vger.kernel.org
Subject: [PATCH] drm/panel: simple: Add Raystar RFF500F-AWH-DNN enable delay
Date: Wed,  9 Sep 2026 17:13:46 -0300
Message-ID: <20260909201346.937343-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

From: Fabio Estevam <festevam@nabladev.com>

The RFF500F-AWH-DNN datasheet requires a minimum delay of 250 ms
between display signal output and backlight power-on.

Without this delay, the backlight can expose unsettled panel contents
during display startup, resulting in a brief bright flash.

Set the panel enable delay to the datasheet-specified minimum.

Cc: stable@vger.kernel.org
Fixes: 1b2a9ec82099 ("drm/panel: simple: Add Raystar RFF500F-AWH-DNN panel entry")
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c95964ba25a9..70e37ff12c9e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4354,6 +4354,9 @@ static const struct panel_desc raystar_rff500f_awh_dnn = {
 		.width = 108,
 		.height = 65,
 	},
+	.delay = {
+		.enable = 250,
+	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
-- 
2.43.0

