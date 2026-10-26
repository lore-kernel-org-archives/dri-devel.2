Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12D606A32F
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oOMTLVlv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B636710EC8B;
	Mon, 26 Oct 2026 08:37:30 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA6B10EC20
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:18:50 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-19305bcb72cso1772148c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 01:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793002730; x=1793607530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E6zA7UN4800aROAky49ikegUFLsqpLG7wSuvYuvN3r8=;
 b=oOMTLVlvIi/MwzR1YdnBrHAudgD91MvFDp+jrJfJQx/5ANtFjiB0z6BQjYCghGe4Uj
 ADhJ9ZqF2d0rM5NhqygjyTyDMI55CzYZDLIe/hmZ+2RAV0PFDLO6i/gf9DccVb+dP0Vz
 0VzQQpWHLeS9XRiJe8Y6zprowlTaJG0/xxT//v5iqJvuPLna9A/y/xY7CaxUubY/4wPI
 HypUyvYlJwuS5KJzfnnSLfuqBA4cAjdRSGZxVhMquNl79zxvtiP0dKQbY6FkzUzsCMu+
 ZMhCB1SlPUcgY8M9NhKMUxiaTg+X0gxNzEyzLxUKLhaaHLhEUgoEt1b8e8vo7I5AC7q/
 sAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793002730; x=1793607530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E6zA7UN4800aROAky49ikegUFLsqpLG7wSuvYuvN3r8=;
 b=dP/lMDypSZu98I5A2/1nwbWJP3F1N4o8/MfZMOvUe9g0ZVJqRDMA8KmzpMdFVU5UmS
 8jmLpI0Ma15aNqF4imyNCYRkvjsGV6NFXazdnb3o1YqiMTSvcA0dANh392BjzOmNMhcf
 Ua3OcRH9MbvZtxWnIjpBPFfCqXLb/S4FknA65UHrKXtIA06iOPA5NF+O6uOSEPL8wUyd
 KRuPPakK+MXfxheG33TDaMLrc/+rs8bnomwxgVWmfePUfQh6DXn84g67BCD536SkIzwS
 sXh6hVgtuCIgijZ+FqMeeHezEDg4OQG8apEp10zUFTM6Z8vMGmj5UO2nBCQVBAcJt4Av
 TF0w==
X-Forwarded-Encrypted: i=1;
 AKwUvByL0/1s4OhjlsXmxiRbDdBKuGD9q5TL19Fscrh8Rzj4Koka+J+JnlbrPDpJshYUp7VZsYAWWn3vkWs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYItFxoqwzm7Sf0wSMhex/H+rdKlsYLLurPMDZGWLS4zTEQQQ/Fv
 JPdodPyrogXOiKjfLC6fOXZ4J/cLEA0kd2wqzb0mf+2Cpf0UQrLXY5r8
X-Gm-Gg: AYBFou2A6N6KvIejExK0EdInbm2taWrrsNTyUnNV2d3eOajfyT0qyxlCLa6Uo2JJkqG
 +xq7YfMxmrm8oqW8GTiAksIMDV8K+FDUULhcIGLWaAYoBZ/xlLvJ1wnxiw/YlO1KtB3oQvXXi8l
 jbQ+CZno1LJ+Lpz6jCiXMa1Ki7yA12GETYhwT1XKPEg3gj8FAR8eZhwE1A8a7nGSPwKmSqzPfO6
 C1ry5J8z4stYoEMpFU9+KOrCXwitorlJE3w7V8K8wEtYBQDIaBK48K6LJTINtqzklNNBrMWrZbH
 S1+NxBsnAKl8fL/PGTH8mTBUa8QGmbfVtZAYadfw2qVHaYrIenW8Rj64ic6i1N6H69NLVxQjtA8
 /4CSOXDjBNHo5FBtTWDEpTINswmq3nRjmja6zi+1129jFAmsAhI9McdZ6XBB9ZjAryTLsWHdF2b
 g3VxDLiVBoWV5KhNrJ7mSF8z8TR31i3u7UyYVVTS2pxPd2skWVbpoN535pTE+Sbd4LRKv67KALV
 XeovP9FAuBqDMqx0naIh6O3opCLhNG1PhtNAgGC0jxSn3OL8LtggFdSyCmsUWqLspfiE+2w13Q=
X-Received: by 2002:a05:7022:7e0a:b0:195:9228:50a0 with SMTP id
 a92af1059eb24-1993686f4a1mr10019388c88.42.1793002729532; 
 Mon, 26 Oct 2026 01:18:49 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ec865esm21698270eec.26.2026.10.26.01.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 01:18:48 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dennylin0707@gmail.com, cenzhang@linux.microsoft.com,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 dan.carpenter@linaro.org, Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH] staging: fbtft: Remove unused macro
Date: Mon, 26 Oct 2026 13:48:32 +0530
Message-ID: <20261026081832.60570-1-himanshu.bakshi478@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>

fbtft_init_dbg is not used in drivers/staging/fbtft directory and
since dev_dbg messages are good enough, fbtft_init_dbg should be
removed. After compiling the driver, there are no undefined macro
issues.

Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 40a7567df1eb..16459e4e0ba0 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -420,13 +420,6 @@ module_spi_driver(fbtft_driver_spi_driver);
 #define DEBUG_REQUEST_GPIOS_MATCH   BIT(30)
 #define DEBUG_VERIFY_GPIOS          BIT(31)
 
-#define fbtft_init_dbg(dev, format, arg...)                  \
-do {                                                         \
-	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
-		dev_info(dev, format, ##arg);                \
-} while (0)
-
 #define fbtft_par_dbg(level, par, format, arg...)            \
 do {                                                         \
 	if (unlikely((par)->debug & (level)))                    \
-- 
2.56.0

