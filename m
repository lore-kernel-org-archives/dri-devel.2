Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028FCCD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D5210E137;
	Tue,  9 Jun 2026 07:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BXQRnnQV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453F210E137
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 07:22:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E8E964050F;
 Tue,  9 Jun 2026 07:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C631F00893;
 Tue,  9 Jun 2026 07:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780989759;
 bh=I7FjI2O820nUywCy7+dsVn5yjEmJGm64ivePqVuSznw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BXQRnnQV+2QCcagZphHSOF7BYi7wn/QpRnuwSzxOhhwC6rlYLmLIzq7FmZr0qshQd
 Iip7BxBMx/a4l3EnGn1XKMeeJeuLxaAU6F6Bvd1J0YQqS1HWcmHCtT/0FKI6uDL8Gf
 BW2g/y+hr/9eO/Iqr54X7aBdTTMBLUeeHzs/H7BQtDqX8WKOBqEegveG7IAAI90iXg
 E1rEH4b8xvB/vW+Jnm18an3eRdRidxK6adLb7j7ZNFHLIuTDxvn90lBOVvGUFwNnqa
 fJWniPnIm5Erddgsl4U3z7DOb/1lRVGRUXDvAx8w5QykeMrT94EMovbgmUk6QsscYD
 Y+Y6AaI2hSiIQ==
Date: Tue, 9 Jun 2026 10:22:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 jmoroni@google.com, praan@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v6] dma-buf: Fix silent overflow for phys vec to sgt
Message-ID: <20260609072234.GB327369@unreal>
References: <20260608194321.150838-1-xuehaohu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608194321.150838-1-xuehaohu@google.com>
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

On Mon, Jun 08, 2026 at 07:43:21PM +0000, David Hu wrote:
> In case MMIO size is bigger than 4G and peer2peer DMA goes
> through host bridge, we trigger a code path that assigns the
> total linked IOVA (which is greater than 4G) to mapped_len.
> 
> Previously, `mapped_len` was declared as 32-bit `unsigned int`.
> When accumulating `size_t` lengths, this leads to a silent wrap-around.
> This truncation causes truncated lengths to be passed to functions
> like `fill_sg_entry()`.
> 
> Fix this by changing `mapped_len` to `size_t` (64-bit). While
> at it, fix similar potential overflow issues in `calc_sg_nents`
> by using `check_add_overflow()` for `nents` and using
> `unsigned int` for the loop iterator in `fill_sg_entry` to match.
> 
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Cc: stable@vger.kernel.org
> Cc: iommu@lists.linux.dev
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: David Hu <xuehaohu@google.com>
> ---
> Changes in v6:
>  - Used `check_add_overflow()` in `calc_sg_nents()` for safer
>    accumulation (Leon).
>  - Dropped explicit `!nents` check and added a comment noting that
>    `sg_alloc_table` handles `nents == 0` (Leon).
>  - Collected Reviewed-by from Kevin Tian.
> 
> Changes in v5:
>  - Removed WARN_ON_ONCE from calc_sg_nents() to avoid log noise (Jason).
>  - Added explicit check for `!nents` in dma_buf_phys_vec_to_sgt() to
>    cleanly return -EINVAL on overflow (Jason).
> 
> Changes in v4:
>  - Added WARN_ON_ONCE() to the nents overflow check to prevent silent
>    failures (Claude Bot).
> 
> Changes in v3:
>  - Removed leftover sentence fragment from the commit message.
>  - Kept `nents = 0` initialization (previously stated as removed in the
>    v2 changelog) as it is strictly required for the `+=` accumulation
>    loop in `calc_sg_nents()`.
> 
> Changes in v2:
>  - Fixed 'IVOA' -> 'IOVA' typo and expanded commit message (Claude Bot).
>  - Added Reverse Xmas tree formatting (Pranjal).
>  - Folded in extra bounds checking for calc_sg_nents() (Pranjal).
>  - Folded in type consistency fix for fill_sg_entry() (Pranjal).
>  - Collected Reviewed-by from Pranjal Shrivastava.
> 
>  drivers/dma-buf/dma-buf-mapping.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
> index 794acff2546a..67a8ff52fb8f 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -5,12 +5,13 @@
>   */
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/dma-resv.h>
> +#include <linux/overflow.h>
>  
>  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  					 dma_addr_t addr)
>  {
>  	unsigned int len, nents;
> -	int i;
> +	unsigned int i;
>  
>  	nents = DIV_ROUND_UP(length, UINT_MAX);
>  	for (i = 0; i < nents; i++) {
> @@ -40,8 +41,11 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
>  	size_t i;
>  
>  	if (!state || !dma_use_iova(state)) {
> -		for (i = 0; i < nr_ranges; i++)
> -			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
> +		for (i = 0; i < nr_ranges; i++) {
> +			unsigned int added = DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
> +			if (check_add_overflow(nents, added, &nents))

An additional blank line should be inserted between variable initialization
and the subsequent code block.

Aside from that,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
