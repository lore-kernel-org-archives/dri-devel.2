Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16307606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HldSW/uG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D5410E784;
	Thu, 29 Oct 2026 06:21:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC85210E784
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:21:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FD3243269;
 Thu, 29 Oct 2026 06:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2291F01825;
 Thu, 29 Oct 2026 06:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793254880;
 bh=MwCOmZXP6z+DhMZx3i10QCICGtnTp8Zag+DzzpR+f4A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HldSW/uGlUNoMVkJQszV8/IK2iidbN21QOa+CKDvSGExnyoKp5sgbxg+i3gx7r7T4
 8aN/u+XbUiv5EeVmtCoDrpfzpRQbdAFd3JXXmMPt6Vmx4GJyZ5r2Ts9pJJGpandtpB
 E6foerRGdACBrRjVCyr6C3sTU4i3y1Js0fknSOr6Z+qyPMFcCo/UeXOBvyvHadzf6N
 mIZpb7e1fKB3Ag99yFI0Qh3kfc4Ss/UhgwAgXzy5thLBf2IKoDZVNJhk2WuyjWdrBX
 vqyxsLH0WFdWo4+bhImWX/bNBILokghowKxZKbbV0AvXPF6m1vw6eRK16aKc7NDPVx
 bMTzI6f4RTkKA==
Message-ID: <sashiko-outbox-188812@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] drm/imagination: Limit access to the MIPS
 firmware interface
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-b4-simplify-mips-pte-defs-v4-1-9656041e040b@imgtec.com>
References: <20261029-b4-simplify-mips-pte-defs-v4-0-9656041e040b@imgtec.com>
 <20261029-b4-simplify-mips-pte-defs-v4-1-9656041e040b@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:21:19 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/imagination: wrong page count check and loop bound in pvr_vm=
_get_pt_phys_addrs()
- [Low] drm/imagination: mismatched kernel-doc member names in struct pvr_f=
w_device
--

commit 1c0b6ad7b66c2f99b867a56a6bc1405d6e8aad70
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Limit access to the MIPS firmware interface

This commit splits struct pvr_fw_mips_data into separate structures for the
main MIPS firmware logic and the MIPS VM logic, removes pvr_fw_mips.h, and
adds pvr_vm_get_pt_phys_addrs() to retrieve the physical addresses of the
MIPS firmware page table.

> diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagi=
nation/pvr_fw.h
> index 4b25291135b69..0d4507f55c84b 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw.h
> +++ b/drivers/gpu/drm/imagination/pvr_fw.h
> @@ -310,10 +310,15 @@ struct pvr_fw_device {
>  	/** @funcs: Function table for the FW processor used by this device. */
>  	const struct pvr_fw_defs *defs;
> =20
> -	/** @processor_data: Pointer to data specific to FW processor. */
> +	/** @processor_data: Data specific to FW processor. */
>  	union {
> -		/** @mips_data: Pointer to MIPS-specific data. */
> -		struct pvr_fw_mips_data *mips_data;
> +		/** @mips_data: MIPS-specific data. */
> +		struct {
> +			/** @mips_fw_data: Pointer to MIPS-FW-specific data. */
> +			struct pvr_fw_mips_data *fw_data;
> +			/** @mips_vm_data: Pointer to MIPS-VM-specific data. */
> +			struct pvr_vm_mips_data *vm_data;
> +		} mips_data;

[Severity: Low]
This isn't a bug, but in struct pvr_fw_device in
drivers/gpu/drm/imagination/pvr_fw.h, should the kernel-doc tags
@mips_fw_data and @mips_vm_data be @fw_data and @vm_data to match the struct
member names?

> diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/=
imagination/pvr_vm_mips.c
> index 5847a1c92bea8..264ea0fccf9c1 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c
> @@ -16,6 +17,31 @@
>  #include <linux/types.h>
>  #include <linux/vmalloc.h>
> =20
> +#define PVR_MIPS_PT_PAGE_COUNT \
> +	DIV_ROUND_UP(ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES * ROGUE_MIPSFW_PAGE_S=
IZE_4K, PAGE_SIZE)
> +
> +/**
> + * struct pvr_vm_mips_data - MIPS-VM-specific data
> + */
> +struct pvr_vm_mips_data {
> +	/**
> +	 * @pt_pages: Pages containing MIPS pagetable.
> +	 */
> +	struct page *pt_pages[PVR_MIPS_PT_PAGE_COUNT];
> +
> +	/** @pt: Pointer to CPU mapping of MIPS pagetable. */
> +	u32 *pt;
> +
> +	/** @pt_dma_addr: DMA mappings of MIPS pagetable. */
> +	dma_addr_t pt_dma_addr[PVR_MIPS_PT_PAGE_COUNT];

[ ... ]

> @@ -230,8 +256,38 @@ pvr_vm_mips_unmap(struct pvr_device *pvr_dev, struct=
 pvr_fw_object *fw_obj)
>  			    ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K;
> =20
>  	for (u32 pfn =3D start_pfn; pfn < end_pfn; pfn++)
> -		WRITE_ONCE(mips_data->pt[pfn], 0);
> +		WRITE_ONCE(vm_data->pt[pfn], 0);
> =20
>  	pvr_mmu_flush_request_all(pvr_dev);
>  	WARN_ON(pvr_mmu_flush_exec(pvr_dev, true));
>  }
> +
> +/**
> + * pvr_vm_get_pt_phys_addrs() - Acquire the physical addresses of the MI=
PS FW page table pages
> + * @pvr_dev: Target PowerVR device.
> + * @phys_addrs: Output array for physical addresses of MIPS FW page tabl=
e pages.
> + * @max_num_addrs: Maximum number of addresses that can be written to @p=
hys_addrs.
> + *
> + * Returns:
> + *  * 0 on success, or
> + *  * -%EINVAL if @phys_addrs cannot accommodate all MIPS FW page table =
pages.
> + */
> +int
> +pvr_vm_get_pt_phys_addrs(struct pvr_device *pvr_dev, u64 *phys_addrs, in=
t max_num_addrs)
> +{
> +	struct pvr_fw_device *fw_dev =3D &pvr_dev->fw_dev;
> +	struct pvr_vm_mips_data *vm_data =3D fw_dev->processor_data.mips_data.v=
m_data;
> +
> +	if (ARRAY_SIZE(vm_data->pt_pages) > max_num_addrs)
> +		return -EINVAL;
> +
> +	for (u32 page_nr =3D 0; page_nr < max_num_addrs; page_nr++) {
> +		/* Firmware expects 4k pages, but host page size might be different. */
> +		u32 src_page_nr =3D (page_nr * ROGUE_MIPSFW_PAGE_SIZE_4K) >> PAGE_SHIF=
T;
> +		u32 page_offset =3D (page_nr * ROGUE_MIPSFW_PAGE_SIZE_4K) & ~PAGE_MASK;
> +
> +		phys_addrs[page_nr] =3D vm_data->pt_dma_addr[src_page_nr] + page_offse=
t;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
In pvr_vm_get_pt_phys_addrs() in drivers/gpu/drm/imagination/pvr_vm_mips.c
(and its declaration in drivers/gpu/drm/imagination/pvr_vm_mips.h), should
the size check and loop bound use ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES
instead of ARRAY_SIZE(vm_data->pt_pages) and max_num_addrs, and should
max_num_addrs be an unsigned type such as u32?

vm_data->pt_pages and vm_data->pt_dma_addr are sized to
PVR_MIPS_PT_PAGE_COUNT, which is the number of host PAGE_SIZE pages (for
example, 1 on 16K or 64K page hosts), whereas phys_addrs is populated with
4K MIPS firmware page table addresses
(ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES =3D 4).

Checking ARRAY_SIZE(vm_data->pt_pages) > max_num_addrs validates against the
host page count rather than ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES, so on 16K
or 64K page hosts a buffer with fewer than 4 entries would pass the check.

Additionally, iterating page_nr up to max_num_addrs rather than
ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES means that if a caller passes
max_num_addrs > ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES, src_page_nr will index
past the end of vm_data->pt_dma_addr[]. Because max_num_addrs is a signed i=
nt
compared against unsigned ARRAY_SIZE() and u32 page_nr, this also triggers
-Wsign-compare warnings and allows negative values to bypass the check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-simplif=
y-mips-pte-defs-v4-0-9656041e040b@imgtec.com?part=3D1
