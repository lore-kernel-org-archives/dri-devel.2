Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B87C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A684110E6EB;
	Mon,  3 Aug 2026 14:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BouBC2ip";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C926A10E6FE
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:59:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D6DDD60AA3;
 Mon,  3 Aug 2026 14:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C931F000E9;
 Mon,  3 Aug 2026 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785769156;
 bh=cliP6khiAYIqGakNZ9MKPy5IZbcuq2DG1AkEyuHOhvQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BouBC2ipI1P09RnGlfKyz/OSHauKRN+X9BXARwRWK8kjJhNajE73wih4jRkmEXEeg
 0fB91zVJEokMZSNi8PxTNvL/W3gQYmDXoUPtWLCTs00vhQY2qsYxP4e/x899MCB/zE
 1+Fmcre3P7fwiSurO317m2e7z500Z0ovG95cw6slkWGibQISZ11OHeVwGBSsQ9NJsz
 3RweSvvsICjc8TVqi4EMMrszzwsECMKSnwTAJSokbca7pH/RttQt8yt99ZrRDA+sA+
 7F8sCGZ4Xd17c4K+jOKY+/TTV9Ru+uihN+w3CcKQPptzY5FhWK/WFs3kL6jgSnk6AA
 K0Pvp0phWCUAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] udmabuf: vastly increase the size limit per dmabuf
To: "Xaver Hugl" <xaver.hugl@kde.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260803144120.11524-1-xaver.hugl@kde.org>
References: <20260803144120.11524-1-xaver.hugl@kde.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:59:15 +0000
Message-Id: <20260803145916.62C931F000E9@smtp.kernel.org>
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
- [High] Unprivileged users can exhaust system memory by pinning an unbound=
ed amount of pages, bypassing RLIMIT_MEMLOCK limits.
- [High] On 32-bit systems, an integer overflow in `udmabuf_create` during =
the accumulation of `pgcnt` allows a local attacker to bypass the `size_lim=
it_mb` check and cause a kernel heap buffer overflow.
--

--- Patch [1]: [PATCH] udmabuf: vastly increase the size limit per dmabuf -=
--
commit 35feed24a80e2f326fb9ba08e55d7ef8e97bae25
Author: Xaver Hugl <xaver.hugl@kde.org>
udmabuf: vastly increase the size limit per dmabuf

This commit increases the default size limit per dmabuf from 64MB to 1024MB.
This accommodates larger buffers used by high-resolution displays when scal=
ing
is applied.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index bced421c0d658..be2bcda0fb0f3 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -20,9 +20,9 @@ static int list_limit =3D 1024;
>  module_param(list_limit, int, 0644);
>  MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default =
is 1024.");
> =20
> -static int size_limit_mb =3D 64;
> +static int size_limit_mb =3D 1024;

[Severity: High]
This is a pre-existing issue, but does increasing the default size limit to
1024MB make it easier for unprivileged users to exhaust system memory?

In drivers/dma-buf/udmabuf.c:udmabuf_create(), memory is pinned using
memfd_pin_folios() but it doesn't appear to call account_locked_vm() or che=
ck
against RLIMIT_MEMLOCK:

drivers/dma-buf/udmabuf.c:udmabuf_create() {
    ...
		ret =3D udmabuf_pin_folios(ubuf, memfd, list[i].offset,
					 list[i].size, folios);
    ...
}

Without a hard limit on the total number of dmabufs a user can create, an
unprivileged user with access to /dev/udmabuf might be able to repeatedly
allocate dmabufs up to the size_limit_mb per file descriptor and pin system
memory until the tmpfs limit or physical RAM is completely exhausted.

[Severity: High]
This isn't a bug introduced by this patch, but does the larger size limit m=
ake
it easier to hit an integer overflow on 32-bit systems?

In drivers/dma-buf/udmabuf.c:udmabuf_create(), pgcnt is accumulated using a
32-bit pgoff_t on 32-bit systems:

drivers/dma-buf/udmabuf.c:udmabuf_create() {
    ...
		subpgcnt =3D list[i].size >> PAGE_SHIFT;
		pgcnt +=3D subpgcnt;
		if (pgcnt > pglimit)
			goto err_noinit;
    ...
}

By supplying up to list_limit (default 1024) items, an attacker could spread
2^32 pages across the items such that pgcnt wraps around to a small value,
bypassing the pglimit check.

init_udmabuf() then allocates an undersized ubuf->pages array. Later, when
udmabuf_pin_folios() successfully pins the large items, it iterates over the
actual requested size and can write out of bounds into the small heap array:

drivers/dma-buf/udmabuf.c:udmabuf_pin_folios() {
    ...
		for (; subpgoff < fsize; subpgoff +=3D PAGE_SIZE) {
			ubuf->pages[upgcnt] =3D folio_page(folios[cur_folio],
						subpgoff >> PAGE_SHIFT);
			++upgcnt;
		}
    ...
}

Triggering this out-of-bounds write requires memfd_pin_folios() to
successfully pin the largest item (minimum ~16.7 GB spread across 1024 item=
s).
Thus, it relies on the 32-bit system having enough physical RAM available
(e.g. via PAE) to not fail safely with -ENOMEM before reaching the vulnerab=
le
write.

>  module_param(size_limit_mb, int, 0644);
> -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Def=
ault is 64.");
> +MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Def=
ault is 1024.");
> =20
>  struct udmabuf {
>  	pgoff_t pagecount;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803144120.1152=
4-1-xaver.hugl@kde.org?part=3D1
