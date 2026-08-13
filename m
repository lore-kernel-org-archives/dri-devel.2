Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA123C5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9FDE10F314;
	Thu, 13 Aug 2026 12:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="OqT5pkfv";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 062ED10F309
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ld
 gRe+8c28l0pZpsvHDBdbSNCsT8XeELOsgW9kViHgI=; b=OqT5pkfvRf2f3wEgiY
 Y7NMVfi0uPHkJn9e+qyXu2lCvCwGFFYNz0qfCFucaZ5eYvl0v9HFVDlNbOX1/U/r
 8yui+jlMlc72QS5AsuJX8IDqaIaWvN5Dn+gj4ESVDrEM/zGdMHunG9KdK7j+i7oZ
 Emr8qG15AF/ySlKyNO0Unffms=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgB3lO2JvX1qxfeJMA--.22540S4;
 Thu, 13 Aug 2026 20:50:22 +0800 (CST)
From: oushixiong1025@163.com
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Abdun Nihaal <nihaal@cse.iitm.ac.in>, u.kleine-koenig@baylibre.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 3/5] fbdev: savage: Convert to managed PCI and ioremap API
Date: Thu, 13 Aug 2026 20:50:13 +0800
Message-Id: <20260813125015.1097301-3-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813125015.1097301-1-oushixiong1025@163.com>
References: <20260813125015.1097301-1-oushixiong1025@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgB3lO2JvX1qxfeJMA--.22540S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF45Jr1kurWUCr18ArWfAFb_yoW5tr1xpF
 Wkta1ayrWrJ3yUuwnrCF47CF15Krs2k3yrGry8K3WIqFn8Aa4kXrs7JFyjva9xJrZFk3Zx
 X34Fq348Ja4xZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jO_-PUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4Q6Mm2p9vY43JwAA3M
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

Use pcim_enable_device(), pcim_request_all_regions(),
devm_ioremap() and devm_ioremap_wc() to replace manual resource
management. Remove all pci_release_regions() and iounmap() calls.
Merge failed_init label into failed_enable.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 7789196d2eb5..56ff3c50cd29 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -1728,7 +1728,7 @@ static int savage_map_mmio(struct fb_info *info)
 
 	par->mmio.len = SAVAGE_NEWMMIO_REGSIZE;
 
-	par->mmio.vbase = ioremap(par->mmio.pbase, par->mmio.len);
+	par->mmio.vbase = devm_ioremap(&par->pcidev->dev, par->mmio.pbase, par->mmio.len);
 	if (!par->mmio.vbase) {
 		printk("savagefb: unable to map memory mapped IO\n");
 		return -ENOMEM;
@@ -1755,7 +1755,6 @@ static void savage_unmap_mmio(struct fb_info *info)
 	savage_disable_mmio(par);
 
 	if (par->mmio.vbase) {
-		iounmap(par->mmio.vbase);
 		par->mmio.vbase = NULL;
 	}
 }
@@ -1774,7 +1773,7 @@ static int savage_map_video(struct fb_info *info, int video_len)
 
 	par->video.pbase = pci_resource_start(par->pcidev, resource);
 	par->video.len   = video_len;
-	par->video.vbase = ioremap_wc(par->video.pbase, par->video.len);
+	par->video.vbase = devm_ioremap_wc(&par->pcidev->dev, par->video.pbase, par->video.len);
 
 	if (!par->video.vbase) {
 		printk("savagefb: unable to map screen memory\n");
@@ -1802,7 +1801,6 @@ static void savage_unmap_video(struct fb_info *info)
 
 	if (par->video.vbase) {
 		arch_phys_wc_del(par->video.wc_cookie);
-		iounmap(par->video.vbase);
 		par->video.vbase = NULL;
 		info->screen_base = NULL;
 	}
@@ -2188,11 +2186,12 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 	par = info->par;
 	mutex_init(&par->open_lock);
-	err = pci_enable_device(dev);
+	err = pcim_enable_device(dev);
 	if (err)
 		goto failed_enable;
 
-	if ((err = pci_request_regions(dev, "savagefb"))) {
+	err = pcim_request_all_regions(dev, "savagefb");
+	if (err) {
 		printk(KERN_ERR "cannot request PCI regions\n");
 		goto failed_enable;
 	}
@@ -2200,7 +2199,7 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	err = -ENOMEM;
 
 	if ((err = savage_init_fb_info(info, dev, id)))
-		goto failed_init;
+		goto failed_enable;
 
 	err = savage_map_mmio(info);
 	if (err)
@@ -2331,8 +2330,6 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	savage_unmap_mmio(info);
  failed_mmio:
 	kfree(info->pixmap.addr);
- failed_init:
-	pci_release_regions(dev);
  failed_enable:
 	framebuffer_release(info);
 
@@ -2355,7 +2352,6 @@ static void savagefb_remove(struct pci_dev *dev)
 		savage_unmap_video(info);
 		savage_unmap_mmio(info);
 		kfree(info->pixmap.addr);
-		pci_release_regions(dev);
 		framebuffer_release(info);
 	}
 }
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

