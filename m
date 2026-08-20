Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21A6C5DF88
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 01:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A89210E114;
	Thu, 20 Aug 2026 01:31:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=huaqin-corp-partner-google-com.20251104.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20251104.gappssmtp.com header.b="pGWZ00kL";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C6610E114
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 01:31:10 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so19358605ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 18:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=huaqin-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1787189470; x=1787794270; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sf8/1y/BvE8Q5udXvIgVW5M9y1VSk6Oq+FeF32W6vPI=;
 b=pGWZ00kL+rtaBqLVdYLdBrXBtuekziUTy3ld5iVmZpa8MVEEQu7QVlG5PtzRhoIyX4
 DWGXN8wFlmJgAqJD+8JYXtAjXJiWXWR+FBd+2wtaSiAlIHZOZBmexLQWhG058OtFS2jF
 siyg9R1ebseLDeRggPUXX+XunIwKBYU3S+1nNIZQVT/Iy0Ltywa8wW4BW9xIdwbUnQmv
 rP2/Kg/RDw0rwCbvL1WvFEP0K2/rD498WS8hTO9gEXv0cDVVENwPbgx0Wmw9qYVT3zRz
 NACQL8G5Ei/U2YYc5ZjLfNeqgsZhZipEc5zdioGTawsqorWrgdoeiocJNNuIc7BbMyWh
 lbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787189470; x=1787794270;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sf8/1y/BvE8Q5udXvIgVW5M9y1VSk6Oq+FeF32W6vPI=;
 b=BtM2qk/tv7Zf0JEgzgN1s938OVGC30RKeDoZeF5cNdbUyi2UGQLbFnu//bPiFRYkMK
 vPYQdIuQesJ4dTvxONtO9C0JeCr42eShQBq+aBrDHh9qeFznhUjo3oTHmXgc3Xegl9ED
 Sg7OMtRk/qR1xeHw1hgOMapQeOn13K8NhM5iY5a2E7175y06zRnFfOjWwVg8Ac9bL66b
 2ehnR6Ers3J6r9uHfaENlgISVr5nql99vI2Ac2y40oHm1lGItvkFc66Jc6Om5O1El7Ii
 HG7jxbQBYSsVppnYiLHjkFP/VfbUT+6Y+otYJe1RGWLS+JvsHVyArI5HwcAmPmirRsZ9
 VIHA==
X-Gm-Message-State: AFuF++ku40tGZSU7t7ueEUqorly2p3CEAMkoumOTemLEMU2VOucGO39Z
 4AK9PRwLXVBWyDiSTJ5EvWaeQXHujXoOd6VGMQLYgSH5xAYeMckh+3T+LyB+vUFio/g=
X-Gm-Gg: AR+sD10vGa/JIWTcH4wqsjTvbjj+V1eNEmHsVJWKtgDVXACQJCXCVNxCBc13brpalb4
 +wgajLaepNjBouAdlBsRyM7u/lvmK8gZ3S6vCEOGYke09zD28OQjr9Kwk64/Jc/x2CtEyp3lyEA
 +L0BL3EZOsId+DDKcYyK5CUYxLu7kaU/cQxcDUnjR2mJjJgHOoL2xjpDxsuUKneRN1KlKHUIZJq
 AzyM4BXKplkGhgelXRCa2ASWilybyaitHgt3uhSI1yeHXS3u3yYx4j/BIne2pYiEqYf1/2D/Ppq
 LS2+sWMXzq+J4h4Xk4bVw5WT8pBllS3twWgK9cp5HqrtMmduSWW0AcjkwbJdm0DJfv5EUPcHoQM
 PwG643lrsFK0y9cywA1WTYnGYXsO8bzcuSQCj7FbKELaAhs1QYt0V+SoJaDhqCj9WnEmR+pZF8N
 00CHclNqAZu7juhu3FkE5rLjAfzpWEkAJ8O7LIvHY2A68dN6DOBoaQOCJtp0AeLnVZkE+tpMDkE
 gPB34AFFowAnIFw1t2hivoom2Jt5Tr7LwYcKkQ=
X-Received: by 2002:a17:903:40c9:b0:2c9:b396:1a55 with SMTP id
 d9443c01a7336-2d60197c4c5mr177873985ad.12.1787189469970; 
 Wed, 19 Aug 2026 18:31:09 -0700 (PDT)
Received: from zhk-cbg100025892.huaqin.com ([103.117.77.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62e3c27c7sm633575ad.70.2026.08.19.18.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 18:31:08 -0700 (PDT)
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, airlied@gmail.com,
 Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Support MNE007QS3-F and TM140VDXP15 edp panel
Date: Thu, 20 Aug 2026 09:25:54 +0800
Message-Id: <20260820012554.4038893-1-zhouhaikun5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
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

MNE007QS3-F raw edid:
00 ff ff ff ff ff ff 00 0e 77 87 14 00 00 00 00
0f 24 01 04 a5 1e 13 78 03 2c c5 94 5c 59 95 29
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 35 30 80 a0 70 b0 24 40 30 20
66 00 2d bc 10 00 00 1a 00 00 00 fd 00 28 3c 4b
4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
00 4d 4e 45 30 30 37 51 53 33 2d 46 0a 20 01 41

70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
80 3f 79 5c 9e 05 95 9c f2 1d 02 45 54 b0 5c b0
5c 00 42 12 78 22 00 14 8c 5a 02 85 7f 07 9f 00
2f 80 1f 00 af 04 23 00 05 00 05 00 2b 00 0c 27
00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
b0 5c b0 5c 81 00 1e 72 1a 00 00 03 01 28 3c 00
00 53 ff 53 ff 3c 00 00 00 00 e3 05 04 00 e6 06
01 01 53 53 ff 00 00 00 00 00 00 00 00 00 7e 90

TM140VDXP15 raw edid:
00 ff ff ff ff ff ff 00 51 a1 37 21 00 00 00 00
0b 24 01 04 a5 1e 13 78 03 2b a5 97 5b 57 8c 28
20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 24 31 80 a0 70 b0 3c 40 30 20
a6 00 2d bc 10 00 00 1a 00 00 00 fd 00 28 3c 4c
4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
00 54 4d 31 34 30 56 44 58 50 31 35 0a 20 01 dd

70 20 79 02 00 21 01 1d c2 0b 58 07 80 07 b0 04
80 71 69 5b 79 d5 8c 87 82 20 02 45 54 b0 5c b0
5c 00 42 12 78 22 00 14 3f 66 02 85 7f 07 9f 00
2f 80 1f 00 af 04 3b 00 05 00 05 00 2b 00 0c 27
00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
b0 5c b0 5c 81 00 17 72 1a 00 00 03 01 28 3c 00
00 53 ff 53 ff 3c 00 00 00 00 e3 05 04 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 90

Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 5784ba0618bd1..03e24f2a8a104 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2236,6 +2236,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MNE007QB3-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x147c, &delay_200_500_e50_d100, "MNE007QB3-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1486, &delay_200_500_e50_d100, "MNE001BS6-2"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1487, &delay_200_500_e50, "MNE007QS3-F"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1519, &delay_200_500_e80_d50, "MNF601BS1-3"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1529, &delay_200_500_e80_d50, "MNF307QS3-2"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x153f, &delay_200_500_e200_d50, "MNF601BS4-1"),
@@ -2288,6 +2289,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, "TM140VDXP01-04"),
 	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e50_d100, "TL140VDMS03-01"),
+	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2137, &delay_200_500_e50, "TM140VDXP15"),
 	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e80_pu100, "TM156VDXP25"),
 
 	{ /* sentinal */ }
-- 
2.34.1

