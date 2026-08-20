Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5A6C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4586210EFF0;
	Thu, 20 Aug 2026 11:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GaAtExFZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDEF10EFFE
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:08:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3E4F60A5C;
 Thu, 20 Aug 2026 11:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2724D1F000E9;
 Thu, 20 Aug 2026 11:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787224122;
 bh=StuOTL/1m9vtFSKprtXoEy6lGer298rg8gURzKvP72U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GaAtExFZjyZC15rfKo/+y7fJEs15nyMb3Fk7iV1/x8hFbQL3/cSHs/zmupyJFA+2F
 brDOILB57WwP8lHd3+OVmFmNZC1FZRPkvvXBbSAaVAYZUHoiQmq+Q9WyB7uVviO98h
 GWWrGQKHUD5rSTNf5dHxiQMj3M09lLwitmJSJRNTP2DXuVGSxyKsciPZqOgJHbEuVl
 GG9y1vZ1Kx3CqmnjUkqjMOTRvlLqsXT48BFWkPvYOxO6dWqoGvx8jXoMRd3VDa/QI/
 NxVkfg2P+a30SR4QNTAWuxfLTtifLFWaaMYxNS4k5ypY+wyAqgsoZ1IPieD7mXhN8o
 FV4MpXQmRcKsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] irqchip/gic-v3-its: Zero shared pages after conversion
To: "Steven Price" <steven.price@arm.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260820105026.53208-2-steven.price@arm.com>
References: <20260820105026.53208-1-steven.price@arm.com>
 <20260820105026.53208-2-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 11:08:41 +0000
Message-Id: <20260820110842.2724D1F000E9@smtp.kernel.org>
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
- [High] its_alloc_pages_node() can sleep while allocating memory in an ato=
mic context when running on Arm64 Realm systems, causing a "scheduling whil=
e atomic" BUG.
--

--- Patch [1]: [PATCH 1/2] irqchip/gic-v3-its: Zero shared pages after conv=
ersion ---
commit 36d3014f90a1ff0fea959d794f1e5680dcbc80f5
Author: Steven Price <steven.price@arm.com>

irqchip/gic-v3-its: Zero shared pages after conversion

its_alloc_pages_node() passes __GFP_ZERO to the page allocator before
calling set_memory_decrypted(), but for Arm CCA with MEC the key used to
access the page will change. This masks out __GFP_ZERO from the allocation
request and zeros the page after decryption instead.

> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v=
3-its.c
> index b57d81ad33a0a..1a69eef9209e7 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -213,10 +213,12 @@ static gfp_t gfp_flags_quirk;
>  static struct page *its_alloc_pages_node(int node, gfp_t gfp,
>  					 unsigned int order)
>  {
> +	bool want_zero =3D gfp & __GFP_ZERO;
>  	struct page *page;
>  	int ret =3D 0;
> =20
> -	page =3D alloc_pages_node(node, gfp | gfp_flags_quirk, order);
> +	page =3D alloc_pages_node(node, (gfp & ~__GFP_ZERO) | gfp_flags_quirk,
> +				order);
> =20
>  	if (!page)
>  		return NULL;

[Severity: High]
This is a pre-existing issue, but does the set_memory_decrypted() call that
follows this allocation sleep in an atomic context?

During CPU hotplug, gic_starting_cpu() executes with interrupts disabled
and calls its_cpu_init_lpis() -> allocate_vpe_l1_table(). This function
requests an atomic memory allocation:

drivers/irqchip/irq-gic-v3-its.c:allocate_vpe_l1_table() {
    ...
    page =3D its_alloc_pages(GFP_ATOMIC | __GFP_ZERO, get_order(np * PAGE_S=
IZE));
    ...
}

This wraps its_alloc_pages_node(), which then calls set_memory_decrypted()
unconditionally.

On Arm64 Realm guests supporting BBML2, set_memory_decrypted() eventually
calls split_kernel_leaf_mapping(), which takes a mutex:

arch/arm64/mm/mmu.c:split_kernel_leaf_mapping() {
    ...
    mutex_lock(&pgtable_split_lock);
    ...
}

Could this acquire a mutex from an atomic context and trigger a kernel pani=
c?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820105026.5320=
8-1-steven.price@arm.com?part=3D1
