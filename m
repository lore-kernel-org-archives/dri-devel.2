Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB84C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E545D10E096;
	Mon, 21 Sep 2026 09:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DhC46ye0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C68AB10E096
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:58:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 174D6600C8;
 Mon, 21 Sep 2026 09:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A393E1F000FF;
 Mon, 21 Sep 2026 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789984736;
 bh=deGJJPQ8pdOFb/uMO41wLZDRV69O72eDtFivMOyIoSI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DhC46ye0cm3mg40hUpo9KSP64xWrzCNUBWMgKxt4JZnPAkzWNSm10NSHZ/HrJAfHx
 6JvWzrgdTAGJgRu6kU0/dmZD7caFaxvqkfB3uCvK3FJKcLmxjnG87W9yFj/dytSRdW
 kaGPfq1fyAoW9gnGUllpWfGrduXYB1nyFpjnC2+PM2Yr9ZAVjLXvXMckVgZxQa8ukZ
 oQQsyUAC9ucbXUfyMxEbVL6Wv9kt7WEwbyozw7lCiUMEHNkb+IAoc8gNyJESOG0tth
 c3kFwTwoCkr0baaHfAlpUuv+byuflOhWsmChRkEFIov+IDxkiRjwc6gJAWlRKSMbjz
 F9z9WT3NDQqzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: remove pci-p2pdma include from dma-buf.h
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921094452.679455-1-christian.koenig@amd.com>
References: <20260921094452.679455-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:58:56 +0000
Message-Id: <20260921095856.A393E1F000FF@smtp.kernel.org>
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
- [Low] mlx5: compilation failure due to missing pci-p2pdma.h include
--

commit b5028b6ecc514cd51ffdd0df7d0570f15757e7f7
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

dma-buf: remove pci-p2pdma include from dma-buf.h
   =20
That is unecessary here and creates an unwanted dependency to the PCI
subsystem. Move that into dma-buf-mapping.h instead.

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
Does removing this include break the compilation of the RDMA mlx5 driver?

It appears the mlx5 driver and ib_verbs.h implicitly relied on dma-buf.h
providing declarations for pcim_p2pdma_provider and pcim_p2pdma_init.

Compiling with CONFIG_MLX5_INFINIBAND enabled results in implicit function
declaration errors:

drivers/infiniband/hw/mlx5/main.c:mlx5_ib_mmap_get_pfns() {
    ...
    *provider =3D pcim_p2pdma_provider(pdev, bar);
    ...
}

drivers/infiniband/hw/mlx5/main.c:mlx5_ib_stage_init_init() {
    ...
    err =3D pcim_p2pdma_init(mdev->pdev);
    ...
}

It also causes a warning in include/rdma/ib_verbs.h where
struct p2pdma_provider is used without a forward declaration in
struct ib_device_ops:

include/rdma/ib_verbs.h:struct ib_device_ops {
    ...
    struct p2pdma_provider **provider);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921094452.6794=
55-1-christian.koenig@amd.com?part=3D1
