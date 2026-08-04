Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CC2C55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121A110E9FE;
	Tue,  4 Aug 2026 12:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k1iJsOae";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D578510E9FE
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:20:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 038ED60A7E;
 Tue,  4 Aug 2026 12:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3601F00A3A;
 Tue,  4 Aug 2026 12:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785846042;
 bh=wx+A0RuCo2BmDjRNS97tN25IAquoCflYRodI0PATqCg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k1iJsOae1EQ/FKUNVdk9cjORTAXoUOu4+nneRd4yG8hW4r4ybMoDuX/sY6NhMI23s
 FL7gjWi4DZqkq27RFEEd3ZbQJtZt7JlMPSEMfmZqoc3gi25HYtdNthkejFN24RgpJf
 aNsibqKBkkaU3oaib7ReNoz34XHKUOiiMAZeGkiNyieFh53KiDUe3qtSdsmrNJz8jT
 bYlD/1wCezfZGW4OULXhlmBXuRHuhGIlk+a0iVq4HkiIuCv45vaCIKt4DLDcTN/5er
 yJVvlYBUwCVkthxDZYFn2byXIBBg7UxPQE2V13qsUN5/cBf2w+JZ5Hs0CELeT0SAj8
 H+JVgTH/O5x3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] mm: export vmf_insert_pfn_prot_mkwrite(), change
 variants to inline
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260804120529.1730187-2-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:20:41 +0000
Message-Id: <20260804122042.4F3601F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] The global shared zero page can be mapped as writable by inser=
t_pfn, leading to memory corruption.
--

--- Patch [1]: [PATCH v2 1/6] mm: export vmf_insert_pfn_prot_mkwrite(), cha=
nge variants to inline ---
commit 010e09346cc93d215af7040a0cfe7fd891a1bd7d
Author: Paolo Bonzini <pbonzini@redhat.com>

mm: export vmf_insert_pfn_prot_mkwrite(), change variants to inline

This commit introduces vmf_insert_pfn_prot_mkwrite() and
vmf_insert_pfn_mkwrite() to allow drivers to install writable PTEs during
faults when a mapping is under write notification. It refactors the existing
vmf_insert_pfn() family of functions into inline wrappers around this new,
more flexible variant.

> diff --git a/mm/memory.c b/mm/memory.c
> index 6637c5b13c9ba..786b114d9921a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
[ ... ]
> -vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long=
 addr,
> -			unsigned long pfn, pgprot_t pgprot)
> +vm_fault_t vmf_insert_pfn_prot_mkwrite(struct vm_area_struct *vma,
> +			unsigned long addr, unsigned long pfn, pgprot_t pgprot,
> +			bool mkwrite)
>  {
[ ... ]
>  	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
> =20
> -	return insert_pfn(vma, addr, pfn, pgprot, false);
> -}
> -EXPORT_SYMBOL(vmf_insert_pfn_prot);
> -
> -/**
> - * vmf_insert_pfn - insert single pfn into user vma
[ ... ]
> +	return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
>  }
> -EXPORT_SYMBOL(vmf_insert_pfn);
> +EXPORT_SYMBOL(vmf_insert_pfn_prot_mkwrite);

[Severity: Critical]
This is a pre-existing issue, but by allowing mkwrite to be passed directly=
=20
through to insert_pfn(), can this result in the global shared zero page bei=
ng
mapped writable?

If a driver maps the zero page via vmf_insert_pfn_mkwrite(..., true) into a
shared writable VM_PFNMAP mapping, insert_pfn() in mm/memory.c handles the
new entry like this:

	/* Ok, finally just insert the thing.. */
	entry =3D pte_mkspecial(pfn_pte(pfn, prot));

	if (mkwrite) {
		entry =3D pte_mkyoung(entry);
		entry =3D maybe_mkwrite(pte_mkdirty(entry), vma);
	}

Because there is no check verifying if the passed PFN is the zero page,
maybe_mkwrite() will explicitly make the PTE writable, bypassing the zero
page protections ordinarily afforded by vm_mixed_ok().=20

If the global zero page becomes writable, unprivileged userspace could write
to it, which would cause memory corruption across the system for any process
reading uninitialized memory. Should we add a defense in insert_pfn() to
explicitly reject or write-protect the zero page when mkwrite is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804120529.1730=
187-1-pbonzini@redhat.com?part=3D1
