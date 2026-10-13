Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2152ACC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71EE510E2B1;
	Tue, 13 Oct 2026 17:43:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3451F10E2B1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:43:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BBA7243D97;
 Tue, 13 Oct 2026 17:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7814D1F00893;
 Tue, 13 Oct 2026 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791913401;
 bh=yRdvdYoe8mq203ajF+kLtqwYzN/I5qVJzgFC7dqPjZM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=joboCn6ESZVOGzFNa5VMemCMESgmUMlprWFhxHe+p+w13uhBfCFqPXNhWqVkqm04U
 rGUHnFJQlicZIXt9lT/pOx435OGrBop2Q1ax8yt24sm7H9cVKlRo9JseipdVDabgPT
 4IVKGznyj25bhV/4NDHamnHgMbcqtPqQSjrO8ENi5941eGzVudBlRhtcLJ4qXhmuuQ
 YSIv185RZx3FefcV1uwlkhBbuV2YuisHinNjFXxS4S+2b2MC2d1zt4vJRM4WzmvxKz
 ZHDw3qDCwAjpWlyBpHF0fHNpBr2/bIT0o/Ew3oeAT0iNa9Q3tWB5GKH5GuOibM/8RP
 jGstbcmc0Nt/Q==
Message-ID: <sashiko-outbox-170248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: "Mina Almasry" <almasrymina@google.com>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261012174300.2338784-2-almasrymina@google.com>
References: <20261012174300.2338784-1-almasrymina@google.com>
 <20261012174300.2338784-2-almasrymina@google.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: use-after-free in dma_unmap_sg_attrs() for devmem leased RX b=
indings
--

commit 0978772617865658c49d5d8aff7d5a2c206deaf4
Author: Mina Almasry <almasrymina@google.com>
net: devmem: unmap dma_buf synchronously on queue uninstall

This commit changes the unmapping of the dma_buf attachment to happen
synchronously when the queue is uninstalled. It introduces
net_devmem_dmabuf_binding_unmap() to clear the attachment, preventing a
use-after-free if the physical device is unregistered while references
are still held.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4d60654ce7fd..02d607cc87217 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -153,6 +176,35 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmab=
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
For leased RX queues, if the physical device unregisters, could binding->dev
still point to the virtual device instead of the physical device?

If the physical device unregisters without prior unleasing, or if the queue
was previously uninstalled (setting binding->dev to NULL), this check would
evaluate to true and skip the unmapping. This would leave the dma_buf
mapped to the physical device's dma_dev, which is subsequently freed.

When the binding is ultimately destroyed via
__net_devmem_dmabuf_binding_free(), could this trigger a use-after-free in
dma_buf_unmap_attachment_unlocked() when it accesses the freed dma_dev?

> +
> +	mutex_lock(&binding->lock);
> +	WRITE_ONCE(binding->dev, NULL);
> +	if (!netif_is_queue_leasee(dev))
> +		net_devmem_dmabuf_binding_unmap(binding);
> +	mutex_unlock(&binding->lock);
> +}

[ ... ]

> @@ -529,16 +585,19 @@ static void mp_dmabuf_devmem_uninstall(void *mp_pri=
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
> +			mutex_unlock(&binding->lock);

[Severity: High]
Here binding->dev is unconditionally set to NULL, but for leased queues,
net_devmem_dmabuf_binding_unmap() is explicitly skipped.

If the physical device is later unregistered, won't
net_devmem_dev_unregister_rx() fail to unmap the binding because
binding->dev was already set to NULL?

Could this result in the dma_buf remaining mapped to the physical device
until the binding is eventually freed, causing a use-after-free at that
time?

>  		}
> +		break;
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012174300.2338=
784-1-almasrymina@google.com?part=3D1
