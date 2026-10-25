Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDBC606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=liEK3AT2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4D110E16D;
	Sun, 25 Oct 2026 07:24:02 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B70C10E16F
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 05:21:48 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso5559835eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 22:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792905707; x=1793510507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VrsetohNIasoINtJjADb3Jjeqh2EUCIwdnh6PcRK+gk=;
 b=liEK3AT20QlHoj5LKUcRkaaOWcl3ehXZlecuDQ9TdGBgyvALsmyK905gPTpawikMkV
 w4irGpTgkki9+Kx4fujHVLzoYokSlsZxDZNrqZcJLH77vXKq6we2ulvjWg+HHMisS1Gu
 BR8nq313qmwo2mDGzGKt1iqHqfhDc9UbuFxWomw7C71AiAxFsQgmXeyx39dnrx7db+s6
 dPu0DgHxRJ971z/TlnMwu6GUrfcE/mpse28oV8mORgbsEWxnq0zKMwwLVHCb6kp4YBx/
 9xwoX5y9fVQnA0B24Y4D303KssrkQCKy9odfljQdcZUSmCioZC2EAnP/wuL4+ZTyrd6C
 3wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792905707; x=1793510507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VrsetohNIasoINtJjADb3Jjeqh2EUCIwdnh6PcRK+gk=;
 b=qcreVq2jETdzzngn3caLTPirOD/gB8Jm376YysJKBHglWQdpDsKO41vBsQo+nMDdXU
 LdGq9lvZjwKjELrgxfRTkLFxdVSSa1LAY05g2uBIRxQD9maWjVUDvIL/9aCSgdMjYUR4
 nR7hO0QjsXQ+HUNzYHl74CkixaJYZ2OHlNW0yLKqeG4+vUgoxqsR4v+nsqADvqLQfglt
 teqUYyb+Jvztx6a0wF0Lg4gMujX9WsGkk5OuH4YgpZbgVXDgtgW1rC1rwe7Qs6jBStnS
 gRBEoKoKN01XopDUPetr1+Co5hRNWNUgAd0Fg4bxIwTY+CAlHpPjpgfV13a+b7hAECqf
 6aGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLwD0EYsE/N3luZ0MHeX1Nd6ZvvJKxrBnPcCjkQvn+VM6cmcIPbNgtlWtcHtKOhDHndjU7nE2Dj5A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIbmNELG6LOfW26tlTOZCLTOOBUqFipahrkUD1MxHxihhWKwWKh
 f9290aqZyl6XlsY0i80dW1xIvYI30cyTCCeBLi+9U9DkXdX8PsEcAzX/
X-Gm-Gg: AYBFou0HyNLYITZmKunGVtNFVFtUCcEqqrBkeBM42ZmVtUz9+nfskWAihQdGyR9Y0Vk
 hc+fk3bnxwhkbRjKJJ23rh+SXIAqI5osQE0zq9s/gcc8fjFm5tk3VehFT97Lw8NhuCt7QMc2FY+
 JkXSpja8skbBSynSUGSYqJZGU+fTfq1YSIjWbT9jxg80fexBT/JAsEsXABMb/OHPemTwY3zc/sr
 z5tvkWxxblWXQ01/l6UNO1xxYpII11qlC6E/Kqgg9QVdLuXCYfpTyGAwuTbWwBIp3jzpsUEMG9O
 fZTUWnzc6Hf884Yd6DzSV6bgkQ1XB1cDZZA9uCNNb/diwDxCyJZO5341mGnoXzv7bTddcsMOYVZ
 lO7cRS4fNP0qXjw5ISiOogzvRrBIXNceExI/b7shse9CrQz9fgjlB7VAp7GjOzBYYE3e9JOHXcT
 E8Ye3P15USA7I1KjMRvy3Sm8wI3fet887PoXb0R3+SFACOHRwBBUEgpspU7D1L/+A/uBk+UBXWX
 IBfgVhe/3emoJNV3m+DHCybXNCvYtCHm5ybA8ynTy2Il1DiqDC2i6ZJ
X-Received: by 2002:a05:7300:cc14:b0:358:1f59:48c9 with SMTP id
 5a478bee46e88-369e84dcb4amr6835607eec.24.1792905707382; 
 Sat, 24 Oct 2026 22:21:47 -0700 (PDT)
Received: from myarch ([49.36.79.131]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ec864fsm15239138eec.24.2026.10.24.22.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 22:21:46 -0700 (PDT)
From: Aditya Nagar <dev.adityanagar@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Aditya Nagar <dev.adityanagar@gmail.com>
Subject: [PATCH] staging: fbtft: remove unused argument from FBTFT_SPI_DRIVER()
Date: Sun, 25 Oct 2026 10:51:36 +0530
Message-ID: <20261025052136.389541-1-dev.adityanagar@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 25 Oct 2026 07:24:01 +0000
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

The _compatible argument of FBTFT_SPI_DRIVER() is never used in the
macro body. The device tree match table is created separately by
FBTFT_DT_TABLE() in both callers, FBTFT_REGISTER_DRIVER() and
FBTFT_REGISTER_SPI_DRIVER().

Drop the argument and update both callers. No functional change.

The argument has been unused since the macro was introduced in commit
c222ea5d2f33 ("staging: fbtft: Deduplicate driver registration macros").

Found with checkpatch.pl (MACRO_ARG_UNUSED). The change was prepared
with the help of an AI coding assistant (Claude); I reviewed it and
build-tested all fbtft drivers with W=1.

Signed-off-by: Aditya Nagar <dev.adityanagar@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 40a7567df..62d5c39d7 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -279,7 +279,7 @@ static const struct of_device_id dt_ids[] = {					\
 };										\
 MODULE_DEVICE_TABLE(of, dt_ids);
 
-#define FBTFT_SPI_DRIVER(_name, _compatible, _display, _spi_ids)		\
+#define FBTFT_SPI_DRIVER(_name, _display, _spi_ids)				\
 										\
 static int fbtft_driver_probe_spi(struct spi_device *spi)			\
 {										\
@@ -319,7 +319,7 @@ static void fbtft_driver_remove_pdev(struct platform_device *pdev)	   \
 									   \
 FBTFT_DT_TABLE(_compatible)						   \
 									   \
-FBTFT_SPI_DRIVER(_name, _compatible, _display, NULL)			   \
+FBTFT_SPI_DRIVER(_name, _display, NULL)					   \
 									   \
 static struct platform_driver fbtft_driver_platform_driver = {             \
 	.driver = {                                                        \
@@ -363,7 +363,7 @@ static const struct spi_device_id spi_ids[] = {					\
 };										\
 MODULE_DEVICE_TABLE(spi, spi_ids);						\
 										\
-FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)		\
+FBTFT_SPI_DRIVER(_name, _display, spi_ids)					\
 										\
 module_spi_driver(fbtft_driver_spi_driver);
 

base-commit: 4a177d5e688e8e82113f7a32d6f75f0bab9658c4
-- 
2.56.0

