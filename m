Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F905C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 745828984C;
	Thu, 23 Jul 2026 08:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VGeBx8EI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5628D8984C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 08:35:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE2FD40C18;
 Thu, 23 Jul 2026 08:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774911F000E9;
 Thu, 23 Jul 2026 08:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784795752;
 bh=GSSOyApKAcWbRJFg7GKzkYuOClt+Mi8ARlACiQScwzU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VGeBx8EIrWgrYSKDm8OoZFspoxXVtuaq5X7kwV0d2aE8mC71ReFudAh1LwIzTrvS0
 DGshZb0rlWu5T6LUerk6MBJfPQdY+MrdG3uWascL09+otiqOZ6wTWajIO1x0+9zDTD
 5Tb0e2005Gyq6vxrMVYKSoc3hGbSzmfC/loeuA9QHVUtiyZ8uVpmKZA7a946bmqAZ7
 saxbbFg7Svp4dxvSjUv24RGPt2SelN/8bPyMFd0DzC2mAfXX61kYhOuW5Us89UY5AU
 1Q06WVjZ2ttz9nHRXavM+siiHKcXogJPs58MCE2O5+b3OhJRRb49p0nwMphylOgD30
 CKwgEKa7f1O8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] RDMA/cxgb4: remove dead NULL checks after
 GFP_NOFAIL allocations
To: "Gou Hao" <gouhao@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723081813.176792-5-gouhao@uniontech.com>
References: <20260723081813.176792-1-gouhao@uniontech.com>
 <20260723081813.176792-5-gouhao@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 08:35:51 +0000
Message-Id: <20260723083552.774911F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Fallback error path and chunking in `_c4iw_write_mem_dma` and `wri=
te_adapter_mem` trigger a use-after-free on caller-provided SKBs.
- [High] Unconditional double-free of `mhp->dereg_skb` in the error path of=
 `c4iw_alloc_mr`.
--

--- Patch [4]: [PATCH 4/4] RDMA/cxgb4: remove dead NULL checks after GFP_NO=
FAIL allocations ---
commit 2b81b1933eb1e926287199e29810f5bc991be785
Author: Gou Hao <gouhao@uniontech.com>

RDMA/cxgb4: remove dead NULL checks after GFP_NOFAIL allocations
   =20
alloc_skb() with the __GFP_NOFAIL flag will never return NULL,
so the subsequent NULL checks and error handling are unreachable
dead code. Remove them.

> diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cx=
gb4/mem.c
> index cd1b010141984..08631de17c0a3 100644
> --- a/drivers/infiniband/hw/cxgb4/mem.c
> +++ b/drivers/infiniband/hw/cxgb4/mem.c
> @@ -74,11 +74,8 @@ static int _c4iw_write_mem_dma_aligned(struct c4iw_rde=
v *rdev, u32 addr,
>  		c4iw_init_wr_wait(wr_waitp);
>  	wr_len =3D roundup(sizeof(*req) + sizeof(*sgl), 16);
> =20
> -	if (!skb) {
> +	if (!skb)
>  		skb =3D alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
> -		if (!skb)
> -			return -ENOMEM;
> -	}
>  	set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
related to how these skb pointers are passed in from caller functions.

Looking at _c4iw_write_mem_dma(), the chunking loop reuses the caller's skb
for multiple offload sends:

drivers/infiniband/hw/cxgb4/mem.c:_c4iw_write_mem_dma() {
    ...
	while (remain > inline_threshold) {
		// ...
		ret =3D _c4iw_write_mem_dma_aligned(rdev, addr, dmalen, daddr,
						 skb, remain ? NULL : wr_waitp);
		// ...
	}
	if (remain)
		ret =3D _c4iw_write_mem_inline(rdev, addr, remain, data, skb,
					     wr_waitp);
    ...
}

Since the first call to _c4iw_write_mem_dma_aligned() (or
_c4iw_write_mem_inline()) hands the skb to c4iw_ofld_send() which consumes =
it,
doesn't reusing this same skb pointer in subsequent loop iterations or the
remainder fallback trigger a use-after-free?

Similarly, in write_adapter_mem(), the fallback logic reuses the skb pointer
after _c4iw_write_mem_dma() has potentially consumed it during a failed
offload send:

drivers/infiniband/hw/cxgb4/mem.c:write_adapter_mem() {
    ...
	ret =3D _c4iw_write_mem_dma(rdev, addr, len, data, skb, wr_waitp);
	if (ret) {
		pr_warn_ratelimited("%s: dma map failure (non fatal)\n",
				    pci_name(rdev->lldi.pdev));
		ret =3D _c4iw_write_mem_inline(rdev, addr, len, data, skb,
					      wr_waitp);
	}
    ...
}

Could this fallback also result in a use-after-free if the skb was consumed
before the error was returned?

> =20
>  	req =3D __skb_put_zero(skb, wr_len);
[ ... ]
> @@ -134,11 +131,8 @@ static int _c4iw_write_mem_inline(struct c4iw_rdev *=
rdev, u32 addr, u32 len,
>  					 roundup(copy_len, T4_ULPTX_MIN_IO),
>  				 16);
> =20
> -		if (!skb) {
> +		if (!skb)
>  			skb =3D alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
> -			if (!skb)
> -				return -ENOMEM;
> -		}

[Severity: High]
This is also a pre-existing issue, but there appears to be a double-free
involving dereg_skb in the error path of c4iw_alloc_mr().

When finish_mem_reg() fails, it jumps to err_dereg_mem and calls dereg_mem()
with mhp->dereg_skb. This eventually passes the skb to c4iw_ofld_send()
which takes ownership of the skb.

drivers/infiniband/hw/cxgb4/mem.c:c4iw_alloc_mr() {
    ...
err_dereg_mem:
	dereg_mem(&rhp->rdev, mhp->attr.stag, mhp->attr.pbl_size,
		  mhp->attr.pbl_addr, mhp->dereg_skb, mhp->wr_waitp);
err_free_skb:
	kfree_skb(mhp->dereg_skb);
    ...
}

After dereg_mem() returns, the error path unconditionally calls kfree_skb()
on mhp->dereg_skb.

Does this unconditionally double-free the skb after it has already been han=
ded
off to the network stack?

>  		set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
> =20
>  		req =3D __skb_put_zero(skb, wr_len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723081813.1767=
92-1-gouhao@uniontech.com?part=3D4
