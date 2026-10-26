Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3D606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=phloIjiJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1662410E031;
	Mon, 26 Oct 2026 20:08:24 +0000 (UTC)
Received: from sonic304-25.consmr.mail.gq1.yahoo.com
 (sonic304-25.consmr.mail.gq1.yahoo.com [98.137.68.206])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3B910E031
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 20:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1793045297; bh=DzuHMHSN8rF1Dc/85a+H9qYiM/liHbYetp/uH9IaVE0=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=phloIjiJjP6R9c1c6MaWINVR7WXTZhrTkHluDtN4SKfyGcNpCwxnNBQ8Qtt2S4P0Zl9Bk5N8wqlliqGEaHcgzw2bIPiRbfXIfWz2isTqP0jB4fGs9ZbkV2HwRVK8u4CuUzcQfs3nLA3PUPJQivfVHStd9Tvz+nGhwm/Hq/xZQjtH9dUSxgThxNTaM1jW3S5V7ZwIexiGTwpTH6NWtPQ36S6HRBu4Fv/N+n8/Bx3nYKSc0BMbImlQVb3tXkKK0g3NaK6AWIO/ur6yRRg4Gid7MhXBiNGvu+4zvVw5p9859VVB9mcNA2TgiY+x92c7J0VHJq+J3jY3PqaTdla549La3A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1793045297; bh=mi4fAdGqHfG8lvHQosPduhkUDy6oDzv0Vw5Mv3XVWck=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=AEzIdFFuxvLOK4rYzrzaGAWOsDht/s0Qr1co6l2HItvpYeJ3jCkj/jiQlGGRS+v9jcL+mUTaqqHKseuxV+bdgKqZUaSHzjKGOH9hvIOoykONeh6V2uGxzF/73D/kPzVdk0T4VlsD3Nnb0rbUygsSH+9zxE5h9UTnNyYijQ0anGuw5kRxPmjA2JLJBYDwavkB5GQ7KQIjm6t/dshqHCXc4n81PmMqbeVqwcN9H+FEqAJlJlnU4TO6ejkgagzVf9ZyYtv3K8EkfFFuTZWJMyWD3/ravJHVoKTY1Bw0tfCtEFBawa95OhpXAhYHDFyp7py3m3WPtnRngzhB6I1Y2KVJmA==
X-YMail-OSG: eNwUg7cVM1lE_2o54IncozN7KzTiljc9NkdTE4Z9I3ThFZLE3H2M3YpH4r6yRxb
 tLziYasS6dIbxdUfaPyQVVKA8EbxjWiqf.Xy7F_B5J0lP5Bb6ImfDnDpy4sGj9wq1vlheB7cKFHl
 6T2q9KNHwhCkkvu2isvT.HZ7PqXD2Zj1bBx0ncRN3ZKjvQpgE3BQ5r5BKi_23K9EAokWA59AMuhN
 exzDS3ICifDbN_gttfxADeUZ7VfGoL0j3QaUye.3wNJJslWwq.lNoxnQd0NbUYfukk3HgZcOAXkp
 eWZqCqSX14FhonrpAa7ADpn5NP3bj39vp7C6Ldv7uDggsn4umS2UbRDoSa0UxImMQETIRJZo4Gsk
 4Z7GSUwkEtxE.o5TR5lvFv6naVcwyUitbYMmWsbYGOr_ZrvlC6KzPYbm8h7DfOV9FxxMS1Xpp1U5
 KqqEn3z4GdcxAFjArZ5Tgu4r8pm619_qrSBnbHNUvBczNEsXcRup8Yq7o8DItrq9vjP7_jEmtj0w
 MHjTNvAWTVa31Amku2rl_1u7q5MOMGYvO0UxWqd_vVobvJo9ELG56nHl7TV4hkc03FwovVEp18GF
 76gVDKX5ZKhbRpOVYA_DzMjjwtb5pmeYXMylWePOpAJePW0hhemn6sN_Fi_GW3k0La6aZwxHWHsD
 NQz2tDzuvXp_VHsZd96cNaAWdWnkMUjgAWz5ffDPxtVcL7z1P5U_4RDi4R97Yvdtye_XDgu_3LaT
 y.KWbD2pJ_SSqx1A2Hp5OKt78CUV3yHR6h0F2K71t2RKtcza8QBzys6cD6Fc4sZxSU7cJhEv4DyK
 3HEjKxcYTWTz.472pVACaQiiSHrjmZSBn0m0gBBDXyq51FScN0_m6JHMIUQeyEFnnswz1tRL3IAk
 ASVmysLzu1t7pZPPIMH3ftfIEfWVSgkKon4jgSHOUrwsxBkG2RRb9qWSv5XQbSWCWNyzwe79YqSs
 LcucnJld5ieM_VgHNe3Um6n7e70cI8Cb.niH8stHXN_ePwNAvPNTvGgvvbuAs8tPNcYonsjnac_p
 xQEyEUvd5pDWeMKMQg1MI9Lx1.XJWPQP17_v7afhtQafpMbC.QKm3FeP4xj.STm2PP56cfTbaacm
 9J.mkK7U7uRTwYAcJM.lsL3a1OmkK9J5IWjVCTG2w2VxexAVvUl_uHCGGPmlFUNNPgW_TYg_hTAt
 mk1.EykHNHS6kvKRFGe6cxhoHibNGjPyHwMNc5KhIO001Cte6sm1u724F1u2rCxuPDCkOd_hryfz
 bPLF.Kr2.OOvZtnxGPMnywNc.r7sJIRy_j7uDUUJmWc_FJ93slrvtzI4r.U5MYtnNEMUCtIuSqCK
 Mr2vJs7AtgwmGCbtgpq_E1E4x4LpjrYLsifUOCaWeocW1CSXUWz779.RLjCgya2AToHm.bVlCmLA
 4fIzDhYoYk3TbPc7n6oN1GQGGhe7eqayG4HsDZgrLd0SPWCZqbPAeyCT0b.nICBarMtvymZIW7XW
 qhY29kaV95RacTn25w8nJDJxepCk5d4ALLCeW5UmAjhaxiVe_etuOkjfgumrIn6.lnndvIzQIlOt
 1J8_IBN.V9bd3FhMQtBXOAvqgcglmKnTTp5ibGxa6pbMwT_.LTaAotZtf.mePk2wFBKDmjOcxvMk
 kYkrGx7KzoBO.LQUzZTE2NYg6JT4pFq5952VtjfOwPX8KCEbom.emv7QIzfGzjtqGrdNldrW7c76
 CgPBrPN_.WUq3gQ_1GAOVf4cdbZchi.t705e1vhKYoEHWBq7d21LEQSkhfvX1tkCtHIJ_C0DHO5g
 TFyJMgLdgVDJNuuQPzHo4.yvfwAWRiUblIagh.blrc4T4L88N4XZTtHlS0Nq0A0Wm.JiqfDBa5NA
 5.rorKVdBbxnAoGhPa5pp9xKC3ivLzT91WgsRfqBrtjqFbpp_RnAJbqYtjZTr5Mz9VvwexuzWbNL
 tVqvD8Gz2o4lGVx0bqRqU6nCyuRhAQM2vuqpiZowropu1BcH_ESUnNjsbtblHUe2REV8sDWCqXbW
 Y7Hqcdcv49OeQB0B1L42aZ5wpc0MJ7zGLZ0JB9adVTTn77cbkRJvNpkwF1EILB4HUmtuaKG3sMoS
 I_dXmWhbNO4HZkVrqRnjpIMyhldtUVLOkPfUrT_ZZqZiabNOBD3IKv0EipWwu2t6urU1E1n3lYod
 M_.ZlmKywwO5Bjd7lH45b.niwcuKv37xaNhkZn2JCkIaztLoP9HEqqM1E8sZCJTDJUhx2ZgnytEi
 gBT95Z4B51E2U6Z2vc.7MLdNNSvKqlnSN3BL9bvCga_6H3WSVEl_NwcjAzFlO_8g-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: add68a79-3421-49d8-8787-b106543ad7c2
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Mon, 26 Oct 2026 20:08:17 +0000
Received: by hermes--production-ir2-5dd9bf4598-ck52d (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 4d1f96b714f24078f82ccedc47ac1dd8; 
 Mon, 26 Oct 2026 20:08:11 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Ruben Wauters <rubenru09@aol.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/gud: move format init from gud_probe()
Date: Mon, 26 Oct 2026 20:06:51 +0000
Message-ID: <20261026200739.18523-2-rubenru09@aol.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261026200739.18523-2-rubenru09.ref@aol.com>
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
---
 drivers/gpu/drm/gud/gud_drv.c | 193 +++++++++++++++++++++-------------
 1 file changed, 119 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 680447f426f3..278cc9bf68d0 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -435,11 +435,123 @@ static void gud_free_buffers_and_mutex(void *data)
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
+		fmt_buf_size = drm_format_info_min_pitch(info, 0, drm->mode_config.max_width) *
+							 drm->mode_config.max_height;
+		max_buffer_size = max(max_buffer_size, fmt_buf_size);
+	}
+
+	/* GUD_DRM_FORMAT_R1 and GUD_DRM_FORMAT_XRGB1111 are not in the formats array. */
+	/* Ensure there is enough space for them. */
+	fmt_buf_size = drm_format_info_min_pitch(&gud_drm_format_r1, 0,
+						 drm->mode_config.max_width) *
+						 drm->mode_config.max_height;
+	max_buffer_size = max(max_buffer_size, fmt_buf_size);
+
+	fmt_buf_size = drm_format_info_min_pitch(&gud_drm_format_xrgb1111, 0,
+						 drm->mode_config.max_width) *
+						 drm->mode_config.max_height;
+	max_buffer_size = max(max_buffer_size, fmt_buf_size);
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
+	unsigned int num_formats = 0;
 	struct usb_endpoint_descriptor *bulk_out;
 	struct gud_display_descriptor_req desc;
 	struct device *dev = &intf->dev;
@@ -447,9 +559,8 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct gud_device *gdrm;
 	struct drm_device *drm;
 	struct device *dma_dev;
-	u8 *formats_dev;
 	u32 *formats;
-	int ret, i;
+	int ret;
 
 	ret = usb_find_bulk_out_endpoint(intf->cur_altsetting, &bulk_out);
 	if (ret)
@@ -510,81 +621,16 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
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
@@ -650,7 +696,6 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		return ret;
 
 	devm_kfree(dev, formats);
-	devm_kfree(dev, formats_dev);
 
 	drm_client_setup(drm, NULL);
 
-- 
2.55.0

