Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738BCCD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D234E10E3C3;
	Thu, 14 May 2026 08:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="eU5w4j3c";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7323210E3C3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:25:10 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c796163fac5so5662287a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747110; x=1779351910;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cETLUD+cFYpJj1ZB4GUnM/Wn7jURn1pWYkE3ZLuZekk=;
 b=eU5w4j3c5dSX+X5WnGEZ/2pck4aY0jlKrOszqwe0uOHlM+WShiLmeJPPhJtulyoYV1
 8JliLLoqPIANLhTHk5B3b0UuQB5Z0uPZLe6V04LAiOBDu0g9re3p1+JAsaX48R+tYfEq
 1rlT0dwyHt2xOylDBIR7RRmnJ+caU7cFtz6tc6qrdWVbUjIcsKKQPccjomg25eNWGo0s
 69tmrS2rCU959oaNj6sax5WpPwvTVyuqOzJxm5tVmIqlGiFydzR37qllwwbcmhoEO0yp
 oyFPOyj1+W+GJMCDZn66oaRg8/2q41mj1yFQpBtc2Ktxz/fFlpIy5udLId0tvIbqCI1b
 zYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747110; x=1779351910;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cETLUD+cFYpJj1ZB4GUnM/Wn7jURn1pWYkE3ZLuZekk=;
 b=GBj+iD0rwuAdOK6gAdlt/P60th58W3OY5DT2U21BpqNgEXkvooTZSQvsTjGHJ83lry
 fez/E59uMdiUmilbhw0rPVyAv+KNjqR5w4yweOkzApxCzxyp0tCsYoJhG6pwN+aigvr4
 Bok9N1MhqiDM/Q+aqsjq5htSiW1RlQYr9/9bKmDTKYzJ1cZJPJD+sg0hMK44K1g8SeoS
 TRmTXGmEph1HwHIRuOKCHUG6QrRViw1Mvu37uWZWRi00mVAT2nmzwZkUJnntjly3w3iJ
 cAiq1E9De0drDhyEQkMP2n8FayA/HAMr5Js/RdhWzHAgVS+ebWDECbxjR8rERxRDoyBO
 plDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QxlzeioGM6zG1hCxNMEICiCEVAvM9Edz4Tjeiv5aMS+U2w9XcVBDFzCmYTbMZKBcxiKSeE1JL6LU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqvjnRfVf7GDBdC04GYq9nUsSH1N8YyKx2QjvIauJteHnv1pgk
 tT5ekTW4lzgvkc8PXmY9sxOmS/7gOeRTgdEcp4e64TdxYXJNoedfxGt4EmJcdLjihqY=
X-Gm-Gg: Acq92OGlAOx58clrZaJwxfq5fC/kaC4QWbA6omM8uUk8TI/36bGLDsJLT6XIk9YcN7F
 zveG5gDa+rcBNRfJ0fe9nhopbGmVx0LBecr2J765MpYIdVP/iFd3nk2UDLkRq013TEEHdmLm313
 4aXJ+sbjZ41YNYTd931GDndd28Sq4ufQmZdoImfNo5QVG3SGqlsptyXC5ysP5pMYaR8REEPxeSe
 9tssAf4CNm9BO2p5QTKkFxmg8grL9U85AyFWrzm7SwTCajYZsplRaeYZiXv3H2pJLa+j25cMXvS
 dMW8X0lmZSCrIZQkl7J+0lQ9Phtr7P8SXtux9XQ+e7jriKGB/PlY2qSDWoDRMztkEH2awR4fEaO
 noHGFzd0vC3DA8o3VBKhM3KGyCs6db5bn4ULLDTcEODeWyTVzM+h4p2ipvZ/SU0M3+MB7AfDVW+
 Oj2+WDe6Yp55fizGtkIWcsEN7rNyAGcvD/Gl2/fjzVJPJmUHWNp6ZlfipYilCRlbrLdSFH4kTlW
 z38M5bNx6K19dPuzvDn5n5TQ/CzwftFVes/AzeCAgig
X-Received: by 2002:a05:6a21:4ec4:20b0:3b1:8cf6:8f79 with SMTP id
 adf61e73a8af0-3b18cf6979cmr603100637.44.1778747109771; 
 Thu, 14 May 2026 01:25:09 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:25:09 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:32 +0530
Subject: [PATCH 03/14] fbdev: metronomefb: fix potential memory leak in
 metronomefb_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-3-b3a2474fa720@cse.iitm.ac.in>
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
In-Reply-To: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Siewior <bigeasy@linutronix.de>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
 Ondrej Zary <linux@rainbow-software.org>, 
 Antonino Daplas <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, 
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>, 
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0
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

The memory allocated for pagerefs in fb_deferred_io_init() is not freed
on the error path. Fix it by calling fb_deferred_io_cleanup().

Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/metronomefb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index 6f0942c6e5f1..83c614963a0a 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -645,12 +645,14 @@ static int metronomefb_probe(struct platform_device *dev)
 	info->flags = FBINFO_VIRTFB;
 
 	info->fbdefio = &metronomefb_defio;
-	fb_deferred_io_init(info);
+	retval = fb_deferred_io_init(info);
+	if (retval)
+		goto err_free_irq;
 
 	retval = fb_alloc_cmap(&info->cmap, 8, 0);
 	if (retval < 0) {
 		dev_err(&dev->dev, "Failed to allocate colormap\n");
-		goto err_free_irq;
+		goto err_fbdefio;
 	}
 
 	/* set cmap */
@@ -673,6 +675,8 @@ static int metronomefb_probe(struct platform_device *dev)
 
 err_cmap:
 	fb_dealloc_cmap(&info->cmap);
+err_fbdefio:
+	fb_deferred_io_cleanup(info);
 err_free_irq:
 	board->cleanup(par);
 err_csum_table:

-- 
2.43.0

