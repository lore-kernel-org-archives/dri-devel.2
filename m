Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2079606A32E
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPB3zY9S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED2E10EADD;
	Sun,  1 Nov 2026 23:01:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862DC10EADA
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:01:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 095546060D;
 Sun,  1 Nov 2026 23:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107B71F00919;
 Sun,  1 Nov 2026 23:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793574085;
 bh=y4OUhnmCvJLQBXMOrS9kGGB0AvSLbU3rE7gGaZ0KZtU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=EPB3zY9SusvU7/YIyulwoLXPLZxbJe7asyWwek6N6h+36zLzGFITGSYflezxOsIJK
 V+77hZpAYWtC1j7f9lvP4MX9OmTm/YH2IRtAGk45yIwaliqfkbh9Iqg7NGcndk2Yo3
 KpGhXqM0idVtX7jQDRlh722CnMHjUVm9VcVqsZ6Zj0K0+Z9mT3/ogGFIF/Hb078xjE
 esqVYwwE/BXJLt/AWXBXhwK0eI26h2hVaUiX8SorxcmDZzAqI/t08ifWbXy7pG4765
 Hl9goNdd8ZSOsj7j2PijvvLwBB2YiwUE10lDBNkYIVoe/nSvQPj5XK5lG10RxTDEtE
 CwGixdaXVTMfQ==
Subject: Re: [PATCH net v5 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
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
Date: Sun, 01 Nov 2026 23:01:23 +0000
Message-ID: <179357408360.3131.16098294926514442303@kernel.org>
In-Reply-To: <20261030083539.777877-3-almasrymina@google.com>
References: <20261030083539.777877-3-almasrymina@google.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch's TX detach is incomplete.

--

net: devmem: detach TX bindings on NETDEV_UNREGISTER

This commit extends net_devmem_dev_unregister() to TX devmem bindings.
When binding->dev unregisters, the walk clears the LIVE mark, unmaps the
dma_buf, and clears both binding->dev and binding->vdev. When only
binding->vdev unregisters, it clears just binding->vdev. The commit also
makes __net_devmem_dmabuf_binding_free() call net_devmem_lock_dev() for
TX bindings.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 4610de805ef08..5c7d9640e9d14 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -157,8 +157,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
>  		     binding->area.num_niovs, binding->free_count);
>  
>  	kvfree(binding->area.niovs);
> -	if (binding->direction == DMA_FROM_DEVICE)
> -		dev = net_devmem_lock_dev(binding, &dev_tracker);
> +	dev = net_devmem_lock_dev(binding, &dev_tracker);
>  	net_devmem_dmabuf_binding_unmap(binding);
>  	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
>  	net_devmem_unlock_dev(dev, &dev_tracker);
> @@ -252,11 +251,20 @@ void net_devmem_dev_unregister(struct net_device *dev)
>  
>  	xa_lock(&net_devmem_dmabuf_bindings);
>  	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
> -		if (binding->direction != DMA_FROM_DEVICE ||
> -		    READ_ONCE(binding->dev) != dev ||
> -		    xa_get_mark(&net_devmem_dmabuf_bindings, xa_idx,
> -				NET_DEVMEM_BINDING_LIVE))
> -			continue;
> +		if (binding->direction == DMA_FROM_DEVICE) {
> +			if (READ_ONCE(binding->dev) != dev ||
> +			    xa_get_mark(&net_devmem_dmabuf_bindings, xa_idx,
> +					NET_DEVMEM_BINDING_LIVE))
> +				continue;
> +		} else {
> +			if (READ_ONCE(binding->vdev) == dev)
> +				WRITE_ONCE(binding->vdev, NULL);
> +			if (READ_ONCE(binding->dev) != dev)
> +				continue;
> +			WRITE_ONCE(binding->vdev, NULL);
> +			__xa_clear_mark(&net_devmem_dmabuf_bindings, xa_idx,
> +					NET_DEVMEM_BINDING_LIVE);
> +		}

[Severity: High]

Can a leased bind-tx still create a TX binding on the physical device
after this walk has already run for that device?

net_devmem_dev_unregister() runs once per device. It is called from
netdev_genl_netdevice_event() under netdev_lock(dev), and does nothing
unless reg_state is NETREG_UNREGISTERING.

Take a virtual device V (for example netkit) with a queue leased from a
physical device X. When bind-tx is issued on V, netdev_nl_bind_tx_doit()
locks X and binds to it without checking X->reg_state again:

net/core/netdev-genl.c:netdev_nl_bind_tx_doit() {
    ...
	bind_dev = netdev_find_netmem_tx_dev(netdev);
    ...
	if (bind_dev != netdev)
		netdev_lock(bind_dev);

	dma_dev = netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);

	binding = net_devmem_bind_dmabuf(bind_dev,
					 bind_dev != netdev ? netdev : NULL,
    ...
}

netdev_find_netmem_tx_dev() only checks netif_device_present(X), and
unregister_netdevice_many_notify() does not clear that bit.

netdev_genl_nb is registered at subsys_initcall and the netkit notifier
at module_init, with the same priority. On NETDEV_UNREGISTER of X, the
netdev-genl walk for X therefore finishes and unlocks X before
netkit_check_lease_unregister() queues V for unregistration. Until then
V stays NETREG_REGISTERED and its lease to X stays in place.

That seems to allow this ordering:

CPU1 (unregister of X)              CPU2 (unprivileged bind-tx on V)
netdev_genl_netdevice_event(X)
  netdev_lock(X)
  net_devmem_dev_unregister(X)
  netdev_unlock(X)
                                    netdev_nl_bind_tx_doit()
                                      netdev_get_by_index_lock(V)
                                      bind_dev = X (via the lease)
                                      netdev_lock(X)
                                      net_devmem_bind_dmabuf(X, V, ...)
                                        LIVE binding, binding->dev = X
                                      netdev_unlock(X)
netkit_check_lease_unregister(X)
  unregister of V
    net_devmem_dev_unregister(V)
      binding->dev != V, so only
      binding->vdev is cleared
    netkit_queue_unlease()
      netdev_put() on X
netdev_run_todo()
  X is freed

The walk for X never runs again, and the binding holds no reference on X,
so binding->dev is left pointing at the freed X.

When the netlink socket is closed later, wouldn't
netdev_nl_sock_priv_destroy()->net_devmem_lock_dev() call netdev_hold()
and netdev_lock() on freed memory? That is the oops quoted in the commit
message.

With the __net_devmem_dmabuf_binding_free() change above, the deferred
free work also calls net_devmem_lock_dev() for TX bindings, so it is a
second path that dereferences the stale binding->dev. The dma_buf also
stays attached and mapped to X's DMA device.

The non-leased path looks safe, because netdev_put_lock() checks
reg_state again under the instance lock. The later patches in this series
don't seem to touch this path.

Would it close the window to reject the bind with -ENODEV when
bind_dev->reg_state != NETREG_REGISTERED after netdev_lock(bind_dev)?
unregister_netdevice_many_notify() writes reg_state under that lock, and
the devmem walk runs later under the same lock.

>  
>  		xa_unlock(&net_devmem_dmabuf_bindings);
>  		if (!netif_is_queue_leasee(dev))

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030083539.777877-1-almasrymina%40google.com
