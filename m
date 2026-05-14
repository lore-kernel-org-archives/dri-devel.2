Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D118CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E0AC10F158;
	Thu, 14 May 2026 08:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="JQeg3BJl";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D7110F158
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:26:05 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c8025aecc40so3837697a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747164; x=1779351964;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4r44B3WqzqqOS4+0yZVm7MlIZp2ZYEB2HNnv71bMuBw=;
 b=JQeg3BJleDS9ytjWWyKlvfPVJIfK4DbEyEQlW0mOWK3L4W3st0gd4Q7wtwOI5fm6xQ
 xgLMnlahsaJ+rDC5LSpB5EZ4A3FRzba9ilkv+I3cADfoFO8no3yiXzPb0HwZaFFqoI/q
 tyRICj6GS5HjWTPiKQIGcCk4ypV98JQcxKgS0u5akyobs7Na7znYFsN+I+NVkSAnTVXB
 nNVriHKrg7WQfDQ0OO2WYFNCd9GNDhTeN8jDNeHkChnkOHQj+aQwFPoHRFEn1HHLbwik
 hz20yyOGA7Mjv1q0C6lnrNfj188IYzP4YjBmHIQ5+xrMEoUzj1m7Ng2Fwg2rQ6Qr5Uh6
 6K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747164; x=1779351964;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4r44B3WqzqqOS4+0yZVm7MlIZp2ZYEB2HNnv71bMuBw=;
 b=H1L2Uy6GMaxqLhFgFuw1IiAHaMA90RHCsA0bp0r8ApO0U0s9OSCB61DXMljH9DtH0b
 6cNfK0hR+zplC5/pbDmI9ZqnweRWI8wefiq//OsRvKBv8pTqJJRYTMahdYWnEnRIGArI
 nNcQ47y7ck1Y/UzNS8jt2Xx9MhgHNBCorcIG96ahsIamoBLISx/JisBy0mYYi69mZ0Ot
 V4cRTNMZoF7m34WojHgz9bXBCah1L1PjSvFJ+oIjyogps1zLC36NiQcU7iHjpPTY2ufH
 yaWDbkxx28XQ9oWFI+2YszjIqmXzLs5oAD8IsfHWytFd2QkZxVAgiR01Kx4eXCscyBMk
 rCJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OBsHWjmvyZ3uYKBSTwvu9+qoFPItcF960g3RNQ4SL6KgjDZSYZa3gjEVp2A+pY4H4DuWSj+NCx4M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywpk+eB0dWN5kEiCf+rCYPk4AmTH0o/8FSGik9JADH+BbMFEzlZ
 kQ1NN3rQonyDvdigAyKoix+5ZR0mJRgkGsR2eWMOpThIyVMNoX6PWvNJl/qk4hYBYDI=
X-Gm-Gg: Acq92OHEY+uR15uRIuNx5wxoLcpnZ4ql5vjOU2Qqgs+ux9o/fcPUITEmvcyBtne0/oA
 UpM/ZbDdAAdzObB76GxpdRzC0MzJXmCGr5wp2vH7FYXzlOhRy1WIHZWjuzK6Q4KhfeA/JQAujGo
 y0/F/UVhFQ1jodMrSZL9oELgErrTRUjzW/dSXw+mHUXtIUYNBBJKTUYfLSSbsiMtiDumJ/Mi06j
 VTG0ABnTAlE8B7wzHWol5pQCXQ0bg6VmIrhruLXi7RbwUor5fDMhkHzJNY8SOJYFvxEpu9/2HSD
 Est5EAexDrPZY2dm9XpgtEI0Aq54b8XMsGGuf0iDi8OqW8ebmNwRLAVHQDV/P6+c3SdICv/NVkG
 zRm/aM2VznqEIHD49nFaVpYDxm2pCHs81c191spMe9nRC0qhEUcwYLh+6TZg32sB/nV5PaeyDqC
 HaXez3mQ2DMMKliB2PDfidCyPVTALBvclGxWhUqnynkJJchafAwjPc5ax2AQw6uFP1jCyydIjB3
 NITSi/ea4tKd9MqN7lYaz7o6SA3oau7Bcq/8HBt2zbw
X-Received: by 2002:a05:6a20:ba07:b0:39f:c93e:c7f7 with SMTP id
 adf61e73a8af0-3b0bacce1e9mr2039565637.0.1778747164402; 
 Thu, 14 May 2026 01:26:04 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:26:03 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:39 +0530
Subject: [PATCH 10/14] fbdev: tridentfb: fix potential memory leak in
 trident_pci_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-10-b3a2474fa720@cse.iitm.ac.in>
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

In trident_pci_probe(), the memory allocated for modelist using
fb_videomode_to_modelist() is not freed in subsequent error paths.
Fix that by calling fb_destroy_modelist().

Fixes: 6a5e3bd0c8bc ("tridentfb: Add DDC support")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/tridentfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index a8fdbae83a80..9f055ba776c8 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -1706,6 +1706,7 @@ static int trident_pci_probe(struct pci_dev *dev,
 	return 0;
 
 out_unmap2:
+	fb_destroy_modelist(&info->modelist);
 	if (default_par->ddc_registered)
 		i2c_del_adapter(&default_par->ddc_adapter);
 	kfree(info->pixmap.addr);

-- 
2.43.0

