Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533D3C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C85D10E3E0;
	Wed,  1 Jul 2026 17:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="QDB1m3hw";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896D310E3EB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:05:41 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493bf73ec2aso5288715e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782925540; x=1783530340;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gf3UKUdDckwJ0S32IeJydKrzo8cm0OFmgo0J+PNmpU=;
 b=QDB1m3hwnVzEa3jLtNdz/YcRoYSERhYdRYy4Q0KNt5g/sjnz52PqjrsecQYTyOIvES
 a/0XHm2t87cVs9idbEL10lJVgHyyNFVa6XvZuc2dz6Qy96aRMv3LqV30eHXNkyF7uNpO
 uhEU5D5HrOWwYb2WpRDrBds/g2MeXGaPj/+Ir1aWNLo96kHMwsdVirDUvf3LztQAQrrs
 9ySAgqWRQMa8n08kMyjxghDthTKV61ziRrDYoAChBHHKJt2kAmlFV+1U/5VuQe0gARQD
 usJ9+xmd1T4Kfo7pOZaxtTKkEKIyA0SK5huifDKpUf8pLMOcXMGdRImm3TiD8XVjrZMn
 sGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782925540; x=1783530340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6gf3UKUdDckwJ0S32IeJydKrzo8cm0OFmgo0J+PNmpU=;
 b=UebRFmnGvmbrDGfjhyG27y03jNPdbdkJ2zzFkZsLHJ2YlbdAduDRDQsEbgfpy4qVWX
 VvOCvwzsY9CgUuRLXLQs+V3k01ZOzFxj9gzEUpjlC7T/rJHh7Ki9ScZMNj5SGhTxFQwb
 6jdbMyhbWLqXdjXijH2oUB80XdPdgP5azG/X+f0/3keG4/qNZNwFSBR5GeLO3zbDTxvJ
 ybPhGQGytnRuhfYqAlZNycgo5B/mgck7QUrpU5CAvJL5M2dsgr2VH4UMdr8kVgjFtL3i
 p9zhNSv5hwJkBD+qbtOsAh8X4c/TaGWZDqwyTfxWzC3brMBczKXPd1fXxCj5nEXPrTfZ
 PZnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ShgOHiiZ1x/mzKQSM7WlxjsFYqAbsUn+STc9DkWimWyjuV/8SXH5D079GL49E4gS9TK/sUmmUaZA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6tAuy6FjF5/jrjMmz2QLjcdjXPSHlpZxV9oLf1A15GXdCXmL0
 9Igp+U0bfEo6lO6M1JpYmag1WrfLfWYsYDF9hDlR2wPX6C3q55+4dV3FQvc/6aKw87g=
X-Gm-Gg: AfdE7clv2Sk5GbVsSnsaSQzcolFXT46NoJI+IwcIM/cqIqudhq69+oNueTOjhaRTC6f
 8l32c6CMdAlmMtgV0vJnNDVOqA122erDYI8RiFAMkctUmqsMmiXdhEJrwuCQHWWKY3PKaODNvQp
 sYMCsn2NbLFqa1mlc2tXIiL9TgCS59A/TIYwfTzJWjqZFEIBk6RfRf4zIoft+ZUb1MpTyLZaeKs
 XleRQYfwwXBYlOqKhGLD7KDyZCzbYdY3sywR1lpK6hhbVZVhucLlieOW1zUw6GLuSZxTeRz0mI9
 m2w2lRiI0/ygULVIDfPihYv5LNszFAOGnBtGdFJr1Fhwo2sOX8fMyC8N1o4HsyUWlcW14IH8U4x
 7iniaUGsm48TFXpq5AN1zuQqU7ZSJ694TCGi40v9dJjdEm+KrcRsEul0kTFfhHu0FNh+l0aW1Eh
 /9NMfz0QSz2WSNm0CSuFSNbMmZX9ZdB+sjyS837fSF8q98yEp8Tdp8LJgB52yRhEOneacS6+b4z
 Rhe
X-Received: by 2002:a05:600c:6d0f:b0:493:b6c2:cd96 with SMTP id
 5b1f17b1804b1-493c2b4aaddmr23283325e9.12.1782925539685; 
 Wed, 01 Jul 2026 10:05:39 -0700 (PDT)
Received: from localhost
 (p200300f65f47db044d4849b7c2d3c964.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:4d48:49b7:c2d3:c964])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-493bef1807asm58557995e9.1.2026.07.01.10.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:05:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] drm/hyperv: Explicitly set subvendor and subdevice for
 pci match array
Date: Wed,  1 Jul 2026 19:05:20 +0200
Message-ID: <019450ffb519d02821364afca32b9f48bcd8d2b6.1782925276.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=i6kOt2YoYOTS3UNjaVCpuG2OLA3vhViUK1uSLAS/Pz4=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqRUjThIFqHXG9zdoMtK7kK980Ppa+ht6Sofbha
 6k2UnGDf8eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakVI0wAKCRCPgPtYfRL+
 Tg0pCAC4VMts/wpBY1P1Xxjfc9pRZSMqPVzxiIewQ940MT0UEQZeWMqEfHkODhvzG2CoNrvfO1M
 UvGG5vGQ4G7ulx0zL4RqwpGVqRGwv6ZzlVpgMazmBe/w5GT+nktfRYWRMJ5vp/95INopyieXodq
 1lQCn9sKvrivaSqbVwEnDNbwdGGBwtkT+TdiAeD4lYen2tGPALvhoB6xuBm5OHIuVCzs6pJOk0x
 AywmPpLzK2VUbIwPHGVcLo18+BuJFLACqKjxiYo604o9XSdEB3DmnrpnCQEDGuT4FaqvEXnyzno
 lvyx+0i5U1dYo4NqHKStyrbfxz867rFHc4xDDjh3XexFr4hM
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

.subvendor and .subdevice were set to 0 implicitly, so only devices with
these two values set to 0 in hardware can probe automatically. Make this
requirement explicit.

While touching this array item, also make use of the pci macro designed
for that case.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 2e75fb793495..e766d87b7a9d 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -51,8 +51,8 @@ static void hv_drm_pci_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id hv_drm_pci_tbl[] = {
 	{
-		.vendor = PCI_VENDOR_ID_MICROSOFT,
-		.device = PCI_DEVICE_ID_HYPERV_VIDEO,
+		PCI_VDEVICE_SUB(MICROSOFT, PCI_DEVICE_ID_HYPERV_VIDEO,
+				0, 0),
 	},
 	{ /* end of list */ }
 };
-- 
2.55.0.11.g153666a7d9bb

