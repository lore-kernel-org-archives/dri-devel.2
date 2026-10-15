Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8D3CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E0C1123B9;
	Thu, 15 Oct 2026 16:18:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3ED1123B9
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:18:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F3C3860234;
 Thu, 15 Oct 2026 16:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BFC1F000C4;
 Thu, 15 Oct 2026 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792081093;
 bh=BRaAbuMqwX2nsBdk49Bwqqj0t8l7j9k9qpRQSZBZRPM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dmkM0dQJWhltNPx6LCrpMTuYbz2EQr8nN0dcLZNhpj8BqzM483f7FeUzEoFRmuf4A
 nki8XevNMJpwJpiMgTJ1B+SXQIEz4uKyU8TgNUND+179pWBp1nHqFx22QqaDL2829R
 63GQvaJMtBccjOvWDghTE2uUJWPDHJc9ZCcT0OFQHYQtMxl0aeoKlawcGIDFXmVFu4
 ogPzxQvTDuWn/FZju/2WYf2Mh4nxXFWBZY6TpqHv76cJHpEFehC6P4ozDBZ0CkQsse
 l8quBhkZ6xh/6OquAKqbcnAyREb0J7CL4RmR6J7082HxbwwVQnJScuSq7gQ64wHGV7
 XKyKCG7ZNEFwg==
Message-ID: <sashiko-outbox-173163@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 3/4] netdevsim: support devmem RX and TX bindings
To: "Mina Almasry" <almasrymina@google.com>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261014161754.3782346-4-almasrymina@google.com>
References: <20261014161754.3782346-1-almasrymina@google.com>
 <20261014161754.3782346-4-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:18:13 +0000
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
- [High] netdevsim: NULL pointer dereference in nsim_pp_hold_write() for VF
--

commit d75afa7b1b5f97be20adbad5ccb5b51d01ca5219
Author: Mina Almasry <almasrymina@google.com>
Date:   Wed Oct 14 16:17:53 2026 +0000

netdevsim: support devmem RX and TX bindings

This commit enables NETMEM_TX_DMA and configures page_pool instances to
support devmem bind-rx and bind-tx operations in netdevsim software tests.
It updates the pp_hold debugfs file to allocate pages from queue 0, adds
a netdev instance lock to prevent concurrent binding swaps, and checks if
the pool is backed by a memory provider.

> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index b4a99f3ceac60..357ea9e5623b3 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c

[ ... ]

> @@ -929,12 +939,15 @@ nsim_pp_hold_write(struct file *file, const char __=
user *data,
>  		return ret;
> =20
>  	rtnl_lock();
> +	netdev_lock(ns->netdev);
>  	ret =3D count;
>  	if (val =3D=3D !!ns->page)
>  		goto exit;
> =20
>  	if (!netif_running(ns->netdev) && val) {
>  		ret =3D -ENETDOWN;
> +	} else if (val && page_pool_is_unreadable(ns->rq[0]->page_pool)) {

[Severity: High]
Does this code dereference a NULL pointer for Virtual Function (VF)
interfaces?

When a VF interface is created and brought up (e.g., via
ip link set dev ethX up, setting netif_running() to true), nsim_queue_init()
is skipped during VF creation, which leaves ns->rq as NULL.

If a user with debugfs write permissions then writes to the VF's pp_hold
file, this condition attempts to evaluate ns->rq[0], dereferencing NULL and
causing a kernel panic.

> +		ret =3D -EOPNOTSUPP;
>  	} else if (val) {
>  		ns->page =3D page_pool_dev_alloc_pages(ns->rq[0]->page_pool);
>  		if (!ns->page)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014161754.3782=
346-1-almasrymina@google.com?part=3D3
