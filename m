Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C5ECCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 16:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2CF10E083;
	Sun, 18 Oct 2026 16:01:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF51D10E083
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 16:01:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C1E741EEF;
 Sun, 18 Oct 2026 16:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1BB1F000C4;
 Sun, 18 Oct 2026 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792339268;
 bh=B/YZa7GqJFgxEv8EuhiETJ4RJQg3M12AYmDUEctVniI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=T4GyAZArXU0qcGkZhT0CjCdyQay0LDgzf7NppiOUIM6EyzN4A7FhK0Et2rfE1t2Au
 /Rcrj7hfDGVPvws6oi8XiOirqZNt1KOL4foKGflYwtTFLmnCfnAZIm1qph6tiyrVQP
 VJyzE0wKY12Uv/PtYV4qv9lRH52n6XkXsvj4qa4LC1RT98mkFVrjiLc1r4yKm43O4I
 2TSXnsGoKFdlRd/DmPWvm54uLuRcbNnpD8kWMarMZnJA4RLnmJ8UdYJRur2kPjw9Vq
 Us/3Lb3IkswezQ/4AleiKopjz0XKCSE+1FXTL8GTFQquS/+qquGcccpmwVRooblT7r
 G4jxyRLGimHEQ==
Subject: Re: [PATCH net v4 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
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
Date: Sun, 18 Oct 2026 16:01:06 +0000
Message-ID: <179233926649.3135.15359480619016992874@kernel.org>
In-Reply-To: <20261015163915.1166043-2-almasrymina@google.com>
References: <20261015163915.1166043-2-almasrymina@google.com>
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

Critical: 0 · High: 3 · Medium: 0 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch leaves TX bindings (NETDEV_CMD_BIND_TX,
  DMA_TO_DEVICE) uncovered.
- [High] Leased-queue RX bindings still hit the dma_unmap_sg_attrs() UAF
  that the commit says it fixes.
- [High] There is a use-after-free race between the NETDEV_UNREGISTER
  walk and the binding free worker.
- [Low] The updated refcount comment in struct net_devmem_dmabuf_binding
  (net/core/devmem.h:41-42) says 'RX bindings are unmapped earlier, once…

Pre-existing issues:
- [Medium] This patch was not the cause, but netif_mp_close_rxq() now
  returns non-zero when queue reconfiguration fails (the old queue may…

--

net: devmem: unmap dma_buf synchronously on queue uninstall

This patch unmaps devmem RX dma_buf attachments early, at two points: when
the last bound RX queue is uninstalled, and in net_devmem_unbind_dmabuf()
once the binding's queues are closed. This avoids a use-after-free of
dma_dev in the deferred unmap. Bindings now stay in the global xarray until
they are freed, unbound ones are hidden from TX lookup by an xarray mark,
and leftover RX bindings are detached and unmapped on NETDEV_UNREGISTER.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4d60654ce7fd..20d95b24d5951 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -74,9 +94,23 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
>  		  size, avail))
>  		gen_pool_destroy(binding->chunk_pool);
>  
> -	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
> -					  binding->direction);
> -	dma_buf_detach(binding->dmabuf, binding->attachment);
> +	mutex_lock(&binding->lock);
> +	dev = binding->dev;
> +	if (dev)
> +		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
> +	mutex_unlock(&binding->lock);
> +
> +	if (dev)
> +		netdev_lock(dev);
> +	mutex_lock(&binding->lock);
> +	net_devmem_dmabuf_binding_unmap(binding);
> +	mutex_unlock(&binding->lock);
> +	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> +	if (dev) {
> +		netdev_unlock(dev);
> +		netdev_put(dev, &dev_tracker);
> +	}

[Severity: High]
For a TX binding (NETDEV_CMD_BIND_TX, DMA_TO_DEVICE), can this code touch
a net_device that has already been freed?

At this commit nothing clears binding->dev or unmaps a TX binding when its
device is unregistered:

- The unmap in net_devmem_unbind_dmabuf() only runs for DMA_FROM_DEVICE.
- net_devmem_dev_unregister_rx() only matches DMA_FROM_DEVICE.
- mp_dmabuf_devmem_uninstall() only runs for RX queues.

Here is the sequence. The netlink socket is closed while skbs waiting for
retransmit still hold binding refs. The device is then unregistered and
freed. When the last skb is freed, this worker is scheduled.

netdev_hold() and netdev_lock() would then run on the freed net_device.
After that comes the original dma_unmap_sg_attrs() use-after-free on the
freed dma_dev.

The later commit "net: devmem: detach TX bindings on NETDEV_UNREGISTER" in
this series adds net_devmem_dev_unregister_tx() and seems to fix this, so
the problem only exists in the tree state at this commit.

> +
>  	dma_buf_put(binding->dmabuf);
>  	xa_destroy(&binding->bound_rxqs);
>  	percpu_ref_exit(&binding->ref);

[ ... ]

> @@ -147,12 +183,62 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)

[ ... ]

> +static void net_devmem_dev_detach(struct net_devmem_dmabuf_binding *binding,
> +				  struct net_device *dev)
> +{
> +	mutex_lock(&binding->lock);
> +	WRITE_ONCE(binding->dev, NULL);
> +	if (!netif_is_queue_leasee(dev))
> +		net_devmem_dmabuf_binding_unmap(binding);
> +	mutex_unlock(&binding->lock);
> +}
> +
> +void net_devmem_dev_unregister(struct net_device *dev)
> +{
> +	struct net_devmem_dmabuf_binding *binding;
> +	unsigned long xa_idx;
> +
> +	netdev_assert_locked(dev);
> +
> +	if (dev->reg_state != NETREG_UNREGISTERING)
> +		return;
> +
> +	xa_lock(&net_devmem_dmabuf_bindings);
> +	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
> +		if (!net_devmem_dev_unregister_rx(binding, xa_idx, dev))
> +			continue;
> +
> +		xa_unlock(&net_devmem_dmabuf_bindings);
> +		net_devmem_dev_detach(binding, dev);
> +		xa_lock(&net_devmem_dmabuf_bindings);

[Severity: High]
Can the free worker kfree() the binding while this thread is still inside
mutex_unlock(&binding->lock) in net_devmem_dev_detach()?

After xa_lock is dropped, nothing pins the binding. The commit message
relies on __net_devmem_dmabuf_binding_free() blocking on netdev_lock(dev).
That only happens if the worker reads binding->dev before the walk clears
it.

Take a binding that is already unbound (percpu_ref_kill() has run) but is
still referenced by page pools, RX tokens or skbs on other CPUs:

CPU1 (NETDEV_UNREGISTER, holds netdev_lock(dev))
net_devmem_dev_unregister()
  xa_unlock(&net_devmem_dmabuf_bindings);
  net_devmem_dev_detach()
    mutex_lock(&binding->lock);
    WRITE_ONCE(binding->dev, NULL);
    net_devmem_dmabuf_binding_unmap(binding);
    mutex_unlock(&binding->lock);
      (still inside __mutex_unlock_slowpath())

CPU2 (last ref dropped, worker)
__net_devmem_dmabuf_binding_free()
  mutex_lock(&binding->lock);   /* acquired once CPU1 releases owner */
  dev = binding->dev;           /* NULL, so netdev_lock() is skipped */
  mutex_unlock(&binding->lock);
  ...
  xa_erase(&net_devmem_dmabuf_bindings, binding->id);
  ...
  kfree(binding);

Documentation/locking/mutex-design.rst notes that mutex_unlock() may still
access the mutex structure after it has internally released the lock. So
another context that acquires the mutex cannot assume the unlocker is done
with it.

Should the walk take a reference on the binding (for example with
percpu_ref_tryget()) before it drops the xarray lock?

This is still present at the end of the series. After "net: devmem: detach
TX bindings on NETDEV_UNREGISTER", the walk also detaches TX bindings that
only in-flight skbs keep alive, so the window gets wider.

> +	}
> +	xa_unlock(&net_devmem_dmabuf_bindings);
> +}

[ ... ]

> @@ -529,16 +615,19 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,

[ ... ]

> +		xa_erase(&binding->bound_rxqs, xa_idx);
> +		if (xa_empty(&binding->bound_rxqs)) {
> +			mutex_lock(&binding->lock);
> +			ASSERT_EXCLUSIVE_WRITER(binding->dev);
> +			WRITE_ONCE(binding->dev, NULL);
> +			if (!rxq->lease)
> +				net_devmem_dmabuf_binding_unmap(binding);
> +			mutex_unlock(&binding->lock);

[Severity: High]
Does this leave the dma_buf attachment mapped, with no path left that
unmaps it before the physical NIC goes away?

When bind-rx targets a leased queue on a virtual device such as netkit,
binding->dev is the virtual device. The attachment, however, is mapped for
the physical NIC's dma_dev, which comes from netdev_nl_get_dma_dev().

On netkit teardown, netkit_uninit()->netdev_rx_queue_unlease()->
netif_rxq_cleanup_unlease() does:

	__netif_mp_close_rxq(phys_rxq->dev, rxq_idx, &p);
	__netif_mp_uninstall_rxq(virt_rxq, &p);

There, the new return value of __netif_mp_close_rxq() is discarded. Also,
virt_rxq->lease is only cleared after netif_rxq_cleanup_unlease() returns.
So on this path binding->dev is set to NULL and the unmap is always
skipped. net_devmem_dev_detach() does the same when
netif_is_queue_leasee(dev) is true.

After that, net_devmem_dev_unregister() for the physical NIC cannot match
the binding, because binding->dev is NULL. net_devmem_unbind_dmabuf() also
skips the unmap for the same reason.

Suppose the physical NIC is then removed and the netlink socket is closed.
Wouldn't __net_devmem_dmabuf_binding_free() unmap the attachment against
the freed physical dma_dev? That is the dma_unmap_sg_attrs()
use-after-free described in the commit message.

Could netif_rxq_cleanup_unlease() use the result of __netif_mp_close_rxq()
to decide whether it is safe to unmap here? This looks unchanged at the end
of the series.

> +		}
> +		break;
>  	}
>  }

> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 4a293a7d1149c..a834e0f698c7e 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h

[ ... ]

> @@ -38,7 +38,8 @@ struct net_devmem_dmabuf_binding {
>  	 *
>  	 * The binding undos itself and unmaps the underlying dmabuf once all
>  	 * those refs are dropped and the binding is no longer desired or in
> -	 * use.
> +	 * use. RX bindings are unmapped earlier, once they are no longer
> +	 * installed on any queue.

[Severity: Low]
This isn't a bug, but is this comment accurate? Several paths leave an RX
binding mapped after it is no longer installed on any queue:

- mp_dmabuf_devmem_uninstall() skips the unmap when rxq->lease is set.
- net_devmem_unbind_dmabuf() skips it when a queue close failed (busy) or
  when binding->dev is already NULL.
- net_devmem_dev_detach() skips it for queue leasees.

In those cases the unmap only happens in __net_devmem_dmabuf_binding_free().
Should the comment mention these exceptions?

[ ... ]

> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index 00a7011eb4d57..a7261fedd5e76 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c

[ ... ]

> @@ -289,35 +289,41 @@ static void __netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,

[ ... ]

>  	err = netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg[0], &qcfg[1]);
> -	WARN_ON(err && err != -ENETDOWN);
> +	if (err == -ENETDOWN)
> +		return 0;
> +	WARN_ON(err);
> +	return err;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but netif_mp_close_rxq() now
reports a failed queue restart, and only devmem acts on that. In
io_uring/zcrx.c, io_close_queue() still ignores the result and unmaps
unconditionally:

		if (ifq->if_rxq != -1)
			netif_mp_close_rxq(netdev, ifq->if_rxq, &p);

		scoped_guard(mutex, &ifq->pp_lock)
			io_zcrx_unmap_areas(ifq);

The reconfiguration can fail, for example with -ENOMEM from
ndo_queue_mem_alloc, and the old queue can keep running on the zcrx areas.
Could the device then DMA into areas that were just unmapped? io_uring
behaved the same way before this patch.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015163915.1166043-1-almasrymina%40google.com
