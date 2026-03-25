Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11BA106B53D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E755110E7E6;
	Wed, 25 Mar 2026 14:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="baWiEuMK";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA4010E7E5
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:02:01 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A5D471D4F;
 Wed, 25 Mar 2026 15:00:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774447242;
 bh=k9y+r9AQsyzLRuxOMeW3RIlvydqMMB/I8owjYfiXmrQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=baWiEuMK+KYH9fGw6m8z5ROFC/XcnacMmAOIiNe0CgVlr51VWex2fLYjP/M6y4Z+8
 5qSYKlwakuKxIp3qD2i+s+LAiTvQ390GGjV+es2GuNkngwRo0TEl07Fh/ri+rVuLYX
 Mp1Xd/GGaOc8b5dbWNi5zojj4sg/j9lrlIeAW3F0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 25 Mar 2026 16:01:31 +0200
Subject: [PATCH v9 08/11] drm: xlnx: zynqmp: Add support for P030 & XV20
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-xilinx-formats-v9-8-d03b7e3752e4@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=k9y+r9AQsyzLRuxOMeW3RIlvydqMMB/I8owjYfiXmrQ=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpw+rMMmrZiohBlBVeMEgyN8mTfhmmJmO9o2TxA
 lLPwQQDT06JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacPqzAAKCRD6PaqMvJYe
 9R0zEACBua6RpiCI6I5z96JcFGMi7g64s/IGCSErw1ld3WRuDZtDvWityNPokRrS5kI08eYqGzz
 JoexVVE8le29K4g2Q1F/3lRSUPP8duZruhdMjh3vtk/9AKJF3qm22DJeKR4G4EebwWkvS7pDFOC
 Xe0+ZXYk4fD1ivFZeHH9yus67cMlAo2/w0MaBET0zdUVIF3HM3xYI70lY2/7Efu5DmcTLtuwPi0
 qtfDmRTR6Khobab6eiejCefSeRgLIhgMhCr3W7t3ZwTwamYxa73zwlIe6pn5TLH5i8rID5N5dbW
 tsjOFsbaABGbo4FYW1i3/YSIfUP9F+J6popx6/chl0gRbiovjqgKVO2ptajSTTDm7uhq5wzxLeF
 DcG7Af38wRqGCN0LxKB6Jq8/WLWgAWIgaIobQKgZrIxXCWHdmKBeTqsPudSQdMk/cIvuM+2TsiN
 +qX2MWqc5Ckh9YyDAhdjWtiNRP9gsCiFsqbZ8SDGhOIJsXEvtEG45tYIWQWmdpL3D/c0I7R+y7+
 Xab3inQI8VPVj5YCX0SnA2vT0d6JjUxoCIb5RGsOnMff4VIjxl0tD91zLu8eXJDbE4EoYFnBR5Q
 TX7X4GdMQOWzV/TIwyjM4HXttmSRV7ucdpwkLcoTEBMhhRpR0DB5lYjBlFmsDv7XpgTKDaBZXkF
 99YtDuZiHa2E+uQ==
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

Add support for P030 & XV20 formats.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 12a8d643915f..40deca67b83b 100644
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
+		.drm_fmt	= DRM_FORMAT_XV20,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0

