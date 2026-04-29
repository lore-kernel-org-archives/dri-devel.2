Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77273CD3421
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C65710F267;
	Thu, 30 Apr 2026 07:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=web04.chillydomains.com header.i=@web04.chillydomains.com header.b="nGSlbyXY";
	dkim-atps=neutral
Received: from web04.chillydomains.com (web04.chillydomains.com
 [193.19.92.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A845610E400
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=web04.chillydomains.com; s=dkim; h=From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=OaxA1KOQqFLnJwD8i8nhUbyHPWKOXYrj9Z
 YYoAP/kX0=; b=nGSlbyXYUKfQkPQwkan4V4FLTl1ALcyBc3+tUwIgRQWWxv/h2n
 pesTI414bf4N64kRjBeEU7tiq8EUc8Lt3K2VyQKx7gi/uE4xPiUZHDrY7kp9b/F4
 oHJit6O9XlrqQYW4MFIBZkv9UdCHcSUMc/OMHRIvBSZtRhCECuv3o9eU3XyLpG9V
 TmJpMAYX7743WkMFHRFlvFATt01iFwwFinKlU6eewGwo3VYsymZlNMdFiI2mRIYh
 3iMb+uUxr9SNY/mp3eHMABzA11kKqFvixLvby1WpBK3B2ddPiE27Vcc8VDeuGFsT
 ba9CvK9bEPNHt4W5Utk1BeuDJEL0QbRF4MgA==
Received: (qmail 2740071 invoked by uid 7799); 29 Apr 2026 21:53:35 +0200
Received: by simscan 1.4.0 ppid: 2740007, pid: 2740026, t: 0.6149s
 scanners: clamav: 0.103.9/m:62/d:27778
Received: from 31.29.52.71.dynamic-pppoe.dt.ipv4.wtnet.de (HELO localhost)
 (automation@reauktion.de@31.29.52.71) by web04.chillydomains.com with SMTP
 [64183]; 29 Apr 2026 21:53:35 +0200
From: Markus Fritsche <mfritsche@reauktion.de>
To: Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jacob Chen <jacob-chen@iotwrt.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC 3/3] media: rockchip-rga: attach dma_resv release fence at
 buf_queue
Date: Wed, 29 Apr 2026 19:53:06 +0000
Message-ID: <20260429195306.239666-4-mfritsche@reauktion.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429195306.239666-1-mfritsche@reauktion.de>
References: <20260429195306.239666-1-mfritsche@reauktion.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 07:37:56 +0000
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

Opt the Rockchip RGA driver into the new vb2 release-fence helper.

Same shape as the hantro patch: rga_buf_queue enqueues the buffer
in the driver's m2m queue via v4l2_m2m_buf_queue and additionally
attaches a release fence to each plane's dmabuf->resv via
vb2_buffer_attach_release_fence(). vb2_buffer_done signals the
fence when RGA completes the M2M operation.

Userspace consumers of RGA-produced dmabufs (image-processing
pipelines, screen-rotation servers, gstreamer flows on Rockchip
boards) get spec-clean implicit-sync semantics, matching what
hantro now does in the same patch series.

Signed-off-by: Markus Fritsche <mfritsche@reauktion.de>
---
 drivers/media/platform/rockchip/rga/rga-buf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/platform/rockchip/rga/rga-buf.c b/drivers/media/platform/rockchip/rga/rga-buf.c
index 70808049d..5557ca632 100644
--- a/drivers/media/platform/rockchip/rga/rga-buf.c
+++ b/drivers/media/platform/rockchip/rga/rga-buf.c
@@ -153,6 +153,16 @@ static void rga_buf_queue(struct vb2_buffer *vb)
 	struct rga_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 
 	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
+
+	/*
+	 * Opt in to vb2's dma_resv release-fence path so userspace
+	 * consumers of RGA-produced dmabufs get a real producer fence
+	 * to wait on instead of the dma_buf core's stub fence. See
+	 * the leading patch in this series for rationale. Best-effort:
+	 * fence-allocation failure means we lose implicit-sync
+	 * precision but the m2m operation itself proceeds normally.
+	 */
+	(void)vb2_buffer_attach_release_fence(vb);
 }
 
 static void rga_buf_cleanup(struct vb2_buffer *vb)
-- 
2.47.3

