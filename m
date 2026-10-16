Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C90CCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3F7410E376;
	Fri, 16 Oct 2026 16:39:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70BF810E362
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 16:39:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D2B960218;
 Fri, 16 Oct 2026 16:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AD61F000C5;
 Fri, 16 Oct 2026 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792168765;
 bh=xwvw1ZVrl97tTG8u4GMV8lERo0TT62K4T3E/jmCXnSE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bRWDKq+sJTEdn9KpQKrV7NXHh7kSM7edm5qSVNGxiofbjmw0ScMMBxgeUZ0tQTd2o
 F9JrdpMR+UTSvIvPPATOLjjnBxoDAHBoTYVY9K+jAVOu7+ngaAbN/Hv9l29/nGQxMG
 OvhkQ+2NOHET5N0N/yqzj85BjqIgbMfdYEwPQE0ujNVoc0eMyQFKA28phDIJ2oalIw
 7F2CCCtQuTF5Hatjf87QonZRrGLLfhUmWfFvLMUsW4b9xGSEn63Tuz/CnHQMHGcJfH
 6ONLvBcS52DyDGKwlH2SJvetqvV8kGn2YfxvmLh7mD2Tk6dKeo9KZz0pub7hWMJHiI
 Gweiem1NoMlxQ==
Message-ID: <sashiko-outbox-174651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: "Mina Almasry" <almasrymina@google.com>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261015163915.1166043-2-almasrymina@google.com>
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-2-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 16:39:24 +0000
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
- [High] net: devmem: UAF due to leased queue mismatch in mp_dmabuf_devmem_=
uninstall()
- [High] net: devmem: UAF on dma_dev when physical device backing leased qu=
eue unregisters
--

commit e1f5260c45393c53db73f20e6a31f72ae2f54f17
Author: Mina Almasry <almasrymina@google.com>

net: devmem: unmap dma_buf synchronously on queue uninstall

When a bound net_device is unregistered while userspace still holds a
netlink or TCP socket reference on a devmem binding,
mp_dmabuf_devmem_uninstall() clears binding->dev to NULL so
netdev_nl_sock_priv_destroy() will not touch the unregistered
net_device, but leaves the dma_buf attachment mapped until
__net_devmem_dmabuf_binding_free() runs later on socket close.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4d60654ce7fd..20d95b24d5951 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
[ ... ]
> @@ -147,12 +183,62 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dma=
buf_binding *binding)
> =20
>  		rxq_idx =3D get_netdev_rx_queue_index(rxq);
> =20
> -		netif_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
> +		if (netif_mp_close_rxq(binding->dev, rxq_idx, &mp_params))
> +			busy =3D true;

[Severity: High]
Can this dereference a freed virtual device or queue?

When a dmabuf is bound to a virtual device's leased queue,
net_devmem_bind_dmabuf_to_queue() stores the virtual queue in
binding->bound_rxqs. However, netif_mp_open_rxq() delegates the memory
provider setup to the underlying physical queue, leaving the virtual queue's
mp_params.mp_ops as NULL.

If the virtual device is unregistered while the socket is still open, its
dev_memory_provider_uninstall() skips the virtual queue entirely since its
mp_ops is NULL, leaving the binding intact.

On socket close, this loop iterates over binding->bound_rxqs and uses the
freed virtual device pointer (binding->dev) and freed virtual queue,
potentially causing a use-after-free.

[ ... ]
> +static bool
> +net_devmem_dev_unregister_rx(struct net_devmem_dmabuf_binding *binding,
> +			     unsigned long xa_idx, struct net_device *dev)
> +{
> +	return binding->direction =3D=3D DMA_FROM_DEVICE &&
> +	       READ_ONCE(binding->dev) =3D=3D dev &&
> +	       !xa_get_mark(&net_devmem_dmabuf_bindings, xa_idx,
> +			    NET_DEVMEM_BINDING_LIVE);
> +}

[Severity: High]
Does this strict device match prevent the physical device from handling its
own unregistration when it backs a leased queue?

If userspace binds a dmabuf to a virtual device with leased queues,
binding->dev is set to the virtual device.

If the underlying physical device unregisters (e.g., driver unbind),
net_devmem_dev_unregister() will ignore the binding because binding->dev
matches the virtual device, not the physical device.

This allows the physical device to finish unregistration and free its dma_d=
ev
while the dmabuf remains mapped, leading to a use-after-free when the netli=
nk
socket is eventually closed.

[ ... ]
> @@ -529,16 +615,19 @@ static void mp_dmabuf_devmem_uninstall(void *mp_pri=
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

[Severity: High]
Will this mismatch prevent the cleanup of the binding during physical device
unregistration?

During physical device unregistration, dev_memory_provider_uninstall() calls
mp_dmabuf_devmem_uninstall() with the physical queue (phys_rxq) because the
memory provider was installed on it. However, binding->bound_rxqs contains
the virtual queue (virt_rxq).=20

Because the queues do not match, this loop will continue and skip erasing t=
he
queue and unmapping the binding.

Combined with the device matching issue above, this prevents the physical
device from detaching the binding when it unregisters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015163915.1166=
043-1-almasrymina@google.com?part=3D1
