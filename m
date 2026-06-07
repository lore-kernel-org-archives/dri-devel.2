Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC2CCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7781910EFB7;
	Mon,  8 Jun 2026 08:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BFZndrf5";
	dkim-atps=neutral
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450B910EB71
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 20:17:23 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-39666ac91a2so44771911fa.1
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780863441; x=1781468241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UI+ati8w10fcpvRpL/lKOmhNvyhEWhByMfjT0Pq9pcw=;
 b=BFZndrf5BYg3Cx5FEtRdnt8C02u+9Ea23iNFjh+WC5VnDwV0isJ5kO00xvQqKbnsrx
 yseN59ktlolfZBsEWj7IkYJ3AgksNoHv8x40PoPLwqRny9YK7v1GqgdbFekXPojnDQVb
 GOwTHyvHm7w8trRm+x/7988JNki5lKKzBl1DskqMQ9LFrZzlzqGzgMHFqmVfdaFRTvlD
 4Spo0hdKdfqjY6+I7WEVRLLdJWvlkKtglDIPStPCpgzdWWzy89YSkj3zRYDHweoYmodD
 eFVpRKV/1kvwH6q4FbxXuwLTVEb6BcXrm0CxpHWXEhBYg31natjuUZqY9ZOUjOY7YEVJ
 FDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780863441; x=1781468241;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UI+ati8w10fcpvRpL/lKOmhNvyhEWhByMfjT0Pq9pcw=;
 b=jqDHPEbtTdLdmLJCrPPivvgbhY+MEk3iQYVCn2oeFvYOVWlmxFlvcrvS6va2BGB5XA
 t16FIgTx4OOXiYXoqzYb3gz88X+uYVwUaL0E6mbdCm/Rwogm1Qd3cO6LRL3yAbY99duW
 XGKTjCAdpKW0CxgjK2FdbJ24QSFksEtcQ1HAfDArrfZr8RsZ7kkrsQKBlFhDEDfLMJlQ
 GFjfg9YLr911mMOXkF9hQalm370hz3IeYynpgaieDLh9Xe4HjldeeljUS4pzHUEPAFcF
 +tTNUoAF6KG7Syta7BI6pZ4T6zcpScRFkPXJYzM6hm/97WSUiZAUKDS84qMnqvWuC+YH
 LC+A==
X-Gm-Message-State: AOJu0YzdezJIvQqhfmZzUo9kvZ+xlxUUs/+TDyQHZvrcnG+pnJDtx5gC
 BRMOget/nAEQYvYyTTuETlry+MIZI15h8NVSd4SU1y0KauJp9vy41IDF
X-Gm-Gg: Acq92OHyb8MggBADgCwmzh933z9z6BfRKPoNV7pHW+YEN4Bzu7GKc0wn7y/yf7xsOiD
 xmL263blNFZV9u580O64morc2vKmRj9qe3YgYpMz4zSzj+uluQpqmIWQJdZdjGhj+5ovvMi0/I3
 QdtK1mrSjd1ZjZWyg2sWEuKwiJTZfP6s1nRKiisPn1+C33KvPO/33aX5ZVzsHYC8KkIJqXPQhy1
 7v6bjl0qLJFr8UbcdBwKysfWZmApsuZu4iwoq5Oq02wW/JbLXYnXI3KDmOVOZjBLOUjmCq4W3uC
 h3fGYqweJ7VvW02kGQUEwize/JqZk96pvdBQcddtugi0ICdpD61DJz7df7F74Kh5/5TgZT7LpvK
 z5UdiAj5ZEVpUgXwvgVWcdk/c25G8rH9d7K90+l4Tlfg/k1M6l6soDjmaJdnb/hRCTHCAyYEqzt
 vnYorfyoDZ3WvgUxN9YDAfKHyFRQE9O0w=
X-Received: by 2002:a05:6512:2c08:b0:5aa:5f5c:9546 with SMTP id
 2adb3069b0e04-5aa8865e0d7mr2689095e87.2.1780863441167; 
 Sun, 07 Jun 2026 13:17:21 -0700 (PDT)
Received: from fedora ([37.113.99.0]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b907269sm3276268e87.34.2026.06.07.13.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 13:17:20 -0700 (PDT)
From: Georgii Druzhinin <ilovelinuxgames@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Georgii Druzhinin <ilovelinuxgames@gmail.com>
Subject: [PATCH 1/2] staging: fbtft: fb_ra8875: prefer usleep_range over udelay
Date: Sun,  7 Jun 2026 23:17:07 +0300
Message-ID: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Jun 2026 08:58:33 +0000
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

Replace udelay(100) with usleep_range(100, 120) to avoid busy-waiting
and allow the scheduler to utilize the CPU during the delay.

Signed-off-by: Georgii Druzhinin <ilovelinuxgames@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de6647d0..6058934e2ca2 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 120);
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 120);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
-- 
2.54.0

