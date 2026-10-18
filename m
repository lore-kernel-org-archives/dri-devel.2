Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27233CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 16:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D42510E61E;
	Sun, 18 Oct 2026 16:01:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115E010E61D
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 16:01:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3C4043EBD;
 Sun, 18 Oct 2026 16:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180651F000C5;
 Sun, 18 Oct 2026 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792339270;
 bh=zKKDDOraC/Fm4aWqLVugKGAEsbOeF7nuVUrBWh5Z6rg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=LSzOJga2nAq2hbwzxAML3SslVf/FDFHOwNDeRJ09cLmvvIAT9axjaxzu2Bt0Ihnw2
 zk2DNzNZmSQABcSr7q8Og7XLF2rRUCbnIcdavGi+0pNPiniAFUgBk8vCIKNLR9VOZs
 ZvvoO2AmZ41Kev2DBM+k3+FTI0h1S2SE6pE9ROhOhXoJQvlIheHtIF0+TOKfFsFzsw
 qb40gf9u6OWP3hvvZroHv8+mlYYeOAdJCggKxoARLz2ZEgs9A0PX6LZJcTKu1Gyj/+
 3OvR0irjY4wsPidyBh8GPLyZTxjiMXwk1lzfqqPeKY0n2leIu42ASAbTttkU7c/tfG
 Gg1djIptdyAyg==
Subject: Re: [PATCH net v4 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
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
Date: Sun, 18 Oct 2026 16:01:08 +0000
Message-ID: <179233926862.3135.1507266598648797172@kernel.org>
In-Reply-To: <20261015163915.1166043-3-almasrymina@google.com>
References: <20261015163915.1166043-3-almasrymina@google.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves a race open on the leased path (NETMEM_TX_NO_DMA,
  e.g. netkit), which is the path added by 1abe839b34ae and named in…
- [High] net_devmem_dev_unregister() now also visits TX bindings whose
  percpu_ref has already reached zero, i.e. bindings whose…
- [Low] This patch makes binding->vdev writable after the binding is
  created, but the locking comment in struct net_devmem_dmabuf_binding…

--

net: devmem: detach TX bindings on NETDEV_UNREGISTER

This patch extends net_devmem_dev_unregister() to cover TX bindings.
When binding->dev unregisters, the binding loses its LIVE mark, dev and
vdev are cleared, and the dma_buf is unmapped. When only binding->vdev
unregisters, only vdev is cleared.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 20d95b24d5951..d33a092c6e4bb 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -207,11 +207,30 @@ net_devmem_dev_unregister_rx(struct net_devmem_dmabuf_binding *binding,
>  			    NET_DEVMEM_BINDING_LIVE);
>  }
>  
> +static bool
> +net_devmem_dev_unregister_tx(struct net_devmem_dmabuf_binding *binding,
> +			     unsigned long xa_idx, struct net_device *dev)
> +{
> +	if (binding->direction != DMA_TO_DEVICE)
> +		return false;
> +
> +	if (READ_ONCE(binding->vdev) == dev)
> +		WRITE_ONCE(binding->vdev, NULL);

[Severity: Low]
This isn't a bug, but vdev can now change after the binding is
created. The lock comment in struct net_devmem_dmabuf_binding in
net/core/devmem.h still says:

	/* Protect dev, attachment and sgt */
	struct mutex lock;

Here vdev is written with only the net_devmem_dmabuf_bindings xa_lock
held. net_devmem_dev_detach() writes it under binding->lock. Readers
such as net_devmem_get_binding() read it with no lock at all.

Could the comment be updated to describe how vdev is synchronized? As
far as I can tell it is written with WRITE_ONCE, only ever set to
NULL, and only used for comparisons.

> +
> +	if (READ_ONCE(binding->dev) != dev)
> +		return false;

[Severity: High]
On the leased path, can a TX binding still be created on the physical
device after that device's unregister walk has finished, leaving
binding->dev dangling?

The setup is a physical device P (NETMEM_TX_DMA) with a queue leased
to a netkit device N, and P being unregistered:

unregister_netdevice_many_notify(P)
  P->reg_state = NETREG_UNREGISTERING
  NETDEV_UNREGISTER notifiers:
    netdev_genl_netdevice_event()     (subsys_initcall, runs first)
      netdev_lock(P)
      net_devmem_dev_unregister(P)
      netdev_unlock(P)
    ... other notifiers ...
    netkit notifier                   (module_init, runs later)
      netkit_check_lease_unregister()
        unregister_netdevice_many(N)

During this window N is still NETREG_REGISTERED. An unprivileged
NETDEV_CMD_BIND_TX on N therefore passes netdev_get_by_index_lock().
For P, netdev_find_netmem_tx_dev() checks only this:

		if (netif_device_present(phys_dev) &&
		    phys_dev->netmem_tx == NETMEM_TX_DMA)
			return phys_dev;

Unregistration does not clear __LINK_STATE_PRESENT. After that,
netdev_nl_bind_tx_doit() does:

	if (bind_dev != netdev)
		netdev_lock(bind_dev);
	...
	binding = net_devmem_bind_dmabuf(bind_dev,
					 bind_dev != netdev ? netdev : NULL,
					 ...

Nothing re-checks bind_dev->reg_state, so the code inserts a LIVE
binding with binding->dev == P and maps the dma_buf.

When N unregisters later, this function clears vdev and then returns
false at this check, because binding->dev is P and not N. P is freed
in netdev_run_todo() once netkit_uninit() drops the lease reference.
Any later NETDEV_UNREGISTER rebroadcast happens with
NETREG_UNREGISTERED, so net_devmem_dev_unregister() returns early and
never sees the binding.

When the socket closes, netdev_nl_sock_priv_destroy() and
__net_devmem_dmabuf_binding_free() call netdev_hold() and
netdev_lock() on the freed P. That matches the oops in the commit
message, but on the leased path named in the second Fixes: tag. The
dma_buf also stays mapped against the removed device. Nothing later
in the series seems to touch net/core.

The direct case looks safe, because netdev_get_by_index_lock() rejects
a device that is no longer registered. Would it make sense to reject
bind_dev->reg_state != NETREG_REGISTERED (or bind_dev->moving_ns)
after netdev_lock(bind_dev) in netdev_nl_bind_tx_doit()?

> +
> +	__xa_clear_mark(&net_devmem_dmabuf_bindings, xa_idx,
> +			NET_DEVMEM_BINDING_LIVE);
> +	return true;
> +}
> +
>  static void net_devmem_dev_detach(struct net_devmem_dmabuf_binding *binding,
>  				  struct net_device *dev)
>  {
>  	mutex_lock(&binding->lock);
>  	WRITE_ONCE(binding->dev, NULL);
> +	WRITE_ONCE(binding->vdev, NULL);
>  	if (!netif_is_queue_leasee(dev))
>  		net_devmem_dmabuf_binding_unmap(binding);
>  	mutex_unlock(&binding->lock);

[ ... ]

> @@ -229,7 +248,8 @@ void net_devmem_dev_unregister(struct net_device *dev)
>  
>  	xa_lock(&net_devmem_dmabuf_bindings);
>  	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
> -		if (!net_devmem_dev_unregister_rx(binding, xa_idx, dev))
> +		if (!net_devmem_dev_unregister_rx(binding, xa_idx, dev) &&
> +		    !net_devmem_dev_unregister_tx(binding, xa_idx, dev))
>  			continue;
>  
>  		xa_unlock(&net_devmem_dmabuf_bindings);

[Severity: High]
Can the binding be freed while net_devmem_dev_detach() is still inside
mutex_unlock(&binding->lock)?

The walk now also selects TX bindings whose percpu_ref may already
have reached zero. An example is a binding whose netlink socket is
closed and whose last net_iov reference was dropped when P's
dev_close() or dev_shutdown() freed the TX skbs. For such a binding,
__net_devmem_dmabuf_binding_free() may be pending or running. The
walk takes no reference before xa_unlock() and the call to
net_devmem_dev_detach().

The free worker decides whether to serialize with the walk by looking
at binding->dev:

	mutex_lock(&binding->lock);
	dev = binding->dev;
	if (dev)
		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
	mutex_unlock(&binding->lock);

	if (dev)
		netdev_lock(dev);
	...
	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
	...
	kfree(binding);

Suppose the worker blocks on that first mutex_lock() while detach
holds the lock (dma_buf_unmap_attachment_unlocked() can sleep). When
it gets the lock it reads dev == NULL, skips netdev_lock(), and goes
on to kfree(binding).

__mutex_unlock_slowpath() releases the owner field before it takes
lock->wait_lock. If the worker acquires the mutex in that gap, the
unlocking thread then takes wait_lock inside freed memory. The
mutex_unlock() kerneldoc forbids this:

  mutex_unlock() can NOT directly be used to release an object such
  that another concurrent task can free it.

The previous patch in the series ("net: devmem: unmap dma_buf
synchronously on queue uninstall") relies on the worker taking
binding->dev's instance lock to keep a walked binding alive. That
protection is gone once detach clears dev and releases the mutex.

Should the walk and the final free be serialized by something that
does not depend on binding->dev, for example a global mutex held by
both across the whole detach?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015163915.1166043-1-almasrymina%40google.com
