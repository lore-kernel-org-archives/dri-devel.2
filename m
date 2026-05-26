Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D23CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EF110E69C;
	Tue, 26 May 2026 14:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="SJUoM8xl";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA92410E69C
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:18:09 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso6817048f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1779805088; x=1780409888;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+l0tXTe0JtsE6kljkXV/yKiUveLQAvzo0OxqjuzKVB0=;
 b=SJUoM8xlXmZOwmoUHCFaIYkduUqP5nTYZ7U824Ps+Q2CC7BM830MJ4MrWHDdlpsVh8
 nkOy0FveKkmBISCJcXBsi5F9VN8LuuGggNePssrfrJ/pigFq4ysOhX5ym7qk5SdVqZTc
 FleH7nVTWHU1CE0W9rOUQwxeIXBm50MYBDXCLfY8GFoj42vM3XleT2bIB3ZClrVCKavP
 eVLnFAaT7R+Dto6HYfHp87jHPZMlYIEWuhwW1uvqGcJ2/avA6ozklSl/uiZdZ9q3bQXl
 VzK0yFhhM2VQKJ+hagC+5vMqOwxhrpnm8f8pD7poXomnpmdN+/NcOL0uCgExdF3lr7nY
 4oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805088; x=1780409888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+l0tXTe0JtsE6kljkXV/yKiUveLQAvzo0OxqjuzKVB0=;
 b=iKDUABJCUquaYrqeh4IOrkatEDMQH3ZfhSls1OhHkhw4m1rtjVP5CXO4Tc12+9FP5E
 pblep6SYGiA0rKUFMNNK7xTdykqY99he0cO7kx7KCWitBl6rDhwtmLM4xomTFxHZTpK6
 oj/nlrjauY0I2+R78w7AsXgVLlmZrKDxr5FQCBOflF488daAI9CfTK6/T2VfiWbU2exD
 zeluX8uJFrZ8JeDj5mURg8ecsgjbMlZZnAVhrmArW8z3CF4nliiM3WQU2cyp1MyjSUJ5
 wNKmRARe6b5ianhRoZrvjfdCbTqfbRtOYUnDyqnE2kurE9QyQGF2K3wA5Sizrm9ZZlsz
 M0FA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9e1zB1E8J+Jd6UBiMj5NpF/ub3cSuwAl6Bngihs0859JRCMG4pCFG6cQr+5ARChGho71rIFiQWWuM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFRk15ud0CKTO9w5m889yLD2ZO10XDZzwRUYp777vMVnSV984O
 F89ubEma93rCfgCgkHXWscoxvR2xdfsM5RrIXZ5UwlnfMDYJmXK3Rnus3r1VYhIul1s=
X-Gm-Gg: Acq92OHApKwrNk1ExgfrLS01BMijnJTF+vAbiwBAMA3aNaJo2afMjjahYp9HFaC0HcS
 BOreSikU4htrBP69K0uqigj5lO9TZYtzGOL5zVZtAUPXEK0n1HqpUssYaTPLXBQcQtvbTha11ZY
 fA8rolsHoTlyFlee43eFxt7JIVw47xKhbfEyu0rYn64BMHb56kftrCKMB+lmadz9PVXRs67pqIp
 W9OPD3U9GXfKkYeD24TAIrJudwJy1MlqGjWSBR/JJlnJxX4KlmXuAvRWUNTtgjFpXIlgwAi8JnG
 y028/YaJBvywJ7N87poTYsV6XnLbVpQKNmZ/UakRixH1btSl6BFdsOk7oQCz/jHkhjZ4Z8XR/EO
 U3aK6aaPORkApYshiM0Ko76Ra2sAkAFLi2NHIju+lH6YRzDWzzBB4JtK77pKj3qpQ0zgyG2c0qf
 BuNWsJHBR5Rj99pN1SFDOe2rVy29rNurqBi/wj9VV8REyfHYT/9GP6HehO7cdeEsx8/g68dpEMe
 jl1qj89YCJ0GSo=
X-Received: by 2002:a05:6000:2003:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-45eb38e4b46mr32569170f8f.38.1779805088108; 
 Tue, 26 May 2026 07:18:08 -0700 (PDT)
Received: from localhost
 (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45ec7fcd7f9sm22348657f8f.37.2026.05.26.07.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:18:07 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 8/8] video: cirrusfb: Make use of struct
 zorro_device_id::driver_data_ptr
Date: Tue, 26 May 2026 16:17:34 +0200
Message-ID: <72b515651ab8df2f464deb620fd7b24370d6fb1a.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=K/rLWEjDKkHsJ9bxXPZI9DKSp87tpARRFywudt2h+mw=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFauKEYSHWUZfQM/7o+z0zP1g8ExpBrH3mhgHl
 +PAjlqxotOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahWrigAKCRCPgPtYfRL+
 TiO5B/9L+NQiEbboLQhnRBDWb9kWCznt9081jTJD52DjSXIbOimq9lDExC1+m0zHI2vR23OtAz5
 rYKvMs5BII8C3sPjydO9HflKm+0HGBoxNHyFcBRx7nMD9YMRu0oEL1KgUF5aYOJDw3EZHWDojMB
 lD0vp9qtN/T5HfKs2Sh/ySwqhx90V07yB8/WO6csBHNoZKyJ5crGE/3+EXpuwm9iLdG7ro9/WqW
 252nXum67dBmt2ECelLNWuOkHKOPjUDQ82WHUAqobOpqwWWtT8BqDC/PsBofb8nn9ZBDxydS9Eu
 V55nk2HDzDn0IRAJmoktE3+whV9/arrbjN0Wx39DREREqzRp
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

Usage of .driver_data_ptr allows to drop several casts and so make the
driver a bit more type safe.

While touching the zorro_device_id array, drop an unneeded explicit zero
in the list terminator.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/cirrusfb.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index 2693b5cc053f..7e07e775b393 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -321,25 +321,25 @@ static const struct zorrocl zcl_picasso4_z2 = {
 
 static const struct zorro_device_id cirrusfb_zorro_table[] = {
 	{
-		.id		= ZORRO_PROD_HELFRICH_SD64_REG,
-		.driver_data	= (unsigned long)&zcl_sd64,
+		.id = ZORRO_PROD_HELFRICH_SD64_REG,
+		.driver_data_ptr = &zcl_sd64,
 	}, {
-		.id		= ZORRO_PROD_HELFRICH_PICCOLO_REG,
-		.driver_data	= (unsigned long)&zcl_piccolo,
+		.id = ZORRO_PROD_HELFRICH_PICCOLO_REG,
+		.driver_data_ptr = &zcl_piccolo,
 	}, {
-		.id	= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_REG,
-		.driver_data	= (unsigned long)&zcl_picasso,
+		.id = ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_REG,
+		.driver_data_ptr = &zcl_picasso,
 	}, {
-		.id		= ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_REG,
-		.driver_data	= (unsigned long)&zcl_spectrum,
+		.id = ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_REG,
+		.driver_data_ptr = &zcl_spectrum,
 	}, {
-		.id		= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z3,
-		.driver_data	= (unsigned long)&zcl_picasso4_z3,
+		.id = ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z3,
+		.driver_data_ptr = &zcl_picasso4_z3,
 	}, {
-		.id		= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_REG,
-		.driver_data	= (unsigned long)&zcl_picasso4_z2,
+		.id = ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_REG,
+		.driver_data_ptr = &zcl_picasso4_z2,
 	},
-	{ 0 }
+	{ }
 };
 MODULE_DEVICE_TABLE(zorro, cirrusfb_zorro_table);
 #endif /* CONFIG_ZORRO */
@@ -2208,7 +2208,7 @@ static int cirrusfb_zorro_register(struct zorro_dev *z,
 	if (!info)
 		return -ENOMEM;
 
-	zcl = (const struct zorrocl *)ent->driver_data;
+	zcl = ent->driver_data_ptr;
 	btype = zcl->type;
 	regbase = zorro_resource_start(z) + zcl->regoffset;
 	ramsize = zcl->ramsize;
-- 
2.47.3

