Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730DBCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 00:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC25C10E357;
	Tue, 19 May 2026 00:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mFhaB3Ey";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98CA410E357
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:36:31 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2bab82d75fdso13328265ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 17:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779150991; x=1779755791; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zIbP4h9WDI9+Yz7sY4YHYJ+etVo6kSOqTkbaLsufTQ0=;
 b=mFhaB3EyyDnJQE7avsWk3PzCuM8T+qlLvPfRrs84p0it9g+nfPzSUQaF42762TOjVF
 GlysGV9v6s7EI1nU9BkTbbn3RXaD4LJ6OIlcfFTjj9SMrmBjHkxusS70PGTB+c53Ia99
 iXNU8Q0ViqYlz0cOBginEIpuhZJsdQ2xSsps4Lew3MDm2fLicN+sbnCaV+KzHD7fYY4x
 DnlCQcDjD1rqe9+N1PriU1FnPuZsBUgn+yxjOe9c9QTLhM2Umj65KEh+pVJcH6qNlG9h
 lPg6jbqp6i/oGFi3/CfNkPKGh6ZLOKNE8DlMSx5diuMvscZE+TbAiUt4CNl2ODDhjMzr
 KTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779150991; x=1779755791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIbP4h9WDI9+Yz7sY4YHYJ+etVo6kSOqTkbaLsufTQ0=;
 b=OBEt0KRBOC/Memr6oathzNRQHuImVrigpZP4QDu/PMKFlcZStVr7E5LtA/qZJjlfO8
 QlAKDqfUUCkKpi3DnIjigSeiPVNDjAOt5m+42wYiUu/i6RHtgH7DYVMQSHuSSfBehr7U
 JRn27X6ZMfgieTFIEGeR5W6gRK6Th2WZlGbsXZha/1+3K44B2ZfTFtLQl9DV04kQckgT
 C27cHc3qVTM5512qY/GYx01PmJZgbbWSc6fPi/zcEdJi5WNSapwDTbN9F/LUlYiDmNM4
 SzbSv2KKKggomL/C3gA32q2uO/Y6pQVi5JhiGEa6U3MR+XSwNW5BTow7xjiutP9sbit+
 yt4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8l0TUkeitgPB0GCzJ9iCYGhjWWk4OcJypo/CFRs92YdXWLvNRG6CpvS0zp/Jyoow22MomTBg8I4WQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yysfiu8aLFuPh+gLCFHqprgFBMROZW8hx3diKJWzYTU4MsEqp2t
 rM/EIkYZtXRmY4UuBJFDMBgIe2CPT7vApOEZH2FJIbOMhb9tNE4QGToj
X-Gm-Gg: Acq92OF/lBJ/0VTn8SK+ghrrwxzSDSHti16UInpu9RR0Crko90O8vJdqQS9+SKhZqS7
 Zfcl5CMN+mx34UgGMmlpuyIgCpEQSPuAFYfTZ5/Zqfaw7p2UrHAVSxJFHfVA5UJvsvs78lF6IzC
 jAhi5Thun4B/W6Z/hLtkn07QALJNt2LDGcYE00oR4DaRKhJb6T6PYJvF/1h3/mR4oucOULvibFS
 89Pj2FLrmUH7zNtVLiMTFOveI7TMOOklpKknx6dQNDO7C3Pn0oMD9BKxTwhHPReX/3cWsC1DYO9
 nlAW5tsGaU1Ha/psC/0pROBMKMPX3ntIHu958HRzvJezNrE85sgAuW535Jnuy2ZeYGlXePklxh9
 bLH/remEoa0PxhOA5J3XKy3YZG4GHdAT8NePIUDMpvxLtuXyqAfETPxtSoZam0CXZfk/WDAMo4w
 n5rKV0I54gSJ7h5C3eew1WtneaFoNrEAvr1jzZrJYiRyOoOBb/tqzGsuJfYnkGSmSv+U+MIrY/R
 H8301EssVllilQ0PT4pONYeCGu92dpbTg4=
X-Received: by 2002:a17:903:2ce:b0:2bd:6cab:85d with SMTP id
 d9443c01a7336-2bd7e782281mr180580205ad.3.1779150990945; 
 Mon, 18 May 2026 17:36:30 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe6b8fsm170619925ad.46.2026.05.18.17.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 17:36:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Helge Deller <deller@gmx.de>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC
 support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] fbdev: atmel_lcdfb: Use of_device_get_match_data()
Date: Mon, 18 May 2026 17:36:13 -0700
Message-ID: <20260519003613.626271-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Use of_device_get_match_data() to retrieve the driver match data instead
of open-coding the OF match lookup and dereferencing match->data.

This also removes the deprecated of_device.h include from the driver.

No need for NULL check as every compatible has a corresponding data
component.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 9dfbc5310210..87406a5a2dcf 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -21,7 +21,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <video/of_videomode.h>
 #include <video/of_display_timing.h>
 #include <linux/regulator/consumer.h>
@@ -56,7 +55,7 @@ struct atmel_lcdfb_info {

 	struct atmel_lcdfb_pdata pdata;

-	struct atmel_lcdfb_config *config;
+	const struct atmel_lcdfb_config *config;
 	struct regulator	*reg_lcd;
 };

@@ -930,8 +929,7 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	int ret;
 	int i;

-	sinfo->config = (struct atmel_lcdfb_config*)
-		of_match_device(atmel_lcdfb_dt_ids, dev)->data;
+	sinfo->config = of_device_get_match_data(dev);

 	display_np = of_parse_phandle(np, "display", 0);
 	if (!display_np) {
--
2.54.0

