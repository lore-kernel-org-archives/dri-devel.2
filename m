Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4285C5516F
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 00:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044A710E167;
	Sat,  1 Aug 2026 00:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S6ONTH0F";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F056E10E167
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 00:33:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D782540DB4;
 Sat,  1 Aug 2026 00:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B841F00AC4;
 Sat,  1 Aug 2026 00:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785544385;
 bh=8vx+LdQaZUSQH9Y1ncNlbKME+Sk1HJqKl5lcpgonB4g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S6ONTH0F7qNme32f9jMC8h8ECCKWTUcZcK/9VMWJUDJ/VGfscC6NnCoCXoV5806IL
 r5HXeD7VDly3i9YFg9Uot/sSDnGQiRMqP68fqcQeXVA930J3hy1exbqZ+aTLMv7zhb
 iKX4pKYogT9pYpDXh2mcoQAr8J2KiuCH3U5pnJIKEQ6bq0wHt9t0oe28oVCc7AODBe
 YUA5rDGiCUH+3yvEJkdW30FfjXe6aXNErY/OnqZW6c5atzGKFmLpDyXXHPlfckW4QQ
 VnzuZpI0nj+oOvg+yuvS1r2ZDWXE+W3PfXOXx2r/Zi7AUcHK3AVRYFm3rSVts3gPfc
 oOGyK2TlxBJHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 1/3] net: devmem: allow rx-page-size >
 PAGE_SIZE per dmabuf binding
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260730-tcpdm-large-niovs-v7-1-033d580a619d@meta.com>
References: <20260730-tcpdm-large-niovs-v7-0-033d580a619d@meta.com>
 <20260730-tcpdm-large-niovs-v7-1-033d580a619d@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 00:33:05 +0000
Message-Id: <20260801003305.84B841F00AC4@smtp.kernel.org>
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

New issues:
- [Critical] Mismatch between `dmabuf->size` alignment check and `niov_shif=
t` allocation causes zero-sized allocations and heap out-of-bounds writes.
- [High] Arithmetic right shift of a negative `ssize_t` causes out-of-bound=
s array access for dmabuf chunks larger than 2GB.

Pre-existing issues:
- [High] Truncation of 64-bit `dma_addr_t` to 32-bit `unsigned long` corrup=
ts chunk address tracking, causing memory leaks.
--

--- Patch [1]: [PATCH net-next v7 1/3] net: devmem: allow rx-page-size > PA=
GE_SIZE per dmabuf binding ---
commit 721bc7584b49aea3874dba5c8bcb4896d26b75ed
Author: Bobby Eshleman <bobbyeshleman@meta.com>

net: devmem: allow rx-page-size > PAGE_SIZE per dmabuf binding

Every devmem dmabuf binding today hands the page_pool PAGE_SIZE niovs.
This caps a single RX descriptor at PAGE_SIZE, burning CPU on buffer
churn for large flows.

Add a bind-time netlink attribute, NETDEV_A_DMABUF_RX_PAGE_SIZE, that
lets userspace request a larger niov size. The value must be a power of
two >=3D PAGE_SIZE.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
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

[Severity: High]
Will this right shift perform an arithmetic shift when offset is negative?

In net_devmem_alloc_dmabuf(), offset is declared as ssize_t (a 32-bit signed
integer on 32-bit architectures). For a DMA chunk larger than 2GB, the
difference between dma_addr and owner->base_dma_addr will overflow into a
negative value.

Previously, offset / PAGE_SIZE would implicitly promote offset to unsigned
long because PAGE_SIZE is unsigned, yielding the correct positive index. By
changing this to a right shift by binding->niov_shift, the result of the
shift retains the signed type of the left operand (ssize_t). Right-shifting
a negative signed value performs sign extension, resulting in a negative
index.

Could this lead to an out-of-bounds access on owner->area.niovs[index]?

>  	niov =3D &owner->area.niovs[index];
> =20
>  	niov->desc.pp_magic =3D 0;

[ ... ]

> @@ -113,12 +114,13 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
>  {
>  	struct net_devmem_dmabuf_binding *binding =3D net_devmem_iov_binding(ni=
ov);
>  	unsigned long dma_addr =3D net_devmem_get_dma_addr(niov);
> +	size_t niov_size =3D 1UL << binding->niov_shift;
> =20
>  	if (WARN_ON(!gen_pool_has_addr(binding->chunk_pool, dma_addr,
> -				       PAGE_SIZE)))
> +				       niov_size)))

[Severity: High]
This is a pre-existing issue, but can the 64-bit dma_addr be truncated here
on 32-bit systems?

In net_devmem_free_dmabuf(), the 64-bit return value from
net_devmem_get_dma_addr() is assigned to an unsigned long dma_addr and pass=
ed
to gen_pool_has_addr().

A similar truncation occurs in net_devmem_bind_dmabuf() where
sg_dma_address(sg) is passed to the unsigned long virt parameter of
gen_pool_add_owner().

On 32-bit systems with PAE/LPAE, dma_addr_t is 64-bit. If the original 64-b=
it
address plus the chunk size crosses a 4GB boundary, the truncated 32-bit
end_addr in gen_pool wraps around, breaking the bounds check in
gen_pool_has_addr(). This causes the teardown path to trigger the WARN_ON
and abort without freeing the chunk.

Does this cause a permanent memory leak?

>  		return;
> =20
> -	gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> +	gen_pool_free(binding->chunk_pool, dma_addr, niov_size);
>  }

[ ... ]

> @@ -248,18 +256,14 @@ net_devmem_bind_dmabuf(struct net_device *dev, void=
 *vdev,
>  			goto err_unmap;
>  		}
>  		binding->tx_vec =3D kvmalloc_objs(struct net_iov *,
> -						dmabuf->size / PAGE_SIZE);
> +						dmabuf->size >> niov_shift);

[Severity: Critical]
Can tx_vec be allocated as a zero-sized array here?

In net_devmem_bind_dmabuf(), the alignment check prior to this allocation
still verifies that dmabuf->size is a multiple of PAGE_SIZE rather than
niov_size:

	if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
		err =3D -EINVAL;
		NL_SET_ERR_MSG(extack, "TX dma-buf size must be a multiple of PAGE_SIZE");
		goto err_unmap;
	}

If userspace binds a dmabuf where PAGE_SIZE <=3D dmabuf->size < niov_size (=
for
example, 4K size with 64K niov_size), this check will pass, but the tx_vec
allocation (dmabuf->size >> niov_shift) will allocate 0 elements.

Later, if the exporter padded the scatterlist segment to niov_size, the
scatterlist parsing loop computes owner->area.num_niovs =3D 1 and writes to
tx_vec[0].

Could this result in a heap out-of-bounds write?

>  		if (!binding->tx_vec) {
>  			err =3D -ENOMEM;
>  			goto err_unmap;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-tcpdm-larg=
e-niovs-v7-0-033d580a619d@meta.com?part=3D1
