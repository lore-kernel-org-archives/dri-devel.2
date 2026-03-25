Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC89103A9BD
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C19B910E7D0;
	Wed, 25 Mar 2026 14:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Udi/3crR";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAAD10E0A6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:01:55 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id E7CED1992;
 Wed, 25 Mar 2026 15:00:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774447235;
 bh=lwV/vCcBkghaLz3kUGTN+aDbnk+UmKt+QGgNcRB+7Ks=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Udi/3crRbeXoqYwNwMXLXbCDkwruP13ri5nnwd4efsT3HLsEzIc/Zqf6fkpgX8TJf
 tOR28IfydyoFZ8wngsjp2r3mUNrtnta3IR4BWkBV/t2UwMbjsZX67QjCPiNS6YInHW
 NxS16m+ZSK3pkxWX34J53a+XxOHTsodA0oIjk58U=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 25 Mar 2026 16:01:25 +0200
Subject: [PATCH v9 02/11] drm/fourcc: Add DRM_FORMAT_XV20
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-xilinx-formats-v9-2-d03b7e3752e4@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=lwV/vCcBkghaLz3kUGTN+aDbnk+UmKt+QGgNcRB+7Ks=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpw+rKinDGszZVv54e5pD6eOJMLsufq5UDYm7kM
 QywQ1kLJNeJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacPqygAKCRD6PaqMvJYe
 9S+hD/0Q0rMG6YgbOaKEAJq1042AaXM6SJwI5z7/kuX4s5927BKGI04uekbSieA2muLCihGorqn
 eFTNO0FzPgzsMx88MjECZsTh/ZYiA59VzOfa08TFI+m303VBAoOZKoibE9BPTcsa7jWb7Qhl/oE
 /N18RGNyv9oiJeEyFLt6Wg+B14N9HhY2umDYehEOOZnNN8/PKeqNt/LjtBpbD+mUXFgsEkl48S6
 ZDq9GmV5QPfAq0pHqPuZkodnFIgzj+Nr7M+MkY3WTYtoX9ww0lDWB+TjVIvDxJD8b0ViC6BuYbB
 m9q+sI3eoQGBLsq6gfk9UrC7+3SlvU082nYWM9lp57DM/hlHyrwJkZw3GECpmrAsJ8UJLSjfZ32
 vQ9c/OLU+ydQuoBWahU1VdZnWp8qNWxY7iV1LHae/ap+AhJJSmiv97BLRlNhbS3iuDVCMiCaMeY
 IYH8O75RRfvAfG3TeMWM7WJLDI0H+MydGU4DTeG/gW8Gk+7oLA3GG3pnMvC2tsfgkte7hlWGKaB
 PuHGJe4gINytkyagMEHHWc0tGEVuqD5I3tMqdTw2tUpwAGwkUp7FB2bIHHRuUSsmOQDqlJD/dGx
 MVG+ZASWJHQ1lVq/ehlXteeYOSgt90g4r0oihmozWxkIERglp/lbBbXcILw0gv/6kQBQWmwCLOI
 LlxAb40NW44r5pA==
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

Add a new pixel format, DRM_FORMAT_XV20 ("XV20")

XV20 is 2 plane 10 bit per component YCbCr 2x1 subsampled format. XV20
is similar to the already existing P030 format, which is 2x2 subsampled.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 3 +++
 include/uapi/drm/drm_fourcc.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index e662aea9d105..4fd37226b647 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -381,6 +381,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_S416,            .depth = 0,  .num_planes = 3,
 		  .char_per_block = { 2, 2, 2 }, .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 },
 		  .hsub = 1, .vsub = 1, .is_yuv = true},
+		{ .format = DRM_FORMAT_XV20,		.depth = 0,  .num_planes = 2,
+		  .char_per_block = { 4, 8, 0 }, .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 },
+		  .hsub = 2, .vsub = 1, .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index c89aede3cb12..10cc13bdb495 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -322,6 +322,13 @@ extern "C" {
 #define DRM_FORMAT_RGB565_A8	fourcc_code('R', '5', 'A', '8')
 #define DRM_FORMAT_BGR565_A8	fourcc_code('B', '5', 'A', '8')
 
+/*
+ * 2 plane 10 bit per component YCrCb
+ * index 0 = Y plane, [31:0] x:Y2:Y1:Y0 2:10:10:10 little endian
+ * index 1 = Cb:Cr plane, [63:0] x:Cr2:Cb2:Cr1:x:Cb1:Cr0:Cb0 2:10:10:10:2:10:10:10 little endian
+ */
+#define DRM_FORMAT_XV20		fourcc_code('X', 'V', '2', '0') /* 2x1 subsampled Cr:Cb plane 2:10:10:10 */
+
 /*
  * 2 plane YCbCr
  * index 0 = Y plane, [7:0] Y

-- 
2.43.0

