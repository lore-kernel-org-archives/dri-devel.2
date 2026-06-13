Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95C0CD98D8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 16:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A6810EE08;
	Sat, 13 Jun 2026 16:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nLNh8/ZR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9748610EE08
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 16:28:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AE67C6008A;
 Sat, 13 Jun 2026 16:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE481F000E9;
 Sat, 13 Jun 2026 16:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781368100;
 bh=wI6ijXjr4Sp4+1hR0AC6hRv5TNJ9V+BFzUUp5wYaDfM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nLNh8/ZRLkKe4IQ260CRKPOdllFbtGjkYVgnzS/V9ScpjgCgbeAxAgPCzUF9JIZUv
 534wkyRxicaZWUjPYeSqguBMuSKfLZbLsNltFGRj3W+yaWBkPaPwZLW+HPm6f7hzR+
 MDpPlGS1etEQysWdH/fKFF3OaMlsCYehUweZFM/uExWMFw5gj5YtP52I4xF0QKT2zH
 kJz3RUe4tGYSDzTGEgnsrSoLdqkO9076hUTY3sLtcyFEXPicN8olvWkwPTfF/8Etay
 6500mYnUOoF7Cv1oZNOFASWqjDGAk4WlX4PI3Fq+HaZ94O2jBPUY4OGxMF0yIaufTu
 C0+KrGdyVKwVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/4] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612-tcpdm-large-niovs-v3-1-a3b693e76fcb@meta.com>
References: <20260612-tcpdm-large-niovs-v3-1-a3b693e76fcb@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 16:28:19 +0000
Message-Id: <20260613162820.2CE481F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Integer overflow and signedness bug leading to a negative arra=
y index and out-of-bounds memory corruption on 32-bit architectures.

Pre-existing issues:
- [High] Sleeping in atomic context due to kvfree() inside an RCU read-side=
 critical section.
--

commit b8e27f9eee44549dc6869beb99adddc8150160f6
Author: Bobby Eshleman <bobbyeshleman@meta.com>

net: devmem: allow rx-buf-size > PAGE_SIZE per dmabuf binding

Every devmem dmabuf binding today hands the page_pool PAGE_SIZE niovs.
This caps a single RX descriptor at PAGE_SIZE, burning CPU on buffer
churn for large flows.

Add a bind-time netlink attribute, NETDEV_A_DMABUF_RX_BUF_SIZE, that
lets userspace request a larger niov size. The value must be a power of
two >=3D PAGE_SIZE.

[ ... ]

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 957d6b96216b3..3ce3cc14bec07 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -93,13 +93,14 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_bind=
ing *binding)
>  	ssize_t offset;
>  	ssize_t index;
> =20
> -	dma_addr =3D gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
> +	dma_addr =3D gen_pool_alloc_owner(binding->chunk_pool,
> +					1UL << binding->niov_shift,
>  					(void **)&owner);
>  	if (!dma_addr)
>  		return NULL;
> =20
>  	offset =3D dma_addr - owner->base_dma_addr;
> -	index =3D offset / PAGE_SIZE;
> +	index =3D offset >> binding->niov_shift;

[Severity: Critical]
Does this bitwise shift cause a negative array index on 32-bit architecture=
s?

Since a dma-buf scatterlist entry size (len) can be up to 4GB-1, the offset=
=20
within a chunk can be >=3D 2GB. On 32-bit architectures, ssize_t is a 32-bi=
t=20
signed integer, so an offset >=3D 2GB overflows and becomes negative.

In the original code, the division promoted offset to an unsigned long=20
because PAGE_SIZE is unsigned, resulting in a correct positive index:

    index =3D offset / PAGE_SIZE;

However, the type of a bitwise shift result is determined solely by the=20
promoted left operand. By changing this to a bitwise right shift:

    index =3D offset >> binding->niov_shift;

the result remains signed. An arithmetic right shift of a negative number=20
produces a negative index, which can lead to an out-of-bounds write on=20
owner->area.niovs[index] later in the function.

>  	niov =3D &owner->area.niovs[index];
> =20
>  	niov->desc.pp_magic =3D 0;

[ ... ]

> @@ -273,9 +277,12 @@ net_devmem_bind_dmabuf(struct net_device *dev, void =
*vdev,
>  		size_t len =3D sg_dma_len(sg);
>  		struct net_iov *niov;
> =20
> -		if (!IS_ALIGNED(len, PAGE_SIZE)) {
> +		if (!IS_ALIGNED(dma_addr, niov_size) ||
> +		    !IS_ALIGNED(len, niov_size)) {
>  			err =3D -EINVAL;
> -			NL_SET_ERR_MSG(extack, "dma-buf SG length must be PAGE_SIZE aligned");
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "dmabuf sg entry (addr=3D%pad, len=3D%zu) not aligned to niov si=
ze %zu",
> +					   &dma_addr, len, niov_size);
>  			goto err_free_chunks;

[Severity: High]
This is a pre-existing issue, but can this error path lead to a panic by=20
sleeping in atomic context?

When goto err_free_chunks is taken, the error path handles cleanup using=20
gen_pool_for_each_chunk(), which iterates over chunks with rcu_read_lock()=
=20
held:

lib/genalloc.c:gen_pool_for_each_chunk() {
    rcu_read_lock();
    list_for_each_entry_rcu(chunk, &(pool)->chunks, next_chunk)
        func(pool, chunk, data);
    rcu_read_unlock();
}

The callback net_devmem_dmabuf_free_chunk_owner() then frees the memory:

net/core/devmem.c:net_devmem_dmabuf_free_chunk_owner() {
    ...
    kvfree(owner->area.niovs);
    ...
}

If the allocated array is large enough to use the vmalloc fallback, kvfree(=
)=20
internally invokes vfree(). Since vfree() is not allowed in atomic context=
=20
and calls might_sleep(), won't this trigger a 'scheduling while atomic' bug=
=20
when the RCU read-side critical section is held?

>  		}
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-tcpdm-larg=
e-niovs-v3-0-a3b693e76fcb@meta.com?part=3D1
