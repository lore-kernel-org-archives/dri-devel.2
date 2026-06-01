Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587CFCD6E65
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756D91134C5;
	Mon,  1 Jun 2026 15:19:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bQsRG8pb";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B4E1134BD
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 15:19:10 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso1306561f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780327148; x=1780931948; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1p24QeWuEOdkZHaL1V7uOjlrxK/vJ1VAKn0KvK7P92s=;
 b=bQsRG8pbQKn3mDjW9Bw/AN3V5hBZGndfKjlMgFK/3JaQJAGq6UkF6dakzRRU7VRjmI
 Md8ANGQuVCavw211ZPbXaEe6UCi+OyXglfkoOEkIZyNZR7IIk1YrL5WjJqzDHfAafQOK
 fbQs/Vsq5F/Mq3hjK12SrnZHF2p3pzY8O+YmrY/5xLcYn+StqzalQzIDY7+OXlnNLPKu
 GPYesmoFAdbMXC767drYoclAXqh5OlhE9tw89GS6ASo+zP2+LkHHBPMdC0Qi6EOaHquB
 B9EE8rQqkRnknAEgM8vEeDnVuXF9dWHG51qqa9P2qSXwMCe8xFshgtzgk/IQtL8S1ifq
 NjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780327148; x=1780931948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1p24QeWuEOdkZHaL1V7uOjlrxK/vJ1VAKn0KvK7P92s=;
 b=ltwDp6zQBpV+z6BXnY9IdnI/G7zPl030AU6I1hkEDHUofj/YXkw1310ZhI/L3f2SOf
 Ez3xjWXNpQo55jDIf7M9iEmQLElq4IsmfEqXBy58KeHxPbkpIMdzNSHcYwx3AHk0CxNk
 tkq8N/BAyl5r+WajB1P/CAxJcQU4GLbXig8xu2PJrnYf2MOF7QnRo/QoNyCN1cSvWXU6
 Jmp3DWgYgaLCSxlrT7fGt9J/S0kdN2hhnzh4olOc/ilok/Kd6aVo9/aiZznP/yEsBYkc
 5eZVwaVd6ZizA70Mb7oVVGH+aUj6g5NmgYFCCuPT95PnB658cE66PkILcoKP2s2uzI++
 fRNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/oG9477gBJ0MSSWbgy7H9edOae9tve4e6TK42EpjvephL151mwDqW4Bz4TzieK+nmWXrijIKWmtA4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzO1wEbfMaHIdoMO28wO8XtI9Aa0feBC4Pou3poXFXnrk/N4FOA
 XsVvDpuF34GOthP4Ln/1ghOQEornSn1KDi5z4jngXDqnd4BuGZ+VvHKH
X-Gm-Gg: Acq92OFGdA+NF/j255ax/2odjQ7de1604vKqik38F1qRvUcjbWqbUegBD1XQjZVRsBX
 qX9hXeesJOptj/KhHL6TErA/hNkjha+5U8fjeENsNWzmsE+g03jfJQcQS9o15jyYCyV7G4qeVrq
 B2jaX/h2cwCXeY8kEpvuCBxhV36PPXv5LhBws1KgxWEj0fvIPwF/siIGP6DGlosl3kTIKusBvBv
 veaX1HAqpOkyOTaSQteapmFIc0GCnK66FhVQppRpZs925arcFSRz88CYJeD2jM5ey3lnh/SosEk
 XsunnjXQi9MNaWZmdQinXhhdcHxzreepJUaczAUi9mT9liveadzKSfj0/cUBGH0yCqZ22A7gB8d
 I8l7/e1948DE1WKUfqSbaJfBSDNaBTyzYnQF4hOimZyzwIzrLkQvwRPbHlC0/2vwCmNBKrYLvGJ
 O7u0HxqQUqhTAjUEVr9uwjjv8=
X-Received: by 2002:a5d:5cd1:0:b0:43f:dd91:b022 with SMTP id
 ffacd0b85a97d-45ef6b791f1mr16538591f8f.35.1780327148356; 
 Mon, 01 Jun 2026 08:19:08 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:19:07 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: [PATCH v3 07/11] mfd: lm3533: Set DMA mask
Date: Mon,  1 Jun 2026 18:18:27 +0300
Message-ID: <20260601151831.76350-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601151831.76350-1-clamor95@gmail.com>
References: <20260601151831.76350-1-clamor95@gmail.com>
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

Missing coherent_dma_mask assigning triggers the following warning in
dmesg:

[    3.287872] platform lm3533-backlight.0: DMA mask not set

Since this warning might be elevated to an error in the future, set
coherent_dma_mask to zero because both the core and cells do not utilize
DMA.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 4dca5641b774..b597d338d6f7 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -491,6 +491,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 				   LM3533_BOOST_FREQ_MAX);
 	lm3533->boost_freq = lm3533->boost_freq / (500 * KILO) - 1;
 
+	/* LM3533 and child devices do not use DMA */
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.51.0

