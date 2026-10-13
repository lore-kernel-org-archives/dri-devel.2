Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EF3CC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A7A10E16E;
	Tue, 13 Oct 2026 18:14:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA61110E944
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:14:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D71460A5F;
 Tue, 13 Oct 2026 18:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E2B1F00893;
 Tue, 13 Oct 2026 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791915266;
 bh=kKIzCNn5CgrhfcSurryX3xOatR7Z/YVsZGhkddPHnrY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=JVHrDcHi+hjTUi2GSLLbLdRvF2sRuUlCDYNu3P2vGB1Aguw67M4OvruAN8HxDdkVm
 Usu5mD3FzqTXucjiE2bQnRR5c4jQgUjqbEP3+MTLHK1YWWpmN/Qe5CoyR2IxVu3TQd
 TRavdZw/vhff2RciIZ5b+Vbs6H0tFiiiYOERzIKa2+46Hm88vsuVPLuYemgh3YparO
 v3+55S1J0gO2V8hrg5XjhuQ9nbCQnuQBmdx6g5QAPnypL5OeMaCY6nwjf28n8zSyIx
 rXFGZHtebPcRnwfoluOr/RIT2ZNVNImaAXdCDNzFLAOv9ZlPlb5muCz47x6Y6W816T
 t0yBkLqM312DQ==
Subject: Re: [PATCH net v2 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
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
Date: Tue, 13 Oct 2026 18:14:25 +0000
Message-ID: <179191526509.434549.6192981765881681048@kernel.org>
In-Reply-To: <20261012174300.2338784-3-almasrymina@google.com>
References: <20261012174300.2338784-3-almasrymina@google.com>
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

Critical: 0 · High: 2 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Commit "net: devmem: detach TX bindings on NETDEV_UNREGISTER"
  leaves the dangling binding->dev use-after-free it says it fixes…
- [High] net: devmem: NULL deref in netif_mp_close_rxq() on concurrent
  unregister
- [Medium] net_devmem_dev_unregister_tx() treats every NETDEV_UNREGISTER
  as device destruction, but the same event is sent when a device moves…
- [Medium] net_devmem_dev_unregister_tx() calls synchronize_net() once
  for every TX binding that matches the device, in both the dev branch…

--

net: devmem: detach TX bindings on NETDEV_UNREGISTER

This patch extends net_devmem_dev_unregister() to cover TX devmem
bindings. When binding->dev unregisters, it clears the LIVE mark, clears
both dev and vdev, waits for a grace period and unmaps the dma_buf. When
only binding->vdev unregisters, it clears just vdev.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 02d607cc87217..a1c029f6ae47f 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -192,6 +192,36 @@ net_devmem_dev_unregister_rx(struct net_devmem_dmabuf_binding *binding,
>  	mutex_unlock(&binding->lock);
>  }
>  
> +static void
> +net_devmem_dev_unregister_tx(struct net_devmem_dmabuf_binding *binding,
> +			     unsigned long xa_idx, struct net_device *dev)
> +{
> +	if (READ_ONCE(binding->dev) == dev) {
> +		xa_clear_mark(&net_devmem_dmabuf_bindings, xa_idx,
> +			      NET_DEVMEM_BINDING_LIVE);

[Severity: Medium]
Does NETDEV_UNREGISTER always mean the device is being destroyed here?
__dev_change_net_namespace() also sends it when a device only moves to
another netns:

net/core/dev.c:__dev_change_net_namespace() {
    ...
	 * Note that dev->reg_state stays at NETREG_REGISTERED.
	 * This is wanted because this way 8021q and macvlan know
	 * the device is just moving and can keep their slaves up.
	 */
	call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
    ...
}

netdev_genl_netdevice_event() calls net_devmem_dev_unregister() on every
NETDEV_UNREGISTER, so a netns move ends up here too.

If the physical dev of a TX binding is moved, this code clears
NET_DEVMEM_BINDING_LIVE, sets binding->dev and binding->vdev to NULL and
unmaps the dma_buf, even though the device is still alive. If a netkit vdev
is moved, binding->vdev is cleared.

Nothing restores the mark, the pointers or the mapping when the device
re-registers in the new netns. After that, net_devmem_lookup_dmabuf() can't
find the binding, net_devmem_get_binding() returns -ENODEV, and
validate_xmit_unreadable_skb() drops devmem skbs.

netkit_check_lease_unregister() tells the two cases apart with:

	if (READ_ONCE(dev->reg_state) != NETREG_UNREGISTERING ||

Should net_devmem_dev_unregister_tx() check reg_state the same way? Bound
RX bindings already survive netns moves, because
net_devmem_dev_unregister_rx() skips LIVE bindings.

> +
> +		mutex_lock(&binding->lock);
> +		WRITE_ONCE(binding->dev, NULL);
> +		WRITE_ONCE(binding->vdev, NULL);
> +		mutex_unlock(&binding->lock);
> +
> +		/* Ensure no tx net_devmem_lookup_dmabuf() or
> +		 * validate_xmit_unreadable_skb() are in flight after detach.
> +		 */
> +		synchronize_net();
> +
> +		mutex_lock(&binding->lock);
> +		net_devmem_dmabuf_binding_unmap(binding);
> +		mutex_unlock(&binding->lock);
> +	} else if (READ_ONCE(binding->vdev) == dev) {
> +		mutex_lock(&binding->lock);
> +		WRITE_ONCE(binding->vdev, NULL);
> +		mutex_unlock(&binding->lock);
> +
> +		synchronize_net();
> +	}

[Severity: High]
Can a TX binding still end up with a dangling binding->dev? There seems to
be a race between bind-tx on a netkit and unregistration of the physical
device the netkit leases from.

netdev_nl_bind_tx_doit() only checks reg_state on the device the user
names, through netdev_get_by_index_lock() -> netdev_put_lock(). The physical
device comes from netdev_find_netmem_tx_dev():

	if (netif_device_present(phys_dev) &&
	    phys_dev->netmem_tx == NETMEM_TX_DMA)
		return phys_dev;

Both of these conditions still hold after unregister_netdevice_many_notify()
has set phys->reg_state to NETREG_UNREGISTERING.

netdev_nl_bind_tx_doit() then calls netdev_lock(bind_dev) without checking
reg_state again. net_devmem_bind_dmabuf() maps the dma_buf and publishes the
binding with xa_alloc_cyclic() and xa_set_mark(LIVE), without holding
net_devmem_lock.

In the NETDEV_UNREGISTER chain for phys, netdev_genl_nb (subsys_initcall)
is called before netkit's notifier (module_init). So this ordering looks
possible:

CPU1 unregistering phys:
  call_netdevice_notifiers(NETDEV_UNREGISTER, phys)
    netdev_genl_netdevice_event()
      net_devmem_dev_unregister(phys)
        /* walk completes, no binding for phys yet */

CPU2, before netkit's notifier runs:
  netdev_nl_bind_tx_doit()
    netdev_find_netmem_tx_dev()      /* returns phys */
    net_devmem_bind_dmabuf()         /* dev = phys, vdev = netkit */

CPU1 continues:
    netkit_notifier()
      netkit_check_lease_unregister()  /* unregisters netkit */

When the netkit unregisters, net_devmem_dev_unregister_tx() only takes the
vdev branch above, because binding->dev is phys and not the netkit.

Then netkit_uninit() -> netkit_queue_unlease() -> netdev_rx_queue_unlease()
drops the last lease reference on phys with netdev_put(). The binding holds
no netdev reference, so phys is freed while binding->dev still points to it
and the dma_buf is still mapped.

When the netlink socket is later closed, netdev_nl_sock_priv_destroy() reads
binding->dev and calls netdev_hold() and netdev_lock() on it. Isn't that the
same oops quoted in the commit message?

Would it make sense for netdev_nl_bind_tx_doit() to reject
bind_dev->reg_state != NETREG_REGISTERED under netdev_lock(bind_dev)? Or to
publish the binding under net_devmem_lock together with that check?

> +}
> +
>  void net_devmem_dev_unregister(struct net_device *dev)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
> @@ -201,6 +231,8 @@ void net_devmem_dev_unregister(struct net_device *dev)
>  	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
>  		if (binding->direction == DMA_FROM_DEVICE)
>  			net_devmem_dev_unregister_rx(binding, xa_idx, dev);
> +		else
> +			net_devmem_dev_unregister_tx(binding, xa_idx, dev);
>  	}
>  	mutex_unlock(&net_devmem_lock);
>  }

[Severity: High]
Can net_devmem_unbind_dmabuf() end up calling netif_mp_close_rxq()
with a NULL dev when it races with unregistration of the device?

unregister_netdevice_many_notify() runs dev_memory_provider_uninstall()
under netdev_lock(dev). It then drops the instance lock before calling
the NETDEV_UNREGISTER notifiers. If bound_rxqs is not fully emptied at
that point, the binding still has rxqs to close when the netlink socket
goes away. That could happen with a queue above a reduced
real_num_rx_queues, or with a leased queue.

This ordering looks possible:

CPU1 unregistering dev:
  unregister_netdevice_many_notify()
    dev_memory_provider_uninstall(dev)  /* under netdev_lock */
    /* netdev_lock(dev) dropped */

CPU2 closing the netlink socket:
  netdev_nl_sock_priv_destroy()
    netdev_lock(dev)
    net_devmem_unbind_dmabuf()
      /* clears NET_DEVMEM_BINDING_LIVE */
      synchronize_net()

CPU1 continues:
  call_netdevice_notifiers(NETDEV_UNREGISTER, dev)
    netdev_genl_netdevice_event()
      net_devmem_dev_unregister(dev)
        net_devmem_dev_unregister_rx()
          /* LIVE is clear and binding->dev == dev */
          WRITE_ONCE(binding->dev, NULL)

CPU2 continues:
      xa_for_each(&binding->bound_rxqs, ...)
        netif_mp_close_rxq(binding->dev, ...)  /* now NULL */

netif_mp_close_rxq() reads dev->real_num_rx_queues straight away, so
this is a NULL pointer dereference. An unprivileged user can trigger it
by closing a devmem netlink socket while the device is being removed.
The notifier path takes only net_devmem_lock and binding->lock. The
netdev_lock(dev) held by the unbind side does not serialize against it.

The LIVE check in net_devmem_dev_unregister_rx() seems meant to leave
bindings alone while the unbind path still owns them. But
net_devmem_unbind_dmabuf() clears the mark before it is done using
binding->dev, and that opens this window.

I see a few possible fixes:

- net_devmem_unbind_dmabuf() could use a local copy of the dev that
  netdev_nl_sock_priv_destroy() already holds, instead of re-reading
  binding->dev.
- net_devmem_dev_unregister_rx() could also skip bindings that still
  have entries in bound_rxqs.
- The unbind side could hold net_devmem_lock or binding->lock across
  this window.

Which of these did you intend?

[Severity: Medium]
Does this run one expedited RCU grace period for each matching TX binding,
all while RTNL and net_devmem_lock are held?

net_devmem_dev_unregister_tx() calls synchronize_net() for every binding
that matches dev, in both branches. This runs from the NETDEV_UNREGISTER
notifier with RTNL held, so synchronize_net() picks the expedited variant:

net/core/dev.c:synchronize_net() {
	...
	if (from_cleanup_net() || rtnl_is_locked())
		synchronize_rcu_expedited();
	else
		synchronize_rcu();
}

NETDEV_CMD_BIND_TX is unprivileged and has no limit on the number of
bindings, so a user can create many bindings against one device. The next
removal or netns move of that device would then hold RTNL and
net_devmem_lock across N expedited grace periods. That also blocks
__net_devmem_dmabuf_binding_free(), which takes net_devmem_lock.

Could the walk first clear the mark and pointers on all matching bindings,
then call synchronize_net() once, and only then unmap them?

The vdev-only branch also doesn't seem to need a grace period for memory
safety, since vdev is never dereferenced.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012174300.2338784-1-almasrymina%40google.com
