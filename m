Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51648CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A069510E17D;
	Mon, 15 Jun 2026 04:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ru7KQ37z";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6BF710E17D
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 04:05:30 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c8589498839so1084665a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781496330; x=1782101130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Il3yPCA60ecMhKNK7A4W8smtXWdIja1/mHJ4Opu/D+o=;
 b=Ru7KQ37zseYCCCHiMmUgTYM16DhEREYR57keFM6Gvqnftwj0azPjJDvXTXyz775pkA
 TZehUD6hSE0WXohI8UD98e4kiwtOE6+MnXl9d71tiHGoPeNHp/wOYEfLFyqwcGF8tacJ
 K1tCWfp4aMgYd3MFdDJbhODUSSqwPfWuS9m52Aq2pTs3DoY+0EvDDUC0EO9mvvxRC6Yb
 F6t+vJCMKuXN0STCv/eN6Nxfw0iO8QM1SQBxR6W8og6/TGBVyuDJYLoSgOkl0cw+P9If
 S2clE37o7Tu4XeFy99eWY1DMllOoSWRQ8V7eR22jmhp7bXDXkQ0rd+GSxFcAigIyyNfJ
 qhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781496330; x=1782101130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Il3yPCA60ecMhKNK7A4W8smtXWdIja1/mHJ4Opu/D+o=;
 b=hLWv91sE8do9BvtCA41+vr1Uqi3A7rXQKDkZAtCezQCk84bSHsibsntU79hOwAvWeD
 W4ln33OzgBsuVaUqRGaNsufAs8ApHDM07Ywbykdp2hefX1ZHZOKseCZD/CjVSJTSepF5
 nNJxa1OQ7yGpMhI2dgoTnKpXihIEbswF2YYytWtT7AGd6eeIKZ74koZyA1ksU2uepIe/
 eF5LrUeUWXB86lcxEtXMjLxbv/atUv2AUB0DJ2gNcqAM+4IIiMLmx+kAUdQwqmz3TFEr
 Hj8K69pw5+9TliTqA1/8StLxfNBAVnfO6K6MjtfXuMc2i0AUgY/8XgqrLRv5aVIfcEdp
 Znzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LJClJJlCGT9/2sjoeSUNZNkPgzD7vDYB2/gqhE6tfIcqlfljyHICJUjPVfyzzOFNrKFMmAQPVMsQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIpdLTQ0D0E9TvdicPxcvWNiYDvnxneuIm8qQdT7pt7cWprONh
 DEnXyyCuRPsc1S55muxHQi1Y5SNgCMxqzr4LEXaoNQko9A4y+0Fvzdqa
X-Gm-Gg: Acq92OHVIoa025wRU5TO8roVSZ/U5+O4/1SmD1KWJ/W2ukKrk5Hn1F224q9vNpVJc82
 BrlTp+anML+sYb33fYqoIrycRDk52qHx4OkSqAANjJXBskbEMeI9KThzfu7NoCF9zPt9fm/YxoV
 cVpgAnUin02v/MOJ/wBRVSPhcQGCrEjhNcKurcaMziaUc0ydaeo4jZrEV/6aQFNhoL65I6XaAcB
 eTn4NbBP3t4mAmpMvSLY5N0ExRgT+EALB5hwu8XSM/Q1y4SNzZWmm/3Hzah2iDPB5HUDvDJYmQt
 zZt1RjjK5ZniaAQSNMCNayC8z1TKmglPldmYWndaknmid6lCXZxq3NIqd4vw/z/3yMlYnj26Dcq
 BewSzfxJem+xWYpfmaanPopj0yk6apxA75d3jdc5U0yF2AcEYlaBUhT/xNYIKK5XvBWuxdW+SXm
 K0+jetayDAx5jSTZchQTvaiUte6WKVKvEjtlut0AZg3NY/a4wpuL7X6XbPsSOGqn0rAsqwxLnZL
 FThsnxFaHcdcvQO0nDms1afpeVWM00ca+4FY2QyBSO+appYpUhcmWYctWR5uW5cXlThWz9hIBlD
 kjv/K/gdvlftd37/
X-Received: by 2002:a05:6a21:7107:b0:3b3:2703:115 with SMTP id
 adf61e73a8af0-3b79625bfbemr10526987637.16.1781496330174; 
 Sun, 14 Jun 2026 21:05:30 -0700 (PDT)
Received: from cmpatel-home.hsd1.or.comcast.net
 ([2601:1c0:5780:9200:e093:9ee8:780e:953b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c86651adc16sm7044892a12.31.2026.06.14.21.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 21:05:29 -0700 (PDT)
From: Chintan Patel <chintanlike@gmail.com>
To: linux@armlinux.org.uk
Cc: deller@gmx.de, tzimmermann@suse.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH v2] fbdev: claim Cyber2000 SPARC I/O aperture before ioremap
Date: Sun, 14 Jun 2026 21:05:10 -0700
Message-ID: <20260615040510.9299-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Claim the memory resource associated with the Cyber2000 SPARC MMIO
aperture before accessing it.

This is part of the effort to request memory regions in fbdev drivers.

Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
v2:
- Use pci_err() for error reporting instead of printk().

 drivers/video/fbdev/cyber2000fb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 2d12f8e96c7e..0b362842cab3 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -47,6 +47,7 @@
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
+#include <linux/ioport.h>
 
 #ifdef __arm__
 #include <asm/mach-types.h>
@@ -1620,9 +1621,14 @@ static int cyberpro_pci_enable_mmio(struct cfb_info *cfb)
 	 */
 	unsigned char __iomem *iop;
 
+	if (!request_mem_region(0x3000000, 0x5000, "cyber2000fb iop")) {
+		pci_err(cfb->dev, "cannot reserve I/O area 0x3000000\n");
+		return -EBUSY;
+	}
 	iop = ioremap(0x3000000, 0x5000);
 	if (iop == NULL) {
-		printk(KERN_ERR "iga5000: cannot map I/O\n");
+		pci_err(cfb->dev, "cannot map I/O area\n");
+		release_mem_region(0x3000000, 0x5000);
 		return -ENOMEM;
 	}
 
@@ -1633,6 +1639,7 @@ static int cyberpro_pci_enable_mmio(struct cfb_info *cfb)
 	writeb(EXT_BIU_MISC_LIN_ENABLE, iop + 0x3cf);
 
 	iounmap(iop);
+	release_mem_region(0x3000000, 0x5000);
 #else
 	/*
 	 * Most other machine types are "normal", so
-- 
2.43.0

