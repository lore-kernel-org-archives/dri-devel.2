Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CA8606A32C
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I09mP+sj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CFC710E2B7;
	Sat, 31 Oct 2026 08:36:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C89410E2CD
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 08:36:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2750600D4;
 Sat, 31 Oct 2026 08:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3461F00919;
 Sat, 31 Oct 2026 08:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793435786;
 bh=OZEBZx10YIJkSY0YYAtM6cbgA6GDmAfGU82pBwvW10g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I09mP+sjyEoPOJisdwB+WcHoKqCCPwh4W8yRF/ZCTPzVGI4wHNI8m57YY4cOVMDAV
 fengUXa+fuhAQS1cD35IMxr4VenIfPtVwNrmEY/Qyk6E98izxafWXJtXymzSHNGfHb
 ZDQRN1lgJsBbNFuK6rnzSAyOLAxujzK/IiBxEc91v9rIM0pmhnWngpPRso7maQOD3q
 4teUldT+ILp+IM6CmO6eRaIJ2W7RF3wh1mod76GkMgxr7ciH9+iD/HjOTLCeioD2FT
 HXe+axkfUDcHDzlRTPcYnywsye3nmk/zGi4QWS7LCfLhQfJwE7jjXAohPS0phQ4PzI
 PygrdD0EZkd2g==
Message-ID: <sashiko-outbox-191833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
To: "Mina Almasry" <almasrymina@google.com>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261030083539.777877-3-almasrymina@google.com>
References: <20261030083539.777877-1-almasrymina@google.com>
 <20261030083539.777877-3-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 08:36:26 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: devmem: UAF when netdev_nl_bind_tx_doit() races with phys_dev=
 unregister
--

commit ccf551ffb7f8200a4b1a6abbb90f90e5db975e35
Author: Mina Almasry <almasrymina@google.com>

net: devmem: detach TX bindings on NETDEV_UNREGISTER

This commit extends net_devmem_dev_unregister() and
__net_devmem_dmabuf_binding_free() to handle TX devmem bindings when a
physical or virtual network device unregisters. When binding->dev unregiste=
rs,
the binding is unmarked live, its dma_buf is unmapped, and both binding->vd=
ev
and binding->dev are cleared; when only binding->vdev unregisters, only
binding->vdev is cleared.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 4610de805ef08..5c7d9640e9d14 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -149,7 +149,7 @@ void __net_devmem_dmabuf_binding_free(struct work_str=
uct *wq)
>  {
>  	struct net_devmem_dmabuf_binding *binding =3D container_of(wq, typeof(*=
binding), unbind_w);
>  	netdevice_tracker dev_tracker;
> -	struct net_device *dev =3D NULL;
> +	struct net_device *dev;
> =20
>  	if (binding->freelist)
>  		WARN(binding->free_count !=3D binding->area.num_niovs,
> @@ -157,8 +157,7 @@ void __net_devmem_dmabuf_binding_free(struct work_str=
uct *wq)
>  		     binding->area.num_niovs, binding->free_count);
> =20
>  	kvfree(binding->area.niovs);
> -	if (binding->direction =3D=3D DMA_FROM_DEVICE)
> -		dev =3D net_devmem_lock_dev(binding, &dev_tracker);
> +	dev =3D net_devmem_lock_dev(binding, &dev_tracker);
>  	net_devmem_dmabuf_binding_unmap(binding);
>  	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
>  	net_devmem_unlock_dev(dev, &dev_tracker);
> @@ -252,11 +251,20 @@ void net_devmem_dev_unregister(struct net_device *d=
ev)
> =20
>  	xa_lock(&net_devmem_dmabuf_bindings);
>  	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
> -		if (binding->direction !=3D DMA_FROM_DEVICE ||
> -		    READ_ONCE(binding->dev) !=3D dev ||
> -		    xa_get_mark(&net_devmem_dmabuf_bindings, xa_idx,
> -				NET_DEVMEM_BINDING_LIVE))
> -			continue;
> +		if (binding->direction =3D=3D DMA_FROM_DEVICE) {
> +			if (READ_ONCE(binding->dev) !=3D dev ||
> +			    xa_get_mark(&net_devmem_dmabuf_bindings, xa_idx,
> +					NET_DEVMEM_BINDING_LIVE))
> +				continue;
> +		} else {
> +			if (READ_ONCE(binding->vdev) =3D=3D dev)
> +				WRITE_ONCE(binding->vdev, NULL);
> +			if (READ_ONCE(binding->dev) !=3D dev)
> +				continue;

[Severity: High]
Can binding->dev be left pointing to a freed physical net_device if
netdev_nl_bind_tx_doit() on a virtual device races with physical device
unregistration?

When a NETMEM_TX_NO_DMA virtual device (vdev, such as netkit) leases an RX
queue from a physical device (phys_dev), phys_dev is pinned via
rxq_src->lease_tracker until vdev is unregistered.

When phys_dev unregisters in unregister_netdevice_many_notify(), its
reg_state is set to NETREG_UNREGISTERING under netdev_lock(phys_dev) while
__LINK_STATE_PRESENT remains set. During call_netdevice_notifiers() for
NETDEV_UNREGISTER on phys_dev, netdev_genl_netdevice_event() runs first,
calling net_devmem_dev_unregister(phys_dev) under netdev_lock(phys_dev).
Only after that notifier completes does netkit_notifier() invoke
netkit_check_lease_unregister(phys_dev) -> unregister_netdevice_many() to
acquire netdev_lock(vdev) and set vdev->reg_state to NETREG_UNREGISTERING.

Because netdev_nl_family has parallel_ops enabled and NETDEV_CMD_BIND_TX do=
es
not hold rtnl_lock(), a concurrent netdev_nl_bind_tx_doit() on vdev can grab
netdev_lock(vdev) via netdev_get_by_index_lock() while vdev->reg_state is
still NETREG_REGISTERED, look up phys_dev via netdev_find_netmem_tx_dev(),
and then acquire netdev_lock(bind_dev) after net_devmem_dev_unregister() has
already finished on phys_dev:

net/core/netdev-genl.c:netdev_find_netmem_tx_dev() {
	...
	for (i =3D 0; i < dev->real_num_rx_queues; i++) {
		lease_rxq =3D READ_ONCE(__netif_get_rx_queue(dev, i)->lease);
		if (!lease_rxq)
			continue;

		phys_dev =3D lease_rxq->dev;
		if (netif_device_present(phys_dev) &&
		    phys_dev->netmem_tx =3D=3D NETMEM_TX_DMA)
			return phys_dev;
	}
}

net/core/netdev-genl.c:netdev_nl_bind_tx_doit() {
	...
	if (bind_dev !=3D netdev)
		netdev_lock(bind_dev);

	dma_dev =3D netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);

	binding =3D net_devmem_bind_dmabuf(bind_dev,
					 bind_dev !=3D netdev ? netdev : NULL,
					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
					 PAGE_SHIFT, priv, NETLINK_CB(skb).sk,
					 info->extack);
}

Since netdev_nl_bind_tx_doit() does not check that bind_dev->reg_state =3D=
=3D
NETREG_REGISTERED after taking netdev_lock(bind_dev), it creates the binding
with binding->dev =3D phys_dev and binding->vdev =3D vdev.

When vdev then runs net_devmem_dev_unregister(vdev), this branch sees
binding->vdev =3D=3D vdev and binding->dev =3D=3D phys_dev !=3D vdev, so it=
 only clears
binding->vdev to NULL and continues without unmapping the dma_buf or cleari=
ng
binding->dev. Because net_devmem_dev_unregister(phys_dev) already ran,
binding->dev is never cleared. Once netkit_uninit() drops the lease referen=
ce
and netdev_run_todo() frees phys_dev, won't netdev_nl_sock_priv_destroy() or
__net_devmem_dmabuf_binding_free() dereference the freed phys_dev in
net_devmem_lock_dev()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030083539.7778=
77-1-almasrymina@google.com?part=3D2
