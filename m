Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D2AC982D8
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 19:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A504410E08C;
	Sat, 19 Sep 2026 19:23:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IQLnRgS6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA7010E08C
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 19:23:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 457E6601FB;
 Sat, 19 Sep 2026 19:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E6A1F000FF;
 Sat, 19 Sep 2026 19:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789845829;
 bh=jLWSy11U1LAq7//9T0Ua006MS1cyPehi/CXEKs7oUgc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IQLnRgS67JAYfs5niOHBidtbfSg3JW9hcvAzYbz1MXYwx1vauRgEZ3ttFETz4kem0
 5BP8vh+Tf/jK2i/VcITIadBXa8M22A8V7Debv80e7mvfDkyChJ39Im0w8lcoLhV2ei
 ApVfVsQfevMXc7ZLMEEiiqyef+erGT+HjPPs7iOy2rU3V/f/guvPw7iVXPawAUkmUl
 /l6B1BLevXmu/7jo69l4ETyaHBviRp9pjJXe3c8X5KhaE8qQ2GNnVPTbFI1r+S4X0Y
 FXQIoFXeZQCi4qwc7hWB9ZEdHZcqSnmi3i9Pag+bxoBQ55FsCeFFxhWVWgiGhvyet6
 +bMRZSpr0g9fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: replace kcalloc() with kzalloc_objs()
To: "Lalit Shankar Chowdhury" <lalitshankarch@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260919191432.99342-1-lalitshankarch@gmail.com>
References: <20260919191432.99342-1-lalitshankarch@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 19:23:48 +0000
Message-Id: <20260919192348.D0E6A1F000FF@smtp.kernel.org>
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
- [Low] drm/amdgpu: incomplete refactoring, kcalloc still used for identica=
l buffers
--

commit 8b9c2e12d9fb1d601e7dde3709be635bf6ad1f1b
Author: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: drm/amdgpu: replace kcalloc() with kzalloc_objs()

This commit replaces kcalloc() with kzalloc_objs() across several files
in the AMDGPU driver to simplify object allocations. The commit message
states that it is a non-functional change.

> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 72fd3022b6062..76793a5caa701 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
[ ... ]
> @@ -202,7 +202,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>  	r =3D jpeg_v1_0_sw_init(ip_block);
> =20
>  	/* Allocate memory for VCN IP Dump buffer */
> -	ptr =3D kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), G=
FP_KERNEL);
> +	ptr =3D kzalloc_objs(*ptr, adev->vcn.num_vcn_inst * reg_count);

[Severity: Low]
Could we also update the identical IP dump buffer allocation in
amdgpu_vcn_reg_dump_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c?

It looks like the refactoring might be incomplete. While this file and
others (jpeg, sdma, gfx) were successfully updated to use kzalloc_objs(),
several other instances using kcalloc() for identical buffer types were mis=
sed.

For example:

drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:amdgpu_vcn_reg_dump_init() {
    ...
	adev->vcn.ip_dump =3D kcalloc(adev->vcn.num_vcn_inst * count,
				     sizeof(uint32_t), GFP_KERNEL);
    ...
}

Other files that still use kcalloc() include amdgpu_ras.c,
amdgpu_ras_eeprom.c, and atom.c. Does it make sense to update these
as well to ensure the memory allocation API remains consistent across
the subsystem?

>  	if (!ptr) {
>  		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
>  		adev->vcn.ip_dump =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919191432.9934=
2-1-lalitshankarch@gmail.com?part=3D1
