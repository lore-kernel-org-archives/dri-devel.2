Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D332A606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e/ZAM5gD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEA410E78D;
	Sun, 25 Oct 2026 04:40:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E025F10E78D
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:40:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 634AF600D4;
 Sun, 25 Oct 2026 04:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0E71F01825;
 Sun, 25 Oct 2026 04:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792903228;
 bh=Ow1sr0ySG+5XDIxNahFaZ2FvZsHoJ7LrFYwoMMDtRww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e/ZAM5gD2zCQLrI/P1zjo/5Msu4N4tKn36DAs705SxCEgg1VWSqXRTTQ2DdV0l7lZ
 AJJytgifRCvT6EYovcBM+8F1EQTCpTGWVL61cSTgrnAudoHNKKfIsiYrr846wFoZvo
 EnxxM1csEf+jcWWAGqzhtYdLaOfga5iVsW0u7eSH11+9fK3k5F/795BMI+xHt0vQnr
 1lkCFBImQBfhqA+DMGKC4TscEX0SxGJl3E8egemYEcmq4u3eNPhKYkPW/Q+WP6neB9
 vRfjpZM7QIsERyG1kyBYQthhCrxl2rX60V4fyn5Zvin9rMC7qE6DnOfEf2uFRNLH3T
 7QykFukY8XAuw==
Message-ID: <sashiko-outbox-184074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] drm/amdgpu: Catch register access while GMUX
 keeps the GPU off
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>, 
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-11-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-11-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:40:27 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/amdgpu: missing skip_hw_access check in amdgpu_device_indirect=
_rreg_ext()
--

commit 68a505d63bba52b15e530c1a5a5c68524afaf59d
Author: Andre Eikmeyer <dev@deq.rocks>

drm/amdgpu: Catch register access while GMUX keeps the GPU off

This commit tracks when the GPU is powered off via GMUX during runtime
suspend by setting adev->gmux_off, and skips and reports register accesses =
in
amdgpu_device_skip_hw_access() and indirect PCIe register access helpers to
prevent hanging the PEG link.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_reg_access.c
> index 7468855c16a25..bb5dbeb7fa721 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> @@ -594,6 +594,9 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device =
*adev, u32 reg_addr)
>  	void __iomem *pcie_data_offset;
>  	u32 r;
> =20
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
>  	pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>  	pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
> =20
> @@ -677,6 +680,12 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_devi=
ce *adev, u32 reg_addr)
>  	void __iomem *pcie_data_offset;
>  	u64 r;
> =20
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;

[Severity: High]
Was one of these duplicate amdgpu_device_skip_hw_access(adev) checks in
amdgpu_device_indirect_rreg64() intended for amdgpu_device_indirect_rreg_ex=
t()
just above it?

Currently amdgpu_device_indirect_rreg_ext() in
drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c is the only indirect PCIe
register accessor without this guard:

u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev, u64 reg_add=
r)
{
	unsigned long flags, pcie_index, pcie_index_hi, pcie_data;
	u32 r;
	void __iomem *pcie_index_offset;
	void __iomem *pcie_index_hi_offset;
	void __iomem *pcie_data_offset;

	if (unlikely(!adev->nbio.funcs)) {
		...
	}
	...
	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
	pcie_index_offset =3D (void __iomem *)adev->rmmio + pcie_index * 4;
	pcie_data_offset =3D (void __iomem *)adev->rmmio + pcie_data * 4;
	...
	writel(reg_addr, pcie_index_offset);
	readl(pcie_index_offset);

If RREG32_PCIE_EXT() -> amdgpu_reg_pcie_ext_rd32() ->
amdgpu_device_indirect_rreg_ext() is called while adev->gmux_off or
adev->no_hw_access is true, won't it still perform MMIO accesses on
adev->rmmio?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D10
