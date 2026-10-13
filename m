Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1421FCC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED2610F946;
	Tue, 13 Oct 2026 18:14:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386D110E16E
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:14:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 369D9602C3;
 Tue, 13 Oct 2026 18:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8975D1F000FF;
 Tue, 13 Oct 2026 18:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791915264;
 bh=yRTW/dH5AcddNS+HWfKGncCOuxQwSkTjx47Dtov2j6k=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=TPD3wAWdcLL9hitN4qecoU35ovIN01iCzNcwSSloL4Nog0YaTiD+Lbx5iolfN/7tG
 dwlY6AhShr8w7aI2MusDvnbR+JSTXDMf12b0bRZ2KaHZJ8xuyw1eTOvfXwSSpapG2s
 CC36fcB0/SCDtaycY0ThZ4O+wH2wym0YZJ55UFpPZQKPjeyBE6VGN4ko+w69FPF7Ks
 c2wwTNE1TyAQC+/kPveSHzwctGQpK038JoeEaxTRcXvyvfVqiwU2iQgIl/D1xLRSJ3
 NvO2HS15qlpZOhoWjvazmgjGMiIvDbHO1hhPNbcdU/R0jizuCtUeTaQI5GZKOJdGj3
 BwXRCInusU+MQ==
Subject: Re: [PATCH net v2 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
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
Date: Tue, 13 Oct 2026 18:14:22 +0000
Message-ID: <179191526299.434549.7888465945343049764@kernel.org>
In-Reply-To: <20261012174300.2338784-2-almasrymina@google.com>
References: <20261012174300.2338784-2-almasrymina@google.com>
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

Critical: 0 · High: 2 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The same dma_unmap_sg_attrs() slab-use-after-free the patch
  claims to fix can still happen for RX bindings made on a virtual…
- [High] net_devmem_dev_unregister_rx() adds a new writer of binding->dev
  (and a new unmap).

Pre-existing issues:
- [Low] Not a valid finding against the final series state; kept only
  because requires_validation=true.

--

net: devmem: unmap dma_buf synchronously on queue uninstall

This adds net_devmem_dmabuf_binding_unmap(). The dma-buf attachment is
now unmapped when the last bound RX queue is uninstalled, and also on
NETDEV_UNREGISTER for unbound RX bindings, to avoid a use-after-free of
dma_dev in dma_unmap_sg_attrs(). Bindings now stay in
net_devmem_dmabuf_bindings until they are freed, and an xarray mark hides
unbound ones from TX lookups.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4d60654ce7fd..02d607cc87217 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -129,10 +151,11 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  	unsigned long xa_idx;
>  	unsigned int rxq_idx;
>  
> -	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> +	xa_clear_mark(&net_devmem_dmabuf_bindings, binding->id,
> +		      NET_DEVMEM_BINDING_LIVE);
>  
>  	/* Ensure no tx net_devmem_lookup_dmabuf() are in flight after the
> -	 * erase.
> +	 * mark is cleared.
>  	 */
>  	synchronize_net();
>  

[ ... ]

> @@ -153,6 +176,35 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  	percpu_ref_kill(&binding->ref);
>  }
>  
> +static void
> +net_devmem_dev_unregister_rx(struct net_devmem_dmabuf_binding *binding,
> +			     unsigned long xa_idx, struct net_device *dev)
> +{
> +	if (xa_get_mark(&net_devmem_dmabuf_bindings, xa_idx,
> +			NET_DEVMEM_BINDING_LIVE) ||
> +	    READ_ONCE(binding->dev) != dev)
> +		return;
> +
> +	mutex_lock(&binding->lock);
> +	WRITE_ONCE(binding->dev, NULL);
> +	if (!netif_is_queue_leasee(dev))
> +		net_devmem_dmabuf_binding_unmap(binding);
> +	mutex_unlock(&binding->lock);
> +}

[Severity: High]

Can this race with net_devmem_unbind_dmabuf() and set binding->dev to
NULL while the unbind is still walking bound_rxqs?

net_devmem_dev_unregister() is called from netdev_genl_netdevice_event()
before netdev_lock(netdev) is taken. That means this writer holds only
RTNL, net_devmem_lock and binding->lock.

The socket close path holds netdev_lock(dev) but not binding->lock:

netdev_nl_sock_priv_destroy()
    netdev_lock(dev);
    net_devmem_unbind_dmabuf(binding);
        xa_clear_mark(..., NET_DEVMEM_BINDING_LIVE);
        synchronize_net();
        xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
            ...
            netif_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
        }

Clearing the mark is what makes this walk treat the binding as unbound.
At least two paths deliver NETDEV_UNREGISTER after the instance lock has
been dropped and while bound_rxqs is still populated:

- __dev_change_net_namespace() calls netdev_unlock_ops() after
  dev_shutdown(), then call_netdevice_notifiers(NETDEV_UNREGISTER, dev).
  It never calls dev_memory_provider_uninstall().

- For a netkit leasee, unregister_netdevice_many_notify() runs the
  notifiers after netdev_unlock_ops(). The bound rxq is only uninstalled
  later, from ndo_uninit (netkit_uninit()->netkit_queue_unlease()).

Suppose the unbind is sleeping in synchronize_net() during that window.
This function then sees !LIVE and binding->dev == dev, and sets
binding->dev to NULL. For a physical device it also unmaps the dma-buf
while the binding is still the installed memory provider on the RX
queues.

The unbind loop then calls netif_mp_close_rxq(NULL, ...), which
dereferences dev straight away:

	if (WARN_ON_ONCE(rxq_idx >= dev->real_num_rx_queues))
		return;

Before this patch, binding->dev was only written by
mp_dmabuf_devmem_uninstall() under the netdev instance lock. Does
anything else serialize this walk with an unbind that is in progress?

> +
> +void net_devmem_dev_unregister(struct net_device *dev)
> +{
> +	struct net_devmem_dmabuf_binding *binding;
> +	unsigned long xa_idx;
> +
> +	mutex_lock(&net_devmem_lock);
> +	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
> +		if (binding->direction == DMA_FROM_DEVICE)
> +			net_devmem_dev_unregister_rx(binding, xa_idx, dev);
> +	}
> +	mutex_unlock(&net_devmem_lock);
> +}

[Severity: Low]

This is a pre-existing issue, not one introduced by this patch, but only
DMA_FROM_DEVICE bindings are handled here.

After NETDEV_UNREGISTER, TX bindings created by netdev_nl_bind_tx_doit()
still keep their dma-buf mapping. Their binding->dev also still points at
the unregistered net_device, and netdev_nl_sock_priv_destroy() reads it
later.

The next patch in the series, "net: devmem: detach TX bindings on
NETDEV_UNREGISTER", adds net_devmem_dev_unregister_tx() and an else
branch here for TX bindings. That appears to resolve this by the end of
the series.

[ ... ]

> @@ -529,16 +585,19 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
>  	unsigned long xa_idx;
>  
>  	xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
> -		if (bound_rxq == rxq) {
> -			xa_erase(&binding->bound_rxqs, xa_idx);
> -			if (xa_empty(&binding->bound_rxqs)) {
> -				mutex_lock(&binding->lock);
> -				ASSERT_EXCLUSIVE_WRITER(binding->dev);
> -				WRITE_ONCE(binding->dev, NULL);
> -				mutex_unlock(&binding->lock);
> -			}
> -			break;
> +		if (bound_rxq != rxq)
> +			continue;
> +
> +		xa_erase(&binding->bound_rxqs, xa_idx);
> +		if (xa_empty(&binding->bound_rxqs)) {
> +			mutex_lock(&binding->lock);
> +			ASSERT_EXCLUSIVE_WRITER(binding->dev);
> +			WRITE_ONCE(binding->dev, NULL);
> +			if (!rxq->lease)
> +				net_devmem_dmabuf_binding_unmap(binding);

[Severity: High]

Is the same use-after-free still reachable for RX bindings made on a
netkit device that leases a queue from a physical NIC?

In netdev_nl_bind_rx_doit(), dma_dev is resolved through the lease to
the physical device's DMA device
(netdev_nl_get_dma_dev()->netdev_queue_get_dma_dev()). However,
binding->dev is the virtual netdev, and bound_rxqs holds the virtual rxq.

The only uninstall this binding gets comes from the unlease path, and it
runs while rxq->lease is still set:

netkit_uninit()
  netkit_queue_unlease()
    netdev_rx_queue_unlease()
      netif_rxq_cleanup_unlease()
        __netif_mp_uninstall_rxq(virt_rxq, &p)
          mp_dmabuf_devmem_uninstall()  <- rxq->lease != NULL, no unmap
      WRITE_ONCE(rxq_src->lease, NULL);
      WRITE_ONCE(rxq_dst->lease, NULL);
      netdev_put(rxq_src->dev, &rxq_src->lease_tracker);

So binding->dev becomes NULL and the unmap is skipped.

net_devmem_dev_unregister_rx() doesn't catch it later either. On the
virtual device's unregister it skips the unmap because
netif_is_queue_leasee() is true. On the physical device's unregister,
binding->dev is the virtual device or NULL, so it never matches.

Once netdev_put() drops the lease's reference on the physical device,
nothing holds dma_dev, since dma_buf_attach() doesn't take a reference.
dma_dev can then be freed, for example by netdevsim del_device or PCI
hot-remove. The later
__net_devmem_dmabuf_binding_free()->net_devmem_dmabuf_binding_unmap()
then unmaps against the freed device.

The commit message says:

  except when a leased queue is unleased: the physical device is still
  registered and, if restarting its queue failed, may still be using
  the binding.

netkit_check_lease_unregister() triggers this unlease from inside the
physical device's own NETDEV_UNREGISTER:

	if (READ_ONCE(dev->reg_state) != NETREG_UNREGISTERING ||
	    !dev->dev.parent)
		return;
	...
	netdev_unlock_ops(dev);
	unregister_netdevice_many(&list_kill);

Is the physical device still registered in that case? Would this need to
track the device that owns dma_dev, or hold a reference on dma_dev,
instead of keying on binding->dev?

> +			mutex_unlock(&binding->lock);
>  		}
> +		break;
>  	}
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012174300.2338784-1-almasrymina%40google.com
