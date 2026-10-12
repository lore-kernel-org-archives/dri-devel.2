Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761FFCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBBD610E35E;
	Mon, 12 Oct 2026 08:19:25 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.36 at gabe;
 Mon, 12 Oct 2026 08:19:19 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FABD10E35E
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:19:19 +0000 (UTC)
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
 by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4j39DW2Ng8z6KNr;
 Mon, 12 Oct 2026 10:12:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1791792731;
 bh=8m/PI2rzRR7e4izvpKwNRDaoYx1A00e6WCIv/1VKjt0=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=PTx6Ibnfz5eXEKUXAxXEsgBww+gw/0RXLy7t1V5r2qGbZ4a2vsSiRkVjXSW8rOMq6
 zMKhQMFNNq46CrUsQ8d8beTdzEwNsP9NSd/TCsyvAX/CHmfpTANxUcTD2zGgksEgri
 hUR/hZqC7Ub6DGv6NA8AsIm2JouIVxjJ5hooRJ4LNOwC7aT7DpM1JneG6wqezChCJ7
 qlqKOdtIpWiQ77BSu8V3JypSQeDQCM6YwLDFJuyFM30rEdGNkCxbdtHOwC7FIdNqAZ
 XnRueyYDCofKWFkdWUGCEzHAE+6GRvZgt7Ld9jpP8+gOFtUqvDc7QXfG5m97mdMBCZ
 wB5n1jWeZgJiQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4j39DW1djNz4xrZ;
 Mon, 12 Oct 2026 10:12:11 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j39DT0hwsz8svZ;
 Mon, 12 Oct 2026 10:12:08 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 89CBF5FA0A;
 Mon, 12 Oct 2026 10:12:03 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <d1ef135e-1b5d-4656-9229-348c7029efbb@leemhuis.info>
Date: Mon, 12 Oct 2026 10:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [RFC PATCH 0/3] dma-buf: warn-only mode for DMABUF_DEBUG
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Rob Clark <rob.clark@oss.qualcomm.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20261005064133.7305-1-kmehltretter@gmail.com>
Content-Language: de-DE, en-US
In-Reply-To: <20261005064133.7305-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179179272424.2732199.1316107687235030751@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 89CBF5FA0A
X-NC-CID: e7ESKfmUIpuYlmbQcZtXdDyJbZbz3Y/HlwjoxMOnU+MFOoIgJ9w=
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

On 10/5/26 08:41, Karl Mehltretter wrote:
> With DMABUF_DEBUG, dma_buf_map_attachment() gives the importer a copy of
> the exporter's sg_table without the struct pages and offsets, and
> without the lengths where sg_dma_len() is a separate field. An importer
> that uses those fields stops working. That is the point of the option,
> but the failure usually shows up somewhere else and says nothing about
> the cause.
> 
> Commit 143755bdabaa9 ("dma-buf: Make DMABUF_DEBUG default to y on
> DEBUG_KERNEL kernels"), which I wrote, went into v7.3-rc4. It made the
> default from commit 646013f513f3 ("dma-buf: enable DMABUF_DEBUG by
> default on DEBUG kernels") take effect, and distribution configs
> usually have DEBUG_KERNEL=y. Two reports followed:
> 
> - Jianfeng Liu: hardware video decode with drm/msm ends in GPU
>   translation faults [1]. He then sent a revert [2].
> 
> - Diederik de Haas: rockchip fails to import buffers when playing
>   video, on a config based on Debian's [3].
>
> In [2] Rob Clark said the problem goes beyond msm and cannot be fixed
> quickly,

What's the status here given that 7.3 will likely be released in a few
days? Note, I can see from the discussion that this is a complex problem
that can't be quickly solved. That's how it is sometimes. But I wonder
if the current state of things is the best compromise for now or if
Rob's revert or some other option would be better.

Ciao, Thorsten

> and Christian König offered to set the default to N for
> another few months [4]. I listed more importers that look affected and
> mentioned this RFC in [5]. As of v7.3-rc6 the default is unchanged.
> 
> This series adds DMABUF_DEBUG_WARN as a sub-option of DMABUF_DEBUG. The
> importer still gets a copy, but one that keeps the CPU side of the
> exporter's table. The entries are marked with a new bit in dma_flags.
> sg_page(), sg_nents_for_len() and sg_split() print a rate limited
> message with a stack trace when they see the bit. These CPU-side
> accesses can continue after the report instead of failing because the
> fields were cleared. The report is not a WARN(), so it does not taint
> and does not trigger panic_on_warn. Strict mode remains the default and
> continues to remove the CPU-side fields.
> 
> Known limits:
> 
> - Only access through sg_page(), sg_nents_for_len() and sg_split() is
>   seen. sg_page() covers sg_phys(), sg_virt() and the page iterators.
>   An importer that reads sg->length or sg->offset directly is not
>   noticed.
> 
> - When the option is enabled, every sg_page() tests the flag.
> 
> - It selects NEED_SG_DMA_FLAGS, which adds dma_flags and may increase
>   the size of struct scatterlist. It also relies on dma_flags being
>   initialised, as the DMA mapping code already does.
> 
> - It finds importers. It does not fix them.
> 
> Question for the maintainers: could warn mode be what DEBUG_KERNEL
> kernels get by default, with strict mode kept for CI? Or is an opt-in
> sub-option all that is wanted, if anything? The series does not change
> any default.
> 
> Testing, on the commits as posted:
> 
> - KUnit, the dma-buf suites, under UML and on x86_64 in QEMU, in strict
>   and in warn mode: 56 passed, 1 skipped (it needs 2 CPUs) each time.
> 
> - Builds: x86_64, arm64 and ARM926 with DMABUF_DEBUG_WARN=y, ARM926
>   without DMABUF_DEBUG. Without DMABUF_DEBUG the generated code of
>   dma-buf.o and lib/scatterlist.o is the same as before, except for
>   line numbers.
> 
> - IIO DMABUF capture on a Zynq in QEMU, with local device models. The
>   IIO dmaengine buffer calls sg_nents_for_len() on the attachment's
>   table. In strict mode with NEED_SG_DMA_LENGTH the capture fails with
>   -EBUSY. In warn mode it works, the kernel is not tainted, and the log
>   has:
> 
>   DMA-BUF: importer used the CPU side of an exporter's sg_table
>   CPU: 0 UID: 0 PID: 48 Comm: iio-dmabuf Not tainted 7.3.0-rc4+ #2 VOLUNTARY
>   Call trace:
>    [...]
>    dump_stack_lvl from sg_nents_for_len+0xd8/0xe4
>    sg_nents_for_len from iio_dmaengine_buffer_submit_block+0x4c/0x33c
>    iio_dmaengine_buffer_submit_block from iio_dma_buffer_submit_block.part.0+0x5c/0x104
>    iio_dma_buffer_submit_block.part.0 from iio_dma_buffer_enqueue_dmabuf+0x68/0xa0
>    iio_dma_buffer_enqueue_dmabuf from iio_buffer_chrdev_ioctl+0x520/0x9a4
>    iio_buffer_chrdev_ioctl from sys_ioctl+0x460/0x914
> 
> - sur40 behind xHCI and intel-iommu on x86_64 in QEMU, with a one-line
>   test-only change in sur40. Here sg_page() is called in
>   iommu_dma_map_sg(), and the trace leads back to sur40_poll(). The
>   capture itself did not finish in that setup.
> 
> Details are in the notes on the patches. Not tested on hardware.
> 
> Based on v7.3-rc4-70-gfe2ec83746e5.
> 
> An LLM agent helped with the code and the testing.
> 
> [1] https://lore.kernel.org/r/20260923074256.9357-1-liujianfeng1994@gmail.com
> [2] https://lore.kernel.org/r/20260926022026.10539-1-liujianfeng1994@gmail.com
> [3] https://lists.freedesktop.org/archives/dri-devel/2026-September/600904.html
> [4] https://lore.kernel.org/r/50a9c1f1-6889-4bd5-b4f7-0500d30d3dd9@amd.com
> [5] https://lore.kernel.org/r/arrAvk4aYQ4sDEzN@gmail.com
> 
> Karl Mehltretter (3):
>   dma-buf: keep the DMA flags in the DMABUF_DEBUG copy
>   dma-buf: add a warn-only mode to DMABUF_DEBUG
>   dma-buf: test the debug scatterlist wrapper
> 
>  drivers/dma-buf/.kunitconfig |   1 +
>  drivers/dma-buf/Kconfig      |  23 ++++
>  drivers/dma-buf/Makefile     |   1 +
>  drivers/dma-buf/dma-buf.c    |  48 ++++++-
>  drivers/dma-buf/st-dma-buf.c | 253 +++++++++++++++++++++++++++++++++++
>  include/linux/scatterlist.h  |  26 +++-
>  lib/scatterlist.c            |  22 +++
>  lib/sg_split.c               |   2 +
>  8 files changed, 372 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/dma-buf/st-dma-buf.c
> 
> 
> base-commit: fe2ec83746e501645709761605c2464a44fd2929

