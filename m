Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880F606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBCGrJWh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C15010F7C4;
	Tue,  3 Nov 2026 19:29:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3256B10F7C4
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 19:29:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5DC7C601EF;
 Tue,  3 Nov 2026 19:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8F81F000C1;
 Tue,  3 Nov 2026 19:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793734169;
 bh=j721FUOm5F7lMlYD1BpVBUryO316K1Y5Ky3nQ/AgpFw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=PBCGrJWh0vy2VdUnfpgvm+RUKwQ1La3u1UVod1atoUda1lVxgpD7LfwlqU3E3t9c9
 FNKXHppN9/etYQa/1Uef9IeNwGIngOM8aUPrlSOwDz9JaLa6aI8taJbinNmLPRLfd8
 jsyZCBuckqiFhP6QmnyQPqhvA3IpRLg99uAn8NTmb7ZZCAHDcuqhHJqksTaY7KMY0b
 Rwng0bqhIKwuO5p6zEXk1BRgob67RdiStS0GZgaJpeBnWKBg/psVQfiu6CHlkriukI
 cUm5YwnSZsOBcWQS63V1VCYCgAWxmfenRO23/uFpxj8l/iFW+mwRjGKC9Daubzx05u
 euNUXeVyjUjIw==
Message-ID: <sashiko-outbox-195917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Remap BO pages instead of using
 vm_insert_pages
To: "Lizhi Hou" <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261103190821.2019203-1-lizhi.hou@amd.com>
References: <20261103190821.2019203-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:29:28 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] accel/amdxdna: permanent -EFAULT in aie2_populate_range() on VM_=
PFNMAP BOs
--

commit 9b00bf66bf06146c9db533ea2617347eed41d1ba
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Remap BO pages instead of using vm_insert_pages

This commit keeps the VM_PFNMAP flag on shmem and dma-buf BO mappings and
populates their page tables upfront with remap_pfn_range() instead of
switching to VM_MIXEDMAP and calling vm_insert_pages(). It also removes the
custom mixedmap VM operations in favor of drm_gem_shmem_vm_ops and skips
marking VM_PFNMAP imported mappings invalid during mmap.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index f14484bc31ec0..d78dbce3c2e89 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
[ ... ]
> @@ -502,7 +542,8 @@ static int amdxdna_insert_pages(struct amdxdna_gem_ob=
j *abo,
>  			return ret;
>  		}
> =20
> -		amdxdna_mark_mapp_invalid(abo, vma);
> +		if (!(vma->vm_flags & VM_PFNMAP))
> +			amdxdna_mark_mapp_invalid(abo, vma);
> =20
>  		/* Drop the reference drm_gem_mmap_obj() acquired.*/
>  		drm_gem_object_put(to_gobj(abo));
> @@ -515,10 +556,9 @@ static int amdxdna_insert_pages(struct amdxdna_gem_o=
bj *abo,
>  		return ret;
>  	}
> =20
> -	vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
> -	ret =3D vm_insert_pages(vma, vma->vm_start, abo->base.pages, &num_pages=
);
> +	ret =3D amdxdna_remap_pages(abo, vma);

[Severity: Medium]
Can keeping VM_PFNMAP on BO mappings while still registering an HMM interval
notifier cause aie2_populate_range() to fail permanently with -EFAULT?

When PASID is enabled (abo->mem.dma_addr =3D=3D AMDXDNA_INVALID_ADDR),
amdxdna_gem_obj_mmap() calls amdxdna_hmm_register(), which registers
amdxdna_hmm_ops with default_flags =3D HMM_PFN_REQ_FAULT on the VMA range.
With this change, both native shmem BOs and imported VM_PFNMAP dma-bufs keep
VM_PFNMAP (and remap_pfn_range() sets VM_IO | VM_PFNMAP).

While amdxdna_insert_pages() avoids calling amdxdna_mark_mapp_invalid() on
VM_PFNMAP VMAs during initial mmap, amdxdna_hmm_invalidate() still marks the
mapping invalid unconditionally whenever an MMU notifier event fires:

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_hmm_invalidate() {
	...
	down_write(&xdna->notifier_lock);
	abo->mem.map_invalid =3D true;
	mapp->invalid =3D true;
	mmu_interval_set_seq(&mapp->notifier, cur_seq);
	up_write(&xdna->notifier_lock);

	ret =3D xdna->dev_info->ops->hmm_invalidate(abo, range->event);

	if (range->event =3D=3D MMU_NOTIFY_UNMAP) {
		down_write(&xdna->notifier_lock);
		mapp->unmapped =3D true;
		up_write(&xdna->notifier_lock);
	}
	...
}

If any non-unmap MMU notifier event occurs on the range (for example, writi=
ng
4 to /proc/<pid>/clear_refs, pagemap_scan, or mprotect()), or if a command
submission runs concurrently while MMU_NOTIFY_UNMAP is in progress before
mapp->unmapped is set, aie2_cmd_submit() sees abo->mem.map_invalid and calls
aie2_populate_range() -> hmm_range_fault_unlocked_timeout().

In mm/hmm.c, hmm_vma_walk_test() rejects VM_IO | VM_PFNMAP VMAs when fault =
is
requested:

mm/hmm.c:hmm_vma_walk_test() {
	...
	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)) &&
	    vma->vm_flags & VM_READ)
		return 0;
	...
	if (hmm_range_need_fault(hmm_vma_walk,
				 range->hmm_pfns +
					 ((start - range->start) >> PAGE_SHIFT),
				 (end - start) >> PAGE_SHIFT, 0))
		return -EFAULT;
	...
}

Because aie2_populate_range() aborts on error without clearing mapp->invalid
or abo->mem.map_invalid, wouldn't all subsequent command submissions using
this BO fail permanently with -EFAULT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103190821.2019=
203-1-lizhi.hou@amd.com?part=3D1
