Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13DECD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7109A10EE86;
	Wed, 17 Jun 2026 08:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nBAI2m3r";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A98210EE71
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:00:49 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-695737cf38bso374175a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781683248; x=1782288048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=unbaKaB/vtuL7mVbcw6i8cWTUClKXSp2jofrc/k4FUs=;
 b=nBAI2m3rgE4E4nZ5BLHWJDY8tpaga82R5uzlpjvrCsGMnX8Fd1/IWU2JSPX3AxCn88
 r6XtU2qXq4WGv29HYbxaYICCH9aByXX7CYQ/kf2zT498nJBSbaZAykGZx0Hg0EFs4Hji
 oq27ofJ7F36//CTzb5a942HqRwa6A4ULivao6gywLdId/7gK7gkfre/Tv3dEbSBGkTIR
 KaJTRqWniv8GLOs+3/cVCSTSVjCAlsQxcMMFgkbHhKEB0zIgfcphJWn2rtnb0qNAnOaL
 bksH54aZdxQk8mECZ7K25uDwViOBjIV45mH56tgBuzvOe1VndC5g9/VcsZ6+FtdJ595E
 g0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781683248; x=1782288048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=unbaKaB/vtuL7mVbcw6i8cWTUClKXSp2jofrc/k4FUs=;
 b=qU3LTWjkRb/osTt+T5mR8ZQKjqP1gnx+QLlHjG6tN9rEszQBSuiCvQZ9XzrQYR4CHX
 PymGhuIhSEs2WzYYsQfVZCNKTw/oPtQn3Uc94EJF94tDBjsCDJv1i2IgPEB1rcQaiAwf
 rAh3QgU1g+kJxGemS7oH8g3RmVoujiwhbaHFKqo8Px4oY06Y+AgbnU0aorQctbxKDdv+
 t08eUgbeBl2r5pWS7CRCY7Y/7A5vWK9W0LY/Av2VvLT0ZE2u4f36DnAWVsOsBWKVJJuZ
 nzagPgoV01l1+8hkjdkiflVDMc+RVgvmAGX3qexS2Pxzy53b0LUe5zc7+645HrJsoPMo
 eXdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ//ihxtM8u/liRjG2999CLpmUe8QXIsK46AtVqM8MquHUDM9gPAvuc+XNAAK/EMdj28QL2lIk6XYVw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwstpgBe2K2fBKeFkRSIyV7fKBYx6lXw6Y3DpPO8W+8gtTl7onR
 +NafC4wQLMXKteNk1veS0C5ZL9Rv8d6TxMv+yYvlm+r1qp7CJnTZTVyl
X-Gm-Gg: Acq92OHgkCD65kePPNLmnpRrZ6dkx4KPpBZhlPQNDoaOc3YfHv8hC8M8eHmCSxdpbfw
 ty0rNcQbvN51pdMvJm0Krv139+wqvB+DwLZprNlFXmrOYV6j6b9noQ0/PWemphGKRzFT2gYMHSU
 //U47MWakN7craTZKKwXyNcAuIz8n2EI9vswhyGoMn1CeU3CxxcRxHRNQnVVRvKMV3gqQOaRVjg
 Pi9eS+/TzWxyht1SXWEckrPsVYyDaEsf9fEsfOQFaXqnbksKd1Bq0h2mknscdN5x21d2tD/hiic
 NzFeqyNqdElBqazr4OFa1aXGs/E4uDMuHygT/ELZnQFHsF1pdENNsNENQTHDH5fV8VlcU44/LSL
 K3gfxlRFaRaNuKQzOMGA1NYsxx6fH2dUxCJA4oTrMS4de7tx7tVId6CVqdLzfgwSEwRkt9NBwLm
 3Pgg==
X-Received: by 2002:a17:907:97c6:b0:bee:ac9b:9abc with SMTP id
 a640c23a62f3a-c05a6ed1a53mr193361766b.22.1781683246256; 
 Wed, 17 Jun 2026 01:00:46 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:00:45 -0700 (PDT)
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
Subject: [PATCH v5 03/14] mfd: lm3533: Remove extern from shared functions in
 the header
Date: Wed, 17 Jun 2026 11:00:20 +0300
Message-ID: <20260617080031.99156-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617080031.99156-1-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
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

Using 'extern' is not required, drop them.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 include/linux/mfd/lm3533.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 3463b164d0c1..c4c38876c09b 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -82,13 +82,13 @@ struct lm3533_platform_data {
 	int num_leds;
 };
 
-extern int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
-extern int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
-
-extern int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u32 val);
-extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
-extern int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u32 imax);
-extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u32 val);
-extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
+int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
+
+int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u32 val);
+int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u32 imax);
+int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u32 val);
+int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
 
 #endif	/* __LINUX_MFD_LM3533_H */
-- 
2.53.0

