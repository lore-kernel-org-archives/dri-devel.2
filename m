Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94526C61DF0
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B581210E252;
	Mon, 31 Aug 2026 06:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MtacoLEK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16D9A10E252
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 06:17:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61B9160120;
 Mon, 31 Aug 2026 06:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE60E1F000E9;
 Mon, 31 Aug 2026 06:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788157022;
 bh=z9g8KUc/yy7CHWWOxDpWBuLM/gULDOqbKKjmY0jl1JM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MtacoLEKYIV96pVTCCreTJCf0ABJsJ/dVBRlN03PEzJqTBXgKWwReSznoUT44FIDP
 MsfVjh0BXs5/aEe32J09LCzL4n438JTMBfDOgOovG9z8kORDhHYxiTyJshtbtYqYN3
 ZcmAOy/QPHlwYldDQnhcgpIBf9yER3Br2YnqIm9pNz+a/fMRAlY6r4ZKti+libh1D6
 2apKd0KY0ygD7XMRTBcd2lgvSggXsbLRhqPOKwbRqgNM3wQ5tGnRkZlOq92DWWvzxr
 ++9fVDmrA72e/kHg1pKloY5Hv2vVaSLePtjNsVXPGkezq2XLIfXR7b7UF496KmC0do
 2ngQRLY+M9zsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] udmabuf: Do not warn when pages/folios array
 allocation fails
To: "Vivek Kasireddy" <vivek.kasireddy@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831060210.1713177-2-vivek.kasireddy@intel.com>
References: <20260831060210.1713177-1-vivek.kasireddy@intel.com>
 <20260831060210.1713177-2-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:17:00 +0000
Message-Id: <20260831061701.DE60E1F000E9@smtp.kernel.org>
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
- [Critical] Integer Overflow / Heap Buffer Overflow on 32-bit systems
- [Medium] Incomplete Fix / Missing __GFP_NOWARN for folios array
--

commit 8833c30cdb25571807590bf3d21df9402d38121d
Author: Vivek Kasireddy <vivek.kasireddy@intel.com>

udmabuf: Do not warn when pages/folios array allocation fails

This commit adds the __GFP_NOWARN flag to the allocation of ubuf->pages
and ubuf->pinned_folios in init_udmabuf(). The goal is to prevent warning
traces when creating extremely large udmabuf arrays.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 4a9ab5822ffc3..7c4339130eff7 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -190,11 +190,13 @@ static void unpin_all_folios(struct udmabuf *ubuf)
> =20
>  static __always_inline int init_udmabuf(struct udmabuf *ubuf, pgoff_t pg=
cnt)
>  {

[Severity: Critical]
This is a pre-existing issue, but can pgcnt overflow on 32-bit systems?

In udmabuf_create(), pgcnt and subpgcnt are pgoff_t (32-bit on 32-bit syste=
ms).
When accumulating the total size from the user-provided list:

udmabuf_create() {
        for (i =3D 0; i < head->count; i++) {
                pgoff_t subpgcnt =3D list[i].size >> PAGE_SHIFT;
                pgcnt +=3D subpgcnt;
                if (pgcnt > pglimit)
                        goto err_noinit;
        }
        ...
        ret =3D init_udmabuf(ubuf, pgcnt);
}

If a user passes many elements, pgcnt +=3D subpgcnt can wrap around to a sm=
all
number (e.g., 1), bypassing the pglimit check. This causes init_udmabuf() to
allocate very small arrays for ubuf->pages and ubuf->pinned_folios.

Later, in udmabuf_pin_folios(), a single list item's size is processed:

udmabuf_pin_folios() {
        pgcnt =3D size >> PAGE_SHIFT;
        end =3D start + (pgcnt << PAGE_SHIFT) - 1;
        ...
        for (; subpgoff < fsize; subpgoff +=3D PAGE_SIZE) {
                ubuf->pages[upgcnt] =3D folio_page(folios[cur_folio], ...);
                ++upgcnt;
        }
}

The truncated end value still results in pinning thousands of pages, which =
the
loop blindly writes into the undersized ubuf->pages array, causing a heap
buffer overflow.

Could we add an overflow check when accumulating pgcnt in udmabuf_create()?

> -	ubuf->pages =3D kvmalloc_objs(*ubuf->pages, pgcnt);
> +	gfp_t gfp =3D GFP_KERNEL | __GFP_NOWARN;
> +
> +	ubuf->pages =3D kvmalloc_objs(*ubuf->pages, pgcnt, gfp);

[Severity: Medium]
This isn't a bug introduced by this patch, but since we are adding
__GFP_NOWARN to suppress warnings on massive user-requested allocations,
should we also add it to the folios array allocation in udmabuf_create()?

udmabuf_create() {
        ...
        folios =3D kvmalloc_array(max_nr_folios, sizeof(*folios), GFP_KERNE=
L);
        ...
}

A privileged user (with CAP_IPC_LOCK) can still request an extremely large
size, which could cause this folios allocation to fail and trigger the same
warning this patch intends to fix.

>  	if (!ubuf->pages)
>  		return -ENOMEM;
> =20
> -	ubuf->pinned_folios =3D kvmalloc_objs(*ubuf->pinned_folios, pgcnt);
> +	ubuf->pinned_folios =3D kvmalloc_objs(*ubuf->pinned_folios, pgcnt, gfp);
>  	if (!ubuf->pinned_folios)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831060210.1713=
177-1-vivek.kasireddy@intel.com?part=3D1
