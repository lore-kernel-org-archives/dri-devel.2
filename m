Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B34C5AC67
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 00:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E42810F2F9;
	Fri,  7 Aug 2026 00:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mBkuZQsR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C10D10F2F9
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 00:07:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22C27600B0;
 Fri,  7 Aug 2026 00:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47D61F000E9;
 Fri,  7 Aug 2026 00:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786061229;
 bh=B6mv4cU6ttaFT7HGJN1uTDqy438CyniIusLA8xubXSw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mBkuZQsRihGBlwBwRvuY2AHJ7oAysM7GdzM0tcjzDBCcs3K3YH02A/+fl37+bdyde
 Zmo2oFEnXKjm71+ZVOl//4L5xzf2P+8PZb9wBzC8/H92eKeBewhHfBqZDODQkXe4oj
 rNq1YWIy7H4PqaEm+sb/KlmxnA2X20E1+0Ras2QM5l3qbBLlhxWgYtCmrybzOKgPjC
 /4nGR+hat6ciW0iUGGpcLY6UY5DJMRNbsjOjdre3fTv3lwkVQ3q0KxF/COV0esKwOr
 GVA5YtgZzgr1DIZYr75qJRcz9C3RjK0Ye+HOtC/tXZkvqfsZfprvw06nn6XBnd+ZkU
 RYMPotemrL06Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: fix use-after-free in
 fastrpc_map_attach() error path
To: "Yifei Gao" <gyf161023@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806235056.456341-1-gyf161023@gmail.com>
References: <20260806235056.456341-1-gyf161023@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 00:07:09 +0000
Message-Id: <20260807000709.A47D61F000E9@smtp.kernel.org>
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
- [High] The patch prevents a use-after-free by setting `map->table =3D NUL=
L` in the error path of `fastrpc_map_attach()`, but this erroneously bypass=
es the required `dma_buf_unmap_attachment_unlocked()` cleanup, causing a se=
vere memory and resource leak.
--

--- Patch [1]: [PATCH] misc: fastrpc: fix use-after-free in fastrpc_map_att=
ach() error path ---
commit cfc93c4f96cbcb09d2d76ab41801241697750f77
Author: Yifei Gao <gyf161023@gmail.com>

misc: fastrpc: fix use-after-free in fastrpc_map_attach() error path

This commit clears map->table in the error path of fastrpc_map_attach() to
prevent a use-after-free condition when fastrpc_free_map() subsequently cle=
ans
up the attachment and buffer.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..d6be951d55389 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -915,6 +915,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl=
, int fd,
> =20
>  map_err:
>  	dma_buf_detach(map->buf, map->attach);
> +	map->table =3D NULL;

[Severity: High]
Does this bypass the required DMA unmap operations and leak the sg_table and
IOMMU mappings?

If the length validation fails after the attachment is mapped, the code jum=
ps
to map_err where map->table is set to NULL. When execution falls through to
fastrpc_map_put() and eventually calls fastrpc_free_map(), the cleanup check
will completely skip the unmap:

drivers/misc/fastrpc.c:fastrpc_free_map() {
	...
	if (map->table) {
		...
		dma_buf_unmap_attachment_unlocked(map->attach, map->table,
						  DMA_BIDIRECTIONAL);
		dma_buf_detach(map->buf, map->attach);
		dma_buf_put(map->buf);
	}
	...
}

Because map->table is cleared in the error path without first calling
dma_buf_unmap_attachment_unlocked(), the mapping is never freed. Since this
error path can be reached by an unprivileged user passing a small DMA-BUF w=
ith
a large requested length, can this be exploited to cause unbounded resource
exhaustion?

>  attach_err:
>  	dma_buf_put(map->buf);
>  get_err:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806235056.4563=
41-1-gyf161023@gmail.com?part=3D1
