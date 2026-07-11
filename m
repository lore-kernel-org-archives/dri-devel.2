Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772B7C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 14:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9468310E303;
	Sat, 11 Jul 2026 14:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iKHFj8d0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E9F10E303
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 14:58:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED7C440A8C;
 Sat, 11 Jul 2026 14:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EE31F000E9;
 Sat, 11 Jul 2026 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783781924;
 bh=WPi1L7xQOWiwatZ/hC9K9mCYevpguHfCwz8Wk1/V/NA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iKHFj8d0wU0N6fY94nxRJA1eqk7n4mlKUU+MQRug7CYTsU2X88L3dKoE4u9KUiZuc
 sWvMDchX66NilRh4/mzHHQ2oG2JPueoMISBAx8wYFKRotzKzubsB8phUvvuxRZEO7c
 qxvpt+mDROhbFvwL9CnRIc6CcioRAWarpH1sphv9aQW2oZ3gVc1sUMyuTnN2hfi8ht
 WZ/Pt/zQeRGxX6epgDd5Oza4xWaVfxNVzn2YOxTafHC1L79LDN5hLTIrdgYQQ+W/pe
 /Ev0v1DS5CfvjPCxjXj2PE8wdb+AF/6ts806bCAi5UhgfJBpVFMgnVk6HuZzcaFSzP
 broOvKM/n5IfQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] dma-buf/udmabuf: Introduce
 CONFIG_UDMABUF_SIZE_LIMIT_MBYTES
To: "Robert Mader" <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711144814.8205-1-robert.mader@collabora.com>
References: <20260711144814.8205-1-robert.mader@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 14:58:44 +0000
Message-Id: <20260711145844.A5EE31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] CONFIG_UDMABUF_SIZE_LIMIT_MBYTES lacks a dependency on CONFIG_UDMAB=
UF.
- [Low] Missing range constraint on UDMABUF_SIZE_LIMIT_MBYTES allows negati=
ve values, bypassing size validation.

Pre-existing issues:
- [High] Concurrent calls to DMA_BUF_IOCTL_SYNC trigger a race condition in=
 begin_cpu_udmabuf, leading to a memory leak.
--

--- Patch [1]: [RFC PATCH 1/2] dma-buf/udmabuf: Introduce CONFIG_UDMABUF_SI=
ZE_LIMIT_MBYTES ---
commit 258354f822e15700d93d45826a3e51b308dd35b8
Author: Robert Mader <robert.mader@collabora.com>

dma-buf/udmabuf: Introduce CONFIG_UDMABUF_SIZE_LIMIT_MBYTES

This patch introduces a new Kconfig option, CONFIG_UDMABUF_SIZE_LIMIT_MBYTE=
S,
to allow distributions to configure the maximum size limit for udmabufs at=
=20
compile time. The limit defaults to 64MB and was previously only configurab=
le=20
via the kernel command line.

> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index 7efc0f0d07126..35f0779cdc801 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -40,6 +40,12 @@ config UDMABUF
>  	  A driver to let userspace turn memfd regions into dma-bufs.
>  	  Qemu can use this to create host dmabufs for guest framebuffers.
> =20
> +config UDMABUF_SIZE_LIMIT_MBYTES
> +	int "Size limit in Mega Bytes"
> +	default 64

[Severity: Low]
Should this config have a 'depends on UDMABUF' directive?

Without it, users might be prompted to configure the size limit even
when the UDMABUF driver itself is disabled, polluting the global config.

[Severity: Low]
Could a user configure a negative value here and bypass the size limits?

If this is set to a negative value, it appears it will wrap around to a=20
massive value when cast to u64 in udmabuf_create():

drivers/dma-buf/udmabuf.c:udmabuf_create() {
...
	pglimit =3D ((u64)size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
...
}

Would it be safer to add a range constraint to the Kconfig definition?

> +	help
> +	  Maximum size of a udmabuf, in megabytes. Default is 64.
> +
>  config DMABUF_DEBUG
>  	bool "DMA-BUF debug checks"
>  	depends on DMA_SHARED_BUFFER

[ ... ]

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index bced421c0d658..a831533263621 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -20,7 +20,11 @@ static int list_limit =3D 1024;
>  module_param(list_limit, int, 0644);
>  MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default =
is 1024.");
> =20
> +#ifdef CONFIG_UDMABUF_SIZE_LIMIT_MBYTES
> +static int size_limit_mb =3D CONFIG_UDMABUF_SIZE_LIMIT_MBYTES;
> +#else
>  static int size_limit_mb =3D 64;
> +#endif
>  module_param(size_limit_mb, int, 0644);
>  MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Def=
ault is 64.");
> =20

[Severity: High]
This is a pre-existing issue, but can concurrent calls to=20
DMA_BUF_IOCTL_SYNC cause a memory leak?

Looking at begin_cpu_udmabuf(), the scatter-gather table pointer is=20
checked and assigned without locks:

drivers/dma-buf/udmabuf.c:begin_cpu_udmabuf() {
...
	if (!ubuf->sg) {
		ubuf->sg =3D get_sg_table(dev, buf, direction);
...
}

If multiple threads invoke the ioctl simultaneously, could they bypass=20
the check, allocate multiple tables, and overwrite ubuf->sg, permanently
leaking the previously allocated tables and mappings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711144814.8205=
-1-robert.mader@collabora.com?part=3D1
