Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617A8C5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 11:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A121D10E4EC;
	Sun, 23 Aug 2026 11:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fUKPQp5d";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C06410E4EC
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 11:20:41 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c2022323c37so389670366b.0
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787484040; x=1788088840; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hXbW16L5wvPepfurbHdIAab5lg7qHN9GJKcsA1M84NI=;
 b=fUKPQp5dkmjNlStjNs8B4fEdADMqzN44ynAg3+TRl1JiDj+m2V59xfeaG8RW/FBnBL
 aXVQHu1MGWed+lWIIjuPBj1dmZ+m7GkWlFJ4OkhD8GzSEm3FM0se7W64HP9ay0V0wKTc
 ZbNyGHMPaiqTo4ZeZ6OaP5DT+WDwyDkO6OsAT7YdqqclxiYyK+cVA/1Xz5rEAXRxKl00
 8gRiBiqT2GAOZp2UnBBwJOuX7BGJvpSf3OYhhOU2T9TcBf5vhhqYtoeQk4dkW0iRHtOh
 20PORDrl5Vptkb+JhMgm2LmAlLzMvmA8hxcm8b+kXAGpMEY56nnL1on+7MA9vLlz4os5
 T/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787484040; x=1788088840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hXbW16L5wvPepfurbHdIAab5lg7qHN9GJKcsA1M84NI=;
 b=Wbgj64rBvCkErarh10Bho1DkNcADf/Hnun4CssBZ77cQGGlDL57aoKFx7ppzh3sQai
 1QgvygLaH8Q2TOwncNXm+UvsMKsg41HqYGs97dDhbKtshOihRHthkSa0EOU8d85G/WvX
 cBU5/31KtGM10kbeEc3TATo/lL8wXUH2i2DN3dQmVKN44xLstnGHT4PCuAm2ZYS0Go+K
 hsDIbSUBrYCondR97LmiMIsiiacEZyQJ4AkrwN6uYUkkPPOKbcpoA11nQbrfSP3PpMQ7
 AtTZ24Eoqb9LUZjPKXVFTpLuRH4Ag41+rKPStMknFmfiR6Vhpm1eHa0CWyPndl9DbFBk
 aD1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEBiSS0uR07suFhvzx7oe0xhu2TSbOM1aH1LPrdmguN3YYpgXYHceCqVLwejxLEg/M7kmJIU8n/Gc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k1WCvPCEkj0RR1Mc/vtdhAQZ7uFrIYm5ic51Rx8IJHRHEG9tiY
 jQtUjasK7h19HxR6BwCRzSbbC4iRDhKspxUSqPkVoVUmUDA1VKZ/FGOl
X-Gm-Gg: AR+sD10GJtcMN83WhMFGVJQkIaa+qb/8l4n7iqtp/jQGn7T6zVJXIEbUYeMadK3hKZ8
 Y3tsy85jx1BNKbvxDwU2yq1aytyC7Y7cK9fuZKksqblch44PnRn6txsYXYmnAjVttUJQTA759/J
 AinHYhQjyJZGalj9rK7FAvcGkoRPsQtePqUzHDyyjQFZyL1SDwuApRI+1FEqKmDSl8ln5uhf5NJ
 Mg6wR3l8d7LnYBypWEY7z1P6XShV4ZO6XU19b6GD7s3pHgRk698WroA6d+mmJFfq0gV661YiI11
 jrxJDeMDQStw2UgR8Tkl8MtoHl53a7De/j09nsLVAi+c9X/bQpcw+TjhUyZGP2K11KMl2XkJXSq
 7K9kAIxiiq6YDo4yVq+2E/g3EWIwB30c6SmI2QOoBDffS7ei6HbLrUI73SXAgyHE5RvrPJr0ZDD
 yS/98MI4eY4f2NhwKCSITw9dPPmZKo2UpX/fxgDbhfBLYzghnusSW4fm4BhZktPZ+BZA==
X-Received: by 2002:a17:907:1b0b:b0:c12:e178:9e68 with SMTP id
 a640c23a62f3a-c246a63071emr1921055866b.19.1787484039486; 
 Sun, 23 Aug 2026 04:20:39 -0700 (PDT)
Received: from thinker ([2a13:54c2:f000:e268:6d0c:d746:2b12:231f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm707233866b.38.2026.08.23.04.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 04:20:39 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v5 4/6] drm/ssd130x: Replace positional ssd130x_spi_id[]
 initialization with C99
Date: Sun, 23 Aug 2026 14:19:57 +0300
Message-ID: <20260823111959.17029-5-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823111959.17029-1-amit.barzilai22@gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
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

