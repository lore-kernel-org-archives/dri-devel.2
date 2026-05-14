Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D03CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9674310E0FF;
	Thu, 14 May 2026 08:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="KjRwMCDq";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D4810E0FF
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:24:46 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c798fc1a28cso3653801a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747086; x=1779351886;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4mgvCm8MfJh47lqaqPNfqzc/xfynw7OZOiaI/rFvWqY=;
 b=KjRwMCDq0W9nv6ege5hr5/SNXvlf+VxC4o+OhToT7X2c5rj19Xrr4/UOkZ3NX1jzO5
 rowRu5HUovREZzuVRxcEO3s7FdopQEv07KkU49POD6Jb+0AFilk6Yr8Z0NgfZpoZhbyX
 4maZSuZDejSK1TBkfjfe2TsCfVaZsgPICzKyndeddzCR9358BE4j7zsFscFvjvXQ8obc
 zgKI368TavFWoMVfv92zUGFzxD+apVJhs4Ka80KpEHLeIg5qjOIP/5fwNn06AMyK+oze
 En1m3/JtbMyxg/6aATIEcJLYsNGV6V5Q+FehBTRvfZrAfp9sobDmheYRdjCAzn7PvMzE
 HE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747086; x=1779351886;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mgvCm8MfJh47lqaqPNfqzc/xfynw7OZOiaI/rFvWqY=;
 b=O+ODF8RTPpcsbBuqQJ1SqnekjPrCFgL5PVnSQ+m05WuSV7ZjdC7jDEi8k0lf9oSfAM
 mzUopvI8kZjMmrirExUhlyo6YtZstKq/SJoutLQDMpSwZmgVZ9Ye4bo1HCwpr4izHB6m
 FBm7kSqCvWZLO5hjXFT5OT4dCEtDhtjR2Yenki5XcI6PP+u9iSeIca6syq+hrIOvlv2l
 7T2jEOqM2LKSNwwkuP4i7pX9B9vsdW4844OBq+GympJr4HbocrbnkD/4CRpD131vkcJu
 x12uT5+WNKfdyD2UIeIOe2tQcMBMz8fG5KJdfbGX7lB9lIX7j+/xsrotJLdsJ7L7kJwa
 v6mA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/a0jRSwFomyoVCKw7fazqMKgbgb70GYmzVr6M67gErHbTQUA2pb3P8QXEDYag8g/EEkQlLKubxhU8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNl9q8PiO7pHdRMvynh+WRGExZguvET/+cs+TBvIO3ZNKgkfW/
 gqnXiZXQWN9pfolwSD71BatvG1eLvKJUc4v6IgUeyUN55MjI64m4N3fRG3UepVKP76A=
X-Gm-Gg: Acq92OEDv9S8hJ5EIVSG4IG6LB+2/MTqq1MWTkyJQjAi/atCnDToHre9q6NMk3zq0i6
 F+QdM9SYMGC4RJg9YTyGBs5gr6yvChsGIhJwmUEon9R6RD6EZkYooGn1Sp0F6Zx4cBs5MBZRrnG
 4GRcsnbepAwO/NxthcbXs4mML4PShnBPBWIXARM1nbx7s/BwYNxrTk+hBReLL99q58DT2eEvthC
 2IkCpeXctn1z50YYoUn1AF0kItYLdHzs9PccHSdiuyc2MduURpWQiYNwVVWcpc78vdoD8Unrk9V
 q0mQb1bjCOzSPkYFvPxhbL2VzWBOJ28+HvRtAL4+CvC0fIcbWX8c8z9qwGFQlsKtVAvNes2O7JS
 lGv8yx26EqZ7Fk/77NgqX7hJpg6ss6pzzxBqCjEOG6XEfma6UwDk44xNjL0oc4NYbWuzn+6UEnK
 zUHAc8d3TWD8mA8ved7JVr9eX8tQbgulcU7OoviZd+kJQ25NTc6YWNhCqB8JF36J6l2Rl/xq5Ce
 3+15WjGOikvqIerc98LTUBkRQpQ+mSs2OW/DIQximhcr7jaxg2c2JU=
X-Received: by 2002:a05:6300:218d:b0:395:ce56:4448 with SMTP id
 adf61e73a8af0-3af7f97ae44mr7226883637.25.1778747085948; 
 Thu, 14 May 2026 01:24:45 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:24:45 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Subject: [PATCH 00/14] fbdev: fix various memory leaks
Date: Thu, 14 May 2026 13:54:29 +0530
Message-Id: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL2GBWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Nj3bSklNQyXUvLRFPjlGQDc1OTNCWg2oKi1LTMCrA50bG1tQBF/GH
 kVwAAAA==
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

This patchset fixes some memory leak issues present in fbdev drivers.

Since commit 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
fb_deferred_io_init() allocated memory for pagerefs and returned an
error code, but the existing drivers which call fb_deferred_io_init()
were not updated to do cleanup. The first three commits address this.
- fbdev: hecubafb: fix potential memory leak in hecubafb_probe()
- fbdev: broadsheetfb: fix potential memory leak in broadsheetfb_probe()
- fbdev: metronomefb: fix potential memory leak in metronomefb_probe()

Probe functions that call fb_add_videomode() or fb_videomode_to_modelist() 
sometimes did not call fb_destry_modelist() to free the allocated
memory. The following patches address this issue.
- fbdev: radeon: fix potential memory leak in radeonfb_pci_register()
- fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()
- fbdev: i740fb: fix potential memory leak in i740fb_probe()
- fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
- fbdev: s3fb: fix potential memory leak in s3_pci_probe()
- fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()
- fbdev: tridentfb: fix potential memory leak in trident_pci_probe()
- fbdev: uvesafb: fix potential memory leak in uvesafb_probe()

Since commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
the fb_get_options() function transfers ownership of the memory
allocated for options, and so the caller is expected to free it. The
following two patches address this issue.
- fbdev: efifb: fix memory leak in efifb_probe()
- fbdev: vesafb: fix memory leak in vesafb_probe()

The following commit fixes a simple memory leak.
- fbdev: sm501fb: fix potential memory leak in sm501fb_probe()

All the patches were only compile tested.
The issues were found using static analysis.

Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Abdun Nihaal (14):
      fbdev: hecubafb: fix potential memory leak in hecubafb_probe()
      fbdev: broadsheetfb: fix potential memory leak in broadsheetfb_probe()
      fbdev: metronomefb: fix potential memory leak in metronomefb_probe()
      fbdev: radeon: fix potential memory leak in radeonfb_pci_register()
      fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()
      fbdev: i740fb: fix potential memory leak in i740fb_probe()
      fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
      fbdev: s3fb: fix potential memory leak in s3_pci_probe()
      fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()
      fbdev: tridentfb: fix potential memory leak in trident_pci_probe()
      fbdev: uvesafb: fix potential memory leak in uvesafb_probe()
      fbdev: efifb: fix memory leak in efifb_probe()
      fbdev: vesafb: fix memory leak in vesafb_probe()
      fbdev: sm501fb: fix potential memory leak in sm501fb_probe()

 drivers/video/fbdev/aty/radeon_base.c | 1 +
 drivers/video/fbdev/broadsheetfb.c    | 8 ++++++--
 drivers/video/fbdev/carminefb.c       | 1 +
 drivers/video/fbdev/efifb.c           | 1 +
 drivers/video/fbdev/hecubafb.c        | 6 +++++-
 drivers/video/fbdev/i740fb.c          | 1 +
 drivers/video/fbdev/metronomefb.c     | 8 ++++++--
 drivers/video/fbdev/nvidia/nvidia.c   | 1 +
 drivers/video/fbdev/s3fb.c            | 1 +
 drivers/video/fbdev/sm501fb.c         | 3 +++
 drivers/video/fbdev/tdfxfb.c          | 1 +
 drivers/video/fbdev/tridentfb.c       | 1 +
 drivers/video/fbdev/uvesafb.c         | 4 ++--
 drivers/video/fbdev/vesafb.c          | 1 +
 14 files changed, 31 insertions(+), 7 deletions(-)
---
base-commit: ba2e787b4814ebf9ab5f6a84181678b67eb3677b
change-id: 20260513-fbdev-99a53dc0754f

Best regards,
-- 
Abdun Nihaal <nihaal@cse.iitm.ac.in>

