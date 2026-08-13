Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0F3C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9161A10F309;
	Thu, 13 Aug 2026 12:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="VKmSsGYD";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515D910F309
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oK
 w70w/LOsp/h1z6Fef4O8j0xSbzMzILJqyCgk0tvCQ=; b=VKmSsGYD0tzfZze2kP
 91JdLGx5MzY1u5toIjA2GgalZcc0wRq3uby/qRihHrHuMCr+4kw+WDJ6cNmUd+pe
 JLay6BMJl07AdXaIoRcGUe+thZudxhlLpHjdpNsHzTRCwZWr+zbSf6apdap63zmT
 rJxpSuEsdA3i0SmBApLSUxoHE=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgB3lO2JvX1qxfeJMA--.22540S3;
 Thu, 13 Aug 2026 20:50:21 +0800 (CST)
From: oushixiong1025@163.com
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Abdun Nihaal <nihaal@cse.iitm.ac.in>, u.kleine-koenig@baylibre.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 2/5] fbdev: nvidia: Convert to managed PCI and ioremap API
Date: Thu, 13 Aug 2026 20:50:12 +0800
Message-Id: <20260813125015.1097301-2-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813125015.1097301-1-oushixiong1025@163.com>
References: <20260813125015.1097301-1-oushixiong1025@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgB3lO2JvX1qxfeJMA--.22540S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4DZw15Kry3ur1UWFy7trb_yoWrJFy8pF
 sxKa1ftrWfKF95uw1kCF4UZFs8X3yIv3y3Cr4UK3Z3trsIy3s2vF4IqFyav39rArZrJF1a
 qw1jqw1UZa1IqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOb18UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4Q2Mm2p9vY03EgAA35
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

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/nvidia/nvidia.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 7d20c4087aeb..4ef7a5ba43cc 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1292,7 +1292,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	NVTRACE_ENTER();
 	assert(pd != NULL);
 
-	if (pci_enable_device(pd)) {
+	if (pcim_enable_device(pd)) {
 		printk(KERN_ERR PFX "cannot enable PCI device\n");
 		return -ENODEV;
 	}
@@ -1305,7 +1305,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	nvidiafb_fix.mmio_start = pci_resource_start(pd, 0);
 	nvidiafb_fix.mmio_len = pci_resource_len(pd, 0);
 
-	REGS = ioremap(nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
+	REGS = devm_ioremap(&pd->dev, nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
 	if (!REGS) {
 		printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
 		return -ENODEV;
@@ -1333,7 +1333,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	if (info->pixmap.addr == NULL)
 		goto err_out_kfree;
 
-	if (pci_request_regions(pd, "nvidiafb")) {
+	if (pcim_request_all_regions(pd, "nvidiafb")) {
 		printk(KERN_ERR PFX "cannot request PCI regions\n");
 		goto err_out_enable;
 	}
@@ -1358,7 +1358,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	sprintf(nvidiafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
 
 	if (NVCommonSetup(info))
-		goto err_out_free_base0;
+		goto err_out_enable;
 
 	par->FbAddress = nvidiafb_fix.smem_start;
 	par->FbMapSize = par->RamAmountKBytes * 1024;
@@ -1378,8 +1378,8 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	par->ScratchBufferStart = par->FbUsableSize - par->ScratchBufferSize;
 	par->CursorStart = par->FbUsableSize + (32 * 1024);
 
-	info->screen_base = ioremap_wc(nvidiafb_fix.smem_start,
-				       par->FbMapSize);
+	info->screen_base = devm_ioremap_wc(&pd->dev, nvidiafb_fix.smem_start,
+					    par->FbMapSize);
 	info->screen_size = par->FbUsableSize;
 	nvidiafb_fix.smem_len = par->RamAmountKBytes * 1024;
 
@@ -1423,19 +1423,15 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
-	iounmap(info->screen_base);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);
-err_out_free_base0:
-	pci_release_regions(pd);
 err_out_enable:
 	kfree(info->pixmap.addr);
 err_out_kfree:
 	framebuffer_release(info);
 err_out:
-	iounmap(REGS);
 	return -ENODEV;
 }
 
@@ -1450,11 +1446,8 @@ static void nvidiafb_remove(struct pci_dev *pd)
 	unregister_framebuffer(info);
 
 	arch_phys_wc_del(par->wc_cookie);
-	iounmap(info->screen_base);
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);
-	iounmap(par->REGS);
-	pci_release_regions(pd);
 	kfree(info->pixmap.addr);
 	framebuffer_release(info);
 	NVTRACE_LEAVE();
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

