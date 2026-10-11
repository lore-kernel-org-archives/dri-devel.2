Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84529CA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 03:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCB910E298;
	Sun, 11 Oct 2026 03:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oA1XTyrd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB5C10E282
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 03:38:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7994760229;
 Sun, 11 Oct 2026 03:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60D31F00893;
 Sun, 11 Oct 2026 03:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791689900;
 bh=UVbZ+uffChp+H3gntHguDZmgJ9XGwAqVRvJK4Wg65lQ=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=oA1XTyrddAFmtNVWWuJ+NBdA1Tu5sXSF68aUcshjTbsRytltm3IFeD9z/A+0bdE6c
 V92RIQtHnP3NLnoCHFZR+cbOApnQ8/JDz7sIX+vB3kKFqAtDco6z80murxFbgzRJK/
 UmTY47h0Gih2oC0cvIda0OK5XYocx14oX4JHTt/3c57VinVD9sZ1Isoe4HgA8cNGy9
 OIW/nyT46FJaCrF5HWnPeeLxXyoL3Ib0JB2fnfEpx7IHxNHm/ucwaw/eLBBv6tpZ2b
 0Ou+zJpCxmnKWV5e3RcReMsQgPfMQ+GxwSbH1f80mowEW/jJUmrNlFu5C4j4sOEaJ/
 ySoUHgPwktulg==
Subject: Re: [PATCH net v1 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
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
Date: Sun, 11 Oct 2026 03:38:18 +0000
Message-ID: <179168989825.434549.9034642810701800556@kernel.org>
In-Reply-To: <20261010025532.839559-3-almasrymina@google.com>
References: <20261010025532.839559-3-almasrymina@google.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net_devmem_dev_unregister() can miss a TX binding created during
  unregistration, which leaves binding->dev dangling.
- [High] If the netlink socket closes before the device is removed, a TX
  binding can keep its DMA mapping past device removal, and the later…
- [Medium] net_devmem_dev_unregister() treats every NETDEV_UNREGISTER as
  device removal, but __dev_change_net_namespace() sends…
- [Medium] net_devmem_dev_unregister() erases binding->id from
  net_devmem_dmabuf_bindings early (devmem.c:185) but leaves the binding…
- [Low] net_devmem_dev_unregister() calls synchronize_net() once per
  matching binding inside the xa_for_each loop, in both the dev and vdev…

--

net: devmem: detach TX bindings on NETDEV_UNREGISTER

This adds net_devmem_dev_unregister(), which the netdev-genl
NETDEV_UNREGISTER notifier calls to detach TX devmem bindings from
devices that are going away.

When the physical device unregisters, the binding ID is erased, dev and
vdev are cleared, and the dma_buf is unmapped after synchronize_net().
When only the virtual device unregisters, only vdev is cleared.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 5e4070b82df44..da7b3e8abaa13 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -169,6 +169,51 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  	percpu_ref_kill(&binding->ref);
>  }
>  
> +void net_devmem_dev_unregister(struct net_device *dev)
> +{
> +	struct net_devmem_dmabuf_binding *binding;
> +	unsigned long xa_idx;
> +
> +	rcu_read_lock();
> +	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {

[Severity: High]
Can this walk miss TX bindings that are still mapped but are no longer
in net_devmem_dmabuf_bindings?

If the netlink socket closes before the device is removed,
netdev_nl_sock_priv_destroy()->net_devmem_unbind_dmabuf() does:

    xa_erase(&net_devmem_dmabuf_bindings, binding->id);
    ...
    percpu_ref_kill(&binding->ref);

TX skbs still waiting for retransmit hold binding references through
net_devmem_get_net_iov(). This includes skbs on orphaned TCP sockets
after the process exits. So the binding and its dma_buf attachment stay
alive.

When the physical device is unregistered after that, this loop only
looks at net_devmem_dmabuf_bindings and never sees that binding, so it
is not unmapped. When the last skb reference drops, the deferred free
does:

__net_devmem_dmabuf_binding_free() {
    ...
    mutex_lock(&binding->lock);
    net_devmem_dmabuf_binding_unmap(binding);
    mutex_unlock(&binding->lock);
    ...
}

That calls dma_buf_unmap_attachment_unlocked() and dma_buf_detach() on
an attachment whose ->dev belonged to the freed device.
dma_buf_dynamic_attach() stores attach->dev = dev without taking a
reference on it.

Isn't this the same dma_unmap_sg_attrs() use-after-free described in
"net: devmem: unmap dma_buf synchronously on queue uninstall"?

The commit message says the dma_buf no longer "remains attached and
mapped after device removal", but on this path it still looks mapped.
Does the tracking need to cover every binding that is still mapped,
rather than only the ones in the lookup table?

> +		if (!percpu_ref_tryget(&binding->ref))
> +			continue;
> +		rcu_read_unlock();
> +
> +		if (xa_empty(&binding->bound_rxqs)) {
> +			if (READ_ONCE(binding->dev) == dev) {
> +				xa_erase(&net_devmem_dmabuf_bindings,
> +					 binding->id);

[Severity: Medium]
Can this ID end up being erased twice?

The binding stays on the owning socket's priv->bindings list, and
binding->id does not change. When that socket closes later,
netdev_nl_sock_priv_destroy() sees binding->dev == NULL:

    if (!dev) {
        mutex_unlock(&binding->lock);
        net_devmem_unbind_dmabuf(binding);
        continue;
    }

net_devmem_unbind_dmabuf() then calls
xa_erase(&net_devmem_dmabuf_bindings, binding->id) again. It does not
check that the slot still holds this binding.

net_devmem_bind_dmabuf() allocates IDs with xa_alloc_cyclic() over
xa_limit_32b. Once the allocator wraps, a new binding B could get the
same ID while the old socket is still open. Closing the old socket would
then remove B from the global table.

After that, B's TX lookups would fail. A later net_devmem_dev_unregister()
scan would also miss B, so B->dev could dangle after B's device is
removed. It would then be passed to netdev_hold() and netdev_lock() when
B's socket closes.

This also conflicts with the comment in devmem.h:

    /* ID of this binding. Globally unique to all bindings currently
     * active.
     */

Would an xa_cmpxchg() against this binding, or erasing the ID only once,
avoid this?

> +
> +				mutex_lock(&binding->lock);
> +				WRITE_ONCE(binding->dev, NULL);
> +				WRITE_ONCE(binding->vdev, NULL);
> +				mutex_unlock(&binding->lock);
> +
> +				/* Ensure no tx net_devmem_lookup_dmabuf() or
> +				 * validate_xmit_unreadable_skb() are in flight
> +				 * after detach.
> +				 */
> +				synchronize_net();

[Severity: Low]
How long can RTNL end up held here? synchronize_net() runs once per
matching binding, here and again in the vdev branch below.
NETDEV_UNREGISTER notifiers run under RTNL, so each call turns into
synchronize_rcu_expedited().

NETDEV_CMD_BIND_TX is unprivileged, and the same dmabuf can be bound
many times. A user with many TX bindings on a device therefore adds one
expedited grace period per binding to that device's unregistration, all
while RTNL is held.

Could the loop erase and clear all matching bindings first, call
synchronize_net() once, and then unmap them?

> +
> +				mutex_lock(&binding->lock);
> +				net_devmem_dmabuf_binding_unmap(binding);
> +				mutex_unlock(&binding->lock);
> +			} else if (READ_ONCE(binding->vdev) == dev) {
> +				mutex_lock(&binding->lock);
> +				WRITE_ONCE(binding->vdev, NULL);
> +				mutex_unlock(&binding->lock);

[Severity: High]
If a bind-tx races with the physical device's unregistration, can the
binding reach this branch with binding->dev still dangling?

net_devmem_dev_unregister() walks the table once, and nothing
serializes that walk against netdev_nl_bind_tx_doit(). Take a netkit
device V with a queue leased from physical device P.
netdev_find_netmem_tx_dev() picks P with:

    if (netif_device_present(phys_dev) &&
        phys_dev->netmem_tx == NETMEM_TX_DMA)
            return phys_dev;

netif_device_present() stays true during unregistration.
netdev_nl_bind_tx_doit() then does:

    if (bind_dev != netdev)
        netdev_lock(bind_dev);
    ...
    binding = net_devmem_bind_dmabuf(bind_dev, ...

It never checks bind_dev->reg_state.

During P's unregistration, the NETDEV_UNREGISTER notifiers run without
P's instance lock. netdev-genl registers its notifier from
subsys_initcall and netkit registers its notifier from module_init, so
the sequence looks like this:

unregister_netdevice_many_notify(P)
  call_netdevice_notifiers(NETDEV_UNREGISTER, P)
    netdev_genl_netdevice_event()
      net_devmem_dev_unregister(P)   <- walk finishes
                                       bind-tx on V publishes a
                                       binding with dev = P
    netkit_check_lease_unregister(P)
      unregisters V
        net_devmem_dev_unregister(V) <- takes this vdev branch and
                                        only clears vdev

netkit_uninit()->netkit_queue_unlease() then drops the lease's hold on
P, so P can be freed while binding->dev still points at it.

When the netlink socket closes, netdev_nl_sock_priv_destroy() calls
netdev_hold() and netdev_lock() on the freed net_device. That is the
same use-after-free shown in the commit message. The dma_buf mapping on
P's DMA device is also never unmapped.

Does netdev_nl_bind_tx_doit() need a reg_state check under
netdev_lock(bind_dev), or some other way to serialize bind against this
detach?

> +
> +				synchronize_net();
> +			}
> +		}
> +
> +		net_devmem_dmabuf_binding_put(binding);
> +		rcu_read_lock();
> +	}
> +	rcu_read_unlock();
> +}

[ ... ]

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 33b9f4eb9565a..5bfcd513fb0e8 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1487,6 +1487,7 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
>  		netdev_unlock_full_to_ops(netdev);
>  		break;
>  	case NETDEV_UNREGISTER:
> +		net_devmem_dev_unregister(netdev);

[Severity: Medium]
Does this also tear down TX bindings when a device is only moving to
another netns?

__dev_change_net_namespace() sends NETDEV_UNREGISTER for a device that
stays alive:

    /* Notify protocols, that we are about to destroy
     * this device. They should clean all the things.
     *
     * Note that dev->reg_state stays at NETREG_REGISTERED.
     * This is wanted because this way 8021q and macvlan know
     * the device is just moving and can keep their slaves up.
     */
    call_netdevice_notifiers(NETDEV_UNREGISTER, dev);

net_devmem_dev_unregister() does not check reg_state. If the physical
device moves, the binding ID is erased, dev and vdev are cleared, and
the dma_buf is unmapped, all while the device still exists.

If only the netkit vdev moves into a container, binding->vdev is cleared
and sends through the vdev fail with -ENODEV. Userspace is not told, and
the binding stays on priv->bindings, so every later sendmsg with that
dmabuf ID fails.

netkit_check_lease_unregister(), which runs in the same notifier flow,
does check this:

    if (READ_ONCE(dev->reg_state) != NETREG_UNREGISTERING ||
        !dev->dev.parent)
            return;

A netns move leaves RX bindings alone, because
dev_memory_provider_uninstall() only runs from
unregister_netdevice_many_notify().

Should this path skip devices whose reg_state is not
NETREG_UNREGISTERING, so that TX and RX bindings behave the same way?

>  		netdev_lock(netdev);
>  		netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_DEL_NTF);
>  		netdev_unlock(netdev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010025532.839559-1-almasrymina%40google.com
