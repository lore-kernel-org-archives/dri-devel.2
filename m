Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C5BCD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2253110F16B;
	Thu, 14 May 2026 08:25:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="AsXYk8Qb";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4A810E4D9
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:25:33 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c8025500cc7so5587509a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747133; x=1779351933;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V4vRiLxRbLX8JHWNngfg2YrhJ/NxLEtrCOUYTYRBYTo=;
 b=AsXYk8QbWe8rcOMPkw1mGcxh5yvxcUOhVI0ej0kMvInrihwc4nMu9J4w9wsK7AXQYl
 eyOzbl2f0jHy+CqFsfPiFtuD8JwzGudpgI0ZqRpr8rJzyESkcw7HoTHFM22vWT1+sMUb
 4b73kbjgVvaSO/WeKhAt/OD9Q9fMc1hQFMR7wx9MXaMJrGYwRh5k29pwGOIo9hCA7/YX
 BKDjHhAfbdf5LXt0smWZKYCe69iyBGa9tIS9tnIqzgq28Vr/ltCc1T8uQidfbIaqsTU1
 nkcV42ztSXg/jNpes1ePjLDDYEJUunlXP3uSa3a9ztvXYKecE7EZzEue12Y++MnWEDxg
 81kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747133; x=1779351933;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V4vRiLxRbLX8JHWNngfg2YrhJ/NxLEtrCOUYTYRBYTo=;
 b=JCSafd+pj9MwxdiPfyaP2up9SgKcge/+LS7Dj2lLmkhuOtGjmPjlo9kgIv+fSyfTCz
 0iIVhr0jJQ11zImmQV9rKS/H00wiUmDyGakqLZIMyGIX+rh8tGPiH1PhHB+DFbguwz8B
 6JKNDElW43DZ0zyVWiKPo8XKI4k0/yhoZe6G24xAyNZFs4eoxSNQqzNKWUne0k+AikyZ
 NfIPXk8VbCSyAQWtixdd/yQ80/xLqCGE5zqmmkU2cK6Z5njk1R7gd4RQchNpnV0mUS2p
 hJYMEFNoum9VYeQFTqU1lwlpGqPWdSn7DpIfOwTGuaYAzkhAydHhmkUN8o5WGQAIzUoC
 NwGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MJ9TgnklSWhS5Qj39quWFW4RQwCmgxNZNdPaPn0c1TzF5xUcDDvw2MrapFPukAayxfQJL54yG9Hk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCfikq+IO99XWkagx4xtkYUMoOcpsBFnbafQkb/LWPCJn3OImH
 ytyiimMSd4OVrB/i0tMJLLffGQBLFT2CUDdVSLe9VTKls7WSjru7yrSjDDVgvrTqdPU=
X-Gm-Gg: Acq92OHn0EDPwhj05nnO0qjILfrB/c3EigBvkrzRQ9nuElBn4w9mwS5TtmYsPFRYUmA
 07XjMJwv8l3I8+bRlghHnyfJp9JTmWEAS0vPsYUTm1gvSORM+QGrwXTt8cY5MP6JE+twNMSx+/N
 CnsIJ4k8aqjPwiUxeuDw2hcUn61NtN/OXOMjNP/IfhQ6ty4S4l7p5ecMD9FlP97QW6yIdIEHxDn
 GjL4WnkHmbQkbx27XZPrB5wUyj2XLoPg406+LZD5WGxPCcBsUnS0syE0yeWEjWN4ZztZu7H7cLe
 ToY3jOP3fhnCGcgx3Jf6CllLBWJre3/6YjgPAiSuuKdMZpSiBZdVcEClR8h823d4w9IICKYJjU7
 Bp7ny3T1B3v/ZUeULtqr0pSD8Rw5IhcqUh2fKysgOEzg5i1PrfkwvvMRn+jQZY5205jEQpGEMk4
 KXBW7ZQQdR5uaRlzx3fIS5ZMFZeSK2IJ/6cQsrCnXg+a+xEZgUeMiDinRyMMkwHMMQRswSkJ2i5
 0/382a2bGN/G70/NqWZAtzz0F+htKm/BF1tDMCmMIkx
X-Received: by 2002:a05:6a21:999d:b0:39b:ba95:b127 with SMTP id
 adf61e73a8af0-3afacd2054dmr7947534637.4.1778747132838; 
 Thu, 14 May 2026 01:25:32 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:25:32 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:35 +0530
Subject: [PATCH 06/14] fbdev: i740fb: fix potential memory leak in
 i740fb_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-6-b3a2474fa720@cse.iitm.ac.in>
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

In i740fb_probe(), the memory allocated in fb_videomode_to_modelist()
for modelist is not freed in the error paths. Fix that by calling
fb_destroy_modelist().

Fixes: 5350c65f4f15 ("Resurrect Intel740 driver: i740fb")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/i740fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index 9b74dae71472..c14a19382769 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -1152,6 +1152,7 @@ static int i740fb_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 	fb_dealloc_cmap(&info->cmap);
 err_alloc_cmap:
 err_find_mode:
+	fb_destroy_modelist(&info->modelist);
 	if (par->ddc_registered)
 		i2c_del_adapter(&par->ddc_adapter);
 	pci_iounmap(dev, par->regs);

-- 
2.43.0

