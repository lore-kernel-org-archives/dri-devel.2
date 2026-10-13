Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9D6CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A1610E3BB;
	Tue, 13 Oct 2026 17:43:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEEE310E5F1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:43:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B35A60A5E;
 Tue, 13 Oct 2026 17:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810941F000FF;
 Tue, 13 Oct 2026 17:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791913403;
 bh=yJjlSJtJYNMqtUndQ74YyJg9FOfyqfdfrhdF9cegVl4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g8w/QWQg263IDeIFjCcG8fR25UW8IWCMs9FzsYwWcqh2JxuDihVUensBMdxWJiBcJ
 8OtNi+i4DroXVWvvYBJJg6KPZclNiBedOJ17r31L+oEnc3AbluWJ7DgYcmM3kKCUot
 RO2pYFAZfrz8w4VpczF8blRQugOq6otTB/H4eM60527w6T3c0NsfVP5gCnYbu37gVr
 TugV048QAZD/Zlt+A/8bICscMu4yuuCQVhGLBSP/rstHFy8w7H98IcsTNRRChcdV6F
 t2h8s1o6bYrRDNxR/SGgnNQslmE/gozl76Z8hC/jqykbDMD/RWwZuz4KUg87BXGu6S
 iaKIzYWy2yKRA==
Message-ID: <sashiko-outbox-170251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 3/4] netdevsim: support devmem RX and TX bindings
To: "Mina Almasry" <almasrymina@google.com>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261012174300.2338784-4-almasrymina@google.com>
References: <20261012174300.2338784-1-almasrymina@google.com>
 <20261012174300.2338784-4-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:43:23 +0000
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
- [Medium] netmem: devmem leak and kernel warning in nsim_pp_hold_write()
--

commit b58e0da7daeddfad13177ed902471523d6b96cbf
Author: Mina Almasry <almasrymina@google.com>

netdevsim: support devmem RX and TX bindings

Set a 64-bit DMA mask on nsim_bus_dev, enable NETMEM_TX_DMA on the
netdevsim net_device, and configure page_pool instances with
PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | PP_FLAG_ALLOW_UNREADABLE_NETMEM
and queue_idx so devmem bind-rx and bind-tx netlink operations can be
tested against netdevsim in software selftests.

> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index b4a99f3ceac60..4415dc01c610b 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c

[ ... ]

> @@ -414,16 +414,22 @@ static int nsim_poll(struct napi_struct *napi, int =
budget)
>  	return done;
>  }
> =20
> -static int nsim_create_page_pool(struct page_pool **p, struct napi_struc=
t *napi)
> +static int nsim_create_page_pool(struct net_device *dev, struct page_poo=
l **p,
> +				 struct napi_struct *napi, int idx)
>  {
> +	struct netdevsim *ns =3D netdev_priv(dev);
>  	struct page_pool_params params =3D {
>  		.order =3D 0,
>  		.pool_size =3D NSIM_RING_SIZE,
> +		.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
> +			 PP_FLAG_ALLOW_UNREADABLE_NETMEM,

[Severity: Medium]
When PP_FLAG_ALLOW_UNREADABLE_NETMEM is set and devmem is bound, will this
cause a leak and kernel warning in the debugfs handler?

If nsim_pp_hold_write() is called to test allocating memory from the pool,
it uses page_pool_dev_alloc_pages():

drivers/net/netdevsim/netdev.c:nsim_pp_hold_write() {
    ...
	} else if (val) {
		ns->page =3D page_pool_dev_alloc_pages(ns->rq[0]->page_pool);
		if (!ns->page)
			ret =3D -ENOMEM;
    ...
}

Because devmem may be bound, page_pool_alloc_netmems() can allocate an
unreadable net_iov. When this is passed to netmem_to_page(), it detects an
IOV, triggers a WARN_ON_ONCE(), and returns NULL.

nsim_pp_hold_write() receives NULL and returns -ENOMEM, leaking the
allocated devmem netmem_ref because it is neither stored nor freed.=20

While this is restricted to root via debugfs, does this break the exact
devmem testing functionality this patch intends to support?

> +		.max_len =3D PAGE_SIZE,
>  		.nid =3D NUMA_NO_NODE,
> -		.dev =3D &napi->dev->dev,
> +		.dev =3D &ns->nsim_bus_dev->dev,
>  		.napi =3D napi,
>  		.dma_dir =3D DMA_BIDIRECTIONAL,
> -		.netdev =3D napi->dev,
> +		.netdev =3D dev,
> +		.queue_idx =3D idx,
>  	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012174300.2338=
784-1-almasrymina@google.com?part=3D3
