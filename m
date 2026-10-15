Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA82CCA464
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D9E112454;
	Thu, 15 Oct 2026 19:21:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305B8112459
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 19:21:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97AE560A57;
 Thu, 15 Oct 2026 19:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC941F000C5;
 Thu, 15 Oct 2026 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792092068;
 bh=hQ0l1gT6MrKjFj/MQCsInYw+mZYzDcs0i4WoLYem5W8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=czfXt7pC1ibxFIiT+JTIGuX4E//zYVl/xGDDWH9eZCCKJgIINf8yBAS00U3tSfSrE
 aKrYlfikUmYldsCOYdoVks4dw39FDTySc4M/9+q3kbsvFg18cqowujhT2VNmHyA/9T
 eSTgR76Ut6xm/H+udCvjlPLQlhueUSrmY7KzxU5xle6VKCbxoD9Nsv8me/DRCLddT8
 Tt/dX7XGdBvUGWckAXixZamD643vETsFOpcUXDB5a9WM/X6TH1ykvz1ZIlxSmUXfTL
 y/6e/RcoIRI1p+ZE537qjtQaNDrJhjYjycwDmqUkjtTsVHgUCGiBORFo/9aImKLBN8
 jQP05Fkh++v2A==
Subject: Re: [PATCH net v3 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
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
Date: Thu, 15 Oct 2026 19:21:06 +0000
Message-ID: <179209206664.434549.4640692175922263115@kernel.org>
In-Reply-To: <20261014161754.3782346-3-almasrymina@google.com>
References: <20261014161754.3782346-3-almasrymina@google.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The TX-binding dangling `binding->dev` use-after-free can still
  happen through a race in the leased-queue (netkit) bind-tx path.

--

net: devmem: detach TX bindings on NETDEV_UNREGISTER

This extends net_devmem_dev_unregister() to cover TX devmem bindings.
When binding->dev unregisters, the patch clears the binding's LIVE mark
and both dev and vdev, then unmaps the dma_buf after synchronize_net().
When only binding->vdev unregisters, it clears just binding->vdev.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 93cc2815d935a..dd07203076808 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -192,9 +192,55 @@ net_devmem_dev_unregister_rx(struct net_devmem_dmabuf_binding *binding,
>  	mutex_unlock(&binding->lock);
>  }
>  
> +static bool
> +net_devmem_dev_unregister_tx(struct net_devmem_dmabuf_binding *binding,
> +			     unsigned long xa_idx, struct net_device *dev)
> +{
> +	if (READ_ONCE(binding->dev) == dev) {

[ ... ]

> +		return true;
> +	}
> +
> +	if (READ_ONCE(binding->vdev) == dev) {
> +		mutex_lock(&binding->lock);
> +		WRITE_ONCE(binding->vdev, NULL);
> +		mutex_unlock(&binding->lock);
> +	}

[Severity: High]
Can a TX binding still end up with a dangling binding->dev through the
leased queue (netkit) bind-tx path?

In netdev_nl_bind_tx_doit(), when the target is a NETMEM_TX_NO_DMA
leasee, netdev_find_netmem_tx_dev() finds the physical device. It reads
the lease without taking the physical device's lock. It also only checks
netif_device_present(), and the unregister path never clears that:

net/core/netdev-genl.c:netdev_find_netmem_tx_dev() {
    ...
		phys_dev = lease_rxq->dev;
		if (netif_device_present(phys_dev) &&
		    phys_dev->netmem_tx == NETMEM_TX_DMA)
			return phys_dev;
    ...
}

The bind then goes ahead without rechecking bind_dev->reg_state:

net/core/netdev-genl.c:netdev_nl_bind_tx_doit() {
    ...
	if (bind_dev != netdev)
		netdev_lock(bind_dev);

	dma_dev = netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);

	binding = net_devmem_bind_dmabuf(bind_dev,
    ...
}

On the direct path, netdev_get_by_index_lock()->netdev_put_lock() rejects
reg_state > NETREG_REGISTERED. Nothing does the same check for bind_dev
here.

The sequence seems to be:

1. The physical device P unregisters.
   unregister_netdevice_many_notify() sets P->reg_state to
   NETREG_UNREGISTERING and calls the NETDEV_UNREGISTER notifiers.

2. The netdev-genl notifier runs before netkit's, because it was
   registered earlier with equal priority. It calls
   net_devmem_dev_unregister(P) under netdev_lock(P).

3. A concurrent unprivileged bind-tx on netkit already holds netkit's
   lock and is blocked in netdev_lock(P). It now continues. The lease is
   still in place, so it creates a binding with dev = P and
   vdev = netkit, maps the dmabuf, and marks the binding LIVE.

4. netkit_check_lease_unregister(P) unregisters netkit. In
   net_devmem_dev_unregister(netkit)->net_devmem_dev_unregister_tx(),
   binding->dev is P, so only the branch above runs and only
   binding->vdev is cleared.

5. netdev_run_todo() sets P->reg_state to NETREG_UNREGISTERED. Any
   rebroadcast NETDEV_UNREGISTER then returns early at:

	if (dev->reg_state != NETREG_UNREGISTERING)
		return;

   net_devmem_bind_dmabuf() sets binding->dev = dev without taking a
   netdev_hold(), so P can be freed.

6. When the socket closes, netdev_nl_sock_priv_destroy() reads the stale
   binding->dev and calls netdev_hold() and netdev_lock() on it. This is
   the same oops quoted in the commit message. The dma_buf also stays
   attached to the removed device until the final free.

NETDEV_CMD_BIND_TX is unprivileged. Hitting this needs a race with the
physical device's unregistration. That is still the path the commit
message and the 1abe839b34ae Fixes: tag say this patch fixes. Later
patches in the series don't appear to touch net/ or drivers/net/netkit.c
to address it.

Would it make sense to recheck bind_dev->reg_state after
netdev_lock(bind_dev) in netdev_nl_bind_tx_doit()? Extending the
unregister walk doesn't look like it can close this window on its own.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014161754.3782346-1-almasrymina%40google.com
