Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38190606A32C
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXWTxYAc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D8B910EAD8;
	Sun,  1 Nov 2026 23:01:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86EC610EAD8
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:01:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B7F9B605CB;
 Sun,  1 Nov 2026 23:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E825E1F000C1;
 Sun,  1 Nov 2026 23:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793574083;
 bh=BPSVnso4oEFqCvt1xPqxZev+hvDlmid64+VAE04eWZU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=cXWTxYAc09HjtO/v2x8wJl1A3vpPnQu4XURrpMEGf25Ho9paKJlJ/sV+LjPRA6XWv
 NFIvBouVCFEusyVeqMvDhIJK8tcSAFbR9fLZycsiy4yB4NEn8x19YP7H8+rSOumaPX
 jd1tGm+0sRa4dxl8fbo4I3cDBO3/h96x+1dGsIB0B+bWA0+xFmslqeveOlQS7jTelt
 1L6po2NUqwOgtQ9BX0ys7Bwgxu9v/9XLzXrFKO1LWFXw5XUCekx3Y0ZYjL5RaiLD3S
 0CODRHJQuVurRVyY4zUVAdf9ZLI/efrl+f0jqqMiNmOSz4B+IrGFpWsHP6CfQj2A3G
 1RSbalBd8E1zA==
Subject: Re: [PATCH net v5 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, pabeni@redhat.com, sdf@fomichev.me,
 kaiyuanz@google.com, kuba@kernel.org, bobbyeshleman@meta.com,
 asml.silence@gmail.com, dw@davidwei.uk, ap420073@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 andrew+netdev@lunn.ch, sdf.kernel@gmail.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, daniel@iogearbox.net, razor@blackwall.org,
 tariqt@nvidia.com, kaifengw@google.com, dtatulea@nvidia.com
Date: Sun, 01 Nov 2026 23:01:21 +0000
Message-ID: <179357408146.3131.2882435952119280563@kernel.org>
In-Reply-To: <20261030083539.777877-2-almasrymina@google.com>
References: <20261030083539.777877-2-almasrymina@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The dma_dev use-after-free this patch says it fixes can still
  happen for RX bindings made on a virtual device that leases queues,…

Pre-existing issues:
- [Medium] At this commit, net_devmem_dev_unregister() skips TX
  (DMA_TO_DEVICE) bindings.

--

net: devmem: unmap dma_buf synchronously on queue uninstall

This commit unmaps RX devmem dma_buf bindings earlier: when the last
bound RX queue is uninstalled, when the binding is unbound, or on
NETDEV_UNREGISTER. Previously the unmap waited until the final binding
free. Bindings now stay in the global xarray until they are freed, with
an xarray mark hiding unbound ones from TX lookups, and
netif_mp_close_rxq() now reports queue restart failures. The aim is to
avoid a use-after-free of dma_dev in dma_unmap_sg_attrs() after the
device is removed.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 32fafbfa1359e..4610de805ef08 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -143,12 +228,45 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  
>  		rxq_idx = get_netdev_rx_queue_index(rxq);
>  
> -		netif_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
> +		if (netif_mp_close_rxq(binding->dev, rxq_idx, &mp_params))
> +			busy = true;
> +	}
> +
> +	if (binding->direction == DMA_FROM_DEVICE && binding->dev && !busy) {
> +		net_devmem_dmabuf_binding_unmap(binding);
> +		WRITE_ONCE(binding->dev, NULL);
>  	}
>  
>  	percpu_ref_kill(&binding->ref);
>  }
>  
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
> +		if (binding->direction != DMA_FROM_DEVICE ||
> +		    READ_ONCE(binding->dev) != dev ||
> +		    xa_get_mark(&net_devmem_dmabuf_bindings, xa_idx,
> +				NET_DEVMEM_BINDING_LIVE))
> +			continue;

[Severity: Medium]
This issue was not introduced by this patch, but at this commit TX
(DMA_TO_DEVICE) bindings are skipped here. Their binding->dev is never
cleared, and they stay mapped until __net_devmem_dmabuf_binding_free().

That has three consequences. The deferred dma_unmap_sg_attrs() can run
on a freed dma_dev. netdev_nl_sock_priv_destroy()->net_devmem_lock_dev()
can call netdev_hold() and netdev_lock() on a freed net_device. And the
invariant in the new net_devmem_lock_dev() kernel-doc does not hold for
TX bindings.

The old netdev_nl_sock_priv_destroy() already called netdev_hold() on a
stale TX binding->dev, so this predates the patch. The next patch in the
series, "net: devmem: detach TX bindings on NETDEV_UNREGISTER", appears
to fix it. That patch clears the LIVE mark, unmaps the binding and
clears dev and vdev for TX bindings with binding->dev == dev. It also
calls net_devmem_lock_dev() in __net_devmem_dmabuf_binding_free() for
both directions.

> +
> +		xa_unlock(&net_devmem_dmabuf_bindings);
> +		if (!netif_is_queue_leasee(dev))
> +			net_devmem_dmabuf_binding_unmap(binding);
> +		xa_lock(&net_devmem_dmabuf_bindings);
> +		WRITE_ONCE(binding->dev, NULL);
> +	}
> +	xa_unlock(&net_devmem_dmabuf_bindings);
> +}

[ ... ]

> @@ -551,16 +669,17 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
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
> +			if (!rxq->lease)
> +				net_devmem_dmabuf_binding_unmap(binding);
> +			ASSERT_EXCLUSIVE_WRITER(binding->dev);
> +			WRITE_ONCE(binding->dev, NULL);
>  		}
> +		break;
>  	}
>  }

[Severity: High]
Can the dma_dev use-after-free still happen for an RX binding made on a
virtual device that leases queues, such as netkit leasing from a
physical NIC?

In that case binding->dev is the netkit device and bound_rxqs holds the
netkit rxq. dma_dev is the physical NIC's DMA device, which
netdev_queue_get_dma_dev() finds by following the lease.

On unlease, the call chain is:

netkit_uninit()
  netkit_queue_unlease()
    netdev_rx_queue_unlease()
      netif_rxq_cleanup_unlease()
        __netif_mp_close_rxq(phys_rxq->dev, rxq_idx, &p);
        __netif_mp_uninstall_rxq(virt_rxq, &p);
          mp_dmabuf_devmem_uninstall()

The lease pointers are cleared only after the cleanup returns:

net/core/netdev_rx_queue.c:netdev_rx_queue_unlease() {
    ...
	netif_rxq_cleanup_unlease(rxq_src, rxq_dst);

	WRITE_ONCE(rxq_src->lease, NULL);
	WRITE_ONCE(rxq_dst->lease, NULL);
    ...
}

So rxq->lease is always non-NULL here. The unmap is skipped, but
binding->dev is still set to NULL. netif_rxq_cleanup_unlease() also
ignores the new return value of __netif_mp_close_rxq(), so even a
successful close of the physical queue leaves the mapping in place.

After this, which path unmaps the binding?

net_devmem_unbind_dmabuf() unmaps only when binding->dev is non-NULL.

net_devmem_dev_unregister() on the physical device matches only
binding->dev == dev, so it never finds this binding.

dev_memory_provider_uninstall() on the physical device calls uninstall
with the physical rxq. That never matches the netkit rxq stored in
bound_rxqs.

The binding then stays mapped until __net_devmem_dmabuf_binding_free().
If the NIC was removed before that, the call to
dma_buf_unmap_attachment()->dma_unmap_sg_attrs() uses the freed physical
dma_dev. This is the same KASAN trace quoted in the commit message.

There are two ways to reach this:

Remove the physical NIC while the netlink socket is still open.
netkit_check_lease_unregister() runs from the physical device's
NETDEV_UNREGISTER and unregisters netkit. The unlease therefore runs
while the physical device is NETREG_UNREGISTERING, which seems to
contradict this part of the commit message:

  "except when a leased queue is unleased: the physical device is
  still registered and, if restarting its queue failed, may still be
  using the binding."

Delete netkit first. The physical queue close succeeds, but the unmap
is skipped anyway. If the physical NIC is removed later, while the
socket or RX tokens still hold the binding, the deferred unmap runs on
the freed device.

The leasee branch in net_devmem_dev_unregister() has the same problem.
It skips the unmap when netif_is_queue_leasee(dev) is true but still
clears binding->dev, so nothing can unmap the binding before the
physical device goes away.

Could the lease case decide whether to unmap based on whether the
physical queue close succeeded, instead of skipping the unmap whenever
rxq->lease is set?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030083539.777877-1-almasrymina%40google.com
