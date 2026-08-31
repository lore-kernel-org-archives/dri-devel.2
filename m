Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D62C61DF0
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C3E10E609;
	Mon, 31 Aug 2026 06:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l3+nvp3w";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8203A10E608
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 06:14:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05F3F42AD1;
 Mon, 31 Aug 2026 06:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD25D1F000E9;
 Mon, 31 Aug 2026 06:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788156854;
 bh=G50AZ2fGwZqFH6Vx0awYjOHi8KUIatBOxrKeXV6NFkg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l3+nvp3wRdBNlI1MhJhVEaNmbQp9NWDkn+4QdBGopAqUWHPZbNwWKoKv7m8VV9ZiG
 Z09O58wX52N+AyWO7hVBdtE9KlhxwTzl62Dl45D6l3YzjAH3VpGIGzRNB4xkXdMrWu
 KHj6EkUMMjo18mZBVyvhsIqeXjaDWa7KK+WZe7qTqOnRfKly6zwu50pl0k/GJawKXJ
 V+vxleonAnxxKtDLX3kVlidRRqq27pZuQ+zCgtthzLEGFKXAV1AIgwQYoE4INM3tjj
 ueZy3EpUG3CnS3kBOglKmLYG42arUpx6SGVFx6nVftTeEeuV7ZguiyTDtxoEgS2pgt
 bO6dRBoijtuJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] udmabuf: Add mlock accounting for udmabuf
 pages/folios
To: "Vivek Kasireddy" <vivek.kasireddy@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831060210.1713177-3-vivek.kasireddy@intel.com>
References: <20260831060210.1713177-1-vivek.kasireddy@intel.com>
 <20260831060210.1713177-3-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:14:14 +0000
Message-Id: <20260831061414.BD25D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] deinit_udmabuf() triggers UAF and mlock leak by improperly targeti=
ng the releasing task's ucounts instead of the creator's.
- [High] Integer overflow in `pgcnt << PAGE_SHIFT` on 32-bit systems bypass=
es RLIMIT_MEMLOCK validation.
- [High] Mlock quota leak when `udmabuf_pin_folios` successfully pins fewer=
 pages than requested.

Pre-existing issues:
- [Critical] Integer overflow in `pgcnt +=3D subpgcnt` on 32-bit systems ca=
uses severe Heap Buffer Overflow during pinning.
--

commit 80f5d1e351e60ace6655d7afd00204458578dbbb
Author: Vivek Kasireddy <vivek.kasireddy@intel.com>

udmabuf: Add mlock accounting for udmabuf pages/folios

This commit introduces mlock accounting for udmabuf pages and folios to
prevent unprivileged users from exhausting system memory. It tracks and lim=
its
pinned memory by checking the user's mlock limits via user_shm_lock().

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 7c4339130eff7..e78947f01656d 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -203,9 +203,10 @@ static __always_inline int init_udmabuf(struct udmab=
uf *ubuf, pgoff_t pgcnt)
>  	return 0;
>  }
> =20
> -static __always_inline void deinit_udmabuf(struct udmabuf *ubuf)
> +static __always_inline void deinit_udmabuf(struct udmabuf *ubuf, pgoff_t=
 pgcnt)
>  {
>  	unpin_all_folios(ubuf);
> +	user_shm_unlock(pgcnt << PAGE_SHIFT, current_ucounts());

[Severity: High]
Does this code safely handle unlocking the mlock quota when the dma_buf is
released by a different task?

The dma_buf release callback executes the deinit logic in an arbitrary task
context. Passing current_ucounts() to user_shm_unlock() in this context dro=
ps
a reference on an unrelated ucounts, which can lead to a use-after-free.

This also permanently leaks the original creator's mlock quota, since the
creator's ucounts is locked during creation but never saved in the ubuf
structure for teardown.

>  	kvfree(ubuf->pages);
>  }
> =20
> @@ -217,7 +218,7 @@ static void release_udmabuf(struct dma_buf *buf)
>  	if (ubuf->sg)
>  		put_sg_table(dev, ubuf->sg, ubuf->sg_dir);
> =20
> -	deinit_udmabuf(ubuf);
> +	deinit_udmabuf(ubuf, ubuf->pagecount);

[Severity: High]
Does this successfully unlock the entire mlock quota if udmabuf_pin_folios()
stops early and updates ubuf->pagecount?

During creation, user_shm_lock() locks the requested pgcnt. If a memfd is
smaller than requested, udmabuf_pin_folios() pins fewer pages and overwrites
the requested count:

    ubuf->pagecount =3D upgcnt;

When the buffer is later released, unlocking only the successfully pinned
pages abandons the remaining locked quota, permanently leaking the unpinned
mlock delta.

>  	kfree(ubuf);
>  }
> =20
> @@ -385,6 +386,15 @@ static long udmabuf_create(struct miscdevice *device,
>  	if (!pgcnt)
>  		goto err_noinit;
> =20

[Severity: Critical]
This is a pre-existing issue, but can the 32-bit pgcnt accumulation wrap
around and bypass limits?

In the loop calculating the total pages:

    subpgcnt =3D list[i].size >> PAGE_SHIFT;
    pgcnt +=3D subpgcnt;

If a user passes multiple items that cause pgcnt to wrap around to a small
value, the check against pglimit passes. This small wrapped total is then
passed to init_udmabuf(), which allocates tiny heap arrays based on the
wrapped 32-bit total.

Later, when udmabuf_pin_folios() executes, it loops using the non-truncated
per-item size, writing millions of pointers out of bounds of the undersized
allocation:

    ubuf->pages[upgcnt] =3D folio_page(folios[cur_folio],
                                     subpgoff >> PAGE_SHIFT);

> +	if (!user_shm_lock(pgcnt << PAGE_SHIFT, current_ucounts())) {

[Severity: High]
Does the bitwise shift on the 32-bit pgcnt value overflow on 32-bit systems?

If a user requests an allocation of exactly 4GB, pgcnt becomes 0x100000.
Shifting this by PAGE_SHIFT yields 0 on 32-bit architectures. This instantly
succeeds the zero-byte lock check while successfully pinning the full 4GB of
physical memory, bypassing the RLIMIT_MEMLOCK validation.

> +		pr_warn_once("%s: User not permitted to pin more than %lu KB "
> +			     "of memory, either increase ulimits -l, or "
> +			     "obtain CAP_IPC_LOCK capability\n", current->comm,
> +			     rlimit(RLIMIT_MEMLOCK) >> 10);
> +		ret =3D -EPERM;
> +		goto err_noinit;
> +	}
> +
>  	ret =3D init_udmabuf(ubuf, pgcnt);
>  	if (ret)
>  		goto err;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831060210.1713=
177-1-vivek.kasireddy@intel.com?part=3D2
