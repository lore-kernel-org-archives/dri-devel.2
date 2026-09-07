Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADB8C79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90FEF10E676;
	Mon,  7 Sep 2026 07:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sDwapPKo";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64E510E2E7
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 02:00:42 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so29018955e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 06 Sep 2026 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788746441; x=1789351241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DODmIDn0ugaIVsoeMJTfX4p+/M5GpWJISoJXth2GyC4=;
 b=sDwapPKoHh1RqV25Q6pgVB9esyRR+s1MGUf2h8BkLXgiiLIkePzBEp63E0J/NALSAh
 7JzaBYvCrn1q7Umv3Q9jr5F2Xp/TH1hBk2hxEO4QJg1d/syi0YtPIoo0nS/KzmcmJgc8
 XACJxOPCLvtN3xaLmhrNmeTbA+6TFUKmt+r5SGZN5YpTupL6lkGQr1yUYI/fKoRCbH+N
 h1H+Iy5stVLJWZB9UfuYRJ4IWdtp8IAU6Xqwr6dku4DNCYuljDBS5emHk2G0nW6Jlo29
 vxb0JTxA3kDwLoUs4045pP4bYEfYK+D1VyG9kOistB2ti0OTPvjlp0Yz6ai5aWvfkc4P
 Lw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788746441; x=1789351241;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DODmIDn0ugaIVsoeMJTfX4p+/M5GpWJISoJXth2GyC4=;
 b=bDGllKYWLJjHsqNx0WN1NNlI0BoXyduu9fAbeO9t0ABwvrT2VTuM4FzkhGwTODKEFl
 omfS+9lmlvFKfNGRxI9Mx4Qk4BHsSc3GPfDef2/7EqKX0g176WyC15DySXVRC/PE3hID
 ymhecGCN+DI60gyB5ERDNC4QgwZH87Wy+j8c+gcjnbDBpl1iu5HHLQi3wam8/7EzHwEe
 mFLdc0L7BcLF96SvrOMM6x/r78azbhdU3SRyhuhwfddpEqbgdx1bkuKoCZt/Gbnj2lD7
 5EBYkgqEXdlvy20uoj+0YUj2hhHSk4njsMQlRiClnZQA0ZJsPN80vuhUIxlwrYuK7dSx
 +OQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4ApaBMFs/Vv/5fkhBrxkgIHyIPjStwr/Rl5o5RCZvKhZdm+xWyHXT8qFFcyQsAi1VvAsTXDDfMGA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mvot1fZ/AM87RYmgGx8SidRDX5r7pytn1hOKIE9CvyMrrbd/m/
 MEX3fdkwkcyJXHx5PjBYIQr5YNqeTnwgN4vSGyMg53huk8c3BophiUjP
X-Gm-Gg: AYBFou26DOv/jGYoRtBpoMoKk5lQcWxD7mnqzngosv5HtGvdqWsbQK3p5vZxDhJsLPz
 z/hOLQCBRhaNaOwxnmmZuuyckCZaH54iCBX2gQzJQfOx4HZg89aktBSwjW416o+O4+uc2SOMtbl
 Wj4wBWOTgqm00CXXzNm3hHLJuRBxqO46rulhJvLfR2kC4ulaFWTk5ZJbfG54CADySllNUsfc37m
 ZPmWQIXzIekFNb8YEZuOzD6EIBAdfVdhi5Jcg7XoaWailXL91HtMfp+2ppS9/H+p9Kh7qeRFNEa
 jEImjy/l/82c+5CrQgErXeISKtdWBu0BbGBrL96G32JdiUMSi1ARlIPypnMv/gfrr49+e85BDtX
 XhSyCrWnGV0C4DgYDiaFCzT6+6lN6vo2IXIYTg7xCq/fceFHC/Z4t0wlHfRickC32QevRMNCec3
 yH2E1OLrWExYVjrotPYpVRibBjD/UWo3958iuGQeC+7sa0+phAYfg6KjuWRXcvMr7I3nAXPMXOn
 pDxAo1QWzTn1KkcykIxeqzOP1yJNhW/2YesirgKuyCCo5tPDz6HiOLJxjtLz7XjPrbxYEJQTFut
 GqYhE3AacMxU7BldIdyCDrVh0qJ52OUEZNVnmMVYahZ4oUMKSEmcPhfKAbZ2GFTS9L0G5IKR9zA
 wDVCOHzmrnWg=
X-Received: by 2002:a05:600c:a00a:b0:49c:ed94:cdd8 with SMTP id
 5b1f17b1804b1-49cf81f6736mr403091665e9.6.1788746441066; 
 Sun, 06 Sep 2026 19:00:41 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain
 (dynamic-2a02-3100-b0c9-3601-9daa-d59e-970b-f46c.310.pool.telefonica.de.
 [2a02:3100:b0c9:3601:9daa:d59e:970b:f46c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d08144037sm170897995e9.7.2026.09.06.19.00.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 06 Sep 2026 19:00:40 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH] dma-buf: Make DMABUF_DEBUG default to y on DEBUG_KERNEL
 kernels
Date: Mon,  7 Sep 2026 04:00:15 +0200
Message-Id: <20260907020015.24719-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:00:30 +0000
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

Commit 646013f513f3 ("dma-buf: enable DMABUF_DEBUG by default on DEBUG
kernels") changed the default of DMABUF_DEBUG to "y if DEBUG", but no
Kconfig symbol DEBUG exists, so the option has had no default since.

Use DEBUG_KERNEL, the Kconfig symbol for a debug kernel.

Fixes: 646013f513f3 ("dma-buf: enable DMABUF_DEBUG by default on DEBUG kernels")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
This enables the dma-buf debug checks on every CONFIG_DEBUG_KERNEL
configuration, which is what 646013f513f3 set out to do. If that is too
broad today, the alternative is to restore the previous
"default y if DMA_API_DEBUG".

 drivers/dma-buf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index 7efc0f0d0712..e4f078a326a4 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -43,7 +43,7 @@ config UDMABUF
 config DMABUF_DEBUG
 	bool "DMA-BUF debug checks"
 	depends on DMA_SHARED_BUFFER
-	default y if DEBUG
+	default y if DEBUG_KERNEL
 	help
 	  This option enables additional checks for DMA-BUF importers and
 	  exporters. Specifically it validates that importers do not peek at the

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0

