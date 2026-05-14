Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FC9CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79B110E391;
	Thu, 14 May 2026 08:25:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="H0cO7Y7G";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BF010E391
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:25:02 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c80291e6237so5544927a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747102; x=1779351902;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7d38f+IaIo+LqPs0VUxtKb87zLxGu6BC7Fyaado5mzo=;
 b=H0cO7Y7GNoetxbbltaIaSiC+q40fN8CR6CxtXy/rIVBiaji7hfTcZJUp6XX8sclg0Y
 huDH6DZpB3HV/ZpSjK065JLdacSPeuzc11v1k+qc5Aq8uV/FQEqGYt4leACf/Pw1Z1o9
 JUC8RMVuHCvV1EDmwNTg4enWDtuzzI5hV+dNabUF27Ou75+D61Zc8Okev0BYUIMCcpqb
 Lt53cB8lo+8mE8OZwuIk1rSkTa6jaDkUP7KbZKMO5gYQ/Cfzb9nqskhErKHOeIEsEkzP
 6DY40tL3tA/F7F1i9bD+XZpcGetDgx7NQPdUi5CxTMpEoUaH1S5d3tTivQJ2WKzH8PfR
 MGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747102; x=1779351902;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7d38f+IaIo+LqPs0VUxtKb87zLxGu6BC7Fyaado5mzo=;
 b=Yt0djxlVOx9DRkMzbX7h3cLlXj/vkTUpZDmxEw5SkJatxHS4szMS8nhyU2vuh6WVY2
 060ZGCsdQTTbAbLTvY0GNcuNRUPwjdLaVN0k5Rdd29vMs7W5P7/jOVr7oWcONReILmKI
 Rejxq/KAHyPWAgEXpAUzMnymFGmbKACwaSbcJ8KjbzDKPQ0BKQQh/ZnCpxe5TXFlG/y+
 7zGLeKCzh//UOOHLwzLv8YSaHZIUNpOYI7wxJYiUh6aC5VKj7ygQhr+dBNH04Py3M1bh
 8PebpTZXV0L5K1usNGrTEAcocVxx2iq0bYpzqkor86wAI0piMSeSIJNfXqMz0B966IO/
 TMLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nsb9o97fo+lUEl957EujAumLZ0Tk5o4IByR8ihRlsiJFC21F6Z2Hjca4BBSHBYpEiZBBrvUj++yg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3xbjzDwAr14UVVkYTm+Ys3rznKesMkv2fxbB0CvzNxZZcxVZf
 G7GyIkeAgMGqOpLSHQu1xwgbPeFL+ksJhFzTD9r1A3KKICVRj8mLBr+SWTDRWeToZTA=
X-Gm-Gg: Acq92OGdMJw8me5sarYn5krWBeQ0nZW1CvhbTz9/whGDIlrsAJGEio08S/k4EvKR2wu
 8y99OFmLzosjZ9bBGT+26ojoY6mbBQz0RQu37AyK6mBtIBdI9953i1NbhUk6fok9Vug2vxUr4cB
 k55qkeR8xWDqtllg/J1VsPLimtyiyL466UnvcMYgGmxo9NSQCkD4OTSbVI6x7DWDt+Chyk4YJ7w
 Qoj3ErKUeedpBxYkP8jRx3Dqs+XCLX1rhO4c2lw26CLazqT+cnAXfP/2txX4FPSI1/GM/tPWeQN
 qteqUa+Ypr3yqff2lbew5vNlSCB9peAk+7dYcV902MzfG+UUqI56CsHveNwN0tXivEjLJBCaLkt
 qz97h3VQ5GSiNGdDFVpjB7iFDX/sSuwzGN/VXx8RM5xo+p0pyGpG9JO1dFlvUNLerExed3IKy01
 6yYET5OLBNbY09K+TRn+vkK0yic7xNTPLscYGvy6ZErT+7LB+1qmN/utYBxkG3lK+4DiBJEIoz1
 PhEZoq+l0WUbfCQ5nKS8vWP+sEj2QPj/QyPjlUdZzvYiJZmUFtILco=
X-Received: by 2002:a05:6a20:7495:b0:38b:d9b5:5de2 with SMTP id
 adf61e73a8af0-3af83e4433bmr7439055637.50.1778747102141; 
 Thu, 14 May 2026 01:25:02 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:25:01 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:31 +0530
Subject: [PATCH 02/14] fbdev: broadsheetfb: fix potential memory leak in
 broadsheetfb_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-2-b3a2474fa720@cse.iitm.ac.in>
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
 drivers/video/fbdev/broadsheetfb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index c8ba098a8c42..582f1ee4c9b6 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -1072,12 +1072,14 @@ static int broadsheetfb_probe(struct platform_device *dev)
 	info->flags = FBINFO_VIRTFB;
 
 	info->fbdefio = &broadsheetfb_defio;
-	fb_deferred_io_init(info);
+	retval = fb_deferred_io_init(info);
+	if (retval)
+		goto err_vfree;
 
 	retval = fb_alloc_cmap(&info->cmap, 16, 0);
 	if (retval < 0) {
 		dev_err(&dev->dev, "Failed to allocate colormap\n");
-		goto err_vfree;
+		goto err_fbdefio;
 	}
 
 	/* set cmap */
@@ -1121,6 +1123,8 @@ static int broadsheetfb_probe(struct platform_device *dev)
 	board->cleanup(par);
 err_cmap:
 	fb_dealloc_cmap(&info->cmap);
+err_fbdefio:
+	fb_deferred_io_cleanup(info);
 err_vfree:
 	vfree(videomemory);
 err_fb_rel:

-- 
2.43.0

