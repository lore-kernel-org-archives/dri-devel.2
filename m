Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7419606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcDAGvbR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4E710E7A4;
	Thu, 29 Oct 2026 06:22:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B75810E7A4
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:22:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49D36601F8;
 Thu, 29 Oct 2026 06:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3DB1F01828;
 Thu, 29 Oct 2026 06:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793254951;
 bh=m+fmCzTQU/tN1k4BJOZmSO3eAgDqG1/5G5nJO7+huII=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GcDAGvbRnLAgVrtAinUDfzZuoXoVZ4vWk0fUaRfMW4hDkiVTYCUvBbmpLVGMK5huH
 lGBzHFz8+c6/bd5YqTho86m3oRtHKq/cTwp3SpHPKswu0lQxCp87Fnfr3H9HYmuBsK
 sY2kKK1RuLaVquwEKFX44VnXc045oUT/h7nfu54GwXWteZW8C5n3z7gA06DNsbGUTC
 GILvR465viRBrNmoFiF/Rqh/pbMRcF+81pMCQBegHRZ4K65adnFHvo3+wxikhxAw8A
 ID4AL/+ENWnoiqle17P5XnsjbgIHr6pp3blzo3kAqs63+ITz1Scv5cXnExD9rnY0qi
 /LNwYdJ8Pe3Hg==
Message-ID: <sashiko-outbox-188813@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] drm/imagination: Improve some logging in error
 paths
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-b4-simplify-mips-pte-defs-v4-3-9656041e040b@imgtec.com>
References: <20261029-b4-simplify-mips-pte-defs-v4-0-9656041e040b@imgtec.com>
 <20261029-b4-simplify-mips-pte-defs-v4-3-9656041e040b@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:22:30 +0000
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

commit d2b300f194de238da66cb86085f9b887ba2e3307
Author: Matt Coster <opensource@mtcoster.net>

drm/imagination: Improve some logging in error paths

This commit adds drm_err() messages when attempting to map an already mapped
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

[Severity: Medium]
Should pvr_vm_get_pt_phys_addrs() check and log
PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES instead of ARRAY_SIZE(vm_data->pt_pages)?

In drivers/gpu/drm/imagination/pvr_vm_mips.c, vm_data->pt_pages and
vm_data->pt_dma_addr are sized by PVR_MIPS_PT_PAGE_COUNT, which is the numb=
er
of host PAGE_SIZE pages:

#define PVR_MIPS_PT_PAGE_COUNT \
	DIV_ROUND_UP(PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES * PVR_MIPSFW_PAGE_SIZE_4K,=
 PAGE_SIZE)

However, phys_addrs and max_num_addrs are in units of 4K firmware pages
(PVR_MIPSFW_PAGE_SIZE_4K), as seen in the loop immediately following this
check:

	for (u32 page_nr =3D 0; page_nr < max_num_addrs; page_nr++) {
		/* Firmware expects 4k pages, but host page size might be different. */
		u32 src_page_nr =3D (page_nr * PVR_MIPSFW_PAGE_SIZE_4K) >> PAGE_SHIFT;
		u32 page_offset =3D (page_nr * PVR_MIPSFW_PAGE_SIZE_4K) & ~PAGE_MASK;

		phys_addrs[page_nr] =3D vm_data->pt_dma_addr[src_page_nr] + page_offset;
	}

On a host with 16K or 64K pages, ARRAY_SIZE(vm_data->pt_pages) is 1 while
PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES is 4, so a max_num_addrs of 1 to 3 would
pass the check and receive an incomplete page table, or log that a minimum =
of
1 page is required when 4 DMA address slots are needed.

Also, because max_num_addrs is a signed int compared against unsigned types
and used as the loop bound instead of PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES,
could a negative max_num_addrs or a value greater than
PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES cause src_page_nr to read out of bounds
from vm_data->pt_dma_addr[]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-simplif=
y-mips-pte-defs-v4-0-9656041e040b@imgtec.com?part=3D3
