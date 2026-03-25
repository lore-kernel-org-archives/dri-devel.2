Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D586106B53F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0CB10E7EB;
	Wed, 25 Mar 2026 14:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="L56yRSK5";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 821A010E7E5
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:02:02 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C61701E7A;
 Wed, 25 Mar 2026 15:00:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774447243;
 bh=JS1u+tUvofCvVSFd4SoansSSnQ5kaOnrcifXFx5nnmE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=L56yRSK5LSAW72x7ziwsJlq8V3bxUl+Q9EliERJLXX8C4VaBVnOwMMUIZLNNXm9LF
 iGpMUEYAaIgGh8mtlk9Onjsx134ShIaOY7htF72pZ/b8TTovmjPy0Zt3GZPdHRf/x0
 wtel72Amst5+f1AJXYMwwFSzToWyZ3z8WybIZhjk=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 25 Mar 2026 16:01:32 +0200
Subject: [PATCH v9 09/11] drm: xlnx: zynqmp: Add support for Y8 and XYYY2101010
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-xilinx-formats-v9-9-d03b7e3752e4@ideasonboard.com>
References: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
In-Reply-To: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Pekka Paalanen <ppaalanen@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2157;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=JS1u+tUvofCvVSFd4SoansSSnQ5kaOnrcifXFx5nnmE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpw+rNHh2hc2H4ErbtLvFQWv0j3SL4Hapl9SQ5K
 DqfYMbQ68KJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacPqzQAKCRD6PaqMvJYe
 9eaKD/wIu50aUSGtxqrodliSnBZosxTRfcNTCDHkaNUgWesS19AFIEfhyQRPtbPpKC7m4lkLphi
 us74wLHIHyhBae5SklY4vx20QAIiFhxwsEsC2EGZos0xRzlGkgEodgrT2KPOfYSJS3SqMvn6IJK
 HJtphlQKrc3OFRtZfCa3QJ2lly7dLCnjd21zAjkMB0dI9uK60KdtldlUk6ifZ+JeS/Lra98Wr1f
 5bMG0Kw37GNOWhNX5XUkNaexkthOfl+qCLdCiCuToe3aOpNXQ0nX33B6KkF4mUH6yd16HxNMywt
 HAdIVC6Mq+ANm5RtW3hyKnRUvyQMZZqe+shBmAVOB/58b5yKZ84AumsrnBmLuGuLI7jS7OYxOxy
 wQSg5TC3aVzmA7sLKuo0z+fh6/yNWFg8/TgrGXOY78A75nmZgH5Ajedil63b75oGHalzUWkRzb7
 Ghbtnoc3fS5kOd8DZhg0QzSjOY7e0+1Jf7TXD76QgFuDDUnbm5aL8+oRQ5i3NEWzGIuiYGQX565
 KgqkHo4Bvbo1bKb8JyK3IP5ZbcPpf/y03s22KNm9g41r3nZzLfX5b3GRWDH2IxMVWvotkwV1GCc
 HGqApk3L8AI2vhxVTjfW2eT11RGfgAnS9DNUw/7EOAqMjFSkWRxGIRCYQpcRloH7A+KTCBYkkBE
 qjLZjrkicr9kqUA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

Add support for Y8 and XYYY2101010 formats. We also need to add new csc
matrices for these y-only formats.

Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 40deca67b83b..99bc68481020 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -307,6 +307,16 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_Y8,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_MONO,
+		.swap		= false,
+		.sf		= scaling_factors_888,
+	}, {
+		.drm_fmt	= DRM_FORMAT_XYYY2101010,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YONLY_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 
@@ -697,6 +707,17 @@ static const u32 csc_sdtv_to_rgb_offsets[] = {
 	0x0, 0x1800, 0x1800
 };
 
+/* In Y-only mode the single Y channel is on the third column  */
+static const u16 csc_sdtv_to_rgb_yonly_matrix[] = {
+	0x0, 0x0, 0x1000,
+	0x0, 0x0, 0x1000,
+	0x0, 0x0, 0x1000,
+};
+
+static const u32 csc_sdtv_to_rgb_yonly_offsets[] = {
+	0x0, 0x0, 0x0
+};
+
 /**
  * zynqmp_disp_blend_set_output_format - Set the output format of the blender
  * @disp: Display controller
@@ -846,7 +867,11 @@ static void zynqmp_disp_blend_layer_enable(struct zynqmp_disp *disp,
 				ZYNQMP_DISP_V_BLEND_LAYER_CONTROL(layer->id),
 				val);
 
-	if (layer->drm_fmt->is_yuv) {
+	if (layer->drm_fmt->format == DRM_FORMAT_Y8 ||
+	    layer->drm_fmt->format == DRM_FORMAT_XYYY2101010) {
+		coeffs = csc_sdtv_to_rgb_yonly_matrix;
+		offsets = csc_sdtv_to_rgb_yonly_offsets;
+	} else if (layer->drm_fmt->is_yuv) {
 		coeffs = csc_sdtv_to_rgb_matrix;
 		offsets = csc_sdtv_to_rgb_offsets;
 	} else {

-- 
2.43.0

