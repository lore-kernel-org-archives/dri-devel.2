Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71155C55174
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2B710E2A1;
	Sat,  1 Aug 2026 07:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aoKec9Xg";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA7510F431
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:50:53 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so958458f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785534652; x=1786139452; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mmFMZ3fYEoGkcqSYuP3/MajdLDfVjK6tOo68kSisc3k=;
 b=aoKec9Xg1jjNBXZJkFDUUOa92vraNAnRyuAm2tpE5FO8SXK7nz8c9GQ9JgFzyhw2v9
 4a8iQXW12sPWCgr/YbOAW7028+GoBCqIzHqAhvdrvPb6/5eXxHM/b9rp2yJ13UMWBhS7
 Y5QHXRgoLuK3n3Obmy5JI2NjtGhM24pr/uvpdBtl2hanpGsceoZaZ4NS7gqXJA+vN+IY
 FbNySdviKH+Os35MzIGkWHo9Cs8GyvVPFTkw85LPQ2ShjC4u35ekleBjQ8q8DWmJlpgv
 riCglGaoZEax6CRFmC5p+/bswI89S60dtn5ccxIGZWwORcHN1NQ7Py7YRO3S0Kx/wYPT
 1orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785534652; x=1786139452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mmFMZ3fYEoGkcqSYuP3/MajdLDfVjK6tOo68kSisc3k=;
 b=pVdA5CSWUOkxHPiVPA15kmMOUYz9b1I+BczJ2IL4g7bhGsPyUREMOjGYsMaxswQQEO
 6Cq6WtA68VeEtyEC9n+BpikvW98qNN9U0D9i/M2Km/Jr2FQQnP2JApqt8oJ+jbl1Qhqy
 hR+Kmga8sUG79nFYEyX1Vp6iKP0HeL74bsmO17s4GMyfxixk1m/DZhZu3d3XN38F+6Ej
 xm7xD2GVyK04N9a50SydBsxo2PqHRhmXsMFPp7bUugp/N9pCT6WTadhWevfjoOy3867Q
 fF7OXU5k6AG8Vh7uaKFjys343SfuWVkky+3m/nCjr4yfh6u+bCQkvYzCcrh+PrHaRn50
 Af8g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0GFidMsuSjDwP+tB8U36C22GHlSYEecVyuVGGEyeHYOaDR7Zzgb/uR/dWzGXvvgceIH60BTM2VTU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBzbbRowlx6tL01hANCsRjYrEMrZ5IKKxvUVy8pGSBi2X/K1fF
 C2ShL+rf+WrcpU+qiP9O2CpIWO9nVC4XMwKK9TDx1UeikK8Hw63U3XZk
X-Gm-Gg: AR+sD11pPPT/g5SCapq8QlUF2iYdlwqh/IlwsOANk6IVRdEqTWoCakc/hZ/LwGWzxtE
 s0ayvRpfvsnvgipmIbJoxO0YRd7OvJTsFG/OFh0ssmYdGgdKI8fPKXWYCMrB+lL0gUvXNyC3ioc
 UPcTw4u5kOxnqTV9c/c8YohHjQP2h+zqeChu0Jzc/hRHEm3jQ5tn0Se36FfhySEoCWgjz7RTBYQ
 FE1/qiCj+DjpiAXqFQ87IClDb9q4AQVs0dWHFISg/umf9kcyGEVmyd8BrYFnFi92PdJ9LxEXNHH
 uchiOgi319N8is77bCaj1A12u5/F2CJu/PCZPECkOcwsQR/Ntv7WRiuTBudTm+Grx0l24Rc+9y4
 oL6EAzcwzSsTrPNMz28QxhiPQNpu5fS0//hv7P3h77stiRSOtpo1QhWKN/S8xpWhCUhdQlox/EM
 HV4orACTuM3zlHB9MFInl79inkQwoeYnN9K50Jy3fZSUF1mHFU2hRU/x+t7P62306J5TGsHt6bW
 kcQx7AgKMgG2Q==
X-Received: by 2002:a5d:68cb:0:b0:47f:d01b:a691 with SMTP id
 ffacd0b85a97d-47fd72c6d17mr2157623f8f.14.1785534651962; 
 Fri, 31 Jul 2026 14:50:51 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.62.64])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2484sm10186342f8f.11.2026.07.31.14.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 14:50:51 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Max Pedraza <maximpedraza@gmail.com>
Subject: [RFC PATCH 5/6] video: logo: allow the boot logo to come from a
 reserved memory region
Date: Fri, 31 Jul 2026 23:50:42 +0200
Message-Id: <20260731215043.30392-6-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260731215043.30392-1-maximpedraza@gmail.com>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/video/logo/logo.c | 171 ++++++++++++++++++++++++++++++--------
 1 file changed, 135 insertions(+), 36 deletions(-)

diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index b4f533df0..95d75b905 100644
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
@@ -38,6 +40,15 @@ MODULE_PARM_DESC(nologo, "Disables startup logo");
 #define LOGO_DT_CLUT_OFFSET	32
 /* Sanity limit on the image size, a device tree is not a good place for more */
 #define LOGO_DT_MAX_PIXELS	SZ_32M
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
@@ -46,58 +57,41 @@ static struct linux_logo logo_dt_clut224 = {
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
+	clut = kmemdup(clut_src, clutsize * 3, GFP_KERNEL);
 	if (!clut)
 		return -ENOMEM;
 
-	data = kmalloc(npixels, GFP_KERNEL);
+	data = kmemdup(data_src, npixels, GFP_KERNEL);
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
@@ -124,6 +118,111 @@ static int logo_dt_parse(struct device_node *np)
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

