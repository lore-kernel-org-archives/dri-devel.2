Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC281CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0513110E357;
	Fri, 16 Oct 2026 16:39:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE8A10E357
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 16:39:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0519C41072;
 Fri, 16 Oct 2026 16:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EF41F000C4;
 Fri, 16 Oct 2026 16:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792168765;
 bh=YpZhlRpdo/iSCBxTMzeSoLY113F7ztQjUoqTDFIeFA0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S6e8uLISuyB3EaENZeIF3J4vySufKr9bu5npRdJ4feyOt5TISBiGWouT4uNIBhLMF
 xs0uvFAOacUq8UpMxJ3vRm74olhQhN9t+68Q16GiUDvq3iMMgDmjUvoDh3VZhEZqGs
 TfGMCY8N/sxI/h+ORjxHhPreE66lRkYVLF66bB7JFgihiM9cMiIc+yIDNkv4fg2dLe
 ynSpVxdD++yRQ8WGb4SpCcSPgZ9gs364HK4ItCoByiyQvoNQwfJIRgrTG6KM2xQ55G
 pZca5TS+arWN24PD4MWDWCUpZG24hNo7AepyKHwb6y44TMxlYnv5cLzqmJrhnQvCdu
 +dutYp+BAAQRQ==
Message-ID: <sashiko-outbox-174653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
To: "Mina Almasry" <almasrymina@google.com>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261015163915.1166043-4-almasrymina@google.com>
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 16:39:25 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] netdevsim: NULL pointer dereference in nsim_pp_hold_write() for VFs
- [High] net: OOB access in nsim_do_psp() due to missing pskb_may_pull()
- [Medium] bus: missing return value check for dma_coerce_mask_and_coherent=
()
--

commit 4175c230c938d97450e1b621f172ccd40a24af4d
Author: Mina Almasry <almasrymina@google.com>

netdevsim: support devmem RX and TX bindings

Set a 64-bit DMA mask on nsim_bus_dev, enable NETMEM_TX_DMA on the
netdevsim net_device, and configure page_pool instances so devmem bind-rx
and bind-tx netlink operations can be tested against netdevsim.

> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> --- a/drivers/net/netdevsim/bus.c
> +++ b/drivers/net/netdevsim/bus.c
> @@ -462,6 +462,7 @@ nsim_bus_dev_new(unsigned int id, unsigned int port_c=
ount, unsigned int num_queu
>  	nsim_bus_dev->port_count =3D port_count;
>  	nsim_bus_dev->num_queues =3D num_queues;
>  	nsim_bus_dev->initial_net =3D current->nsproxy->net_ns;
> +	dma_coerce_mask_and_coherent(&nsim_bus_dev->dev, DMA_BIT_MASK(64));

[Severity: Medium]
Does the return value of dma_coerce_mask_and_coherent() need to be checked=
=20
here? If the platform rejects the requested 64-bit DMA mask, this function=
=20
can return a negative error code. This might later cause page_pool_create()=
=20
to fail or trigger silent DMA mapping issues when setting up the queues.

>  	/* Disallow using nsim_bus_dev */
>  	smp_store_release(&nsim_bus_dev->init, false);

[ ... ]

> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
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
Could this lead to a NULL pointer dereference for VFs?

When a VF is initialized, nsim_init_netdevsim_vf() is called instead of
nsim_init_netdevsim(). This bypasses nsim_queue_init(), leaving ns->rq as
NULL. Since the 'pp_hold' debugfs file is created unconditionally, writing
'1' to it for a VF interface could reach this code and dereference
ns->rq[0] while ns->rq itself is NULL.

> +		ret =3D -EOPNOTSUPP;
>  	} else if (val) {
>  		ns->page =3D page_pool_dev_alloc_pages(ns->rq[0]->page_pool);

[ ... ]

> diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
> --- a/drivers/net/netdevsim/psp.c
> +++ b/drivers/net/netdevsim/psp.c
> @@ -86,6 +86,11 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
>  		__wsum csum;
>  		int udplen;
> =20
> +		if (!skb_frags_readable(skb)) {
> +			rc =3D SKB_DROP_REASON_PSP_OUTPUT;
> +			goto out_unlock;
> +		}
> +
>  		/* Do not decapsulate. Receive the skb with the udp and psp
>  		 * headers still there as if this is a normal udp packet.
>  		 * psp_dev_encapsulate() sets udp checksum to 0, so we need to
>  		 * provide a valid checksum here, so the skb isn't dropped.
>  		 */
>  		uh =3D udp_hdr(skb);
>  		udplen =3D udp_get_len(skb, uh, skb_transport_offset(skb));
>  		csum =3D skb_checksum(skb, skb_transport_offset(skb),
>  				    udplen, 0);
> =20
>  		switch (skb->protocol) {
>  		case htons(ETH_P_IP):
>  			iph =3D ip_hdr(skb);

[Severity: High]
Is it safe to directly access udp_hdr(skb) and ip_hdr(skb) here without
first verifying that the transport and network headers are in the linear
data region?

If the packet headers reside in paged fragments (for instance, if injected
via AF_PACKET, since the netdevsim device advertises NETIF_F_SG), this
might lead to an out-of-bounds memory access. Could a call to
pskb_may_pull() be needed before accessing these header pointers?

>  			uh->check =3D udp_v4_check(udplen, iph->saddr,
>  						 iph->daddr, csum);
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015163915.1166=
043-1-almasrymina@google.com?part=3D3
