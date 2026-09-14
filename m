Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551F8C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B5F10EC1F;
	Mon, 14 Sep 2026 09:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MZHvqRRw";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB8C10EC1F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:00:25 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso15917515e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789376424; x=1789981224; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rzH1SlhYJo44ZT//ESye8TSMbGDxpawi+vZSdaQIq4M=;
 b=MZHvqRRw3sxMbTP+igoxMd/whhof3s+aa04byPGxQedPzFoBpC3fCxnDIqsRIuK1HN
 ej1J2OifJLtyLtA/lHyeVUczCSL8fcIIjQlp7VnOOudtW8S7KEper6Dq4yMHV3zkjjEo
 zN06Eta9MW2kUHHeGKEgQ2afPkegPkBldXGpNNDINxMrdEnxggH50hO6ctWzF/Te4cRY
 2SWx+t3Ti4/a3Dkl3KpN6g0YVjYo0NY5bSe/4jORajhENwsRnTOYivH3jr8FYDiGOr5q
 65yaRjJ+ziGf4WPjTdx3rMebLkVyfnDH7WmdM63KeWDrrQNF56yJYSIkp/S27P6lL7pP
 PQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789376424; x=1789981224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rzH1SlhYJo44ZT//ESye8TSMbGDxpawi+vZSdaQIq4M=;
 b=AJ4ByAjGk9X7GMPrRc265hfvrLngxp/pMnBuwcfzi0YhQ6heHa8ta7KSIO+3cu+DLz
 j+Tro+Vl+cBEMllNxrHDn56bVInpT4vXgslUo/raszEHr3eja19XodvBCyp+Q9Hl3lnH
 B2/euHtv2SumDv0ucWr115McBGAfaKiu7GTqnrI4Z0OIYMPm7datk77bgAKUvwJP6V+b
 yjXBfka0yGvj4JKPp5zXHqWyU807vQh7fpMm44Tyh7dZKFo2Z47JSaUWCr60Dt4PjHrF
 yDgiEjL7uIhfF4XvHgeoB2F+mOgvXIqw5b5S+baNb0W4bZEeteHuiKOtRtZzEkRJU5mn
 Mc9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkUSdUAzaOwBCX/86z66lYp6jWbOz3SzFAD+dltISgTXssyhMbue+i+ETY+Y0B2m5n4JRF8sYJTJo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++niVcnePgbqBTDCjfPG4zxYGMhydLGc5z8L/l4KA/tti3ULDmy7
 gRLZbDAOdAHvw2i6e+Lrdv5s8l346aFn9+KQ3A1AkPXbj6yepFqKd6DI
X-Gm-Gg: AYBFou2R3z7m2dobFhQLf/7MhQ/xx9v+adw0g+esq4w6lf153zTwPFEjjFlVYeYmuv7
 FFQv69gHezBIMwG0QLP2FSKgXf6Gg7OMloZFeWws7KIflfKhM+A1H8pGZSVkytl2qZ643Lnjeg6
 uqQNQ06Z8uM+vaJuEsKX59eDinEYNNOj2Pd43+yXa678gdwjzEmAlkp5GglcsGZ5wnCIK+HqZKx
 HdVdTVc+A4NV0PgI4he152qOhmpJA2BlMgm/VEb7hCC5ADWGLt8GO/E9pPThMv3QQAPh+iMb5Z/
 rb0HemCSU9Wbj8VyK+p/TDbKSIkFAo9koqRSCTLlW1ltrJdTVaf3OzbS8vX2th98wod3yXFyo+X
 GDzfsBMaDAh3qnANi32SmLrcUSJ012b+tE7ei18vml6H2pw7x4d+nDFZm5CAYz9sNyYpUfLAN+g
 1nstmizVtX8UfGaJxHEVzbqNpfq0AaE7XyetzojO5w9BrVg8YY/KjKlVvGHyUs5eO7jFsyRHpYN
 yrg7F9hKvsO
X-Received: by 2002:a05:600c:4ecc:b0:499:7219:122f with SMTP id
 5b1f17b1804b1-49e7a662f2emr17392085e9.4.1789376422333; 
 Mon, 14 Sep 2026 02:00:22 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm25245851f8f.9.2026.09.14.02.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:00:21 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amit.barzilai22@gmail.com
Subject: [PATCH v6 3/6] drm/ssd130x: Constify ssd130x_write_data() 'values'
 parameter
Date: Mon, 14 Sep 2026 11:59:28 +0300
Message-ID: <20260914085931.66857-4-amit.barzilai22@gmail.com>
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

At no point does ssd130x_write_data() change the bytes it receives via
the 'values' parameter. Constify the parameter so const-qualified
buffers pass through without casting away const.

Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index cbf77a74c4fa..1d834be6243b 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -252,7 +252,7 @@ static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
 /*
  * Helper to write data (SSD13XX_DATA) to the device.
  */
-static int ssd130x_write_data(struct ssd130x_device *ssd130x, u8 *values, int count)
+static int ssd130x_write_data(struct ssd130x_device *ssd130x, const u8 *values, int count)
 {
 	return regmap_bulk_write(ssd130x->regmap, SSD13XX_DATA, values, count);
 }
-- 
2.55.0

