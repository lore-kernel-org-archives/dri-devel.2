Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB156C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC2AD10F241;
	Fri, 31 Jul 2026 12:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="J/POAy7p";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2526710F241
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:19:26 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so980314a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785500366; x=1786105166; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/zgk2khl+gAzXyZ3o1YPLCn48UL/rzoP7NqltzArtxk=;
 b=J/POAy7pPe/8/nhQZ7tsRxfn5TiSXWA+vLEQ3clTWpyVpNbqunJtUrygvpgGt9wlIJ
 94t2Ivycp4bnT3B5TLCRnOtDEn8U4mT47dmFWg8jP4chj0mLmwb1/WO3RIY6RgRh3Zo+
 Qcki7B5qAW5pXbFPs2ceNcGB7Ss9THUWPNFBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785500366; x=1786105166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/zgk2khl+gAzXyZ3o1YPLCn48UL/rzoP7NqltzArtxk=;
 b=CMlpnfbXE5KVWT1DZWcGnF7A2U/lRuKraHknBUGldKAIUORJQ03CrNEp4TLTPoY8SF
 9QfMcuc809s335ZR5UJycylmL6u9lfKjuQHjTRYmbns8njgfVrlfw0I9uwCLbELe83Xd
 qcmGdTmb9tdRIXXKz9xw7DPNIcgQJcSydTIvJom39ZGvAlQloB6qG+7kWfGIMrFpnD+n
 tAPTyO9knuZNXbyXsg2KGoM1ByLLL6eld2kJ+uZzHu7GURw82Bd1xExx81O0wGwzeVyl
 uo1nGr+fQ04/V7oYNqw++ERxxFJvtncVOjoz5eB4qULft4LVHwr0yEH9RbpXDCoV+NJT
 OIzg==
X-Forwarded-Encrypted: i=1;
 AHgh+Roq2oksoujiMJcLm2XIvjc5Hg5Woe+T8oX7PLm8SuQH8fqiFnUBZ7lwsfbgc3lPEpLEt7uDf72NgU0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVXv7q7eGRYwkkYTYY41bIQzHx1N10PtQtVJEhS2sKOxWtTX1r
 9KYZv+4WqTu+Txk3v9ZCcu4aWXnVWMXtIftC9zKvAoIRJ3D7qHZZSdS/e3eQ2pIAbxA=
X-Gm-Gg: AR+sD10JlIYSOX7Catd+gNWsTbMHWU8gkDuSGQKOJHdLOBfO0bTwtluPT0DiUaOmo9W
 +sbeDh4ow53Xmvr9gmn2S3YdNX06NaVE7CRxr+A2KaNN+GSFeff0Ey2BvuuM+Dowfe7B1lpc1xq
 j7bu27/0Q1G1BAyh6OcKiasSg5o8JZQ4Jheu3BeuR6D2XgQX6m8ehHTff4zianLw/7Zvx33Dqsk
 90RP8MriWvbHF9KsppdHqhA+qEDxMtDv1P1rICOWac6GCTNWIdN499WS5O02HSZe42RG9fXUOur
 tncOEMmQgmWVPBnkUSJJStrokOCSSbhn2cnlpbp3mcpnfcT3yTkLYU2euypR73ehRYM25ua8r/i
 di2xafSkPDyfJpLID6/GAJb517csYdLuLtdI9sRrVpUq5aJ0YszrRxeaXitUBJ096F4+KpKaAYt
 bXNxsuGFXY+fI+CfzIexF/NIuOK/DFn4TedmeqncGJP04XLO3QAWI=
X-Received: by 2002:a17:90b:582c:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-38fb1117e8cmr1766904a91.8.1785500365608; 
 Fri, 31 Jul 2026 05:19:25 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:77cc:841c:1fc1:22d4])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-38fb2b8c5c5sm321981a91.4.2026.07.31.05.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:19:25 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 1/5] fbdev: tdfxfb: Add helper to read config table from
 BIOS
Date: Fri, 31 Jul 2026 21:19:10 +0900
Message-ID: <20260731121915.3362232-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731121915.3362232-1-daniel@0x0f.com>
References: <20260731121915.3362232-1-daniel@0x0f.com>
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

In the case that the video BIOS didn't run because the card isn't the
primary card, the BIOS doesn't support running old skool video BIOS
(modern BIOS without CSM), or the machine isn't x86 it needs to be
booted manually. To do this the config table in the BIOS is needed.

Add a helper to get the config table in preparation for manually
booting cards.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 78 ++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index cc6a074f3165..e92658274411 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -71,6 +71,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -336,6 +337,83 @@ static u32 do_calc_pll(int freq, int *freq_out)
 	return (n << 8) | (m << 2) | k;
 }
 
+/*
+ * Convert a pllctrl register value back to a frequency in kHz.
+ * Formula from 3dfx documentation.
+ */
+static u32 tdfx_pll_to_khz(u32 pll)
+{
+	return (14318 * (((pll >> 8) & 0xff) + 2) /
+		(((pll >> 2) & 0x3f) + 2)) >> (pll & 3);
+}
+
+/* Layout of the "OEM config" table in voodoo 3 BIOS */
+struct tdfx_bios_cfg {
+	__le32 pciinit0;	/* 0x00 */
+	__le32 miscinit0;	/* 0x04 */
+	__le32 miscinit1;	/* 0x08 */
+	__le32 draminit0;	/* 0x0c */
+	__le32 draminit1;	/* 0x10 */
+	__le32 agpinit0;	/* 0x14 */
+	__le32 pllctrl1;	/* 0x18 - memory PLL */
+	__le32 pllctrl2;	/* 0x1c - graphics PLL */
+	__le32 sgrammode;	/* 0x20 - SGRAM/SDRAM mode register data */
+} __packed;
+
+#define TDFX_ROM_CFG_PTR	0x50
+
+static bool tdfxfb_get_bios_cfg(struct pci_dev *pdev,
+				struct tdfx_bios_cfg *cfg)
+{
+	u16 romcfg, oemcfg;
+	void __iomem *rom;
+	size_t romsize;
+	u8 *image;
+	u32 khz;
+
+	/* This only works for the Voodoo 3 for now */
+	if (pdev->device != PCI_DEVICE_ID_3DFX_VOODOO3)
+		return false;
+
+	rom = pci_map_rom(pdev, &romsize);
+	if (!rom || !romsize)
+		return false;
+
+	image = vmalloc(romsize);
+	if (!image) {
+		pci_unmap_rom(pdev, rom);
+		return false;
+	}
+	memcpy_fromio(image, rom, romsize);
+	pci_unmap_rom(pdev, rom);
+
+	/* ROM[0x50] -> ROM config table -> OEM config table */
+	if (TDFX_ROM_CFG_PTR + 2 > romsize)
+		goto out;
+	romcfg = image[TDFX_ROM_CFG_PTR] | image[TDFX_ROM_CFG_PTR + 1] << 8;
+	if (romcfg == 0xffff || romcfg + 2 > romsize)
+		goto out;
+	oemcfg = image[romcfg] | image[romcfg + 1] << 8;
+	if (oemcfg == 0xffff || oemcfg + sizeof(*cfg) > romsize)
+		goto out;
+	memcpy(cfg, image + oemcfg, sizeof(*cfg));
+	vfree(image);
+
+	/*
+	 * Make sure we didn't read garbage from the BIOS and will
+	 * end up setting a frequency that explodes someone's expensive
+	 * card.
+	 */
+	khz = tdfx_pll_to_khz(le32_to_cpu(cfg->pllctrl1));
+	if (khz < 40000 || khz > 250000 || !le32_to_cpu(cfg->draminit0))
+		return false;
+	return true;
+
+out:
+	vfree(image);
+	return false;
+}
+
 static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
 {
 	struct tdfx_par *par = info->par;
-- 
2.53.0

