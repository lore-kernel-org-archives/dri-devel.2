Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D18F589DC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA08110F156;
	Thu, 23 Apr 2026 14:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SH8WWtfx";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0168B10E2B5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:21:48 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 977AC9A4;
 Thu, 23 Apr 2026 16:20:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776954007;
 bh=qsLARDIVnkaD/ICi7soozFniWWJmCvAqHDdDTOWdWNc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SH8WWtfxYgJIOmCBHZeDq6CKA0QNMeHsHVHtaHNioucGtgF0nYR5PPIpyu8C5Cq7n
 g1YlCQdjAVEQE938F8lzysjjjDpyTnswPOu5CLw9utjvBC1HIBevkCJ8Dax0JWRI/2
 fdjio/tr30Th1oB3e6tVLpFU1IYC6+MR1v0HkHto=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 23 Apr 2026 17:21:12 +0300
Subject: [PATCH v10 01/11] drm/fourcc: Add warning for bad bpp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-xilinx-formats-v10-1-c690c2b8ea89@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=qsLARDIVnkaD/ICi7soozFniWWJmCvAqHDdDTOWdWNc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp6ir02WndvzaoJu9fVHl03maWhZDEGbC6j3mLR
 QkhABJgBzeJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeoq9AAKCRD6PaqMvJYe
 9SIgD/9Pd6FQKFMsX4tEdU/iPPznMxPeNc3lJQSCoeDlE2x6iS5F4CbFvjewkCTmfG2ncFxMOld
 K5GGNDl9aJOEGsHZ+n1jroBIFV/l7DBcQ+aPlmIrn1AfPRH85DpwH3v0iurNIexBocnCG2/J/yp
 sq1TPgoBZDY6BbzO5fSMhLtw7eJyqXnjHVCb2BB5xz4QgYCiWenJn8JTMl2ST2/CsLTRoBQfIBY
 hE4c7V9wUYeZP9lppLqk3Bb94RpBrZDQsXtPjA3WAbEmG/Ed0G/iMa4acEWK5BG0kMbqLjogp2i
 OQ4M8Y9w96PHcLN9cepSOJZCvk6AaCRYvcWCKInKUST0c+nSn6YhqAXMJXJtCwkC/tjWBRhXbkn
 DcKuCWvVxl1W6KAB+VMoyi6FZEfoCLFHxqpWSNvMcePmLovecJi7/Tpe3G5cnymiMyCJRCpvN5x
 0BMI/1avkmPRYnFgXk3J6VA0fH7LHqHY/psSEGdAFR6btXL0cA41dxHEHUyD51VZTHhXE4UUISu
 PcHofQTqI2AyGpwANXqORqUD/6Uc0z2+wCXmNfNGk2iYZhuOZmOqJmMiOeczg0asJk0rfSzzyyh
 1jaK633LPo4DWfu6UYKrPyWevm539oH81rcoUZHE35Yp91Ml6ODzvZeBoUUCF/ISrAMZzNRBtwc
 Ka50JNd1GuzanLg==
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

drm_format_info_bpp() cannot be used for formats which do not have an
integer bits-per-pixel in a pixel block.

E.g. DRM_FORMAT_P030's plane 0 has three 10-bit pixels (Y components),
and two padding bits, in a 4 byte block. That is 10.666... bits per
pixel when considering the whole 4 byte block, which is what
drm_format_info_bpp() does. Thus a driver that supports such formats
cannot use drm_format_info_bpp(),

It is a driver bug if this happens, but so handle wrong calls by
printing a warning and returning 0.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index e0d533611040..e662aea9d105 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -491,12 +491,20 @@ EXPORT_SYMBOL(drm_format_info_block_height);
  */
 unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane)
 {
+	unsigned int block_size;
+
 	if (!info || plane < 0 || plane >= info->num_planes)
 		return 0;
 
-	return info->char_per_block[plane] * 8 /
-	       (drm_format_info_block_width(info, plane) *
-		drm_format_info_block_height(info, plane));
+	block_size = drm_format_info_block_width(info, plane) *
+		     drm_format_info_block_height(info, plane);
+
+	if (info->char_per_block[plane] * 8 % block_size) {
+		pr_warn("unable to return an integer bpp\n");
+		return 0;
+	}
+
+	return info->char_per_block[plane] * 8 / block_size;
 }
 EXPORT_SYMBOL(drm_format_info_bpp);
 

-- 
2.43.0

