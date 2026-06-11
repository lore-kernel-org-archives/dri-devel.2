Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FD9CD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 03:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CBF10E214;
	Thu, 11 Jun 2026 03:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WT5+x+CO";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A090810E214
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 03:53:05 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8424b00710aso4677827b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 20:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781149985; x=1781754785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nuLe52twcTi+x/X3rOvTkNMFrTH5BVuejVrED6FOMYc=;
 b=WT5+x+COb2klhA6JMuFeUvv/WYddPBot3HQvaSjUnKKhhk/1mKHYq9UsAbi6sN0AnS
 m5pmaia2vegVmH0+8+/GUGH71+Ff7qz90VoLfKRwM1E918jbH7AhTcJssN8+FITEX9Bl
 aWqVXXbtWphILzWrgy+HXKFJVDsoMT7y6oAfDcd09mzcfNFTiFScM651vlHR0Mm2a5dR
 eDNqQbLTpUmsfO5Ipg70igTq+cXsESN7zsNAxqHCguROt1HrSXxdoDhMOXfdbrM2iYjY
 lX5UBQZpwDrmpduDMjzGAD4UGYK//mgHJTgq5xDAkwflRlJZClHaQixsyUvjUjX+rQuI
 LS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781149985; x=1781754785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuLe52twcTi+x/X3rOvTkNMFrTH5BVuejVrED6FOMYc=;
 b=nnmJn4Vn3y1beUaOFgo2zIw+yMJ37aQJyJxVhsEc+7LHl11x3rSykwe3G1dA8AMOnY
 ycegm/c+XBig5rGsm1Ml5T6Sn1+jnMhilald3dRHOWikw0EfWqhNdKttEx/0DQJ31Dct
 6txFrqwcRnmEqH4fNrePAIyHlk0mpVkNJJAzwbBJdAWwbMCC1jSirzFNoO8/tnQTTpXH
 LFiyQ2Kun1WY/a3o6kv/ItbYe5BGotiDVlSYHbriNR3QAMu47WIjvmH4ojJU1juFhfA6
 GRvV5yUqEGWzIsHW6XkGvV/3dq2b5yLPO9g3cGZ3Pieqq6oK4qtJYpf6p9Kzdxs5sooG
 2n1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9T8gDEz2csV3akyATyghDa7UvkWDToFGbDG8nLgCtFpX4Y3uH2CD125dQaA1BktY26ETbXa61NfHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJsMP2lCyLYT4OCj9lN8gpNV0r4pD+Ns0D0mId1sR86QtYWZ40
 1+L4wGrhjSYsQ1tcKQiOxZ5PoBlPalpNdjlJ/tJEe9xjcj7pmHUmVkBg
X-Gm-Gg: Acq92OEUtOIiFJItcMwyednBV4ugp9XVv9Kqt+hEAe/JXzN/pRarbkUapDSjgXWCYHg
 Y3BuR/OCSdf0n5a8KviNJyYIloxLGVhBIc3+vew0S82O47HLPjZ7MRtgvfdmICKsn4kgNOMHck4
 nlkjAV37WE9TsGsSdFBq1gL7XTDaUDrCQ4orwY3gGDrPi4im06IXaO9VKNlrr6DxLBE/oEc1Su9
 2V2O7UyL3zfbABDZ320pCcPxcwbRtVR4uSsgmmfH3Rj/MKLsqS23t5n15NWEop9zYImOo1yvA7a
 Nh9ssHEnm30L4NkXru+ruevLUERleka92zEcL800qRCrnY8wBYD6Zjrjkjgup05I/+gSEzawyoY
 MmS2dBm+U7oYVj4f482ZbpEgphGy7V1pW6oHtnzQpNSe4Kg2lWKLOLBwv5mA0CcwuT5EMdZm2Ou
 C6wHqaqAoeGNZXh/avKvzp/gZSjUtpYsNlhUArniBq5XX88ctMXL6wdW1zFBxaNsc4LOa5xzCOB
 lpK2fHD/xmVLoa17juzD1G86qCIjEu+JTGEe/XN4LZnvQC5RBdRBLANOocNwLlzkPpdrtfNtkDv
 oOCqDXR0J2tAu8tm/ZUSelmf8IM=
X-Received: by 2002:a05:6a00:12c5:b0:842:6004:3fce with SMTP id
 d2e1a72fcca58-84336bba668mr1064103b3a.26.1781149985157; 
 Wed, 10 Jun 2026 20:53:05 -0700 (PDT)
Received: from cmpatel-home.hsd1.or.comcast.net
 ([2601:1c0:5780:9200:5dea:bbec:bf0c:d151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84337bb6cb2sm380130b3a.15.2026.06.10.20.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 20:53:04 -0700 (PDT)
From: Chintan Patel <chintanlike@gmail.com>
To: linux@armlinux.org.uk
Cc: deller@gmx.de, tzimmermann@suse.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH] fbdev: claim Cyber2000 SPARC I/O aperture before ioremap
Date: Wed, 10 Jun 2026 20:52:42 -0700
Message-ID: <20260611035243.16192-1-chintanlike@gmail.com>
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
 drivers/video/fbdev/cyber2000fb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 2d12f8e96c7e..16ed56180ce2 100644
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
+		printk(KERN_ERR "iga5000: cannot reserve I/O area 0x3000000\n");
+		return -EBUSY;
+	}
 	iop = ioremap(0x3000000, 0x5000);
 	if (iop == NULL) {
 		printk(KERN_ERR "iga5000: cannot map I/O\n");
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

