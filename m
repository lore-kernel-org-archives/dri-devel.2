Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21514CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 02:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF4010E292;
	Sun, 11 Oct 2026 02:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UPUdIN46";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD3C810E28C
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 02:55:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 96B064397F;
 Sun, 11 Oct 2026 02:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428441F00893;
 Sun, 11 Oct 2026 02:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791687345;
 bh=Lt/7AQC8hFd46+OHFqq8vkhQhymxqla2eGKpembrV5I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UPUdIN46fiB+2kIzwuybB5so1ouq9v15CRpV875bcwwJaQ/Ul6/i6/deKcLd5CrWL
 QcZ520YYrBRI2yAhBfkB/oCUtuT+sDlxw2vbMDObPN92k3hZCuvt+NxUzweMs0M5bk
 rJNQ26EY6dgP72p83rLlb5/cJHZl9Udf/lRsNUvqcmiEBsWrVq/5pvtnQpnV1zHGc8
 oNaTq7cM+l32Q98Yuj3R5emGed8/F+yKrq9DP7YO44OgMjxP3MTRWWWQDRgGlmLGcu
 aYZDz3/ZOtgHl92ElSwPUEoaSwXZUIZtPRbkrOANzDrMubRLMUl03kBtSb5paH3goJ
 2zTcOnF1Pq+xg==
Message-ID: <sashiko-outbox-166989@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v1 3/4] netdevsim: support devmem RX and TX bindings
To: "Mina Almasry" <almasrymina@google.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261010025532.839559-4-almasrymina@google.com>
References: <20261010025532.839559-1-almasrymina@google.com>
 <20261010025532.839559-4-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:55:44 +0000
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
- [High] netdevsim: UAF in page_pool async destruction due to freed nsim_bu=
s_dev
- [Medium] netdevsim: memory leak and page_pool release loop in nsim_pp_hol=
d_write
--

commit 3929ee46c506ebcd379657adcaaf3d764e577c6d
Author: Mina Almasry <almasrymina@google.com>

netdevsim: support devmem RX and TX bindings

This patch sets a 64-bit DMA mask on nsim_bus_dev, enables NETMEM_TX_DMA,
and configures page_pool instances with PP_FLAG_DMA_MAP,
PP_FLAG_DMA_SYNC_DEV, and PP_FLAG_ALLOW_UNREADABLE_NETMEM to allow
testing of devmem bind operations in software selftests.

> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index b4a99f3ceac60..4415dc01c610b 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c

[ ... ]

> @@ -414,16 +414,22 @@ static int nsim_poll(struct napi_struct *napi, int =
budget)
>  	return done;
>  }
> =20
> -static int nsim_create_page_pool(struct page_pool **p, struct napi_struc=
t *napi)
> +static int nsim_create_page_pool(struct net_device *dev, struct page_poo=
l **p,
> +				 struct napi_struct *napi, int idx)
>  {
> +	struct netdevsim *ns =3D netdev_priv(dev);
>  	struct page_pool_params params =3D {
>  		.order =3D 0,
>  		.pool_size =3D NSIM_RING_SIZE,
> +		.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
> +			 PP_FLAG_ALLOW_UNREADABLE_NETMEM,

[Severity: Medium]
Does adding PP_FLAG_ALLOW_UNREADABLE_NETMEM here cause a memory leak when
used with the debugfs pp_hold file?

When devmem is bound, a user writing to pp_hold triggers nsim_pp_hold_write=
()
which attempts to allocate a page:

nsim_pp_hold_write() {
    ...
    } else if (val) {
        ns->page =3D page_pool_dev_alloc_pages(ns->rq[0]->page_pool);
        if (!ns->page)
            ret =3D -ENOMEM;
    ...
}

Because the page pool is configured to allow unreadable devmem,
page_pool_dev_alloc_pages() returns an unreadable devmem net_iov.
The inline function netmem_to_page() detects it is unreadable and returns
NULL.

nsim_pp_hold_write() sees the NULL, treats it as an allocation failure,
and drops the pointer without releasing the underlying net_iov back to the
page pool. This leaks the inflight netmem, and later causes the page pool
teardown workqueue (page_pool_release_retry) to spin indefinitely.

> +		.max_len =3D PAGE_SIZE,
>  		.nid =3D NUMA_NO_NODE,
> -		.dev =3D &napi->dev->dev,
> +		.dev =3D &ns->nsim_bus_dev->dev,

[Severity: High]
Can this lead to a use-after-free during asynchronous page pool destruction?

This sets the pool's device pointer to the dynamically allocated
nsim_bus_dev, but the page pool does not appear to take a reference to it.

If the netdevsim device is unregistered (e.g., via sysfs) while normal SKBs
are still inflight in a socket receive queue, nsim_bus_dev's refcount can
drop to 0, causing it to be synchronously freed:

nsim_bus_dev_release() {
    ...
    nsim_bus_dev =3D container_of(dev, struct nsim_bus_dev, dev);
    kfree(nsim_bus_dev);
}

When those inflight SKBs are eventually consumed and freed by user-space,
the asynchronous page pool destruction will invoke
__page_pool_unmap_netmem_dma(), which calls
dma_unmap_page_attrs(pool->p.dev, ...).

Because pool->p.dev points to the already-freed nsim_bus_dev->dev,
this results in a use-after-free.

> +		.napi =3D napi,
>  		.dma_dir =3D DMA_BIDIRECTIONAL,
> -		.netdev =3D napi->dev,
> +		.netdev =3D dev,
> +		.queue_idx =3D idx,
>  	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010025532.8395=
59-1-almasrymina@google.com?part=3D3
