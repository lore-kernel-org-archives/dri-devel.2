Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA0EC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA3710E588;
	Thu, 23 Jul 2026 09:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BORfaAEg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 901E010E588
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:46:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ED64860A67;
 Thu, 23 Jul 2026 09:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9451F000E9;
 Thu, 23 Jul 2026 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784799991;
 bh=c0op309bUfGA0ctk/Gc5xRw/LObUAXSQRptCHu8HqRc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BORfaAEge2bgsh1GovGRFQT20U8KHorncsr/Je6lcz0PutT6rInv5N412OjzzkKk8
 dhQrpekbotopVTjFwaNQK/reH7peBqOamowxX3NHAnHLDLwo7wRJ4Q0yzqxZ7RGBc2
 mnhyaTvavdKHoJiG6dIfg2QNSRwlznpF0b+D9ceDuUbf6+Xo2kczew4bwaF278ss/x
 qDUAHZNmNX+HXAbKw5Acszie/fh7C2yo/oqQHjMHEsnTnAogKclcpNYxJAMETetRyk
 uAgp9PGUeswlZGJ0oK5alUchC6wY7joT8jWl8zJVNayhioHnJ68Ok8ucNqvwDEYpC1
 SWGKwaK0Tp5kw==
Date: Thu, 23 Jul 2026 12:46:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: dhu@x6u.co
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 David Laight <david.laight.linux@gmail.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Pranjal Shrivastava <praan@google.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 stable@vger.kernel.org, jmoroni@google.com, kpberry@google.com,
 chriscli@google.com, viursachi@google.com, xuehaohu@google.com,
 sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260723094625.GE110966@unreal>
References: <20260623015459.1153884-1-xuehaohu@google.com>
 <20260722233932.3997681-1-dhu@x6u.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722233932.3997681-1-dhu@x6u.co>
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

On Wed, Jul 22, 2026 at 11:39:32PM +0000, dhu@x6u.co wrote:
> From: David Hu <xuehaohu@google.com>
> 
> Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> first entry, resulting in non-page-aligned DMA addresses for all
> subsequent entries.
> 
> While the underlying IOMMU mapping may be contiguous, hardware
> DMA engines often require explicit address alignment (e.g., page,
> cacheline, or storage sector boundaries). Passing unaligned
> addresses and lengths can cause explicit failures in DMA descriptor
> creation or silent data corruption if lower unaligned bits are
> truncated.
> 
> In addition, a non-page-aligned sgl length will trigger an edge case
> in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
> buffers, we will have a `va` with lowest bit set to 1. That will lead
> to `ib_umem_find_best_pgsz()` always return 0, and break the promise
> to find best page size for the mapping on the NIC side.
> 
> Fix this by splitting the scatterlist by the largest possible page
> aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
> This ensures all scatterlist DMA addresses and lengths remain page
> aligned, while minimizing the total number of sgl entries.
> 
> Page-aligned entries allow the system to cleanly chunk payloads into
> PCIe MaxPayloadSize (MPS) (e.g., 128 bytes, 256 bytes, 512 bytes).
> As a result, this may help reduce TLP fragmentation in P2P transfers
> and alleviate potential congestion within a logical PCIe switch
> partition, especially when Relaxed Ordering is not possible due to
> hardware constraints.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.kernel.org/
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hu <xuehaohu@google.com>
> ---
>  Changes in v3:
>  - Removed the type cast for `min` (David Laight)
>  - Reverted max ent size to be `ALIGN_DOWN(UINT_MAX, PAGE_SIZE)` and
>    updated commit message to reflect that (Jason Gunthorpe)
>  - Updated commit message to reflect that this also fixes an edge case
>    in `ib_umem_find_best_pgsz()`
> 
>  Changes in v2:
>  - Updated commit title and message to reflect the switch to 2G chunks
>  - Switch to using 2G as the max sg entry size as it naturally aligns
>    with most hardware boundaries, while allowing compiler optimizations
>    with bit shifts (David Laight)
>  - Optimized away division calculation for `nent`, and multiplication
>    calculation for sgl address, by dropping the `for` loop in favor of a
>    `while (length)` loop (David Laight)
>  - Dropped `min_t` in favor of `min()` to maintain a strict type
>    checking safety net (David Laight)
> 
>  drivers/dma-buf/dma-buf-mapping.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

Could you please avoid sending patches as replies? It severely disrupts
the reading flow when using mutt's threaded view.

Regarding the patch,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Thanks
