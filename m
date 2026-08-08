Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D97C5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 10:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84FEC10E02B;
	Sat,  8 Aug 2026 10:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P0TIztDL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE4C10E02B
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 10:23:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DF1D6001A;
 Sat,  8 Aug 2026 10:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AE61F000E9;
 Sat,  8 Aug 2026 10:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786184593;
 bh=LDsOqlAw9/4RkB/u0hMpbAK5eT/c/i6obPUvuBIcBOI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P0TIztDL7Q/dHlhzcN8Lom7/7ND4N0IacLvgxyRD07GdEBWDT0qZllvyX7wr6nRiG
 MrKSc9qIi7ebtRW1YFZqVQyvQSohbtcNUkakqhCJ8m7PgSBfW+7ByQ+73yJ/MpDBE2
 ULlFvaZDwcTRkQiwuRUxJ/vlo3q3tFNfEroDCZvfWp6zZBFdQhsqlVxIgsTa0lBtrK
 JBz6ojGB482Bpv/fNC+tNW6GERLhLQdhqrbiw6O1caR3BtqAczPICKurNe5O6rL/HZ
 FUt6IopzDiJkVHYutOr7djq23qxobrikHkC7isgJKE5J3++Ct2PkdVSNPAQmIHzpk9
 vAjLq0zeDPArQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: add the BO-va mapping offset when
 kmapping an IB
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808-amdgpu-fixes-v2-1-36d66398601f@outlook.com>
References: <20260808-amdgpu-fixes-v2-1-36d66398601f@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 10:23:12 +0000
Message-Id: <20260808102312.F0AE61F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces a kernel memory out-of-bounds read/write =
vulnerability on architectures where the system page size is greater than 4=
KB (e.g., 64KB on ARM64 or PPC64) due to a pre-existing shift bug.

Pre-existing issues:
- [High] The patch incompletely fixes the `mapping->offset` omission. While=
 it fixes `amdgpu_cs_patch_ibs()`, it explicitly ignores other CPU-side con=
sumers of `amdgpu_cs_find_mapping()` (VCN, UVD, and VCE) that suffer from t=
he identical bug, leaving a TOCTOU validation bypass and hardware programmi=
ng errors.
--

--- Patch [1]: [PATCH v2] drm/amdgpu: add the BO-va mapping offset when kma=
pping an IB ---
commit 38c532743ee774da4df8cab806dff666d610d7a1
Author: Junrui Luo <moonafterrain@outlook.com>

drm/amdgpu: add the BO-va mapping offset when kmapping an IB

This commit updates amdgpu_cs_patch_ibs() to add the m->offset term when
calculating the kmapped pointer. This ensures the CPU and GPU views of the
indirect buffer align when a mapping is created with a non-zero offset.

Link: https://lore.kernel.org/r/20260806-amdgpu-fixes-v1-3-ce247012d4da@out=
look.com

> Every other CPU-side consumer of amdgpu_cs_find_mapping() omits
> mapping->offset in the same way.

[Severity: High]
This is a pre-existing issue, but does vcn_v3_0_dec_msg() calculate the CPU
pointer without including map->offset?

drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:vcn_v3_0_dec_msg() {
    ...
    msg =3D ptr + addr - start;
    ...
}

Could similar regressions be present in vcn_v4_0_dec_msg(),
amdgpu_uvd_cs_pass2(), and amdgpu_vce_cs_reloc() where the physical GPU
address or CPU pointer is calculated without the mapping offset?

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 5445f75741b53..17fe6d56e0206 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1043,7 +1043,7 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_par=
ser *p,
>  		if (r)
>  			return r;
> =20
> -		kptr +=3D va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
> +		kptr +=3D m->offset + va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);

[Severity: Critical]
Can this calculation lead to an out-of-bounds access if m->offset is inflat=
ed
during a mapping split?

For example, if a pre-existing shift bug occurs on architectures with a sys=
tem
page size greater than 4KB, could adding m->offset push kptr out of bounds
before it is used?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808-amdgpu-fix=
es-v2-1-36d66398601f@outlook.com?part=3D1
