Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28123FF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA5810E63B;
	Mon, 27 Apr 2026 09:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="k0u5hPEQ";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BEC10E63B
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 09:40:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1488C1A343E;
 Mon, 27 Apr 2026 09:40:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D8F34600D1;
 Mon, 27 Apr 2026 09:40:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 90C4C107222C6; 
 Mon, 27 Apr 2026 11:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777282843; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=k3AGsGSjsAqkFWTdEAPpfBhMkb7kN97LhnCntWK+11o=;
 b=k0u5hPEQMmNRorbJLBK3tzGnBsBAbJvs34AhxMc1vCXAZmx5mYpmt8srUi2mZJm7IqIvfv
 EiO4sRz43Dy6Q9S4OnERh5JpP0juZEdZ/ayXvFqQJxgRla/jfTAaxOE52s+FlDJSXo5nVL
 mUEhFa4X5soEb7qDXf8+bqx2n9P33ynGVUVJfLgjN/OotY09WdoI0sT5k1MZk0utSV7qmz
 fuXFJZBD4dhD+uB/noDhMjGsWDOSfGrSYUjHmuZXABI5wFxDMnb2lwrwVI8YMuElNj09k8
 gqWn0y39h6mRK8NoybzivUVJ9tllMf1bI6VEUaZrfzwuRJeyxzGKcu+0Kr2ESw==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 27 Apr 2026 11:40:33 +0200
Subject: [PATCH v2 1/2] backlight: cgbc: Remove redundant X86 dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-backlight-cgbc-remove-x86-dependency-v2-1-da9f2375a34a@bootlin.com>
References: <20260427-backlight-cgbc-remove-x86-dependency-v2-0-da9f2375a34a@bootlin.com>
In-Reply-To: <20260427-backlight-cgbc-remove-x86-dependency-v2-0-da9f2375a34a@bootlin.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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

The backlight driver depends on the MFD cgbc-core driver, which already
depends on X86. The explicit X86 dependency for the backlight driver is
redundant and can be safely removed.

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/video/backlight/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index a7a3fbaf7c29..07905d2ba01a 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -260,7 +260,7 @@ config BACKLIGHT_PWM
 
 config BACKLIGHT_CGBC
 	tristate "Congatec Board Controller (CGBC) backlight support"
-	depends on MFD_CGBC && X86
+	depends on MFD_CGBC
 	help
 	  Say Y here to enable support for LCD backlight control on Congatec
 	  x86-based boards via the CGBC (Congatec Board Controller).

-- 
2.53.0

