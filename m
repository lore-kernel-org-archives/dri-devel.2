Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3DE606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVbsfM2X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3322B10E545;
	Mon,  2 Nov 2026 07:19:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7E210E545
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 07:19:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 557A560DC0;
 Mon,  2 Nov 2026 07:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A241F000C1;
 Mon,  2 Nov 2026 07:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793603950;
 bh=TT11cNNQOUEwXofn5zKwqd+b9GGv+S9fX+rvnyFJA5Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PVbsfM2XbwmG/VqqRkbRE4QiP3MiE8SQF14m89bd/U+0Zx8gyyTrEKlzPfDpGhPTD
 REDTDWAdM0uYt+ymVKUBZH2ISIAYv1veNFl/HKeHSH2naG420tz12uKUQUPqMfENZq
 kqzylUwTSAhrPL5E1l/8UNH+8sxZW7Qxuwt77Su80PiDqyrNTQkCiYUKB97Z6OzNwB
 YneqUkLocfylF5BQ/e7ec0kgeZ2N6z5DEFwE2LZEWut4MjNIMKvRfVQm/bKyjhhpOQ
 04coN4cduPlJL/WRgvbUxzKiXAnDvIlIEzMhQXuBiFNUSm+PP28RasqJCReDp1YOQI
 gQog+QGpWjVig==
Message-ID: <sashiko-outbox-193014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] drm/imagination: Improve some logging in error
 paths
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261102-b4-simplify-mips-pte-defs-v5-3-d5bcf7d95a1a@imgtec.com>
References: <20261102-b4-simplify-mips-pte-defs-v5-0-d5bcf7d95a1a@imgtec.com>
 <20261102-b4-simplify-mips-pte-defs-v5-3-d5bcf7d95a1a@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 07:19:09 +0000
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
- [Medium] drm/imagination: wrong page count check in pvr_vm_get_pt_phys_ad=
drs()
--

commit b112075b03dc02481bd49eeee6ccd64222b769b3
Author: Matt Coster <opensource@mtcoster.net>

drm/imagination: Improve some logging in error paths

This commit adds error logging when attempting to map an already mapped
firmware object, unmap an already unmapped firmware object, or provide too
few DMA address slots for the MIPS firmware page table.

> diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/=
imagination/pvr_vm_mips.c
> index 726f900d35827..b74386032e6ab 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c
[ ... ]
> @@ -278,8 +279,12 @@ pvr_vm_get_pt_phys_addrs(struct pvr_device *pvr_dev,=
 u64 *phys_addrs, int max_nu
>  	struct pvr_fw_device *fw_dev =3D &pvr_dev->fw_dev;
>  	struct pvr_vm_mips_data *vm_data =3D fw_dev->processor_data.mips_data.v=
m_data;
> =20
> -	if (ARRAY_SIZE(vm_data->pt_pages) > max_num_addrs)
> +	if (ARRAY_SIZE(vm_data->pt_pages) > max_num_addrs) {
> +		drm_err(from_pvr_device(pvr_dev),
> +			"Minimum %zu pages required for FW PT, but only %d DMA address slots =
were provided\n",
> +			ARRAY_SIZE(vm_data->pt_pages), max_num_addrs);
>  		return -EINVAL;
> +	}
> =20
>  	for (u32 page_nr =3D 0; page_nr < max_num_addrs; page_nr++) {
>  		/* Firmware expects 4k pages, but host page size might be different. */

[Severity: Medium]
As reported by Sashiko on v4 [1], in pvr_vm_get_pt_phys_addrs() in
drivers/gpu/drm/imagination/pvr_vm_mips.c, vm_data->pt_pages and
vm_data->pt_dma_addr are sized by PVR_MIPS_PT_PAGE_COUNT, which is the
number of host PAGE_SIZE pages rather than 4K firmware pages:

#define PVR_MIPS_PT_PAGE_COUNT \
	DIV_ROUND_UP(PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES * PVR_MIPSFW_PAGE_SIZE_4K,=
 PAGE_SIZE)

However, phys_addrs and max_num_addrs are in units of 4K firmware pages
(requiring PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES slots), as shown by the loop
body translating each 4K page_nr into a host page index:

	for (u32 page_nr =3D 0; page_nr < max_num_addrs; page_nr++) {
		/* Firmware expects 4k pages, but host page size might be different. */
		u32 src_page_nr =3D (page_nr * PVR_MIPSFW_PAGE_SIZE_4K) >> PAGE_SHIFT;
		u32 page_offset =3D (page_nr * PVR_MIPSFW_PAGE_SIZE_4K) & ~PAGE_MASK;

		phys_addrs[page_nr] =3D vm_data->pt_dma_addr[src_page_nr] + page_offset;
	}

On hosts with PAGE_SIZE > 4K (such as 16K or 64K page kernels),
ARRAY_SIZE(vm_data->pt_pages) is 1 while 4 DMA address slots are still
required for the firmware page table. Checking and logging
ARRAY_SIZE(vm_data->pt_pages) allows an undersized buffer of 1 to 3 slots
to pass validation on those kernels and logs the host page count instead of
the required 4K page table slot count.

Additionally, because max_num_addrs is a signed int compared against
unsigned ARRAY_SIZE() and u32 page_nr, and the loop iterates up to
max_num_addrs rather than PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES, passing
max_num_addrs > PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES or a negative
max_num_addrs will cause src_page_nr to read out of bounds from
vm_data->pt_dma_addr[].

Should the check, error message, and loop bound use
PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES instead of ARRAY_SIZE(vm_data->pt_pages)
and max_num_addrs?

[1] https://lore.kernel.org/r/20261029-b4-simplify-mips-pte-defs-v4-3-96560=
41e040b@imgtec.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-b4-simplif=
y-mips-pte-defs-v5-0-d5bcf7d95a1a@imgtec.com?part=3D3
