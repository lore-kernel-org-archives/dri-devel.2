Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DEACD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC54A10F13A;
	Thu, 14 May 2026 08:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="mi/uu/Gg";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA8F10F182
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:25:17 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-c802803ac17so3487108a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747117; x=1779351917;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fJh4Y1vJpYq92CQsC3/GcBHFFxqYLe8usjdVpu9K90E=;
 b=mi/uu/GgUb57BIqs9rJSn5KvrfWqgbAOF6545RARauly2N6bqPpweTCWaWrgBskgd2
 jONqC5CSRImuOcEPAkFTjZFBjDeqNjBzq4h/qjUdDdnCJ/zxCsO47eOz4iMPxVWL72qT
 R63VshxmDkK8M1x248Z5d3GpVSLu4tKiV3n+XBXeYjFCYXUuuadVcUKDxsCfZxHSc/Ux
 4PjLDj8gdUSRLE+dc5Ap2BCi14Z7SSovKf73sNZL1yKBy5fDn9xir5l0hFt3doEAAR+B
 B7DrozETqdidatWhz92pPGYvoxgXFy0G+mZrwcN8G9AJULoRNdkTpFN2BmMklTLrcqae
 V91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747117; x=1779351917;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fJh4Y1vJpYq92CQsC3/GcBHFFxqYLe8usjdVpu9K90E=;
 b=OMfTzrtkBROAndnkOavo+u74B+iDGK2sCy2sQH/Fgsce2OEG8pU6xhTa9XFmURSOIJ
 Am+qf0lwtoRns3mChvjPL2lGRVyDiIv76H8gd4pZLcD8Riormy6pVGeNdbu1aLH7LN5x
 QYPanRZvccPaz0Eg9v/drkbrgLgAD5HIBZvVkEfv/14S8OQR/vSUZo3Ka/cg2xmCqPfX
 3gId6QYleOJX7j1veGSzb5N/JX3F7RcTg7PN8xoOFnzHMh04NSNiYwJwGO+RgjTAZYfw
 stI0wdWv9WhA6TUwnuOfjMW+/0nuni4ikEyEXGedNUhTFHwm8n47xAEspTBOycn4issj
 NJ+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9276g08caV6Y3ZJODwj/jysKuY00e8T8L/wnWryaIUMwICN83/ghrHxvdnIqMswPqdaZLns2IHwJ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzg0wuGMaa4DyGMwCs3PV2NxwSVpehw5Q44xlI+/wc6xO70gMjv
 R1UceiS9sffSbtvNsK9R3C0VrOTc2JXj1IDalluslsrelBBEdjntc4kVm0Y/B0QVfIY=
X-Gm-Gg: Acq92OHjdKQtW71GPlZbydoB/RCisdfqtf/K6hNRRmjazP1W2j3zPzIVqkxTa2nVu44
 eozXOruCs9y8cvNr4klB17o6j9Y+AsVgKzBm5LMRhSP9cbWIFP7p6ET2Z2tT6IfiPXioIhQF3IP
 V4XEve+gVEp1SFPei96DrDxBfWX8/jQFpoSFODnSvc1MpE5YIn9+KnA4Pe3eMNFQSFb8yRVRWVe
 H7nUrqKJ8TSr+n4kK+UgSN7gLCRd5/NNqsQUfGqn1oedKUZ6d3X/U8P3WBtp7xswM1lv1MEc1mh
 NakTbUE2XBu78xKRttp22yHyB5FVRiyGExYmVKqZRKHE9o7Q1oS/yJZtjcitH2CdZK6dNvRcFvT
 siSpNkoilb7rrbq8I4fNvBgE0qsmF8H800z6+haG9iS4XwS+/Hbd9IHqN+T1CYRivTgybEYlQyH
 kSbZAqciiFjBSqv6E0jBVI6upn3S62l9dJA0UiH1ive1w4mi6lhcCyXvPYZp2/jlRnM3DC3u6ez
 y4WQMzpZw5GNZlJzD3y+JJGKiEI0lf0PRGsJnbyRgjLfimMHWue2lA=
X-Received: by 2002:a05:6a20:939e:b0:3aa:c99b:5c63 with SMTP id
 adf61e73a8af0-3af7f25ba7fmr7209249637.18.1778747117417; 
 Thu, 14 May 2026 01:25:17 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:25:16 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:33 +0530
Subject: [PATCH 04/14] fbdev: radeon: fix potential memory leak in
 radeonfb_pci_register()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-4-b3a2474fa720@cse.iitm.ac.in>
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

The function radeonfb_pci_register() allocates memory for modelist
(by calling radeon_check_modes() which calls fb_add_videomode()).
The memory is appended to info->modelist, but is not freed in subsequent
error paths. Fix this by calling fb_destroy_modelist().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/aty/radeon_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index adb03489bedf..b6b058cee751 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2476,6 +2476,7 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	return 0;
 err_unmap_fb:
 	iounmap(rinfo->fb_base);
+	fb_destroy_modelist(&info->modelist);
 err_unmap_rom:
 	kfree(rinfo->mon1_EDID);
 	kfree(rinfo->mon2_EDID);

-- 
2.43.0

