Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579EBF589DF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E065B10F16D;
	Thu, 23 Apr 2026 14:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="G/sJjcn0";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21CB910E2B5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:21:51 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id DCBE112D6;
 Thu, 23 Apr 2026 16:20:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776954010;
 bh=eg74wjOEypEbnxxiyEFdSKXRuGixs62xUArGpDpOiJA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=G/sJjcn0733qO5ZQAFkByLrlgZ9t3mnEqWSZlem2sMMOyPGDy4YrlNH7CviQD17mw
 KhcMnTk/VHpqpB8EfkBtPmp2qVOoOCREa/+5qkiyXG35rqzB+97wDOQCVe9dU3oQUo
 VOqC+yEBYjqEMc+ieLVVRsX/vNzWKeY/IX04PodE=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 23 Apr 2026 17:21:15 +0300
Subject: [PATCH v10 04/11] drm/fourcc: Add DRM_FORMAT_XYYY2101010
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-xilinx-formats-v10-4-c690c2b8ea89@ideasonboard.com>
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
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=eg74wjOEypEbnxxiyEFdSKXRuGixs62xUArGpDpOiJA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp6ir1IPaI87+IOPSJMOTPxR4XsrexwwPRrpwaV
 +6/myhPGAOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeoq9QAKCRD6PaqMvJYe
 9doHEACe3U2/6h5BGr3J5TPHqgM1+xXVDm5PgoSI+5ONH4ux3GSREFSA6F1LCxQh4z0IfEcFJHV
 gVAYs5QhkJzKuqvzdr4F/9bWY4tqdpj4LhWU34A0d8szATiV98ie8Thjuka7RLDAn5p9v1WDQV0
 4XYJoDeLxMz9a03031IFOJqqmMJXBMGodBBUklEuB8Vv2eXGf81Vw+FD9fIbh+YtH2zvL+hKN3x
 H3JOah44U2QajBDO25BF4OBa00v+rLCazGZe4ibzzpiLVuW1yvqJacnBvZTWLJFsSMQIreWZySp
 2N/vUBi5L/ef8e3rDW6VaIkR8fQCfbMExjToaDon9p2WunRxx4CVCgt0TpomV5kY8y/Ij7uO+0X
 hlHhk2mgQaKHAIPjl5W0/eL5oiwris6nFaRc9QdbNywGWNHW7pAfUyMaXuWndfHjGULYF4oXsrN
 IxvB7vyUFRrqjPd/EElvlvyilaHWj6OtWe3hFOh3ZjBjCyH0x60wazpKadYSQjjXRVBDGF+Ukvq
 IcSUWwmfYN+4Uxc7M8hmiickX6Gs0Xw+0ATH0B1e88ftsiPlpqabBQ38EjaF4W5TJh199R3lLm5
 VeaHu/Nj93PK64qYxY04cXbUxIvff4kA0pOTQzIpFHtVunozbTnqTpuSBSp5NhT+pWTEcABpfPj
 0rlM3Pczx5gMQjg==
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

Add XYYY2101010 ("YPA4"), a 10 bit greyscale format, with 3 pixels
packed into 32-bit container, and two bits of padding.

The fourcc for the format is 'YPA4', which comes from Y - Y only, P -
packed, A - 10 (as in 0xA), 4 - 4 bytes.

Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 3 +++
 include/uapi/drm/drm_fourcc.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index c30266b8d051..01761c553e7e 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -385,6 +385,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_S416,            .depth = 0,  .num_planes = 3,
 		  .char_per_block = { 2, 2, 2 }, .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 },
 		  .hsub = 1, .vsub = 1, .is_yuv = true},
+		{ .format = DRM_FORMAT_XYYY2101010,	.depth = 0,  .num_planes = 1,
+		  .char_per_block = { 4, 0, 0 }, .block_w = { 3, 0, 0 }, .block_h = { 1, 0, 0 },
+		  .hsub = 1, .vsub = 1, .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index c5b64ed3b00a..472f95632640 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -468,6 +468,7 @@ extern "C" {
  */
 
 #define DRM_FORMAT_Y8		fourcc_code('G', 'R', 'E', 'Y')  /* 8-bit Y-only */
+#define DRM_FORMAT_XYYY2101010	fourcc_code('Y', 'P', 'A', '4')  /* [31:0] x:Y2:Y1:Y0 2:10:10:10 little endian */
 
 /*
  * Format Modifiers:

-- 
2.43.0

