Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48790C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 03:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D61810E365;
	Mon, 29 Jun 2026 03:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=huaqin-corp-partner-google-com.20251104.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20251104.gappssmtp.com header.b="L9Yr2kZ7";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F12810E365
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 03:09:42 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8478cc93299so81310b3a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 20:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=huaqin-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1782702581; x=1783307381; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+mKWRwi7VVnmHKeoOR84v8PlpxewPuvyjTdT0ngmDho=;
 b=L9Yr2kZ7Uyu7vrqhVAw6C2F+mjG+rQZLPjN0BAjLerMNz9hZUjxjD8qheGFU47rvb1
 F1VfCXwVtC1Wz2GLe1fNU8/2u7rpCxv66MOm5SISqRV7nT77KCuauN2Ptl8cu1o4prjR
 ANABORa5pI9VkQ3oIRHH1sdBUCNIbN7JgEu51qZ5FfIDjCMDWDThIyQbga92zCEdoACM
 +IgIdxjDc2qGSSssYKVunpukANRnc84WpzaopF0jG6IYVPjRe+v4wWYLwYvJYBs+nMGW
 WD2M5z58f+Ewo7t+RotT41dKYBFQC61gaUCGlyYI6YcRaKtYx790Kf3NLCepZhqItWD1
 xaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782702581; x=1783307381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mKWRwi7VVnmHKeoOR84v8PlpxewPuvyjTdT0ngmDho=;
 b=YnHf8F1G/WHNXZBK9d+GO+O7AG2irboi6zh0XwVkiQy3NYVyYFuF1ZEmJWlINw+nOE
 +XpvS5s8VsaaDU3h2TGQUBCvJk6lvpqk5oP6OaCg726monXY7/YKqtWSO2F2VD+lx3dF
 kkAiWflPTfQzw+N4fdSfBw4KGyuJLOVASZ+nqrqsxYajuIXDr0i7h9jz5CXTVGiou0Bx
 laJJouZMCdF8PFkct9EsmDXD7Is22N4gKfqHEZ8E4g3afamxU252rclAS1NQoBEsIrqu
 gd9tGPL0OXcSXIaB++KMRL1mselwXwlakVMsapWvsavB3TOdwktzKdRLjjn36GmLiR7T
 LVKA==
X-Gm-Message-State: AOJu0Ywc3q7XJaqN6b94N6uD437ZksaOgL+zvTjOVp4LtGfhNgIPw9Z4
 qHANxIXIxEUHt90Yb200nY/DisZlCfsP9iovZd10IOTsFA0EV5An1qnJhP01LDo07BU=
X-Gm-Gg: AfdE7ckiIJ50A2M2vBlQ2b76C6e9juIXE1/0Oe4Mm8qPmv5gaSicsGy/jLN7G3YahQ7
 bsYMJH+sjmt28jcTAocNQayF58/Zh1fpL0LCRRU4mka/ohi/1eLgmduvaPpeL2UB4U/WtiHqKTB
 Lvnc/zEZl+xMVFZ4kj5pU05UYN2VWrnmlhs/clrGY+NtjFPw8Kx4eRwo3Xx6K43Wq32g5Kez7wB
 EqIveYU7g1Eng4hB7SjVKEM/rj0mP4z5+vWKl7eUZFiLxV6t6hlLnbZemPWTP4ZTsvlCy4g6efL
 4ZyakeJGZ9K6UdvHp8rYhBHjTRD61d/CzHRdhXiR+c8wwNzTBwiESaLnMGUvBje38+j75mScOAv
 x6kkMI6w6o2vk0uYRqHvMfZLernWfNYP+bMxO/lfgJmVN4YOx1l0PqTfpoDDcomlGCbdjzrft3g
 ErPzyJ6juYXg1TU0FaGlzL9Dcmpil3nSEwpDQFPbsf9YC076Tf/fRu5BiYcQJom9M=
X-Received: by 2002:a05:6a00:3902:b0:842:6e1f:c8fc with SMTP id
 d2e1a72fcca58-845d24cc2fbmr8168620b3a.32.1782702581592; 
 Sun, 28 Jun 2026 20:09:41 -0700 (PDT)
Received: from zhk-CBG100025892.huaqin.com ([103.117.77.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a40d23ccsm11442748b3a.36.2026.06.28.20.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:09:40 -0700 (PDT)
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, airlied@gmail.com,
 Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Change the KD116N2930A15 panel enable delay
Date: Mon, 29 Jun 2026 11:09:30 +0800
Message-Id: <20260629030930.379879-1-zhouhaikun5@huaqin.corp-partner.google.com>
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

Due to panel characteristics, when the panel wakes up from the S3, the
main link data is not yet ready when the backlight turns on, causing
a garbage appearance on the screen. Delaying the backlight by 1000ms
can avoid this issue.

Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index d1b01d66eb9d1..58124fd381f26 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1932,6 +1932,12 @@ static const struct panel_delay delay_200_500_e80 = {
 	.enable = 80,
 };
 
+static const struct panel_delay delay_200_500_e1000 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.enable = 1000,
+};
+
 static const struct panel_delay delay_200_500_e80_d50 = {
 	.hpd_absent = 200,
 	.unprepare = 500,
@@ -2162,7 +2168,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0397, &delay_200_500_e50, "KD116N3730A12"),
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x044f, &delay_200_500_e50, "KD116N9-30NH-F3"),
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x05f1, &delay_200_500_e80_d50, "KD116N5-30NV-G7"),
-	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0809, &delay_200_500_e50, "KD116N2930A15"),
+	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0809, &delay_200_500_e1000, "KD116N2930A15"),
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x1220, &delay_200_500_e50, "KD116N3730A05"),
 
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0000, &delay_200_500_e200_d200, "Unknown"),
-- 
2.34.1

