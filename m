Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C35CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2439B112733;
	Fri, 16 Oct 2026 10:10:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B5E10E0BE
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:09:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 04D4C600D4;
 Fri, 16 Oct 2026 10:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856CE1F000C4;
 Fri, 16 Oct 2026 10:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792145394;
 bh=mHRPYKWvwDnufwGMtxhQGmL+/uEhd49L4x2uShnvp4U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ljad7zW4rTXPANbtuZxLZJDT+TpbvFqryGpxvoPBLxmDn7LoC+EdAYPepxszGqjws
 tZS6Dju0lyyCS++HjXBp1hakvgETg7o4oQhHHxNzZvZYzVjzhcwhWUN/pPa5cor73S
 S4/9+937XjZ+Tx0FnnBNjdG/XKyxjwnEAzvublBhuANPKCsWlAdc9kIoSs/ZivfN45
 rchr+VJHsz1IKAH2qt+EArLJfjHTEIVt2sGKvTsqdHHR8U2De+96QEBaVLAe6Wd55r
 tcRigUqee+OaH0icNc9Auo6CexuWk/SZCnU5HOJ37b1gi6xJm4y0Q6i63Sdgp6NSgD
 e+Ynfh7t1csyg==
Message-ID: <sashiko-outbox-174125@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] dma-buf-io: document dma_buf_io_init_map
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <a9fdfbe6e447ac583f4d3a3f981b203141a624c4.1792144609.git.asml.silence@gmail.com>
References: <cover.1792144609.git.asml.silence@gmail.com>
 <a9fdfbe6e447ac583f4d3a3f981b203141a624c4.1792144609.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:09:54 +0000
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
- [Low] dma-buf: incorrect documentation of map parameter direction
--

commit 1158f35d78a501cf423bc44ae35a1645c81c621d
Author: Pavel Begunkov <asml.silence@gmail.com>

dma-buf-io: document dma_buf_io_init_map
   =20
This commit adds a kerneldoc for dma_buf_io_init_map().

> diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
> index e432194a5dfc0..8440151de8600 100644
> --- a/drivers/dma-buf/dma-buf-io.c
> +++ b/drivers/dma-buf/dma-buf-io.c
> @@ -43,6 +43,18 @@ static void dma_buf_io_kill_map(struct dma_buf_io_ctx =
*ctx)
>  	dma_buf_io_map_release(map);
>  }
> =20
> +/**
> + * dma_buf_io_init_map - Initialise the map.
> + * @ctx:	[in]	dma-buf I/O context the map is created for
> + * @map:	[in]	dma-buf I/O map

[Severity: Low]
Is the [in] annotation correct for the map parameter here? Since
dma_buf_io_init_map() initializes the internal fields of the map struct,
this functions as an output parameter. Should this be documented as [out]
or [in,out] instead?

> + * @sgt:	[in]	the backing scatter-gather table
> + *
> + * Importer's helper that initialises @map for the provided I/O context
> + * and scatter-gather table. The importer should call it once for each m=
ap
> + * on creation.
> + *
> + * Return: 0 on success, or a negative errno code otherwise.
> + */
>  int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_ma=
p *map,
>  			struct sg_table *sgt)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792144609.gi=
t.asml.silence@gmail.com?part=3D2
