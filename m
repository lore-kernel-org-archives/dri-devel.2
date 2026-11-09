Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29419606A335
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsO18QoK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E86110E73C;
	Mon,  9 Nov 2026 12:44:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F96610E8A4
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:44:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2910342E7C;
 Mon,  9 Nov 2026 12:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E449A1F008A1;
 Mon,  9 Nov 2026 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794228274;
 bh=4Yy9Mom/rOBdxPbYt4MGfv+4venLco3a70Us0iHWcZc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OsO18QoKbNgZE/hvHmhOFakorIJJrcRndJs48EGUNGWvvXwMnKbpW3Q/6c1usxbaJ
 Av8CZXVrNwR4eIoVuZhdSxhi8QX+YF+uy+a40/8gr54COXUQIUlTi1g+NHjdz1x3x8
 +wRqgh0yLyJRnO/J6fwcC0MuJQ6gBC8E0h0w0Mu0F8ENLXIh+wR2Hcu9Uvk2Nv/FXP
 XzFd4AIUc4K9fL4ZWYmUILbvjRlIra/OHzCbiyTh2mpkcgofwnOkGPBqR+MEYO+quO
 O6+cneOEA77lsbY4GOtDacqYNESVbARHsS8MGv2qtPpfSxmO2J3vpoLhH3Gn87/1Yn
 dnh7yOEOdkA7Q==
Message-ID: <sashiko-outbox-204976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] drm/imagination: Limit access to the MIPS
 firmware interface
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109-b4-simplify-mips-pte-defs-v6-1-65153bc9a71c@imgtec.com>
References: <20261109-b4-simplify-mips-pte-defs-v6-0-65153bc9a71c@imgtec.com>
 <20261109-b4-simplify-mips-pte-defs-v6-1-65153bc9a71c@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 12:44:33 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/imagination: wrong page count and loop bound in
  pvr_vm_get_pt_phys_addrs()
--

commit e62c2f99ef374e32a08f96715d23432d524c50fd
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Limit access to the MIPS firmware interface

This commit splits struct pvr_fw_mips_data into separate firmware and VM
structures, removes pvr_fw_mips.h, and adds pvr_vm_get_pt_phys_addrs() to
retrieve the MIPS firmware page table physical addresses.

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
Should pvr_vm_get_pt_phys_addrs() check and loop against
ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES rather than
ARRAY_SIZE(vm_data->pt_pages) and max_num_addrs?

vm_data->pt_pages and vm_data->pt_dma_addr are sized to
PVR_MIPS_PT_PAGE_COUNT, which is the number of host PAGE_SIZE pages (1 on
16K or 64K page kernels), whereas the loop steps by 4K firmware pages
(ROGUE_MIPSFW_PAGE_SIZE_4K).  On 16K or 64K page hosts, checking
ARRAY_SIZE(vm_data->pt_pages) > max_num_addrs allows a phys_addrs buffer
with fewer than 4 entries, and looping up to max_num_addrs reads out of
bounds from vm_data->pt_dma_addr[] whenever a caller passes max_num_addrs >
ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES.

Also, max_num_addrs is a signed int compared against unsigned ARRAY_SIZE()
and u32 page_nr, which triggers -Wsign-compare warnings and promotes
negative values to large unsigned integers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-b4-simplif=
y-mips-pte-defs-v6-0-65153bc9a71c@imgtec.com?part=3D1
