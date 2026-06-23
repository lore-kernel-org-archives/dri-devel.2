Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE37CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E712310EC50;
	Tue, 23 Jun 2026 18:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L6/TVH63";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA8C10EC50
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 18:52:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A6C7D60018;
 Tue, 23 Jun 2026 18:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FE41F000E9;
 Tue, 23 Jun 2026 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782240775;
 bh=ZeWY3eadOG5wuTzaUsiSW6+lXgxolxwdFtEVovGFo3M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L6/TVH63M457VoJ9AcTtmUOCrC3QNFcJzN1I+qMI1l8KxL0+uj2+1w2DcPq7dImPJ
 Z7M5YfIuUHZ/RrM0uUCpi6na78NEMejwycs5Tv7ntzj1ap1jDMOqjmrupMQDxQTeJl
 7QqfHJx/mcQzKsFTlKiYTEuYK721R6RvPH1LCVhR7QWBfte/PzghH/DnRmdqYdpE1F
 veaivtbGzWZg0yejiOAGnzY11zAqT2za1V3AAst3A1M8alg/8XFuqwsUmV1pMOySyI
 K/VvEp6j7kkkOn8CTeWKV7fDbabr6OVBCsvj7YjXIUauDBF4HiwVivNxitvwISmgll
 J2Ee4S505gURA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panthor: Check VMA boundaries for PMD mappings
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623181942.1536598-1-lk@c--e.de>
References: <20260623181942.1536598-1-lk@c--e.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 18:52:54 +0000
Message-Id: <20260623185255.38FE41F000E9@smtp.kernel.org>
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
- [High] VMA page offset calculation ignores VMA splits, causing the wrong =
GEM pages to be mapped
--

commit 0ed0c5c04749e14eb0003e5dbc760b6b5b001ce2
Author: Christian A. Ehrhardt <lk@c--e.de>

drm/panthor: Check VMA boundaries for PMD mappings

In the ->huge_fault handler do not install a PMD huge page mapping if the
huge page exceeds the boundaries of the VMA.

Link: https://lore.kernel.org/lkml/20260622215718.1532689-1-lk@c--e.de/
Link: https://sashiko.dev/#/patchset/20260622215718.1532689-1-lk%40c--e.de

> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/pant=
hor/panthor_gem.c
> index a1e2eb1ca7bbe..54535bae2b0cf 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -802,9 +802,13 @@ static vm_fault_t insert_page(struct vm_fault *vmf, =
unsigned int order, struct p
>  	} else if (order =3D=3D PMD_ORDER) {
>  		unsigned long pfn =3D page_to_pfn(page);
>  		unsigned long paddr =3D pfn << PAGE_SHIFT;
> +		struct vm_area_struct *vma =3D vmf->vma;
> +		unsigned long start =3D ALIGN_DOWN(vmf->address, PMD_SIZE);
> +		unsigned long end =3D start + PMD_SIZE;
> +		bool in_range =3D vma->vm_start <=3D start && end <=3D vma->vm_end;
>  		bool aligned =3D (vmf->address & ~PMD_MASK) =3D=3D (paddr & ~PMD_MASK);
> =20
> -		if (aligned &&
> +		if (aligned && in_range &&
>  		    folio_test_pmd_mappable(page_folio(page))) {
>  			pfn &=3D PMD_MASK >> PAGE_SHIFT;
>  			return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);

[Severity: High]
This isn't a bug introduced by this patch, but looking further down in
panthor_gem_any_fault():

drivers/gpu/drm/panthor/panthor_gem.c:panthor_gem_any_fault() {
    ...
	/* Offset to faulty address in the VMA. */
	page_offset =3D vmf->pgoff - vma->vm_pgoff;
    ...
}

Does this VMA page offset calculation ignore VMA splits?

If a userspace process maps a Panthor GEM object and then unmaps the first
page using munmap(), the core memory management subsystem splits the VMA and
increments vma->vm_pgoff by 1.

When a page fault subsequently occurs at the new VMA start address, both
vmf->pgoff and vma->vm_pgoff have advanced by 1, which means page_offset
incorrectly evaluates to 0 instead of 1.

Could this logic error cause the fault handler to map incorrect physical
pages (bo->backing.pages[0] instead of bo->backing.pages[1]) from the GEM
object into userspace memory?

The calculation should probably subtract the GEM object's base fake offset
using drm_vma_node_start(&bo->base.vma_node).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623181942.1536=
598-1-lk@c--e.de?part=3D1
