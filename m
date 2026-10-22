Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00821606A325
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQzQYYIi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D02711240C;
	Thu, 22 Oct 2026 08:36:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02D3112411
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:36:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF93760018;
 Thu, 22 Oct 2026 08:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D7C1F000C1;
 Thu, 22 Oct 2026 08:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792658203;
 bh=n+vAAmuAwv/3hTOmT5D4ZpO14xp46WkMsRL2ipvVouk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cQzQYYIiI0r821kUNipIXVj/iDhSeTESF5y9SEqoN9NrTlO9RuAs7lc0GsMEoE9Zj
 1yaAVgINFWlQ/c6GRUctCllkDaOLfXTKjfrq0aTrRsqeqsAyqddt5FO2iAyBXM1gJL
 TeB+D08AkhKtQHOcN6WE6xM9HvNwJ51weiUUWrnrHbHIIcr6sjJL6HF/7YW3Vtbaz9
 qSYXl+q1Vo9UZxLLgA35McMapiYayOQ05w0xmt7L9QAJyzFQw2EFFuQIECGkzDb6e6
 YW/zT014n3L3c5/rE6qScdIE5AnfOFwjjzHR26gKMkwdEkGL/yC2ap5z+0TGxi7FFk
 ftDlrRjThrGsw==
Message-ID: <sashiko-outbox-181188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] drm/imagination: Limit access to the MIPS
 firmware interface
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022-b4-simplify-mips-pte-defs-v2-1-ee2402c03a4b@imgtec.com>
References: <20261022-b4-simplify-mips-pte-defs-v2-0-ee2402c03a4b@imgtec.com>
 <20261022-b4-simplify-mips-pte-defs-v2-1-ee2402c03a4b@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:36:43 +0000
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
- [Medium] drm/imagination: wrong page count check and loop bound in pvr_vm=
_get_pt_phys_addrs()
--

commit e4145d0a7941bfef48f4dfeebed31eabbdbd97ec
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Limit access to the MIPS firmware interface

This commit splits struct pvr_fw_mips_data into separate firmware and VM
structures internal to pvr_fw_mips.c and pvr_vm_mips.c, removes
pvr_fw_mips.h, and adds pvr_vm_get_pt_phys_addrs() to retrieve the MIPS
firmware page table physical addresses.

> diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/=
imagination/pvr_vm_mips.c
> index 5847a1c92bea8..264ea0fccf9c1 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c

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
In pvr_vm_get_pt_phys_addrs(), each element written to phys_addrs[] is a 4K
MIPS firmware page table address, whereas vm_data->pt_pages and
vm_data->pt_dma_addr are sized by PVR_MIPS_PT_PAGE_COUNT in units of host
PAGE_SIZE pages:

  #define PVR_MIPS_PT_PAGE_COUNT \
      DIV_ROUND_UP(ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES * \
                   ROGUE_MIPSFW_PAGE_SIZE_4K, PAGE_SIZE)

On a host with 16K or 64K pages, ARRAY_SIZE(vm_data->pt_pages) is 1 while
ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES is 4, so checking
ARRAY_SIZE(vm_data->pt_pages) > max_num_addrs allows a max_num_addrs betwee=
n 1
and 3 to pass instead of returning -EINVAL.

In addition, the loop iterates up to max_num_addrs rather than
ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES. If a caller passes max_num_addrs larg=
er
than ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES, src_page_nr will exceed
PVR_MIPS_PT_PAGE_COUNT - 1 and read past the end of vm_data->pt_dma_addr[].
Also, because max_num_addrs is a signed int compared against unsigned types
(size_t in ARRAY_SIZE and u32 page_nr), a negative max_num_addrs converts t=
o a
large unsigned value, bypassing the bounds check and overflowing
vm_data->pt_dma_addr[] and phys_addrs[].

Should max_num_addrs be u32 (or size_t), checked against
ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES, with the loop bounded by
ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-simplif=
y-mips-pte-defs-v2-0-ee2402c03a4b@imgtec.com?part=3D1
