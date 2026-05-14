Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253FDCD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C84010E384;
	Thu, 14 May 2026 08:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="NijPYV27";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C5210E384
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:25:25 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3660daea6a5so4257723a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747125; x=1779351925;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Cj4tsYfpJn1h72OjlKL8YrS/bESA9WMb/nnrThUnbQ0=;
 b=NijPYV27oj8G8TAo2btHslk1wo5gEwEwJsZ6Q5hamf9x+Oso8uAntqK2qm0kzFqKXX
 pUVXZ5qE9e3jVyFH7ZdNhBwggn031ktB0r7Zhj3kTQsVVe348BGSqHW8vGL06ai4QIr8
 OXI1qMk1G+lhqBUEwqIlS6WzBqXTnmYShszQRpcFXszpgQxSpD6VQoJ1SDUTo0AaUNKa
 ZUCJQ6peAUheBQJFVQalFulVwvqgOx0588EQ+LdVDuBi3A/LYaHtB6MCIVotUdggtbVr
 JAf/mhhuTzAakBf/7fyN9/QQBujAGXyz206SaLzX+lrTAMH6cGw+H9yoxhNh7C+vdjNH
 XECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747125; x=1779351925;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Cj4tsYfpJn1h72OjlKL8YrS/bESA9WMb/nnrThUnbQ0=;
 b=e+KvcXt0xqNymM+CyROqoFtt7mKhLPlwzpVX/3SHOkkZEBLg/hiYQEjhfpCP7roBKz
 +gM9wWDODXelKZGPFy0mmNJcEKOiSJU+G9GB0rl7lC/QeXV7hpAJdGq7Mm+qnmaCKFQG
 nwFaJ3abyDiUoLeaWyBg5uLcqLIr2mRSPi2q8IiCQKe2IFc47vMVwwftxEfC1SI6M/ae
 EbRrL+0p7mE7rrJOw3ZHLLza/zuw76Tza1XUE1FvNihLjhu0K4cYNc8IJaglqyrecUR2
 3CxIhte/VPcgBAqtHiWFP21DoBp7gJ9QlYoidSDGvw6LSZhe2jelqr4NV9LQxwSopqq5
 rwOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9U6uQAf4oMZ3+mBIXI82EYiMyzi3ZH2iiy0xWi4cB+NXmzmDpIZREBouBpVg/WpOuouPM27fbBEos=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHTx0Rp4E01uyG1E/JwjQREG1IaHhTv0tCturEoUvK0ABAZ+Um
 J41e8iHmoHL8wlY8uf7JDM72hrCsdx4t0GZSfoyJ+Z0wTYHj0RJVm8fosyDH/ZeFL7c=
X-Gm-Gg: Acq92OH2uML2ZdWi8QSTebqk791apsqaKvDE0ccm8Hp+3NVs35RnzuAU5UV5jFIRr4H
 sm/dj2UawAZTVRf0hbIy/NAfjiCW2EOQ8kB2TYK1oqqmoX17gqyuhKNoJpJ5Q4foiuOvZJEU+ib
 +GWdg6afmpyLcGc/85gwP/1T8BTekw/5mLscnMKJbX8S6P/o6APIncWw+cVWyFXl8RhT6Kg+X+X
 lMK0d0Pr5ZFyNqutkiMYrcuX14X4rMu5qTqq5hJAV1NX/tCu70Nqq6CPvhZUm8L7WX8bhfHCQ3d
 494vx8Ex8CtiVpLSzi5/0Ih0KpbhoJDmimMm2c62X26Q/zHTVL4EdMZimU/pVaqTiHmrZYNoYWD
 CS9nAmauJD9v9LCXzxC2mcc0/mvT+ZArp6QW6zLvUJytv9uchqiRbcrGAGrTy/bPgmh7rNY8c2k
 VNz1mMLTm4RrTMIAMwj/b99Vrh3KtkbkAhMDkr9HosHevrjnDOFrhFcyJL9xuFJISVLuz2Ghe5J
 s+ZgqfRJWT0ThipIzleB/PfVjGhnpKWippV0k7+ECuP
X-Received: by 2002:a17:90b:2e4f:b0:368:30bf:e51a with SMTP id
 98e67ed59e1d1-368f782f1c3mr6794705a91.12.1778747125031; 
 Thu, 14 May 2026 01:25:25 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:25:24 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:34 +0530
Subject: [PATCH 05/14] fbdev: carminefb: fix potential memory leak in
 alloc_carmine_fb()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-5-b3a2474fa720@cse.iitm.ac.in>
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

The memory allocated for modelist in fb_videomode_to_modelist() is not
freed in the subsequent error path.
Fix that by calling fb_destroy_modelist()

Fixes: 2ece5f43b041 ("fbdev: add the carmine FB driver")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/carminefb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/carminefb.c b/drivers/video/fbdev/carminefb.c
index 5f13f1cc79d3..fca50b7961eb 100644
--- a/drivers/video/fbdev/carminefb.c
+++ b/drivers/video/fbdev/carminefb.c
@@ -589,6 +589,7 @@ static int alloc_carmine_fb(void __iomem *regs, void __iomem *smem_base,
 	return 0;
 
 err_dealloc_cmap:
+	fb_destroy_modelist(&info->modelist);
 	fb_dealloc_cmap(&info->cmap);
 err_free_fb:
 	framebuffer_release(info);

-- 
2.43.0

