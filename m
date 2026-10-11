Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66277CA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 03:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D8810E282;
	Sun, 11 Oct 2026 03:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EkZZT6kA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8B610E282
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 03:38:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E570447A1;
 Sun, 11 Oct 2026 03:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17801F000FF;
 Sun, 11 Oct 2026 03:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791689902;
 bh=vpDzdyqOuBqn75M9QRrJXkUmp+FpV4aVcz8Hf/4UtS8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=EkZZT6kAN/v81cxQqSmrEi3H+WZMRHlWt8GrJxIwtnOVy5M5tthAjut+CnkvZp9W5
 eC4lRAXlnAMvr186xSv+RlbPLwgj5fsEJlrqgZ1YIL2Lc7jGjxvDGuHUI+r7ExDFzI
 +wmgcgvOZNkIPhSsQI3644WZj5Figmj9D7UI1qfXMt3vjurWGeV/qk+9O0kgS5ylu4
 pVtrU/aWTYoxOxFCvOpgKBRh4Ieqoz/xrLQROJB4jszb2yoRG3Xu8vvi2RqaiHlYES
 AEgnRa7uL+lesaLSi6fm2vRAxFfwOhXxx4M0ra60MdwcGNOQbcGfTgFydVbVJmRpmu
 Y+nSL18Z5CToQ==
Subject: Re: [PATCH net v1 3/4] netdevsim: support devmem RX and TX bindings
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: kuba@kernel.org, dw@davidwei.uk, asml.silence@gmail.com,
 ap420073@gmail.com, sdf@fomichev.me, pabeni@redhat.com, kaiyuanz@google.com,
 bobbyeshleman@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, horms@kernel.org, shuah@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, daniel@iogearbox.net,
 razor@blackwall.org, tariqt@nvidia.com, kaifengw@google.com
Date: Sun, 11 Oct 2026 03:38:20 +0000
Message-ID: <179168990038.434549.9826013939304899900@kernel.org>
In-Reply-To: <20261010025532.839559-4-almasrymina@google.com>
References: <20261010025532.839559-4-almasrymina@google.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds PP_FLAG_ALLOW_UNREADABLE_NETMEM and .queue_idx
  to nsim_create_page_pool().
- [Medium] nsim_bus_dev_new() ignores the return value of
  dma_coerce_mask_and_coherent(&nsim_bus_dev->dev, DMA_BIT_MASK(64)) and…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  nsim_pp_hold_write() holds only rtnl_lock() while it loads ns->rq[0],…

--

netdevsim: support devmem RX and TX bindings

This patch sets a 64-bit DMA mask on the netdevsim bus device and enables
NETMEM_TX_DMA on the netdevsim net_device. It also creates the RX page_pools
with DMA mapping, unreadable netmem and queue_idx set, so that devmem
bind-rx and bind-tx can be tested against netdevsim in selftests.

> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> index 5c55c308487b4..f87f5e037b6fb 100644
> --- a/drivers/net/netdevsim/bus.c
> +++ b/drivers/net/netdevsim/bus.c
> @@ -462,6 +462,7 @@ nsim_bus_dev_new(unsigned int id, unsigned int port_count, unsigned int num_queu
>  	nsim_bus_dev->port_count = port_count;
>  	nsim_bus_dev->num_queues = num_queues;
>  	nsim_bus_dev->initial_net = current->nsproxy->net_ns;
> +	dma_coerce_mask_and_coherent(&nsim_bus_dev->dev, DMA_BIT_MASK(64));

[Severity: Medium]
What happens here on CONFIG_HAS_DMA=n builds?

NETDEVSIM does not depend on HAS_DMA. Some configs select NO_DMA, for
example UML without UML_DMA_EMULATION. On those builds the dma_set_mask()
stub returns -EIO. The return value is ignored here, so the device
registers and no error is reported.

The PP_FLAG_DMA_MAP change in nsim_create_page_pool() below means every
slow-path page_pool allocation would then fail:

page_pool_alloc_netmems()
  ...
    page_pool_dma_map()
      dma_map_page_attrs()   <- stub returns DMA_MAPPING_ERROR
      if (dma_mapping_error(pool->p.dev, dma))
          return false;

After that, nsim_pp_hold_write() returns -ENOMEM:

	ns->page = page_pool_dev_alloc_pages(ns->rq[0]->page_pool);
	if (!ns->page)
		ret = -ENOMEM;

Would the existing page_pool selftests that use pp_hold now fail on these
builds? They passed there before this patch.

Should the error be checked here? Alternatively, should the DMA flags only
be set when the mask setup succeeds?

>  	/* Disallow using nsim_bus_dev */
>  	smp_store_release(&nsim_bus_dev->init, false);
>  
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index b4a99f3ceac60..4415dc01c610b 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -414,16 +414,22 @@ static int nsim_poll(struct napi_struct *napi, int budget)
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
> +		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
> +			 PP_FLAG_ALLOW_UNREADABLE_NETMEM,
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

[Severity: Medium]
With PP_FLAG_ALLOW_UNREADABLE_NETMEM and queue_idx set, page_pool_init()
now copies rxq->mp_params.mp_ops and mp_priv into the pool. After a devmem
(or io_uring zcrx) bind-rx on queue 0, ns->rq[0]->page_pool is therefore
backed by a memory provider.

nsim_pp_hold_write() still allocates from that pool with the page-only API:

	ns->page = page_pool_dev_alloc_pages(ns->rq[0]->page_pool);

What happens to the net_iov in that case? The call chain looks like:

nsim_pp_hold_write()
  page_pool_dev_alloc_pages()
    page_pool_alloc_pages()
      page_pool_alloc_netmems()
        mp_dmabuf_devmem_alloc_netmems()
          page_pool_set_pp_info(pool, netmem);
          pool->pages_state_hold_cnt++;
      netmem_to_page()
        if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
            return NULL;

The WARN fires, and it is fatal with panic_on_warn. ns->page becomes NULL
and the write returns -ENOMEM. The net_iov is already counted in
pages_state_hold_cnt, but nothing holds a pointer to it anymore.

Is this net_iov leaked for good? If so, the pool's inflight count would
never reach zero. page_pool_destroy() at unbind or queue restart would then
keep deferring the release, and the provider's destroy hook would never
run. That would also leak the pool, its dmabuf binding reference and the
binding's genpool chunk.

Should nsim_pp_hold_write() use the netmem allocation API instead? Or
should it refuse to allocate when a memory provider is bound to the queue?

>  	struct page_pool *pool;
>  

[ ... ]

> @@ -762,14 +768,16 @@ nsim_queue_mem_alloc(struct net_device *dev,
>  	if (ns->rq_reset_mode == 1) {
>  		if (!netif_running(ns->netdev))
>  			return -ENETDOWN;
> -		return nsim_create_page_pool(&qmem->pp, &ns->rq[idx]->napi);
> +		return nsim_create_page_pool(dev, &qmem->pp,
> +					     &ns->rq[idx]->napi, idx);
>  	}
>  
>  	qmem->rq = nsim_queue_alloc();
>  	if (!qmem->rq)
>  		return -ENOMEM;
>  
> -	err = nsim_create_page_pool(&qmem->rq->page_pool, &qmem->rq->napi);
> +	err = nsim_create_page_pool(dev, &qmem->rq->page_pool, &qmem->rq->napi,
> +				    idx);

[Severity: High]
This is a pre-existing issue that this patch did not introduce. It seems
worth raising because bind-rx now gives netdevsim another way to restart
queues.

nsim_pp_hold_write() holds only rtnl_lock() while it loads ns->rq[0],
dereferences its page_pool and allocates from it. The RX queue restart
path replaces and frees those objects while holding only the netdev instance
lock:

netdev_rx_queue_restart()
  nsim_queue_mem_alloc()
  nsim_queue_stop()
  nsim_queue_start()
    ns->rq[idx] = qmem->rq;               (modes 0/2/3)
    ns->rq[idx]->page_pool = qmem->pp;    (mode 1)
  nsim_queue_mem_free()
    page_pool_destroy(qmem->rq->page_pool);
    nsim_queue_free(dev, qmem->rq);       <- kfree()s the old rq

nsim_qreset_write() takes only netdev_lock(), and so do devmem bind-rx and
unbind. None of them takes rtnl, so these paths share no lock with
nsim_pp_hold_write().

Can this interleaving lead to a use-after-free?

CPU0                                CPU1
nsim_pp_hold_write()
  rtnl_lock()
  loads old ns->rq[0]
                                    restart of queue 0
                                      ns->rq[0] = new rq
                                      page_pool_destroy(old pool)
                                      kfree(old rq)
  old rq->page_pool
  page_pool_dev_alloc_pages()

Should nsim_pp_hold_write() also take the netdev instance lock?

>  	if (err)
>  		goto err_free;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010025532.839559-1-almasrymina%40google.com
