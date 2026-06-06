Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE30CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 21:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A46610E8B3;
	Sat,  6 Jun 2026 21:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=runbox.com header.i=@runbox.com header.b="el9IRWdA";
	dkim-atps=neutral
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com
 [185.226.149.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA8110E8B3
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 21:43:00 +0000 (UTC)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
 by mailtransmit05.runbox.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <david.laight.linux_spam@runbox.com>)
 id 1wVxbr-007cFp-Gp; Sat, 06 Jun 2026 22:27:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com; 
 s=selector1;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From; bh=GQRWb9tcfRli0dIbDrB6vkuNwQ7FvLjPZHROOcuMtfU=; b=el9IRW
 dAMwyavlsEkSqgQ0M2JWZCNqoLAZGpGtoU7Q5XGmJhqsIXO7k6cKHgdjiCL3e60w9FdAINpVzW5hf
 FIkha+jj/49X2fqhBBAjizFONBNBIjsfFjZV4kQU/cqiVGKz6Xp4pM0GJX5lHjlUmwydJROtefhGM
 r7Ps0APJjhgMclzQZnA6DvkvCQxaoPdX2ve/zgtzvw1GSPdDmw+MNaGSIOF1fLCdzGS4ZYbuD5gXN
 SpmvONmC+I6Ly5LdkYBRFEY8aZI/cinVChlKchHImF3aVAdIBhb2QAQNApBzmRTfybSZW9LfKhZiC
 AY70u5p7u7fV8IkNjpAH+c9UT/EA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
 by mailtransmit02.runbox with esmtp (Exim 4.86_2)
 (envelope-from <david.laight.linux_spam@runbox.com>)
 id 1wVxbq-0000tI-WD; Sat, 06 Jun 2026 22:27:11 +0200
Received: by submission01.runbox with esmtpsa [Authenticated ID (1493616)]
 (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.95) id 1wVxbi-006V18-9A; Sat, 06 Jun 2026 22:27:02 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 Arnd Bergmann <arnd@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Helge Deller <deller@gmx.de>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/video/fbdev/atmel_lcdfb: Use strscpy() to copy
 device name
Date: Sat,  6 Jun 2026 21:26:16 +0100
Message-Id: <20260606202633.5018-22-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
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

From: David Laight <david.laight.linux@gmail.com>

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/video/fbdev/atmel_lcdfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 9dfbc5310210..da3eb5f1b337 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1062,7 +1062,7 @@ static int atmel_lcdfb_probe(struct platform_device *pdev)
 	info->fbops = &atmel_lcdfb_ops;
 
 	info->fix = atmel_lcdfb_fix;
-	strcpy(info->fix.id, sinfo->pdev->name);
+	strscpy(info->fix.id, sinfo->pdev->name);
 
 	/* Enable LCDC Clocks */
 	sinfo->bus_clk = clk_get(dev, "hclk");
-- 
2.39.5

