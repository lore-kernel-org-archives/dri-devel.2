Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2324AC531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 02:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED3E10E626;
	Fri, 24 Jul 2026 02:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kgbF6VEz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6924E10E626
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 02:53:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D7A9600AA;
 Fri, 24 Jul 2026 02:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E261F000E9;
 Fri, 24 Jul 2026 02:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784861606;
 bh=jSLBsTOzUhyQsdEyvbAojDMMdpeIZF3IIz1pUlCce80=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kgbF6VEzpyLiD/W8nxKEv2FpBu0zfCQoHQImVU48Omy67PMAzTQ0818cJzVM0Rnl/
 pRRbKMCyu0FgwNADENH6W2u4fE8C+/kOoZ+4mm4R+m+yAcsNckY8DStz028WHhQ3mA
 yD3BGKoCwAkVUOZJT0G4kVkrw41ZjkgFCQZULjA/pMNlUPXhB/tZIzj3dBQsTN4fbs
 asTHg2mOWawSo70KniHoMO9Esd/eb5O5v/idEg21PavHWNxBHAkEMUsjkwfkkPJDKe
 CUXS3A7nN0wqMgnOexFQjTz8CiAHhbCQJyIcVzSWdZvyRkYwv8KcdIL6FmP73hyabv
 l5dYes+5Igvng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] RDMA/cxgb4: remove dead NULL checks after
 GFP_NOFAIL allocations
To: "Gou Hao" <gouhao@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724022851.466017-7-gouhao@uniontech.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
 <20260724022851.466017-7-gouhao@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 02:53:25 +0000
Message-Id: <20260724025326.28E261F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double free of `mhp->dereg_skb` in MR allocation error paths (`c4i=
w_get_dma_mr`).
- [Medium] `write_adapter_mem()` passes an already freed skb to `_c4iw_writ=
e_mem_inline()` if `_c4iw_write_mem_dma()` fails.
- [Medium] Leaked `mhp->dereg_skb` in `c4iw_dereg_mr()` during device fatal=
 error.
--

--- Patch [6]: [PATCH v2 6/6] RDMA/cxgb4: remove dead NULL checks after GFP=
_NOFAIL allocations ---
commit 8aa6275ceca7a8b20e9109cfd6059d14769af15d
Author: Gou Hao <gouhao@uniontech.com>

RDMA/cxgb4: remove dead NULL checks after GFP_NOFAIL allocations

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
> =20
>  	req =3D __skb_put_zero(skb, wr_len);
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
>  		set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
> =20
>  		req =3D __skb_put_zero(skb, wr_len);

[ ... ]

> static int write_adapter_mem(struct c4iw_rdev *rdev, u32 addr, u32 len,
> 			     void *data, struct sk_buff *skb,
> 			     struct c4iw_wr_wait *wr_waitp)
> {
[ ... ]
> 	ret =3D _c4iw_write_mem_dma(rdev, addr, len, data, skb, wr_waitp);
> 	if (ret) {
> 		pr_warn_ratelimited("%s: dma map failure (non fatal)\n",
> 				    pci_name(rdev->lldi.pdev));
> 		ret =3D _c4iw_write_mem_inline(rdev, addr, len, data, skb,
> 					      wr_waitp);
> 	}
> out:
> 	return ret;
>=20
> }

[Severity: Medium]
This isn't a bug introduced by this patch, but does the error handling path
here pass an already freed skb to _c4iw_write_mem_inline()?

If _c4iw_write_mem_dma() encounters a transmission error (e.g., c4iw_ofld_s=
end
fails), the network layer will consume and free the skb.

Does write_adapter_mem() incorrectly assume any error from the DMA function=
 is
a non-fatal mapping error, and fall back to _c4iw_write_mem_inline() passing
the exact same freed skb pointer?

[ ... ]

> struct ib_mr *c4iw_get_dma_mr(struct ib_pd *pd, int acc)
> {
[ ... ]
> 	ret =3D write_tpt_entry(&rhp->rdev, 0, &stag, 1, php->pdid,
> 			      FW_RI_STAG_NSMR, mhp->attr.perms,
> 			      mhp->attr.mw_bind_enable, 0, 0, ~0ULL, 0, 0, 0,
> 			      NULL, mhp->wr_waitp);
> 	if (ret)
> 		goto err_free_skb;
>=20
> 	ret =3D finish_mem_reg(mhp, stag);
> 	if (ret)
> 		goto err_dereg_mem;
> 	return &mhp->ibmr;
> err_dereg_mem:
> 	dereg_mem(&rhp->rdev, mhp->attr.stag, mhp->attr.pbl_size,
> 		  mhp->attr.pbl_addr, mhp->dereg_skb, mhp->wr_waitp);
> err_free_skb:
> 	kfree_skb(mhp->dereg_skb);
> err_free_wr_wait:

[Severity: High]
This is a pre-existing issue, but does this error path cause a double-free
of mhp->dereg_skb?

In c4iw_get_dma_mr(), if finish_mem_reg() fails, the error handling path ca=
lls
dereg_mem() with the pre-allocated mhp->dereg_skb. dereg_mem() passes this =
skb
to the network stack, where functions like c4iw_ofld_send() assume ownership
and unconditionally consume and free the skb.

When dereg_mem() returns, the error path unconditionally falls through to t=
he
err_free_skb label and executes kfree_skb(mhp->dereg_skb) on the already-fr=
eed
pointer.

[ ... ]

> int c4iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
> {
[ ... ]
> 	dereg_mem(&rhp->rdev, mhp->attr.stag, mhp->attr.pbl_size,
> 		  mhp->attr.pbl_addr, mhp->dereg_skb, mhp->wr_waitp);
> 	if (mhp->attr.pbl_size)
> 		c4iw_pblpool_free(&mhp->rhp->rdev, mhp->attr.pbl_addr,
> 				  mhp->attr.pbl_size << 3);
> 	if (mhp->kva)
> 		kfree((void *) (unsigned long) mhp->kva);
> 	ib_umem_release(mhp->umem);
> 	pr_debug("mmid 0x%x ptr %p\n", mmid, mhp);
> 	c4iw_put_wr_wait(mhp->wr_waitp);
> 	kfree(mhp);
> 	return 0;
> }

[Severity: Medium]
This is a pre-existing issue, but does this function leak mhp->dereg_skb if
the device is in a fatal error state?

c4iw_dereg_mr() passes mhp->dereg_skb to dereg_mem() to deregister the memo=
ry
region, assuming the network stack will consume and free the skb.

However, if the device is in a fatal error state, write_tpt_entry()
immediately aborts and returns -EIO before the skb is handed to the network
layer, leaving it unconsumed:

drivers/infiniband/hw/cxgb4/mem.c:write_tpt_entry() {
	if (c4iw_fatal_error(rdev))
		return -EIO;
    ...
}

Because c4iw_dereg_mr() ignores the return value of dereg_mem() and
unconditionally frees the mhp structure, does it permanently leak the
unconsumed skb?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724022851.4660=
17-1-gouhao@uniontech.com?part=3D6
