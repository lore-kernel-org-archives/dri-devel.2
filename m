Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A6EC5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F07A10F306;
	Thu, 13 Aug 2026 12:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="L0AfYe9e";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C68410F314
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tw
 U2UmKc0VqNuKR+XXFp2odsiikhh3amQi3ufiG3shw=; b=L0AfYe9e6jJSNqpbok
 yrqz5+M+jHw3nJ/fF1Rk5XHzfnbiA42R0cFlCzJaypWoXAck487CkT13Sa2Sp0I9
 jpnXQzsTZq2RUk82kT0bcftFi6Bp6Vwwk2LD9p7j2bZBxLLBjKe9XF5iKKqYdeOO
 fwowJuKYuKMEaZPFSWltajJFo=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgB3lO2JvX1qxfeJMA--.22540S2;
 Thu, 13 Aug 2026 20:50:18 +0800 (CST)
From: oushixiong1025@163.com
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Abdun Nihaal <nihaal@cse.iitm.ac.in>, u.kleine-koenig@baylibre.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 1/5] fbdev: aty128fb: Convert to managed PCI and ioremap API
Date: Thu, 13 Aug 2026 20:50:11 +0800
Message-Id: <20260813125015.1097301-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgB3lO2JvX1qxfeJMA--.22540S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWryDZryftw45Cry5ZrW7XFb_yoWrAw1Dpr
 1fGFW3Gr4rGFnFgF4DuF15Z3Z8ZrWIv345CrW2y3sagFsIy3s2qrZ7tFyjvF9xJ3ykK3W3
 Zw45t3WxZFWUGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZyCAUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-QqLmmp9vYoWbwAA3-
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

From: Shixiong Ou <oushixiong@kylinos.cn>

Fix missing pci_disable_device() in probe and remove.

Use pcim_enable_device(), pcim_request_region(), devm_ioremap()
and devm_ioremap_wc() to replace manual resource management.
Remove all release_mem_region() and iounmap() calls.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/aty/aty128fb.c | 40 +++++++++---------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index bcb10e66221c..b76bfe014f41 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -2009,31 +2009,30 @@ static int aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return err;
 
 	/* Enable device in PCI config */
-	if ((err = pci_enable_device(pdev))) {
+	err = pcim_enable_device(pdev);
+	if (err) {
 		printk(KERN_ERR "aty128fb: Cannot enable PCI device: %d\n",
 				err);
 		return -ENODEV;
 	}
 
 	fb_addr = pci_resource_start(pdev, 0);
-	if (!request_mem_region(fb_addr, pci_resource_len(pdev, 0),
-				"aty128fb FB")) {
+	if (!pcim_request_region(pdev, 0, "aty128fb FB")) {
 		printk(KERN_ERR "aty128fb: cannot reserve frame "
 				"buffer memory\n");
 		return -ENODEV;
 	}
 
 	reg_addr = pci_resource_start(pdev, 2);
-	if (!request_mem_region(reg_addr, pci_resource_len(pdev, 2),
-				"aty128fb MMIO")) {
+	if (!pcim_request_region(pdev, 2, "aty128fb MMIO")) {
 		printk(KERN_ERR "aty128fb: cannot reserve MMIO region\n");
-		goto err_free_fb;
+		goto err_free_info;
 	}
 
 	/* We have the resources. Now virtualize them */
 	info = framebuffer_alloc(sizeof(struct aty128fb_par), &pdev->dev);
 	if (!info)
-		goto err_free_mmio;
+		goto err_free_info;
 
 	par = info->par;
 
@@ -2041,7 +2040,8 @@ static int aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Virtualize mmio region */
 	info->fix.mmio_start = reg_addr;
-	par->regbase = pci_ioremap_bar(pdev, 2);
+	par->regbase = devm_ioremap(&pdev->dev, pci_resource_start(pdev, 2),
+				    pci_resource_len(pdev, 2));
 	if (!par->regbase)
 		goto err_free_info;
 
@@ -2050,9 +2050,9 @@ static int aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	par->vram_size = aty_ld_le32(CNFG_MEMSIZE) & 0x03FFFFFF;
 
 	/* Virtualize the framebuffer */
-	info->screen_base = ioremap_wc(fb_addr, par->vram_size);
+	info->screen_base = devm_ioremap_wc(&pdev->dev, fb_addr, par->vram_size);
 	if (!info->screen_base)
-		goto err_unmap_out;
+		goto err_free_info;
 
 	/* Set up info->fix */
 	info->fix = aty128fb_fix;
@@ -2063,7 +2063,7 @@ static int aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* If we can't test scratch registers, something is seriously wrong */
 	if (!register_test(par)) {
 		printk(KERN_ERR "aty128fb: Can't write to video register!\n");
-		goto err_out;
+		goto err_free_info;
 	}
 
 #ifndef __sparc__
@@ -2085,25 +2085,15 @@ static int aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_drvdata(pdev, info);
 
 	if (!aty128_init(pdev, ent))
-		goto err_out;
+		goto err_free_info;
 
 	if (mtrr)
 		par->wc_cookie = arch_phys_wc_add(info->fix.smem_start,
 						  par->vram_size);
 	return 0;
 
-err_out:
-	iounmap(info->screen_base);
-err_unmap_out:
-	iounmap(par->regbase);
 err_free_info:
 	framebuffer_release(info);
-err_free_mmio:
-	release_mem_region(pci_resource_start(pdev, 2),
-			pci_resource_len(pdev, 2));
-err_free_fb:
-	release_mem_region(pci_resource_start(pdev, 0),
-			pci_resource_len(pdev, 0));
 	return -ENODEV;
 }
 
@@ -2124,13 +2114,7 @@ static void aty128_remove(struct pci_dev *pdev)
 	unregister_framebuffer(info);
 
 	arch_phys_wc_del(par->wc_cookie);
-	iounmap(par->regbase);
-	iounmap(info->screen_base);
 
-	release_mem_region(pci_resource_start(pdev, 0),
-			   pci_resource_len(pdev, 0));
-	release_mem_region(pci_resource_start(pdev, 2),
-			   pci_resource_len(pdev, 2));
 	framebuffer_release(info);
 }
 #endif /* CONFIG_PCI */
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

