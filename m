Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6975DC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB90E10F236;
	Fri, 31 Jul 2026 11:37:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qEWMhcY2";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C5B10F224
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:37:15 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so1212154f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785497834; x=1786102634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zjX+fB5UFRlHcf7n2PcBZQATegbj+CND3nwA4wOUKpg=;
 b=qEWMhcY2kwLttTXM6qvd6qrw90P2gb6n01bAquuE1CPdiyzVYQOm0JCLbpgQKZ0l1+
 EyoYZbJsjIgWdN6VRwJUwArfoLJOVEZCssBYQOYiO6OFi/tNS7dsngbAWOVhKLdubgYX
 4PWKEyUOxN4nPx8652OV1Vrl26A/wPAL2Vlu7rd+JDvatPa9y5VhrJGyfYz371n660ii
 hd/Uw5bg9A5vkjHylKFM0CpVpp8lYLK44OJRmbOgHnDSVxeH2GBWDL3l8KWgHfxlAjo5
 SQe8NheRpAo7O1p2rtg5JoOndrvj8y/OxcmMp3xd3ckeT0wMZjb92796VmJKvIttowqp
 rXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785497834; x=1786102634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zjX+fB5UFRlHcf7n2PcBZQATegbj+CND3nwA4wOUKpg=;
 b=ek1TSA6pGvP0B7Ij2lDnJF1BhW+67JRZ7/0cFbJnoY50KN4h8GA2Veq0nfoETkgf16
 3VdxAU8lC6xULXi5FvpMt0n7tAsfVrv1srn7512tb7XRt+qPWCS+ogZXgNk+dUt2xcwz
 Iqjs7PwmbttrRJVa/d642TZKhBLuHe25A+mbKzWJ42W/Ow9TVk0Yc3qhOoF2JUEKCQ6N
 wUnBa/jXWQzLXAwMzUWLcHUtKrIqf9ddOY0ECpzgrC8BRGR/F54E6fFZg5cWnQJQ2Fyj
 OqkGdu3z5r2GEctMFRcUiyQWAnh6xwa3ea8cmADJHAdx0BOwzjdYfugPyp4SxiExVdlr
 +ZYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+C2jVEauRc5OWuyL43xuYSLvdvwNGtCB7cMvp2Ukdc9W7nNKwfivYo75J0AX83DPk52KaSXmRIog=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGAD0NA2bapJ109Z2TUnj6Lvtp4Iaimh4IGxYvezqc0nm6tlGD
 WZ7d8K0eFeWcA199A4uiv+zyLKHY73erezzuWO2T2aXdRcnTk+4cI1Jl
X-Gm-Gg: AR+sD11ya5uvTTjAWqUoiD5kOSES5S/MN5US7jTDCz5/0YsJRAfhPu6rr9bTtC5uTe1
 odEt01GX5nYhPuVZ+T4YA8LG8pidXXg6J4ZF71cb//AjOhN+c96AbWs6ZcbiZgn80uaWP4Lsm5O
 SZ0mpTuCor40fBJHRvYozEqNKv5kdvLZzPFkEdpaIzInLQUT8VJ3f2cZRcACqERdTUKxwAE4x8j
 /CcAoabLnfPJ8VJPexXzF6H+hQjTu3ErNVgVcEkDrn7tYvBl3eNMakVYFJGLwKyxNgDqJcz4fuN
 5PwgMIHXn/VvKKvGOgyMQt9tqbjKk28DK8JjFWdkWyOxA7hlY+efPas/k0RBplQ0a/YjMAgHk8w
 PEy3nATWbGU7UAxUli15xec+0khzz7iEoirBrjShNKfxRhJL3Fhxpg7m6FLy0ZN8yCbOVwjxEiD
 nef+T/bpPwLu4cZkIsbjBBvXuEm5xgaV9NsUfx08qDruGN7wKpJSjOcklUejx778Jd4oDqG5Nk+
 YI3zuwaDQ==
X-Received: by 2002:a5d:5f85:0:b0:47f:70b2:7321 with SMTP id
 ffacd0b85a97d-47fd32fcb20mr3516082f8f.27.1785497834285; 
 Fri, 31 Jul 2026 04:37:14 -0700 (PDT)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:37:13 -0700 (PDT)
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
 mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: [PATCH v6 10/14] mfd: lm3533: Set DMA mask
Date: Fri, 31 Jul 2026 14:36:28 +0300
Message-ID: <20260731113632.158440-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
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
index 2a63df034171e..9233da7ce0996 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -479,6 +479,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 				   LM3533_BOOST_FREQ_MAX);
 	lm3533->boost_freq = lm3533->boost_freq / (500 * KILO) - 1;
 
+	/* LM3533 and child devices do not use DMA */
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.53.0

