Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EFFFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6F7110E64B;
	Mon, 27 Apr 2026 09:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="U94p3vTF";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F15610E63B
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 09:40:44 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1B5EB1A343C;
 Mon, 27 Apr 2026 09:40:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E51FF600D1;
 Mon, 27 Apr 2026 09:40:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 05A2A10722426; 
 Mon, 27 Apr 2026 11:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777282842; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=Te2dj+WEunSegelzjzPHOppUQP1HYC45/jqiWmBk+W0=;
 b=U94p3vTFaouJYr0Nu2bRInSksLsQXuhl86LCMBdv+k/cAoD5uUGDTraEu5nBemB3XUAThj
 7uC5J0vTvO9/6gl8iBisP+QuJ+03w2zfulKTvjkZ8NUo0+qfpa5f1I6TVAQK+pGkt78czp
 Azt2OwpvoQhLqEJhbvosZ+x99ysdzRVwvN4W9+V6M88mvJ74ZEVdNP3nguasqodkL2Sdqz
 tH/YsMyc9MmRuTkQQ+GSQeNIrMZxZ8/f7YnAESiOkAZR26DnFsXPpg5rfARZynvWjndUEy
 WqB7yZaJWMxJR3qL+5RBurUokD8OHC0EFdzWnMab9YwPval7eGe06GLuQJYiCg==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH v2 0/2] Remove redundant X86 dependency for the cgbc
 backlight driver
Date: Mon, 27 Apr 2026 11:40:32 +0200
Message-Id: <20260427-backlight-cgbc-remove-x86-dependency-v2-0-da9f2375a34a@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABAv72kC/43NQQ6DIBCF4as0rDsNoKh01Xs0LhSnOqmCAUM0x
 ruXmh6gy/8t3rezgJ4wsPtlZx4jBXI2hbxemBka2yNQl5pJLguecQ1tY94j9cMCpm8NeJxcRFi
 rAjqc0XZozQY5b0qjlShypVm6mj2+aD2ZZ516oLA4v51qFN/1B8jyPyAK4JBXShiNWmWleLTOL
 SPZm3ETq4/j+AAEVv2H2gAAAA==
X-Change-ID: 20260309-backlight-cgbc-remove-x86-dependency-40a7c9516459
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

For this second iteration, I just added Daniel's RB tags.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Changes in v2:
- add Daniel's RB tags.
- Link to v1: https://lore.kernel.org/r/20260327-backlight-cgbc-remove-x86-dependency-v1-0-4851c9e95371@bootlin.com

---
Thomas Richard (2):
      backlight: cgbc: Remove redundant X86 dependency
      MAINTAINERS: Add cgbc backlight driver

 MAINTAINERS                     | 1 +
 drivers/video/backlight/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260309-backlight-cgbc-remove-x86-dependency-40a7c9516459

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>

