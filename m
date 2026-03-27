Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515B010F2867
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6961B10ED38;
	Fri, 27 Mar 2026 19:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Qegvgyu1";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D301410ED2C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:39:40 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A6998C58745;
 Fri, 27 Mar 2026 19:40:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B152A60268;
 Fri, 27 Mar 2026 19:39:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A27E410451AEF; Fri, 27 Mar 2026 20:39:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774640378; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=mLE15DOQB0f7iSKKawPwRv0wOdSj7ZQm/qNs4WZOIds=;
 b=Qegvgyu1W8JnJYMq4q9eLQ444VFl4KFsHeFAnV54fbrX2TAkOZxHY/fEN63h9NFnixVQvx
 BPY/SR8goeDPamS3FT1mO1Ce0618hYAv+dH8A+AxV0cRVVFUd1R0qNtaBW3nq3Sw0aFFos
 j1tPyWHNrjgyXimpl2t8zTKnF4DiGeLYw6A0jHKfuktcNada3ozpQV5Nlwahpj65Mv9yiE
 fgaW96uHlfFTAFs10oVGbYOxUCaS8Lp/BLFwVdZJyImUq5bYwaDNDWoxuVOjGiaToehGxP
 piTwwHLfBZKZXCTAqh7bn1/1Rh4vKwWrq3E7EasJ1PwmEfHtrajiw6TSUKhc8g==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH 0/2] Remove redundant X86 dependency for the cgbc backlight
 driver
Date: Fri, 27 Mar 2026 20:39:31 +0100
Message-Id: <20260327-backlight-cgbc-remove-x86-dependency-v1-0-4851c9e95371@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPPcxmkC/x3NQQ6CMBBG4auQWTtJQajiVYiLMv0tE7WQ1hAM4
 e42Lr/NeztlJEWmW7VTwqpZ51hQnyqSycUAVl9MjWmsOZueRyfPl4bpwxJG4YT3vIK3q2WPBdE
 jypdb4y7Sd7Vtu55Kakl46PbfDPfj+AGmm8yidgAAAA==
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

Remove redundant X86 dependency for the cgbc backlight driver. Additionally
the driver is added to MAINTAINERS file.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Thomas Richard (2):
      backlight: cgbc: Remove redundant X86 dependency
      MAINTAINERS: Add cgbc backlight driver

 MAINTAINERS                     | 1 +
 drivers/video/backlight/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260309-backlight-cgbc-remove-x86-dependency-40a7c9516459

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>

