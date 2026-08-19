Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328D3C5DF8B
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1DEE10EF71;
	Thu, 20 Aug 2026 08:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.pl header.i=@yahoo.pl header.b="o1awkTT1";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-euwe1-0017.asd.mail.yahoo.com
 [34.2.82.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C6F10E166
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048;
 t=1787157900; bh=fxgdbKZ4EVOmdlAegT37bG2gyo0fL7Bviv99W3LuWQE=;
 h=From:Date:Subject:To:Cc:References:From:Subject:Reply-To;
 b=o1awkTT1ZMgERffT/bNFTXmt4srItwfqLjThS6tZ0j2F9L+jh1yh/rnvoiLHHGbdYZolgacnBoP4RjVx/zG5P6LB1vFYmA/A3IbWZ5moqQV85d9TCh4F09qTPFej14dye0YhlXWCVcdLsJfaLitgOmu4EXr9izdTGvU4Rf4oDo1b8iWtAUh547IYp0FPhuY2GJvLvPdrIfOQ1DsV34rAnxwiq8bpFNY5Ih3hiUQ+SDz0vkHj3dt3cw23ox4Bsja3HMW7X2707Uf5FR7E6iB8GsBUDqqDqwl19tlFFQx1HyeWnDI/Ywj0m6329+paNrUfeiwtqAkQqE6uMRglp4adKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787157900; bh=pzN0DZQZmmMdJVCkjXFx5oSOlXKWr/JYLwDlizRlkkm=;
 h=X-Sonic-MF:From:Date:Subject:To:From:Subject;
 b=CbJUbLY4KbTNunR4L4GMPHg6yLgWwfmAgKbrmso7cGJhw9pt3F0+J2c8yOUY7ye2mXvT2AZcw9ZsNvGgeMSdiPcVIXYGq3reRKl1c8IrHaJ6Jrt3+WncyTzxBPpWoouiSlKHF1asN7AfLIDqVgD2xewowexwCNVH/c5qxzns/svJhdFSwcZLiBtedwXkUCECLgy4V6kWHb5DxfDm2ilTEDDEk01mZ0spV4fyvK0ahsjaECHu50Bwjv7a0+pR83gFCM7hESnEWb8qmLQGcAYpbCf9SVQv8c+ZS2X4nZmcGGKrCkfX0AFe3k5btJcuoQIeBpKK2orKk8ZiwezuGnizQw==
X-YMail-OSG: fbh0ObMVM1n3pFygdC3kO4_AYrlEibhGhL6U8lKaoUhMUShlpUAZ2QipvKAwrea
 8i.RNbhBiLnjN1qmm0yirK7Le3IFad.6Lq2ppf8P3o3sM5tUa17cprmmvV_CTJmtZF0xwNhibFsl
 Xlp63X_R6xH_G0KO.ljVjEBFPTfmK.D6h2GIPIhtLfS7Qxx.bpU7Dfr7V8zKitbdifUVsW.WzI0H
 2UD1fgSgNzvW2ltGGWqfPiR7b1ynVvIzQfhsxX.w_zWfljQmwUa6_sVri0Brt902rgSW5TiKsQzK
 BN_docpHXHld4GWmATRWokAAaFfaw48YVjq7OT.AqXaDA1qRst1ZLGVK.GOkG0LsN7UFt6trCUA3
 W3mhbWKQf_p1bt2sFsTaMTRtovpstX6bo6yQlkDAUkvpVfXP5s3PnzffHkTsd4_dRI8ld1Iy2NeG
 j0AF1sdjTAPBwo46LtLz6ZLJqZmVz2Aq9hW2aj68D5J0eknB9fbs9DoER_nlBEBSoVMwXg1M6UEL
 PUBw5jXWg4d_AguUcPjBVEEoyF8wumDq8uqni.chP1e5YWSl37LrYuHyWAVJwuWkrUX9rj1z0F1Q
 M.0KsmiYLlhK9ZwMt9AaxFXRUt1kyWjMKK5OXPErBMWysf3Q0F2Sgu49HL3udmmWTZS2P7_Mq6v2
 8ZvRIStcCfwQ8DniyIjvGZt8yEkxs3NjaXT2wUl.tKTVYeNGUP4gxJTbG15q5zrRIGsHbHKRUMLJ
 Bfre6_70G53z9zLsAMiyD0.L6syfq.AXGBAhg26lUfb1R1Pfbst553feC3K3JQx45tYmwA23HcVp
 q1r8UPfZuvALbnhNT_14lTpX00kcyPnrg4CMsY6GcLJo9VQ.kB0uoYjFDSBIU13ht2b9ditI5xrL
 7yu0EK178MbL_eUX8StYqxekkHNdtFrd2HA3dBZe6J7mLT78PYhqU6Tqpz4OPjfkH3IILxZcHa5l
 QHuej6cTGD2JIr91JqiyBfXex3.Sidd4V9vY3hqgYDED.7eKIlQVrD5jjtesr7i9XZrexH_2dcpe
 swr3lJUZDH4AQznavCJ4LFjYIJ7qq7Y2XXqHYkLvaRE0vFcQfemX6i8rZrFvzVAJpzeLZvadO6U7
 CZYCTd5R4WaRGKe7AUIbEBuVoi7FXTqVU2EQP_kw4iuhdOBnSVN_nb8onsNlaleXQfkBao2SKvH.
 0n.9HWqgpmZ_nYkL6eOsAso36_vY_8xC9h9SEoBwHhxhRojHXjclVP6lMPR_H8rw.aHVYKJ2_3lB
 X7CtRTcLsDspIKisB9gkcS1jiZcMKmQwqVRoj2TEQb9.8USuuoiGoC6EoCro7JocCwtJ4mvA_9xu
 fIagAm5Cvdgu5D88ZahnEOM2u33ynWj45JGRuQPqrA2e5mkB60p5mKbMLlSzRxZUkvX.3BTWxDvh
 xip0pfXUCRBlXbCtCmzxKilTMmsY3rzEOvKTWc76i66fQyZrXm3R6RnCliOjKb0tzT5NAzNPfnan
 BSKpd.5VnmDee9cmbsU8VeyMMB1t2zRHGrSOULnMk0vsi0y0J2PT.VbC8fmQuROwMK4Q.o2x0gBV
 A6wzQiiOcE7fESgIOFFZYYyxHZNaMMWkTn_mLC2Y..KpDrjvuZHbfiLjHkXERbSRM_wuEdO7mM4s
 .BdY.JFLVL2CXk9P_TwoUNtrs2GAsh4GQQDRFEBmMSeXY84.abPmn3f8hhPPJ9kzoeAbqNSf_Heu
 61PqHuAD2AdQdeXmSIdf1dITuT5E13nNsY0.G7p3s6eKz.5DQ8LLkgStySTJ7IyZS25kXiFJRmrC
 egfV5ufBTwTPcaWeX2qtLMpIix767xPOzjZAaOJX_LaC8j2W0CUOutTQLFdFJaOuQ7F7YKZc6oT2
 G7AVMghh.1Z6HuieMVFVmrY.WdLQ7lHUVQi.hsBQJbp6i_pcjfnjbCTi4vh6MtTc.RkOv3QAlzke
 pWw6TWQxIM5zaSGFUbqcbfHn8p3FEiPNpCDawTI6YHuWtudsAOXW5filWbTmXzP2jbN2jmcTFSe0
 ie3WGZUGEBkP_cYcT7V689ysAI84U7yKHqSdbcwL_xAuoV1LAuTbvHfG.VWD9EQ--
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 9b716b9d-7246-472c-8d1e-624c7e58f7e5
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-euwe1-prod-sonicconsumer-svc-102 with HTTP;
 Wed, 19 Aug 2026 16:45:00 +0000
Received: from dip105.lsn.ir2.yahoo.com ([87.248.99.114])
 by hello (SMTP) with SMTP ID 5d5ae7f586cb629b9c02634e046e3739;
 Wed, 19 Aug 2026 16:44:55 +0000 (UTC)
From: Tomasz Unger <tomasz.unger@yahoo.pl>
Date: Wed, 19 Aug 2026 18:44:44 +0200
Subject: [PATCH] staging: fbtft: prefer scnprintf over sprintf in fbtft-core.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-fbtft-core-scnprintf-v1-1-842c0603634c@yahoo.pl>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxA0auQrm0yMxKCXsW4kNJCXQykHY0J4
 e4OunyL/zdwNmWHa7OB8Vtdl1wRTw3Q/MgTo47VkELqQh8vKEORgrQYo1NeTXMRjEIS2tRRf26
 hpqux6Oe3vd3/9tfwZCrHC/b9C+QJjtF4AAAA
X-Change-ID: 20260819-fbtft-core-scnprintf-1fcf0426c834
To: Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Tomasz Unger <tomasz.unger@yahoo.pl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787157894; l=2505;
 i=tomasz.unger@yahoo.pl; s=20260311; h=from:subject:message-id;
 bh=fAj/ZwZdDNIq6XPDw1CtOG2+/TZWCjN9a5TCWDhfr0I=;
 b=TOIBrdl31TNOG55V/dOQ/xIgEIbFBGWCGHNHXLhkT8N3LD6fK1YdGoZweUdcZ/b8YIoaZRts7
 EWCkNIj+vgKCq+86Il/+GteuXyHTwjyqfHJe6MysIP1iAZCUWt1bOw/
X-Developer-Key: i=tomasz.unger@yahoo.pl; a=ed25519;
 pk=EPPsO91uz/0J2cTQ6ol+dgxYaieEc9dKSXWUb51n46c=
References: <20260819-fbtft-core-scnprintf-v1-1-842c0603634c.ref@yahoo.pl>
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:48:42 +0000
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

Using sprintf has potential for buffer overflows if the formatted
string exceeds the destination buffer size. Replace it with
scnprintf, passing sizeof() of the fixed-size stack buffers
(text1[50] and text2[50]) so the write is always bounded.

In practice an overflow is very unlikely here: text1 only needs
room for a size_t value from an SPI TX buffer length, and text2
formats three small integers (bus number, chip select, and
frequency in MHz) that always come from real hardware ranges far
below the theoretical worst case for their types. This is
therefore a defense-in-depth hardening rather than a fix for an
observed or easily triggered issue.

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
Verified with checkpatch.pl - no errors or warnings.
Compiled the fbtft module successfully with CONFIG_FB_TFT=m
(also required enabling CONFIG_FB=m, CONFIG_SPI=y and
CONFIG_GPIOLIB=y, all previously disabled).
fb.ko, syscopyarea.ko, sysimgblt.ko, sysfillrect.ko,
fb_sys_fops.ko and fbtft.ko all load without errors in a QEMU
environment (verified via insmod and lsmod). This confirms the
modules load cleanly but does not exercise the changed code
path, which would require an actual SPI-connected TFT display.
---
 drivers/staging/fbtft/fbtft-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index ca0c38221c16..95c92ad55e98 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -784,10 +784,10 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	fbtft_sysfs_init(par);
 
 	if (par->txbuf.buf && par->txbuf.len >= 1024)
-		sprintf(text1, ", %zu KiB buffer memory", par->txbuf.len >> 10);
+		scnprintf(text1, sizeof(text1), ", %zu KiB buffer memory", par->txbuf.len >> 10);
 	if (spi)
-		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
-			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
+		scnprintf(text2, sizeof(text2), ", spi%d.%d at %d MHz", spi->controller->bus_num,
+			  spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
 	fb_dbg(fb_info,
 	       "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
 	       fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260819-fbtft-core-scnprintf-1fcf0426c834

Best regards,
--  
Tomasz Unger <tomasz.unger@yahoo.pl>

