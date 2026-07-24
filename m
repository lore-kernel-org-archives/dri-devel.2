Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7E8C531FC
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 350E910E304;
	Mon, 27 Jul 2026 07:17:21 +0000 (UTC)
X-Greylist: delayed 3373 seconds by postgrey-1.36 at gabe;
 Fri, 24 Jul 2026 08:39:00 UTC
Received: from stargate.chelsio.com (unknown [12.32.117.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B0110F2AF
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:39:00 +0000 (UTC)
Received: from localhost (praveen-pc.asicdesigners.com [10.193.191.60] (may be
 forged))
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 66O7YKls001771;
 Fri, 24 Jul 2026 00:34:20 -0700
Date: Fri, 24 Jul 2026 13:04:03 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Gou Hao <gouhao@uniontech.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, jgg@ziepe.ca, leon@kernel.org,
 akpm@linux-foundation.org, namcao@linutronix.de, ynorov@nvidia.com,
 sshegde@linux.ibm.com, nilay@linux.ibm.com, clg@kaod.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, gouhaojake@163.com, kernel@uniontech.com
Subject: Re: [PATCH v2 6/6] RDMA/cxgb4: remove dead NULL checks after
 GFP_NOFAIL allocations
Message-ID: <amMVa/hvQndWud1I@chelsio.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
 <20260724022851.466017-7-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724022851.466017-7-gouhao@uniontech.com>
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

On Friday, July 07/24/26, 2026 at 10:28:51 +0800, Gou Hao wrote:
> alloc_skb() with the __GFP_NOFAIL flag will never return NULL,
> so the subsequent NULL checks and error handling are unreachable
> dead code. Remove them.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>  drivers/infiniband/hw/cxgb4/mem.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
> index cd1b010141984..08631de17c0a3 100644
> --- a/drivers/infiniband/hw/cxgb4/mem.c
> +++ b/drivers/infiniband/hw/cxgb4/mem.c
> @@ -74,11 +74,8 @@ static int _c4iw_write_mem_dma_aligned(struct c4iw_rdev *rdev, u32 addr,
>  		c4iw_init_wr_wait(wr_waitp);
>  	wr_len = roundup(sizeof(*req) + sizeof(*sgl), 16);
>  
> -	if (!skb) {
> +	if (!skb)
>  		skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
> -		if (!skb)
> -			return -ENOMEM;
> -	}
>  	set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
>  
>  	req = __skb_put_zero(skb, wr_len);
> @@ -134,11 +131,8 @@ static int _c4iw_write_mem_inline(struct c4iw_rdev *rdev, u32 addr, u32 len,
>  					 roundup(copy_len, T4_ULPTX_MIN_IO),
>  				 16);
>  
> -		if (!skb) {
> +		if (!skb)
>  			skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
> -			if (!skb)
> -				return -ENOMEM;
> -		}

Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>

>  		set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
>  
>  		req = __skb_put_zero(skb, wr_len);
> -- 
> 2.20.1
> 
