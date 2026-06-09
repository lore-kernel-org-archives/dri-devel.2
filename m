Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A892CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D96F410E3C9;
	Tue,  9 Jun 2026 14:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fyCGh/xG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B366C10E3C9
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 14:10:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5959041AFF;
 Tue,  9 Jun 2026 14:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222A41F00893;
 Tue,  9 Jun 2026 14:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781014214;
 bh=Zf5HPSBu5AtK6hxcW9/kzL8rg9XaCRiKH5q4K2I7+48=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fyCGh/xGmbyN1Xvh5819s8C971RblQJm/74vCs5hbBC9xJDFHkjBKiywT9QnwVuMu
 XWc7c9srey6CFBTiVPQ9fjY85rwG3XfdSpryrPmQ1A2D0zEEnNjPbhDEqv3blAJ2CS
 V7EeuwiCc9yNKlBVv/pRlpcSTLrc+4wNwUyFx4Xcgze7P9japLrCFChCuL4pGTEgYj
 HsxttMXjcp1Jc512X2xrPlg109I0DXT2SwsnSoYHZ28uknI4CUo3nJdYv7mHkOWrxI
 z8NNLmDOm+959Y5vxPNcEpyNsOorCMNVNeEVCvgmy8gNdiAmVahqRnnTlkbClaqOj3
 KtOYi1BIWJ+vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: enable sg_table wrapping on CONFIG_DEBUG
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609135939.2606-1-christian.koenig@amd.com>
References: <20260609135939.2606-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 14:10:13 +0000
Message-Id: <20260609141014.222A41F00893@smtp.kernel.org>
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
- [Medium] The `dma_buf_wrap_sg_table()` and `dma_buf_unwrap_sg_table()` fu=
nctions incorrectly check for `CONFIG_DEBUG`, which is not a valid or defin=
ed Kconfig option, unconditionally disabling the feature.
--

commit b10cbc45f527d11143178ac04d087f2e2061de9c
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

dma-buf: enable sg_table wrapping on CONFIG_DEBUG

This commit changes the conditional for wrapping sg_tables from
CONFIG_DMABUF_DEBUG to CONFIG_DEBUG. The intent is to catch bad
importers doing nasty things by broadening when this feature is enabled.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc294..9caef606fba14 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -861,7 +861,7 @@ static int dma_buf_wrap_sg_table(struct sg_table **sg=
_table)
>  	struct dma_buf_sg_table_wrapper *to;
>  	int i, ret;
> =20
> -	if (!IS_ENABLED(CONFIG_DMABUF_DEBUG))
> +	if (!IS_ENABLED(CONFIG_DEBUG))

[Severity: Medium]
Is CONFIG_DEBUG a defined Kconfig option in the kernel? I could not find it.
Since it doesn't exist (unlike CONFIG_DEBUG_KERNEL or CONFIG_DEBUG_FS),
this will unconditionally evaluate to false and completely disable the
wrapping feature. Was a different debug config intended here?

>  		return 0;
> =20
>  	/*
[ ... ]
> @@ -900,7 +900,7 @@ static void dma_buf_unwrap_sg_table(struct sg_table *=
*sg_table)
>  {
>  	struct dma_buf_sg_table_wrapper *copy;
> =20
> -	if (!IS_ENABLED(CONFIG_DMABUF_DEBUG))
> +	if (!IS_ENABLED(CONFIG_DEBUG))

[Severity: Medium]
Will unwrapping also become permanently disabled here due to the undefined
Kconfig option?

>  		return;
> =20
>  	copy =3D container_of(*sg_table, typeof(*copy), wrapper);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609135939.2606=
-1-christian.koenig@amd.com?part=3D1
