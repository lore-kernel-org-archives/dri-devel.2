Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB72C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 122E610EE8E;
	Tue,  1 Sep 2026 18:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="CHeLv6D1";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACDF10EE85
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288694;
 bh=gMZvH/XQuHle0y4qmxFGuepyJ+gg6MxKAWPpFnQKQUk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=CHeLv6D1SpaIHwZ1VwZo90Z4Voe1VkTLSbU/6grn1SzcAuimWnmB++CGKsI2PRyNU
 nM3MUkO+tJf+2sZWXaVUIs/tPNuAVxN3Q1+nQ89+aD/Rb7r/hDtMb7C97yiV1nvfD1
 cMnWZT5VQUCWaxVNdpecybIeGFh4GNVcwFiuvIfFRIPGdmvzVvDkI7dE3mW6oItc9X
 /lgVE6jTFFmb3ZOflHVIVDaHxTzoCNkJfQx18QbGA8nnEYGVOI/hxN/HZjLEFqFotV
 mFjc2/dBjjLKqOroSXryCUWxsFnAg7CKKKcNuToSqgWDOBpc5Iq95edvAE212+1UoL
 etYOWrrCkwVzg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0833817E3CA6;
 Tue, 01 Sep 2026 20:51:34 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:36 +0300
Subject: [PATCH v11 72/74] video/hdmi: Define SPD InfoFrame field lengths
 and use strtomem_pad()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-72-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org
X-Mailer: b4 0.15.2
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

HDMI specification defines the SPD InfoFrame Vendor Name and Product
Description as fixed-size fields, 8 and 16 bytes respectively, padded
with zeros and left without any trailing NUL when a name spans the whole
field.

Give those lengths a name and mark the fields as non-strings, so that
the copies can be handed over to strtomem_pad(), which implements
precisely the required semantics.  This also bounds the reads from the
source strings, whereas the open-coded strlen() could run past the end
of the buffer in the hdmi_spd_infoframe_unpack() path, where the names
come straight from the wire and are not NUL-terminated.

While at it, replace the related magic numbers in the pack and unpack
helpers with the new defines.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/video/hdmi.c | 23 +++++++++++++----------
 include/linux/hdmi.h |  7 +++++--
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 45b42f14a750..e729c26d61c4 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -217,23 +217,22 @@ EXPORT_SYMBOL(hdmi_avi_infoframe_pack);
  * @vendor: vendor string
  * @product: product string
  *
+ * Both strings are copied into the fixed-size infoframe fields,
+ * truncated if too long and padded with zeros otherwise.
+ *
  * Returns 0 on success or a negative error code on failure.
  */
 int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
 			    const char *vendor, const char *product)
 {
-	size_t len;
-
 	memset(frame, 0, sizeof(*frame));
 
 	frame->type = HDMI_INFOFRAME_TYPE_SPD;
 	frame->version = 1;
 	frame->length = HDMI_SPD_INFOFRAME_SIZE;
 
-	len = strlen(vendor);
-	memcpy(frame->vendor, vendor, min(len, sizeof(frame->vendor)));
-	len = strlen(product);
-	memcpy(frame->product, product, min(len, sizeof(frame->product)));
+	strtomem_pad(frame->vendor, vendor, 0);
+	strtomem_pad(frame->product, product, 0);
 
 	return 0;
 }
@@ -305,9 +304,11 @@ ssize_t hdmi_spd_infoframe_pack_only(const struct hdmi_spd_infoframe *frame,
 	ptr += HDMI_INFOFRAME_HEADER_SIZE;
 
 	memcpy(ptr, frame->vendor, sizeof(frame->vendor));
-	memcpy(ptr + 8, frame->product, sizeof(frame->product));
+	memcpy(ptr + HDMI_SPD_INFOFRAME_VENDOR_LEN, frame->product,
+	       sizeof(frame->product));
 
-	ptr[24] = frame->sdi;
+	ptr[HDMI_SPD_INFOFRAME_VENDOR_LEN + HDMI_SPD_INFOFRAME_PRODUCT_LEN] =
+		frame->sdi;
 
 	hdmi_infoframe_set_checksum(buffer, length);
 
@@ -1643,11 +1644,13 @@ static int hdmi_spd_infoframe_unpack(struct hdmi_spd_infoframe *frame,
 
 	ptr += HDMI_INFOFRAME_HEADER_SIZE;
 
-	ret = hdmi_spd_infoframe_init(frame, ptr, ptr + 8);
+	ret = hdmi_spd_infoframe_init(frame, ptr,
+				      ptr + HDMI_SPD_INFOFRAME_VENDOR_LEN);
 	if (ret)
 		return ret;
 
-	frame->sdi = ptr[24];
+	frame->sdi = ptr[HDMI_SPD_INFOFRAME_VENDOR_LEN +
+			 HDMI_SPD_INFOFRAME_PRODUCT_LEN];
 
 	return 0;
 }
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index b80a5ee63bb2..d73ad7b3fa94 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -267,12 +267,15 @@ enum hdmi_spd_sdi {
 	HDMI_SPD_SDI_PMP,
 };
 
+#define HDMI_SPD_INFOFRAME_VENDOR_LEN   8
+#define HDMI_SPD_INFOFRAME_PRODUCT_LEN 16
+
 struct hdmi_spd_infoframe {
 	enum hdmi_infoframe_type type;
 	unsigned char version;
 	unsigned char length;
-	char vendor[8];
-	char product[16];
+	unsigned char vendor[HDMI_SPD_INFOFRAME_VENDOR_LEN] __nonstring;
+	unsigned char product[HDMI_SPD_INFOFRAME_PRODUCT_LEN] __nonstring;
 	enum hdmi_spd_sdi sdi;
 };
 

-- 
2.55.0

