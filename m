Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D87CCF2E3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA9510E11C;
	Mon, 19 Oct 2026 12:44:43 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9FBD10E11C
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 12:44:36 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0AFC6593;
 Mon, 19 Oct 2026 14:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1792413749;
 bh=NtAjh1G4ukJUomR9VlnElNvrY3MY7elt+Y6687H1Azg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kJLPx6y6L6U6aoBJWEpcxJ5iwqaFl6fqBuR5Vc9jMPUfDuL+SgZbCRHqWv4YVdcht
 YlzLF0KmoD5shqk8EkxKW0ciqM5gJaS0+nMInEOMiYf1Zi/lxxdpPS/hC95u92/1vG
 nvutY5tEDTYt6YncJLwCQk3TxIlYzBc8PZu3L3Ow=
Date: Mon, 19 Oct 2026 15:44:33 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Tomasz Stanislawski <t.stanislaws@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] media: synchronize CPU access to imported DMA-BUFs
Message-ID: <20261019124433.GU595565@killaraus.ideasonboard.com>
References: <cover.1792392288.git.kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1792392288.git.kmehltretter@gmail.com>
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

On Mon, Oct 19, 2026 at 09:14:07AM +0200, Karl Mehltretter wrote:
> UVC and vivid access imported DMA-BUFs with the CPU without cache
> synchronization. On a Pi 400, captured data remained in the CPU cache
> while physical RAM was stale.
> 
> Add an opt-in queue flag to bracket CPU access from buf_prepare() through
> buf_finish(). The allocator cannot imply CPU use because some vb2-vmalloc
> drivers pass buffers to hardware. Patch 1 balances finish operations in
> VIDIOC_REMOVE_BUFS so removing prepared buffers closes this interval.

This seems completely wrong.

> This follows the per-queue flag proposed here:
> https://lists.openwall.net/linux-kernel/2024/06/20/236
> 
> Based on Linux 7.3. Tests cover the same code on these earlier bases:
> 
> - Pi 400, 7.3-rc4, all four patches: eight 640x480 YUYV frames per run,
>   imported CMA DMA-BUFs with a DRM device mapping:
> 
>   Path                          Runs   Stale frames
>   UVC, vb2-vmalloc               12        0/96
>   vivid, vb2-vmalloc             12        0/96
>   vivid, vb2-dma-contig          12        0/96
> 
>   All six lifecycle cases passed with both vivid allocators. Read-only
>   output USERPTR passed. The test added no warnings or failed CPU-access
>   callbacks. A control without the DRM mapping found 4/16 stale frames.
> 
> - SAM9X75 (ARMv5), 6.18 backport of all four patches: the baseline
>   PREPARE_BUF/REMOVE_BUFS imbalance was fixed. USERPTR and six lifecycle
>   cases passed. All 128 vivid and 96 UVC frames matched RAM, with 100/100
>   begin/end calls. The baseline was already coherent.
> 
> - BeagleV Ahead (RISC-V), 7.3-rc7, patches 1, 2 and 4: read-only USERPTR,
>   six traced lifecycle cases and 60 repeats passed with balanced callbacks
>   and no kernel diagnostics. A vendor 5.10 backport of patches 2 and 3
>   captured 96 UVC frames without stale data, with 100/100 begin/end calls.
>   Its baseline was already coherent.
> 
> Karl Mehltretter (4):
>   media: videobuf2: finish prepared buffers in VIDIOC_REMOVE_BUFS
>   media: videobuf2: add opt-in DMA-BUF CPU access
>   media: uvcvideo: synchronize imported DMA-BUFs for CPU access
>   media: vivid: synchronize imported DMA-BUFs for CPU access
> 
>  .../media/common/videobuf2/videobuf2-core.c   | 96 ++++++++++++++++++-
>  .../common/videobuf2/videobuf2-dma-contig.c   |  5 +-
>  .../media/common/videobuf2/videobuf2-dma-sg.c |  5 +-
>  .../common/videobuf2/videobuf2-vmalloc.c      |  5 +-
>  drivers/media/test-drivers/vivid/vivid-core.c |  1 +
>  drivers/media/usb/uvc/uvc_queue.c             |  1 +
>  include/media/videobuf2-core.h                | 12 ++-
>  7 files changed, 116 insertions(+), 9 deletions(-)
> 
> 
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222

-- 
Regards,

Laurent Pinchart
