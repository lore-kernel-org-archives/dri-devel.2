Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6649CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F3310F150;
	Thu, 14 May 2026 08:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="zNVyIa9H";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B3610F150
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:25:48 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-36627a0ea23so3165241a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747148; x=1779351948;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U8JuFCRwwrvf2GMkTB19c8/MiJ4FqDOCW/ASwDDZNHk=;
 b=zNVyIa9HZQgsmQ0KQbrobS6BQpO1lciOoQrBcz1LhJZNuQ0jY27wdTX7fXg/YM8/FW
 HrQHnIU9mqhzmNZea/I1lmoJuk1g50WCGqfvqm0J9HiFKSlnKABXUzUl67FfxFgQVV+1
 HIw4QezO/vCn6l0zQmApkWfdCXW3rf0umbwnp6Re1edi26qs7fQAO67py4SXlnQew/BW
 2+w/0Yf21+0Gvtheaeif0507sgsnHgc9BHTjJbVvVCCCImAGn4ZFHv1S9tH+f6zBczbb
 VxzFVZL3dTLakUvTas1qcvmVYdghUsr70JSDkifsTNr0Us8AuF3A+RL3D/erp+ec8JMS
 gF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747148; x=1779351948;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U8JuFCRwwrvf2GMkTB19c8/MiJ4FqDOCW/ASwDDZNHk=;
 b=OKhXq0Q7icCK+fYR2BTANz+nvU9jEGzDpadlrBvVEgrH+b0clu873HiX+NuN9iujIe
 KS9ivrovq43RkSeaXuy0oVqDDzVOoq16T2oi95f11s/9kvjiy+hYhBdj2q4uOLQ8LlQI
 99aEWDxCs93RBbLF3cqnxUEbu8GJKd49TWVyBbAfQ5m6DFNlFh9KOeNDofS6NIXJmjRo
 zgRYK0LGzFELKWIaqBoeNrQb2oVB9MF03eU9gzz2Ikb+d56vPn5PTCyDz8x44n5dbbrg
 +do1I2y6VdELHH/nipOfmoLlSSh5AIR3ynll0v1XWJxezpP70DGD5Rb1MXPxbUAfUPQH
 uLUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8lS+rbBTIo6Zf6RiX6uss7Jp/VmgY6ftgoD6SXlub6juAfD/njXMFB2skgDyZOwcRSR3xECTHR/A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoxI2N9AXOda0c+c13dtO4RjCiZ2asdZI/WpGEP++pMZWJVBoa
 NC1/cJ43uI2aWX4pvmvQ8wNLlyAsnDdhwyIVzlCIn+BOfpCdJAsFwMUYTpFEVhgU6Tw=
X-Gm-Gg: Acq92OHlmhXpUIpUDpIiz8KdamPrDSGKdZIax+iqzvZUBcSgS/lzJZ3c5t4bNhuqtss
 kKKOPCjntzBNAUbVmKSmOzi3FRPfFZDZ/PO58qbQciGMJkD5B8RLzKnQcxjRSI6fs8RDGSU0O0o
 WgzHcseXhOg20LtajKPqgf7IvxpwGLzg7Q1/SGA98kBqHrfPkBPCqnu0b91VNdTdr0IQ9ZsCx7Z
 0EnsGSTg9jRR7v/f0jWwp8BL10B+W0iiVn2J6/FwTHRH5eJ+vKVzMPrVnKXh4CQSABR3lq/KqOY
 pnh+AVQ8DCA+RfZUy/2GFY+5FpEJdgCc+sSQC37UsqNNHbe5pFgGIUka2MjNkAA7qjkt0m1j4Xt
 EvBF0Jvcq8wMaSiNlIseavxj/6RZkAK/MTZajNNKP9RRoBFDv5iY2pmemhBH2vRoSdQ/qhgRhif
 17lTuGYWYqfXe3G7/O08qxUlXJq0hJPUvxPhXEwOWnd3wj4ry/NERsDjSaVOpj1UZJYovyV0Ecf
 fXvwtUdf2Oit4RKdmh5KAjWcw6+14XrMjaQIUczszJVaVc+hqnKq+8=
X-Received: by 2002:a17:90a:fc44:b0:368:4cb2:17b8 with SMTP id
 98e67ed59e1d1-368f40835b7mr7602543a91.21.1778747148094; 
 Thu, 14 May 2026 01:25:48 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:25:47 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:37 +0530
Subject: [PATCH 08/14] fbdev: s3fb: fix potential memory leak in s3_pci_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-8-b3a2474fa720@cse.iitm.ac.in>
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

In s3_pci_probe(), the memory allocated for modelist using
fb_videomode_to_modelist() is not freed in subsequent error paths.
Fix that by calling fb_destroy_modelist()

Fixes: 86c0f043a737 ("s3fb: add DDC support")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/s3fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index 831e9e6861b1..dc1f9b627185 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -1446,6 +1446,7 @@ static int s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 err_alloc_cmap:
 err_find_mode:
 #ifdef CONFIG_FB_S3_DDC
+	fb_destroy_modelist(&info->modelist);
 	if (par->ddc_registered)
 		i2c_del_adapter(&par->ddc_adapter);
 	if (par->mmio)

-- 
2.43.0

