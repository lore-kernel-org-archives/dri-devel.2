Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BE0C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A74410F30A;
	Thu, 13 Aug 2026 12:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="U5tA9u0K";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B67C10F317
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/q
 53+4sbAkvZghtcJNaufkYc4MPRh9iQVRdTOXlG4Iw=; b=U5tA9u0KbNddN1J6yz
 6IrqXV9E8qLzzTzq/NNyGCxgngzoplbPUDXSZuj6xNx77Rmtyh13D4jkbebaW2hm
 X0PZ5KfeXtK9K8E15iKHTyY+hn2S1IBHEF0GiuxGzkpHhoZg9uH/OnQKPRgGGhfb
 q0knLpvtmZs0oDucjXpdAqK1g=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgB3lO2JvX1qxfeJMA--.22540S5;
 Thu, 13 Aug 2026 20:50:23 +0800 (CST)
From: oushixiong1025@163.com
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Abdun Nihaal <nihaal@cse.iitm.ac.in>, u.kleine-koenig@baylibre.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 4/5] fbdev: matrox: Convert to managed PCI and ioremap API
Date: Thu, 13 Aug 2026 20:50:14 +0800
Message-Id: <20260813125015.1097301-4-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813125015.1097301-1-oushixiong1025@163.com>
References: <20260813125015.1097301-1-oushixiong1025@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgB3lO2JvX1qxfeJMA--.22540S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1UtF1xJFWDuw1Uur1ftFb_yoWrGr1DpF
 Z5JFWYkF15JF13WrZrAFyDXa1rt3W7t34rG34IvFZa9Fn8Z3ykZr4rJFWvvay5J393Kr13
 AwnYyw18Xr9ruF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTAp8UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4RCNnGp9vZA3LwAA3C
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

Use pcim_enable_device(), devm_request_mem_region(),
devm_ioremap() and devm_ioremap_wc() to replace manual resource
management. Remove all release_mem_region() and iounmap() calls.
Use devm_request_mem_region() instead of pcim_request_region()
because the requested sizes (16384 for MMIO, maxvram for FB) do
not match the full PCI BAR sizes.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/matrox/matroxfb_base.c | 30 ++++++++--------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index ac04a19b6849..24d312c29fb6 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -374,10 +374,6 @@ static void matroxfb_remove(struct matrox_fb_info *minfo, int dummy)
 	unregister_framebuffer(&minfo->fbcon);
 	matroxfb_g450_shutdown(minfo);
 	arch_phys_wc_del(minfo->wc_cookie);
-	iounmap(minfo->mmio.vbase.vaddr);
-	iounmap(minfo->video.vbase.vaddr);
-	release_mem_region(minfo->video.base, minfo->video.len_maximum);
-	release_mem_region(minfo->mmio.base, 16384);
 	kfree(minfo);
 }
 
@@ -1712,11 +1708,13 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
 		goto fail;
 	}
 	memsize = b->base->maxvram;
-	if (!request_mem_region(ctrlptr_phys, 16384, "matroxfb MMIO")) {
+	if (!devm_request_mem_region(&minfo->pcidev->dev, ctrlptr_phys, 16384,
+				     "matroxfb MMIO")) {
 		goto fail;
 	}
-	if (!request_mem_region(video_base_phys, memsize, "matroxfb FB")) {
-		goto failCtrlMR;
+	if (!devm_request_mem_region(&minfo->pcidev->dev, video_base_phys,
+				     memsize, "matroxfb FB")) {
+		goto fail;
 	}
 	minfo->video.len_maximum = memsize;
 	/* convert mem (autodetect k, M) */
@@ -1727,19 +1725,19 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
 		memsize = mem;
 	err = -ENOMEM;
 
-	minfo->mmio.vbase.vaddr = ioremap(ctrlptr_phys, 16384);
+	minfo->mmio.vbase.vaddr = devm_ioremap(&minfo->pcidev->dev, ctrlptr_phys, 16384);
 	if (!minfo->mmio.vbase.vaddr) {
 		printk(KERN_ERR "matroxfb: cannot ioremap(%lX, 16384), matroxfb disabled\n", ctrlptr_phys);
-		goto failVideoMR;
+		goto fail;
 	}
 	minfo->mmio.base = ctrlptr_phys;
 	minfo->mmio.len = 16384;
 	minfo->video.base = video_base_phys;
-	minfo->video.vbase.vaddr = ioremap_wc(video_base_phys, memsize);
+	minfo->video.vbase.vaddr = devm_ioremap_wc(&minfo->pcidev->dev, video_base_phys, memsize);
 	if (!minfo->video.vbase.vaddr) {
 		printk(KERN_ERR "matroxfb: cannot ioremap(%lX, %d), matroxfb disabled\n",
 			video_base_phys, memsize);
-		goto failCtrlIO;
+		goto fail;
 	}
 	{
 		u_int32_t cmd;
@@ -1954,13 +1952,6 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
 	return 0;
 failVideoIO:;
 	matroxfb_g450_shutdown(minfo);
-	iounmap(minfo->video.vbase.vaddr);
-failCtrlIO:;
-	iounmap(minfo->mmio.vbase.vaddr);
-failVideoMR:;
-	release_mem_region(video_base_phys, minfo->video.len_maximum);
-failCtrlMR:;
-	release_mem_region(ctrlptr_phys, 16384);
 fail:;
 	return err;
 }
@@ -2069,9 +2060,8 @@ static int matroxfb_probe(struct pci_dev* pdev, const struct pci_device_id* dumm
 		return -ENODEV;
 	}
 	pci_read_config_dword(pdev, PCI_COMMAND, &cmd);
-	if (pci_enable_device(pdev)) {
+	if (pcim_enable_device(pdev))
 		return -1;
-	}
 
 	minfo = kzalloc_obj(*minfo);
 	if (!minfo)
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

