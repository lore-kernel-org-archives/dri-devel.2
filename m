Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BB3CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5747C10EE36;
	Wed,  6 May 2026 17:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20251104.gappssmtp.com header.i=@compal-corp-partner-google-com.20251104.gappssmtp.com header.b="GUbdAtoj";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A33DC10EE39
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:06:36 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c6dd5b01e14so2430753a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1778087196; x=1778691996; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xfuy1xBMV1sGnuWOt23z0KyBf259rOz6LYvKw/B3Eb4=;
 b=GUbdAtojWIglZjmS8BamNjMsxSMB1/ewojslEDZX19Kkev79cCkuRSl3nzYUlpjxcE
 P781UwYpY/OMSulj+6bQmtskjSnIamb1yxT5G/yw1EpGszP0PIs6gcByBhIcLyj+uUhJ
 1Fvl7c7MFBFJupinLU86yQ3A7qnrYpfBwpnvSWvgQHmv2Y4lin6uBRZUoDLz1Z2QAqiA
 WKyzBzD7ozF5dwPVPf7liV4MSkhjOD+SAb/Wdx/ODL94c4oUxnsA6EcomdaeM7aeySOx
 Jpw2xjn4UGPeTDgpil9iGlqKrRsum32oy8+nrmLTbEWJ/NV8PHm5d8P17Hpp1H2TQKOH
 L4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087196; x=1778691996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xfuy1xBMV1sGnuWOt23z0KyBf259rOz6LYvKw/B3Eb4=;
 b=QrTlSSMRfoVYmvwY06/6/enaKIyQGeQS/YVGVNXlhU4V7/DTzB8Lz3CHoQzWyFJHL7
 hOXZL3tpaqiqRIGOtRDcW2qOv8mfVgiigB2Ux4YW+C+7sHnBGGpfeeonUwjbSRjgHxBB
 u0FBohZ9jXtfyQIK8YfWahEpOeewyhRttnzyyze/fOLnHKkhP9SsgBEX/okG4sTaGOEc
 N7AJzuNysZB0vC1WagAT/wtXFZLosbVe5j1rozn17Magk5yym2Mml+HpvSqw+NklwFbk
 t0Ndzj8kZiVlQrXXGL1hd5EwRrAzVInZvYa3AKvIe6hfwxHG+wHAa/ipEftPIPoJWx0m
 RZPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BEpqKBuWPK+ldUivsaT/SL/GK/FDBlsn+88llxUiuOdnJycKARtMzHBR1qhstHhe1v8/TzVYuS5g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyaE9/phrovtIHx6qyw0VXprzGZN68hXt5cG0PXQX6X0+3Wuc/+
 dVZw6K3pYz58dPpnik4Wa9GEGU8rbJnuXUFbyLzoJZcfz+ZSHJBXDW56G9v+B/2Dv8c=
X-Gm-Gg: AeBDievYU26XPt6gHD4qvCpR5nG/a13O9b0udzGloqoLwpzcrrJhYZGjaN1eEconG2h
 a03lnmiq74znyJ4VaOA+rrA9PMuhe/HAv1z9MmcbANeZuQPmXy1zmM9dnQBfRF/U89E//ixpiAb
 A7stKnqOb5YokrYqFGFb2K9NiZApJMsRP+pZAtONAsMdkjpis9GG8HG9udqA/fRFKINzFJG78KK
 PjgdhRNkXb2Di2AkmPSELSfcKJ/mxmH215Qe2G0ZBomHPoO5zqnpGusIpKXQvq8d7fKSfUwyuSr
 nHz4/UOjSCBI+a8/9XXB8bs8bIkk01Kjzo1D+Q16/Fd7xMaIjUdom3sOD12Z3RkTFDIU/TBQoZl
 0OoDrE7GeVDEPvXE4NlVfKSZ0pfm6/YZf1+E0PGJM4mWDMAWB8yBlhCTmdRTGOphMpszockU2YZ
 zLePe2XqgLpp4TAVI7XO/vVajduFwTKJz0DCoRYome8vfx7BVv6Jpcu1AE/xtHIAg7pigXwL+bP
 YVKF7JlLsSGnaqiajD5dw==
X-Received: by 2002:a05:6a20:9185:b0:3a1:90ef:7e31 with SMTP id
 adf61e73a8af0-3aa5ab7b7damr4492879637.54.1778087195995; 
 Wed, 06 May 2026 10:06:35 -0700 (PDT)
Received: from terryhsiao-Latitude-5490.. ([150.116.253.88])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8242ab8bf4sm2649096a12.4.2026.05.06.10.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:06:35 -0700 (PDT)
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
Subject: [PATCH v1 3/4] drm/panel-edp: Add CMN N116BCN-EA1, CMN N140HCA-EEK,
 IVO M140NWFQ R5, IVO R140NWFW R0
Date: Thu,  7 May 2026 01:06:06 +0800
Message-Id: <20260506170607.10813-4-terry_hsiao@compal.corp-partner.google.com>
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

CMN N116BCN-EA1
00 ff ff ff ff ff ff 00 0d ae 69 11 00 00 00 00
0a 24 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 88 1e
ae 00 00 90 10 00 00 1a 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0c 3d ff 0d 3c 7d 07 0a 16 7d 00 00 00 00 2e

CMN N140HCA-EEK
00 ff ff ff ff ff ff 00 0d ae c7 14 00 00 00 00
2f 23 01 04 a5 1f 11 78 03 28 65 97 59 54 8e 27
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 36 36 80 a0 70 38 20 40 30 20
a6 00 35 ad 10 00 00 1a 24 24 80 a0 70 38 20 40
30 20 a6 00 35 ad 10 00 00 1a 00 00 00 10 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0c 33 ff 0f 3c 96 0c 09 16 96 00 00 00 01 76

70 20 79 02 00 25 01 09 1c 1e 02 1c 1e 02 28 3c
80 81 00 15 74 1a 00 00 03 01 28 3c 00 00 00 00
00 00 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 12 90

IVO M140NWFQ R5
00 ff ff ff ff ff ff 00 26 cf d5 8c 00 00 00 00
00 20 01 04 a5 1f 11 78 0b 05 f0 97 57 54 8f 28
23 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 9c 36 80 a0 70 38 28 40 18 30
5a 00 35 ae 10 00 00 19 68 24 80 a0 70 38 28 40
18 30 5a 00 35 ae 10 00 00 19 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0c 33 ff 0f 3c 96 0a 0b 1b 96 00 00 00 01 6c

70 20 79 00 00 25 00 09 ff 21 02 ff 21 02 28 3c
00 81 00 09 68 1a 00 00 01 01 28 3c 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 af

IVO R140NWFW R0
00 ff ff ff ff ff ff 00 26 cf e6 8c 00 00 00 00
00 20 01 04 a5 1f 11 78 0b 24 10 97 59 54 8e 27
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 38 36 80 a0 70 38 20 40 18 30
3c 00 35 ae 10 00 00 19 22 24 80 a0 70 38 20 40
18 30 3c 00 35 ae 10 00 00 19 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0f 3d ff 0f 3c 7d 16 11 22 7d 00 00 00 00 24

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 5b417626c9a5..427a4b4c6712 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2056,6 +2056,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1160, &delay_200_500_e80_d50, "N116BCJ-EAK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1161, &delay_200_500_e80, "N116BCP-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1163, &delay_200_500_e80_d50, "N116BCJ-EAK"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1169, &delay_200_500_e80_d50, "N116BCN-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x117a, &delay_200_500_e80_d50, "N116BCL-EAK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x124c, &delay_200_500_e80_d50, "N122JCA-ENK"),
@@ -2066,6 +2067,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1468, &delay_200_500_e80, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x148f, &delay_200_500_e80, "N140HCA-EAC"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14a8, &delay_200_500_e80, "N140JCA-ELP"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14c7, &delay_200_500_e80, "N140HCA-EEK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d4, &delay_200_500_e80_d50, "N140HCA-EAC"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
@@ -2103,6 +2105,8 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854a, &delay_200_500_p2e100, "M133NW4J"),
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "R133NW4K-R0"),
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x8c4d, &delay_200_150_e200, "R140NWFM R1"),
+	EDP_PANEL_ENTRY('I', 'V', 'O', 0x8cd5, &delay_200_500_e200_d10, "M140NWFQ R5"),
+	EDP_PANEL_ENTRY('I', 'V', 'O', 0x8ce6, &delay_200_500_e200, "R140NWFW R0"),
 
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x044f, &delay_200_500_e80_d50, "Unknown"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
-- 
2.34.1

