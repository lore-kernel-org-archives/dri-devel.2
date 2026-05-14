Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1FECD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0183A10F160;
	Thu, 14 May 2026 08:26:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="zqqlCrbU";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C71510F163
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:26:12 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c8025500cc7so5587951a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747172; x=1779351972;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GheaXfm6WhMIcKtl8e6E9+wMuBUvLISEtMm7ivNoGig=;
 b=zqqlCrbUw+6ZAZu8jEkiFOEmw7SPWmC4UY0/7zAwxOA/zudSAoGRYlBJcMCDdUybJX
 QTZgoxGiB4VnGr7r2G0yir+6AcjqHe33eJibrGYYOB2jtugww9YiZk+GimMGFK+hZTEZ
 2YRDqyrCNoY5Fgw6e+Odg8VW82EA3qdNA8X/fqlTq3Bs3lPaxWFjo5so66FOKHBJVKR0
 PGEkzszK6AQtzlqQTHmWFKM/DoUNyiu1nrRfPcXJoLiJD1PwTyOsaIEKraBKXtPpL5OO
 vmow8GO+9Liabhuf6Z5TjmJYEmdFBg+PBDp6gAqVX6yzzNd3iefka2SaI7Hunc9dHpde
 60sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747172; x=1779351972;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GheaXfm6WhMIcKtl8e6E9+wMuBUvLISEtMm7ivNoGig=;
 b=C9lhcpAmwzMACWc9BVSpw86bOxzxEOmd/w9uYpaXIslbOiTjDnnCQGjkACH++EKXya
 VoPRZSHTn5WyDGoKtJr9Vg77sb1GLay5MK6lajOHQXbKzbfHfA7dJtf9qJppXIfI//Y4
 TFv+8J+gIY3OpyLWK6wDPktA2M4URvahJNX/64nmPZ3S8QIXVrsYJWh0PXB5Xl+ZKREF
 fD5VCKqQUcdhxi0AQrXgrpMQjASwWGC57f9mNE/zOMSGGaw8fMj5sM79rOMeuTxarTWC
 YrSBSVzPRTsdvDjCuBTr2L4hRkTv6KGvjJ5KCHXMU6rULtNnucAWPJpcMsRcpb9IUnBR
 NRkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/y9xsjMmiq35Y+k1SbRJd/iHMHeu2xZAANJD9NvrPpF3poOjMERxxeEljhQfcMd7aw/oXaZ7HjLmA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0tiAdo+5vXVVbZrA+EC+I/L9ol6A65sCbmb2qpPrZF09RgFZj
 P+6qxM+Eo9Y9HrHxacrMLwak98h7jm7NJisx3z5PR9Cng0WCd61XCrw3WaNETFiZdoY=
X-Gm-Gg: Acq92OHQ3XPTe/4U6RNHDFUXlhmd8F7Mx5EhKB19DFDgXhXmyPlTW2HGhMdM9gooNIK
 6Ve3YVpuXo0ducxKuzFKoVnwlTi9+HgzMDfYm3rgcnospSbSTTn4uzj26lBWXieBqpeL7gRrG01
 qGvNd4poCJK77wf8l34qeUP4IaV5WEzDISqP1g2YOPWLSjv6x2qgQl1A5jAR+VDLDzX65pIsMHJ
 i3WyjZwSot8s65fcO5mEYqyKL8vGyTeA81mKCTlKMmyZO47puoe8zbR33tKP73jfd1deNUHbgAm
 2UJoADzCffjPRURtInmiXAxwc1hjp5hKC2FNSBdTLTrs/MZC6Bh7PXM5QDaCNk6TtniF0hO3v8P
 P1myF4tOTXySN3s8zyrObvhmWVYHmfvNHbJYYuhGMVoJ2rPS3CcoKseTJLnwZhci50Gbz4ScN13
 8skj3Vcbz1ZyQyvUX3UXyhTzmej/ZvCb8qKZfiCzyPaNrv5R/eKFyvEhOpaxrIWTZGRLMp0pmWE
 sLg2gF7d/yTtmi1Gh7d2wHLXYkyD4yQilLh11sqJyCj
X-Received: by 2002:a05:6a20:7f8e:b0:398:8002:8033 with SMTP id
 adf61e73a8af0-3afb0524b0fmr7156205637.49.1778747171713; 
 Thu, 14 May 2026 01:26:11 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:26:11 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:40 +0530
Subject: [PATCH 11/14] fbdev: uvesafb: fix potential memory leak in
 uvesafb_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-11-b3a2474fa720@cse.iitm.ac.in>
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

Due to an incorrect goto label, memory allocated for modedb and modelist
in uvesafb_vbe_init() is not freed in some error paths. Fix this by
updating the goto label.

Fixes: 8bdb3a2d7df4 ("uvesafb: the driver core")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/uvesafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 88667fccc27b..9d82326c744f 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1694,14 +1694,14 @@ static int uvesafb_probe(struct platform_device *dev)
 	i = uvesafb_vbe_init_mode(info);
 	if (i < 0) {
 		err = -EINVAL;
-		goto out;
+		goto out_mode;
 	} else {
 		mode = &par->vbe_modes[i];
 	}
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		err = -ENXIO;
-		goto out;
+		goto out_mode;
 	}
 
 	uvesafb_init_info(info, mode);

-- 
2.43.0

