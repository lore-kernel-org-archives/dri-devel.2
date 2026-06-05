Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A209CCD6E6B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB69311A4C0;
	Fri,  5 Jun 2026 07:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TVpqH1Qv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC61911A4BE
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 07:03:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03B5C600AA;
 Fri,  5 Jun 2026 07:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E33F1F00898;
 Fri,  5 Jun 2026 07:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780643030;
 bh=h2xwZQW682m/lc+RgTVbyQzaLz4+QD4JGz2IG59VZaw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TVpqH1QvQcJvHOAwE184MccNwmTte/P7TW1V2LSU9Z9ENobTH2dYlZhGFnjQDM4JW
 0d90bXUGKWsdQs9DWkkmWuuK4dPRQNNh+U1gPUPe5TkdMkj6Jtd3ugcag5Za2PqJAm
 yd8TL++jrvjS+pptmhjhRRg56fc8D9gj601U768cqHXW3fnop6yEpnGwTQxs+52m9a
 jdKqS28u8EjB+wYN1/F6TSsSkg3gEmjapaWrx9bdjvf0rmkS1lIFlHqO080/MAsX6U
 1nigfnAe2jC3mG+SnPYmqdwkFbcBMACW2lQJgpFPYwmnB4a1OoXwNN7Py9GMl/V8nM
 I9P5sooXaJG5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/4] net: devmem: allow rx-buf-size > PAGE_SIZE
 per dmabuf binding
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
In-Reply-To: <20260603-tcpdm-large-niovs-v1-1-f37a4ac6726c@meta.com>
References: <20260603-tcpdm-large-niovs-v1-1-f37a4ac6726c@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 07:03:50 +0000
Message-Id: <20260605070350.7E33F1F00898@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] The `tx_vec` array is allocated without zero-initialization, l=
eading to dereferencing uninitialized pointers if the mapped SG table is sm=
aller than the dmabuf.
- [Critical] The `tx_vec` array can be overflowed if a dmabuf exporter retu=
rns an SG table whose total mapped length exceeds `dmabuf->size`.
--

commit 19418ca41b5b75f8c09b7526af4fcb2ea506b0fa
Author: Bobby Eshleman <bobbyeshleman@meta.com>
Subject: net: devmem: allow rx-buf-size > PAGE_SIZE per dmabuf binding

This patch adds a bind-time netlink attribute, NETDEV_A_DMABUF_RX_BUF_SIZE,
that lets userspace request a larger niov size for devmem dmabuf bindings,
allowing rx-buf-size > PAGE_SIZE.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -248,18 +256,14 @@ net_devmem_bind_dmabuf(struct net_device *dev, void=
 *vdev,
>  			goto err_unmap;
>  		}
>  		binding->tx_vec =3D kvmalloc_objs(struct net_iov *,
> -						dmabuf->size / PAGE_SIZE);
> +						dmabuf->size >> niov_shift);

[Severity: Critical]
This isn't a bug introduced by this patch, but since kvmalloc_objs() doesn't
zero-initialize the memory, is it possible for uninitialized pointers to be
returned later?

If a dmabuf exporter returns an SG table whose total mapped length is less
than dmabuf->size, the trailing elements of the tx_vec array would remain
uninitialized. When userspace requests transmission with an offset beyond
the mapped length but within dmabuf->size, net_devmem_get_niov_at() would
read from this uninitialized memory and return a garbage pointer to the
datapath.

[ ... ]

> @@ -313,7 +319,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *=
vdev,
>  			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
>  						      net_devmem_get_dma_addr(niov));
>  			if (direction =3D=3D DMA_TO_DEVICE)
> -				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] =3D niov;
> +				binding->tx_vec[(owner->area.base_virtual >> niov_shift) + i] =3D ni=
ov;

[Severity: Critical]
This is a pre-existing issue, but does this loop lack bounds checking
against the actual allocated size of tx_vec?

The tx_vec array is allocated to hold dmabuf->size >> niov_shift elements.
If a buggy or malicious dmabuf exporter returns an SG table that maps more
data than expected (exceeding dmabuf->size), this loop will write pointers
past the end of the dynamically allocated tx_vec array, corrupting adjacent
kernel memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-tcpdm-larg=
e-niovs-v1-0-f37a4ac6726c@meta.com?part=3D1
