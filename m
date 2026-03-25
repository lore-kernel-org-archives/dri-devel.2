Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F145106B53D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7976A10E7EC;
	Wed, 25 Mar 2026 14:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QF0d4g8K";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5743C10E7E5
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:02:00 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 98FB91BCF;
 Wed, 25 Mar 2026 15:00:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774447241;
 bh=z0ohKrl3nNbmQTLz1wlnzqyZg5t58xltjjEsw+ctQ5I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QF0d4g8Kh3BPE6L2eXkONe+b8r2Rte/T6Dszu5QsrAqshNc+P4ne0FbAdQivpQTXg
 pVGC9dKYZ9Sf49m+yUyZW2qTp3RHKT4EbAO87sQfLX6Jh/qiwNBgH94Em2xgfBEGAt
 m7IVyUk1SnG93ZkxBBlVD3KLS5BmTH0d/Z/q5Hu4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 25 Mar 2026 16:01:30 +0200
Subject: [PATCH v9 07/11] drm: xlnx: zynqmp: Use drm helpers when
 calculating buffer sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-xilinx-formats-v9-7-d03b7e3752e4@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=z0ohKrl3nNbmQTLz1wlnzqyZg5t58xltjjEsw+ctQ5I=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpw+rM1t8SmQCwqK8q+2874g4y6W+UFEHPA5hLY
 P1NTp9GrruJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacPqzAAKCRD6PaqMvJYe
 9eeDEACjFTftnIo4/vHE+Zbd/vinVkVUNXpCS2jTkFIphNpxKMEFHsw7tW07kBC3+PW1UIz513A
 HLXt3o2mABa2ycziWgJfIsVDzbO2nKSPakHWbExsms2XRQ567n4dZQC3y92nRX0pcI3U+GQsPbC
 I/KGUItD4iqGJcAuZUaA3Cn7GtbM2Ln+XeGFpdpdqNq3TlFa9ZX7dfcaL1JV43ZBiKlOzGfwR4k
 SVLndy8Jg/nAuIPwI95nQQufCjTvgsyqOzLZuofGU93kloYDGSDX4E3U25yKRbM2pRbccNxj+/R
 RSI9rvkcNLX0OLT+WSYTfePHO3TUXNziuxVd3EOgGcQc5Zbkn5hXar1FGDRpW2u/4rynhKe7rhn
 6/7ie2yQZoRICLxCQYYbA2ayWBjGOuTehWshn7VfhHvviCY2vh6Iej+t9h79wi8OhHocxnnymk3
 tUVh3QW2WWTOYspyZaGkjpfjhIWEGpBr5QAZa5b2WwlzDmVhlxHVbg66k3mE4fq24kCEcm/Y8gv
 yA9Efs8Fj7DluezJKBic7LrzOkmFvJUOEh17JRc7JwRnrNPJcZ98Hj94t0dp+p9NUCyVJi8Ss29
 sYi3nvJzSpxERRAYpKzzlsIePpGy1x/3rfFnkJEL6q3nu63/y3m0TaeNcBgEVEIWwbnqueDWAYo
 a6+4lwMinVAQ2wA==
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

Use drm helpers, drm_format_info_plane_width(),
drm_format_info_plane_height() and drm_format_info_min_pitch() to
calculate sizes for the DMA.

This cleans up the code, but also makes it possible to support more
complex formats (like P030, XV20).

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 9a8f38230cb4..12a8d643915f 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -1116,16 +1116,19 @@ int zynqmp_disp_layer_update(struct zynqmp_disp_layer *layer,
 		return 0;
 
 	for (i = 0; i < info->num_planes; i++) {
-		unsigned int width = state->crtc_w / (i ? info->hsub : 1);
-		unsigned int height = state->crtc_h / (i ? info->vsub : 1);
 		struct zynqmp_disp_layer_dma *dma = &layer->dmas[i];
 		struct dma_async_tx_descriptor *desc;
 		dma_addr_t dma_addr;
+		unsigned int width;
+		unsigned int height;
+
+		width = drm_format_info_plane_width(info, state->crtc_w, i);
+		height = drm_format_info_plane_height(info, state->crtc_h, i);
 
 		dma_addr = drm_fb_dma_get_gem_addr(state->fb, state, i);
 
 		dma->xt.numf = height;
-		dma->sgl.size = width * info->cpp[i];
+		dma->sgl.size = drm_format_info_min_pitch(info, i, width);
 		dma->sgl.icg = state->fb->pitches[i] - dma->sgl.size;
 		dma->xt.src_start = dma_addr;
 		dma->xt.frame_size = 1;

-- 
2.43.0

