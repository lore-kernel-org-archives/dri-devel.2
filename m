Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6F3C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D130910E477;
	Fri, 17 Jul 2026 13:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IjHhOTjU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 684D610E477
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:12:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E87814139A;
 Fri, 17 Jul 2026 13:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A612F1F000E9;
 Fri, 17 Jul 2026 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784293945;
 bh=y7ig37PcRO/JYiXJOqtqVnBeLxf+//Lh4TTh/Zt3qjE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IjHhOTjUpLBuhDMXByBfIopUGHSgwkVpjDelAed0Ot3/XgDsn9wGipQYeQl4TmA3K
 p9jwi9vGxGOhHkfenayN+34TGGg/CH7eI+99283eZlX1fe5T3EjQLsL2htmfzgqBfd
 Bq6QmoKk8Ha4er2VkdKkDVk4V1+meObBLoXYpqzyVwRPKxRVRGzqD75kVbm+GCAYHU
 j8kcAGasrw2V58Q0VsrI1B0Z8H1MDWvlRTzawlsodcHN1ARH7hjUao/uNrNcKaEHg0
 YkHdmw1zw2Qpu6Z3VoRjE1jzjaNr44EfeIgM4mE+X7GaH+QE4H4kLOUhq8mJgqUqho
 AhKhWn+8xZoSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] dma-buf/udmabuf: Disable the size limit by default
To: "Robert Mader" <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260717125750.62639-1-robert.mader@collabora.com>
References: <20260717125750.62639-1-robert.mader@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:12:24 +0000
Message-Id: <20260717131225.A612F1F000E9@smtp.kernel.org>
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
- [Critical] Removing the default size limit exposes an integer overflow on=
 32-bit architectures during `pgcnt` accumulation, leading to a critical he=
ap buffer overflow.
- [High] Removing the default `size_limit_mb` allows an unprivileged user t=
o force arbitrary unbound kernel memory allocations via `kvmalloc()`, leadi=
ng to a global OOM.
--

--- Patch [1]: [PATCH v1] dma-buf/udmabuf: Disable the size limit by defaul=
t ---
commit 99ebd05d75131f1777563136d3ba9224beb0dc68
Author: Robert Mader <robert.mader@collabora.com>

dma-buf/udmabuf: Disable the size limit by default

This commit changes the default size limit for udmabuf to 0, which
disables the limit. It modifies the size check in udmabuf_create()
to bypass validation when the limit is 0.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 08f57bc1294df..3ebc1742f3ff7 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
[ ... ]
> @@ -374,7 +374,7 @@ static long udmabuf_create(struct miscdevice *device,
> =20
>  		subpgcnt =3D list[i].size >> PAGE_SHIFT;
>  		pgcnt +=3D subpgcnt;
> -		if (pgcnt > pglimit)
> +		if (pglimit && pglimit < pgcnt)
>  			goto err_noinit;

[Severity: High]
Does removing this default size limit allow unprivileged users to force
arbitrary unbound kernel memory allocations and trigger a global OOM?

With pglimit bypassed, a user could submit an ioctl(UDMABUF_CREATE)
with a massive size. The unbound pgcnt is then passed to init_udmabuf(),
which allocates metadata arrays via kvmalloc_objs() using GFP_KERNEL:

drivers/dma-buf/udmabuf.c:init_udmabuf() {
    ...
    ubuf->pages =3D kvmalloc_objs(*ubuf->pages, pgcnt);
    ...
}

For huge requests, the vmalloc fallback executes with GFP_KERNEL and without
__GFP_RETRY_MAYFAIL or __GFP_ACCOUNT. Could this force the page allocator to
invoke the global OOM killer?

[Severity: Critical]
Does bypassing this size check also expose an integer overflow regression on
32-bit architectures?

On 32-bit systems, pgcnt is a 32-bit pgoff_t. A user could submit an ioctl
with multiple items whose subpgcnt values sum to exceed U32_MAX. This would
wrap pgcnt around to a small positive value.

init_udmabuf() would then allocate a tiny array for ubuf->pages:

drivers/dma-buf/udmabuf.c:init_udmabuf() {
    ...
    ubuf->pages =3D kvmalloc_objs(*ubuf->pages, pgcnt);
    ...
}

However, udmabuf_pin_folios() processes each item individually based on its
original size and writes sequentially into ubuf->pages. This could massively
overflow the undersized allocation:

drivers/dma-buf/udmabuf.c:udmabuf_pin_folios() {
    ...
    ubuf->pages[upgcnt] =3D folio_page(folios[cur_folio],
                                     subpgoff >> PAGE_SHIFT);
    ++upgcnt;
    ...
}

Could this lead to a heap buffer overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717125750.6263=
9-1-robert.mader@collabora.com?part=3D1
