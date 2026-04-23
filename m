Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB3EF589DD
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E02710F174;
	Thu, 23 Apr 2026 14:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IksUgbdE";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3394D10F172
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:21:57 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3DF941BA6;
 Thu, 23 Apr 2026 16:20:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776954017;
 bh=c8+yKzAkZdIaCuKUbPEM4QYUtfg3S0c3pjFSh7gMtqE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IksUgbdE1WfMxZWNJliZbsAxoFa255hyDyBGk310iHshWR21fdiCqOiBb1yn41eSt
 VD2Q87dFkatYlfRmJ4uTEZQUYBTIT2VZM/4iaABJC++qRIDaKToRgiGV37SlP2PXtH
 emWJh7jGsM4HgLUq3UEWkyYfII7dVTZDstsFI0co=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 23 Apr 2026 17:21:21 +0300
Subject: [PATCH v10 10/11] drm: xlnx: zynqmp: Add support for T430
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-xilinx-formats-v10-10-c690c2b8ea89@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=883;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=c8+yKzAkZdIaCuKUbPEM4QYUtfg3S0c3pjFSh7gMtqE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp6ir3VcmPeuTSKUxBDmiHUsJ7UXUHk4IAJmP5L
 4gb4A8vPLGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeoq9wAKCRD6PaqMvJYe
 9fnXEACs/EmFIP0yptFdPtRd/aNYx0efTXFt8tFwW1Ejyu7yruayVzKbAKDB8KbuyRMig+FzoFR
 V+bwDvhkPmTlxfquv+6J+fE37zj+zVt2Mf2xSGgaGv4UETbbqY6ddQmupKj6G3C+AGjL8BVOCr7
 usaeMOPUMDkFQcV1i5OeHYo3uDXbZX2YPm1QWk+0xRiCMJr8LCuC9nirqkZmxJCt++JP6mkuw/s
 WqvI0G6z0llhudc1ushAjsUGW+QtRXvHZDHQUiFK3lVYJVP2jPHhQVt+bdgoq5uX352n5mE69a1
 x8at76U5kd0I3TgEZ5YWDX6METheXq72rpY6m49xOJ7b3tnvw4tS16Ucyc0tRUOXkwOPyJ1bzpZ
 xVZTU7djSoXc4M5NSpSL9hOQ0jTmZnpYuO/+X+02VNmLE0kuDmE0h1tVD5E0er0zMlQ5cFFxDTx
 Qu2Ade+nvgtKrm28VDxepA7BSyCGdQ+0jekaGQnE12vqau8Rs63Wp2Y5QaI11NbbX9GxqXXIUGc
 tDcyqSEAI98Ktnml3Qu64lGaT1TtmMBgZ/QsgT+vFi2oFnmny6a17Nf2xiHoXzRhMM2HjHbiyQx
 8JWOtrDHpihbCXL1uEdEfEn00oM/G+QwvVNtFi401zgmw9Mnee76NnADvvZ8pU44dYSds5FQnwW
 sgUfm+156Wuml7g==
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

Add support for T430 format.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 175ae1589018..2e07e97c1540 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -317,6 +317,11 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YONLY_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_T430,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV24_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0

