Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95D9C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B89310E7F0;
	Mon,  6 Jul 2026 08:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=huaqin-corp-partner-google-com.20251104.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20251104.gappssmtp.com header.b="fSa1Xwda";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6100C10E7F0
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:03:46 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2c9bd2f8bf7so36647525ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=huaqin-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1783325026; x=1783929826; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t02O0arrKh6weWMnMwmstwk6EJKDxIB/YqCIDD56r/s=;
 b=fSa1Xwdaszsx0Tl4tY/nIzlGd7g6d+Q9wTw/fl0CH2wbMxWXGUgobeMVdCfbnh9Rjw
 AGsEP0D6WQPmRMJlGNKAxBm3sVegbPy11wVRfxfYImKTtQoQxB8JbbacEvwrianUc8wx
 Zht5wQVaLpmZ/+mRqpfITT87y4F7+WmQiazdVv+cp4Olg96IjYG9qH60XqUEWFX0tlLE
 5RxsFjfLx4SN7puPe33ZpdvhjgBQWW6zam/fTTVMvT46ztJERAGvMASf8q0sgiFLdFBF
 dnnrf/dZu4cOXkmtV6u4V+nVvwNEOEj8Nd7RPdiXt/CJyags5IwBsQPrzuJHD5Csog3P
 oOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783325026; x=1783929826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t02O0arrKh6weWMnMwmstwk6EJKDxIB/YqCIDD56r/s=;
 b=LY/kngFmFtYaL/RX/dSjnrfW9Spo/8wiWkoE+HkGMYgZHeJgwyTt5mEU/rTWeGl6ij
 bBIZgXMrkpRsRQvDraeiE2YC94DT2dvybE2lDWtCEXAS9hz4ZReIwrLPhOo0XVG+B6Mc
 XmSAYbU8bpyvultV17Pkzi4XMOwoVt/F46UgKOaYBaFLfGNnoX/utz4Xfg6XwLPnEnWK
 GLrslry47WSXBnM+4or2GHeRAUoHdj+KrOO0w7zRTKaJTyJ5KohCsYtZHjBZIKoGc7sW
 i74hB7i3qRtluQ+MZRlKiV3ClJ065GMH3HKsohqir/rDQNgP62GKYIBRWSkwy8FVXCfb
 e8WA==
X-Gm-Message-State: AOJu0YzWCYQmW9p9Fxq/PNM5qY4pQLFl3stzJe2bBCvEVE25egMK7fVo
 82ax2GnWs1ENYZtVzicwixn6yGqHfNqDfMeZXe8bnbjEtYkHIDDZhrxQMgHw15VpbxY=
X-Gm-Gg: AfdE7cmcTG4SZBGuxVZ02AC46U4eIkddUH9UoVY9FAh97OTJfhuhx2nvidad9eOwj/F
 q74act38Autxf/jQdLfE6vnuUq1WEsJ3THC6m+BGHx9YgIKjTRjzvlg8RIwZcQnqqhj8GtQQrxm
 zqcZS7A2ZcAN/xnRQ0PtqXpoC21/KyOxBUDyjGgIU2s+F+veatGPde+j9RGPphiQ4p3A0gTLr52
 9Q9Itw2ZJiaNvFU8Kx4MovwgQaIiX+RiGGsoAFONj3Qe/kVl3me0nz6yfPh+TgZnyKsorLiMshj
 PR2o7Gf93o3nn0ZqHeWcAu7eAY5dxGCSOOMnfJ7lIOPpD/5nbCGIw9Ismw3kBH9YjExUuRv2szO
 BTtfEqpE1XNUJWD1IkFLob8VWAEDiu59GlBz40bTuT0EVjV5O7GTdVdzhlEmIOFkNVl8jqe6Oi5
 JKP5PYyrQbxdAc1QBa1TAmBXYyeyUNAMBoPVxJI7NmaG6LtKAe6IbhW+wUzxb5lxc=
X-Received: by 2002:a17:903:3b88:b0:2c9:d27b:af11 with SMTP id
 d9443c01a7336-2cacacc3ccamr135731495ad.11.1783325020944; 
 Mon, 06 Jul 2026 01:03:40 -0700 (PDT)
Received: from zhk-CBG100025892.huaqin.com ([103.117.77.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cb3f5b7090sm34484765ad.26.2026.07.06.01.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 01:03:40 -0700 (PDT)
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, airlied@gmail.com,
 Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Support MNE001BS6-2 and MNF601BS4-1 edp panel
Date: Mon,  6 Jul 2026 16:03:33 +0800
Message-Id: <20260706080333.41426-1-zhouhaikun5@huaqin.corp-partner.google.com>
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

MNE001BS6-2 raw edid:
00 ff ff ff ff ff ff 00 0e 77 86 14 00 00 00 00
0f 24 01 04 a5 1f 11 78 03 2c c5 94 5c 59 95 29
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 af 2b 80 a0 70 38 28 40 30 20
66 00 36 ad 10 00 00 1a 00 00 00 fd 00 28 3c 43
43 0e 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
00 4d 4e 45 30 30 31 42 53 36 2d 32 0a 20 01 80

70 20 79 02 00 21 00 1d 15 0c cc 06 80 07 38 04
80 3f 79 5c 9e 05 95 9c f2 1d 02 45 54 b0 5c b0
5c 00 42 12 78 22 00 14 03 22 02 84 7f 07 9f 00
2f 80 1f 00 37 04 27 00 05 00 05 00 2b 00 0c 27
00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
b0 5c b0 5c 81 00 1e 72 1a 00 00 03 01 28 3c 00
00 53 ff 53 ff 3c 00 00 00 00 e3 05 04 00 e6 06
01 01 53 53 ff 00 00 00 00 00 00 00 00 00 70 90

MNF601BS4-1 raw edid:
00 ff ff ff ff ff ff 00 0e 77 3f 15 00 00 00 00
0f 24 01 04 a5 22 13 78 03 2c c5 94 5c 59 95 29
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 ae 2b 80 a0 70 38 28 40 30 20
36 00 58 c1 10 00 00 1a 00 00 00 fd 00 28 3c 44
44 0e 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
00 4d 4e 46 36 30 31 42 53 34 2d 31 0a 20 01 b6

70 20 79 00 00 21 00 1d 72 0d 90 07 80 07 38 04
80 3f 79 5c 9e 05 95 9c f2 1d 02 45 54 b0 5c b0
5c 00 42 12 78 22 00 14 04 22 02 84 7f 07 9f 00
2f 00 1f 00 37 04 27 00 02 00 05 00 2b 00 0c 27
00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
b0 5c b0 5c 81 00 1e 72 1a 00 00 03 01 28 3c 00
00 4b ff 4b ff 3c 00 00 00 00 e3 05 04 00 e6 06
01 01 53 53 ff 00 00 00 00 00 00 00 00 00 e1 90

Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index bb8ca80929254..e70d2615b3722 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2208,8 +2208,10 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1468, &delay_200_500_e50, "MNE007QB2-2"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MNE007QB3-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x147c, &delay_200_500_e50_d100, "MNE007QB3-1"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1486, &delay_200_500_e50_d100, "MNE001BS6-2"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1519, &delay_200_500_e80_d50, "MNF601BS1-3"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1529, &delay_200_500_e80_d50, "MNF307QS3-2"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x153f, &delay_200_500_e200_d50, "MNF601BS4-1"),
 
 	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
 
-- 
2.34.1

