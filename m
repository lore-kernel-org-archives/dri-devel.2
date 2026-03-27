Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE7E10F2869
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5553D10ED2C;
	Fri, 27 Mar 2026 19:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="eVdnPTcZ";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E913F10ED38
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:39:40 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9C11DC58750;
 Fri, 27 Mar 2026 19:40:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CB4C560268;
 Fri, 27 Mar 2026 19:39:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4CC9510451AF7; Fri, 27 Mar 2026 20:39:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774640379; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=iPhjjyjp+Si4/Cjy/AMZxhHDxGFBbRdehdgcpegxNhA=;
 b=eVdnPTcZkj+yEj+kOYZQgIHDfPsyXxufKYE1hut4TMxt3NM+syBTvsnfHfki5xAxKw0TYb
 pVaA6k0MroVQJVzX0yRelI6abyD6qY3OjvYbO5GsqYvZpTG17++BNyNQyKk6/aFY38K6tV
 2BLr+iunWEjVQVERH1tpYO94ymvlmf70n7oWSk9v1XsNvh6HNjwHrvZrWi8pONRqKklNQv
 yo7OfLK//TMbEHuu3FoYVTLM7aL9BWjAqNrrzYn/bPDdkaXaX4gRPcOBcjE8lWgCOUflWl
 bFeENandoV7derxAKoG2gBclILlBXx/ysw4Z1QEPROSpjUFxo42TdS1hP2mnkg==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Fri, 27 Mar 2026 20:39:32 +0100
Subject: [PATCH 1/2] backlight: cgbc: Remove redundant X86 dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-backlight-cgbc-remove-x86-dependency-v1-1-4851c9e95371@bootlin.com>
References: <20260327-backlight-cgbc-remove-x86-dependency-v1-0-4851c9e95371@bootlin.com>
In-Reply-To: <20260327-backlight-cgbc-remove-x86-dependency-v1-0-4851c9e95371@bootlin.com>
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

