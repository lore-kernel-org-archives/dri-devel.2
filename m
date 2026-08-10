Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7829DC5B56A
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 17:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1F810E209;
	Mon, 10 Aug 2026 17:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XhUVJHeB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3B810E209
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 17:18:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E3661600C8;
 Mon, 10 Aug 2026 17:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364721F000E9;
 Mon, 10 Aug 2026 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786382299;
 bh=zgCJLzK2j5t+ZIMpgHwnjV0dS4vtc5LLT70QuK3a3g0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XhUVJHeBADd/lPKjeoaPzW1kLGBwqe6C7cyczjUH4u68QE0dyLtSZ57xZ+wSydCvn
 OzChUazPAS6rc9uORugjFXq8IBZSPDHvHWZUs9vBhz/Vx5z/xVOppHU6rfEfFboTuc
 T/vahH8A0OsauI7G0AYupfzyOR63Q/nD4VG0QovE1Y3MxRLg7rxFd9/xvhINvA0a4h
 rvz6DyBIK9N/HuitqC6yFEy7kJqbcvtn+ovWy6UPKt3QDPdNvTDAMqM3W+Qkex/Fkz
 sHJBRatEcMYsqobjQsf97Hr/Gppc7p4arLYcTcSzcSPHgljKrVoPsp85gD8lSlcw20
 5bQ4G2VN/HI0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] drm/amdgpu: skip amdgpu_gmc_flush_gpu_tlb_pasid
 if device is wedged
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810165322.24682-3-pierre-eric.pelloux-prayer@amd.com>
References: <20260810165322.24682-1-pierre-eric.pelloux-prayer@amd.com>
 <20260810165322.24682-3-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 17:18:17 +0000
Message-Id: <20260810171819.364721F000E9@smtp.kernel.org>
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
- [High] Pre-existing deadlock risk: `amdgpu_gmc_flush_gpu_tlb_pasid()` use=
s plain `spin_lock()` for `ring_lock` while KIQ accessor functions use `spi=
n_lock_irqsave()` and run in hardirq context.
--

--- Patch [3]: [PATCH v1 3/3] drm/amdgpu: skip amdgpu_gmc_flush_gpu_tlb_pas=
id if device is wedged ---
commit 24e4f92f6cbb016df09e7fbd1d0ec02c367162a1
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: skip amdgpu_gmc_flush_gpu_tlb_pasid if device is wedged

This commit skips the GPU TLB flush for a specific pasid when the device
is wedged. This avoids failing to wait for the register write, which could
fill the MES buffer and prevent a reset from succeeding.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index f43d85ba4b78b..c33320a6413e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -786,6 +786,9 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_devi=
ce *adev, uint16_t pasid,
>  	int r, cnt =3D 0;
>  	uint32_t seq;
> =20
> +	if (amdgpu_device_is_wedged(adev))
> +		return -ENODEV;
> +
>  	/*
>  	 * A GPU reset should flush all TLBs anyway, so no need to do
>  	 * this while one is ongoing.

[ ... ]

>  	} else {
>  		/* 2 dwords flush + 8 dwords fence */
>  		ndw =3D kiq->pmf->invalidate_tlbs_size + 8;
>=20
>  		if (adev->gmc.flush_tlb_needs_extra_type_2)
>  			ndw +=3D kiq->pmf->invalidate_tlbs_size;
>=20
>  		if (adev->gmc.flush_tlb_needs_extra_type_0)
>  			ndw +=3D kiq->pmf->invalidate_tlbs_size;
>=20
>  		spin_lock(&adev->gfx.kiq[inst].ring_lock);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that
amdgpu_gmc_flush_gpu_tlb_pasid() acquires the KIQ ring_lock using plain
spin_lock() here, while other KIQ accessor functions like amdgpu_kiq_wreg()
acquire it with spin_lock_irqsave() because they can run in hardirq context.

If a hardware interrupt occurs on the same CPU while this lock is held,
could an interrupt handler attempting to read or write a register using KIQ
(such as via WREG32 on an SR-IOV guest) deadlock when trying to acquire the
same ring_lock?

Does this lock acquisition need to be changed to spin_lock_irqsave()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810165322.2468=
2-1-pierre-eric.pelloux-prayer@amd.com?part=3D3
