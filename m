Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE76FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E528A10E102;
	Thu, 30 Apr 2026 07:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=web04.chillydomains.com header.i=@web04.chillydomains.com header.b="lrxD/WNw";
	dkim-atps=neutral
Received: from web04.chillydomains.com (web04.chillydomains.com
 [193.19.92.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B58C510E400
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=web04.chillydomains.com; s=dkim; h=From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=+BMPRzE2ZaYndt8PUP9j3vTLvi6F1/BIe/
 +XCjPPh4w=; b=lrxD/WNwHIEekuNqi8vyqW3sAshhJYlyBWCJnbqSeTMYEytjp+
 UyGR2ATf8nRI1fDgeTXCln6LGbfU4BNAUXh/sUDzdti6LlZajf/4fLrePDzBpnfR
 Zo7FfaU9+6/4cWOP1EtpX0Nzmz3AyYUTl73wrxubhby8h1gzOUF1xTtmF0vyGvLV
 CjZU8gbZvp74M1UX9jJuJSqdVC+xjGUQYsICFy+ocDlBL0TMO0Ua+6ZF5cHRPUD/
 DjvymalihIlfMzkrStbDUkw4uHkM/LTqfTPDlJT+m0gGPrUxqjE7F2chM01iLOPb
 OTNNJgyb9YhYocCpHiL/e7PC4y/B+Zw4YCyA==
Received: (qmail 2739579 invoked by uid 7799); 29 Apr 2026 21:53:28 +0200
Received: by simscan 1.4.0 ppid: 2739543, pid: 2739553, t: 0.6181s
 scanners: clamav: 0.103.9/m:62/d:27778
Received: from 31.29.52.71.dynamic-pppoe.dt.ipv4.wtnet.de (HELO localhost)
 (automation@reauktion.de@31.29.52.71) by web04.chillydomains.com with SMTP
 [61968]; 29 Apr 2026 21:53:28 +0200
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
Subject: [PATCH RFC 2/3] media: hantro: attach dma_resv release fence at
 buf_queue
Date: Wed, 29 Apr 2026 19:53:05 +0000
Message-ID: <20260429195306.239666-3-mfritsche@reauktion.de>
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

Opt the hantro driver into the new vb2 release-fence helper.

When userspace QBUFs a buffer to hantro, the buffer is added to the
driver's m2m queue via v4l2_m2m_buf_queue. We additionally call
vb2_buffer_attach_release_fence() so each plane's dmabuf->resv
gets a real producer fence attached. The fence is signalled by
vb2_buffer_done when hantro completes the decode (via
v4l2_m2m_buf_done_and_job_finish in hantro_drv.c, which converges
on vb2_buffer_done).

Wayland compositors (and any other userspace) that import hantro
CAPTURE buffers and wait on the dmabuf's implicit-sync fence now
wait on a real fence representing the producer's actual completion,
not a stub. Validated end-to-end on PineTab2 (RK3566 / Mali-G52 /
mainline 6.19 with this series backported) playing 1080p30 H.264 in
chromium under stock KDE Plasma 6.6.4 Wayland: KWin's
Transaction::watchDmaBuf wait completes correctly the moment
hantro's IRQ fires, instead of falling back to a stub-resolved
poll.

Signed-off-by: Markus Fritsche <mfritsche@reauktion.de>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 62d3962c1..e95a3433a 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -877,6 +877,18 @@ static void hantro_buf_queue(struct vb2_buffer *vb)
 	}
 
 	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
+
+	/*
+	 * Opt in to vb2's dma_resv release-fence path. Userspace
+	 * consumers that imported this buffer's dmabuf and wait on
+	 * its implicit-sync fence (poll(POLLIN) or
+	 * DMA_BUF_IOCTL_EXPORT_SYNC_FILE) get a real producer fence
+	 * representing this device's completion, instead of the stub
+	 * fence dma_buf_export_sync_file substitutes when dma_resv
+	 * is empty. Best-effort: a fence-allocation failure means we
+	 * lose implicit-sync precision, no functional regression.
+	 */
+	(void)vb2_buffer_attach_release_fence(vb);
 }
 
 static bool hantro_vq_is_coded(struct vb2_queue *q)
-- 
2.47.3

