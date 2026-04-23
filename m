Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CBDF589DB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F403610F172;
	Thu, 23 Apr 2026 14:22:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OGc0QUQ9";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DBA910F172
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:21:58 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E45C9A4;
 Thu, 23 Apr 2026 16:20:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776954018;
 bh=Q4YkxStVTNtbNjeHGufmg4LcJPbgHr6TYwXK5L0yUlM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OGc0QUQ9jocaipcvVF2KbFBR+jS6eyr/Ses5FEnZoKBh0q7vz5zXBKPVyUf3FpsbL
 NE4jWpulBAqGSKmmXqicw6j+h3VJwVMhi5DoaJjInu7tRCZDBzxbrabq+sIDPb9j18
 uLn9HygiYY81MnmJhtbjEngtFQHJXcRX8tlR6NT0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 23 Apr 2026 17:21:22 +0300
Subject: [PATCH v10 11/11] drm: xlnx: zynqmp: Add support for XVUY2101010
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-xilinx-formats-v10-11-c690c2b8ea89@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=898;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Q4YkxStVTNtbNjeHGufmg4LcJPbgHr6TYwXK5L0yUlM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp6ir3usQmkVqyFAJusd4oRJMcY3epkwQeBm5g3
 RhohBwnfOCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeoq9wAKCRD6PaqMvJYe
 9e/BD/4/dcVHTYJBGhAyRJRwMlHnuaOOAHphnm/BToUlOn9ynmG4rHf4a5BbTY20pcmwU2HbIfz
 2s77+cd2ey9M8RRHdiGV7iDvGxkKY3xw0BVanbGdymrqFkx+gO5/ExB9Xvf83IqtxX21CNDiuxa
 z9yBwFnZJFN6P0LLKPg0IEuzTYcyUmrAltyFbmoRX7AmnP9IfgnlXmJHkLVCfaIbY7KBzmhM+FE
 Lq7Cp/cWG80JU480ll3J72+KBp2RaZg+VA9szCIxbPzLuwkxiVACkbwcP43yZ64oey8wJR4gL9B
 xrcAeV5fKBcC3OOySHhjlSmj9w/zqCil/VgunGA4jenf5hwtwMTvq+EgIZfh45uLObm80b7hZOl
 6/A0mCgocw8zENxRkctsGflKuIHjaaIXSfFxA7MVJmN8u/fImP7iUM5pR5joeb5/ggl87UXMlii
 wn5dwRqnBsnw4p0jgXO/Sds1d3f970WpN1AhOnZJdY07lJLWTYa7k+QKsob60/NN9Teolga/QXm
 TBvsdmwY/JnHJ/6lZJXn1gPEWdT7MQd2wDk/ujG5x+0xu0FMK64CKA2pKErMyyz9701LTlHFD6T
 LtvW+rZVU9J1yzos4ih0JnEiPrpSfWdpv6FC4vG4q29SAqpt/beEElGSKRfZHcaT3DiAjp1iyPs
 6XrYEuVYu6jwYmw==
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

Add support for XVUY2101010 format.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 2e07e97c1540..52a0712e39c4 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -322,6 +322,11 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV24_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_XVUY2101010,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YUV444_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0

