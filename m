Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F633CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A585010F16A;
	Thu, 14 May 2026 08:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Mw1K3PXj";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A1710F16A
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:26:27 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c822652f82aso5572543a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747187; x=1779351987;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=okp+cmZfIVDgj/1rQL2V5ef2DxZfT0YRw0dNkTRuA+Y=;
 b=Mw1K3PXjWqmp5GxqneN4ZSCEarqQiCcJxsjSRi1JxUkBkx/2dufhKS1qnTB7aPFHc+
 /PaK25LAGGfYXES898ApRdV6kGDpdXNR+/EHf/2PtMP/SqUaOqj6GPtl2LH2n2pJLzp2
 X2ePGGv/0yAUzfvp9f0coGwqPnNXdojwwlkyCgDbIEYJltftmsH1de2ttKhT3A4ii7Qn
 Drswiry7qMPmxN9mkYbJ+OS0PdGEK6kMo590Vu1B6JoVq5n00IlexsiO1faOxc8T4SPo
 uaLcVcwZkRIGs60xkT+FOcmT+Pktin7jWM9BDrE1kUsxdb0Z0xwGU5fyLvbyujRdNcSh
 Sp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747187; x=1779351987;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=okp+cmZfIVDgj/1rQL2V5ef2DxZfT0YRw0dNkTRuA+Y=;
 b=jWfTrkwtgMk4tWy/rvlNkTRgVEDBRDudKntTRtgMMKEACJwmmR834SDHvTvyRHs6Mf
 lcKQ1SERBJRKR225IS2fMfZqsDqKmxcQvX7Do3IsaNxZFmWigjRznXF58mJKE5OJhnHm
 Um5p1T1wZGOoVI0kKz/C2yhXR4CUpAx2dbD6KtfjeScM0GbW79bCzwxHyhZQxYL3dK6m
 8Wp+9+n+mBwKFqJcVORx49MOmC4Ey8TOu0ilVzF2xkqM3mdD3pWg/dWPc/7U2wRpL+nt
 VK2qYi5LoL9D41taW9t3k8PE/+S7ejhz8aFadIcxV1Wt+Ytq6tRsHAIs+AZi3GLQPTy5
 WC7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+n3CKjt41hmzlACNbWoNS2G2oAUr4q9IA+QEPW/8mb1E/eldC+Ho8mfBZDwR4nXoHGLcDDOgPZQKY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDw2aKHUGz5gSNLuZE+57B/msTRvHXUnrmvXXs2jt7vho0+spb
 yPSGybXEpCZ/zXzTmViIwmnxsv8V1adQRCq2tW8rm47gJBnAL6iJC/Q0QBN0C/i2FGM=
X-Gm-Gg: Acq92OGz+gbvuhAfmvl1OIPKAhkHrTVcTQk8vO+HJxlGgZUOJp/LhdFKpI9liylLUVl
 ZY4X2vbXZ7ktPCBNYHSDLWo0/4r8rSX0f9WAegRq9YJ3w2nyp+uUV9uDre3XNejuYw1BtzOciNo
 oZvI79NBb1GS/rmZTcqBe/mweWDbLerlSGp0Jc50oO8tIsru2X2faAzHwT/IMWONMy/W32lhHm3
 QeKecBg0YiQbD59lIuC7K3e44YV7m4AHH+gXd1aKafVZexcJWHA8J+y1KpTor1cN5HFOAj8rXTN
 8GpGmi5FN+/hmS0olB+Ht9PHv03v2sgMAJe8rxBd4xhbhP1CAv13m2Glu+2gh8Q3NlaNjz8oePq
 innLCV7WfYMiDc7OBdzVTLULwfnpgl+LkuT/TIeTuWSOWWnflGL1o7jMw1ewXIA+ec0NRMl1NVL
 woTwA+I8qfERj5bq0Lht7vmtbBo4GR7lAbuOUdv3JEWlo8d0KhGxkjMfPgMANvVE/CR6Lp+V2PF
 wKthqZH0CHi/iYjN/3sDAVSOBdFGvWWl2KZDJRVY4sz
X-Received: by 2002:a05:6a20:12ce:b0:366:19e9:f43 with SMTP id
 adf61e73a8af0-3af80079e2bmr8359899637.6.1778747186893; 
 Thu, 14 May 2026 01:26:26 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:26:26 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:42 +0530
Subject: [PATCH 13/14] fbdev: vesafb: fix memory leak in vesafb_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-13-b3a2474fa720@cse.iitm.ac.in>
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

Since commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
caller; clarify ownership") the string returned from fb_get_options()
is expected to be freed by the caller. But the string is not freed in
vesafb_probe(). Fix that by freeing the option string after setup.

Fixes: 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/vesafb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index f84f4db244bf..f1902056bd73 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -269,6 +269,7 @@ static int vesafb_probe(struct platform_device *dev)
 	/* ignore error return of fb_get_options */
 	fb_get_options("vesafb", &option);
 	vesafb_setup(option);
+	kfree(option);
 
 	if (si->orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENODEV;

-- 
2.43.0

