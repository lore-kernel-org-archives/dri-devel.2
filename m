Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CD9CCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 16:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF2710E61D;
	Sun, 18 Oct 2026 16:01:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DED110E61E
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 16:01:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A7B64480B;
 Sun, 18 Oct 2026 16:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571411F000C4;
 Sun, 18 Oct 2026 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792339273;
 bh=AvBfaI1A7Wm4thY0Q9puG6a7Zmf5trkowv5N01h1M4o=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=MyocOagElc7aW/wWF57cMnrelxPqQcdbFQtdiB3TlvHxKRBRxbf9qY1uyzyQT5tN8
 bCna15wB76ZAFF0ZO6iDqUE87oU1TU1QTZF6Jm579ZZDjMrI5RlQVe70c7ctkwsbvr
 yzJfPPYkefq8t+Tkcg0HdCTO7XQecPAJ6YkRMzcBCv/kZjGpueSSmYB/Tkc5f5bWSL
 /yGl2PIV9pXlkFwFdUv+AMs5LPAOxUhPA5r46OLBpxqNnJr/qlIjqBu3bigwDgHG0j
 pqSJ6aZoerBfq6sReYBLZe+Bys8yWS0zltFctTqeDduH0/1je/oOKmuSSeS7aPb+YH
 gudtNovyqlx/w==
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: kuba@kernel.org, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
 ap420073@gmail.com, pabeni@redhat.com, kaiyuanz@google.com,
 bobbyeshleman@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 horms@kernel.org, shuah@kernel.org, sumit.semwal@linaro.org,
 christian.koenig@amd.com, dtatulea@nvidia.com, razor@blackwall.org,
 daniel@iogearbox.net, tariqt@nvidia.com, kaifengw@google.com
Date: Sun, 18 Oct 2026 16:01:10 +0000
Message-ID: <179233927086.3135.6123492094489915156@kernel.org>
In-Reply-To: <20261015163915.1166043-4-almasrymina@google.com>
References: <20261015163915.1166043-4-almasrymina@google.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On builds where PP_DMA_INDEX_BITS is 0, this patch leads to a
  use-after-free of the netdevsim bus device.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but writing true
  to the pp_hold debugfs file of a running netdevsim VF port…

--

netdevsim: support devmem RX and TX bindings

This commit sets a 64-bit DMA mask on the netdevsim bus device, enables
NETMEM_TX_DMA, and creates netdevsim page pools with
PP_FLAG_ALLOW_UNREADABLE_NETMEM and queue_idx, plus DMA mapping when
CONFIG_HAS_DMA is set, so devmem bind-rx and bind-tx can be tested. It
also refuses pp_hold on memory-provider-backed pools under the netdev
instance lock, and drops unreadable skbs in the software PSP checksum
path.

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

[Severity: High]

Can this cause a use-after-free of the nsim_bus_dev struct device on
builds where PP_DMA_INDEX_BITS is 0?

The page pool doesn't take a reference on pool->p.dev. With
PP_FLAG_DMA_MAP now set, pages from these pools carry a DMA mapping
against &ns->nsim_bus_dev->dev.

PP_DMA_INDEX_BITS is 0 when POISON_POINTER_DELTA is 0 and PAGE_OFFSET is
not a suitably aligned compile-time constant. Some 32-bit and nommu
builds hit this, riscv nommu for example, where PAGE_OFFSET is
phys_ram_base. In that case the mapping is never recorded:

net/core/page_pool.c:page_pool_register_dma_index() {
    ...
	if (unlikely(!PP_DMA_INDEX_BITS))
		goto out;
    ...
}

so page_pool_scrub() can't unmap outstanding pages while the device is
still alive.

Suppose a page is held via pp_hold and the device is then deleted.
nsim_destroy() returns ns->page late on purpose ("Put this intentionally
late to exercise the orphaning path"), and the sequence looks like this:

nsim_destroy()
  nsim_queue_uninit()
    page_pool_destroy()
      page_pool_release()
        page_pool_scrub()     <- held page not tracked, stays mapped
      inflight == 1, release_dw scheduled
  page_pool_put_full_page(pp, ns->page, false)  <- page lands in pool->ring
nsim_bus_dev_del()
  device_unregister()
    nsim_bus_dev_release()    <- struct device freed

page_pool_release_retry()
  page_pool_release()
    ...
      page_pool_empty_ring()
        page_pool_return_netmem()
          __page_pool_release_netmem_dma()
            __page_pool_unmap_netmem_dma()
              dma_unmap_page_attrs(pool->p.dev, ...)  <- freed device

The existing nl_netdev.py page_pool test, which holds a page and then
removes the device, follows this sequence. Before this patch the pools
did no DMA mapping, so the late put never touched the device.

>  	pool = page_pool_create(&params);
>  	if (IS_ERR(pool))
>  		return PTR_ERR(pool);

[ ... ]

> @@ -929,12 +939,15 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
>  		return ret;
>  
>  	rtnl_lock();
> +	netdev_lock(ns->netdev);
>  	ret = count;
>  	if (val == !!ns->page)
>  		goto exit;
>  
>  	if (!netif_running(ns->netdev) && val) {
>  		ret = -ENETDOWN;
> +	} else if (val && page_pool_is_unreadable(ns->rq[0]->page_pool)) {

[Severity: Medium]

This isn't a bug introduced by this patch, but can this dereference a
NULL ns->rq on VF ports?

nsim_create() creates the pp_hold file for both PF and VF ports. However,
nsim_init_netdevsim_vf() only sets nsim_vf_netdev_ops and registers the
netdev, so ns->rq stays NULL.

nsim_vf_netdev_ops has no ndo_open. __dev_open() still sets
__LINK_STATE_START, so after "ip link set up" on the VF the
netif_running() check above passes.

Writing 1 to pp_hold on a running VF port with no page held would then
evaluate ns->rq[0] with ns->rq == NULL. The previous
page_pool_dev_alloc_pages(ns->rq[0]->page_pool) call had the same
dereference.

> +		ret = -EOPNOTSUPP;
>  	} else if (val) {
>  		ns->page = page_pool_dev_alloc_pages(ns->rq[0]->page_pool);
>  		if (!ns->page)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015163915.1166043-1-almasrymina%40google.com
