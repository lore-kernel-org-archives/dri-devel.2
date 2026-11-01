Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53B606A31A
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CY7CxXIM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374EF10E025;
	Sun,  1 Nov 2026 01:42:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E230310E025
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 01:42:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 29933400D8;
 Sun,  1 Nov 2026 01:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DFB1F000C1;
 Sun,  1 Nov 2026 01:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793497359;
 bh=Y3wAkSULnghY3p9q0qChnuIgIwOMmMN+2gBezIZ1ISI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CY7CxXIM+MUu+50YgLU4vggsjWxa1X5RUs+nWLUvmAO8/23hpJF2PwkFozcdxLbfX
 ha5ZCsZ7BLM/VgNfbxHZuhP4rHbe8q/SndRijSWlQZ91KLNhsQEE8TOxjmXJHd+J/h
 o7d3dvDwtrG0xfi1y8mdQi+ltbZs7vD0x249tdEas+eiNRwdg0Lr+4mRMvoU1JIvT2
 zpNjPw65JV/sj+18zrHr9Om/UrHpTDlmKpzkb+tihAEz9cSzqPpCJx1Gu4k4Amkug7
 4zDrk2WWFpewKWJo8MSfufc4sotEf/+Y5lkIDux69Ms8cYbh6R1Qya1FoOIh/cROXP
 lYIUamc3mwHIw==
Message-ID: <sashiko-outbox-192240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: Only take the VRAM path for KFD device
 pages in svm_range_dma_map_dev
To: "Matthew Krebs" <matthewkrebs8@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261101012500.7048-1-matthewkrebs8@gmail.com>
References: <20261101012500.7048-1-matthewkrebs8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 01:42:38 +0000
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
- [Medium] drm/amdkfd: dma_map_page() fails on DAX ZONE_DEVICE pages with D=
MA_API_DEBUG
--

commit 0eacef2f328edc8a87aa6b82601cf66a9676e3be
Author: Matthew Krebs <matthewkrebs8@gmail.com>

drm/amdkfd: Only take the VRAM path for KFD device pages in svm_range_dma_m=
ap_dev

This commit restricts the VRAM mapping branch in svm_range_dma_map_dev() to
device-private and device-coherent pages so that other ZONE_DEVICE pages, s=
uch
as fsdax and device-dax mappings, are DMA mapped instead of dereferencing a
potentially NULL prange->svm_bo.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index ed5e3318877be..354184829e1d6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -180,7 +180,12 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, st=
ruct svm_range *prange,
>  			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
> =20
>  		page =3D hmm_pfn_to_page(hmm_pfns[i]);
> -		if (is_zone_device_page(page)) {
> +		/*
> +		 * Only KFD's own VRAM pages (device private or device coherent)
> +		 * take the VRAM path. Other ZONE_DEVICE pages, such as fsdax or
> +		 * device-dax memory, are system memory and are DMA mapped below.
> +		 */
> +		if (is_device_private_page(page) || is_device_coherent_page(page)) {

[Severity: Medium]
When fsdax (MEMORY_DEVICE_FS_DAX) or device-dax (MEMORY_DEVICE_GENERIC) pag=
es skip
this branch in drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_dma_map_dev()=
, they
fall through to dma_map_page():

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_dma_map_dev() {
	...
		if (is_device_private_page(page) || is_device_coherent_page(page)) {
			...
			continue;
		}
		addr[i] =3D dma_map_page(dev, page, 0, PAGE_SIZE, dir);
	...
}

In kernel/dma/mapping.c:dma_map_page_attrs(), all ZONE_DEVICE pages are rej=
ected
when CONFIG_DMA_API_DEBUG is enabled:

kernel/dma/mapping.c:dma_map_page_attrs() {
	...
	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
	    WARN_ON_ONCE(is_zone_device_page(page)))
		return DMA_MAPPING_ERROR;
	...
}

Won't mapping a fsdax or device-dax range through the KFD SVM ioctl
(kfd_ioctl_svm() -> svm_ioctl() -> svm_range_set_attr() ->
svm_range_validate_and_map() -> svm_range_dma_map() -> svm_range_dma_map_de=
v())
trigger this WARN_ON_ONCE() and fail with -ENOMEM when CONFIG_DMA_API_DEBUG=
 is
enabled?

Should svm_range_dma_map_dev() and its unmap path use dma_map_phys() and
dma_unmap_phys() (similar to hmm_dma_map_pfn() in mm/hmm.c) instead of
dma_map_page() and dma_unmap_page() when mapping non-VRAM ZONE_DEVICE pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101012500.7048=
-1-matthewkrebs8@gmail.com?part=3D1
