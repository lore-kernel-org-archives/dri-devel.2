Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2357CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C3941126E1;
	Fri, 16 Oct 2026 09:26:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 131F61126F7
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:26:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A915C41210;
 Fri, 16 Oct 2026 09:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D651F000C8;
 Fri, 16 Oct 2026 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792142799;
 bh=mpEV3p/xqK3124xIQYY+IgM3jrHpfGKUbgMtrke3Ch0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DCDEM3thjhPNMtaXAtsNpodCiIYFIcT3SSIFJYbI2GbHf/NIs2ixGVcABUZprDCon
 GsBMT2hZ79fzyfRuIDqjH3ymjgfulpUnQsx8+47sPrN/iTsCRRhTWcPZa4zDolZmr9
 c5Tg58YIKIf0X4DMndf1sJ8ijqXLCLseOx/EU1xswY+/ZtthAYDw5eR56NmC4+A1SC
 WZn+TX8xjxuxZpP1QkFZ4gvAzdFL2YCOysPd6hcwj0El40pP6x2NYsKVuDBIUJo3FF
 aDmr3xsRRVPRf7SU7aqFmCgfeqLGFULjOf5g4SRfWRcGj0axQ9c2mss1vzUuv5nvwe
 evImpHbev78AQ==
Message-ID: <sashiko-outbox-174078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/amdkfd: validate SVM ranges against the
 target GPU address limits
To: "Daniel Huang" <danielhu@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261016170546.88570-3-danielhu@amd.com>
References: <20261016170546.88570-1-danielhu@amd.com>
 <20261016170546.88570-3-danielhu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 09:26:38 +0000
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
- [Critical] drm/amdgpu: out-of-bounds array access in amdgpu_vm_pt_descend=
ant() on invalid fault address
- [High] mm: infinite page fault loop when VMA crosses GPUVM limit
- [High] drm/amdkfd: unmap skips valid subranges if overall range exceeds G=
PU limit
--

commit c516e2b1eb5a9d1a668925627f8b8692a22ac1fd
Author: Daniel Huang <danielhu@amd.com>
drm/amdkfd: validate SVM ranges against the target GPU address limits

This commit adds limits validation for SVM ranges mapped to the GPU in
amdkfd, ensuring ranges don't exceed the GPU address limits. It checks
the limits in both mapping and unmapping paths, as well as the fault
handling path.

Link: https://sashiko.dev/#/patchset/20261016145129.69645-1-danielhu%40amd.=
com

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index cfb428c72686e..c3e4f0367522d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1427,6 +1427,16 @@ svm_range_unmap_from_gpu(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm,
>  		return -EINVAL;
>  	}
> =20
> +	/* Such a range was rejected by svm_range_map_to_gpu() and so was
> +	 * never mapped. Skip it rather than failing, since unmap is also
> +	 * used on the eviction and process teardown paths.
> +	 */
> +	if (!kfd_svm_range_fits_gpu(adev, start, last)) {

[Severity: High]
Does this skip unmapping for valid subranges if the overall range
exceeds the GPU limit?

When a large user-space virtual memory area (prange) partially overlaps the
GPU limit, subranges within the limit can be successfully mapped in
svm_range_map_to_gpus().

However, when the entire prange is later unmapped here,
kfd_svm_range_fits_gpu() checks the overall bounds (start to last). Since
last exceeds the limit, it returns false and unmapping is skipped entirely.

Could this leave the valid page table entries of the previously mapped
subrange permanently mapped to potentially freed memory, causing a
use-after-free and resource leak on the GPU?

> +		pr_debug("CPU[0x%llx 0x%llx] exceeds GPUVM, skipping unmap\n",
> +			 start, last);
> +		return 0;
> +	}
> +
>  	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL,=
 gpu_start,

[ ... ]

> @@ -1604,6 +1624,20 @@ svm_range_map_to_gpus(struct svm_range *prange, un=
signed long offset,
>  			continue;
>  		}
> =20
> +		/* GPUs in the same process can have different address limits.
> +		 * Skip the ones that cannot represent this range instead of
> +		 * failing the whole mapping.
> +		 */
> +		if (npages && !kfd_svm_range_fits_gpu(pdd->dev->adev,
> +						      prange->start + offset,
> +						      prange->start + offset +
> +						      npages - 1)) {

[Severity: High]
Can this cause an infinite page fault loop when the virtual memory area
crosses the GPU limit?

If the GPU faults on an address within an allocation that is below the GPU
limit, svm_range_restore_pages() allows it to proceed because it only checks
the faulting address. Then svm_range_create_unregistered_range() creates a
range spanning the entire area, which might exceed the GPU limit.

When this code skips the mapping for the GPU because the end of the range
exceeds the limit, it continues and returns 0 for success. Will the page
fault handler exit with success without resolving the fault, causing the GPU
to continuously refault on the same address and leading to a hard hang?

> +			pr_debug("device idx %d cannot map CPU[0x%lx 0x%lx]\n",
> +				 gpuidx, prange->start + offset,
> +				 prange->start + offset + npages - 1);
> +			continue;
> +		}
> +
>  		set_bit(gpuidx, prange->bitmap_mapped);

[ ... ]

> @@ -3096,6 +3130,14 @@ svm_range_restore_pages(struct amdgpu_device *adev=
, unsigned int pasid,
>  		return -EFAULT;
>  	}
> =20
> +	/* addr is a CPU page index here. Reject faults the GPUVM cannot
> +	 * represent before any range is looked up or migrated.
> +	 */
> +	if (!kfd_svm_range_fits_gpu(adev, addr, addr)) {

[Severity: Critical]
Can returning -EFAULT here trigger an out-of-bounds array access in the
fallback path?

When this returns -EFAULT, amdgpu_vm_handle_fault() bypasses its early retu=
rn
and falls through to its fallback path. It then passes the exact same
unvalidated, out-of-bounds addr to amdgpu_vm_update_range():

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:amdgpu_vm_handle_fault() {
    ...
    if (!svm_range_restore_pages(adev, pasid, vmid, node_id,
                                 addr >> PAGE_SHIFT, ts, write_fault))
        return true;
    ...
    r =3D amdgpu_vm_update_range(adev, vm, true, false, false, false,
                               NULL, addr, addr, flags, value, 0,
                               NULL, NULL, NULL);
    ...
}

Because amdgpu_vm_update_range() lacks internal bounds checking against
max_pfn, it eventually uses an out-of-bounds index derived from the
unvalidated addr to index into the root page directory's flexible entries
array in amdgpu_vm_pt_descendant(). Could this lead to memory corruption or
a kernel panic?

> +		pr_debug("fault address 0x%llx exceeds GPUVM\n", addr);
> +		return -EFAULT;
> +	}
> +
>  	p =3D kfd_lookup_process_by_pasid(pasid, NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016170546.8857=
0-1-danielhu@amd.com?part=3D2
