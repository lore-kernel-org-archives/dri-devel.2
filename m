Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002D0CD98F0
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5583C10ED4A;
	Thu, 18 Jun 2026 08:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jAKZlrZg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FDA410ED4A
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 08:22:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7CB6601F8;
 Thu, 18 Jun 2026 08:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0631F000E9;
 Thu, 18 Jun 2026 08:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781770965;
 bh=l8kqou+oa4+rUPVzvvhmLjeT1GbJ6+z8nS8qJuTvCdc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jAKZlrZgh9O/ZFuM8EFTAOuVGkIU1zSCAt/VQ83g+l3Gfmrm47dqe8ZY/BpSrVcH3
 3Ng858/q/655rrfEVpbmww7hU2nQ/OJSZGNFq2bK+HK7vmVJh/U7VU7o7VVZuu7CBZ
 klEuNRCAOFlKQg4XghoXztoDAVpuu6vdc3QFtBUJP9A3uUofNGcwHV0XtY0YmVh87B
 mHxoAWHrkt/eCxOY3kH9UnfCbKYbEu+B+tas85TvzL0oS5j8qTyzg8z+87hvWYT5p0
 fupglnVERd0JiZKQ508pLQhE5AWEw692TcRdajPprr9lPvOiVJ1NJV5SN/he+vbAZl
 VPIDpk5x6EDqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] drm/gpusvm: move struct drm_gpusvm_pages out of
 struct drm_gpusvm_range
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618080902.1527255-5-honglei1.huang@amd.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
 <20260618080902.1527255-5-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:22:45 +0000
Message-Id: <20260618082245.7A0631F000E9@smtp.kernel.org>
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
- [High] Uninitialized memory usage risk due to API and documentation misma=
tch in `drm_gpusvm_init_pages()`.
--

commit 197258e5db713e6ce07b4d77f6fdaf1b1e01175a
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: move struct drm_gpusvm_pages out of struct drm_gpusvm_range

Since the pages the physical pages and MM VA range has been abstractly
separated. Unbinding a single form of physical page from the MM VA
range, brings flexibility to the drm gpu SVM framework, transfer the
way of management of MM and device physical pages to the driver layer.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 85fbadc9716a4..842bfb37a3677 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c

[ ... ]

> @@ -48,6 +48,47 @@
>   *	event. As mentioned above, ranges are tracked in a notifier's Red-Bla=
ck
>   *	tree.
>   *
> + * - Pages:
> + *	struct drm_gpusvm_pages holds the DMA mapping state for a range of
> + *	CPU virtual addresses: the DMA mapped device addresses,

[ ... ]

> + *	.. code-block:: c
> + *
> + *		struct driver_range {
> + *			struct drm_gpusvm_range base;
> + *			unsigned int num_pages;	// 1: inline_pages, >1: pages[]
> + *			union {
> + *				struct drm_gpusvm_pages inline_pages;
> + *				struct drm_gpusvm_pages *pages;
> + *			};
> + *		};
> + *
> + *	In the N:1 case the driver allocates the pages array (e.g. with
> + *	kmalloc_array(num_pages, ...)), initialises each entry with
> + *	drm_gpusvm_init_pages(), and frees each entry with
        ^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this documentation suggest an unsafe allocation pattern?

If a driver follows this example and allocates an array of struct
drm_gpusvm_pages using kmalloc_array(), the memory will be uninitialized.
When drm_gpusvm_init_pages() is called, it only sets drm and notifier_seq,
leaving dma_addr, flags, and dpagemap uninitialized.

Later, when drm_gpusvm_get_pages() checks drm_gpusvm_pages_valid_unlocked():

static bool drm_gpusvm_pages_valid_unlocked(...)
{
    if (!svm_pages->dma_addr)
        return false;
   =20
    ...
    if (!pages_valid)
        __drm_gpusvm_free_pages(gpusvm, svm_pages);
}

The check for !svm_pages->dma_addr will read the uninitialized heap data and
likely pass. If flags evaluates to false, __drm_gpusvm_free_pages() will
execute kvfree(svm_pages->dma_addr) on the garbage pointer, which could cau=
se
a panic.

Should the documentation specify kcalloc() instead, or should
drm_gpusvm_init_pages() explicitly zero the rest of the fields?

> + *	drm_gpusvm_free_pages() plus the array itself, from its range free
> + *	callback. Each drm_gpusvm_pages is mapped independently by their own
> + *	drm_device.
> + *	Each drm_gpusvm_pages must be initialised with drm_gpusvm_init_pages()
> + *	and released with drm_gpusvm_free_pages() in driver range free callba=
ck.
> + *

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618080902.1527=
255-1-honglei1.huang@amd.com?part=3D4
