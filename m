Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BAECCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC3A10E29E;
	Fri, 16 Oct 2026 09:41:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D6D10E29E
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:41:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E413B600D4;
 Fri, 16 Oct 2026 09:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB6A1F000C4;
 Fri, 16 Oct 2026 09:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792143668;
 bh=PHHbwqh2w4rwxYnpn70DSdq6t7YJjn6AxsyOTrHIDTA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ngAjf8zxgL1SsBT+6EQ0ffxHk0/nnEoxfLQ3kHgeAtDRgTQkWNldaPWr01in1jmhE
 RHthQwfJsD2R2afmBrXAU4BhIoU9UUvq85sijMha+AvWUbq9Xbnq0nDQscnvFa1MDh
 SPvsYrTYvOxhZBOOHe0mYFItpcUDV0S4VIs5uO49VkIy6bmy3BziSRwcmCHd+WPWT4
 okDk2ARujGkDAcg3AJd4Ji3Pc0aQ4ba0q4oEOewDqfiU6QPoy5TJyZIqqabM5hIgK1
 zp1JZh7ek9xWo5IB/4ezh2+A1B57eHY5ZE2ZmoIigOOppCPcM9sL0IOf9VGSohaoBO
 7t3RBgbe02bJg==
Message-ID: <sashiko-outbox-174086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] dma-buf-io: document dma_buf_io_init_map
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <79e1cc681326365d2105203b318d8a27ed7e90d7.1792142927.git.asml.silence@gmail.com>
References: <cover.1792142927.git.asml.silence@gmail.com>
 <79e1cc681326365d2105203b318d8a27ed7e90d7.1792142927.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 09:41:07 +0000
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
- [Low] dma-buf: incorrect return value documentation in dma_buf_io_init_ma=
p() kerneldoc
--

commit b6debb4c02ab1cee94fc3f78293f8425b78664d4
Author: Pavel Begunkov <asml.silence@gmail.com>

dma-buf-io: document dma_buf_io_init_map

This commit adds kerneldoc documentation for the dma_buf_io_init_map()
function.

> diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
> index e432194a5dfc0..f724936e223b1 100644
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
> + * @sgt:	[in]	the backing scatter-gather table
> + *
> + * Importer's helper that initialises @map for the provided I/O context
> + * and scatter-gather table. The importer should call it once for each m=
ap
> + * on creation.
> + *
> + * Returns a map on success, or a negative errno code otherwise.

[Severity: Low]
This isn't a bug, but the kerneldoc states this function returns a map,
while the actual implementation returns an int (0 on success) and modifies
the map argument in place.=20

Could this be updated to accurately reflect the return value and use the
standard "Return:" tag format expected by automated kerneldoc tools?

> + */
>  int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_ma=
p *map,
>  			struct sg_table *sgt)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792142927.gi=
t.asml.silence@gmail.com?part=3D2
