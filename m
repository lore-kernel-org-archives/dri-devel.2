Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C72CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 261B610F1EB;
	Thu, 28 May 2026 13:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iv7CuiPw";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 792EE10F1E3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:51:56 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-bd8d0e4e341so1843376466b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779976315; x=1780581115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqOemnD04LJjQnMzwMBgcGs6gZ1ngsn7g7S9Cna4sh0=;
 b=iv7CuiPwQcafix8eMLTkCuimthzLNQr4KwmycPEvhb71nf6gutlcWJFV5lKABCIjRA
 edLFgtocskCm4WNcU7AoL8Tmn89upZxNasxW2jvyaIF0HM/h0GXpM5/+THin4CQsEvJ8
 ELAB8FpO0HYVtU56E3vY/yZNRcSZmW3nWPLLbcJ+wC85f7ApXpFtUxHFch+lSP84/mxF
 v7OEhnOhvxMpgQwIMC2egL3Jzoj6xY+yc+8+fH1Y8f/dWHC8AbQzsusw8D3KqqY7/CJ9
 Im4ebVN7DZ96YUqnuBEmV+EyA6cOGpI+UvajoeZZffKQgh68F02Ka0TzskcluS/hHc40
 cQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976315; x=1780581115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HqOemnD04LJjQnMzwMBgcGs6gZ1ngsn7g7S9Cna4sh0=;
 b=GO+9mNF7ORZ89LPojCmAPjuK27N4o8xNtDXDzEsk0bckZaDApxLaf8x+vlM+DfEPGi
 u6pQHRG0rwnz2H+oIZesPi+BCon11uy1zCLI3wtuAxK+eXarCV77+QoLC3Nd2Gs1XdWl
 NnT0iMO/L5IA04yKtiYgY2Bu+HLgJNXoPHPbBLFEitc+ALLA/lfLRBNgAiy1eGpRkYy6
 cqfqJ+KYxCmCHlOirQMRKe5RLSb3D0BRaLk9Hg+9pvmy2PapfGnIXwfAlyaYOlwb0gQ6
 oWKeDEpfC4dqsWPthLJvDXBM9T7P2H/klBTUzt0ENP9zLPoOHD2G+dfB2esoHRCiUhES
 F2Dw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kgJusP85SzixuR/TmuIx/b1pBr+0izV97OiW6IAVedTkd7INmxSASvNkJmG9Nh14uafzPobH+leI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNZH7z8A0BlMFz98JEF+2b/mhyw7n5PtJSI56+laE/V7nUcY7s
 UxBaBFNPok8J42pkatmOWKZ99Z6zZ/qkT91RdrIzopLmmLmhpqNNikrs
X-Gm-Gg: Acq92OEPywVP0/vrf+6fuN6EeDo0vLzuWiPxKwgOHngdAUhpP8z8PWxaqS0zxPF+Gfw
 dCq8yYBRRHnVQ8OF/Fc4D1RPmylBLwSYac0giR7iGnfE1B6yKrM/4x/peR1Z4/vPmwE4B9oYzC2
 no1CHxGPvHDK0lE30dIkGRuTE7JtjVhL0CEOjZ7K4z9vi4jDYI62eZe7jq2PgW0nzh6U75eBJ0O
 Sv5k49+X4AowUJcgQYuhLgDVnaz1vSxUiXxfNtSwNHiOtM7HzeX0OxbvakrkeWUo5gffOna3Lgm
 RFraLCk40MBwiapbZnI7F02NPXywolDwILIKQVXVWn2WSnV1JsrjJpEYDlIaK+GlRwofv3rhG3q
 L9vXgwM7vR7G62zMesoJag6SR1lK8qz+Uh0cv+l8ZFUWvXxoTlD4ncsiSuAQL8F08oSzJNhX1d1
 OW3FAVkfgBb/Vm3SNSPu/2h1Y=
X-Received: by 2002:a17:907:2665:b0:bd1:d549:decc with SMTP id
 a640c23a62f3a-bdd23af346bmr1376086666b.20.1779976314604; 
 Thu, 28 May 2026 06:51:54 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc65da3bbsm723636566b.52.2026.05.28.06.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:51:54 -0700 (PDT)
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
Subject: [PATCH v2 4/6] mfd: lm3533: Set DMA mask
Date: Thu, 28 May 2026 16:51:21 +0300
Message-ID: <20260528135123.103745-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528135123.103745-1-clamor95@gmail.com>
References: <20260528135123.103745-1-clamor95@gmail.com>
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
index 519f8c16a3f3..3cfdebf5fb52 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -526,6 +526,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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

