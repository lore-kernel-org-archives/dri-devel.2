Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EADDC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B9110E13A;
	Fri, 10 Jul 2026 07:27:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M4+agpuK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79CCC10F7D6
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:27:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F47C43926;
 Fri, 10 Jul 2026 07:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC57B1F000E9;
 Fri, 10 Jul 2026 07:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783668432;
 bh=BrW9k7dfqdBFuh3Iiqvbuav2ASLBmuES+QRpj2ZXIBI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M4+agpuK7HRlIvIi7qHm5HFXuUu+Me4ikddgG3SR/PsxlQuo86HuMWVcMFfHGG4M7
 GJLjEXQ2AisyJUvNP7i6nrNIskB+60d5ZcbRlNipk5uNqvaSqVIBn0RgfOH3JSCm0A
 j6U7suyBtaq0qRR+pU7+4znRB6i6h2rnMqhJaop0+ZPt53FVVAz9FSSDs0l6MLWF55
 dZTHOXCCCNB4R2yPMyhiANSkOSlTMjlsbpF8yxt0m+TSPtAqj5h+rMlpV31av/yRJ0
 xBEdKGHpreduc3zvYWZ8vjw4jvCKcZRul6uA/RvsdGt80WkZAEpMl98bZok2lWHG7j
 ebgg6YyN+jmbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708-tcpdm-large-niovs-v5-1-34bf6fac941b@meta.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-1-34bf6fac941b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 07:27:12 +0000
Message-Id: <20260710072712.BC57B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] On 32-bit architectures with 64-bit DMA addresses (e.g., CONFIG_AR=
CH_DMA_ADDR_T_64BIT), passing `dma_addr_t` to `gen_pool` functions truncate=
s the DMA address to 32 bits, leading to broken bit allocations, leaked chu=
nks, and possible data corruption.
--

--- Patch [1]: [PATCH net-next v5 1/3] net: devmem: allow rx-buf-size > PAG=
E_SIZE per dmabuf binding ---
commit 700c87449a5348e02d33589504f632f46bed92e7
Author: Bobby Eshleman <bobbyeshleman@meta.com>

net: devmem: allow rx-buf-size > PAGE_SIZE per dmabuf binding

This commit introduces the NETDEV_A_DMABUF_RX_BUF_SIZE netlink attribute.
It allows userspace to request an RX buffer size larger than PAGE_SIZE
for devmem dmabuf bindings, avoiding CPU churn for large flows.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 957d6b96216b3..3ce3cc14bec07 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
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

[Severity: High]
This is a pre-existing issue, but can this truncate the DMA address?=20
Looking at net_devmem_free_dmabuf() in net/core/devmem.c, dma_addr is
derived as a dma_addr_t (which can be 64-bit), but is passed to
gen_pool_has_addr() and gen_pool_free() which expect an unsigned long.=20

On 32-bit architectures with 64-bit DMA addresses (like
CONFIG_ARCH_DMA_ADDR_T_64BIT), this will silently truncate the upper 32
bits. If a chunk crosses a 4GB boundary in its lower 32 bits, the end
address could wrap around, causing gen_pool_has_addr() to fail the bounds
check and permanently leak memory via this WARN_ON path.

> +				       niov_size)))
>  		return;
> =20
> -	gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> +	gen_pool_free(binding->chunk_pool, dma_addr, niov_size);
>  }
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

[Severity: High]
This is a pre-existing issue, but does this suffer from the same 64-bit to
32-bit truncation?=20

In net_devmem_bind_dmabuf() in net/core/devmem.c, gen_pool_add_owner()
takes an unsigned long for its virtual address parameter. Passing the
64-bit dma_addr here will truncate the upper 32 bits on 32-bit systems.=20

If two dmabuf chunks happen to share the same lower 32 bits, this
truncation could cause overlapping chunk registrations. This might
eventually lead to double allocations of the same network buffers and
silent data corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-tcpdm-larg=
e-niovs-v5-0-34bf6fac941b@meta.com?part=3D1
