Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602B5C55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 05:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D95C10F0A8;
	Thu,  6 Aug 2026 05:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aZEJtGOP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F1D10F0A8
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 05:06:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6AD8660A80;
 Thu,  6 Aug 2026 05:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0B11F000E9;
 Thu,  6 Aug 2026 05:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785992789;
 bh=LwqG42IInCjXQtr+mvBn+K5GTgJBQfE2A1zgHP5fQS0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aZEJtGOPCSNWRSLxlCqk+ZYcHmsGQ68FdZus+eUuaBdPDi1UvmYdu1YXBn7+SGH92
 QxNVtjvFmXzqczCRHVEvhGNuwXLT1sT8rDf/c8X0d68bzasWfskJIvCXgwPpUVQoTH
 Wi5J/qzjZDT2z3ZGwxhTtU2wvEfmXH2+O2I0F3/9SO7XlaPNpFvJZwb/jjcXJwqwFQ
 wPv1RyhIUy3CqKwF5ajOJD7QRpCA/PQxHE/Z49i3zsle048SMF4QJgwOW+76QPZwvV
 4m6S1BDcoh4b/WsMVKizq763Lm9ROxEBZASPp10gnlSA6Y/sClXatn459DsshyO98i
 iYPtdZYuwDlKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/amdgpu: add the BO-va mapping offset when
 kmapping an IB
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806-amdgpu-fixes-v1-3-ce247012d4da@outlook.com>
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
 <20260806-amdgpu-fixes-v1-3-ce247012d4da@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 05:06:28 +0000
Message-Id: <20260806050628.EB0B11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete bug fix: multiple CPU-side consumers of `amdgpu_cs_find=
_mapping()` ignore `mapping->offset`, causing validation bypasses and incor=
rect hardware programming.
--

--- Patch [3]: [PATCH 3/3] drm/amdgpu: add the BO-va mapping offset when km=
apping an IB ---
commit d8bdec727584870cf6250f253ea262e5bbf96aef
Author: Junrui Luo <moonafterrain@outlook.com>

drm/amdgpu: add the BO-va mapping offset when kmapping an IB

This patch fixes the CPU-side view of indirect buffers (IBs) in
amdgpu_cs_patch_ibs(). It adds the missing mapping offset to the kmapped
pointer so it accurately reflects the bytes programmed into the page tables.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 9c514cb010966..a72cee871af3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1047,7 +1047,7 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_par=
ser *p,
>  		if (r)
>  			return r;
> =20
> -		kptr +=3D va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
> +		kptr +=3D m->offset + va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);

[Severity: High]
This is a pre-existing issue, but while this patch fixes the mapping offset
calculation here, do we need to apply the same fix to other CPU-side consum=
ers
of amdgpu_cs_find_mapping()?

The commit message notes that every other CPU-side consumer omits
mapping->offset in the same way. Does this mean they are still vulnerable to
incorrect hardware programming or validation bypasses?

For example, when calculating the physical GPU address to patch into the UVD
IB, amdgpu_uvd_cs_pass2() in drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c does n=
ot
include mapping->offset:

	addr -=3D mapping->start * AMDGPU_GPU_PAGE_SIZE;
	start +=3D addr;

Similar calculations omitting mapping->offset occur in:
- drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:amdgpu_vce_cs_reloc()
- drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:vcn_v3_0_dec_msg()
- drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:vcn_v4_0_dec_msg()
- drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c:amdgpu_dev_coredump_prin=
t_ibs()
- drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c:amdgpu_userq_fence_read_w=
ptr()

If a user submits a command stream with an IB mapped with a non-zero
offset_in_bo, could this lead to hardware hangs by bypassing VCN codec
validation, or corrupt UVD/VCE command stream physical address patching?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-amdgpu-fix=
es-v1-0-ce247012d4da@outlook.com?part=3D3
