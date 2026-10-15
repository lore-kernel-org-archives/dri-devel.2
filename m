Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B51ECCA464
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 877BF112459;
	Thu, 15 Oct 2026 19:21:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E0C112461
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 19:21:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E81A43727;
 Thu, 15 Oct 2026 19:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E961F000C4;
 Thu, 15 Oct 2026 19:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792092070;
 bh=GgBgaGH8A1dFQW3H1sBO1hUvGwcWJ6mOtr3Ya+b10HA=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=RABnDfJP47XBl2oNxKo8DaXiXoYOGriUg3dHJZX4NIQevXyTwYqKuKbsCvuEGKcMm
 F6y/MK9XjRhd5ip7nul+xqddelY1VnU2if4xWXNGz+kg47p6s+FFwqJpsKRI5UaASq
 yvCstuHteyLmNAQvnel9etVDipnLBO8+sSm5XpJNU9clPyX2HZ9BoEqz/F37eRFIYE
 C80PbiAYyFkXMQzKdj+MEWJObYXqgZGxf0ntI3KOTzE7Xq71lq1BeF35MYA53TmOvI
 ck0JvHYNPweJjd0JVhT1Y/n7M5UjSgf7GivpPYWQWfIMGXSyM9PzDemjyO5NZNyUHU
 B9P+xuDiGpG8A==
Subject: Re: [PATCH net v3 3/4] netdevsim: support devmem RX and TX bindings
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: kuba@kernel.org, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
 ap420073@gmail.com, pabeni@redhat.com, kaiyuanz@google.com,
 bobbyeshleman@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, horms@kernel.org, shuah@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, daniel@iogearbox.net,
 razor@blackwall.org, tariqt@nvidia.com, kaifengw@google.com,
 dtatulea@nvidia.com
Date: Thu, 15 Oct 2026 19:21:08 +0000
Message-ID: <179209206849.434549.7519044574049970137@kernel.org>
In-Reply-To: <20261014161754.3782346-4-almasrymina@google.com>
References: <20261014161754.3782346-4-almasrymina@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] nsim_bus_dev_new() now calls
  dma_coerce_mask_and_coherent(&nsim_bus_dev->dev, DMA_BIT_MASK(64)) on…
- [Medium] Before this patch, netdevsim page pools did not DMA-map pages.

--

netdevsim: support devmem RX and TX bindings

The patch sets a 64-bit DMA mask on the netdevsim bus device and enables
NETMEM_TX_DMA. It also creates page pools with
PP_FLAG_ALLOW_UNREADABLE_NETMEM and a queue_idx, and adds DMA mapping
flags under CONFIG_HAS_DMA, so devmem bind-rx and bind-tx can be tested
against netdevsim. Finally, it refuses pp_hold when the queue 0 pool is
backed by a memory provider and drops unreadable skbs in the software PSP
checksum path.

> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> index 5c55c308487b4..f87f5e037b6fb 100644
> --- a/drivers/net/netdevsim/bus.c
> +++ b/drivers/net/netdevsim/bus.c
> @@ -462,6 +462,7 @@ nsim_bus_dev_new(unsigned int id, unsigned int port_count, unsigned int num_queu
>  	nsim_bus_dev->port_count = port_count;
>  	nsim_bus_dev->num_queues = num_queues;
>  	nsim_bus_dev->initial_net = current->nsproxy->net_ns;
> +	dma_coerce_mask_and_coherent(&nsim_bus_dev->dev, DMA_BIT_MASK(64));

[Severity: High]
Can this oops on sparc64 when a netdevsim device is created?

The nsim bus device has no DMA or IOMMU setup, so dev->archdata.iommu
stays NULL. On sparc64, get_arch_dma_ops() returns the global sun4u/sun4v
ops for devices that have no per-device dma_ops. The call chain is:

new_device_store()
  nsim_bus_dev_new()
    dma_coerce_mask_and_coherent()
      dma_set_mask_and_coherent()
        dma_supported()
          dma_4u_supported()

arch/sparc/kernel/iommu.c:dma_4u_supported() {
	struct iommu *iommu = dev->archdata.iommu;

	if (ali_sound_dma_hack(dev, device_mask))
		return 1;

	if (device_mask < iommu->dma_addr_mask)
		return 0;
	return 1;
}

ali_sound_dma_hack() returns 0 for non-PCI devices. That would make the
iommu->dma_addr_mask read a NULL pointer dereference.

Even if the mask check got through, the page_pool mappings enabled under
CONFIG_HAS_DMA in nsim_create_page_pool() would still go through the same
arch IOMMU ops with a NULL iommu. CONFIG_HAS_DMA is set on sparc64.

The return value of dma_coerce_mask_and_coherent() is also ignored here.
Should a failure be handled, or should PP_FLAG_DMA_MAP depend on whether
the mask was actually set?

>  	/* Disallow using nsim_bus_dev */
>  	smp_store_release(&nsim_bus_dev->init, false);
>  
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index b4a99f3ceac60..357ea9e5623b3 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -414,19 +414,27 @@ static int nsim_poll(struct napi_struct *napi, int budget)
>  	return done;
>  }
>  
> -static int nsim_create_page_pool(struct page_pool **p, struct napi_struct *napi)
> +static int nsim_create_page_pool(struct net_device *dev, struct page_pool **p,
> +				 struct napi_struct *napi, int idx)
>  {
> +	struct netdevsim *ns = netdev_priv(dev);
>  	struct page_pool_params params = {
>  		.order = 0,
>  		.pool_size = NSIM_RING_SIZE,
> +		.flags = PP_FLAG_ALLOW_UNREADABLE_NETMEM,
> +		.max_len = PAGE_SIZE,
>  		.nid = NUMA_NO_NODE,
> -		.dev = &napi->dev->dev,
> +		.dev = &ns->nsim_bus_dev->dev,
>  		.napi = napi,
>  		.dma_dir = DMA_BIDIRECTIONAL,
> -		.netdev = napi->dev,
> +		.netdev = dev,
> +		.queue_idx = idx,
>  	};
>  	struct page_pool *pool;
>  
> +	if (IS_ENABLED(CONFIG_HAS_DMA))
> +		params.flags |= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> +

[Severity: Medium]
Pool pages are now DMA-mapped against &ns->nsim_bus_dev->dev. Can the
deferred page_pool release worker end up unmapping against a struct
device that has already been freed?

nsim_destroy() returns the pp_hold page on purpose late, after
unregister_netdevice() has already destroyed the pool via nsim_stop():

drivers/net/netdevsim/netdev.c:nsim_destroy() {
	...
	/* Put this intentionally late to exercise the orphaning path */
	if (ns->page) {
		page_pool_put_full_page(pp_page_to_nmdesc(ns->page)->pp,
					ns->page, false);
		ns->page = NULL;
	}
	...
}

That can recycle the page into the retired pool's ptr_ring instead of
releasing it.

When PP_DMA_INDEX_BITS evaluates to 0, page_pool_register_dma_index()
does not track the mapping, so the first page_pool_scrub() has nothing to
unmap. Later the retry worker drains the ring:

page_pool_release_retry()
  ...
    __page_pool_unmap_netmem_dma()
      dma_unmap_page_attrs(pool->p.dev, ...)

In this case there is no xa_cmpxchg guard, so the unmap runs
unconditionally.

page_pool holds no reference on pool->p.dev. nsim_bus_dev_release()
kfree()s the nsim_bus_dev that embeds the device once device_unregister()
drops the last reference.

If page_pool_release_retry() runs after that, does dma_unmap_page_attrs()
dereference freed memory?

It is not clear which shipping configurations end up with
PP_DMA_INDEX_BITS == 0, so this may be limited in practice.

>  	pool = page_pool_create(&params);
>  	if (IS_ERR(pool))
>  		return PTR_ERR(pool);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014161754.3782346-1-almasrymina%40google.com
