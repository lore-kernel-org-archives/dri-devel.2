Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5958ECD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9115E10E9B9;
	Wed, 17 Jun 2026 10:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=huaqin-corp-partner-google-com.20251104.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20251104.gappssmtp.com header.b="JOTeAWI6";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BADA10E9B9
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:11:08 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-13988680a69so3545846c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=huaqin-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1781691068; x=1782295868; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mHvICy4UZ/hMOih4gskMgFhyoibokv0BZdvuT9p1JE8=;
 b=JOTeAWI6dl2pjfjr8kbntKZ+S3a7tePBuZTFAugk4RR9n5qKql6Pi8P3l9OBumgA5i
 FfyFWDfMUS95cBQ9Tg1ILB7Jk8Y5XNB1AnWA6eXtVvSCQFqI5cDXnlYruGnHvtTtQizA
 0cjFHax/q9M0bXdNnbJlOpUyg3Moar9yvDh3+icrXMMMEL4HXmPw50Kuuc3gpi9xbZlS
 6VOG0PeV5y93yNvatG+VkS9REkyh0I32spzWExO4YjCfvfaYDFJD+sq46rEJP9fd0T2B
 qVryr8zf0pKUlZcm7X/qucYv8X28JRmwpZOQHGReGdWR20V7Zx3vU604QBeiNMyo06nN
 bvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691068; x=1782295868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHvICy4UZ/hMOih4gskMgFhyoibokv0BZdvuT9p1JE8=;
 b=sWcYM7vvUkc13dhWRA0OforNm+FVTMSqArHp0xtvy44pwrEF9pBPX0uNLkyii/1wqP
 IkAKFOoY6/DxqgQo72sIWLXUsEXvQ8X/rFp+AqtUdJiJJSp4dQCwwUOQYVyUk8GAUVFU
 8B/fWzmQ/+IeXWLPva2yZmvrScSCSf+Q9TEPLbwe/Am6iCQxQan+bSOCegA72ik5n/6/
 Ng4Q6fLAmK1F0l1K4Ozei+gmFH2PjwbOnB9O0VUCIeIfjxfjxWztd3up/he237sjZyj7
 2UC+H7hRTcw1e6ZgdrNwe9Ke9ZkAkGeqUkk/TP6HFyJ43KisTg2yLrrnXpp4bpfNtR2U
 RxyQ==
X-Gm-Message-State: AOJu0YyQAlkAdRWB+65Wj0B9Yoh6lX+vlsnPJSUDEqqFMeHb85iTN7Uo
 KyTcJLfwVEs8Fm0qYYI7Zwd43OmpZZuigY6vNooyifABAIAFERVvveiUMoHZP4MOLng=
X-Gm-Gg: AfdE7cmA/cM6nFOfEqoUXe2DaSy9LMpZ3SM4kXhqU3+pXFB+YYl802xJ4w3JCnL4iSP
 cRj2PRx5rWK/zekXpwmmnFyWB3lJwe+NhUF4L8iB6KxQ7ep6aP3zxn2KgFOMSzivBjhr64Ym2sz
 ErRHg2ZuIW5JCnYCloNKQlA/5OFUT+rp2vQe8sVx1LS41djPB1ahcNGM4Xkv/e1l2MH1Si/abGS
 C/Hg3aItaiN2sOINnRKmK8emSNf4C8cxkhznu17lGMeN4qE77JVzFrBU+2Nkr5XKJMt4U2ksl9r
 ysLMTC5Ek8CROCellKZGFMTL8+NwV4ensMPnR/kYVHBsU7RQ5djZXBXodlmnFotwU/TOUCfH2dr
 cQzdKVU5+zgbzwUw+vX8C1ldRfln4k6kMzxPQbOA5+Mnt6VvQ3i23fnQYABIrgIrrWgFjD3+UJK
 AI8qYBMzFBrYx8VvCo8N6WOBn1I32To3IIObZr24pGX4q7mcp5Kuop3r+8KR/995U=
X-Received: by 2002:a05:7301:7c0e:b0:307:91f5:9377 with SMTP id
 5a478bee46e88-30bc9ab99b7mr1684818eec.9.1781691067658; 
 Wed, 17 Jun 2026 03:11:07 -0700 (PDT)
Received: from zhk-CBG100025892.huaqin.com ([103.117.77.121])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e91f878sm22176339eec.17.2026.06.17.03.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:11:07 -0700 (PDT)
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, airlied@gmail.com,
 Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Subject: [PATCH] Support new NV140FHM-N5B and TM156VDXP25 edp panel
Date: Wed, 17 Jun 2026 18:11:01 +0800
Message-Id: <20260617101101.3474684-1-zhouhaikun5@huaqin.corp-partner.google.com>
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

the NV140FHM-N5B need 200ms delays from the backlight on to valid data,
100ms delays from backlight off to valid data, the TM156VDXP25 need
100ms delays from the backlight off to valid data.

NV140FHM-N5B raw edid:
00 ff ff ff ff ff ff 00 09 e5 98 0d 00 00 00 00
10 23 01 04 a5 1f 11 78 01 c8 d5 95 5d 59 94 29
23 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 94 37 80 a0 70 38 3c 40 30 20
36 00 35 ae 10 00 00 1a 76 2c 80 a0 70 38 3c 40
30 20 36 00 35 ae 10 00 00 1a 00 00 00 fd 00 28
3c 44 44 0e 01 0a 20 20 20 20 20 20 00 00 00 fc
00 4e 56 31 34 30 46 48 4d 2d 4e 35 42 0a 01 87

70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
00 00 53 ff 53 ff 3c 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 90

TM156VDXP25 raw edid:
00 ff ff ff ff ff ff 00 51 a1 39 21 00 00 00 00
0d 24 01 04 a5 22 13 78 03 6e 95 99 5b 58 8d 28
21 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 af 2b 80 a0 70 38 28 40 30 20
36 00 58 c2 10 00 00 1a 00 00 00 fd 00 28 3c 43
43 0e 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
00 54 4d 31 35 36 56 44 58 50 32 35 0a 20 01 ef

70 20 79 02 00 21 00 1d 72 0d 90 07 80 07 38 04
80 95 69 5b 8d 95 8d 87 42 21 02 35 54 b0 5c b0
5c 00 42 12 78 22 00 14 ff 21 02 85 7f 07 9f 00
2f 00 1f 00 37 04 27 00 02 00 05 00 2b 00 0c 27
00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
b0 5c b0 5c 81 00 1e 72 1a 00 00 03 01 28 3c 00
00 53 ff 53 ff 3c 00 00 00 00 e3 05 04 00 e6 06
00 00 00 00 00 00 00 00 00 00 00 00 00 00 90 90

Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 81e1866d54e78..3e6d8f17c3072 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2010,6 +2010,15 @@ static const struct panel_delay delay_80_500_e50_d50 = {
 	.disable = 50,
 };
 
+static const struct panel_delay delay_200_500_e50_po2e200_d100 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.enable = 50,
+	.powered_on_to_enable = 200,
+	.disable = 100,
+};
+
+
 #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name) \
 { \
 	.ident = { \
@@ -2144,6 +2153,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d45, &delay_200_500_e80, "NV116WHM-N4B"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d98, &delay_200_500_e50_po2e200_d100, "NV140FHM-N5B"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153WUM-N42"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ddf, &delay_200_500_e80, "NV116WHM-T01"),
 
@@ -2250,6 +2260,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, "TM140VDXP01-04"),
 	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e50_d100, "TL140VDMS03-01"),
+	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e50_d100, "TM156VDXP25"),
 
 	{ /* sentinal */ }
 };
-- 
2.34.1

