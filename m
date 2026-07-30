Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778B8C5516E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967F310EFAB;
	Thu, 30 Jul 2026 18:27:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="q6/ag7+J";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12FA10F019
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:27:01 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso272239b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785436021; x=1786040821; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kDb2lpOWcTmtm+d/TFdlb5UDpwayQCJmDNQmiV6VIlg=;
 b=q6/ag7+Jvm/smsjgWtxDGjRc80vV+yeZavyhu1wH7D1S2I/f454NH1pSsqT8lIIaHd
 MoCNUYANKgw13BczOxEjnnT03eqWb0gcFVipZ9AlwLI95+XUkBEt5T2EhrQdGVEIl9zF
 95vmd/qXUhfm2vw1W1OxJyl+Cds2nEbCSBQBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436021; x=1786040821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kDb2lpOWcTmtm+d/TFdlb5UDpwayQCJmDNQmiV6VIlg=;
 b=cjRlyMhz3LunVYrCz97fT0lcnFT2lYZDxMfz4dDKVeu9yEMMkP98OFP/VDBWV+tJWQ
 CZkGH4VRDvUuL/XSpwFVRwGMS8ZY2potWMK6EZl6HmDVqdxAebGr9xrUiBlJWYymGjaN
 XFomkcYee/rhAyeQ1PSTlDBjJ5Sc9lXxq/Ws0Ka0/Gfr79Zb3Tg6yWc0iB353lCsB5p5
 ONfXSQyaQ6sDDeGTHUJyCmjSWXizDe8NUvmNVTc1iHB/cXsuB3mUtx/8QkBKes3Q9I02
 tcS96OzziZdZcgMppLm2DTdlGXraWcjcwg3Ojt8/NE9hm5vxf9e6zETFixyRSvEXGGRC
 5bdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxCCAgvZr4yAy4Vp1O60Saljc4yJ1w+B9G6h5on6iL7cAmW60ZH7EP2YM6eA0uVLeJMGG/+Q1xdfg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwusU9qp5HTj2daB5/NMaPag8nBCcoqV9NMFKybcSYZfNzrpB2h
 mlNKQjpDEKDWieytVydwEKwlsszvBON0PzNI9qGHV0SGUVqJ66YD6orzUPlkwzRhCkBVw4CFVUl
 TeUuG
X-Gm-Gg: AR+sD12BcQA483vQaSS9/QDtx4bV4cOY4Mi8RUT8e77eAyeyJMjuXJYABBhQuUtXUaC
 OsgvN/YQ3Sa5xVdJ4qA2H74s0KVXmWCQiimsrZroaTwxxPjxCAn8WTGHmrLluRCzJppSf8SnBy3
 3IO93RsepVBpeFESucBb90oAq62z+MOknh4Y5ADevfXvfjoaVeHXeJAQw/FHipCf9LBcrD8sSXE
 r+M34eMNAh6cq7o7gGZOreGHikZwfHA+oYO2Mo/QUR9ryMsFrTo4cKOb8lThtQOBwrDZnmnQYx2
 L7mFXEfItBIXHwQLkoAF1Uv/i/dncxtS30171BeEm0Y44rkkx9a1Lse0f0fXD14wzXgF/lo9unv
 UxL7Xiw75sBHhmuRS3la7s/NjyXXvoGIy7ISNSHHtD+hFYkpNwouqXm+FL3J6v1uof0v+yptPbM
 QO3buOMDwTvFj8s3v+RCknz9pBsZMR9BfSZrDxhlUefzkQ5rDYGes=
X-Received: by 2002:a05:6a00:4143:b0:848:2f7a:2e58 with SMTP id
 d2e1a72fcca58-84ebc4471aemr3293938b3a.71.1785436021391; 
 Thu, 30 Jul 2026 11:27:01 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:f84d:1f36:28ac:c15e])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-84ea0378b18sm3428806b3a.48.2026.07.30.11.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:27:00 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/5] fbdev: tdfxfb: Add helper to read config table from BIOS
Date: Fri, 31 Jul 2026 03:26:36 +0900
Message-ID: <20260730182640.2808572-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730182640.2808572-1-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
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
 drivers/video/fbdev/tdfxfb.c | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index cc6a074f3165..fa554b09a0a6 100644
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
@@ -336,6 +337,79 @@ static u32 do_calc_pll(int freq, int *freq_out)
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

