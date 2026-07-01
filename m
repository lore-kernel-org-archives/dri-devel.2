Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94C6C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 01:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CDA210E2E0;
	Wed,  1 Jul 2026 01:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=huaqin-corp-partner-google-com.20251104.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20251104.gappssmtp.com header.b="xnNA+p11";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB2410E2E0
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 01:30:24 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2c7cfa17fedso918615ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 18:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=huaqin-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1782869424; x=1783474224; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kuK12U8VejIJpQBCwKFz9vJWqbfcPIhRNcYNqf6TjfQ=;
 b=xnNA+p11Fq8tuy8XKc+1+kt3/8Qa6DP535g8QkmNbaNYkFT541jaLfuKVqWfkKWQJ7
 BsZT044e+CPbMp6VjFJpyFtyZLhnMlNqZ6E5hE6T8NBi+k51MKRNNkZBt0ytUEIRkC6a
 vFRpYiV9k3p8/tAR6ZLzgVi/8CCtlWyZOapQxDeI2/IqqDYiKKflJQjvI2M+nPiSHX07
 tXDzG3UDL3rNG7dcrWErg/+qMFgG1uqfAWHgcfO1nIRg3GGKBIHppN6FPallUIvD9tDm
 ir1ar/0Ac4Hpx/i/ecnpDKSEljeM6Ek33KXlkSgTveEtBXUsfPeTG/y9jenVzE29b5+z
 47zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782869424; x=1783474224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuK12U8VejIJpQBCwKFz9vJWqbfcPIhRNcYNqf6TjfQ=;
 b=DqRNpaEPNEGhk6X2aomk5Qqr2+t8FwybV/RWQsfKDWIAa/XXT+skkxlaPRcrXpMP/s
 HDJqZQu6elot+B6ksCQueZ4c9rRaoc8nSWm9L0ldX6U1Ig8QXfpBKndjRj31BKbrBWjX
 vxgf4ZmNnM5SqQpte1y9DNK47b5gFvnsoMaIpiu5hojojY0lVDhBIcLRGCKWz2nM+1D0
 Dog7IpkpQPGyS2Geql9Pml09Rpe1vLhVzC7rSbn2zIE+X5Y330fkj1YRdbK3e7WjwqOu
 +ACY6ObItKJrtcvin5uAxSJNCJjlQghsOFefQro4gGWFlwrLf8V+mP62zMAYHea+osB2
 5/Dg==
X-Gm-Message-State: AOJu0YzYNCifjQsuOJaXMfW+NQNryhBStfExW5HxBw2Ls/QTpydE3fb8
 qwbTx/PHnzovUThhj1np0XQYGg9c0VUoVgtWa1lmze0Wddq+XzLcIq+FylUXSbplaSo=
X-Gm-Gg: AfdE7cm6TUkFvc4Kt4Gtnzr90Z3zkZJXpbS0qKdQ2Zpvfw23F0fxoBr8U6NZCPiQxP/
 rqKracAraqXAtO0CbCbk4e1/SX5Q4/B6ushRb6Tht3ly2cwNolQo2aXKp0FJHKHKSmA0MxoEzkV
 zn1iXJpeVYyxpxEu/7U5zeOqH1xJ8d+eIQY/WGKKGbnQ5iZEp1n60kFMStc2EBxobNdWQMb2kuK
 1g6tNKV92m9LJpg0eBwJK+hG/AF2cVRVSfHF0Qqvti4Wl1jtvlK0kW5DcZNok42S2RyfnMX9RHP
 JfCkPxk6OzA5HxCMl7LPiwvKZH+AUhA8eUU0F/A4biztcn8AM5LuAXW2dtTlsstIVJj31ExcqPa
 pu05PZ6fJo6/+K9z2RjKTF6SwdPKntUjFbZd+bhgjmaSHg/FbKaMkdtKzC5+hq2GJ5JzKOk2qM2
 bvcGIqmFq9m2UCIZyNnU+lgO12j6V1Ov0Cn4olQp+xC1uMLk1rgQjGONDdOIIhApw=
X-Received: by 2002:a17:902:ebc4:b0:2ca:17e2:2acc with SMTP id
 d9443c01a7336-2ca5a57351emr24211595ad.21.1782869424335; 
 Tue, 30 Jun 2026 18:30:24 -0700 (PDT)
Received: from zhk-CBG100025892.huaqin.com ([103.117.77.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca382abefdsm23490465ad.59.2026.06.30.18.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 18:30:24 -0700 (PDT)
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, airlied@gmail.com,
 Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Subject: [PATCH V2] drm/panel-edp: Support MB116AS01'3 edp panel
Date: Wed,  1 Jul 2026 09:30:18 +0800
Message-Id: <20260701013018.2621972-1-zhouhaikun5@huaqin.corp-partner.google.com>
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

MB116AS01'3 raw edid:
00 ff ff ff ff ff ff 00 21 63 03 12 00 00 00 00
00 23 01 04 95 1a 0e 78 23 e7 05 9c 5b 56 93 27
21 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 36 1c 56 92 50 00 1c 30 60 18
a8 00 00 90 10 00 00 18 00 00 00 fd 00 28 3c 30
30 07 01 0a 20 20 20 20 20 20 00 00 00 fe 00 48
4b 43 20 4d 59 20 20 20 20 0a 20 20 00 00 00 fe
00 4d 42 31 31 36 41 53 30 31 27 33 20 20 01 cb

70 20 79 02 00 22 00 14 1c 1a 01 84 55 05 91 00
5f 00 17 00 ff 02 1b 00 09 00 07 00 2b 00 06 27
00 28 3b 00 00 81 00 13 72 1a 00 00 03 01 28 3c
00 00 00 00 00 00 3c 00 00 00 00 25 01 09 1c 1a
01 1c 1a 01 28 3c 80 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 e7 90

Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index e70d2615b3722..98639f3b2f87e 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2215,6 +2215,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
 
+	EDP_PANEL_ENTRY('H', 'K', 'C', 0x1203, &delay_200_500_e80, "MB116AS01'3"),
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d51, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5b, &delay_200_500_e200, "MB116AN01"),
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5c, &delay_200_500_e200, "MB116AN01-2"),
-- 
2.34.1

