Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF88C88E6A
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7FF10EC2E;
	Mon, 14 Sep 2026 09:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pf11PjQk";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32EF10EC1F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:00:25 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351832so887514f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789376424; x=1789981224; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JgEITP5zYNHD7Hd4jE+xDuU4E1MB+W23iELVzvgQk0c=;
 b=Pf11PjQktx5ck+Eke+aJsVWcFd8KAUmDgca5nVudbknlCmJEwgS4KmpbjJ5IczmcQO
 uxhNmNYiTAv7r7NmmboLIHr7ZpT7aAo2LmKek19BQU69CYSgUzQwK4aLM4EAZMTXUb2D
 bs0RKFb8T5y+6FagKGyrl2e4CFQemBVOutGfMzjfS/oWKCw3egJ1/k9nBp2RNkyscxvH
 FZGjl3sDR3Nt2laqQDehfvv5BgZv+F6u0tpkkrn8/WmTtS7iYr5Yyh0MMrdGunPZMR7A
 et5/XYYxlz5+f6Vmbua8CRsTrd16pmu5Y3UDtGtRoc02DnJg+QLrZryNcsg4urZQwWOE
 mMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789376424; x=1789981224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JgEITP5zYNHD7Hd4jE+xDuU4E1MB+W23iELVzvgQk0c=;
 b=HKN2KoFrtbuGVEOfyHqIYmMw3rJCwqFU7HoW2HIX6ZNIHZc39fO7q7zqYGG/Z0rHPZ
 +SyTa6EUIZ4MhtOH6TR10tiefJA2bwrg+z1J90HRx/Qt3sxAk6TemiKvhKWER7dl/fHc
 cgyxflLNh9NZ+uZxr95GaFQPbBF4gC7Z9AgF9y3G5/BBlkwv/FtjigrCenidfj1jpQgY
 Pc+0MpV3SNp7s4wJ86MAPyLIEOhBiRfG+h+ixNptAZ+hziAAL7CN3Pb9AW1SzHEi20uQ
 hW5+5X1OjRdvnJ6brbBFs48pb9b86hGZ6bgPa9k/n/XU6twLG/8WstatuPwrDT8SKibo
 lJ4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8lWz4qvXuKcTl1G2FcaFOLI+ASlygtbOqq/VcUVX6IBN5fL3cjXyWrNPtePBULuq8pM5m24s2LoQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mDSXqScCbqTmohytVEDvJygajSm4i1JrwK2krxJXtVq1klgUla
 oSnK9taW+FQvCd7RPMa3oKdN/9E7Zl3HiwfpyVpBNzpXXUIfOzVLvLFP
X-Gm-Gg: AYBFou3c9NBViogoyHHe9E/Ow3jMJ87xsQeLr5FLiJb4SIomrtadWzK3BIFDiZu5k/8
 Glcrsvp+r8902q4uKVDmpHM6s4gb50lVunNC9cjb3pHpBS31w+R2bQV7eDwaNfEvkv0EZAbM/wK
 7UMdTz6C1sQB4+l6G1zBrB2UETUNYifpPkWVazoM/rNbMTxRTI3q01OaMPAxe3EZ9GhIbX+8RXs
 cwLYncK75vFaHZ7iUslVDBQNl6rSpXU1jkXjgQZgsqIlIcG2EBB+vqXdH90yn4Zg1P2D4sb8xT/
 obk+GdlWNlOCKO+CzW6+q+u6Fq6bEju6/nIWQ2W6lH0w7XRTiMk6GWyBkK2cudK70PoN2MrG46n
 hwUk7tF7TNxnzuWIZWXw7ELHtE22loBO19j1s1NjHBocMPj/AP4D4WyDW43j9WWY0uU/Z9y3fKU
 Hhy7hC6Ilha2REto8M2aa3MoHoSk9BcU9/mFiePTmi2SqTEt6hIrpnX+9nE0pDalnrQ8+3X6/Ve
 moaphJpfBdl
X-Received: by 2002:a05:6000:41da:b0:485:ac0e:6fa6 with SMTP id
 ffacd0b85a97d-48702ab93bdmr1778531f8f.14.1789376424193; 
 Mon, 14 Sep 2026 02:00:24 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm25245851f8f.9.2026.09.14.02.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:00:23 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amit.barzilai22@gmail.com
Subject: [PATCH v6 4/6] drm/ssd130x: Replace positional ssd130x_spi_id[]
 initialization with C99
Date: Mon, 14 Sep 2026 11:59:29 +0300
Message-ID: <20260914085931.66857-5-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914085931.66857-1-amit.barzilai22@gmail.com>
References: <20260914085931.66857-1-amit.barzilai22@gmail.com>
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

ssd130x_spi_id[] is initialized with positional initializers, which
easily create easy-to-miss bugs when changing the members of the target
struct (struct spi_device_id in this example).

Change this to C99 initializers to guarantee each member is initialized
with the correct value.

Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/solomon/ssd130x-spi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
index b52f5fd592a1..be50e5aa2c87 100644
--- a/drivers/gpu/drm/solomon/ssd130x-spi.c
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -160,17 +160,17 @@ MODULE_DEVICE_TABLE(of, ssd130x_of_match);
  */
 static const struct spi_device_id ssd130x_spi_id[] = {
 	/* ssd130x family */
-	{ "sh1106",  SH1106_ID },
-	{ "ssd1305", SSD1305_ID },
-	{ "ssd1306", SSD1306_ID },
-	{ "ssd1307", SSD1307_ID },
-	{ "ssd1309", SSD1309_ID },
+	{ .name = "sh1106", .driver_data = SH1106_ID },
+	{ .name = "ssd1305", .driver_data = SSD1305_ID },
+	{ .name = "ssd1306", .driver_data = SSD1306_ID },
+	{ .name = "ssd1307", .driver_data = SSD1307_ID },
+	{ .name = "ssd1309", .driver_data = SSD1309_ID },
 	/* ssd132x family */
-	{ "ssd1322", SSD1322_ID },
-	{ "ssd1325", SSD1325_ID },
-	{ "ssd1327", SSD1327_ID },
+	{ .name = "ssd1322", .driver_data = SSD1322_ID },
+	{ .name = "ssd1325", .driver_data = SSD1325_ID },
+	{ .name = "ssd1327", .driver_data = SSD1327_ID },
 	/* ssd133x family */
-	{ "ssd1331", SSD1331_ID },
+	{ .name = "ssd1331", .driver_data = SSD1331_ID },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, ssd130x_spi_id);
-- 
2.55.0

