Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852BFC982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A664110E6FB;
	Mon, 21 Sep 2026 12:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S+fT+EQK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0D210E151
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:43:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E543600D1;
 Mon, 21 Sep 2026 12:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA84E1F000FF;
 Mon, 21 Sep 2026 12:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789994627;
 bh=FK9eXTT/9ww/Ib4uuY97FdnOfnYbJzloexgo+FKQG4Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S+fT+EQKZeUJiKzlw4uWFObpw5ZtVs/K9SbTAypNoEccjdhP9JKauz+JsSzxjEOgq
 +84lt9Omd1/sv+uu8QgAO0CBATCx2efcIYVSRd2fainX/1uD4TEXLOuXh7X8fK2z3M
 3Y3CGzgYQRw1RssPCYBJiEucvNre3MZRbRVNSIlu+3z8oBctKnk4hQUe/jcwBVTPrH
 aIGph8ZkTHu+BG7VTEWwHtVhq9RDYEYEmUCe1JeVMOVjP5NLDlanp7T75zwoF0lzuj
 hLfnM7l5Riwj/+Zu1q1MZiAyNs4iNBFb+i5SgQxFyuQ3NbVhsAL4bW3DzVW+/sG+Yv
 VvmmhwIWEwUwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: remove pci-p2pdma include from dma-buf.h v2
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921123613.683042-1-christian.koenig@amd.com>
References: <20260921123613.683042-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 12:43:46 +0000
Message-Id: <20260921124346.DA84E1F000FF@smtp.kernel.org>
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
- [Low] dma-buf: build failure in dma-buf-mapping.c due to missing pci-p2pd=
ma include
--

commit 8de2b0ebefc837cd0e3d5d4be72922d840602ba3
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
dma-buf: remove pci-p2pdma include from dma-buf.h v2

This commit removes the <linux/pci-p2pdma.h> include from <linux/dma-buf.h>=
 to
eliminate an unwanted dependency on the PCI subsystem. It uses a forward
declaration in <linux/dma-buf-mapping.h> instead.

> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d15b2b31d3c91..159271fcf3d2e 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -22,7 +22,6 @@
>  #include <linux/fs.h>
>  #include <linux/dma-fence.h>
>  #include <linux/wait.h>
> -#include <linux/pci-p2pdma.h>

[Severity: Low]
Does removing this include break the build for
drivers/dma-buf/dma-buf-mapping.c?

That file unconditionally uses functions and enum values from the pci-p2pdma
header without explicitly including it, relying on this transitive inclusio=
n.
For example:

drivers/dma-buf/dma-buf-mapping.c:dma_buf_phys_vec_to_sgt() {
...
	switch (pci_p2pdma_map_type(provider, attach->dev)) {
	case PCI_P2PDMA_MAP_BUS_ADDR:
...
}

Will this lead to a compile-time failure for drivers/dma-buf/dma-buf-mappin=
g.c
due to undeclared identifiers?

> =20
>  struct device;
>  struct dma_buf;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921123613.6830=
42-1-christian.koenig@amd.com?part=3D1
