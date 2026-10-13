Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E725CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1BF210E944;
	Tue, 13 Oct 2026 18:14:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FBEC10E986
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:14:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 201FF60A64;
 Tue, 13 Oct 2026 18:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCE91F000FF;
 Tue, 13 Oct 2026 18:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791915268;
 bh=wdPjgZbwCKTdtL33b9mS5g+t87lxKHuF22lrCg6SFH0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=R4rBlEz3W6tyMUdWr6/wsjzNh7kwQ1XxIUCCH21XaD5VbPivcM31mFtR3eDeq80fh
 tUgeqz8B7JRW4OrpFxz/JgZHG++5kDiYoGLMMo5TyLaEPVDx2vpaynuyz7DPA6JLyQ
 UUDd3cdHGDJWEv4pQ7AkB5sUtBLX7vxPewtzqjt3KjsqySnoMMSDOZDcM0RK4m7X3N
 RdmA0M7tJPAaVrfi2oyzHLVZFKFNaC0AoQFVVw2cHAir066/LNJeVy33nOqhWKS7H9
 93lcCZ+s4F3eaT6b1/iVdY3Bdr+jKAlGhBeuVL75oRPqSb0ifWTE7qCOmhXYjnrbI/
 k+T0E4tOwrZEA==
Subject: Re: [PATCH net v2 3/4] netdevsim: support devmem RX and TX bindings
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: kuba@kernel.org, dw@davidwei.uk, asml.silence@gmail.com,
 ap420073@gmail.com, sdf@fomichev.me, pabeni@redhat.com, kaiyuanz@google.com,
 bobbyeshleman@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, horms@kernel.org, shuah@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, razor@blackwall.org,
 daniel@iogearbox.net, tariqt@nvidia.com, kaifengw@google.com
Date: Tue, 13 Oct 2026 18:14:27 +0000
Message-ID: <179191526706.434549.7588739313460970086@kernel.org>
In-Reply-To: <20261012174300.2338784-4-almasrymina@google.com>
References: <20261012174300.2338784-4-almasrymina@google.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The pp_hold debugfs knob leaks a devmem net_iov, and the page
  pool's inflight count never reaches zero, once rx queue 0 has a dmabuf…
- [Medium] Page-pool allocations always fail on CONFIG_HAS_DMA=n builds
  after this patch.
- [Medium] Enabling NETMEM_TX_DMA exposes netdevsim's software PSP
  checksum path to unreadable payloads.
- [Medium] Deferred page-pool cleanup can call the DMA API on a freed
  nsim_bus_dev on configurations where PP_DMA_INDEX_BITS is 0.

Pre-existing issues:
- [Medium] nsim_pp_hold_write() dereferences ns->rq[0]->page_pool and
  allocates from it while holding only rtnl_lock.

--

netdevsim: support devmem RX and TX bindings

This commit sets a 64-bit DMA mask on the netdevsim bus device and enables
NETMEM_TX_DMA on the netdev. It also creates page pools with DMA mapping
and unreadable netmem support, tied to a queue index, so that devmem
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
The return value of dma_coerce_mask_and_coherent() is ignored here.

NETDEVSIM has no HAS_DMA dependency, and UML selects NO_DMA unless
UML_DMA_EMULATION is set. On those builds the dma_set_mask stub returns
-EIO, and the device registers anyway.

nsim_create_page_pool() then sets PP_FLAG_DMA_MAP unconditionally. Every
slow-path allocation goes through page_pool_dma_map() ->
dma_map_page_attrs(). The stub returns DMA_MAPPING_ERROR, so the page is
freed.

Will page_pool_alloc_pages() always return NULL on CONFIG_HAS_DMA=n after
this change? If so, nsim_pp_hold_write() would always fail with -ENOMEM.
That would break the page_pool selftests that use pp_hold, which worked
before.

Should the DMA flags only be set when the mask setup succeeds? The other
option is to make NETDEVSIM depend on HAS_DMA.

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

[Severity: Medium]
With PP_FLAG_ALLOW_UNREADABLE_NETMEM and .queue_idx set, page_pool_init()
picks up the rx queue's mp_params. After a bind-rx on queue 0 and the
queue restart, ns->rq[0]->page_pool becomes a dmabuf devmem pool.

What happens if pp_hold is written while the device is up?
nsim_pp_hold_write() still uses the page-only API:

drivers/net/netdevsim/netdev.c:nsim_pp_hold_write() {
    ...
		ns->page = page_pool_dev_alloc_pages(ns->rq[0]->page_pool);
		if (!ns->page)
			ret = -ENOMEM;
    ...
}

The call chain would be:

nsim_pp_hold_write()
  page_pool_dev_alloc_pages()
    page_pool_alloc_pages()
      page_pool_alloc_netmems()
        mp_dmabuf_devmem_alloc_netmems()
          page_pool_set_pp_info()
          pool->pages_state_hold_cnt++
      netmem_to_page()
        WARN_ON_ONCE(netmem_is_net_iov(netmem)) -> return NULL

Does this leak the net_iov? The niov is already counted as inflight, but
the handle is dropped without a page_pool_put_netmem() and the write
returns -ENOMEM.

If so, the pool's inflight count can never reach zero. page_pool_destroy()
at close or queue restart would then loop forever in
page_pool_release_retry() with "stalled pool shutdown". Because
mp_ops->destroy never runs, the binding, its genpool chunk and the dma-buf
would not be released either.

Should nsim_pp_hold_write() switch to the netmem API, or refuse when the
pool has a memory provider?

> +		.max_len = PAGE_SIZE,
>  		.nid = NUMA_NO_NODE,
> -		.dev = &napi->dev->dev,
> +		.dev = &ns->nsim_bus_dev->dev,

[Severity: Medium]
Pool pages are now DMA-mapped against the nsim_bus_dev device, and the
pool holds no reference on that device. Can the deferred page_pool release
worker touch the bus device after it has been freed?

nsim_destroy() intentionally returns the pp_hold page late:

	/* Put this intentionally late to exercise the orphaning path */
	if (ns->page) {
		page_pool_put_full_page(pp_page_to_nmdesc(ns->page)->pp,
					ns->page, false);

By this point page_pool_destroy() has already scheduled
page_pool_release_retry().

Some configs have PP_DMA_INDEX_BITS == 0 (PAGE_OFFSET is not a compile-time
constant and POISON_POINTER_DELTA == 0). There,
page_pool_register_dma_index() does not track mappings, so
page_pool_scrub() cannot unmap the outstanding page synchronously through
pool->dma_mapped.

After nsim_destroy() returns, device_unregister() can drop the last
reference, and nsim_bus_dev_release() calls kfree(nsim_bus_dev). The
delayed worker would later drain the ring and call
dma_unmap_page_attrs(pool->p.dev, ...) on the freed device.

The existing orphaning path test seems to exercise this sequence. Whether
it actually triggers depends on which configs have PP_DMA_INDEX_BITS == 0,
and on whether the final put_device() runs before the HZ/10 worker.

>  		.napi = napi,
>  		.dma_dir = DMA_BIDIRECTIONAL,
> -		.netdev = napi->dev,
> +		.netdev = dev,
> +		.queue_idx = idx,
>  	};
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
>  	if (err)
>  		goto err_free;

[Severity: Medium]
This isn't a bug introduced by this patch, but nsim_pp_hold_write()
dereferences ns->rq[0]->page_pool and allocates from it while holding only
rtnl_lock.

Queue restarts swap ns->rq[idx] in nsim_queue_start(). They destroy and
free the old rq and pool in nsim_queue_mem_free() while holding only the
netdev instance lock:

	page_pool_destroy(qmem->rq->page_pool);
	nsim_queue_free(dev, qmem->rq);

Since rtnl_lock and the netdev instance lock never overlap here, can
pp_hold allocate from a destroyed pool or dereference a freed rq?

The queue_reset debugfs file already provides a trigger:
nsim_qreset_write() -> netdev_lock() -> netdev_rx_queue_restart(). Working
devmem bind-rx and unbind adds another one.

[ ... ]

> @@ -1051,6 +1059,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
>  	ns->netdev->netdev_ops = &nsim_netdev_ops;
>  	ns->netdev->stat_ops = &nsim_stat_ops;
>  	ns->netdev->queue_mgmt_ops = &nsim_queue_mgmt_ops;
> +	ns->netdev->netmem_tx = NETMEM_TX_DMA;

[Severity: Medium]
With NETMEM_TX_DMA set, validate_xmit_unreadable_skb() now lets devmem TX
skbs through to nsim_start_xmit(). psp_validate_xmit() only checks that
the association's psd matches dev->psp_dev, so it does not reject
unreadable frags.

For a PSP-associated socket, nsim_start_xmit() calls nsim_do_psp() before
any linearization. If the peer has no PSP device, or does not enable
pas->version, nsim_do_psp() takes the non-decapsulation branch:

drivers/net/netdevsim/psp.c:nsim_do_psp() {
    ...
		uh = udp_hdr(skb);
		udplen = udp_get_len(skb, uh, skb_transport_offset(skb));
		csum = skb_checksum(skb, skb_transport_offset(skb),
				    udplen, 0);
    ...
}

Would this hit WARN_ON_ONCE(!skb_frags_readable(skb)) in skb_checksum()?

skb_checksum() then returns 0, or a partial header-only checksum.
nsim_do_psp() uses that value to write uh->check, sets CHECKSUM_NONE, and
forwards the packet to the peer with a wrong checksum.

Should nsim_do_psp() check skb_frags_readable() before computing the
checksum in software?

>  	netdev_lockdep_set_classes(ns->netdev);
>  
>  	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012174300.2338784-1-almasrymina%40google.com
