Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5F4CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A31310EEA0;
	Mon,  8 Jun 2026 08:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20251104.gappssmtp.com header.i=@compal-corp-partner-google-com.20251104.gappssmtp.com header.b="LprdINzP";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FED10EEA4
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 08:03:22 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-36b9ec98144so2951831a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1780905802; x=1781510602; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYHtyZ0Rvc25G+nmtl44gJI8hcvVDuFNjrSzwAekyew=;
 b=LprdINzP1fLFHATekkRZmzp2lqfeF0SdyJerUYyMIEsNaXD6LnWjv/SROp2hK+kSYM
 3/uIBJPTcf/gREx8ulkcwwoeQWsOaPatdzsRzvZ6S+cduO13uzNlXFCSTJjFVgoJ5tnR
 945I7d+YSuKLwLN7NRnrQMXQ4Y3OPDFCmJ7RDoNFwpr6Bi3fpj6JGHC/907OJ9z8Fg8s
 LBL/3FyVIqEuA9up1EbgKmjamAkYmujnMOPzAZUeejzHvoa7Wn85TkKXzR7mDmg0E0x1
 vTo31cyBknqnpZDWDooklcNHryfsOSTx05yeqhV8o1oY6wSC9SfCvrm6bRIkrmsaEaPv
 +dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780905802; x=1781510602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nYHtyZ0Rvc25G+nmtl44gJI8hcvVDuFNjrSzwAekyew=;
 b=i/rya1DAYjfhwrspE2M1XeShP/a4rAUWj/o7EUMwgn4zbkWDqX1ZqYdWV5xLwlgn4m
 XAgwM4bxWBMtxlSJwqcnz6VTMHgzkvgzW/Kp+QmQw8CUxO969tVTnzfHWfoMcHQUrNYw
 XWRzdoW6e7riUSKMD7fnRIWYGg5UJt+aYy1R7h88Mk98emPIMqkfAE7pH0nTCl+y+rid
 M2evLZ21c+3ldFShpUxZs5AA+u8CGw2Bi7Vp5H1bG9vmmPe0y3AT4hpu35Ip86haxXMl
 coFiJPGgkFwzvkDJCC88z3xas3MH4Ln5aEhyAv1sT+vd5zCVeEpi81aiqBLEX0b4zm+B
 yUlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oM9of2RHS15bRPvl6rD5l0c07vJu6ec0cX5PTRUjMZ3UTSrl0TY7ETo/cb17tRb4tKQLyvx2W2pI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKYcjo7aOOUkGsGZY6EUOvnzm1TTJkvF4Hn4HRHmKqKQYI7X7u
 ay7N6YtBIbAuirwoV3kndKoyoI8qCwyd47cxYJy39eJ0x3tkS2xMpgjzDwXtr8IDtA8=
X-Gm-Gg: Acq92OFGZWZ65JaOZGiM0Lg6eEkF13uaRSY99ghUF5kbxPqIQmMr206QhsJRsC831BA
 EQldjnChT17uVftMWdxB571mjRjnlsElu2RTesGZCNXVOrEwDNjpVL19hmV6UxhxLurTD1ZSBnH
 +/v5BNdnX1cpiZesFG3PheJkz6mrINAgyq6mCwD+SkvR6eG/xr5JHo+lPTsuB797wkiQwuepBRp
 7Ji0KcTye/rGmAQ7qEgg3zl/79ToWWtUKNq9iEVIqU2CyDO2SybHR8HNzNpxw8YTjRs1RtOrpLw
 rOHV2EDC3IPJVLhxLFIsS5mCTaoL9c9XG39rGrZws/darf89c7hRVSfAM/onbR1MKgAu5mxI2RY
 uaXCd5M76tsqQwRGf2SSrRzvImczf5WUdUSOey+BbXerNIAPK8gwVZM53KGF4rye0SZoksZqjXS
 tilavDk7gkMkBKF79FNVMKiFjXZaEhgh348IW/x9HBE73eFauu/jfY70LWgPSdHeHlSlqDOZyl1
 l4JuCqaj1pL/OS2vsxPEjCcI468LL8PrketJrlKk9HKAkY=
X-Received: by 2002:a17:90b:3fd0:b0:36d:cf58:b79 with SMTP id
 98e67ed59e1d1-370f0e4b14amr14642697a91.19.1780905802309; 
 Mon, 08 Jun 2026 01:03:22 -0700 (PDT)
Received: from terryhsiao-Latitude-5490.. (36-231-165-24.dynamic-ip.hinet.net.
 [36.231.165.24]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f68b03ef6sm15262168a91.0.2026.06.08.01.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 01:03:21 -0700 (PDT)
From: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Subject: [PATCH v1 1/2] drm/panel-edp: Add AUO B116XAT04.3, CMN N116BCP-EA2,
 CSW MNB601LS1-8
Date: Mon,  8 Jun 2026 16:03:09 +0800
Message-Id: <20260608080310.15126-2-terry_hsiao@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608080310.15126-1-terry_hsiao@compal.corp-partner.google.com>
References: <20260608080310.15126-1-terry_hsiao@compal.corp-partner.google.com>
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

The raw EDIDs for each panel:

AUO B116XAT04.3
00 ff ff ff ff ff ff 00 06 af c0 29 01 ff 00 00
00 24 01 04 95 1a 0e 78 03 9e a5 96 59 58 96 28
1b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 ce 1d 56 ea 50 00 1a 30 30 20
46 00 00 90 10 00 00 18 df 13 56 ea 50 00 1a 30
30 20 46 00 00 90 10 00 00 18 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 10 48 ff 0f 3c 7d 0d 0b 16 7d 00 00 20 01 d6

70 20 79 02 00 20 00 0c 10 d8 b1 c0 29 00 00 00
00 00 1a 00 21 01 1d 01 0a a0 05 56 05 00 03 88
68 59 59 8d 85 96 87 62 1b 02 35 54 00 80 00 80
00 80 11 78 22 00 14 0b 2a 01 84 55 05 e9 00 2f
80 1f 00 ff 02 19 00 03 00 05 00 2b 00 0c 27 00
28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 80 00
80 00 80 81 00 15 74 1a 00 00 03 01 28 3c 00 00
80 2b 80 2b 3c 00 00 00 00 00 00 00 00 00 2e 90

CMN N116BCP-EA2
00 ff ff ff ff ff ff 00 0d ae 6d 11 00 00 00 00
02 24 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
a6 00 00 90 10 00 00 1a e7 13 56 e2 50 00 20 30
30 20 a6 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0c 47 ff 08 3c 7d 0d 0a 15 7d 00 00 00 00 04

CSW MNB601LS1-8
00 ff ff ff ff ff ff 00 0e 77 0d 11 00 00 00 00
13 24 01 04 a5 1a 0e 78 03 a1 35 9b 5e 58 91 25
1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
36 00 00 90 10 00 00 1a 06 14 56 dc 50 00 28 30
30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0c 3d ff 0c 3c 7d 0e 0b 17 7d 00 00 00 00 01

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index aa27d6cd932e..44922896e743 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1934,6 +1934,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B116XTN02.5"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x29c0, &delay_200_500_e50, "B116XAT04.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x30ed, &delay_200_500_e50, "G156HAN03.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x3c9f, &delay_200_500_e50, "B140HAK03.5"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B140HAN04.0"),
@@ -2060,6 +2061,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1161, &delay_200_500_e80, "N116BCP-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1163, &delay_200_500_e80_d50, "N116BCJ-EAK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1169, &delay_200_500_e80_d50, "N116BCN-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x116d, &delay_200_500_e80_d50, "N116BCP-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x117a, &delay_200_500_e80_d50, "N116BCL-EAK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x124c, &delay_200_500_e80_d50, "N122JCA-ENK"),
@@ -2086,6 +2088,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, "MNB601LS1-3"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, "MNB601LS1-4"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x110a, &delay_200_500_e50, "PNB601LS1-2"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x110d, &delay_200_500_e50, "MNB601LS1-8"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, "MNE007QS3-6"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x144b, &delay_200_500_e80, "MNE001BS1-4"),
-- 
2.34.1

