Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F179C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD0410E495;
	Fri,  3 Jul 2026 07:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nOWnadwt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F15710F6BF
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 07:52:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4770943540;
 Fri,  3 Jul 2026 07:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DAE1F00A3D;
 Fri,  3 Jul 2026 07:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783065121;
 bh=PGoSZ5zXGa7s7mlf/s6I0gZlKHcvVIqYbTweuQToz94=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nOWnadwtKTEv58uftBDzy9+jMdaQ/VesGOWK8kHau3Jb9osJN0WKBWhax562XCZFf
 iLg4lIPtYXPCmMRLMSkn2st2wZpRNl3H244611QMtJJAIYlHDvJldVUrTf1A9x2n54
 gyRIiNdoS12OSOqvBvNrtA3ZTxhOiRa4F/IGihREz93dsSNQtK0wnS3JZmA7S8piCK
 +Q5+/xcAkJlUtI47V1SY7AaC24qjAHozD0dyGCs53m3r9yNoaGCegGW2saSvcRfPUl
 eYRd7cIPb1YFZv50KvwXFlNJAA8VXoekrFnscr+b08Cp6whTpxrHaxUeZQ0D1Z1si2
 M3+K3QfK1x0zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-tcpdm-large-niovs-v4-1-ca4654f37570@meta.com>
References: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
 <20260701-tcpdm-large-niovs-v4-1-ca4654f37570@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 07:52:00 +0000
Message-Id: <20260703075200.F1DAE1F00A3D@smtp.kernel.org>
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
- [High] Truncation of 64-bit `dma_addr_t` to 32-bit `unsigned long` when i=
nteracting with `gen_pool` causes memory leaks and corruption on 32-bit sys=
tems with LPAE.
--

commit 294321e299dc1978a803324d3c6d3e8d5fb93d2d
Author: Bobby Eshleman <bobbyeshleman@meta.com>

net: devmem: allow rx-buf-size > PAGE_SIZE per dmabuf binding

This commit introduces a new netlink attribute to allow devmem dmabuf
bindings to request a larger niov size. The value must be a power of two
greater than or equal to PAGE_SIZE, aiming to reduce CPU overhead for
large flows.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 957d6b96216b3..3d6cf35e50f30 100644
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
> +				       niov_size)))
>  		return;
> =20
> -	gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> +	gen_pool_free(binding->chunk_pool, dma_addr, niov_size);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does truncating dma_addr_t to
unsigned long in net_devmem_free_dmabuf() cause issues on 32-bit systems
with LPAE?

The net_devmem_get_dma_addr() function returns a 64-bit dma_addr_t, but it =
is
cast to an unsigned long local variable. The gen_pool_has_addr() and
gen_pool_free() functions also expect an unsigned long for the address.

If a DMA-BUF is mapped with a 64-bit dma_addr_t that exceeds the 32-bit
boundary, passing it as unsigned long will truncate it.

Could this lead to gen_pool_has_addr() failing and causing an unrecoverable
memory leak, or gen_pool_free() clearing bits in the wrong chunk and causing
memory corruption?

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
This is also a pre-existing issue, but does passing dma_addr to
gen_pool_add_owner() truncate the 64-bit DMA address here?

The virt parameter of gen_pool_add_owner() takes an unsigned long. If a
contiguous chunk crosses a 4GB boundary on a 32-bit LPAE system, would this
truncation cause a start_addr > end_addr wrap-around or overlap in the
gen_pool?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tcpdm-larg=
e-niovs-v4-0-ca4654f37570@meta.com?part=3D1
