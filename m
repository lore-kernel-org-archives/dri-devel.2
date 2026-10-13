Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52763CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730FE10E2B9;
	Tue, 13 Oct 2026 17:43:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D2B10E2B9
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:43:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FAD543FAE;
 Tue, 13 Oct 2026 17:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B89F1F00893;
 Tue, 13 Oct 2026 17:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791913402;
 bh=AuoScA5FRM7uHPmAS8M742kalyVNL+TM2LhFvCRGy6A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OFIvjhB+a80ZM7mTZWf6oj6IP3TDQQ8x05ghb8w515yNPveTKXQolZTAP7QLp78mF
 su5JxEiapl4wF0gSdCMd2auKvqrX2SCQ+eX3KMmuijala/P44Exh848vsmimaqYLeu
 FmL76h5IpoPPC0sutYK2Vib4dxvyODf8efkV7MkKVEWRvxq+u5anmx2ktah5K3hPpg
 8fKPEKwxlOqa96bctsxstkN7PowmAai8VI25Uf0A8cR39aMS0IKRcM++bPDr29SnF4
 WmdHHJVOn5zU0U+WUV42WqQdNB0hxHYbdsqAw6VL0FBo72PzHr0iGP8KehQSfGCa6c
 1p/4nx6l9ag+Q==
Message-ID: <sashiko-outbox-170249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
To: "Mina Almasry" <almasrymina@google.com>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261012174300.2338784-3-almasrymina@google.com>
References: <20261012174300.2338784-1-almasrymina@google.com>
 <20261012174300.2338784-3-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:43:21 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net: O(N) synchronize_net() calls under rtnl_lock cause RTNL stall=
 and IPI storm
- [High] net: devmem: NULL deref in netif_mp_close_rxq() on concurrent unre=
gister
--

commit 92717c23489a6c952c6219d6248685cf5a364b91
Author: Mina Almasry <almasrymina@google.com>
Subject: net: devmem: detach TX bindings on NETDEV_UNREGISTER

This patch extends net_devmem_dev_unregister() to detach TX bindings when
a device is unregistered. It waits for in-flight readers via
synchronize_net() and unmaps the dma_buf to prevent dangling pointers.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 02d607cc87217..a1c029f6ae47f 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
[ ... ]
> +static void
> +net_devmem_dev_unregister_tx(struct net_devmem_dmabuf_binding *binding,
> +			     unsigned long xa_idx, struct net_device *dev)
> +{
> +	if (READ_ONCE(binding->dev) =3D=3D dev) {
> +		xa_clear_mark(&net_devmem_dmabuf_bindings, xa_idx,
> +			      NET_DEVMEM_BINDING_LIVE);
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

[Severity: High]
Does this O(N) synchronize_net() inside a loop cause a potential denial of
service?

Because net_devmem_dev_unregister() iterates over all bindings using
xa_for_each() and calls net_devmem_dev_unregister_tx() for each, this
synchronize_net() executes sequentially for every matching TX binding.

This executes in the NETDEV_UNREGISTER notifier chain under the global
rtnl_lock, which causes synchronize_net() to fall back to
synchronize_rcu_expedited(). For a large number of bindings, this could for=
ce
numerous consecutive expedited RCU grace periods, sending a massive amount =
of
IPIs system-wide and stalling the RTNL lock.

Could we lift the synchronize_net() out of the per-binding loop, batch the
pointer clearing, issue a single synchronize_net(), and then perform the
unmapping?

> +
> +		mutex_lock(&binding->lock);
> +		net_devmem_dmabuf_binding_unmap(binding);
> +		mutex_unlock(&binding->lock);
> +	} else if (READ_ONCE(binding->vdev) =3D=3D dev) {
> +		mutex_lock(&binding->lock);
> +		WRITE_ONCE(binding->vdev, NULL);
> +		mutex_unlock(&binding->lock);
> +
> +		synchronize_net();
> +	}
> +}
> +
>  void net_devmem_dev_unregister(struct net_device *dev)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
> @@ -201,6 +231,8 @@ void net_devmem_dev_unregister(struct net_device *dev)
>  	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
>  		if (binding->direction =3D=3D DMA_FROM_DEVICE)
>  			net_devmem_dev_unregister_rx(binding, xa_idx, dev);

[Severity: High]
Is there a NULL pointer dereference risk here if net_devmem_unbind_dmabuf()
runs concurrently with device unregistration?

If unregister_netdevice_many_notify() calls dev_memory_provider_uninstall()
and then drops the lock, the following race could occur:

1. netdev_nl_sock_priv_destroy() calls net_devmem_unbind_dmabuf(), clearing
   the LIVE mark and entering synchronize_net().

2. The unregister notifier triggers net_devmem_dev_unregister_rx() here.

3. Because the LIVE mark was cleared in step 1, net_devmem_dev_unregister_r=
x()
   bypasses its early return and unconditionally sets binding->dev =3D NULL.

4. When net_devmem_unbind_dmabuf() resumes, it executes
   xa_for_each(&binding->bound_rxqs) and calls
   netif_mp_close_rxq(binding->dev) using the now NULL binding->dev.

Could this crash the kernel at dev->real_num_rx_queues in netif_mp_close_rx=
q()?

> +		else
> +			net_devmem_dev_unregister_tx(binding, xa_idx, dev);
>  	}
>  	mutex_unlock(&net_devmem_lock);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012174300.2338=
784-1-almasrymina@google.com?part=3D2
