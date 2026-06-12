Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2ADCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 634B710F3D5;
	Fri, 12 Jun 2026 09:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X4cVNeyZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048BA10F3D5
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:42:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D30D743CC5;
 Fri, 12 Jun 2026 09:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7770B1F000E9;
 Fri, 12 Jun 2026 09:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781257337;
 bh=izpShOSwhha1G1pl80b2V5W6pEvEQBrT/+tQe62Kbzc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X4cVNeyZYc0dQ9jL7Vw8PxDOS6v/0D1F27ddPWUtB5bkLmiCGxSvnjPbUCCbWlROb
 vAN05JRqNll8YTb3g6Bm+6bauGbN7+3fr0lHvLH/3uRIEI7GNDThGeHx2yhUDakjX1
 HimcPU1lZn0UyOqjSBI/PSSezU2Pd1Tphb8k9BA7Z3f6iSPmbxx+nxiFYgv1RDxSBi
 PVwL8EXpwshoXCONJ7e9zWLxl8Re2gLYyfXwOVE+T6CscVrROsYwqE4udX8808Z2BI
 Vy4Zo2zYTgkqjmYInWrH8toGYAgAKaD1Pwzm6x6csl7QTDBrWXDw1+wPhIFmg9q5XJ
 oJgv+5Hp9jAuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 18/18] drm/amdgpu: integrate VRAM migration into SVM
 fault and prefetch paths
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-19-ray.huang@amd.com>
References: <20260612090928.29682-19-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:42:17 +0000
Message-Id: <20260612094217.7770B1F000E9@smtp.kernel.org>
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
- [Medium] VRAM prefetch silently skips migrating mixed ranges where only s=
ome pages are in VRAM.

Pre-existing issues:
- [Critical] Stale GPU mappings are left in the page tables if `amdgpu_svm_=
range_update_gpu_range` fails midway, leading to a Use-After-Free.
--

commit a10d03ff5d198ccb21336100307e785425a497b5
Author: Junhua Shen <Junhua.Shen@amd.com>

drm/amdgpu: integrate VRAM migration into SVM fault and prefetch paths

This commit integrates VRAM migration into the SVM page fault and prefetch
paths. It calls amdgpu_svm_range_migrate_to_vram() when VRAM migration is
needed and allows prefetch to actively move pages to VRAM by bypassing the
valid-mapping fast path.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_svm_range.c
> index 6ac785a3b5cba..62b4e0c306682 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c

[ ... ]

> @@ -275,7 +277,8 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *=
svm,
>  		unsigned long start_page, last_page;
>  		bool is_last_seg;
> =20
> -		if (entry->proto !=3D DRM_INTERCONNECT_SYSTEM)
> +		if (entry->proto !=3D DRM_INTERCONNECT_SYSTEM &&
> +		    entry->proto !=3D AMDGPU_INTERCONNECT_VRAM)
>  			return -EOPNOTSUPP;

[Severity: Critical]
This is a pre-existing issue, but does this loop leave stale GPU mappings if
it fails midway?

Looking at amdgpu_svm_range_update_gpu_range(), it loops over DMA addresses
and updates the GPU page tables. If it hits an unsupported protocol or
amdgpu_vm_update_range() fails, it returns an error immediately:

drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c:amdgpu_svm_range_update_gpu_r=
ange() {
	while (mapped_pages < npages) {
		...
		if (entry->proto !=3D DRM_INTERCONNECT_SYSTEM &&
		    entry->proto !=3D AMDGPU_INTERCONNECT_VRAM)
			return -EOPNOTSUPP;
		...
		ret =3D amdgpu_vm_update_range(...);
		if (ret)
			return ret;
	}
}

Because it returns without rolling back the successful segments,
amdgpu_svm_range_update_mapping() will leave range->gpu_mapped set to false.

Later, when the MMU notifier fires to unmap the memory, it will skip zapping
the PTEs because gpu_mapped is false:

drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c:amdgpu_svm_range_notifier_eve=
nt_begin() {
	...
	if (range->pages.flags.unmapped || !svm_range->gpu_mapped)
		return false;
	...
	amdgpu_svm_range_zap_ptes(svm, svm_range, start_page, last_page);
}

Could this result in the GPU continuing to access memory after the CPU has
freed it?

[ ... ]

> @@ -449,12 +454,24 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
>  		if (next_addr <=3D addr)
>  			return -EINVAL;
> =20
> -		if (amdgpu_svm_range_is_valid(svm, range, attrs)) {
> +		/*
> +		 * Prefetch to device memory should still run migration logic even if
> +		 * the current GPU mapping is already valid. This allows prefetch
> +		 * requests to actively move backing pages to VRAM instead of being
> +		 * skipped by the valid-mapping fast path.
> +		 */
> +		if (amdgpu_svm_range_is_valid(svm, range, attrs) &&
> +		    !need_vram_migration) {
>  			addr =3D next_addr;
>  			continue;
>  		}
> =20
> -		/* TODO: add migration */
> +		if (need_vram_migration) {
> +			AMDGPU_SVM_RANGE_DEBUG(range, "MIGRATE PAGES");
> +			ret =3D amdgpu_svm_range_migrate_to_vram(svm, &range->base);
> +			if (ret)
> +				return ret;
> +		}

[Severity: Medium]
Is it possible that this prefetch logic silently skips migrating mixed rang=
es
where only some pages are in VRAM?

The new logic explicitly bypasses the valid mapping check to allow
prefetching, but amdgpu_svm_range_migrate_to_vram() relies on
range_needs_migrate_to_vram():

drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c:range_needs_migrate_t=
o_vram() {
	if (range_in_vram(range))
		return false;
	...
}

And range_in_vram() checks if there are ANY device memory pages:

drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c:range_in_vram() {
	return flags.has_devmem_pages;
}

If a range is mixed (contains both system memory and VRAM pages),
range_in_vram() returns true, causing amdgpu_svm_range_migrate_to_vram()
to return immediately without migrating the remaining system pages. Might
this defeat the explicit prefetch intent for partially resident ranges?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D18
