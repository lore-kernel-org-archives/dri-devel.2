Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A083ACD8CA8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 07:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A8910ECE7;
	Sat, 13 Jun 2026 07:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cyefMFHX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7981210ECE7
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 07:46:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49D7440DFD;
 Sat, 13 Jun 2026 07:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E9B1F000E9;
 Sat, 13 Jun 2026 07:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781336778;
 bh=X5tlP2d67yfGVGCCX1vjE9M91EpXRf2OWl+G5t+r7Bk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cyefMFHXXIeDA2zYZVgMyWoV/kmSaObIzxsSrSEh2QPVvbJg5WPF9eVA8J+dTL58A
 Wo9BvBZb5FeNtLh5Q+DmhOJU2MJndqXiFka3sBSywEgN4cEfUVRrQtd0fzFYdGkHls
 s3ePMaEKPT6YhpAcHVVSts92LZcUPABpiuYZW+1P3KDxqGIt2Ea94rffgE63od4zzn
 VdUyy7aP/HGkg3qEkXle+FBzz/CjMOS4BwkpRiM9yWKGbwiqgYoyERm4Tcanjvkixp
 a/C0r/Af/6eW1Td9FP8Cr/0CS35Mw8NFvOJSWoFq+jyvRoWcYBWQBus3bdlLjHi25F
 u08NmQ8f5hrEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-tcpdm-large-niovs-v2-1-ee2bf15e7523@meta.com>
References: <20260611-tcpdm-large-niovs-v2-1-ee2bf15e7523@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:46:17 +0000
Message-Id: <20260613074618.06E9B1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Double free of `rsp` sk_buff in `netdev_nl_bind_rx_doit` on th=
e `genlmsg_reply` error path
--

commit d5aaaaf7bcf98f7060fb724bf8b3e6c07879798d
Author: Bobby Eshleman <bobbyeshleman@meta.com>

net: devmem: allow rx-buf-size > PAGE_SIZE per dmabuf binding

Every devmem dmabuf binding today hands the page_pool PAGE_SIZE niovs.
This caps a single RX descriptor at PAGE_SIZE, burning CPU on buffer
churn for large flows.

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b4d48f3672a5b..8709e9c94389f 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
[ ... ]
> @@ -1078,7 +1092,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, str=
uct genl_info *info)
>  	}
> =20
>  	binding =3D net_devmem_bind_dmabuf(netdev, NULL, dma_dev, DMA_FROM_DEVI=
CE,
> -					 dmabuf_fd, priv, info->extack);
> +					 dmabuf_fd, niov_shift, priv,
> +					 info->extack);
>  	if (IS_ERR(binding)) {
>  		err =3D PTR_ERR(binding);
>  		goto err_rxq_bitmap;

[Severity: Critical]
This is a pre-existing issue, but while reviewing this function I noticed a
potential double-free in the error path of netdev_nl_bind_rx_doit().

When genlmsg_reply() is called, it unconditionally consumes the rsp skb
(either by successfully transmitting it or freeing it internally via
kfree_skb() inside netlink_unicast()).

If genlmsg_reply() fails, it returns an error and jumps to err_unbind, which
falls through to err_genlmsg_free:

	err =3D genlmsg_reply(rsp, info);
	if (err)
		goto err_unbind;

...

err_unbind:
	net_devmem_unbind_dmabuf(binding);

...

err_genlmsg_free:
	nlmsg_free(rsp);
	return err;

Since nlmsg_free() is an alias for kfree_skb(), won't this result in a
double-free on the same pointer? Does this error path need to be updated to
avoid freeing the already consumed skb?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-tcpdm-larg=
e-niovs-v2-0-ee2bf15e7523@meta.com?part=3D1
