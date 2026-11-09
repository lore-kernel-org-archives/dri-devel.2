Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F9606A326
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RF1HNJb7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779B810E8A4;
	Mon,  9 Nov 2026 12:45:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3302D10E8A4
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:45:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 577C060204;
 Mon,  9 Nov 2026 12:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA21D1F0089F;
 Mon,  9 Nov 2026 12:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794228307;
 bh=/0gdnvM1b1ABBLh+f2hN+2hL0IWcHD+UKEYTGvmZrcE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RF1HNJb7b/O0+XEvSM/3UljvuyEaByfY4yW7CQtwK4yX1y/bgplmDVI+d2bOwxYVY
 bE+gmUlavQiN7Zu6AIOjWFAVJgBfgnJjU5IHOoEvTtNHEuQ35ZC5/owq8ARzDEs3Rs
 O7q8pg63fp0GKdPkagt1RgucNZzwbwh3bTnzTmpG5e6M+siCS7ivtem5r4ua+2kNNy
 rIOcAyy2rf/awSdUqFnElaoV+4K29T9qV7pDQywhhYukEv/gQ6zB7cHpDKcn21nBSY
 wkkRjU7updP+KrL4GlvxPNc/2SBGkJTUUebUwJppfbSr63dY0QZ9pi59RkeSa3YYhM
 Y/DHTgL255E0Q==
Message-ID: <sashiko-outbox-204977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] drm/imagination: Improve some logging in error
 paths
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109-b4-simplify-mips-pte-defs-v6-3-65153bc9a71c@imgtec.com>
References: <20261109-b4-simplify-mips-pte-defs-v6-0-65153bc9a71c@imgtec.com>
 <20261109-b4-simplify-mips-pte-defs-v6-3-65153bc9a71c@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 12:45:06 +0000
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
- [Medium] drm/imagination: wrong page count check in
  pvr_vm_get_pt_phys_addrs()
--

commit 43aecf50717d40af73f931373c0d00296cc14d1f
Author: Matt Coster <opensource@mtcoster.net>

drm/imagination: Improve some logging in error paths

This commit adds drm_err() messages to error paths in
pvr_fw_object_fw_map(), pvr_fw_object_fw_unmap(), and
pvr_vm_get_pt_phys_addrs().

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
Does this check and log ARRAY_SIZE(vm_data->pt_pages) in host pages instead
of the 4K firmware page count PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES?

vm_data->pt_pages and vm_data->pt_dma_addr are sized in host pages:

drivers/gpu/drm/imagination/pvr_vm_mips.c:
#define PVR_MIPS_PT_PAGE_COUNT \
	DIV_ROUND_UP(PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES * PVR_MIPSFW_PAGE_SIZE_4K,=
 PAGE_SIZE)

struct pvr_vm_mips_data {
	struct page *pt_pages[PVR_MIPS_PT_PAGE_COUNT];
	...
	dma_addr_t pt_dma_addr[PVR_MIPS_PT_PAGE_COUNT];

On a host with 16K or 64K PAGE_SIZE, ARRAY_SIZE(vm_data->pt_pages) is 1,
whereas the firmware page table requires PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES
(4) 4K DMA address slots in phys_addrs.  A max_num_addrs of 1 to 3 passes
this check on 16K/64K page kernels and leaves the firmware page table
incomplete, or logs 1 instead of 4 as the required minimum.

Also, max_num_addrs is a signed int compared against unsigned size_t
ARRAY_SIZE() and used as the upper bound of the loop, so a negative
max_num_addrs or a value larger than PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES
causes src_page_nr to read out of bounds from vm_data->pt_dma_addr[].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-b4-simplif=
y-mips-pte-defs-v6-0-65153bc9a71c@imgtec.com?part=3D3
