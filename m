Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12E6CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7B510EE12;
	Wed,  6 May 2026 17:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20251104.gappssmtp.com header.i=@compal-corp-partner-google-com.20251104.gappssmtp.com header.b="qLWug8bz";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36BAB10EE32
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:06:33 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso3298595b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1778087193; x=1778691993; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHV8oeiERbLzMWnYOO79/N9N1K6pff1TsJQjg4oGA58=;
 b=qLWug8bzyqDDQIhcKwV8dBpj1DSLOtOLm7yay5bSu3jkM7EanotzpvFwYbkd06AYPo
 /3601+vdC/hR/jnP+UDoea6V80Sr/WG3H9FRNEP7Jjv+S6OFqOi3kfXvzdWhOR1fNFQf
 Jj5niP0PFb1GRH0YffCupjvEVSiA3GwxngZAM7S3s4mf3hWcQFRv2Q8j0WeJPT+tDmtw
 Db2jMgspohp6ypmaPG4RMUQzmNv0y7Yb9aImkJDovfL/fwGX8vD2CB/5QVJq2nkYM8qC
 BgUJJyUEQ83A6Gdo9fV+aDIxqybFEr1N2zVF2RnL+zOGhcz2ymPAIAaNzFeQy75ppLf/
 rSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087193; x=1778691993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rHV8oeiERbLzMWnYOO79/N9N1K6pff1TsJQjg4oGA58=;
 b=LdXK0htIKUCwgkKDeax3Frxq+nZ+e+vR9Va5iIgCITkEUzTqeeB2y6Hqfd2B+HQlBB
 cC1zaamp4k/gb6OIp94BWSVG7rK+vGMrivC5zn9YpPOXQSvTnAhDcU+WLN4QaU2IAMZC
 YRpr+7YMSYLOjzchA2DeoRm4DXXXncIRG7KSVqgdrTKAXEm4EzE0ELYcTQgJpOgR+Vm1
 ofqhRk9CrlpfC/3VLKrybDmewMAnClUtCuib0Mf1Me0fkbhmVwuD3oVxy6K+LTJH6ES+
 l6hQ3vxL+NwSOeQaRoGxKm+hM992umJGvlrRJF6j53d/2mc9Mixd4vHMXUvA97YcPIk/
 oBhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fQL9h3QbNMllJfgI4dkR/T1ZXSxZycdTs8VsE2bCq3rpUFBmoLuU389f1E4FtzS5DC3WInx3zX+w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyibXp1FXeklQGhC2PLhSwZuRasYOVnSWG/EbPNS7/ZpATIpX9l
 ASnACIRNAWBzSnK+ZnI0WOluldGZUr7Zr78ujHAIlHajHIUHT4zzSSZt8NgHeP5cs64=
X-Gm-Gg: AeBDiesjAsdddGj18jgpy1B8YAHSOROf1auRJEgeMgNhl9heLylaokpb9Uf9N49/A6U
 +dp4bsZFkbs8IDlZXZpwHoJynU89OUA7g86z+pGSm4J8xZUwUs0VTXL93yqCkDlatUph6U2c509
 WMre0DOHXDVRRbc4jPZVgX6pkf5pCS+4H0cG4/LjW/w/ZWaVHbVaqUV8UOFTBfc8hWDGrH63Unc
 sH51s6i/BIbWPJPV2ANQkKsxB0knvB0LCwKkfj2BOVGw503SoCVZ4nTYftZMmHWIHuVyZIyMjYT
 et3t8FxDywMKG3rc51Fe3Mttr9mc1+w1r/rOhhQvOiJJRLahezVUAYewIFJeIF0YneMLBWsZSx3
 dyonnU2x2IxQxokvLmDaaobgj82pldMOOjt0vTfbFKqIinY/7uBBjjCqLL3x515YyrqFwoMuL5A
 eK0yN8fQ7PM1Jvh/WKO9XnLsFIaZXTz58mtJu7jRAelW4CQV8ZGTCqdmByzWrchMRfAWAq8gTFC
 CwImyOPJoO57ipUcDSPAQ==
X-Received: by 2002:a05:6a21:99a9:b0:39b:dea7:5626 with SMTP id
 adf61e73a8af0-3aa5ab7170amr4637242637.35.1778087192350; 
 Wed, 06 May 2026 10:06:32 -0700 (PDT)
Received: from terryhsiao-Latitude-5490.. ([150.116.253.88])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8242ab8bf4sm2649096a12.4.2026.05.06.10.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:06:31 -0700 (PDT)
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
Subject: [PATCH v1 2/4] drm/panel-edp: Add BOE NT140WHM-N4T, BOE NT140WHM-T05,
 BOE NV140FHM-N40
Date: Thu,  7 May 2026 01:06:05 +0800
Message-Id: <20260506170607.10813-3-terry_hsiao@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506170607.10813-1-terry_hsiao@compal.corp-partner.google.com>
References: <20260506170607.10813-1-terry_hsiao@compal.corp-partner.google.com>
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

BOE NT140WHM-N4T
00 ff ff ff ff ff ff 00 09 e5 0d 09 00 00 00 00
01 1e 01 04 95 1f 11 78 03 f8 45 96 57 54 92 28
23 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 a9 1d 56 d0 50 00 24 30 30 20
36 00 35 ae 10 00 00 1a c6 13 56 d0 50 00 24 30
30 20 36 00 35 ae 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0d 40 ff 0a 3c 7d 11 11 21 7d 00 00 00 00 65

BOE NT140WHM-T05
00 ff ff ff ff ff ff 00 09 e5 85 0b 00 00 00 00
01 21 01 04 95 1f 11 78 03 ea a5 93 5c 58 8f 29
1d 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 c7 1d 56 e2 50 00 1e 30 30 20
36 00 35 ae 10 00 00 1a da 13 56 e2 50 00 1e 30
30 20 36 00 35 ae 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0d 40 ff 0a 3c 7d 11 11 21 7d 00 00 00 00 4e

BOE NV140FHM-N40
00 ff ff ff ff ff ff 00 09 e5 6f 0c 00 00 00 00
19 21 01 04 a5 1f 11 78 03 21 35 97 59 57 8f 29
23 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 c2 37 80 cc 70 38 28 40 6c 30
aa 00 35 ae 10 00 00 1a 2c 25 80 cc 70 38 28 40
6c 30 aa 00 35 ae 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0d 36 ff 0a 3c 96 09 0a 19 96 00 00 00 01 57

70 20 79 02 00 25 01 09 8c 2d 02 8c 2d 02 28 3c
80 81 00 10 6f 1a 00 00 03 01 28 3c 00 00 53 4a
53 4a 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 e4 90

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index d883399bff3e..5b417626c9a5 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1995,6 +1995,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x08b2, &delay_200_500_e200, "NT140WHM-N49"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0848, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0849, &delay_200_500_e200, "Unknown"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x090d, &delay_200_500_e50, "NT140WHM-N4T"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09c3, &delay_200_500_e50, "NT116WHM-N21,836X2"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x094b, &delay_200_500_e50, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0951, &delay_200_500_e80, "NV116WHM-N47"),
@@ -2021,8 +2022,10 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV140FHM-T09"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140FHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b66, &delay_200_500_e80, "NE140WUM-N6G"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b85, &delay_200_500_e50, "NT140WHM-T05"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140FHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c26, &delay_200_500_p2e200, "NV140WUM-T08"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c6f, &delay_200_500_e50, "NV140FHM-N40"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf2, &delay_200_500_e200, "NV156FHM-N4S"),
-- 
2.34.1

