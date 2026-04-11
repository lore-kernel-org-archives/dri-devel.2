Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25983F3ED6C
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 09:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F4F10E00C;
	Sun, 12 Apr 2026 09:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H97RA+Au";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E06110E209
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 15:26:32 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so14443315ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775921192; x=1776525992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S2yzm7/HJQbzBsOcthAlts6qCBZnAR76KLWrUtFupiU=;
 b=H97RA+AuWldZRZsbRWxwe+vA5f8KoB3lIAHvGxndPKj+F+4WD13eHWbVwwaJScYgmb
 GOZePvdziNXzOp1fEpXG3hXFqRiPNV886PXn5M+DaWxXdaJZU/qIAmRmMqxLxkB6/Zr2
 KrF1Plge5b7gpWyk6E/bCoODnUTsRw77M0i/GPKY8tyr9o8FBwVChHsNwviwtmLDF9MJ
 96LVttla3jVYzrodxcxlW9oFDToUuWY1qe7ipD0L9nobtqQOrxMGneWYPhJ3aaKG/B7d
 5vkVihd96f+f20+tQOFRKN0yAapEF607WrgHMf9Ry2QtHkcmpzIqq7ZQW3qN8ithnZu/
 E8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775921192; x=1776525992;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2yzm7/HJQbzBsOcthAlts6qCBZnAR76KLWrUtFupiU=;
 b=D5gyIO37QmWtk28EhIiZ+6f+zaeOmMBPTypmH+FI1C9hakz3LNztBllSTdpjDkS7M8
 cCK3vNYLhBazvnsU1MBY8lg9aJjX9WrIY4a87ydwe3OpyPI2Eh3ioLlhD/BNwfehu+cR
 wmhIjysQtaT/QaqyCFCl6tfjEVLkoRaMVlMItHr0ieqvR8spFN/8Bb/IEUaspPeWfI0K
 Mkra8Pns2O1kdO6DYfhxxCzHTZotON2LluSuDoMqrSzQrg26OHjz8Qmsqw6aNugN9v8C
 er+aGWUPBH6Y+Eu2ww4iIJCDSXajW2OjeKUM+bzAK1FzfxGcnGDwME687XaOcS+31Y5C
 C4GQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sE8KI1GYWBgj+wTu14wXEguFWkGn3FwPIqcLtSQ4XROOfYDh3eAo6tqsEcmjvALU8DkVocnarJpQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS/s599pI/KO4pMpDNnJXx9qU+e5muItMtrZkMETqI0KbT34yT
 WIGB5YPeEh+cBxxPqDL5u6nw5Z9j80NRRSVcfmyqlTgtV747dt9Ti/AH
X-Gm-Gg: AeBDieuZKLPimEalXZpW1O0uMJJJ9KbqZDuuRFURaMNqhVzrKEHYtLL4ZtOi4JCYxe6
 8SgC1ikZmzxgWM1K/JAg/xBbpsV3Ml2I6xSQBsGL5ynS6GPsjjARCRmdhyWNrKre9LcCUSM3FAC
 hfBe4ipEC+3ANbN6QoXQbRhWT/6dHtILEPlOFn/75DiGdxiXYuaOTqi3wBjyQSA3HRF8NIry7+N
 qBjvfjPC7AyV8FvS0tMlS0O1UVCFwo2xSYfMFqmPvdNIdbMZPiddFybg3Nk3AbMsKdKh2tkNYoF
 Oltqt4kTk7Byp4wZhR4EFbTmL3YAJJ8PKHslYYIOy4kA7rzC+Zpw6DozbdlYDFDxfcGG4uqsTC1
 QalAs2OcPLJp21sli8a5cxJl8eNsMcXJYY833VNwQcJ4B01UpZRa5wUAEm0RMM31NzdFIHpns61
 bYeShTijIGOFIVH2jwc0CBvJL26Z56PtcrMzIW2jQmBw3UKWEHqswhNUMJBNPS3bHlBA==
X-Received: by 2002:a17:903:1a6f:b0:2b0:7d6f:4627 with SMTP id
 d9443c01a7336-2b2d5a45f9dmr72344535ad.37.1775921191790; 
 Sat, 11 Apr 2026 08:26:31 -0700 (PDT)
Received: from chandras-fedora.tail1a292d.ts.net ([14.195.131.227])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f2af90sm64077935ad.64.2026.04.11.08.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 08:26:31 -0700 (PDT)
From: Chandra Mouli Baskaran <bcmouli2006@gmail.com>
To: gregkh@linuxfoundation.org,
	andy@kernel.org
Cc: linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Chandra Mouli <bcmouli2006@gmail.com>
Subject: [PATCH] staging: fbtft: improve TODO comment clarity
Date: Sat, 11 Apr 2026 20:52:20 +0530
Message-ID: <20260411152220.89174-1-bcmouli2006@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 12 Apr 2026 09:03:11 +0000
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

From: Chandra Mouli <bcmouli2006@gmail.com>

Clarify the TODO comment in fbtft_ops_damage_range() to
better describe that the current implementation updates
the entire displayinstead of only the modified region.

Signed-off-by: Chandra Mouli <bcmouli2006@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 74 +++++++++++++++---------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index f427c0914..f011a6ebc 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -77,12 +77,12 @@ static int fbtft_request_one_gpio(struct fbtft_par *par,
 	struct device *dev = par->info->device;
 
 	*gpiop = devm_gpiod_get_index_optional(dev, name, index,
-					       GPIOD_OUT_LOW);
+						   GPIOD_OUT_LOW);
 	if (IS_ERR(*gpiop))
 		return dev_err_probe(dev, PTR_ERR(*gpiop), "Failed to request %s GPIO\n", name);
 
 	fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
-		      __func__, name);
+			  __func__, name);
 
 	return 0;
 }
@@ -112,15 +112,15 @@ static int fbtft_request_gpios(struct fbtft_par *par)
 		return ret;
 	for (i = 0; i < 16; i++) {
 		ret = fbtft_request_one_gpio(par, "db", i,
-					     &par->gpio.db[i]);
+						 &par->gpio.db[i]);
 		if (ret)
 			return ret;
 		ret = fbtft_request_one_gpio(par, "led", i,
-					     &par->gpio.led[i]);
+						 &par->gpio.led[i]);
 		if (ret)
 			return ret;
 		ret = fbtft_request_one_gpio(par, "aux", i,
-					     &par->gpio.aux[i]);
+						 &par->gpio.aux[i]);
 		if (ret)
 			return ret;
 	}
@@ -134,7 +134,7 @@ static int fbtft_backlight_update_status(struct backlight_device *bd)
 	bool polarity = par->polarity;
 
 	fbtft_par_dbg(DEBUG_BACKLIGHT, par, "%s: polarity=%d, power=%d\n", __func__,
-		      polarity, bd->props.power);
+			  polarity, bd->props.power);
 
 	if (!backlight_is_blank(bd))
 		gpiod_set_value(par->gpio.led[0], polarity);
@@ -172,7 +172,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
 
 	if (!par->gpio.led[0]) {
 		fbtft_par_dbg(DEBUG_BACKLIGHT, par,
-			      "%s(): led pin not set, exiting.\n", __func__);
+				  "%s(): led pin not set, exiting.\n", __func__);
 		return;
 	}
 
@@ -183,8 +183,8 @@ void fbtft_register_backlight(struct fbtft_par *par)
 		par->polarity = true;
 
 	bd = backlight_device_register(dev_driver_string(par->info->device),
-				       par->info->device, par,
-				       &fbtft_bl_ops, &bl_props);
+					   par->info->device, par,
+					   &fbtft_bl_ops, &bl_props);
 	if (IS_ERR(bd)) {
 		dev_err(par->info->device,
 			"cannot register backlight device (%ld)\n",
@@ -199,7 +199,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
 EXPORT_SYMBOL(fbtft_register_backlight);
 
 static void fbtft_set_addr_win(struct fbtft_par *par, int xs, int ys, int xe,
-			       int ye)
+				   int ye)
 {
 	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS,
 		  (xs >> 8) & 0xFF, xs & 0xFF, (xe >> 8) & 0xFF, xe & 0xFF);
@@ -235,8 +235,8 @@ static void fbtft_update_display(struct fbtft_par *par, unsigned int start_line,
 	if (unlikely(par->debug & (DEBUG_TIME_FIRST_UPDATE |
 			DEBUG_TIME_EACH_UPDATE))) {
 		if ((par->debug & DEBUG_TIME_EACH_UPDATE) ||
-		    ((par->debug & DEBUG_TIME_FIRST_UPDATE) &&
-		    !par->first_update_done)) {
+			((par->debug & DEBUG_TIME_FIRST_UPDATE) &&
+			!par->first_update_done)) {
 			ts_start = ktime_get();
 			timeit = true;
 		}
@@ -251,7 +251,7 @@ static void fbtft_update_display(struct fbtft_par *par, unsigned int start_line,
 		end_line = par->info->var.yres - 1;
 	}
 	if (start_line > par->info->var.yres - 1 ||
-	    end_line > par->info->var.yres - 1) {
+		end_line > par->info->var.yres - 1) {
 		dev_warn(par->info->device,
 			 "%s: start_line=%u or end_line=%u is larger than max=%d. Shouldn't happen, will do full display update\n",
 			 __func__, start_line,
@@ -261,7 +261,7 @@ static void fbtft_update_display(struct fbtft_par *par, unsigned int start_line,
 	}
 
 	fbtft_par_dbg(DEBUG_UPDATE_DISPLAY, par, "%s(start_line=%u, end_line=%u)\n",
-		      __func__, start_line, end_line);
+			  __func__, start_line, end_line);
 
 	if (par->fbtftops.set_addr_win)
 		par->fbtftops.set_addr_win(par, 0, start_line,
@@ -359,15 +359,15 @@ static unsigned int chan_to_field(unsigned int chan, struct fb_bitfield *bf)
 }
 
 static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red,
-			      unsigned int green, unsigned int blue,
-			      unsigned int transp, struct fb_info *info)
+				  unsigned int green, unsigned int blue,
+				  unsigned int transp, struct fb_info *info)
 {
 	unsigned int val;
 	int ret = 1;
 
 	fb_dbg(info,
-	       "regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X\n",
-	       regno, red, green, blue, transp);
+		   "regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X\n",
+		   regno, red, green, blue, transp);
 
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
@@ -414,7 +414,9 @@ static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
 {
 	struct fbtft_par *par = info->par;
 
-	/* TODO: only mark changed area update all for now */
+	/* TODO: Optimize to update only the modified region instead
+	 * of refreshing the entire display.
+	 */
 	par->fbtftops.mkdirty(info, -1, 0);
 }
 
@@ -577,10 +579,10 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 	if (display->gamma_num && display->gamma_len) {
 		gamma_curves = devm_kcalloc(dev,
-					    display->gamma_num *
-					    display->gamma_len,
-					    sizeof(gamma_curves[0]),
-					    GFP_KERNEL);
+						display->gamma_num *
+						display->gamma_len,
+						sizeof(gamma_curves[0]),
+						GFP_KERNEL);
 		if (!gamma_curves)
 			return NULL;
 	}
@@ -793,10 +795,10 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
 			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
 	fb_dbg(fb_info,
-	       "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
-	       fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
-	       fb_info->fix.smem_len >> 10, text1,
-	       HZ / fb_info->fbdefio->delay, text2);
+		   "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
+		   fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
+		   fb_info->fix.smem_len >> 10, text1,
+		   HZ / fb_info->fbdefio->delay, text2);
 
 	/* Turn on backlight if available */
 	if (fb_info->bl_dev) {
@@ -885,10 +887,10 @@ static int fbtft_init_display_from_property(struct fbtft_par *par)
 			}
 			/* make debug message */
 			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-				      "init: write_register:\n");
+					  "init: write_register:\n");
 			for (j = 0; j < i; j++)
 				fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-					      "buf[%d] = %02X\n", j, buf[j]);
+						  "buf[%d] = %02X\n", j, buf[j]);
 
 			par->fbtftops.write_register(par, i,
 				buf[0], buf[1], buf[2], buf[3],
@@ -909,7 +911,7 @@ static int fbtft_init_display_from_property(struct fbtft_par *par)
 				buf[60], buf[61], buf[62], buf[63]);
 		} else if (val & FBTFT_OF_INIT_DELAY) {
 			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-				      "init: msleep(%u)\n", val & 0xFFFF);
+					  "init: msleep(%u)\n", val & 0xFFFF);
 			msleep(val & 0xFFFF);
 			val = values[++index];
 		} else {
@@ -1020,8 +1022,8 @@ int fbtft_init_display(struct fbtft_par *par)
 		case -2:
 			i++;
 			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-				      "init: mdelay(%d)\n",
-				      par->init_sequence[i]);
+					  "init: mdelay(%d)\n",
+					  par->init_sequence[i]);
 			mdelay(par->init_sequence[i++]);
 			break;
 		default:
@@ -1052,7 +1054,7 @@ static int fbtft_verify_gpios(struct fbtft_par *par)
 	int i;
 
 	if (pdata->display.buswidth != 9 &&  par->startbyte == 0 &&
-	    !par->gpio.dc) {
+		!par->gpio.dc) {
 		dev_err(par->info->device,
 			"Missing info about 'dc' gpio. Aborting.\n");
 		return -EINVAL;
@@ -1140,8 +1142,8 @@ static struct fbtft_platform_data *fbtft_properties_read(struct device *dev)
  * Return: 0 if successful, negative if error
  */
 int fbtft_probe_common(struct fbtft_display *display,
-		       struct spi_device *sdev,
-		       struct platform_device *pdev)
+			   struct spi_device *sdev,
+			   struct platform_device *pdev)
 {
 	struct device *dev;
 	struct fb_info *info;
@@ -1264,7 +1266,7 @@ void fbtft_remove_common(struct device *dev, struct fb_info *info)
 	par = info->par;
 	if (par)
 		fbtft_par_dbg(DEBUG_DRIVER_INIT_FUNCTIONS, par,
-			      "%s()\n", __func__);
+				  "%s()\n", __func__);
 	fbtft_unregister_framebuffer(info);
 	fbtft_framebuffer_release(info);
 }
-- 
2.53.0

