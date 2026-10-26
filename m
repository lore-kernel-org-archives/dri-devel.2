Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98D606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=qlxaOLsZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF9E10E03C;
	Mon, 26 Oct 2026 21:01:32 +0000 (UTC)
Received: from sonic305-21.consmr.mail.gq1.yahoo.com
 (sonic305-21.consmr.mail.gq1.yahoo.com [98.137.64.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33FEC10F15A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 21:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1793048485; bh=cVMZaBWOwFNQ9LUQkZKIqJUPl7GbxoQa66f024vGQhw=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=qlxaOLsZIXaAG7my8LZ/uGd1xO9c2acYnPhCiiebda8/Wo7WvoLR2DdPQJ6Rx9fTw2TDHopkfVF6eXeUZKH3SVPsRpmD80uc2mXYH35qTV1+dsdUhiSaD+H4Rom8s5gBYZC1EPiHGdElV0UoALu3pozg0p4A/TR0Ag1fXZyR8FfLN2h32w1jPVtNOWNJWZwAT829/YmLyeD1+wSg00jIx3fTWJOlTHkMlT8IVeCWjlMlEmc4dFEDaq87m5XoZSeoNaQ7oL3Or9cqA28cOsDeKZNrRCvOQpj9jN10BdzhAx1fOqkG4CUsGhVii+A5XeRME8eEMiZuN9F1MklMWV4rWQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1793048485; bh=KvCcwVah0FgyAiXJpf9lnODlk0qkV+995RRS2ir0W4T=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=XABoSMn6cmDRL8XRMaw/L5KKERNSS107TUEASsrWTgSTKLm1b56jejcXKH02Iv7KSL6rHIeYSIVIRGjuYRIqiWsSrgYLArWhEOHwqYDHmh3jiPajckyWHJ28PHFl61slQxWMLUUZQEk6FZmpCNyuZn/Ala2Ht+vzNtmSlTLTJDo3wA+LRZmJqznaE092phsKNudRPCRluqWuKXU129MQU1sKjTu7oU7P+L2etgLRA0BQcNQNZ7o15Wvl7w70R9rJ1VWCn5fq8im/PKQIfhRPUcrGanTvtsd+C7DZnSs1D3UMA+GdrfahjMCohL8G+ESwMldk7wb73z4y4WzBxRZJ9Q==
X-YMail-OSG: biVpO8AVM1l1v7NeXm5Ubqn10MtwLMQ5Jwyl5sbA0oTFORfsGbozlH4_3Rm_F8.
 r9FBFXIJTogLUqjp720nDCqfpelW9.ivDzIbfixPIvOQyqIHojp.v1Cdr3e3woo.NTl2aTeRqjnG
 _frguYALbacMgaAfIvjy.WJpjgvUxre01uf6FsvKwbULZXRIJsasQMBxMpM7LOyQ3FcU5a5CtstK
 mcI8BVl38X8IJe9D0I.xXPBAqhEe28c74W6t6VywCTXemwsAuO_N9yPfjHMFEcm1pGkOuf7IBx3c
 alo19livBXKITA4nJaj7Zoh6gGV54N.j8jpXp4mlovo.x6y22YTg1Gi7YMXikFbXC8aotn4s80NZ
 wWbFy2GHjiA59iWXGx97okDoukZt7EyZijk59L71A6GBMblw3zbRrCuVvhMiQl9hFAHrkg_5zCJh
 wppzbQm9MhTzzYTUYOxGdVEWJL.yw4EtEp2D8PSyMS2GG4YEifYDRFMuYpkyC_EKzZplcnJVOduI
 KMMASCU9x1QBHOBY3ai9euOmf0lRjgziQMGkF5UORNjvu.5EqhtykEWjPHz1ypl0MjDJ6Hahxk8p
 FrwkZrCD5xDLXCy.61.uyfbZnnBebUO2cRsWlxnyhMucvB1p60K8gZl4x4cimYM1nXYUP6TeUWIS
 LNNGOt0YiARs0TuPlhXXiTI03wi0qkSdl3B8c5bkmnl5DtBUpAsr6H0l2ywZbOuNjeUfteulMN6W
 BgKInHbZnh699JwGw1mtRWEYN7KRs5e6ggN_P1plm3iL7ww4pkU5RVou7r3CBxnhKr3Sskq3GWOD
 BTy22qrYXyx5BtKW5USQgMNrXBsl7v8gw3_ZuLSUpu04QNJl.9GI5QHxwVZb1fdruvDp2GEx4toR
 0q4JC20V3y4W4zB7OBQa.Cr7BbGR5f.5jhKTnyayGLkYSPPm5YgD8OzNlmg5BGHtSv_6BU2br.Qi
 3pWVVGKvemHqn3u9iyDVhlxqn9K4kVdqRpBz7FzZWW7i9O9WBT6Dcj1pcayAkWjPkll16iUZKPyK
 StCrNfps1E3BeHadSzUuTIO.9B15dIn5pajvAwx_IFE6IxJlFo2lH8SXPxTcufhJuPJgQLL11AqL
 qnV4aB_Fw7UTLntRC2qwX7QLb5RLebcLhtNF5CeWI2JSDXMkQ0PWzAbIKILm7pX4TUXjSK90ZYrj
 eFvCtIFTV514ZRH_6H9E.Xr2nzlRYjAFuFYy0653rEIiQHspWbB.nUkBpp7TOmwUsReMWHhXhNC6
 sN6lBXbmlJdJVy_WQrDchh_dh645HhBQRKbfgPiPTB6rHdPupWIHhuU0bPPurpNNxPwBy0Vyh.BF
 _FsnFrcmHoZT9uuQopCZmhqmNwzCi_G3idySS56LVYKof4r_6aSFGys7tXYi9qHdaZ4O2c6JdpNL
 Lt0UdtuTzbbhNEkaB9ZhtUu0C6siBJziJKmzaOsXIjLcZhzTsWX4uxxIgh_EfkDcy.R6Ez6.nKxK
 K3bptf4bZSvAOgH8eVx4T4pn4YdROXxlG5TNP_iaXLTi55iqGKSoioXQwgYnCQow.RuVZ6nYmLRe
 8LJzDqxgrrk8R6ubWAo8ApfLqiX6VJmEppVmox6agcrHx5dt6I6DZO5c6SHWOsKZdhHW7ELjn1vf
 pSFk9UBcdqv6QRhQtVxVCrtOiG6yl7uIgu4YXbPOXgSrQrOljEhDkOUJ.K8e21zNSNnlfBz.pcii
 2WBsxG2KaSsJhJgkrfp85kZCWSSOJsq8sqXdoCXailz55pY0rR3CIT4UJczw9oZ7tpzVrqJdsv_s
 p6XYw8R_QQQUi6XKRDy8sjkzUWDmezhL_HlkzaVy4n6f_6WRXmn7i2GN3AZa5Uk3L5nXP9VsUVvK
 pCKYCn1wJQZgwbZzugUKh6W4Ww2pHv2nguK5yZc4GeC7fErjgwDQnj5GvytZTuWGtd7vhtH_2.n_
 blIAdpq4RjdzSjJ83e9SBQgVn0JA1ea77uZm7jC8txFX2Iur7AHWuvzbfCKVsef1s..fP5D.Nu4Y
 RfyEZBvVAqPxVUge94RbnJOIspJomwJO3kdPQXBO6JZjExha05kLX8zYfqaISZDG7qg1AVkBGYYK
 QDrI1WoVhePSt9HGH9MOcVehx6G3H7D4hs.33888i8TeS07rsc_hSV.P585469.h5Fhz99jht.6i
 1FifcP2gRNIgsq4p9piKc5OTXSick6sKIQIaO5Uwj28orjtdjHwN5j36qLlIXNu0t0xla0HTz23r
 nraodCivWKU04CPyI378GX63KdGuuBkF76IksIKGRr3Pd763qsnZq7zpUgRGIO.VAwA--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: b9a8866e-c042-4f5d-aef5-db96f306f024
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Mon, 26 Oct 2026 21:01:25 +0000
Received: by hermes--production-ir2-5dd9bf4598-98szj (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 5d00b31c00c703fa66515078aceb212e; 
 Mon, 26 Oct 2026 21:01:21 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Ruben Wauters <rubenru09@aol.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/gud: move format init from gud_probe()
Date: Mon, 26 Oct 2026 21:00:43 +0000
Message-ID: <20261026210116.10082-1-rubenru09@aol.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261026210116.10082-1-rubenru09.ref@aol.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As part of the cleanup of gud_probe(), this patch splits off format init
code from gud_probe into it's own function. This makes the code more
compartmentalised and easier to follow, and makes gud_probe() smaller
and also easier to read.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
V1 -> V2:
- Removed output parameters for gud_get_formats()
- Added gud_get_max_buffer_size() helper function

Apologies this v2 took so long

V2 -> V3:
- Fix potential num_formats underflow
- Skip XRGB8888 in size calculations if emulated
- Remove redundant r1 and XRGB1111 size calculations
---
---
 drivers/gpu/drm/gud/gud_drv.c | 185 ++++++++++++++++++++--------------
 1 file changed, 111 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 680447f426f3..36adf2e2b6a2 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -435,11 +435,115 @@ static void gud_free_buffers_and_mutex(void *data)
 	mutex_destroy(&gdrm->ctrl_lock);
 }
 
-static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
+static size_t gud_get_max_buffer_size(struct gud_device *gdrm, u32 *formats, u32 num_formats)
+{
+	struct drm_device *drm = &gdrm->drm;
+	size_t max_buffer_size = 0;
+	size_t fmt_buf_size;
+	int i;
+
+	for (i = 0; i < num_formats; i++) {
+		const struct drm_format_info *info = drm_format_info(formats[i]);
+
+		/* Skip over emulated XRGB8888 */
+		if (formats[i] == DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulation_format)
+			continue;
+
+		fmt_buf_size = drm_format_info_min_pitch(info, 0, drm->mode_config.max_width) *
+							 drm->mode_config.max_height;
+		max_buffer_size = max(max_buffer_size, fmt_buf_size);
+	}
+
+	return max_buffer_size;
+}
+
+static int gud_get_formats(struct gud_device *gdrm, u32 *formats)
 {
 	const struct drm_format_info *xrgb8888_emulation_format = NULL;
 	bool rgb565_supported = false, xrgb8888_supported = false;
 	unsigned int num_formats_dev, num_formats = 0;
+	u8 *formats_dev;
+	struct drm_device *drm = &gdrm->drm;
+	struct device *usb_device = gdrm->drm.dev;
+	int ret, i;
+
+	formats_dev = devm_kmalloc(usb_device, GUD_FORMATS_MAX_NUM, GFP_KERNEL);
+	if (!formats_dev)
+		return -ENOMEM;
+
+	ret = gud_usb_get(gdrm, GUD_REQ_GET_FORMATS, 0, formats_dev, GUD_FORMATS_MAX_NUM);
+	if (ret < 0)
+		return ret;
+
+	num_formats_dev = ret;
+	for (i = 0; i < num_formats_dev; i++) {
+		const struct drm_format_info *info;
+		u32 format;
+
+		format = gud_to_fourcc(formats_dev[i]);
+		if (!format) {
+			drm_dbg(drm, "Unsupported format: 0x%02x\n", formats_dev[i]);
+			continue;
+		}
+
+		if (format == GUD_DRM_FORMAT_R1)
+			info = &gud_drm_format_r1;
+		else if (format == GUD_DRM_FORMAT_XRGB1111)
+			info = &gud_drm_format_xrgb1111;
+		else
+			info = drm_format_info(format);
+
+		switch (format) {
+		case GUD_DRM_FORMAT_R1:
+			fallthrough;
+		case DRM_FORMAT_R8:
+			fallthrough;
+		case GUD_DRM_FORMAT_XRGB1111:
+			fallthrough;
+		case DRM_FORMAT_RGB332:
+			fallthrough;
+		case DRM_FORMAT_RGB888:
+			if (!xrgb8888_emulation_format)
+				xrgb8888_emulation_format = info;
+			break;
+		case DRM_FORMAT_RGB565:
+			rgb565_supported = true;
+			if (!xrgb8888_emulation_format)
+				xrgb8888_emulation_format = info;
+			break;
+		case DRM_FORMAT_XRGB8888:
+			xrgb8888_supported = true;
+			break;
+		}
+
+		if (format == GUD_DRM_FORMAT_R1 || format == GUD_DRM_FORMAT_XRGB1111)
+			continue; /* Internal not for userspace */
+
+		formats[num_formats++] = format;
+	}
+
+	if (!num_formats && !xrgb8888_emulation_format) {
+		dev_err(usb_device, "No supported pixel formats found\n");
+		return -EINVAL;
+	}
+
+	/* Prefer speed over color depth */
+	if (rgb565_supported)
+		drm->mode_config.preferred_depth = 16;
+
+	if (!xrgb8888_supported && xrgb8888_emulation_format) {
+		gdrm->xrgb8888_emulation_format = xrgb8888_emulation_format;
+		formats[num_formats++] = DRM_FORMAT_XRGB8888;
+	}
+
+	devm_kfree(usb_device, formats_dev);
+
+	return num_formats;
+}
+
+static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
+{
+	int num_formats = 0;
 	struct usb_endpoint_descriptor *bulk_out;
 	struct gud_display_descriptor_req desc;
 	struct device *dev = &intf->dev;
@@ -447,9 +551,8 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct gud_device *gdrm;
 	struct drm_device *drm;
 	struct device *dma_dev;
-	u8 *formats_dev;
 	u32 *formats;
-	int ret, i;
+	int ret;
 
 	ret = usb_find_bulk_out_endpoint(intf->cur_altsetting, &bulk_out);
 	if (ret)
@@ -510,81 +613,16 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	drm->mode_config.helper_private = &gud_mode_config_helpers;
 
 	/* Format init */
-	formats_dev = devm_kmalloc(dev, GUD_FORMATS_MAX_NUM, GFP_KERNEL);
 	/* Add room for emulated XRGB8888 */
 	formats = devm_kmalloc_array(dev, GUD_FORMATS_MAX_NUM + 1, sizeof(*formats), GFP_KERNEL);
-	if (!formats_dev || !formats)
+	if (!formats)
 		return -ENOMEM;
 
-	ret = gud_usb_get(gdrm, GUD_REQ_GET_FORMATS, 0, formats_dev, GUD_FORMATS_MAX_NUM);
-	if (ret < 0)
-		return ret;
-
-	num_formats_dev = ret;
-	for (i = 0; i < num_formats_dev; i++) {
-		const struct drm_format_info *info;
-		size_t fmt_buf_size;
-		u32 format;
-
-		format = gud_to_fourcc(formats_dev[i]);
-		if (!format) {
-			drm_dbg(drm, "Unsupported format: 0x%02x\n", formats_dev[i]);
-			continue;
-		}
-
-		if (format == GUD_DRM_FORMAT_R1)
-			info = &gud_drm_format_r1;
-		else if (format == GUD_DRM_FORMAT_XRGB1111)
-			info = &gud_drm_format_xrgb1111;
-		else
-			info = drm_format_info(format);
-
-		switch (format) {
-		case GUD_DRM_FORMAT_R1:
-			fallthrough;
-		case DRM_FORMAT_R8:
-			fallthrough;
-		case GUD_DRM_FORMAT_XRGB1111:
-			fallthrough;
-		case DRM_FORMAT_RGB332:
-			fallthrough;
-		case DRM_FORMAT_RGB888:
-			if (!xrgb8888_emulation_format)
-				xrgb8888_emulation_format = info;
-			break;
-		case DRM_FORMAT_RGB565:
-			rgb565_supported = true;
-			if (!xrgb8888_emulation_format)
-				xrgb8888_emulation_format = info;
-			break;
-		case DRM_FORMAT_XRGB8888:
-			xrgb8888_supported = true;
-			break;
-		}
-
-		fmt_buf_size = drm_format_info_min_pitch(info, 0, drm->mode_config.max_width) *
-			       drm->mode_config.max_height;
-		max_buffer_size = max(max_buffer_size, fmt_buf_size);
-
-		if (format == GUD_DRM_FORMAT_R1 || format == GUD_DRM_FORMAT_XRGB1111)
-			continue; /* Internal not for userspace */
-
-		formats[num_formats++] = format;
-	}
+	num_formats = gud_get_formats(gdrm, formats);
+	if (num_formats <= 0)
+		return num_formats;
 
-	if (!num_formats && !xrgb8888_emulation_format) {
-		dev_err(dev, "No supported pixel formats found\n");
-		return -EINVAL;
-	}
-
-	/* Prefer speed over color depth */
-	if (rgb565_supported)
-		drm->mode_config.preferred_depth = 16;
-
-	if (!xrgb8888_supported && xrgb8888_emulation_format) {
-		gdrm->xrgb8888_emulation_format = xrgb8888_emulation_format;
-		formats[num_formats++] = DRM_FORMAT_XRGB8888;
-	}
+	max_buffer_size = gud_get_max_buffer_size(gdrm, formats, num_formats);
 
 	if (desc.max_buffer_size)
 		max_buffer_size = le32_to_cpu(desc.max_buffer_size);
@@ -650,7 +688,6 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		return ret;
 
 	devm_kfree(dev, formats);
-	devm_kfree(dev, formats_dev);
 
 	drm_client_setup(drm, NULL);
 
-- 
2.55.0

