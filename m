Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8468DCD37B7
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A518210E5F6;
	Sun, 10 May 2026 10:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dSwW4ijM";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B799B10E37D
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 13:58:07 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso19591615e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778335086; x=1778939886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JUti0+dSrRWKVryrgT/4Dh3EjusVIM58YtILlWK34V8=;
 b=dSwW4ijMoVTtjz/sMWEnyIwjOSgPjpPV2+XSQ8wSruxBnsKz0IpFEBRTwBV1NjjJ6n
 38axJUWZPCICP1IriWlW7rrYgfHeuNBm/pqWryUqWVey3kyMZ7NfxtGglS373FT/ZyC0
 JQirUhN2Bq8fYu66Hqpd1uWiNwhMhR2iYwTFczUHQryZjkgc6+wTqumeKCfrtQ7G6/PO
 5GSzPnLY/iDKdIEkz5ybotsTHVpp4QobPEJdIW606PRvOrY5MFa+STfyYRCHwJKaP8SI
 R0tyjgE6A5cycmOs6+6ru5e67nZkNfEB628OaNecYUyfsbyz2wgZA4MZPZzTd1SzeiGt
 Aeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778335086; x=1778939886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUti0+dSrRWKVryrgT/4Dh3EjusVIM58YtILlWK34V8=;
 b=AkCmib6CTKH5ZKzJOSzLVidMsxYA41Jy4zWa/9yDVrZXy7XSPK2JDstuqhqBu/KWKF
 LdvG3GP8WCDdGqjDgjE7Y36lLpndXQX0y91MMk4OOWykpEv+GEgNcf/uB2NHtf7D7htn
 UL9gO3cXoU0DGdhf+BhvlkdJah2hGZ9MDMMs2NkxDzBvsu2wSNA+v6JfWizyL9tNkdxX
 7BcUXI+2OoT0DGdk4cgbi7eXOAWhpdi6xUn4FAZAIi52VJIRQ4Y88Wxb8zXeHF6AI9mw
 eLkjNkPSOTLp2LmIQDLA5/W1QjChKqMwJ1jlBgAu2zAVzsahA2jcppaw0FfPOxz3OP9e
 TNLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HZxj+kkEbIj7XOsPtKSbLrNuzHI3osDD3TkulzAWrOPovA1qRT/7X+2KRS4fK3bKXfrzrxQuShH0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+Mz8ku9zWStRKTXKEGbtqF5V1F6r1vy9PDKJfz48LYBd5BovR
 sC488nV1JdzV7rhvus9TMFyFp05aum0A1WEUB+pyo5DlnPZCis7g7DoI
X-Gm-Gg: Acq92OE+Btt9J83Wzd6LanX2HLx/mH3hFQhb6IiSoi7JLz/V/c1TI69Kw0TuNlDxXyM
 X5uaNFt2laR+RZM4Z8/KxzOsJld+1hzr/cosJQxj1KbG84pNny1Z1S1TETpSOEBfk0WdfDNmE/B
 BEP3Z6lyLmZjJy4ZulG0H6cBtAhi54hkvyHIKkTE2uZqPsHm9k1uwcw6SSF6tKjgCSLjnnkdIA4
 yq1W+nWR5mDbQGDem+3w9Z7RJMEucST42GeAL3lFynn5ztSHCdIQCocxUrQwAJv6sQivh8uUvcH
 9YOA2J+q7vnk/xX+/BHUV4wlgWO0yFQNLsG/ssTT302VQZTtuUxtZSRSRopfDi319bdvgWAbO5s
 6YT5lUltaix2jTHhF4455mPKSs/TC+WZ4Axvw63h5oxk6WFan1UdrtSiPRY8MqAQvb3nFzYRQTO
 BvUXRpC1RZeDJeSWQnobZjg4Qo7MPO18ZFrs3m2M5I0Yfv
X-Received: by 2002:a05:600c:8908:b0:48e:6275:27ec with SMTP id
 5b1f17b1804b1-48e676b6393mr72783285e9.24.1778335085773; 
 Sat, 09 May 2026 06:58:05 -0700 (PDT)
Received: from RM.localdomain ([92.53.30.157])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702e5614sm53450105e9.9.2026.05.09.06.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 06:58:05 -0700 (PDT)
From: =?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: deller@gmx.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
Subject: [PATCH] fbdev: sunxvr2500: replace printk with device-aware logging
 functions
Date: Sat,  9 May 2026 15:57:59 +0200
Message-ID: <20260509135759.1391-1-mahmutovicrahman5@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

Replace all printk() calls with appropriate device-aware logging
functions to properly associate log messages with the PCI device.

- Use pci_err() for errors where struct pci_dev is available
- Use pci_info() for info messages where struct pci_dev is available
- Use dev_err() for errors where only struct fb_info is available

Remove redundant 's3d:' prefix and pci_name() calls as device-aware
functions include device identification automatically.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Rahman Mahmutović <mahmutovicrahman5@gmail.com>
---
 drivers/video/fbdev/sunxvr2500.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/sunxvr2500.c b/drivers/video/fbdev/sunxvr2500.c
index 42426d09b..3a36e7524 100644
--- a/drivers/video/fbdev/sunxvr2500.c
+++ b/drivers/video/fbdev/sunxvr2500.c
@@ -38,8 +38,7 @@ static int s3d_get_props(struct s3d_info *sp)
 	sp->depth = of_getintprop_default(sp->of_node, "depth", 8);
 
 	if (!sp->width || !sp->height) {
-		printk(KERN_ERR "s3d: Critical properties missing for %s\n",
-		       pci_name(sp->pdev));
+		pci_err(sp->pdev, "Critical properties missing\n");
 		return -EINVAL;
 	}
 
@@ -107,7 +106,7 @@ static int s3d_set_fbinfo(struct s3d_info *sp)
 	var->transp.length = 0;
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0)) {
-		printk(KERN_ERR "s3d: Cannot allocate color map.\n");
+		dev_err(info->dev, "Cannot allocate color map\n");
 		return -ENOMEM;
 	}
 
@@ -127,8 +126,7 @@ static int s3d_pci_register(struct pci_dev *pdev,
 
 	err = pci_enable_device(pdev);
 	if (err < 0) {
-		printk(KERN_ERR "s3d: Cannot enable PCI device %s\n",
-		       pci_name(pdev));
+		pci_err(pdev, "Cannot enable PCI device\n");
 		goto err_out;
 	}
 
@@ -143,8 +141,7 @@ static int s3d_pci_register(struct pci_dev *pdev,
 	sp->pdev = pdev;
 	sp->of_node = pci_device_to_OF_node(pdev);
 	if (!sp->of_node) {
-		printk(KERN_ERR "s3d: Cannot find OF node of %s\n",
-		       pci_name(pdev));
+		pci_err(pdev, "Cannot find OF node\n");
 		err = -ENODEV;
 		goto err_release_fb;
 	}
@@ -153,8 +150,7 @@ static int s3d_pci_register(struct pci_dev *pdev,
 
 	err = pci_request_region(pdev, 1, "s3d framebuffer");
 	if (err < 0) {
-		printk("s3d: Cannot request region 1 for %s\n",
-		       pci_name(pdev));
+		pci_err(pdev, "Cannot request region 1\n");
 		goto err_release_fb;
 	}
 
@@ -194,12 +190,11 @@ static int s3d_pci_register(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, info);
 
-	printk("s3d: Found device at %s\n", pci_name(pdev));
+	pci_info(pdev, "Found device\n");
 
 	err = register_framebuffer(info);
 	if (err < 0) {
-		printk(KERN_ERR "s3d: Could not register framebuffer %s\n",
-		       pci_name(pdev));
+		pci_err(pdev, "Could not register framebuffer\n");
 		goto err_unmap_fb;
 	}
 
-- 
2.43.0

