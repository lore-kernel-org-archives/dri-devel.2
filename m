Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4CDCD6E57
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F044F10E147;
	Thu,  4 Jun 2026 09:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="niblaG2N";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEDF10E147
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 09:43:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A716E601DF;
 Thu,  4 Jun 2026 09:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA221F00893;
 Thu,  4 Jun 2026 09:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780566230;
 bh=Jr5p7L025l5AeOyYY0OiYrQNKQ4cBVm4lneQmDi1MpU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=niblaG2NeNcheETDbWROWRN2EC8gUaeqU+V2iVk/GSdhP8Z5E3h/Gqpa5xH9cOpQ1
 v6hrbB7Jus7K1nshEC5tnaXEu/x8R0Ps4MUAXWUUwT0v92mDO1wuGIP+A09ewkQc3R
 fewRlDncxRlqrzoTxEvDeXuP3fJVL9FX+trLyhY92vve5JphyKdwYusPG+7U/3wQ9z
 2vJgIhyrAkFhIBA1MXydcQxfKlKZZc4vg+gsKTiHeslcVTAbWNka86r8xtj34X4OJd
 JPg5dlYSt4RSFaXGFT+erozr6bJfWrCgR4+GV5uKZqspaOb3D1WgDUAG9cSmTV8MK3
 Q5HIolmsKCCkw==
Date: Thu, 4 Jun 2026 12:43:44 +0300
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
Subject: Re: [PATCH v5] dma-buf: Fix silent overflow for phys vec to sgt
Message-ID: <20260604094344.GB245424@unreal>
References: <20260601200012.3872274-1-xuehaohu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601200012.3872274-1-xuehaohu@google.com>
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

On Mon, Jun 01, 2026 at 08:00:12PM +0000, David Hu wrote:
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
> by using `size_t` for `nents` and checking against `UINT_MAX`
> and using `unsigned int` for the loop iterator in `fill_sg_entry`
> to match.
> 
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Cc: stable@vger.kernel.org
> Cc: iommu@lists.linux.dev
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Hu <xuehaohu@google.com>
> ---
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
> 
>  drivers/dma-buf/dma-buf-mapping.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
> index 794acff2546a..607b7998463d 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -10,7 +10,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  					 dma_addr_t addr)
>  {
>  	unsigned int len, nents;
> -	int i;
> +	unsigned int i;
>  
>  	nents = DIV_ROUND_UP(length, UINT_MAX);
>  	for (i = 0; i < nents; i++) {
> @@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
>  				  struct phys_vec *phys_vec, size_t nr_ranges,
>  				  size_t size)
>  {
> -	unsigned int nents = 0;
> +	size_t nents = 0;
>  	size_t i;
>  
>  	if (!state || !dma_use_iova(state)) {
> @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
>  		nents = DIV_ROUND_UP(size, UINT_MAX);
>  	}
>  
> +	if (nents > UINT_MAX)

I would suggest to use check_add_overflow() while calculating nents
instead of this check.

> +		return 0;
> +
>  	return nents;
>  }
>  
> @@ -95,9 +98,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
>  					 size_t nr_ranges, size_t size,
>  					 enum dma_data_direction dir)
>  {
> -	unsigned int nents, mapped_len = 0;
>  	struct dma_buf_dma *dma;
>  	struct scatterlist *sgl;
> +	size_t mapped_len = 0;
> +	unsigned int nents;
>  	dma_addr_t addr;
>  	size_t i;
>  	int ret;
> @@ -133,6 +137,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
>  	}
>  
>  	nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
> +	if (!nents) {
> +		ret = -EINVAL;
> +		goto err_free_state;
> +	}

Technically, this hunk is not necessary, since sg_alloc_table() will
return -EINVAL when nents == 0. At least, that is the behavior I relied on.

Thanks

> +
>  	ret = sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
>  	if (ret)
>  		goto err_free_state;
> -- 
> 2.54.0.929.g9b7fa37559-goog
> 
