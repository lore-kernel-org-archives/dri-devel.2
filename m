Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1F9CCA463
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C16781123A2;
	Thu, 15 Oct 2026 16:18:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C79111123A2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:18:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BBBB60200;
 Thu, 15 Oct 2026 16:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B881F000C4;
 Thu, 15 Oct 2026 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792081093;
 bh=oxDFYaRXaWBY8jYhUrvaclS1/sxGZzUC4Ga9k7YL9Ms=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a3g6S5uHnoSBhz461QjJobnlPh6jq0d1472ZJHzicyiooNA03kKH3WMG4ZPiO8cB2
 5nz8eyjmt1dzF3w6gdZGMuCFgevn5BW8+gJwwk0pDsDJQOXMNrPGfFGvt+YE6sXUih
 68KaJctyUotd3KpIJDlDR+eEyBuQnxvwK/VgTeHwtuUFNTus3PVqJ7PN7nzFUhou6G
 uuwjSSooM4WD0m78vGa4zU97/DF57c/Bd4ovpEHtf3xC6xOgJXUl88cf/ZFBZWiXGT
 nehZ2CilAHp/vk43scmet+81QtMWMVlWJ/ITi/R/K/fbegtRN10b31IsGr2fX/68hh
 k8/pNJMoAyLoA==
Message-ID: <sashiko-outbox-173162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: "Mina Almasry" <almasrymina@google.com>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261014161754.3782346-2-almasrymina@google.com>
References: <20261014161754.3782346-1-almasrymina@google.com>
 <20261014161754.3782346-2-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:18:12 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: devmem: UAF in dmabuf unmap due to skipped unmap on physical =
device unregister
--

commit 9aa963a98903abc88d8d047a795dac2c2807eebc
Author: Mina Almasry <almasrymina@google.com>

net: devmem: unmap dma_buf synchronously on queue uninstall

This commit adds synchronous unmapping of a dma_buf when the last bound RX =
queue
is uninstalled or the bound physical device is unregistered. The intention =
is to
prevent a use-after-free crash in dma_unmap_sg_attrs() that happens when the
device is removed (freeing dma_dev) before the binding is completely freed =
on
socket close.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4d60654ce7fd..93cc2815d935a 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
[ ... ]
> @@ -153,6 +176,38 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmab=
uf_binding *binding)
>  	percpu_ref_kill(&binding->ref);
>  }
> =20
> +static void
> +net_devmem_dev_unregister_rx(struct net_devmem_dmabuf_binding *binding,
> +			     unsigned long xa_idx, struct net_device *dev)
> +{
> +	if (xa_get_mark(&net_devmem_dmabuf_bindings, xa_idx,
> +			NET_DEVMEM_BINDING_LIVE) ||
> +	    READ_ONCE(binding->dev) !=3D dev)
> +		return;

[Severity: High]
When a virtual device leases an RX queue from a physical device,
netdev_nl_bind_rx_doit() maps a dmabuf using the physical device's dma_dev =
but
sets binding->dev to the virtual device. If the physical device is unregist=
ered,
will this condition cause the unmap to be skipped because binding->dev does=
 not
match the physical device?

> +
> +	mutex_lock(&binding->lock);
> +	WRITE_ONCE(binding->dev, NULL);
> +	if (!netif_is_queue_leasee(dev))
> +		net_devmem_dmabuf_binding_unmap(binding);

[Severity: High]
If the virtual device unregisters (either directly or due to the physical d=
evice
unregistering), this explicit check skips the unmapping step for leased que=
ues.
Does this leave the dmabuf mapped to the physical device's soon-to-be-freed
dma_dev, and ultimately lead to the same use-after-free crash during socket
close?

> +	mutex_unlock(&binding->lock);
> +}
[ ... ]
> @@ -529,16 +588,19 @@ static void mp_dmabuf_devmem_uninstall(void *mp_pri=
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
> +			mutex_lock(&binding->lock);
> +			ASSERT_EXCLUSIVE_WRITER(binding->dev);
> +			WRITE_ONCE(binding->dev, NULL);
> +			if (!rxq->lease)
> +				net_devmem_dmabuf_binding_unmap(binding);

[Severity: High]
Similar to the issue above, does explicitly skipping the unmap here for lea=
sed
queues prevent synchronous unmapping and trigger a use-after-free in
__net_devmem_dmabuf_binding_free() when it uses the freed dma_dev?

> +			mutex_unlock(&binding->lock);
>  		}
> +		break;
>  	}
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014161754.3782=
346-1-almasrymina@google.com?part=3D1
