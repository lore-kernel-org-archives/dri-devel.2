Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D487B1093168
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E46F10E7E3;
	Wed, 25 Mar 2026 14:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lF587bCn";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A94110E0A6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:01:54 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id DB3651862;
 Wed, 25 Mar 2026 15:00:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774447234;
 bh=qsLARDIVnkaD/ICi7soozFniWWJmCvAqHDdDTOWdWNc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lF587bCnjk96kRIOnhLuuZueHe6u03Vp48+mNFLsNW4Pn+IP+ZHuEXrXTPRHZ7+YO
 sVMWc/lOjpLOvYigVwDEMy0SL0MykDKv6vWKrevGybIK9X2lBY/QjMNpk41q9xBPjT
 LZuYpKDrbMbZPOmwB41f7K/QiJ3Q6ErMJV34RaKc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 25 Mar 2026 16:01:24 +0200
Subject: [PATCH v9 01/11] drm/fourcc: Add warning for bad bpp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-xilinx-formats-v9-1-d03b7e3752e4@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=qsLARDIVnkaD/ICi7soozFniWWJmCvAqHDdDTOWdWNc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpw+rKDYNdViLCLpYqmZY0SWmqG5dqG7vwwbdHf
 xBeIPg+ZiCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacPqygAKCRD6PaqMvJYe
 9b6yEACZbXoKPDiWE2N5P6E9h8U/nh2IAvHlKdisK3dSbhI2w8QJyHDIZ35PsOGhEmhynk0rSEC
 SXYP4gXR+V7WlAnsroPmcagxUtt7WZGZXoRWCkWxd8YgN+BX1ETCWADTXvry4oYUI7tJV2Hf/QD
 4KJ9fwZcTFHZVqDq0EQjHmMv7SplpqL0RJwYVAxqgquFRz0FJpj1qH0+5qlOKa24psIzq6ICCFn
 TpAlP2/wenQ/0cxFdZEIa+wwxKQcWid280+84DCs6vsG1KT0OuvFsh46TPUGxIA5vC4FIjgifJJ
 /hlaA1gtlFYC7JSui0UBOKfhNYH/vkF895MuKub+jpODFhYg74i71rSdLHYS0S8UWSRFNxBnwA9
 XE1W38JfDpDJ3J+UzOZC3M0FJweCx29QWhNLik9+S5P0E4yrUk8xLef2CNdQZtbHsF/WCN7JDOh
 HL9/CUpJz7Xv9PgLdzPeIjUtEWcCZw3gLqJrTyKvrTUPef2/N1bifxV/nVg/wSf6F28nZSR1TCb
 ygayljh2ewhRZfynm1FbwB2kiSaCgr2zCnK6xdi0S+ECp1odkv+62iEqYsWg+J9kwB31hcuoA52
 fW0FJIuUMBYfhqQQY5RfqMfFTN2vmJ82TwV8nKHsZtdK5psK0Raza5Cf0EikElS9tonfTihy2KU
 QhlNqqK4aCPb+sg==
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

