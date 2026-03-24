Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A588CF532E6
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 06:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1467B10E0D7;
	Tue, 24 Mar 2026 06:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="HTgAomTU";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112ED10E0CF
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 06:14:51 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c06cb8004e8so1650406a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 23:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601;
 t=1774332890; x=1774937690; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wOsKkrPZxAVVoUGj9NknOFapZSu84QSPGRYGWvY3NUU=;
 b=HTgAomTU33Mo0Vrdj9FfVIvBkBq3CkJviT7RCC+fNX9xMcDrK57r+TVsZic4NvY7Y1
 ykfW3AaeZAtXfq8Saxj2R8UPN/PCDmu1jLHmenyfj4zFEIccl5adNdQDf178CDKn435e
 IZXLrqzYyi9azge5bCoce0zYLV3BFJPWa5cD8GblxFZmMLlAgy27H0if47CvltEloeYt
 dGn0m8N+JE0vtYEOyvCe8cAGynPqGnCC55i2vjHr6JJjRwtTL2YUYgDBp5YPll/FMoMc
 D15dihFWhThc1J/z1lhPmnYABogkgAdjm9VIg0GmhKEWRDjkqoorxP+GSTU1T9+3glAB
 lb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774332890; x=1774937690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOsKkrPZxAVVoUGj9NknOFapZSu84QSPGRYGWvY3NUU=;
 b=K2/F3v0Bls92bIwnNNe1j21lyNpICeeNiqQpqd+NaYLdTxyTofEs2YW7E4/0JLVphp
 S9asmdCj3DZKM1fg1Oeg9m02bcO4+lSGmWEMsrnj0cwrJnEReIhLoZwvjasK8BLJ5DG/
 2f75Iu9HF2Y4kRwa8kMWwErrSBGG+iYSyTYszWP6ze9YfW+6Xzx5U7s0lpdO8TsKpTdA
 QhMxQoN+pkB7XXlEDDlA/6cjB6EzutZnC32Wf+N31I8LLYn3n10pCpi8bQBf1aFTrDK9
 boAZmM8sukpU3sWDLWWn/zoJBkRESQcxPC7AqOHW+sir9uZ3uIwEeiXgT5gOJZz9a/ze
 juFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfSiY/cIwGOlULnQaHepzxlXmMXgjoJIXztkqIwoDgB80nYT5x2qYSxSCdSYbhCsb6bx0Dg++IwrA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPsW/GPrj8PjpcUDseji3IpJ2GfjymkZZbXyM+Sb8qfRVvr39v
 /sFQbw6WoPgsOdOGhzqbtzUF0Hd/xsR98CBVYGbnSScnawdcf/TwJ9p1Xv1Ig0IKjrs=
X-Gm-Gg: ATEYQzxu33xnuUmj37++X42cmcrTSMYONevH/K+1bHYGUPeQjB8ts+HEjsFG8LhdpGC
 lhHMwPddNn9XCezRyRdqfR/4pPIndhw5vLju+D0CH0juFf37VG2qnsLvZd3kaRE/rW+Cdxhei6G
 Sqaz/jOlCBNOG9FpRZlk6ShtK7zuGRT/Evq9wG8rzQf16zrZpaqoSYSB3BPZ40rgStT/YNKzDmB
 /GTJ2FopMex2TotAIccXuDaNfdwzFBLSZhgcyEjJNnvphOgEKMauEQ2xd4sS3I4hK2IJBqYIct9
 0OK0Fb/NKPJKhqbJh97RRoF1Jy9rGT4teudM4KiszRKi8vgVEzQUxfP+m1HRJ/dx3/tfUhGukpL
 MG0vIyDzO3jhYxt1JreC8xxm7kZsOrw1Rx0EqBYlMqDUz/+20Uta8qXOFBL4iM778kuwBDVW9l7
 uHFYU4DWILiO2MVrdnZYPI9uW1/bbSGSQ4EbqtPCBkhRIUyXU+2pU3HeON0+q9uSgGEDRYWmoN0
 PdpziShKO6rxbVb01ZvfakNUb3OGfOvoZg7m5CJXPl51Vc=
X-Received: by 2002:a17:902:ce0d:b0:2b0:489f:84e9 with SMTP id
 d9443c01a7336-2b0826c668dmr141884835ad.7.1774332890521; 
 Mon, 23 Mar 2026 23:14:50 -0700 (PDT)
Received: from terryhsiao-Latitude-5490.. (36-231-133-75.dynamic-ip.hinet.net.
 [36.231.133.75]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0836b97fesm128087805ad.84.2026.03.23.23.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 23:14:50 -0700 (PDT)
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
Subject: [PATCH v1] drm/panel-edp: Add 2 panels used by MT8186 Chromebooks
Date: Tue, 24 Mar 2026 14:14:44 +0800
Message-Id: <20260324061444.242917-1-terry_hsiao@compal.corp-partner.google.com>
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

The raw EDIDs for each panel:

CSW
- PNB601LS1-2
00 ff ff ff ff ff ff 00 0e 77 0a 11 00 00 00 00
30 23 01 04 a5 1a 0e 78 03 a1 35 9b 5e 58 91 25
1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
36 00 00 90 10 00 00 1a 06 14 56 dc 50 00 28 30
30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0c 3d ff 0c 3c 7d 0e 0b 17 7d 00 00 00 00 e8

LGD
- LP116WHA-SPB1
00 ff ff ff ff ff ff 00 30 e4 fe 07 01 01 00 00
00 24 01 04 a5 1a 0e 78 03 72 e5 9c 5e 5b 94 27
19 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 d5 21 56 a0 50 00 b2 30 30 20
f8 0c 00 90 10 00 00 1a 8e 16 56 a0 50 00 b2 30
30 20 f8 0c 00 90 10 00 00 1a 00 00 00 fd 00 28
3c 39 39 09 01 0a 20 20 20 20 20 20 00 00 00 02
00 0f 3d ff 0f 3c 7d 0d 0a 15 7d 00 00 00 01 da

70 20 79 02 00 25 00 09 57 52 01 57 52 01 28 3c
80 81 00 15 74 1a 00 00 03 01 28 3c 00 00 4a 5a
4a 5a 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 ef 90

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 497dcd48f57b..7d80524a9406 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2072,6 +2072,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1100, &delay_200_500_e80_d50, "MNB601LS1-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, "MNB601LS1-3"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, "MNB601LS1-4"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x110A, &delay_200_500_e50, "PNB601LS1-2"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, "MNE007QS3-6"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x144b, &delay_200_500_e80, "MNE001BS1-4"),
@@ -2119,6 +2120,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d200, "134WT1"),
+	EDP_PANEL_ENTRY('L', 'G', 'D', 0x07fe, &delay_200_500_e200_d200, "LP116WHA-SPB1"),
 
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
-- 
2.34.1

