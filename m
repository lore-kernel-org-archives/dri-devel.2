Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013A0C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC1110E424;
	Wed, 22 Jul 2026 11:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cm57ohbG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA11C10E424
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 11:27:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A5F54417A4;
 Wed, 22 Jul 2026 11:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD131F000E9;
 Wed, 22 Jul 2026 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784719628;
 bh=qrMT8djc+OY4B40F/4R0ChLnJvMx1TnDxi98vlGPRUE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cm57ohbG6dcaDY17Mm1ddppJC6frE9FbEFLcZExqz0zLq84YmceutEcCg2DD2RmOc
 AJwmz2pJUeeAf6rRQFpveYpqVciv9w3ZW/TqruCuVWAcrNAaXdA1yFcEUof94+Emht
 2Et20GttuBxsR3BGxIOLghgVFOpfFEAWqIu40tzcqAzCNTMkohCjSUob9J0ojDHqqL
 6jHes8kla/Cvm24lNE4thRIoq4eABFqeDhq+/i8o7VOid9Z3GlKo5cu5VJa8BdU219
 aVOIIMRpBCczVJJ9tjg6KdofKmwT2qhQy0ocnC1AEPGWD8+kBICeORVocHvJQjvhaU
 DNc27OH4Sa1OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dma-buf/udmabuf: Disable the size limit by default
To: "Robert Mader" <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260722110145.36641-1-robert.mader@collabora.com>
References: <20260722110145.36641-1-robert.mader@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 11:27:07 +0000
Message-Id: <20260722112708.5CD131F000E9@smtp.kernel.org>
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

New issues:
- [High] Removing the dmabuf size limit (by setting `size_limit_mb` to `INT=
_MAX`) allows an unprivileged user to request a massive buffer size (up to =
~2.2 TB). This forces the kernel to attempt massive unbounded vmalloc alloc=
ations for the internal tracking arrays, rapidly exhausting system memory a=
nd triggering the OOM killer.

Pre-existing issues:
- [High] Setting `size_limit_mb` to `INT_MAX` allows unprivileged users to =
create udmabufs of 4GB or larger. On 32-bit architectures, this triggers an=
 integer overflow when converting the page count back to bytes (`ubuf->page=
count << PAGE_SHIFT`), resulting in a size of 0 or a severely truncated val=
ue.
--

--- Patch [1]: [PATCH v2] dma-buf/udmabuf: Disable the size limit by defaul=
t ---
commit f1c9db60e57729e9743c42b43759bab6d0eafb5d
Author: Robert Mader <robert.mader@collabora.com>

dma-buf/udmabuf: Disable the size limit by default

This commit disables the default 64MB size limit for udmabuf by setting it
to INT_MAX. It aims to support users who need larger buffers for high
resolution video formats. The change assumes the per-buffer size limit does
not provide sufficient protection on its own.

Link: https://lore.kernel.org/dri-devel/20260711144814.8205-1-robert.mader@=
collabora.com/
Link: https://lore.kernel.org/dri-devel/6764ca6f-b4d8-4baa-9d27-2ca867ac2d4=
1@amd.com/

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index bced421c0d658..639e937049242 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -20,9 +20,9 @@ static int list_limit =3D 1024;
>  module_param(list_limit, int, 0644);
>  MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default =
is 1024.");
> =20
> -static int size_limit_mb =3D 64;
> +static int size_limit_mb =3D INT_MAX;

[Severity: High]
Does this change allow an unprivileged user to exhaust kernel memory?=20

Because the size limit is effectively removed, an unprivileged user can
request an extremely large buffer size via /dev/udmabuf.

Looking at udmabuf_create() and init_udmabuf(), the internal tracking
arrays are allocated based on this requested size:

drivers/dma-buf/udmabuf.c:udmabuf_create() {
    ...
    folios =3D kvmalloc_array(max_nr_folios, sizeof(*folios), GFP_KERNEL);
    ...
}

drivers/dma-buf/udmabuf.c:init_udmabuf() {
    ...
    ubuf->pages =3D kvmalloc_objs(*ubuf->pages, pgcnt);
    ...
}

Since these allocations use GFP_KERNEL without __GFP_ACCOUNT, they bypass
memory cgroups. Could a large request trigger unbounded vmalloc allocations
that consume gigabytes of memory per ioctl call, leading to an OOM conditio=
n?


[Severity: High]
This is a pre-existing issue, but does removing the size limit expose a
page count overflow on 32-bit architectures?

When a user requests a size of 4GB or larger, the pagecount exceeds
1048576. In export_udmabuf() and get_sg_table(), the size is calculated by
shifting the page count:

drivers/dma-buf/udmabuf.c:export_udmabuf() {
    ...
    exp_info.size =3D ubuf->pagecount << PAGE_SHIFT;
    ...
}

drivers/dma-buf/udmabuf.c:get_sg_table() {
    ...
    ret =3D sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->pagecount, 0,
                                    ubuf->pagecount << PAGE_SHIFT,
                                    GFP_KERNEL);
    ...
}

On 32-bit architectures, this 32-bit arithmetic wraps around to 0. Can
this result in a truncated dma-buf size or an invalid SG table with
0-length elements, potentially causing a panic in IOMMU drivers?

>  module_param(size_limit_mb, int, 0644);
> -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Def=
ault is 64.");
> +MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Def=
ault is INT_MAX.");
> =20
>  struct udmabuf {
>  	pgoff_t pagecount;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722110145.3664=
1-1-robert.mader@collabora.com?part=3D1
