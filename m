Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9BD606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=dx+287pB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077DA10E05B;
	Sat,  7 Nov 2026 16:22:30 +0000 (UTC)
Received: from sonic311-24.consmr.mail.gq1.yahoo.com
 (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87E1E10E05B
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1794068542; bh=oROIpyW/wuPrKD3YfrN56npu9YJ+fEEUp5oFz9jJmCI=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=dx+287pBUIiY8QrAu+DHO65EE0aYIb0SufmS/0usjDPVMHeUh+LnUnIk5mF+SGn34vGE7ZJjPYFpZ3xpu9c6B8w5uKDQ5jBjkES8OdWr+d2qPBorLGw+yNhTGG2QETHfbMls7Ne76C46ErKlNSxvSaNklwCVfw3XXzp3sNjl02HAl5JBLOA90hxlwgRQTAO6ZnlpkPsbIAK8pXewlOdYcXzZTkYo+N0jTZyCUjTxwAZMquHAyK9/GZIBpwKj3DbWU4qJI3aBqFcRd9MqjTihR9vbJ7o5GpodNhi3Zl9hc4gLxMGsvR8z2pi8au8csVaL6YI+9tCQE0ZsNgE/THBo/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794068542; bh=DTakXC9HQrj+cDqU5Gf5d+U/VzEDlPewUhDLHVGL9h/=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=HMlC5sK+m3xDn0CkCPOujSoSU37PURMFD7dZGT8efqe17KTs//XfyMw6zwoI4DMqEF3gyG+F4VH2Rn2FVogVANT3hf4noSC5lTk4XaQ2kbJD2kkihUrq1KTRlQXuFU3XB4AUzH4Vn2/4kDqnkYkwxyNYX9xcClBA2uH+6vLW/rYjqCsQkj8JuaixaVjfYwl7e4t8nEomHQD8e0/yRQZPs6jMSAzuWZODbgL6fcwCwKMpzqVOiNnx/LHll0WqrMwbaPQBuux6GFJktoAByT1eySRRAZ77FH4FPlgVbYLCU/EhlReRlBzoRW/6OjAGMTYSyFG1Hdmf6l1N7gCFjpo45Q==
X-YMail-OSG: meWDOFYVM1mcADasHih23up9BSDhkpf.0ph9MJFLu3qXyWQ7AZMnlcMjHJwEj_O
 tvxnSRZm74vW3m7dzVc8JylXU.M4wNoRUg_wo6e5RUl_hEnWfhDLpHhQJNE9uUvLcDww5zjU3vsD
 awHFdcWGe1p3U9u6rOO.2hZGuPXxDAAYhBlfpYz2ZN3SC.aTPzvztn1.QhxVHfBjCdqYDwS.j8cA
 3X4GQnFVn2Zu40V.tTTDeYcUvI0Am3W7.aJLOSOxcs8hrE67G_vmqT.iaYK9PYB.BjQYEksV1Qh2
 .GKu4f8TFdq5KCCU4wVYenFEo8J7gUPZiHyEC9lNqNcVKiRu3pLEhhckQAYvFazGNwgVOSg1OZee
 RQDtjb5o7bieyAP.VEFq3KQ6GlNUKrwc5p57hWDRhoDeXkoXYNynmsIrp9jQgT6Ap.4Kj7k9XNPb
 l4ryIIXts8fGk_KLopLic5Q5PqPIDnvuuVKUDvFft370XUXr2vZT0Dvy6EN8q1EICtIXOmYqaswl
 sIQYJ0INxnqF.r565eTqUPwN9If49knHa53mdBFN5.PeRj2RrtwAhkfQd95npuZDt15iTfLvKbAr
 HXyypByatwFKzv8DULjNyYFPuwYDDT2qQMFaUSGMnp_alVBILEP3Zrcg6.PJhmWJTOLCYhVkQL5j
 .dEiJqUFt_E0InIGh03qB6UkNUWK9uoN63GX71JqmNU.GWZSjGTcOoUX5X6N5Rorfa0hfoNoAEiH
 wi_vx.htIem_2dWk6uYGQ4_1MOEy_IBytr7oNnvBmDrqBSt2yAyE2_MFoA1fj2EvduaxYcLSQPxI
 st3qjkgzWMB4mE2OoLCUizuq6X1yUQAnxbldKhREX_kuiIPC21hbwgAme2vjwlQYEX4lLi1cRU_C
 rqofWkrIXeUWSz4x6vViLMRm_q2m.UNlkEDeA_rzLT3G7ejGdPOGT0xvbN_JdxPqjf3mfLE7Bflq
 wCxOTvGOiRKF5pVIzkUVPrgQ6a418rTjiE08RjK_N59NObvM1nhPacZNWCo50fvMw79BRWed2lpc
 wP7_iz5npoHiSRdDjenLH5bCYj17RYM2cUJNNrkCBrExxLn87lWkYPP6HECWXV95OvGh3uyKDqrQ
 5uA2HsR22QgKzN9t6t5PhGoWl0A3f_Jl1B6ppL19A1RfxX.1kQia7ZQzGAX2Z3kRt1J6tVzYcF8U
 sMC2Vhs2nHyOjUYZy.qKpLZPjNr_mAhdZlDjDE8MMKYC2BScWmk2yM4Qw9K.Lt3XZXPIDy4FZJoc
 yXhI5uA1frH_GzYgVgAEQI4l4LVbiOH0n73ulfKXKrZClkfEnXHFP56yS0HciW79i3qTBsPOoXYB
 RD0Ue03Nnixvx0J_7_GRd2F6XERbAfkLQc26fp9ezTz.0oraxG7Vg85G4v13QexwtNcLjpomDr0G
 TpYOXwQdj3xfwAL__U0pGhIwnFvzV2Ho5mMZWJEIuBwlt3sn8ZpnD_JwSKBlnHGo8ZrEk0omWp9F
 JrME1f3WiUCTxlEZexoUX.4nNbTHW0U73AOiRg_v_4fOkRhdbOcLwIaFwhIDdWydpC_NohTFD_B8
 6nyn1cq_M6RALMrJRbqglcaIyTf6eA_RAS1oRrqN4UgsjDFsMXuO3RuyAJjZeGd2j9g1Xp49WeOm
 haq2DVPIqeqhEWsj7ZrsCAp9Ulw0rbwuC.lMGqOc4VdBDlAB47s_VH5kQxWSvpwMyjFhN9jx51tp
 A9GQ7cTYMiGSeMB2WccliqmHBMiX1A_MGd0CHNdsv7lMUIorHgPT_HoTuH4yNshdBYJ2GFqzkj2k
 hsfrH5ZkpgrB0zreBPjsvnT8yW.CkgaNdu9OVD3yPv0JwcG5mUEFfaqy9QbliKqfNAIQJDSeU4xw
 5nEBONpoXVt48VxXxwlQxqYW0RChkyARA7nx2VNgklfiztUVNKKng1f3LPpRX3XpZogwFNPcFV90
 dpnz32ZLmgickjeF2RhvkzHjgtiTutwNenuaksTJHgQUC.WFah9VGE1EwyQxPuOz6hDwtyWQ31N7
 KfNarZgvHkml8y5Xe99dZZF0BEqX602T3iCmOVxOravE8RxRKwYp1Oe86dRC9GGjNZO.wDLEZX5p
 7DijlsdXodS4lYLI17u4lwGghXJk.bGdAr.LIxrLWuIAoFG3QcA5lyxa4J4WRNXfpcVunQkGQ0tN
 rRlnubvjUPp0yKhHCxMn6x6dDU7Gj8rxiTtXCK1Hy2RQrplHk.oPlTM5y8..XdpserxhDpD9wFFN
 Dzc_KE9VxNEV8yFMQ1VdsXlfI4PEWBH8ye5gRlKiTcl_qIn38joZgQqc6oG4HSw--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 3c0b4d3a-4b79-4873-ae8f-f54142884bd5
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sat, 7 Nov 2026 16:22:22 +0000
Received: by hermes--production-ir2-5dd9bf4598-cdfcp (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 994c5c73ac4f7d9f986d84c8d5b6b884; 
 Sat, 07 Nov 2026 16:22:17 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Ruben Wauters <rubenru09@aol.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4] drm/gud: move format init from gud_probe()
Date: Sat,  7 Nov 2026 16:21:10 +0000
Message-ID: <20261107162207.26336-1-rubenru09@aol.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261107162207.26336-1-rubenru09.ref@aol.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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

V3 -> V4
- Take XRGB8888 emulated format into account when calculating
  max_buffer_size
---
 drivers/gpu/drm/gud/gud_drv.c | 185 ++++++++++++++++++++--------------
 1 file changed, 111 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 680447f426f3..1ffb2a4fc901 100644
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
+		/* Substitute emulated XRGB8888 for proper format */
+		if (formats[i] == DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulation_format)
+			info = gdrm->xrgb8888_emulation_format;
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
2.56.0

