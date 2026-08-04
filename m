Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D2CC55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB2210E9FD;
	Tue,  4 Aug 2026 12:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DiuuEZI2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A817610EA00
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:21:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C9A460A6C;
 Tue,  4 Aug 2026 12:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838941F000E9;
 Tue,  4 Aug 2026 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785846088;
 bh=o55X5EFKDdd4NmpGuUIhEgn6r1Pm62pKmqmPFQ0Ddcc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DiuuEZI2RRusBtL5jmfkXQFLnbUUrLU0bLUQyArSzaN0mkHHiy9OrjIe/uMVn8qte
 G8wN1I4kOJfD6tRhsIusXlMUL+9OulBHlOsJNVxvP5du1rcQYpZTZrO6RdTFJa9Uc4
 xvLS4tjGAtC4QTizAb2cyrhdqlWigw4Nkr1Xh7a5dHCjNxuW1wD/LBJMnUafrU74XT
 eri6NgYlIDeNEYTjlhC+wVZhOxl/xPrLG/qZgO4Pt9Y3+yOQQSYVolT7gwb9JDHStl
 2lexK1CZU5jgJ8e9buLvtTVZqwk5p/xO5weBTz6ifb4UFhvUHPE5xsxTr6a9hrXh7z
 ShuMnXGMvqpmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable
 PTEs when mkwrite is in use
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20260804120529.1730187-4-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:21:28 +0000
Message-Id: <20260804122128.838941F000E9@smtp.kernel.org>
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
- [High] Missing dirty page tracking in vmw_bo_vm_fault() when prefaulting =
fails, leading to silent data loss.

Pre-existing issues:
- [High] Inverted error handling logic in ttm_bo_vm_fault_reserved() hides =
primary fault errors and propagates prefault errors.
--

--- Patch [3]: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable=
 PTEs when mkwrite is in use ---
commit 2f0ecb57a3fc3ac93f0458269dd5ea847c608a25
Author: Paolo Bonzini <pbonzini@redhat.com>
Subject: drm/ttm, drm/vmwgfx: directly create writable PTEs when mkwrite is=
 in use

This patch modifies TTM BO fault handling to explicitly request writable
PTEs for the primary page when mkwrite is in use. It also updates vmwgfx
to manually record write faults since the .pfn_mkwrite() callback is no
longer invoked for the primary page.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo=
_vm.c
> index a80510489c456..3ebde936ce608 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c

[ ... ]

> @@ -242,6 +243,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *=
vmf,
>  	 * Speculatively prefault a number of pages. Only error on
>  	 * first page.
>  	 */
> +	mkwrite =3D !!(vmf->flags & FAULT_FLAG_WRITE);
>  	for (i =3D 0; i < num_prefault; ++i) {
>  		if (bo->resource->bus.is_iomem) {
>  			pfn =3D ttm_bo_io_mem_pfn(bo, page_offset);
> @@ -263,9 +265,10 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault =
*vmf,
>  		 * at arbitrary times while the data is mmap'ed.
>  		 * See vmf_insert_pfn_prot() for a discussion.
>  		 */
> -		ret =3D vmf_insert_pfn_prot(vma, address, pfn, prot);
> +		ret =3D vmf_insert_pfn_prot_mkwrite(vma, address, pfn, prot, mkwrite);
> =20
> -		/* Never error on prefaulted PTEs */
> +		/* Never error on prefaulted PTEs and never map them writable */
> +		mkwrite =3D false;
>  		if (unlikely((ret & VM_FAULT_ERROR))) {
>  			if (i =3D=3D 0)
>  				return VM_FAULT_NOPAGE;
>  			else
>  				break;
>  		}

[Severity: High]
This is a pre-existing issue, but does this error handling logic for
ttm_bo_vm_fault_reserved() behave backwards?

If vmf_insert_pfn_prot_mkwrite() fails for the primary page (i =3D=3D 0),
returning VM_FAULT_NOPAGE hides the error from the fault handler,
potentially causing an infinite page fault loop.

Conversely, if a speculative prefault (i > 0) fails, the loop breaks
and the error is propagated to the fault handler, which might cause
a spurious process crash even though the primary fault succeeded.


> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm=
/vmwgfx/vmwgfx_page_dirty.c
> index 45561bc1c9eff..3099558c0762f 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c

[ ... ]

> @@ -484,6 +487,9 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
>  		prot =3D vm_get_page_prot(vma->vm_flags);
> =20
>  	ret =3D ttm_bo_vm_fault_reserved(vmf, prot, num_prefault);
> +	if (ret =3D=3D VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
> +		WARN_ON_ONCE(vmw_bo_dirty_mkwrite(vmf, bo));
> +
>  	if (ret =3D=3D VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT=
))
>  		return ret;
> =20

[Severity: High]
If a speculative prefault fails inside ttm_bo_vm_fault_reserved(), will
this skip tracking the dirty page and lead to silent data loss?

Because the primary page is successfully mapped writable before the prefault
loop continues:

ttm_bo_vm_fault_reserved()
    ret =3D vmf_insert_pfn_prot_mkwrite(vma, address, pfn, prot, mkwrite);
    // ... prefault loops to next page and fails ...
    break; // returns the error

The error is returned to vmw_bo_vm_fault(), meaning ret is not
VM_FAULT_NOPAGE.

This check is skipped, leaving the primary page mapped writable without the
driver marking it dirty.

If the process survives the fault (e.g., by handling SIGBUS), could it
then modify data without the driver tracking it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804120529.1730=
187-1-pbonzini@redhat.com?part=3D3
