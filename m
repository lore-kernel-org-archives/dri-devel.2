Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBACAC5516F
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03BA910E2E1;
	Sat,  1 Aug 2026 07:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=elsta.tech header.i=@elsta.tech header.b="h0P4QLxL";
	dkim-atps=neutral
Received: from mail.elsta.tech (mail.elsta.tech [194.150.96.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49F910F218
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 10:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.elsta.tech (Postfix) with ESMTP id 8B8E48D53B0;
 Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Authentication-Results: mail.elsta.tech (amavis); dkim=pass (2048-bit key)
 header.d=elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10032) with ESMTP
 id w_5u-wOWrmyM; Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.elsta.tech (Postfix) with ESMTP id 575C58D53B3;
 Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.elsta.tech 575C58D53B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elsta.tech;
 s=0883730E-C77C-11E9-9DA4-0BE9876769AA; t=1785494793;
 bh=ZxF0Ia0SpL2leWM4M8BdqR+cmjt5HfKK1z6aKB6gE6g=;
 h=From:Date:MIME-Version:Message-Id:To;
 b=h0P4QLxL2/CM/udcfgkpEZYjrqVi5wtqT0wexFUnTDa1mvOBhKFkGQC0IlMNGEO6h
 65vD6Hym7wPYt2STXDvm8IgY/waZGRYuUDPJoYSx1yE6M/5tRpSCIEQ5HoVBnUcTKf
 26NZYZHoW2WsT2nqOfEiUBooZl756u9Rj9aOeUvxjNeKzLltHhxG7cgcJo8ETIlewN
 bd1lgYNmApBqRpWGhx87RjAuOxb/LaBK0m+rQ88T5F+9zR9UEerNG5bNUVXx+GgHMT
 v1zqcYe38Pq5rUUhiNQOazad6UeKrH0GoU5LV4eDbPMMtSnRhLxnqKWaY5hCsSomz5
 nLXt18uYMbxkA==
X-Virus-Scanned: amavis at elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10026) with ESMTP
 id di8XxouTnVal; Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Received: from [127.0.1.1] (unknown [172.31.0.125])
 by mail.elsta.tech (Postfix) with ESMTPSA id 1EC928D53B0;
 Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
From: Jakub Turek <jakub.turek@elsta.tech>
Date: Fri, 31 Jul 2026 12:46:16 +0200
Subject: [PATCH 1/2] fbdev: ssd1307fb: add support for Sino Wealth SH1107
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-feat-sh1107-v1-1-e10977f76e6b@elsta.tech>
References: <20260731-feat-sh1107-v1-0-e10977f76e6b@elsta.tech>
In-Reply-To: <20260731-feat-sh1107-v1-0-e10977f76e6b@elsta.tech>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jakub Turek <jakub.turek@elsta.tech>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
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

The SH1107 display controller is very similar to SSD1307 but the main
difference is that SH1107 has different memory layout and uses page mode
adressation only.

The SH1107 relies primarily on vertical page addressing mode where the
internal 128x128 GDDRAM is split into 16 vertical pages, rather than
the horizontal/tile addressing modes natively utilized by the
SSD1306/SSD1307.

Signed-off-by: Jakub Turek  <jakub.turek@elsta.tech>
---
 drivers/video/fbdev/ssd1307fb.c | 234 ++++++++++++++++++++++++++--------------
 1 file changed, 155 insertions(+), 79 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 644b8d97b381..4930d5c999ff 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -17,29 +17,31 @@
 #include <linux/uaccess.h>
 #include <linux/regulator/consumer.h>
 
-#define SSD1307FB_DATA			0x40
-#define SSD1307FB_COMMAND		0x80
-
-#define SSD1307FB_SET_ADDRESS_MODE	0x20
-#define SSD1307FB_SET_ADDRESS_MODE_HORIZONTAL	(0x00)
-#define SSD1307FB_SET_ADDRESS_MODE_VERTICAL	(0x01)
-#define SSD1307FB_SET_ADDRESS_MODE_PAGE		(0x02)
-#define SSD1307FB_SET_COL_RANGE		0x21
-#define SSD1307FB_SET_PAGE_RANGE	0x22
-#define SSD1307FB_CONTRAST		0x81
-#define SSD1307FB_SET_LOOKUP_TABLE	0x91
-#define	SSD1307FB_CHARGE_PUMP		0x8d
-#define SSD1307FB_SEG_REMAP_ON		0xa1
-#define SSD1307FB_DISPLAY_OFF		0xae
-#define SSD1307FB_SET_MULTIPLEX_RATIO	0xa8
-#define SSD1307FB_DISPLAY_ON		0xaf
-#define SSD1307FB_START_PAGE_ADDRESS	0xb0
-#define SSD1307FB_SET_DISPLAY_OFFSET	0xd3
-#define	SSD1307FB_SET_CLOCK_FREQ	0xd5
-#define	SSD1307FB_SET_AREA_COLOR_MODE	0xd8
-#define	SSD1307FB_SET_PRECHARGE_PERIOD	0xd9
-#define	SSD1307FB_SET_COM_PINS_CONFIG	0xda
-#define	SSD1307FB_SET_VCOMH		0xdb
+#define SSD1307FB_DATA 0x40
+#define SSD1307FB_COMMAND 0x80
+
+#define SSD1307FB_PAGE_COL_START_LOW 0x00
+#define SSD1307FB_PAGE_COL_START_HIGH 0x10
+#define SSD1307FB_SET_ADDRESS_MODE 0x20
+#define SSD1307FB_SET_ADDRESS_MODE_HORIZONTAL (0x00)
+#define SSD1307FB_SET_ADDRESS_MODE_VERTICAL (0x01)
+#define SSD1307FB_SET_ADDRESS_MODE_PAGE (0x02)
+#define SSD1307FB_SET_COL_RANGE 0x21
+#define SSD1307FB_SET_PAGE_RANGE 0x22
+#define SSD1307FB_CONTRAST 0x81
+#define SSD1307FB_SET_LOOKUP_TABLE 0x91
+#define SSD1307FB_CHARGE_PUMP 0x8d
+#define SSD1307FB_SEG_REMAP_ON 0xa1
+#define SSD1307FB_DISPLAY_OFF 0xae
+#define SSD1307FB_SET_MULTIPLEX_RATIO 0xa8
+#define SSD1307FB_DISPLAY_ON 0xaf
+#define SSD1307FB_START_PAGE_ADDRESS 0xb0
+#define SSD1307FB_SET_DISPLAY_OFFSET 0xd3
+#define SSD1307FB_SET_CLOCK_FREQ 0xd5
+#define SSD1307FB_SET_AREA_COLOR_MODE 0xd8
+#define SSD1307FB_SET_PRECHARGE_PERIOD 0xd9
+#define SSD1307FB_SET_COM_PINS_CONFIG 0xda
+#define SSD1307FB_SET_VCOMH 0xdb
 
 #define MAX_CONTRAST 255
 
@@ -54,9 +56,11 @@ struct ssd1307fb_deviceinfo {
 	u32 default_dclk_frq;
 	bool need_pwm;
 	bool need_chargepump;
+	bool page_mode_only;
 };
 
 struct ssd1307fb_par {
+	unsigned page_address_mode : 1;
 	unsigned area_color_enable : 1;
 	unsigned com_invdir : 1;
 	unsigned com_lrremap : 1;
@@ -90,22 +94,22 @@ struct ssd1307fb_par {
 };
 
 struct ssd1307fb_array {
-	u8	type;
-	u8	data[];
+	u8 type;
+	u8 data[];
 };
 
 static const struct fb_fix_screeninfo ssd1307fb_fix = {
-	.id		= "Solomon SSD1307",
-	.type		= FB_TYPE_PACKED_PIXELS,
-	.visual		= FB_VISUAL_MONO10,
-	.xpanstep	= 0,
-	.ypanstep	= 0,
-	.ywrapstep	= 0,
-	.accel		= FB_ACCEL_NONE,
+	.id = "Solomon SSD1307",
+	.type = FB_TYPE_PACKED_PIXELS,
+	.visual = FB_VISUAL_MONO10,
+	.xpanstep = 0,
+	.ypanstep = 0,
+	.ywrapstep = 0,
+	.accel = FB_ACCEL_NONE,
 };
 
 static const struct fb_var_screeninfo ssd1307fb_var = {
-	.bits_per_pixel	= 1,
+	.bits_per_pixel = 1,
 	.red = { .length = 1 },
 	.green = { .length = 1 },
 	.blue = { .length = 1 },
@@ -115,7 +119,7 @@ static struct ssd1307fb_array *ssd1307fb_alloc_array(u32 len, u8 type)
 {
 	struct ssd1307fb_array *array;
 
-	array = kzalloc(sizeof(struct ssd1307fb_array) + len, GFP_KERNEL);
+	array = kzalloc(sizeof(*array) + len, GFP_KERNEL);
 	if (!array)
 		return NULL;
 
@@ -209,6 +213,33 @@ static int ssd1307fb_set_page_range(struct ssd1307fb_par *par, u8 page_start,
 	return 0;
 }
 
+static int ssd1307fb_set_page_pos(struct ssd1307fb_par *par, u8 page_start,
+				  u8 col_start)
+{
+	int ret;
+	u8 page;
+	u8 col_low;
+	u8 col_high;
+
+	page = SSD1307FB_START_PAGE_ADDRESS | (page_start & 0x0f);
+	col_low = SSD1307FB_PAGE_COL_START_LOW | (col_start & 0x0f);
+	col_high = SSD1307FB_PAGE_COL_START_HIGH | ((col_start >> 4) & 0x0f);
+
+	ret = ssd1307fb_write_cmd(par->client, page);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, col_low);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, col_high);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int ssd1307fb_update_rect(struct ssd1307fb_par *par, unsigned int x,
 				 unsigned int y, unsigned int width,
 				 unsigned int height)
@@ -253,13 +284,16 @@ static int ssd1307fb_update_rect(struct ssd1307fb_par *par, unsigned int x,
 	 *  (5) A4 B4 C4 D4 E4 F4 G4 H4
 	 */
 
-	ret = ssd1307fb_set_col_range(par, par->col_offset + x, width);
-	if (ret < 0)
-		goto out_free;
+	if (!par->page_address_mode) {
+		ret = ssd1307fb_set_col_range(par, par->col_offset + x, width);
+		if (ret < 0)
+			goto out_free;
 
-	ret = ssd1307fb_set_page_range(par, par->page_offset + y / 8, pages);
-	if (ret < 0)
-		goto out_free;
+		ret = ssd1307fb_set_page_range(par, par->page_offset + y / 8,
+					       pages);
+		if (ret < 0)
+			goto out_free;
+	}
 
 	for (i = y / 8; i < y / 8 + pages; i++) {
 		int m = 8;
@@ -271,16 +305,31 @@ static int ssd1307fb_update_rect(struct ssd1307fb_par *par, unsigned int x,
 			u8 data = 0;
 
 			for (k = 0; k < m; k++) {
-				u8 byte = vmem[(8 * i + k) * line_length +
-					       j / 8];
+				u8 byte =
+					vmem[(8 * i + k) * line_length + j / 8];
 				u8 bit = (byte >> (j % 8)) & 1;
+
 				data |= bit << k;
 			}
 			array->data[array_idx++] = data;
 		}
+
+		if (par->page_address_mode) {
+			ret = ssd1307fb_set_page_pos(par, par->page_offset + i,
+						     par->col_offset + x);
+			if (ret < 0)
+				goto out_free;
+
+			ret = ssd1307fb_write_array(par->client, array, width);
+			if (ret < 0)
+				goto out_free;
+
+			array_idx = 0;
+		}
 	}
 
-	ret = ssd1307fb_write_array(par->client, array, width * pages);
+	if (!par->page_address_mode)
+		ret = ssd1307fb_write_array(par->client, array, width * pages);
 
 out_free:
 	kfree(array);
@@ -302,7 +351,8 @@ static int ssd1307fb_blank(int blank_mode, struct fb_info *info)
 		return ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
 }
 
-static void ssd1307fb_defio_damage_range(struct fb_info *info, off_t off, size_t len)
+static void ssd1307fb_defio_damage_range(struct fb_info *info, off_t off,
+					 size_t len)
 {
 	struct ssd1307fb_par *par = info->par;
 
@@ -317,17 +367,17 @@ static void ssd1307fb_defio_damage_area(struct fb_info *info, u32 x, u32 y,
 	ssd1307fb_update_rect(par, x, y, width, height);
 }
 
-FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(ssd1307fb,
-				   ssd1307fb_defio_damage_range,
+FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(ssd1307fb, ssd1307fb_defio_damage_range,
 				   ssd1307fb_defio_damage_area)
 
 static const struct fb_ops ssd1307fb_ops = {
-	.owner		= THIS_MODULE,
+	.owner = THIS_MODULE,
 	FB_DEFAULT_DEFERRED_OPS(ssd1307fb),
-	.fb_blank	= ssd1307fb_blank,
+	.fb_blank = ssd1307fb_blank,
 };
 
-static void ssd1307fb_deferred_io(struct fb_info *info, struct list_head *pagereflist)
+static void ssd1307fb_deferred_io(struct fb_info *info,
+				  struct list_head *pagereflist)
 {
 	ssd1307fb_update_display(info->par);
 }
@@ -341,7 +391,8 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (par->device_info->need_pwm) {
 		par->pwm = pwm_get(&par->client->dev, NULL);
 		if (IS_ERR(par->pwm)) {
-			dev_err(&par->client->dev, "Could not get PWM from device tree!\n");
+			dev_err(&par->client->dev,
+				"Could not get PWM from device tree!\n");
 			return PTR_ERR(par->pwm);
 		}
 
@@ -352,8 +403,9 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		/* Enable the PWM */
 		pwm_enable(par->pwm);
 
-		dev_dbg(&par->client->dev, "Using PWM %s with a %lluns period.\n",
-			par->pwm->label, pwm_get_period(par->pwm));
+		dev_dbg(&par->client->dev,
+			"Using PWM %s with a %lluns period.\n", par->pwm->label,
+			pwm_get_period(par->pwm));
 	}
 
 	/* Set initial contrast */
@@ -374,7 +426,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 
 	/* Set COM direction */
 	com_invdir = 0xc0 | par->com_invdir << 3;
-	ret = ssd1307fb_write_cmd(par->client,  com_invdir);
+	ret = ssd1307fb_write_cmd(par->client, com_invdir);
 	if (ret < 0)
 		return ret;
 
@@ -416,7 +468,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 			return ret;
 
 		mode = (par->area_color_enable ? 0x30 : 0) |
-			(par->low_power ? 5 : 0);
+		       (par->low_power ? 5 : 0);
 		ret = ssd1307fb_write_cmd(par->client, mode);
 		if (ret < 0)
 			return ret;
@@ -457,7 +509,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		return ret;
 
 	ret = ssd1307fb_write_cmd(par->client,
-		BIT(4) | (par->device_info->need_chargepump ? BIT(2) : 0));
+				  BIT(4) | (par->device_info->need_chargepump ? BIT(2) : 0));
 	if (ret < 0)
 		return ret;
 
@@ -483,13 +535,16 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		}
 	}
 
-	/* Switch to horizontal addressing mode */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_ADDRESS_MODE);
 	if (ret < 0)
 		return ret;
 
-	ret = ssd1307fb_write_cmd(par->client,
-				  SSD1307FB_SET_ADDRESS_MODE_HORIZONTAL);
+	if (par->page_address_mode)
+		ret = ssd1307fb_write_cmd(par->client,
+					  SSD1307FB_SET_ADDRESS_MODE_PAGE);
+	else
+		ret = ssd1307fb_write_cmd(par->client,
+					  SSD1307FB_SET_ADDRESS_MODE_HORIZONTAL);
 	if (ret < 0)
 		return ret;
 
@@ -531,9 +586,9 @@ static int ssd1307fb_get_brightness(struct backlight_device *bdev)
 }
 
 static const struct backlight_ops ssd1307fb_bl_ops = {
-	.options	= BL_CORE_SUSPENDRESUME,
-	.update_status	= ssd1307fb_update_bl,
-	.get_brightness	= ssd1307fb_get_brightness,
+	.options = BL_CORE_SUSPENDRESUME,
+	.update_status = ssd1307fb_update_bl,
+	.get_brightness = ssd1307fb_get_brightness,
 };
 
 static struct ssd1307fb_deviceinfo ssd1307fb_ssd1305_deviceinfo = {
@@ -562,6 +617,13 @@ static struct ssd1307fb_deviceinfo ssd1307fb_ssd1309_deviceinfo = {
 	.default_dclk_frq = 10,
 };
 
+static struct ssd1307fb_deviceinfo ssd1307fb_sh1107_deviceinfo = {
+	.default_vcomh = 0x35,
+	.default_dclk_div = 1,
+	.default_dclk_frq = 8,
+	.page_mode_only = 1,
+};
+
 static const struct of_device_id ssd1307fb_of_match[] = {
 	{
 		.compatible = "solomon,ssd1305fb-i2c",
@@ -579,6 +641,10 @@ static const struct of_device_id ssd1307fb_of_match[] = {
 		.compatible = "solomon,ssd1309fb-i2c",
 		.data = (void *)&ssd1307fb_ssd1309_deviceinfo,
 	},
+	{
+		.compatible = "sinowealth,sh1107",
+		.data = (void *)&ssd1307fb_sh1107_deviceinfo,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ssd1307fb_of_match);
@@ -617,7 +683,8 @@ static int ssd1307fb_probe(struct i2c_client *client)
 		if (ret == -ENODEV) {
 			par->vbat_reg = NULL;
 		} else {
-			dev_err_probe(dev, ret, "failed to get VBAT regulator\n");
+			dev_err_probe(dev, ret,
+				      "failed to get VBAT regulator\n");
 			goto fb_alloc_error;
 		}
 	}
@@ -628,19 +695,24 @@ static int ssd1307fb_probe(struct i2c_client *client)
 	if (device_property_read_u32(dev, "solomon,height", &par->height))
 		par->height = 16;
 
-	if (device_property_read_u32(dev, "solomon,page-offset", &par->page_offset))
+	if (device_property_read_u32(dev, "solomon,page-offset",
+				     &par->page_offset))
 		par->page_offset = 1;
 
-	if (device_property_read_u32(dev, "solomon,col-offset", &par->col_offset))
+	if (device_property_read_u32(dev, "solomon,col-offset",
+				     &par->col_offset))
 		par->col_offset = 0;
 
-	if (device_property_read_u32(dev, "solomon,com-offset", &par->com_offset))
+	if (device_property_read_u32(dev, "solomon,com-offset",
+				     &par->com_offset))
 		par->com_offset = 0;
 
-	if (device_property_read_u32(dev, "solomon,prechargep1", &par->prechargep1))
+	if (device_property_read_u32(dev, "solomon,prechargep1",
+				     &par->prechargep1))
 		par->prechargep1 = 2;
 
-	if (device_property_read_u32(dev, "solomon,prechargep2", &par->prechargep2))
+	if (device_property_read_u32(dev, "solomon,prechargep2",
+				     &par->prechargep2))
 		par->prechargep2 = 2;
 
 	if (!device_property_read_u8_array(dev, "solomon,lookup-table",
@@ -648,9 +720,11 @@ static int ssd1307fb_probe(struct i2c_client *client)
 					   ARRAY_SIZE(par->lookup_table)))
 		par->lookup_table_set = 1;
 
-	par->seg_remap = !device_property_read_bool(dev, "solomon,segment-no-remap");
+	par->seg_remap =
+		!device_property_read_bool(dev, "solomon,segment-no-remap");
 	par->com_seq = device_property_read_bool(dev, "solomon,com-seq");
-	par->com_lrremap = device_property_read_bool(dev, "solomon,com-lrremap");
+	par->com_lrremap =
+		device_property_read_bool(dev, "solomon,com-lrremap");
 	par->com_invdir = device_property_read_bool(dev, "solomon,com-invdir");
 	par->area_color_enable =
 		device_property_read_bool(dev, "solomon,area-color-enable");
@@ -658,6 +732,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
 
 	par->contrast = 127;
 	par->vcomh = par->device_info->default_vcomh;
+	par->page_address_mode = par->device_info->page_mode_only;
 
 	/* Setup display timing */
 	if (device_property_read_u32(dev, "solomon,dclk-div", &par->dclk_div))
@@ -675,8 +750,8 @@ static int ssd1307fb_probe(struct i2c_client *client)
 		goto fb_alloc_error;
 	}
 
-	ssd1307fb_defio = devm_kzalloc(dev, sizeof(*ssd1307fb_defio),
-				       GFP_KERNEL);
+	ssd1307fb_defio =
+		devm_kzalloc(dev, sizeof(*ssd1307fb_defio), GFP_KERNEL);
 	if (!ssd1307fb_defio) {
 		dev_err(dev, "Couldn't allocate deferred io.\n");
 		ret = -ENOMEM;
@@ -725,8 +800,8 @@ static int ssd1307fb_probe(struct i2c_client *client)
 	if (ret)
 		goto regulator_enable_error;
 
-	bl = backlight_device_register("ssd1307fb-bl", dev, par, &ssd1307fb_bl_ops,
-				       NULL);
+	bl = backlight_device_register("ssd1307fb-bl", dev, par,
+				       &ssd1307fb_bl_ops, NULL);
 	if (IS_ERR(bl)) {
 		ret = PTR_ERR(bl);
 		dev_err(dev, "unable to register backlight device: %d\n", ret);
@@ -742,8 +817,11 @@ static int ssd1307fb_probe(struct i2c_client *client)
 
 	bl->props.brightness = par->contrast;
 	bl->props.max_brightness = MAX_CONTRAST;
+	info->bl_dev = bl;
 
-	dev_info(dev, "fb%d: %s framebuffer device registered, using %d bytes of video memory\n", info->node, info->fix.id, vmem_size);
+	dev_info(dev,
+		 "fb%d: %s framebuffer device registered, using %d bytes of video memory\n",
+		 info->node, info->fix.id, vmem_size);
 
 	return 0;
 
@@ -784,11 +862,9 @@ static void ssd1307fb_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ssd1307fb_i2c_id[] = {
-	{ .name = "ssd1305fb" },
-	{ .name = "ssd1306fb" },
-	{ .name = "ssd1307fb" },
-	{ .name = "ssd1309fb" },
-	{ }
+	{ .name = "ssd1305fb" }, { .name = "ssd1306fb" },
+	{ .name = "ssd1307fb" }, { .name = "ssd1309fb" },
+	{ .name = "sh1107fb" },	 {}
 };
 MODULE_DEVICE_TABLE(i2c, ssd1307fb_i2c_id);
 

-- 
2.34.1

