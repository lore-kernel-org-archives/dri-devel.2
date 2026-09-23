Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA40AC98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D7810F17E;
	Wed, 23 Sep 2026 20:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kGT7ck7z";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E443110F17E
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:11:01 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso11874135e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790194260; x=1790799060; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i2OOLJKEASfUrtwVJ4InIXktjShhe/Ob36b0n3ix6zY=;
 b=kGT7ck7z+nhM/VcpdnHKOIr9Ir61K6U97cvVRPEbprG4Z0wyTWSj5Y+rt/TGA8E5Lv
 LBdkd+9XbbV6nctOjXaZn5B1Syt26j4aOD+HYG/Bak3lRjpIbfAUeV1TxdFg9tI8L8mx
 gKDXtfSAuyldNNWavyfI1DYHC1PICeHHrvi2UwidOOT2tBhi1/K5n4hJBMlESsbN0MeX
 nBmgIodtCDvM+oA2zfjON4EjG+cv8OLa1haG35HBvzcRFAnu1KdV3rAID/LtLQYXwTUX
 IR1kxcDkBf2t1h3g8DybPJXdleuMUdjp75YcgTbBXRufq3tYw0Y4HY3kx67FUoT8d3iZ
 op6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194260; x=1790799060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i2OOLJKEASfUrtwVJ4InIXktjShhe/Ob36b0n3ix6zY=;
 b=Bd55Oyxqi5J1eNNK9WBR8umkaf2SgVXnAm8kc5dawz882c/4d6PSQwrWQUKpdhzIMf
 w+s0DE1WuKtOpeyVfwUQKfvIR0crua0agC0E0m5Ys9bri9YuxkQExBWv7PeOK90BAIUr
 RwCu/k0MIhDbbSBIU2tdyDxNNFwwFA7qYMq+Z5Hd2dvhudSgVK+0e+sL8IHq5XS+LGGG
 ME3Mt0k39PGTaT7kmm2CHgcGqFRJn/6wd00pIyfkn+6ThGEKBNpDKIDqH5km2YTw0Oz6
 nvgHh7y8lHmlFzcEpmqkLkJoOiGNe6Rxm0mxZS28d78CVa9PMc59Y7duz3/960VpXUrm
 wjvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0IqZMFHk2lEAexJZPCnktozQjkHocVl4kGtyZwX3A54VX1g/Tel4cXs1fDeKeBNlEA9k4pNDk1f0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kzqlUcpamO/XHuSS9u3tOLrx+dWewbX6GiY2QsCSiSEVnTKZZJ
 ALLuTTW3JiB9dRTquBvlbPTSUxgWxM2+doMqBr9/ARKDCMUZnkCqODxt
X-Gm-Gg: AYBFou2yc0v4T9rbIF2UswcQ64/FK/btj4qBqLP9EAEVKSkntxGoTyoI5g86dxCYqLO
 vQmaw3/oNL3m0Wj2/iHVL8QFQGLHX9qaJGg563DFUJAT/UCtH84vvBP12NwNuljU6IFsQPpe/sv
 koD2iyyc2XG1tsMi+xc9SEWLBMT8m1xQekihi8MYP9PAVSzPdthKrbjHWdTsqU421bYdeI5uLfx
 UE+hVUBwMQuUPPKmsrwi25/BCleyVD3u7wQnvi546DMMijxgiuJZCJV7mscWh3DqDF7YNJ+HYam
 c3l9cx+4PfWtMCjugUo8Q0IA5czxx8MIiaWw6HSaA35D81TQv/J0FiYVm6RDvvMu7l5MlO9LCAu
 vTtb8a967OcvTnpsWMi3g/AxGg0GytDBIP3I4aioYn9LPfBOHzVZYRTfOMtc9BY+j8tuVE9IYQn
 ZJ3V6LI3QFdKAkujvNumS7IKgC0/d8TzUuVPWWRKWwOUOHzCgZNChnxaNF+ACxwDSH5/P5L/aXD
 /wwf44J0RNm5HbsEHh0syN6CMs9Wd+vPGY=
X-Received: by 2002:a05:600c:310e:b0:49e:8377:c880 with SMTP id
 5b1f17b1804b1-49fe6716468mr4217415e9.33.1790194260255; 
 Wed, 23 Sep 2026 13:11:00 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4c8dsm13559295e9.3.2026.09.23.13.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:10:59 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v3 6/7] video: logo: allow the boot logo to come from a
 reserved memory region
Date: Wed, 23 Sep 2026 22:10:34 +0200
Message-Id: <20260923201035.51007-7-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260923201035.51007-1-maximpedraza@gmail.com>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
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

Take the image from the region a "memory-region" phandle points at, when
the node has one, instead of from the width, height, clut and data
properties.

Only a declared region is accepted, never a bare physical address. That
matters for more than tidiness: the region is reserved before the allocator
starts, so the logo code can never be pointed at memory the kernel is using
for something else, and a size is known, so every field can be bounds
checked. The region is mapped with memremap(), which copes with a no-map
reservation and fails cleanly instead of handing back a bogus pointer the
way phys_to_virt() on an arbitrary address would.

The image is validated and copied out rather than used in place: the magic
number has to match, the geometry has to be sane, the palette and pixels
have to fit inside the reserved region, and every pixel has to reference an
existing palette entry. Anything else is reported and ignored, falling back
to the built-in logo. Copying also means nothing that happens to the region
afterwards can affect what has already been validated, and it keeps the
pixel data in the same shape both paths produce.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 drivers/video/logo/logo.c | 176 ++++++++++++++++++++++++++++++--------
 1 file changed, 138 insertions(+), 38 deletions(-)

diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index b600fc3aab..6f0adcd34e 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -10,8 +10,10 @@
  *  Copyright (C) 2003 Geert Uytterhoeven <geert@linux-m68k.org>
  */
 
+#include <linux/io.h>
 #include <linux/linux_logo.h>
 #include <linux/of.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
@@ -38,9 +40,19 @@ MODULE_PARM_DESC(nologo, "Disables startup logo");
 /*
  * Sanity limit on the image size, a device tree is not a good place for more:
  * a 4K screen is 8.3M pixels, and the copy is kept for the life of the kernel.
- * One byte per pixel, so this is a byte count as well.
+ * One byte per pixel, so this is a byte count as well. Keep in step with
+ * MAX_PIXELS in ppmtodtlogo.
  */
 #define LOGO_DT_MAX_PIXELS	SZ_16M
+/* "LOGO", little endian, at the start of a handed over memory region */
+#define LOGO_DT_MAGIC		0x4f474f4c
+
+struct logo_dt_header {
+	__le32 magic;
+	__le32 width;
+	__le32 height;
+	__le32 clutsize;
+};
 
 static struct linux_logo logo_dt_clut224 = {
 	.type		= LINUX_LOGO_CLUT224,
@@ -49,59 +61,42 @@ static struct linux_logo logo_dt_clut224 = {
 static unsigned char *logo_dt_clut;
 static unsigned char *logo_dt_data;
 
-static int logo_dt_parse(struct device_node *np)
+/* Reject geometries that cannot describe a sane image before using them */
+static int logo_dt_check_geometry(u32 width, u32 height, u32 clutsize)
 {
-	unsigned int clutsize, npixels, i;
-	unsigned char *clut, *data;
-	u32 width, height;
-	int len, ret;
-
-	ret = of_property_read_u32(np, "width", &width);
-	if (ret)
-		return ret;
-
-	ret = of_property_read_u32(np, "height", &height);
-	if (ret)
-		return ret;
-
 	if (!width || !height || (u64)width * height > LOGO_DT_MAX_PIXELS)
 		return -EINVAL;
 
-	npixels = width * height;
-
-	len = of_property_count_u8_elems(np, "clut");
-	if (len < 3 || len % 3)
+	if (!clutsize || clutsize > LOGO_DT_MAX_CLUT)
 		return -EINVAL;
 
-	clutsize = len / 3;
-	if (clutsize > LOGO_DT_MAX_CLUT)
-		return -EINVAL;
+	return 0;
+}
 
-	ret = of_property_count_u8_elems(np, "data");
-	if (ret < 0)
-		return ret;
-	if ((unsigned int)ret != npixels)
-		return -EINVAL;
+/*
+ * Take a private copy of an image that has already been range checked, so
+ * that nothing else can change it under us, and shift the pixels into the
+ * palette slots the frame buffer layer leaves to the logo.
+ */
+static int logo_dt_store(u32 width, u32 height, u32 clutsize,
+			 const u8 *clut_src, const u8 *data_src)
+{
+	unsigned int npixels = width * height;
+	unsigned char *clut, *data;
+	unsigned int i;
+	int ret;
 
-	clut = kmalloc(len, GFP_KERNEL);
+	/* The palette is at most 672 bytes, the pixels can be megabytes */
+	clut = kmemdup(clut_src, clutsize * 3, GFP_KERNEL);
 	if (!clut)
 		return -ENOMEM;
 
-	/* The palette is at most 672 bytes, the pixels can be megabytes */
-	data = kvmalloc(npixels, GFP_KERNEL);
+	data = kvmemdup(data_src, npixels, GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
 		goto err_free_clut;
 	}
 
-	ret = of_property_read_u8_array(np, "clut", clut, len);
-	if (ret)
-		goto err_free_data;
-
-	ret = of_property_read_u8_array(np, "data", data, npixels);
-	if (ret)
-		goto err_free_data;
-
 	for (i = 0; i < npixels; i++) {
 		if (data[i] >= clutsize) {
 			ret = -ERANGE;
@@ -128,6 +123,111 @@ static int logo_dt_parse(struct device_node *np)
 	return ret;
 }
 
+static int logo_dt_parse_properties(struct device_node *np)
+{
+	const u8 *clut, *data;
+	u32 width, height;
+	int len, ret;
+
+	ret = of_property_read_u32(np, "width", &width);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(np, "height", &height);
+	if (ret)
+		return ret;
+
+	len = of_property_count_u8_elems(np, "clut");
+	if (len < 3 || len % 3)
+		return -EINVAL;
+
+	ret = logo_dt_check_geometry(width, height, len / 3);
+	if (ret)
+		return ret;
+
+	if (of_property_count_u8_elems(np, "data") != width * height)
+		return -EINVAL;
+
+	clut = of_get_property(np, "clut", NULL);
+	data = of_get_property(np, "data", NULL);
+	if (!clut || !data)
+		return -EINVAL;
+
+	return logo_dt_store(width, height, len / 3, clut, data);
+}
+
+/*
+ * Image handed over by the bootloader in a reserved memory region. Only a
+ * region the device tree declared is accepted, never a bare address, so the
+ * kernel can never be pointed at memory it is using for something else, and
+ * so that a size is known and every access can be bounds checked.
+ */
+static int logo_dt_parse_memory_region(struct device_node *np)
+{
+	u32 width, height, clutsize;
+	const struct logo_dt_header *hdr;
+	struct device_node *mem_np;
+	struct reserved_mem *rmem;
+	size_t clutlen, datalen;
+	const u8 *payload;
+	void *mem;
+	int ret;
+
+	mem_np = of_parse_phandle(np, "memory-region", 0);
+	if (!mem_np)
+		return -ENOENT;
+
+	rmem = of_reserved_mem_lookup(mem_np);
+	of_node_put(mem_np);
+	if (!rmem)
+		return -EINVAL;
+
+	if (rmem->size < sizeof(*hdr))
+		return -EINVAL;
+
+	mem = memremap(rmem->base, rmem->size, MEMREMAP_WB);
+	if (!mem)
+		return -ENOMEM;
+
+	hdr = mem;
+	if (le32_to_cpu(hdr->magic) != LOGO_DT_MAGIC) {
+		ret = -EINVAL;
+		goto out_unmap;
+	}
+
+	width = le32_to_cpu(hdr->width);
+	height = le32_to_cpu(hdr->height);
+	clutsize = le32_to_cpu(hdr->clutsize);
+
+	ret = logo_dt_check_geometry(width, height, clutsize);
+	if (ret)
+		goto out_unmap;
+
+	clutlen = (size_t)clutsize * 3;
+	datalen = (size_t)width * height;
+
+	/* Everything the header promises has to fit inside the region */
+	if (sizeof(*hdr) + clutlen + datalen > rmem->size) {
+		ret = -EINVAL;
+		goto out_unmap;
+	}
+
+	payload = (const u8 *)(hdr + 1);
+	ret = logo_dt_store(width, height, clutsize, payload, payload + clutlen);
+
+out_unmap:
+	memunmap(mem);
+	return ret;
+}
+
+static int logo_dt_parse(struct device_node *np)
+{
+	if (of_property_present(np, "memory-region"))
+		return logo_dt_parse_memory_region(np);
+
+	return logo_dt_parse_properties(np);
+}
+
 static const struct linux_logo *logo_dt_find(void)
 {
 	static bool probed;
-- 
2.39.5

