Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70415CA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 03:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F85B10E106;
	Sun, 11 Oct 2026 03:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EGinSXvX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E52B10E106
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 03:38:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3055E41472;
 Sun, 11 Oct 2026 03:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2501F000FF;
 Sun, 11 Oct 2026 03:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791689898;
 bh=IHiq471lI34tMV6DI159H0HPk05JOLQKG1SqobU79J0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=EGinSXvXpMfm+BKNZSmdSSntxAhl9mXZyU1CvvbHybYYrOFEAUplRFw93WoCpsrlz
 AE6R27g5xwx8YepMEIMSbWA4MwPWl6/taP2phdnYblY4lplz5F39EL9vjm/NrzR0vH
 5njyL8cZX7SFm8XCVC5pmp8CEKTWplmCsErFuEaqeCI+hDWFWthMtmM3gm1kEyxdA1
 QvgS9q1lBn6fRVzg44hJMFcLIz/pQbeSsYyWqnYyTtgVvZZ9DEFPX14XgsIaC6kigN
 vtr+AQJHdwJ+AFq19iQsmjkgkujLMqg0eVkTKkHpIgcK7BzaBC5kvk+hKgJTakkwig
 CU7u0yQ6Sk14Q==
Subject: Re: [PATCH net v1 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
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
Date: Sun, 11 Oct 2026 03:38:16 +0000
Message-ID: <179168989611.434549.16378879758158058625@kernel.org>
In-Reply-To: <20261010025532.839559-2-almasrymina@google.com>
References: <20261010025532.839559-2-almasrymina@google.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: a binding that has already been unbound (netlink
  socket closed) but is still alive because a TCP socket or page pool…
- [High] The patch unmaps and detaches the dma-buf in
  mp_dmabuf_devmem_uninstall() as soon as bound_rxqs becomes empty.
- [Low] The comment on struct net_devmem_dmabuf_binding::lock in
  net/core/devmem.h still reads '/* Protect dev */'.
- [Low] The comment on struct net_devmem_dmabuf_binding::ref in
  net/core/devmem.h still says 'The binding undos itself and unmaps the…

--

net: devmem: unmap dma_buf synchronously on queue uninstall

This patch adds net_devmem_dmabuf_binding_unmap(), which runs under
binding->lock and clears binding->sgt and binding->attachment so that
unmapping is idempotent. It is called from mp_dmabuf_devmem_uninstall()
when the last bound RX queue is uninstalled, so the dma_buf is no longer
unmapped against a freed dma_dev after device unregister.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4d60654ce7fd..5e4070b82df44 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -58,6 +58,21 @@ static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
>  	schedule_work(&binding->unbind_w);
>  }
>  
> +static void
> +net_devmem_dmabuf_binding_unmap(struct net_devmem_dmabuf_binding *binding)
> +{
> +	lockdep_assert_held(&binding->lock);

[Severity: Low]
This isn't a bug, but the comment on binding->lock in net/core/devmem.h
still reads:

	/* Protect dev */
	struct mutex lock;

The lock now also protects binding->sgt and binding->attachment, and the
lockdep_assert_held() here enforces that. Should the comment in the header
be updated as well?

> +
> +	if (!binding->sgt)
> +		return;

[ ... ]

> @@ -74,9 +89,10 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
>  		  size, avail))
>  		gen_pool_destroy(binding->chunk_pool);
>  
> -	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
> -					  binding->direction);
> -	dma_buf_detach(binding->dmabuf, binding->attachment);
> +	mutex_lock(&binding->lock);
> +	net_devmem_dmabuf_binding_unmap(binding);
> +	mutex_unlock(&binding->lock);

[Severity: High]
Can this deferred unmap still run against a freed dma_dev when the binding
was already unbound before the device went away?

The commit message says the fix covers unregister "while userspace still
holds a netlink or TCP socket reference". However, the only synchronous
unmap is in mp_dmabuf_devmem_uninstall(), and dev_memory_provider_uninstall()
only reaches that for RX queues whose rxq->mp_params is still set.

Closing the netlink socket does this, with no unmap:

netdev_nl_sock_priv_destroy()
  net_devmem_unbind_dmabuf()
    xa_erase(&net_devmem_dmabuf_bindings, binding->id);
    netif_mp_close_rxq()
      __netif_mp_close_rxq()
        memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
    percpu_ref_kill(&binding->ref);

Other references can keep the binding alive past that point. On RX,
unreturned devmem tokens keep the old page pool alive. On TX, unacked
devmem skbs in a TCP retransmit queue hold refs taken via
net_devmem_get_net_iov(). The TX binding can be created through
netdev_nl_bind_tx_doit(), which does not check for CAP_NET_ADMIN.

A later unregister then finds no installed provider, so
mp_dmabuf_devmem_uninstall() is never called for this binding. After the
parent device is freed (for example in nsim_bus_dev_release()), dropping
the last reference goes through:

__net_devmem_dmabuf_binding_free()
  net_devmem_dmabuf_binding_unmap()
    dma_buf_unmap_attachment_unlocked()
      unmap_udmabuf()
        dma_unmap_sg_attrs()    <-- freed attach->dev

That looks like the same KASAN report quoted in the commit message.

The follow-up commit "net: devmem: detach TX bindings on NETDEV_UNREGISTER"
fixes the TX case while the netlink socket is still open. Its
net_devmem_dev_unregister() only walks net_devmem_dmabuf_bindings, though,
and unbound bindings are no longer in that xarray.

A narrower variant needs no extra references. The unbind_w work queued by
net_devmem_dmabuf_binding_release() runs asynchronously, and nothing makes
it run before device removal.

Would a complete fix need to track every binding that is still mapped
against a device, and not only the ones installed on an RX queue?

> +
>  	dma_buf_put(binding->dmabuf);
>  	xa_destroy(&binding->bound_rxqs);
>  	percpu_ref_exit(&binding->ref);
> @@ -535,6 +551,7 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
>  				mutex_lock(&binding->lock);
>  				ASSERT_EXCLUSIVE_WRITER(binding->dev);
>  				WRITE_ONCE(binding->dev, NULL);
> +				net_devmem_dmabuf_binding_unmap(binding);

[Severity: High]
Is it safe to unmap here just because bound_rxqs became empty? Nothing
here checks whether the hardware queue has actually stopped using the
binding.

On queue lease teardown the physical NIC is still registered and running:

netkit_queue_unlease()
  netdev_rx_queue_unlease()
    netif_rxq_cleanup_unlease()
      __netif_mp_close_rxq(phys_rxq->dev, rxq_idx, &p);
      __netif_mp_uninstall_rxq(virt_rxq, &p);
        mp_dmabuf_devmem_uninstall()
          net_devmem_dmabuf_binding_unmap()

If the reconfig fails, __netif_mp_close_rxq() only warns:

	err = netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg[0], &qcfg[1]);
	WARN_ON(err && err != -ENETDOWN);

netdev_rx_queue_reconfig() can fail in ndo_queue_mem_alloc() before
ndo_queue_stop() is called. It can also fail in stop or start, with the
old queue restored. In both cases the old devmem page pool keeps running,
and its ring holds DMA addresses from binding->sgt.

netif_rxq_cleanup_unlease() still calls uninstall unconditionally. The
virtual rxq is the one recorded in bound_rxqs, so removing it empties the
xarray. The dma-buf is then unmapped and detached while the NIC can still
DMA into those IOVAs, and the pool can keep refilling from
binding->chunk_pool.

Before this patch the mapping lasted until __net_devmem_dmabuf_binding_free()
ran, which only happens after every page pool has dropped its binding ref.
The commit message only talks about unregistration. Was the lease
teardown path also meant to unmap synchronously here?

[Severity: Low]
This isn't a bug, but the comment on the ref field of struct
net_devmem_dmabuf_binding in net/core/devmem.h still says:

	 * The binding undos itself and unmaps the underlying dmabuf once all
	 * those refs are dropped and the binding is no longer desired or in
	 * use.

With this call, the mapping can go away while netlink, page pool or
net_iov refs are still held. The follow-up commit "net: devmem: detach TX
bindings on NETDEV_UNREGISTER" adds another early unmap in
net_devmem_dev_unregister(). Should this comment be updated to match?

>  				mutex_unlock(&binding->lock);
>  			}
>  			break;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010025532.839559-1-almasrymina%40google.com
