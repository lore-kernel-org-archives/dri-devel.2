Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5480F589DC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E240B10F16C;
	Thu, 23 Apr 2026 14:21:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HjRdqkSI";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1752C10F163
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:21:55 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 25F1B1AC5;
 Thu, 23 Apr 2026 16:20:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776954015;
 bh=vZkFF0xrkUBDHTioB8iHQUCx5w6z2fRHG6Mq9b2C0NU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HjRdqkSIvrxNem79c6Xy6wciTgBtiI6fQ4Cs0ooNUSk+PtCjLLKDqEz0XTW6bBdXu
 2XTCjFaQfwFw9Ipec0vL+uS188dBaeHK8z5cJGgZiGa/I+lQVAbx6D01Xo5ouQaKIt
 b4eCKXKQe9MWJTlIv9ui065zoRleNUTqIlKSQE64=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 23 Apr 2026 17:21:19 +0300
Subject: [PATCH v10 08/11] drm: xlnx: zynqmp: Add support for P030 & P230
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-xilinx-formats-v10-8-c690c2b8ea89@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=vZkFF0xrkUBDHTioB8iHQUCx5w6z2fRHG6Mq9b2C0NU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp6ir2dTnj8Ubx1p+8tEpNVRDEUxWoS1Bp0L9hG
 xoUQSERjrSJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeoq9gAKCRD6PaqMvJYe
 9SOzD/9ZRjt5IL+Y5jGgKklSwwNQK/cFoLm7zOLSqzeEdndU7Z4BGx8PKG/LvGaX7+fBIFRX0J/
 MungOS8YHI1yrgOnyxu8o7+7toj8drI9W4bXt280MTPuASallcgTT7O4vCanrPvZfqlxYwtV10F
 o2L1GKbVoPgCgg0XlvseYaacosUeDdznxFVwKDxPcY1FqNhf+zpLiyGUKztr4ZgGIYV/fy+6BeZ
 3nZJVxNia+COXi7g2oIBpsu7fAnBo8zawR3i3CJZnRm8BIeAUb9THN3nI3P8WjX1kqbHJUmT15Y
 VdZb5OP5lCiCG0a/ZAHodMaZvQeqlU+DEMbsYHXt0bfmQBZB4Agl873KAq0pxUN95chRJLSnzSf
 sgtXAx/RoVD4pQixW/EOrWLQAo66WZ+yCrlgD/n1lpn2m83OrLs+XDaT4gXSLIDxzmCI8/bO+bL
 Zjal5iQoaNAQwzCM317KYR+EFscZSrzbSxP3QvcXmSu/JirioRw3z/orbo04Lut6OpwTSCVmojQ
 Er4GLrc67cXMo90AFsk8QnhVFqpaTMfNgeRGuGAhcoMml2e6e7MnrtvYkZ1ORESHKfOVNJkPCRD
 R0qIrW5XTygKDA880DYAznR3oytf+DK454ZNklmCPXdZWQw+ZcPk2/UXEHhq36zdjLAI3CiXJD0
 QeTVB6IVZS++5Gw==
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

Add support for P030 & P230 formats.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 12a8d643915f..46ea70fd37ec 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -297,6 +297,16 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_420,
 		.swap		= true,
 		.sf		= scaling_factors_888,
+	}, {
+		.drm_fmt	= DRM_FORMAT_P030,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_420_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_P230,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0

