Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F462CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A8A910F13C;
	Thu, 14 May 2026 08:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="GW2T3k2A";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763CB10F13C
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:25:41 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c80167f5716so3426282a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747141; x=1779351941;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XqQpLk2INDxanrU5EbiD7pVjr54bhFQM7xaG69RB0RA=;
 b=GW2T3k2AxYBA0m3mcI2iFo6JAY6V+KzA2tWhQseY1OnCySvqpDsk6GUXAsewyFaOQQ
 LPnEBb3TGzjtc+7rMiKWngEWj5/uDndrs0AT8CM/VysVf1OqEUwD0kNRaOmnHir6MFfU
 twCYoPZyYpGtIPkn1SoRfuiKQ4sCMV6qZgMJToesRKDbvo2YQdhrzUNECXBcyqinSoHB
 Ty5jbgo9qwsYuQZYSUFPZGfYx2IC4lDHg4MWCp2Q+jQ47NSZDn7CzhTpAOHOmt711w7B
 farKsvFC+b+ZOuSo7ePXABVe4wQjyfJpGQG/lGnpsLwKPvSX53EHiAUnMC5NW2sMwJVW
 M9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747141; x=1779351941;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XqQpLk2INDxanrU5EbiD7pVjr54bhFQM7xaG69RB0RA=;
 b=r4N5EKguXp9V+9tmJdJAu5Q77/Bf1oxJWPKymufp3LpAcInW//BF3X4tzyCJ5ZVBKx
 Ija2p+rYVZssMPBO17rPP9qS0dzlza9Lb/ea3UciQpcKxuZGlLnq1UfCBk9Pb1BvUgVq
 pOkv8N3IJ9/fJ7UTpJe2L346295GFXRuoan5S1X1FhcHe2M5CiIauNVn/9AU4PU0XboS
 ripS/zqwnIywAUsRb5PRRi41k/gjMmJ0Y6RicMB68pFg7QPyStFShMwN1B/5pkJ7ZA8c
 kifG+mjzEjLx6PW0Re49UXVm2CRwLYm9KeifP9/uACCLIFN45OCFNx7Km1NOeykDL1h2
 DaTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/otSw9v3a9sChbtCnxu0zk4X9t4bEN9iMGPMrPVj0WQWxG1MGG/el5Xr07NewFPLz9HIcrxCCGs6c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1l8X6ixQq7jIYYxpWrD5UIh2nlthIJqZbd5JoI3VmZmN9ozcB
 /x1UVqpULsvqiw6mazvMI1MvrjKi3b6OI8BcrjBdHtNk9yepnAwRuSPA8h4FkrJC0DM=
X-Gm-Gg: Acq92OG78ZFKN4a6GrxkRJ2Aer/DqloxG4haoRtL4rS1CPsQ9nxxvtJbdcZYZOe+1GC
 8DvHsXvpdSnznj/WTRRJBJWDV3egcirRXd/Xux09oLqiOzjwgOBMv3hl0rbo8oAeWb+ey0DN6Mx
 EkLXKWIl6Xq+IE7sP3jWIOmBGt0vvrA7BogL8E7rpi8TE19sJ5TnrIfENfqwi7HUNJMep0cBI3R
 OTrAwHuriivpwP4O+TNcg0qTravLWMouHZAE7RjwEU/9Ppm40jOkOzdq7RJ5luYnflv4WY1+Fwx
 jQ2bJmp87SWwrN0yu6n7ovnKTeVYQF9wq+1OaxczRnrPIGVLIHtlgcbEn2P04dymwFZILkwzuXh
 z5qX3VF7c2Dh6naPaWrjqGOPb3YapvHFWscIzU8Zxhvz0nDdgKCIkfBSjrbpMFZkYWAAFD06tIS
 im98/U2ZnPaQLdE5+kCnkfBPVsry6VTjK9ZiuI6KLSV4jDOwDZFpxxEN4TlDnNv6UeDaTx9t3xz
 Z+J6madQAFR9+hjnkpDYkt0/eqqWSgxf1vTe9SznFmm
X-Received: by 2002:a05:6a20:431c:b0:398:7eea:50a0 with SMTP id
 adf61e73a8af0-3af7f86f95amr7286510637.18.1778747140737; 
 Thu, 14 May 2026 01:25:40 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:25:39 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:36 +0530
Subject: [PATCH 07/14] fbdev: nvidia: fix potential memory leak in
 nvidiafb_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-7-b3a2474fa720@cse.iitm.ac.in>
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

In nvidiafb_probe(), the memory allocated for modelist in
nvidia_set_fbinfo() is not freed in the subsequent error paths.
Fix that by calling fb_destroy_modelist().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index da2d486022e8..7d20c4087aeb 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1424,6 +1424,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 
 err_out_iounmap_fb:
 	iounmap(info->screen_base);
+	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);

-- 
2.43.0

