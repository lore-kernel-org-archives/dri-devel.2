Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D85CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B13910EFD1;
	Wed, 17 Jun 2026 13:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CLGRGX9e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72AD410EFD1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 13:52:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3478D4031C;
 Wed, 17 Jun 2026 13:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCFC1F000E9;
 Wed, 17 Jun 2026 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781704376;
 bh=pbFPA3JLigRNAzxjrBN5Pf5fFUMjOxgowA5SyQ/pspY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CLGRGX9en9zcUdzxa4Po0IpLdz6PW+uXKn+3pl/A/wFCDPREUW73eXQnHGp+cq3n8
 HpoW5SRX18/XFV+h0GlzldHYvaWTBWkDnfcISQRQq1L1bp+o8HYkjTNFMJ7CQP8rZf
 ZquMIBRGdmaF0sFfXJVyjCsNFWR2xIcvyxIuqj4ck/7Z5Qj0af64XOwWncrvsVCahH
 esg1X27ajygnPrFHTdgoUwHqrhVL8VHASptMUVdYbbf9sNeEVvyzL0eAdXNRRsG2Rh
 gQWpi4gtSnDg1Kn1SCR1dcxxKjBxfQnX/bgAptH7uoIUzNTOpY+k9zzdrxpcF31ax0
 TcaclqbRKqn8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/amdgpu: delay ttm buffer func enablement on
 xgmi
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617132835.12306-2-pierre-eric.pelloux-prayer@amd.com>
References: <20260617132835.12306-1-pierre-eric.pelloux-prayer@amd.com>
 <20260617132835.12306-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 13:52:55 +0000
Message-Id: <20260617135255.EDCFC1F000E9@smtp.kernel.org>
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
- [High] The relocated call to amdgpu_ttm_enable_buffer_funcs() silently fa=
ils due to the amdgpu_in_reset() guard, leaving TTM DMA permanently disable=
d.
--

commit 61a1713a716e72510eef36a97d31d040637c47f6
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: delay ttm buffer func enablement on xgmi

When amdgpu_init_minimal_xgmi is used, SDMA engines init is delayed so
amdgpu_ttm_enable_buffer_funcs must be called later. This commit moves
the call into amdgpu_device_reinit_after_reset to avoid initialization
failures.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 57e10afb4714d..53150fe553508 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
[ ... ]
> @@ -5320,6 +5319,8 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_=
reset_context *reset_context)
>  				r =3D -EAGAIN;
>  				goto end;
>  			}
> +
> +			amdgpu_ttm_enable_buffer_funcs(tmp_adev);

[Severity: High]
This isn't a bug introduced by this patch, but doesn't this relocated call
silently fail due to the amdgpu_in_reset() guard?

Because amdgpu_device_reinit_after_reset() executes within a hardware reset
context, the in_gpu_reset flag is set. Looking at
amdgpu_ttm_enable_buffer_funcs() in drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c,
there is an early return guard for this:

	if (!adev->mman.initialized || amdgpu_in_reset(adev) ||
	    adev->mman.buffer_funcs_enabled || adev->gmc.is_app_apu)
		return;

Will this cause the function to silently abort, leaving TTM DMA permanently
disabled and forcing all VRAM migrations to fallback to slow CPU copies?

Also, by placing the call at the very end of amdgpu_device_reinit_after_res=
et(),
it executes after drm_client_dev_resume(). Would any VRAM migrations trigge=
red
by fbdev restore run without hardware DMA even if the early return was bypa=
ssed?

>  		}
> =20
>  		if (r)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617132835.1230=
6-1-pierre-eric.pelloux-prayer@amd.com?part=3D2
