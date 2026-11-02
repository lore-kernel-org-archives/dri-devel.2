Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085CF606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVcw1vMl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3859110EB6E;
	Mon,  2 Nov 2026 07:19:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76AD610EB6E
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 07:19:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEF0960EDF;
 Mon,  2 Nov 2026 07:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8273A1F00919;
 Mon,  2 Nov 2026 07:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793603970;
 bh=utcRIZ85DAVgCeIWJuSFPbheDW33g7Mv9b2oWETQ8UY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DVcw1vMl5xljBGEEo+qRCCsVFb4fueT0Es9eAqAXghd/24pR5nzVbVyvR5XFiZT9o
 qoWLL8H/N7zd5DtL/Il7fwBckERW20mprlJFDUQW/B31hlSy7XfWNAUJiQuu+qcoQu
 RA3qYmJvHlLTVtm2avnazS/PdHi09JOVL1KQgjBqBeTs8jBaRKmdxIGqgflctwlEat
 Rwq4eCPmakQ6lcKoQ9sbUthhq6/jR9x7VvnreOFNG/Cd4VM6Wdy3YmgaedlAXY2BBo
 p0RwMXonY+d4+ReiCYSB82xleI7pt0FGWbgBnyMNC1tSFolqXve7yA4Vqy1Yv0ti6n
 sz35r2rZ/YLIg==
Message-ID: <sashiko-outbox-193015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] drm/imagination: Limit access to the MIPS
 firmware interface
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261102-b4-simplify-mips-pte-defs-v5-1-d5bcf7d95a1a@imgtec.com>
References: <20261102-b4-simplify-mips-pte-defs-v5-0-d5bcf7d95a1a@imgtec.com>
 <20261102-b4-simplify-mips-pte-defs-v5-1-d5bcf7d95a1a@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 07:19:30 +0000
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
- [Medium] drm/imagination: wrong page count and loop bound in pvr_vm_get_p=
t_phys_addrs()
- [Low] drm/imagination: missing types.h include and prefix in pvr_vm_mips.h
--

commit ba830ed70a6d676494fb621937678d6996067bfb
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Limit access to the MIPS firmware interface

This commit splits struct pvr_fw_mips_data into separate internal structures
for the main MIPS firmware logic and the MIPS VM logic, removes pvr_fw_mips=
.h,
renames the MIPS firmware processor headers with an _internal suffix, and a=
dds
pvr_vm_get_pt_phys_addrs() to retrieve the MIPS firmware page table address=
es.

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
As reported by Sashiko on v4 [1], in pvr_vm_get_pt_phys_addrs(), does
checking ARRAY_SIZE(vm_data->pt_pages) and looping up to max_num_addrs use
the wrong page count?

vm_data->pt_pages and vm_data->pt_dma_addr are sized by
PVR_MIPS_PT_PAGE_COUNT, which is the number of host PAGE_SIZE pages (for
example, 1 page on 16K or 64K page kernels), whereas the loop steps by
4K firmware pages and requires ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES (4)
entries.

On hosts with PAGE_SIZE > 4K, ARRAY_SIZE(vm_data->pt_pages) is 1, so the
check fails to reject a phys_addrs buffer with fewer than 4 entries. In
addition, if a caller passes max_num_addrs greater than
ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES, the loop reads past the end of
vm_data->pt_dma_addr[].

Also, because max_num_addrs is a signed int, comparing it against
ARRAY_SIZE() and u32 page_nr triggers -Wsign-compare warnings and would
treat negative values as large unsigned numbers. Should max_num_addrs be u32
(or size_t), and should both the check and loop bound use
ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES instead?

> diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.h b/drivers/gpu/drm/=
imagination/pvr_vm_mips.h
> index 0fd59f68fb5b8..3db0606c50374 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm_mips.h
> +++ b/drivers/gpu/drm/imagination/pvr_vm_mips.h
> @@ -18,5 +18,7 @@ int
>  pvr_vm_mips_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj=
);
>  void
>  pvr_vm_mips_unmap(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_o=
bj);
> +int
> +pvr_vm_get_pt_phys_addrs(struct pvr_device *pvr_dev, u64 *phys_addrs, in=
t max_num_addrs);
> =20
>  #endif /* PVR_VM_MIPS_H */

[Severity: Low]
In drivers/gpu/drm/imagination/pvr_vm_mips.h, pvr_vm_get_pt_phys_addrs()
uses u64 in its prototype, but pvr_vm_mips.h does not include
<linux/types.h>. Could this fail to compile if pvr_vm_mips.h is included
before <linux/types.h>?

Also, this isn't a bug, but all other functions in pvr_vm_mips.h use the
pvr_vm_mips_ prefix (pvr_vm_mips_init(), pvr_vm_mips_fini(),
pvr_vm_mips_map(), pvr_vm_mips_unmap()). Should this function be named
pvr_vm_mips_get_pt_phys_addrs() for consistency?

[1] https://lore.kernel.org/r/20261029-b4-simplify-mips-pte-defs-v4-1-96560=
41e040b@imgtec.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-b4-simplif=
y-mips-pte-defs-v5-0-d5bcf7d95a1a@imgtec.com?part=3D1
