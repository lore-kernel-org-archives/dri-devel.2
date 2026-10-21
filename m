Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD6606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=X+gN1MV/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E6310FCD7;
	Wed, 21 Oct 2026 08:53:41 +0000 (UTC)
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com
 [203.205.221.155])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC72010E248
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 03:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792553176; bh=G+Ehm9l8Xv95Bx6oKmHAdogDlKOh7ugIKpG8hkUh+Qg=;
 h=From:To:Cc:Subject:Date;
 b=X+gN1MV/62tdQSIKs5RCr+dGrVb3dKBUUwzcOI7ZNWR0srYEDNTPBNiQWlelf2d1Q
 cXD8K4ENETT/Wq01CkmqWvfWRCy+IJto8FIlvwqQRxZSeiDxX705dxzi12UD+e0KmX
 VY0UBYWmHLv9OCGlZg2Wxf12Dgrt3lU/gRRqn87c=
Received: from Liujunyuan.. ([218.106.117.235])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 68994661; Wed, 21 Oct 2026 11:26:09 +0800
X-QQ-mid: xmsmtpt1792553169tykol0mr5
Message-ID: <tencent_FFC8FA1142CEF600BDEBE1EDF4EC27C39005@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ9jpRfuEWKcN4czwvt/COfC8g6UlvEKtVZGfio2W3eSYLdQ3Tey
 7eZgUuFSxQFyO0YtRWNaRFpGuyTjn7Z28BQ8Ot6nxwuWp1mtWSlS0MM75YoungkdChUSqXZvt5WD
 UuBsXAQbebrZW5ubeFUfcFIaQGTjf9HUBQI6d9O44Ae+BaSnNXsmuX2ccwrBvWntQrNljnexPucH
 +sxMbPDou9fstgEPiStjVR+6hIsarEP9ytp8MRZnPYMSMCJJK+zHgBzIx3fo5z6ByTO/Kx7JrA9r
 tZi70WkGWP/q/wXM3OslVFY5c9hXRxgl/NogrjsRGO4AtmhQu4teoY3QQWSUnqUqfBQaByUsDOnf
 mwFw2zLAh3SwuBGpz4tTkKvZVgMFcrC2znmHNqpVgJA4xMCaaXGLexavxDhKV/AsFwV6SkJLaCYc
 QDl2IxCPMp0HnRt/t7oHjwbVZJO2RISYJzIUSH3T4UwBy2DoRW1ReSVra1cI6Njh+8W1F1X4Wa1Z
 p7jVYv02yUnQoDIg71PWBgSvj3JOKjqGtMKvDdMXPnfwFR4EMwIXaLaYYGN4ul1X0SmKllkLu+BX
 DSaGhodP43SH7hhJWakIvISpv5WMMye5fHOBKKA76+aDGA9uuRtvnrJbQwvIcvFq+6dDx9TNkxAe
 aWvdVyojZRI/FCtgtL9ueI+ZKMX1eOKJ6O763LA4BW/YgFeMalG9uPgc1Z9+V8OhbDoaKtw5Dbwe
 Ub/5AKiYonVw4CpRYUIRJ7EXMyLK89PqBwJcgcZZLdB8Tug130nWUq5Eihc33xPERXjGCsGcSmEm
 uzJ9JwUIwOVOWQ+vovL50Neio/lssWy2NeAgznIPSaXwzRIZtGVmCbTs+jysGcDh7SdHflBHGRJL
 1oHVBJfoHTC1MbJIAhz/y0//VBDYYgVYuOYAFBcb0KmIrrkgmESqv+WenHsyIJOVGkpcH9/OckWw
 yvzCORre0xWewHkuOyOWq+m7CKaRF1W9i2sUrDSiOgjbUVp79v82hD/6bC01QMQYzDGDYjNgi4lv
 biPnp9ukldQhrdlHPZ0aVCkzinkr6nlL5U30Qh57E1dW4PTgru
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: LiuJunyuan <2058432396@qq.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, LiuJunyuan <2058432396@qq.com>
Subject: [PATCH] staging: fbtft: use scnprintf for fixed-size text buffers
Date: Wed, 21 Oct 2026 11:22:08 +0800
X-OQ-MSGID: <20261021032208.12827-1-2058432396@qq.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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

Replace sprintf() with scnprintf() when formatting the framebuffer
description strings into fixed-size buffers.

Signed-off-by: LiuJunyuan <2058432396@qq.com>
---
 drivers/staging/fbtft/fbtft-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 7925d974de80..f7751b972a52 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -785,10 +785,12 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	fbtft_sysfs_init(par);
 
 	if (par->txbuf.buf && par->txbuf.len >= 1024)
-		sprintf(text1, ", %zu KiB buffer memory", par->txbuf.len >> 10);
+		scnprintf(text1, sizeof(text1), ", %zu KiB buffer memory",
+			  par->txbuf.len >> 10);
 	if (spi)
-		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
-			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
+		scnprintf(text2, sizeof(text2), ", spi%d.%d at %d MHz",
+			  spi->controller->bus_num, spi_get_chipselect(spi, 0),
+			  spi->max_speed_hz / 1000000);
 	fb_dbg(fb_info,
 	       "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
 	       fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
-- 
2.43.0

