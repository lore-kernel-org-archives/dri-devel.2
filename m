Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264B606D809
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=wGel0Pqc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B48810E58E;
	Sat,  7 Nov 2026 10:59:56 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319FB10E58E
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 10:59:50 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4203EC14;
 Sat,  7 Nov 2026 11:57:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1794049048;
 bh=j+h2K+Hb5Cv2MefIVwTunwXi7NhuqCo+7EeZpAlrKXE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wGel0Pqc9wogfYLkIWvCWYNBcfKnlwz/12QrYbBRqM/q/lkKG9sovWnku8VZMjSDF
 yHM9aH+Ag55miR72fxIpH22uACsSXkA1x8k6nLQa7Jy7A6EoknoYnRKWOQfYnNW8zb
 c/mXHaHtwAUn6AOPohE7aQDZ/LEQerUreLVAQBFg=
Date: Sat, 7 Nov 2026 12:59:46 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] media: synchronize CPU access to imported DMA-BUFs
Message-ID: <20261107105946.GA96745@killaraus.ideasonboard.com>
References: <20261107104703.44111-1-kmehltretter@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261107104703.44111-1-kmehltretter@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Karl,

We discussed in v1 how this is not the right approach. Why are you
posting a v2 without addressing that ? You need to go back to the design
table.

On Sat, Nov 07, 2026 at 11:47:00AM +0100, Karl Mehltretter wrote:
> uvcvideo and vivid (when using vb2-vmalloc) access imported DMA-BUFs
> through a kernel vmap without cache synchronization. When a non-coherent
> importer such as V3D maps the same DMA-BUF persistently, captured data
> remains in the CPU cache while physical RAM holds stale bytes.
> 
> Add an opt-in uses_cpu_access queue flag for vb2-vmalloc queues to
> bracket the interval from buf_prepare() through buf_finish() with
> dma_buf_begin_cpu_access() and dma_buf_end_cpu_access(). Keep this
> opt-in because some vb2-vmalloc drivers pass imported buffers to
> hardware, and end CPU access in process context because DMA-BUF
> callbacks may sleep.
> 
> This follows the per-queue flag proposed here:
> https://lore.kernel.org/r/CAAFQd5Am5jBev5P1HmsdeHoJfROZat3bi1W=UsN7wpVqw-XUQQ@mail.gmail.com/
> 
> Based on Linux 7.4-rc1 with prerequisite patch "media: videobuf2: finish
> prepared buffers in VIDIOC_REMOVE_BUFS":
> https://lore.kernel.org/r/20261026071735.37220-1-kmehltretter@gmail.com/
> 
> Changes in v2:
> - Split patch 1 of v1 into the standalone VIDIOC_REMOVE_BUFS patch above
>   and use its __vb2_buf_cancel() helper so queue cancellation and
>   VIDIOC_REMOVE_BUFS share the finish path (Tomasz).
> - Scope uses_cpu_access to vb2-vmalloc queues and drop the attach_dmabuf
>   dma_dir parameter from vb2_mem_ops, videobuf2-dma-contig,
>   videobuf2-dma-sg and videobuf2-vmalloc (Tomasz).
> - Enable uses_cpu_access in vivid only when vivid uses
>   vb2_vmalloc_memops (Tomasz).
> 
> Link to v1:
>   https://lore.kernel.org/r/cover.1792392288.git.kmehltretter@gmail.com/
> 
> Testing:
> 
> - Raspberry Pi 500+ (6.18.34+rpt-rpi-2712, aarch64, 16 KiB pages,
>   Sunplus UVC camera 1bcf:2701 and Broadcom V3D 7.1 GPU), backport of
>   the prerequisite patch plus patches 1 and 2: eight 640x480 YUYV frames
>   (614,400 B) captured into DMA-BUFs pre-seeded with 0xA5 and imported
>   into persistent EGL_LINUX_DMA_BUF_EXT textures before VIDIOC_STREAMON,
>   then copied by V3D 7.1 immediately after VIDIOC_DQBUF:
> 
>   Heap                        Baseline stale      Patched v2 stale
>   /dev/dma_heap/linux,cma     8/8 (329,890 B)        0/8 (0 B)
>   /dev/dma_heap/system        8/8 (509,818 B)        0/8 (0 B)
> 
> - QEMU virt (arm64, Linux 7.4-rc1 with the prerequisite patch and
>   patches 1-3, VIDEO_ADV_DEBUG=y, DEBUG_ATOMIC_SLEEP=y): six vivid
>   lifecycle cases (stream, streamoff-queued, prepare-reqbufs0,
>   prepare-remove, close-streaming, replace-dmabuf) across single-planar
>   and multi-planar queues with kprobe counters on
>   dma_buf_begin_cpu_access() and dma_buf_end_cpu_access():
> 
>   Queue                        begin/end calls   Unbalanced   Warnings
>   vivid vb2-vmalloc (SP)           34 / 34            0           0
>   vivid vb2-vmalloc (MP)           34 / 34            0           0
>   vivid vb2-dma-contig (SP)         0 / 0             0           0
>   vivid vb2-dma-contig (MP)         0 / 0             0           0
>   20x prepare-remove (vmalloc)     20 / 20            0           0
> 
> Assisted by an LLM for code changes, test harnesses and commit message
> drafting.
> 
> Karl Mehltretter (3):
>   media: videobuf2: add opt-in DMA-BUF CPU access
>   media: uvcvideo: synchronize imported DMA-BUFs for CPU access
>   media: vivid: synchronize imported DMA-BUFs for CPU access
> 
>  .../media/common/videobuf2/videobuf2-core.c   | 76 +++++++++++++++++++
>  drivers/media/test-drivers/vivid/vivid-core.c |  4 +-
>  drivers/media/usb/uvc/uvc_queue.c             |  1 +
>  include/media/videobuf2-core.h                |  5 ++
>  4 files changed, 85 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> prerequisite-patch-id: aa99d5c3c27082cbe003ed94a195e3de415777c9
> -- 
> 2.39.5 (Apple Git-154)

-- 
Regards,

Laurent Pinchart
