Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C94A10F2867
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686FC10ED72;
	Fri, 27 Mar 2026 19:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YBP/iJgv";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839F310ED72
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:39:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 239871A3029;
 Fri, 27 Mar 2026 19:39:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EE83660268;
 Fri, 27 Mar 2026 19:39:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7510210451AF8; Fri, 27 Mar 2026 20:39:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774640380; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=QBXw6xFuqX0scA2nxRBDxbSxByrStwiIMm6x28ahDaY=;
 b=YBP/iJgvKAkBfLp6+yHhmKTPpVUrD7qTUx5pt47aKDs9zzGmXGZ8mL0JSwkLXHe5jGGwCP
 hw2JZyAxoPhvGDJ49xyVzFsN0JQV0q/FcoUXWnXVeizyJsFc00/BaZxBJXn+N8N+GOmg6x
 T/W/DyO3nj9uPCPVTkQdNpxwA/U5S/xj1GLAYf79BgCEqXr2OX6Q70OEDHTGlTTBQTxGDO
 KdD/0c4LlVPTIJu8rSU+BKe8tIokKujXWMEsDL4RyM4hhQnD6XF2HDV1rrcMN1e4dJEc6g
 ynvrDIZoAa+awVPREGqyfoA4J8UcwCGppqzMiguZraIx8zysaefgOstMpsLyYA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Fri, 27 Mar 2026 20:39:33 +0100
Subject: [PATCH 2/2] MAINTAINERS: Add cgbc backlight driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-backlight-cgbc-remove-x86-dependency-v1-2-4851c9e95371@bootlin.com>
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

Add missing backlight driver in CONGATEC BOARD CONTROLLER entry.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d10988cbc62..c210dbb94459 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6476,6 +6476,7 @@ F:	drivers/gpio/gpio-cgbc.c
 F:	drivers/hwmon/cgbc-hwmon.c
 F:	drivers/i2c/busses/i2c-cgbc.c
 F:	drivers/mfd/cgbc-core.c
+F:	drivers/video/backlight/cgbc_bl.c
 F:	drivers/watchdog/cgbc_wdt.c
 F:	include/linux/mfd/cgbc.h
 

-- 
2.53.0

