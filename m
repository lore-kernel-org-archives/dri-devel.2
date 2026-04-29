Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5F0FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33A4110F24C;
	Thu, 30 Apr 2026 07:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=web04.chillydomains.com header.i=@web04.chillydomains.com header.b="1vj/rErK";
	dkim-atps=neutral
X-Greylist: delayed 401 seconds by postgrey-1.36 at gabe;
 Wed, 29 Apr 2026 20:00:06 UTC
Received: from web04.chillydomains.com (web04.chillydomains.com
 [193.19.92.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E3710E400
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=web04.chillydomains.com; s=dkim; h=From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding; bh=YdZ585r8V4E5fIuQnRHHEPO5/1uSUDu/m0
 GZmLya3es=; b=1vj/rErKfLqdvPkaG7tQijNJlnMKzq3V9bInusLa5pAamfmMu6
 cNuGkzACHYfNYN4jN0F2CaiOl/W7T6Q2fkOIuhNkjKF0iJnZHhOmlNr4w+JPyB5M
 Gzkst5aqBPrurZmJaNlb7pJ7q3JSF3Qz33BJ4/f3Vq3Mll/4EghofNfHsevT1JQx
 wJ0fv/V3BrzOSUyvo7j4mRHAOJLPKB2rSXEX9PSoY4zvmWs+ZL0Mkd46betkApbG
 NVTpRCLv5ccro0DY7BCXh8gWJNXJhhUSzTeR7KJeUJNroOpZGc1Uu7144jPwsQ2f
 q581v2KAPxqgF9wh2jnPqaiW4PgXFayBh2aw==
Received: (qmail 2738904 invoked by uid 7799); 29 Apr 2026 21:53:22 +0200
Received: by simscan 1.4.0 ppid: 2738885, pid: 2738893, t: 0.6424s
 scanners: clamav: 0.103.9/m:62/d:27778
Received: from 31.29.52.71.dynamic-pppoe.dt.ipv4.wtnet.de (HELO localhost)
 (automation@reauktion.de@31.29.52.71) by web04.chillydomains.com with SMTP
 [64555]; 29 Apr 2026 21:53:21 +0200
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
Subject: [PATCH RFC 0/3] media: videobuf2: opt-in dma_resv producer fences for
 V4L2 dmabuf exports
Date: Wed, 29 Apr 2026 19:53:03 +0000
Message-ID: <20260429195306.239666-1-mfritsche@reauktion.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi,

This series proposes a small opt-in API in videobuf2-core that lets V4L2
drivers populate a dma_resv exclusive write fence on the dmabufs they
export to userspace, signalled when the buffer transitions to
VB2_BUF_STATE_DONE. Two example drivers (hantro, rockchip-rga) opt in
to demonstrate the call shape; the change is no-op for every other
driver.

Why
---
Modern Wayland compositors and any other userspace consumers that
import V4L2-produced dmabufs and want to do implicit synchronization
the spec-clean way (poll(POLLIN) on the dmabuf fd, or
DMA_BUF_IOCTL_EXPORT_SYNC_FILE for a sync_file) currently get either:

1. A stub fence from dma_buf_export_sync_file(), because the dmabuf's
   dma_resv has no fences populated. The kernel substitutes
   dma_fence_get_stub() which is permanently signalled. The compositor
   "successfully" waits on a fence that represents nothing real about
   the producer's state.
2. A poll(POLLIN) on the dmabuf fd that returns immediately for the
   same reason — dma_buf_poll_add_cb finds zero fences in the resv,
   triggers the wake callback inline, and reports POLLIN ready before
   the producer has actually said anything.

Today this works as a happy accident on most paths because clients
attach buffers after VIDIOC_DQBUF, which the userspace V4L2 contract
guarantees only returns a buffer after the producer is done. So the
implicit "the kernel's stub fence is fine because the buffer is
already complete by the time anyone polls it" assumption has held.

But:

- It's a contract gap. The kernel claims to expose implicit sync; it
  does not, for V4L2 producers.
- It paid latency for nothing. Every Wayland frame from a V4L2
  producer pays a DMA_BUF_IOCTL_EXPORT_SYNC_FILE round-trip for a
  fence that's stub-signalled. On Mali-class hardware (RK3566 Wayland
  chrome video playback), this contributed to compositor stalls.
  Removing the wait at the compositor level is a workaround, not a
  fix.
- It blocks downstream consumers from doing the right thing. A
  Wayland compositor that defensively waits on a sync_file gets a
  stub-fence pass-through with no actual gating; if the V4L2 driver
  ever has an out-of-band path that releases the buffer before
  finishing the write, there is no fence to gate on.

What
----
Patch 1 adds:

- struct dma_fence *release_fence to struct vb2_buffer
- u64 dma_resv_fence_context + atomic64_t dma_resv_fence_seqno +
  spinlock_t dma_resv_fence_lock to struct vb2_queue
- vb2_buffer_attach_release_fence(vb) — drivers call this from their
  buf_queue callback. Allocates a dma_fence on the queue's fence
  context, attaches it as DMA_RESV_USAGE_WRITE on each plane's
  dmabuf->resv. No-op for buffers without exported dmabufs.
- vb2_buffer_done() extended to signal+put the fence if attached,
  so the producer's completion signal lands in the resv synchronously
  with the userspace DQBUF wakeup.

Patches 2 and 3 add a single call to the helper from hantro_buf_queue
and rga_buf_queue respectively. Both are demonstration drivers; other
vb2 drivers can opt in incrementally with the same one-line change.

Tested on
---------
PineTab2 (RK3566 / Mali-G52 panfrost / mainline 6.19.10, this series
backported), playing 1080p30 H.264 in chromium under KDE Plasma 6.6.4
Wayland. The test harness is the chromium-fourier patch series at
https://github.com/marfrit/fourier — chromium plus a KWin patch
that *previously bypassed* Transaction::watchDmaBuf because the
kernel-side fence was stub-signalled. With this series applied, the
bypass becomes unnecessary; KWin's fence wait completes correctly
because the fence now signals when hantro completes the capture
buffer write.

End-to-end result before the kernel patch (chromium + Qt 6 patches +
KWin watchDmaBuf bypass): 1080p30 H.264 plays through, ~81% combined
chrome CPU, but the watchDmaBuf bypass weakens KWin's defenses against
misbehaving clients.

End-to-end result after the kernel patch (chromium + Qt 6 patches +
plain unmodified KWin): 1080p30 H.264 plays through with the same CPU
profile, KWin's watchDmaBuf wait completes within microseconds against
the now-real producer fence, no defenses weakened.

What's missing in this RFC
--------------------------
- Other vb2-using drivers don't opt in. Each maintainer should look
  at their driver and decide. The hantro + rga patches show the
  shape; copying it to other drivers should be straightforward.
- For drivers that have intermediate image-processor stages (e.g.
  CSI -> ISP -> user), the fence semantics across stage boundaries
  are out of scope here. This series only addresses the producer-to-
  userspace edge.
- No selftest. videobuf2 doesn't have a great in-tree selftest harness
  for dmabuf flows; the validation is end-to-end at the userspace
  consumer level (KWin, in our case).

Reviews especially welcome on:

- The decision to make this opt-in per driver vs. automatic for all
  vb2-CAPTURE queues. Auto-on would force every driver to be audited;
  opt-in is incremental and safer but leaves the contract gap for
  drivers nobody touches.
- Whether vb2_buffer_done is the right place to signal vs. an earlier
  hook (e.g. immediately after DMA-from-device finishes). For hantro
  the two are effectively the same; for drivers with asynchronous
  post-processing they may differ.
- The choice of DMA_RESV_USAGE_WRITE — we are emitting the producer's
  write completion, so WRITE matches dma-buf documentation, but a
  sanity check is welcome.

Cheers,
Markus


Markus Fritsche (3):
  media: videobuf2: add dma_resv release-fence helper
  media: hantro: attach dma_resv release fence at buf_queue
  media: rockchip-rga: attach dma_resv release fence at buf_queue

 .../media/common/videobuf2/videobuf2-core.c   | 95 +++++++++++++++++++
 drivers/media/platform/rockchip/rga/rga-buf.c | 10 ++
 .../media/platform/verisilicon/hantro_v4l2.c  | 12 +++
 include/media/videobuf2-core.h                | 29 ++++++
 4 files changed, 146 insertions(+)

-- 
2.47.3

