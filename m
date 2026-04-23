Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADD8F589DD
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8281310F169;
	Thu, 23 Apr 2026 14:21:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PDN59u2A";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5AA10E2B5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:21:48 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F0BEBCA;
 Thu, 23 Apr 2026 16:20:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776954008;
 bh=cV1j8rF0mvRQM5cd4x3+IVXBssf9hzDrAeMBKL5wjDM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PDN59u2AEW+BBAOu+vwmZtYoWZD80ZRq1dX3rTwMY2sgb5xTsaB+yhuFFZw/yQ0HX
 Z296CDrpb8cDw/XpTGdjKK0z83pw6apA/8udwgLeEArfNw5oH3qWVfb/KKAFOp5YPp
 B1HdPFzBoF2WVyOe8TkpUM5JDkfwSxmSZP614YRw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 23 Apr 2026 17:21:13 +0300
Subject: [PATCH v10 02/11] drm/fourcc: Add DRM_FORMAT_P230
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-xilinx-formats-v10-2-c690c2b8ea89@ideasonboard.com>
References: <20260423-xilinx-formats-v10-0-c690c2b8ea89@ideasonboard.com>
In-Reply-To: <20260423-xilinx-formats-v10-0-c690c2b8ea89@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=cV1j8rF0mvRQM5cd4x3+IVXBssf9hzDrAeMBKL5wjDM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp6ir0lM0cshP9RzBUakPjti3S18cVDdNF141Rs
 j58TrZ2KZ6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeoq9AAKCRD6PaqMvJYe
 9X1LD/wJMs1H79AH9wAah+J6AswD0WsGbIPg7Qja6GpiBWc514p3PnxNiwBwSbi/XpXKUvv1qFi
 hBRh15PPTmLEjy0YlQ56BYFaOs+3TlcWuG6DgBxKgiqWNVApzQOBc0+0xoHtvmP8n32nt4qMtbM
 gjItkz0J60mjsE/wFsK9LFcmtwiHgNnrjIW0h0pUtGSBysXuYl+keT0qHPT4NGcs+LzKkXiFTpj
 k2fjPWYf+Xd34yBcZeZxIYB3Oln8/mJHROaUuCMUynyDWBCfqToJOyKVuQMImo5KiFfOUarVJQE
 Ew3I1pD/QeSjj3yy3HRKgkl2U3pw66YYStWRM7kk6xrM8Prjb84tWqslUBIRsY347nKtjeBYlb+
 MVwFtvaftpYKpJ4VHAIiz7ZDIPZIN1kI87X5IX0Fi4u6J2s1hpQQyacDv8l7DYlW+MVlZeJ1pab
 2wUeVLEhdjllL3puBv7xuxmAta6WX8YR2o0SvoTWoD572FugQkalgMNv9Md0S51OS8f71OvQN2Z
 1XeVfr357sVuSsBi3Hi2KN0jnwx31Xgty73kqqiewJWPpIQntnC1kimNUK1gRN3mfBcJdGMDBYM
 mEao+p/99os7ecjnyhXVqJ85AEJRztY3xUm3V1s9qoylwZGsa/4wXppetCfb95jyu86EHRlOxPt
 idVgfpIPUDAJIrw==
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

Add a new pixel format, DRM_FORMAT_P230 ("P230")

P230 is 2 plane 10 bit per component YCbCr 2x1 subsampled format. P230
is similar to the already existing P030 format, which is 2x2 subsampled.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 3 +++
 include/uapi/drm/drm_fourcc.h | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index e662aea9d105..5b6d8f4686c4 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -354,6 +354,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_P030,            .depth = 0,  .num_planes = 2,
 		  .char_per_block = { 4, 8, 0 }, .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 },
 		  .hsub = 2, .vsub = 2, .is_yuv = true},
+		{ .format = DRM_FORMAT_P230,		.depth = 0,  .num_planes = 2,
+		  .char_per_block = { 4, 8, 0 }, .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 },
+		  .hsub = 2, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_S010,            .depth = 0,  .num_planes = 3,
 		  .char_per_block = { 2, 2, 2 }, .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 },
 		  .hsub = 2, .vsub = 2, .is_yuv = true},
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index c89aede3cb12..0f2f79542121 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -379,6 +379,14 @@ extern "C" {
  */
 #define DRM_FORMAT_P030		fourcc_code('P', '0', '3', '0') /* 2x2 subsampled Cr:Cb plane 10 bits per channel packed */
 
+/*
+ * 2 plane YCbCr422.
+ * 3 10 bit components and 2 padding bits packed into 4 bytes.
+ * index 0 = Y plane, [31:0] x:Y2:Y1:Y0 2:10:10:10 little endian
+ * index 1 = Cr:Cb plane, [63:0] x:Cr2:Cb2:Cr1:x:Cb1:Cr0:Cb0 [2:10:10:10:2:10:10:10] little endian
+ */
+#define DRM_FORMAT_P230		fourcc_code('P', '2', '3', '0') /* 2x1 subsampled Cr:Cb plane 10 bits per channel packed */
+
 /* 3 plane non-subsampled (444) YCbCr
  * 16 bits per component, but only 10 bits are used and 6 bits are padded
  * index 0: Y plane, [15:0] Y:x [10:6] little endian

-- 
2.43.0

