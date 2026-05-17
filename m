Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA98CD4F3D
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 07:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7152D10E1AD;
	Sun, 17 May 2026 07:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b2plsLuk";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2442B10E1A7
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 07:43:39 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so588568f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779003818; x=1779608618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKwCpCIE3pQrKMIlzgxzd9zVO2yq7zSfHES0U3paVng=;
 b=b2plsLukTYrHw5lFghca1kvHPrDCcPzbFQE5e0hjR/oPvjfRM/ZPGaa2Vdk+WygaHT
 DmCaJy2Q3/LwcfmhVjwmxygb0TN+Mc/eboQfjMl3TkTGGznEoVfRQXWA+nu5mklHXRdG
 mJi1AOB2hr7TL99o6gEB9GG7elTnov/MSxNtzc+4cJRZTCDyxlVSKDxZK63KGSVS+4qf
 4n+pn5Ef7sWSLqTrp/jcihL94QXCZ60+CG7ShX1qsBnza7RqzRVbDIiqk8XXeUVwjZFv
 Rz2kV2BOogY7Qrg2IwkUHcw23bWB9bJxxJm39K+Th5TZaCt9dtrVKtxT2tRULjjnfJNI
 rfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779003818; x=1779608618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PKwCpCIE3pQrKMIlzgxzd9zVO2yq7zSfHES0U3paVng=;
 b=C9hhX3JYUoAHl5q3KeDMV3hWNErGHiuCWym43t/M/ISXpXKvrgow1ja/DNXkDpz2ZA
 DOBQAfA0rMHLJTv2yblJkvhOkxd5Epm48yl5TOkY40kuUulYDB+9zm56KSQWxmdf894K
 gTxz5jC+6yPFkSwgjBf1HYVTfCOafZMI9VJQgsEtaRomcxHQ5E0rdxpPWsJqfbKivwqo
 Impq8lqZm1dWT3PMgHKmWlOENKUUeZCX5sE+/RaShPiPEev90mYbmhp78FY0zelYu/6N
 8Ejll95pf+E9CJk8hsom422tws8Pn6M/OZrJwwDKZZiqimMF+nKrult85YqLRwaTBeuU
 GF7Q==
X-Gm-Message-State: AOJu0YzO4bzDA+mf4gySfjw/yLY1KtG7vG2+tnMcA1f64ObcmoAExMD8
 U87tF4xpKh7YTcwMM07NtX26sHlao+SHkKmkcxm5uAfHTRIHC/WCX0xg
X-Gm-Gg: Acq92OErM40zpr6hnRshH89S6JRXO9AFaqLKNsOLPzFLZWM9ikNudUF2cOq/X90aCPO
 Q3WYY0V3VHOyXdkscROhocGDLj5Psh+C7XpvaveXoPn9VY0d6tRNO+dj50S7Ovu3E4PR4KURfXg
 UqVDsV5mKqhZufuLxzGJrYwepeaTh3VVDldcU438rkqKIvXjKl9NIjTn/ieybgnHL9Skmb5QHMt
 04alkJos2CDRu4FZzK73WcazPPA/RuGv3TlbvPbss//8bfcBWk31YSNoCQ4uDmND/YgSF25ZHFD
 XpiyjJ2h0COEzXrMFjdIsLlj2D7u19OPCqCfrInPJyfcoNWJZFVWgCo2/uPIfowAWro/F+mIzOs
 y9Vw18Fjs4bs/WHD2IT5W41GqTl5MkaJBxQyFKYug1PqJAwiSnUkef2NCXKD2D9W3kaAtLIo/9x
 UC+3et5KoQZZ4A
X-Received: by 2002:a05:6000:2508:b0:454:9655:43af with SMTP id
 ffacd0b85a97d-45e5c30d598mr14636187f8f.0.1779003817436; 
 Sun, 17 May 2026 00:43:37 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe248dsm27512864f8f.30.2026.05.17.00.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 00:43:36 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v1 4/6] mfd: lm3533: set DMA mask
Date: Sun, 17 May 2026 10:43:04 +0300
Message-ID: <20260517074306.30937-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517074306.30937-1-clamor95@gmail.com>
References: <20260517074306.30937-1-clamor95@gmail.com>
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
index 131eb1a1c8eb..c7914afd564c 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -499,6 +499,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 			lm3533->have_leds = true;
 	}
 
+	/* Parent I2C controller uses DMA, LM3533 and child devices do not */
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.51.0

