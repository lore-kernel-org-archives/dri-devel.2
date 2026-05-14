Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89984CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F197110E4D9;
	Thu, 14 May 2026 08:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="wwD82171";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 055C210E4D9
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:25:56 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c802803ac17so3487306a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747155; x=1779351955;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hMKbbNZvfD8+3yGZ0ruUDTcJofyUq6ZI9yURAX9o3WY=;
 b=wwD82171ufDfRLj+YOUhGev5I+v9zpeZozkW1j5Hb0+XvQto+mchpPNvWpF4c+j6/j
 n2CNfb92zdfiRnFhSz2QBqyqKPr7fhFXmyNqQKCrq+PbQp3Obaw80y1MitfSN6VnEoyy
 n1ueK61locHh9zcOgGMoE3EG9qy3M0zbWAD9F6yJAaRZTLNCLv7vheA8FJS4YehKqEiG
 gaIkjQul0PEDnPM8HP3GiWSEyDI8ckHDnQd3g8B/keBohThuC5ddT9de7QITO6G5ISkT
 M/0SFVOsw/OjtO2W4B9P3S6rI7HJFSc8CEkq6koQESBdUxyDJzLAZ2GTYPqAW3T4iWaU
 8fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747155; x=1779351955;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hMKbbNZvfD8+3yGZ0ruUDTcJofyUq6ZI9yURAX9o3WY=;
 b=acvihtWndYSkXdstgVCijMBeaon7mcknJ0EkICgl1YAsm0ksILOHvN0jwi5Fkd1qvq
 TehMfTSmnBZJmwJoUHg2c+8QO804P1D4QBwRIIBzFgsdPwjpGAgxsj4BA2/7J5mYOy8u
 ew6tmMg3WEyKTTVtRWIkhT9UB/ilcH/ZRmJ7b4wRUrPWf81I9isfVHv5Oo8U4AwJgBxY
 leRrd8WTwLY0olKbMtgdSwP1nltrqxYlavQcVyx/9QmCXI5ACc9GQdzKjwJoWBIPvsj6
 ZjBBELUZZFFQrZJ1SB3GPI7v3qr8unlKvMPpsnjcZa5evt84WXC0Wp6+j080+YGRBwkI
 ZTTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/srPosoAEwGGxG90uYuHXZQKgODECyDxoVUaS7iWEF3IPZC9tqhiiOKD5lVMoWzSE0LqZVSe1PU/4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYHPCeGmhK0yivvxPHcTkwdd3zxg9mBHHPSJ1sLkQULXYuv3jc
 lUe3dwAIO02LjXnuPo7FvJ94tNlci+m1WwbnwDfz4uVjSXolPJIPvlM/3rQ5A11zwkw=
X-Gm-Gg: Acq92OFToZr+01dqZXFi8RJW8ppd87OjevjK/hiFlbEfqYdBoOdRlr0qn6HPBVYy0yS
 AFV+zdsPEXzjmDxJQNHO1hRT1//r4pt0VwRsa3W9vtLkZBzm16XIQyhwGvEOJYOAfxr0f94Mf0H
 xsBYmROGWXvhmFwY6T+mWE9IrXdfrtsT58EXK6MVhyjWc1lcK3CT8Ri+mZz7yoUBjRxJAQjwuhX
 ehl1w9T3UhCIFrIvaUKPw4AFXcHY3QqyH0+Fd3BhCb6fJCJDvsSkTuwXSXEpIBN01O3Yd6yyrpo
 8rXkA0CgZAgSZG2/PVWUe85nb53zXrdUvCU4rh5RHavgyChgg5iGd6/PU065o3VuP1oKNVXY+AX
 pdLgoHYHFpCSsCGLQqerjRIl4Qj0GE0ZefnJtgX+CHmHPot10DTa8teylyrKFE+HO5mfvNOYrGs
 9qKgYYz8E9SKjMw3zojKBkUv7K7DOre8QRY23Kb01FxGAYpdaDJPRpHu2xPYr3WbEivgsjkTCu2
 w5PO1mwaL+2UW4GmC8cddDgUV7fwAuYAEMp5HniyceR
X-Received: by 2002:a05:6a20:7fa4:b0:39f:2b9e:e472 with SMTP id
 adf61e73a8af0-3af7e835015mr8274496637.3.1778747155351; 
 Thu, 14 May 2026 01:25:55 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:25:54 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:38 +0530
Subject: [PATCH 09/14] fbdev: tdfxfb: fix potential memory leak in
 tdfxfb_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-9-b3a2474fa720@cse.iitm.ac.in>
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

In tdfxfb_probe(), the memory allocated for modelist using
fb_videomode_to_modelist() when CONFIG_FB_3DFX_I2C is defined, is not
freed in the subsequent error paths.
Fix that by calling fb_destroy_modelist().

Fixes: 215059d2421f ("tdfxfb: make use of DDC information about connected monitor")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/tdfxfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index a6b63c09b48f..cc6a074f3165 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -1552,6 +1552,7 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 out_err_iobase:
 #ifdef CONFIG_FB_3DFX_I2C
+	fb_destroy_modelist(&info->modelist);
 	tdfxfb_delete_i2c_busses(default_par);
 #endif
 	arch_phys_wc_del(default_par->wc_cookie);

-- 
2.43.0

