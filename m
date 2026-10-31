Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6094606A31F
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Id7aAWL0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A9710E2CD;
	Sat, 31 Oct 2026 08:36:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E6110E2B7
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 08:36:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 54B73600C8;
 Sat, 31 Oct 2026 08:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF20E1F00919;
 Sat, 31 Oct 2026 08:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793435786;
 bh=kf5OVhXX9J/gHwn0XmKY4IAnrJcMqFyI4S4BUTFFJhk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Id7aAWL0kanZNnL973Cd/N4yOlRp397FrQtoKn4XjKbi9aLpUVK+L6slfFjoiskoP
 P7Cj4kmXaIk0bQEzq9PDkohVgLhAsZ7CKXTZ04N/DsYWKELre5gOViY7XR6SOFbmit
 ObymrgrvwSALCIOr91T0iryJPrpBAltypRQjJmKqrCBA4IHllDFeP3p3b7uc/DknbF
 tk8piPtgJ77ND1fQHa3j35tjq5gsbwGvGeHmoqSOUHpbxUQsR+DOnWx7oYC2FeOFu5
 lOlRtucdslJ7wd3KrEawl/CwU2nqvNGEj1UafoYsLZ8zZNwuq9Zxk5IssZYP2WKe0H
 UbY6B2+wAtJgA==
Message-ID: <sashiko-outbox-191832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: "Mina Almasry" <almasrymina@google.com>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261030083539.777877-2-almasrymina@google.com>
References: <20261030083539.777877-1-almasrymina@google.com>
 <20261030083539.777877-2-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 08:36:25 +0000
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
- [High] net: devmem: leased RX bindings never unmapped before dma_dev is f=
reed
--

commit b250f1e4ffd826ff4e6f5c24e078e06c36365baf
Author: Mina Almasry <almasrymina@google.com>

net: devmem: unmap dma_buf synchronously on queue uninstall

This patch adds synchronous dma_buf unmapping when RX queues are closed,
uninstalled, or when the bound net_device is unregistered, to avoid a
slab use-after-free in dma_unmap_sg_attrs() if dma_dev is freed while the
devmem binding is still alive.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 32fafbfa1359e..4610de805ef08 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
[ ... ]
> @@ -143,12 +228,45 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dma=
buf_binding *binding)
> =20
>  		rxq_idx =3D get_netdev_rx_queue_index(rxq);
> =20
> -		netif_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
> +		if (netif_mp_close_rxq(binding->dev, rxq_idx, &mp_params))
> +			busy =3D true;
> +	}
> +
> +	if (binding->direction =3D=3D DMA_FROM_DEVICE && binding->dev && !busy)=
 {
> +		net_devmem_dmabuf_binding_unmap(binding);
> +		WRITE_ONCE(binding->dev, NULL);
>  	}
> =20
>  	percpu_ref_kill(&binding->ref);
>  }
> =20
> +void net_devmem_dev_unregister(struct net_device *dev)
> +{
> +	struct net_devmem_dmabuf_binding *binding;
> +	unsigned long xa_idx;
> +
> +	netdev_assert_locked(dev);
> +
> +	if (dev->reg_state !=3D NETREG_UNREGISTERING)
> +		return;
> +
> +	xa_lock(&net_devmem_dmabuf_bindings);
> +	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
> +		if (binding->direction !=3D DMA_FROM_DEVICE ||
> +		    READ_ONCE(binding->dev) !=3D dev ||
> +		    xa_get_mark(&net_devmem_dmabuf_bindings, xa_idx,
> +				NET_DEVMEM_BINDING_LIVE))
> +			continue;
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
> @@ -551,16 +669,17 @@ static void mp_dmabuf_devmem_uninstall(void *mp_pri=
v,
>  	unsigned long xa_idx;
> =20
>  	xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
> -		if (bound_rxq =3D=3D rxq) {
> -			xa_erase(&binding->bound_rxqs, xa_idx);
> -			if (xa_empty(&binding->bound_rxqs)) {
> -				mutex_lock(&binding->lock);
> -				ASSERT_EXCLUSIVE_WRITER(binding->dev);
> -				WRITE_ONCE(binding->dev, NULL);
> -				mutex_unlock(&binding->lock);
> -			}
> -			break;
> +		if (bound_rxq !=3D rxq)
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
As reported by Sashiko on v2 [1], for an RX binding on a leased queue
(for example via netkit), can the binding still be left mapped after the
backing physical device is unregistered and its dma_dev is freed?

When netdev_nl_bind_rx_doit() binds to a virtual queue-leasee device, the
dmabuf is attached to the physical device's dma_dev, but binding->dev is
set to the virtual device and net_devmem_bind_dmabuf_to_queue() records
the virtual rxq in binding->bound_rxqs while netif_mp_open_rxq() installs
mp_params on the physical rxq.

When the virtual device unregisters (either directly or via
netkit_check_lease_unregister() when the physical device unregisters),
ndo_uninit runs:

  netkit_uninit()
    netkit_queue_unlease()
      netdev_rx_queue_unlease(virt_rxq, phys_rxq)
        netif_rxq_cleanup_unlease(phys_rxq, virt_rxq)
          __netif_mp_close_rxq(phys_rxq->dev, rxq_idx, &p)
          __netif_mp_uninstall_rxq(virt_rxq, &p)
            mp_dmabuf_devmem_uninstall(binding, virt_rxq)

Because netdev_rx_queue_unlease() only clears rxq_src->lease and
rxq_dst->lease after netif_rxq_cleanup_unlease() returns:

  net/core/netdev_rx_queue.c:netdev_rx_queue_unlease() {
      ...
      netif_rxq_cleanup_unlease(rxq_src, rxq_dst);

      WRITE_ONCE(rxq_src->lease, NULL);
      WRITE_ONCE(rxq_dst->lease, NULL);
      ...
  }

rxq->lease is still non-NULL in mp_dmabuf_devmem_uninstall(), so it skips
net_devmem_dmabuf_binding_unmap(binding) while emptying
binding->bound_rxqs and setting binding->dev to NULL. If the netlink
socket is closed afterwards, net_devmem_unbind_dmabuf() sees
binding->dev =3D=3D NULL and also skips unmapping.

Similarly, if the netlink socket was closed earlier and
netif_mp_close_rxq() failed (busy =3D=3D true), net_devmem_dev_unregister()
on the virtual device skips net_devmem_dmabuf_binding_unmap(binding)
because netif_is_queue_leasee(dev) is true, and then clears binding->dev
to NULL.

In both cases, when the physical device finishes unregistering,
dev_memory_provider_uninstall() and net_devmem_dev_unregister() on the
physical device cannot find or unmap the binding because binding->bound_rxqs
is empty and binding->dev was the virtual device (and is now NULL). Once
the physical device frees its dma_dev, won't
__net_devmem_dmabuf_binding_free() later hit the same slab use-after-free
in dma_unmap_sg_attrs()?

[1] https://lore.kernel.org/r/179191526299.434549.7888465945343049764@kerne=
l.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030083539.7778=
77-1-almasrymina@google.com?part=3D1
