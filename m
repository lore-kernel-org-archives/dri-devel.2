Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C7CCD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 04:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D59310E214;
	Tue, 16 Jun 2026 04:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L8dKjV/l";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B6A610E214
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 04:30:53 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2c0c1e0b0faso25118865ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 21:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781584252; x=1782189052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HDHkAn/riVOcTXXqBqO3TP0uWOPCnLzIZS8n/LO+QSE=;
 b=L8dKjV/lcKzdSm3Yu1Ffk+0blxhKvasyz1HKzQUuXBf2nuwzGgaKDrwXYKnqtJl+fS
 JPPHbO5Mo4h+5tVOJMQR1P9sfxdTiFnN8qqHKX3YHnP+Jx4+2gozgIPXm7hLHhGvhj2n
 FbCkfa4t6IkM8eGnQcalTaILsdP+70X/LGV7FWwl3/XZPoqfoj0xw5yH3wxPmlCNA7bl
 5gREU6zobhPcVdbqhnGjOMvmPq6e26R0jFnvvh5H92FIgh/cx4ziR5keY0f1lV05aEGZ
 tCNTuBaVNb2wPqT7GAJT8r8gd3rS1kA3DYTU5ipHVjOHpQsc29FH1JfLxLsUEO5HTlZw
 S6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781584252; x=1782189052;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDHkAn/riVOcTXXqBqO3TP0uWOPCnLzIZS8n/LO+QSE=;
 b=IDRAOyDFIVuab+5OmA2i+bSH0wsy8gmpAsT0bgYHYINSk4bHQgr0R4d+yDdOEqWQgl
 5D3snL1FA9h2IO4kOPbiylKfSANDSWjiYlh1q7EqDvwGcrCtsZ2LtEH1cX8gNhXfT/sK
 d56dwwbGXuCu88SEN7NvQmX86AvEnvalkFIrt0I8smcL5jAqjX39G+JjmA2iBXbDMxnv
 VtxFYYxu5wjcvOKKXAV4sryOCqG4frmUHAuoPvl9hq7jsNm0aB3yP0Onqhg7p8s8QHMD
 VyNRSbEQWJ7dH/WJgyABHFARbO3eBXFl6vimaB41pZvbOhJdB+PZruVnPRLFnts02MQc
 Lx/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AUly6gCd4bG/zRQms7sSK4fFx2pXWckNP8ULJ7TMgB75eMVY8E0jG1vezyJMyaKCK+9nIyLU7SZY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuIxUbDMWlv41/EBmoCJolBbWJgNkwBmrLlURiUWe4o/A7wd/5
 13ptNSE8EXV0ZYaowgE7haZYnPKKswfwpWzJ0z/6bwpDqgZLyDCc1HKk
X-Gm-Gg: Acq92OGv837KXy4OsIjfmBhfMQ9l+tMgtlKuKJz3DMnYIN7y6Bcawe+B7+PA3C5tigh
 43gtqinBK0eh0gWoQ6iVVfo4nXGXcTGKUm2scUY9Gs2RXgT2v9w18Srikc4X0HBTA+Dxwzla6hW
 T2MZhEkhLvXRPGiWntr2a4YNiPe682sXpZ+BWaUjuX4XkjJoyuWFsD+5//JmHfxFiIrdNv3107d
 xlAV3eTIegjqQu1IWlCfTYm3X4bgcFQuQscYqt8nKGTVF0KR8Ety7ePOCJU5ny+abtlhPf7nXdS
 Uh9WETcDHfUp8ZuF4nWfCZrERF7PGoVAsbNOD7yYe5y3P+ntop+4p99spSBxk9eVRsrpJ8eXq2k
 byH15B0LtIlp4AC/lMDA8CPts1VboRInm8fSHiDtUYozTyKEhpt9Yyrnn6gr0Irt2QbkqeLf1Op
 AJEAfLMiy3AXWDFEkN6IOYMtEsms/oY8BM8c1G3a8xjiCLDk0djo3VLX5D6sPF1UVrQadrh9DSq
 slX6EK+mZ6JmNzIWMji9OO5UM4Lj4bMO3egglcPnEtzZNYH/V37FZiD9uZMIwARW+18RqUPMC+z
 LeHiSVkeAwOqD1sT
X-Received: by 2002:a17:902:cf07:b0:2c2:5446:30dd with SMTP id
 d9443c01a7336-2c410bdb849mr205880405ad.7.1781584252505; 
 Mon, 15 Jun 2026 21:30:52 -0700 (PDT)
Received: from cmpatel-home.hsd1.or.comcast.net
 ([2601:1c0:5780:9200:9445:e681:a5ae:95ab])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e5374sm112635475ad.5.2026.06.15.21.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 21:30:52 -0700 (PDT)
From: Chintan Patel <chintanlike@gmail.com>
To: linux@armlinux.org.uk
Cc: deller@gmx.de, tzimmermann@suse.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH v3] fbdev: claim Cyber2000 SPARC I/O aperture before ioremap
Date: Mon, 15 Jun 2026 21:30:35 -0700
Message-ID: <20260616043035.11952-1-chintanlike@gmail.com>
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
v3:
 - Use pr_err() instead of pci_err()
v2:
- Use pci_err() for error reporting instead of printk().

 drivers/video/fbdev/cyber2000fb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 2d12f8e96c7e..9fced6bf6ffd 100644
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
+		pr_err("iga5000: cannot reserve I/O area 0x3000000\n");
+		return -EBUSY;
+	}
 	iop = ioremap(0x3000000, 0x5000);
 	if (iop == NULL) {
-		printk(KERN_ERR "iga5000: cannot map I/O\n");
+		pr_err("iga5000: cannot map I/O area\n");
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

