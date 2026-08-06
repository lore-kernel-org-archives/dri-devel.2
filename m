Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737AEC56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D927010F2AB;
	Thu,  6 Aug 2026 20:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OoL8luBG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C0910E3B3
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 20:43:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0290643B33;
 Thu,  6 Aug 2026 20:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEF21F000E9;
 Thu,  6 Aug 2026 20:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786049004;
 bh=33varXzfsNU7B2tRjhMGfbEHKr44GM7wZpXAzMNDKmo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OoL8luBGM9uEmiMSiw8g/Fqj3b6x/DX6aNkufDL0z+z6hNrd4fVqurOvu/0gvWswL
 joMlStJwj4t8drR7JCcbpGD2bSd91rSeejFLcM9+me4DOjebNeEmXw0v4PKlMC7Coz
 zRB4JyxdO3GP9RGWTypDiBNCfDQozCyJecF1RNL/7PRxI3udZh9Cc3gRUkI60PEFFY
 JtoEAOMN45rPIfPyKIgptuZwqPHXXcgktmZYxYjLXBK6LW1SkmfDn79Ww5PubcPhAZ
 0YN0+UzIh2WVMTfGrfcK/PROzNWQoYnC8eKAnGUjA3WxMnsDRv9I48DAlUrvIeCCps
 td0572qKVytxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8 1/3] net: devmem: allow rx-page-size >
 PAGE_SIZE per dmabuf binding
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260805-tcpdm-large-niovs-v8-1-3e0225e2808c@meta.com>
References: <20260805-tcpdm-large-niovs-v8-0-3e0225e2808c@meta.com>
 <20260805-tcpdm-large-niovs-v8-1-3e0225e2808c@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 20:43:24 +0000
Message-Id: <20260806204324.ACEF21F000E9@smtp.kernel.org>
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
- [High] Truncation of 64-bit DMA addresses to 32-bit unsigned long causes =
allocator state and memory corruption.
- [High] Valid DMA address 0 is treated as an allocation failure, causing a=
 permanent resource leak and kernel panic.
--

--- Patch [1]: [PATCH net-next v8 1/3] net: devmem: allow rx-page-size > PA=
GE_SIZE per dmabuf binding ---
commit aedd523e1f497a9daaf91448a092f69629705696
Author: Bobby Eshleman <bobbyeshleman@meta.com>

net: devmem: allow rx-page-size > PAGE_SIZE per dmabuf binding

This commit introduces a netlink attribute to allow setting a larger
dmabuf rx-page-size for the page_pool. The value must be a power of two
and greater than or equal to PAGE_SIZE.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 957d6b96216b3..f4d60654ce7fd 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
[ ... ]
> @@ -87,13 +93,14 @@ struct net_iov *
>  net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  {
>  	struct dmabuf_genpool_chunk_owner *owner;
>  	unsigned long dma_addr;
>  	struct net_iov *niov;
>  	ssize_t offset;
>  	ssize_t index;
> =20
> -	dma_addr =3D gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
> +	dma_addr =3D gen_pool_alloc_owner(binding->chunk_pool,
> +					1UL << binding->niov_shift,
>  					(void **)&owner);
>  	if (!dma_addr)
>  		return NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does this check incorrectly
handle a valid allocation when the dmabuf is mapped at DMA address 0?

Since gen_pool_alloc_owner() can return 0 on success if the chunk starts at
virtual address 0, checking for !dma_addr might treat a valid DMA address 0
as an allocation failure.

This could cause the allocation to leak in the pool without a tracking net_=
iov.
Later, when the dmabuf is unbound, gen_pool_destroy() will check that all
chunks are free and could hit a BUG_ON if this allocation was leaked.

> =20
>  	offset =3D dma_addr - owner->base_dma_addr;
> -	index =3D offset / PAGE_SIZE;
> +	index =3D offset >> binding->niov_shift;
>  	niov =3D &owner->area.niovs[index];

[Severity: High]
This is a pre-existing issue, but can this lead to an out-of-bounds array
access on 32-bit platforms with 64-bit DMA addresses (e.g., LPAE/PAE)?

Since dma_addr is derived from gen_pool_alloc_owner(), which returns an
unsigned long, it will be a 32-bit value on 32-bit systems.

If base_dma_addr is 64-bit and the actual address is above 4GB, the truncat=
ed
dma_addr subtracted from the 64-bit base_dma_addr would result in a massive
underflow.

Could this huge offset result in indexing out of bounds when initializing
niovs[index]?

[ ... ]
> @@ -288,7 +295,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *=
vdev,
> =20
>  		owner->area.base_virtual =3D virtual;
>  		owner->base_dma_addr =3D dma_addr;
> -		owner->area.num_niovs =3D len / PAGE_SIZE;
> +		owner->area.num_niovs =3D len >> niov_shift;
>  		owner->binding =3D binding;
> =20
>  		err =3D gen_pool_add_owner(binding->chunk_pool, dma_addr,
>  					 dma_addr, len, dev_to_node(&dev->dev),
>  					 owner);

[Severity: High]
This isn't a bug introduced by this patch, but does calling
gen_pool_add_owner() silently truncate the 64-bit DMA address on 32-bit
systems?

The gen_pool_add_owner() function takes an unsigned long for the virt
argument. When passing dma_addr_t dma_addr on 32-bit architectures, this
might truncate the upper 32 bits of the DMA address.

If a DMA address exceeds 4GB, could this truncation cause overlapping virtu=
al
address ranges in the gen_pool?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-tcpdm-larg=
e-niovs-v8-0-3e0225e2808c@meta.com?part=3D1
