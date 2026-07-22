Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30326C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 22:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8602D10E4E7;
	Wed, 22 Jul 2026 22:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ncm4i5m5";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3240810E4E7
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 22:00:29 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49546c690ffso44324995e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 15:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784757627; x=1785362427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hAmg9kvDp6fcRhAWqYJmRWgkw3aQP6ISOL7nDMeVy7Y=;
 b=ncm4i5m5Ma25HuVN2Dhehixr0/kMVN2Ods/Ms1+c9fNIeDl65/glf6Aq1qB+X46BpJ
 XwpFraX1a4aocv9dUo6oRFuQbZQXQplOV66BGRvCzYT5+4+mM8QN4FnzIFrIom9HY+ah
 ZSXqTGXpN3aTe7pAQNRJcnm0bSn8KvcduRUJXQREJPKkgrwN31xa5tsvE+4SEm7t/lNx
 PM0IFJI7mxvhjh8RNRK4NEZygXubKW3Tq9DbpOFkc5iUU+adbbvNLz1O3S/fmjpw5EmG
 uR5wnaimQ2L2o5oEZCvbV33nYyaZx3hH3SZAa4pfGjqCUMQwkdi5LcuNOtU0/jxudmsP
 c4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784757627; x=1785362427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hAmg9kvDp6fcRhAWqYJmRWgkw3aQP6ISOL7nDMeVy7Y=;
 b=pjzKx+YTDVFMKlCbakCi+LE6R3lN3+ezIrAwDRt1af98+xFzvqKGRJiyNXFjS0AHR+
 +A0sstcnqe2CJrIDP2ac4VW+97ug9+1gCPA94tp6TbwE7Pi2vMKLyZgLywzaksIZx0QW
 Vw2UyH2aeXbiDFAUE2Rzzzzyq989rxxVneCwbZt5B92SxLIHY1gjORFPPgw7pl+XShlD
 3+hmxGPx47JSHadRjZ/EYkDo9a77v4+Lfl7vJhI07OK2dG5wAMVqONohYdCXojQ+Dw00
 2kek3Dybj2dBHoKKaIs9p9Hd2ChJWl5IPGkEHYG26RkwbZ9LSHEpk+wuVofdXySrDPXz
 IuwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGSx29ERoa71n59AaZ4RsT2BgFhDPWxImmvpvo9sWUgTfGp2Ia3N2r04aoA1Et8qmNbNJWKp9hawk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdwFAZ7HLANTsdjnxWBpj1HxG9K3Xa8G+7CHNftScy0+eOgfeh
 EFO9BsTW1tNzYAPrKEHwwrD8tL/hnup9UimflbytHkuIYGxL/ie5U7pT
X-Gm-Gg: AR+sD11eTorL4Dc0IQ1cn1ngfn2eIdzjru9CXSZatN/JmHqc8oV8MFJF5FTiEykmrHC
 940VS2EF7pJZP3douFX2Hjvgq3UZIwDoZw7C663/dzLx92ns5TJxZSdAQ9Cigw5DeJvtSnjSlJL
 sCYTj4eC6k2cr6JSVaPyljUTg7w6Q6nFFRjrLMzcv75Wg0lmQQNppH2v1bAAU/pjIwgBWMhsoQU
 vv4XLoTeWMzOdpEx2ORYJnfzZQKGZBqnxZ/bVjK1cZ0VbZfGfGz1CctMkfgPsj3etoFA6fljqD4
 V6s6YxI9qlsrc/Eq6QTLMtN8qHqXqOycx7PDuCwsp1rPEUbRAqlfqAkcoj2OeSBgDO5bY/609eO
 Z9Rn3Q+yUF8AMdt1T+CiIDPM2OcVIVSjaKnJwajKNRP+xJq+zDM2ngQ9X3Mk7nIVS3zsBw/FH3p
 bFd+DmFRtkVFRi6szeo9eHgdj1X3wS0YlqIvdn0ACqMjFxRu06BP+hMwwsn2+LPBalTQ==
X-Received: by 2002:a05:600c:818f:b0:495:4f62:c9f5 with SMTP id
 5b1f17b1804b1-49573cf6daamr3388225e9.24.1784757627049; 
 Wed, 22 Jul 2026 15:00:27 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b0395f7sm62532245e9.3.2026.07.22.15.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 15:00:26 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: deller@gmx.de
Cc: tzimmermann@suse.de, wei.liu@kernel.org, ptsm@linux.microsoft.com,
 arnd@arndb.de, u.kleine-koenig@baylibre.com, hsukrut3@gmail.com,
 rob.github@jumpstation.co.uk, enelsonmoore@gmail.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] fbdev: replace dead select with dependency
Date: Wed, 22 Jul 2026 23:00:23 +0100
Message-ID: <20260722220023.196029-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.54.0
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

'select' does not work on config options in a 'choice', so currently it is
possible to enable FB_MB862XX_LIME without FB_LITTLE_ENDIAN.

We cannot replace the 'select FB_LITTLE_ENDIAN' without also changing
FB_FOREIGN_ENDIAN from 'select' to 'depends on', otherwise we will get
a recursive dependency.

Note that, if we remove the select / dependency, the kernel will compile
with FB_MB862XX_LIME=y and FB_LITTLE_ENDIAN=n so if it would be
better to remove the select, please advise as I do not have the hardware
to runtime test this.

This dead select was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/video/fbdev/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 085d3a202148..1ed4506c0cb2 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1717,8 +1717,8 @@ config FB_MB862XX_PCI_GDC
 config FB_MB862XX_LIME
 	bool "Lime GDC"
 	depends on OF && PPC
-	select FB_FOREIGN_ENDIAN
-	select FB_LITTLE_ENDIAN
+	depends on FB_FOREIGN_ENDIAN
+	depends on FB_LITTLE_ENDIAN
 	help
 	  Framebuffer support for Fujitsu Lime GDC on host CPU bus.
 
-- 
2.54.0

