Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305B6CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB1010F643;
	Thu,  8 Oct 2026 16:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UY3I3LNn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A87210F60D
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 16:23:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF25243D53;
 Thu,  8 Oct 2026 16:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84041F000FF;
 Thu,  8 Oct 2026 16:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791476580;
 bh=9oSuqeldjjstv5miPomyZRVF0/yE0PomWaLdPNdlZnA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UY3I3LNnZZy+/LvhKHEFmdSVQxz+bbbk7A8XIFYXjl0DPAhCka/l6a5aiNbKGnZvY
 UFpSy3Wivrjj4e7UpP3npR3OcMPixoqNdUcOFHRMKYscolJC1O1SJSMCT6TEsnK3uu
 lBlxGt5Smj8qLY69PXtzxNx+GnWeSayy83fKtagi/EhzXXKv0e8s1kHR7vTIvdGCYT
 nLLcL7TST2gNQkjceTLt4rNx9CYluitxzcTS8du9WxAKrQ9r+E7nKlEPtOftMlDtl8
 rFrUkjPvrSg5iIEQxeaNNQRvgJIAi3izRPupeocW/v2O3B4Z6UEvAoYZuKZpRyaInh
 w6twwbDxpjdtA==
Message-ID: <sashiko-outbox-164377@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix NULL RAS context dereference in UMC
 page retirement
To: "Haotian Zhang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008161144.2671028-1-vulab@iscas.ac.cn>
References: <20261008161144.2671028-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 16:23:00 +0000
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
- [High] amdgpu: KFD queue permanently hung when RAS is disabled due to byp=
assed GPU reset
--

commit 8cb95b8549bf147ff94f08bcdd4e5a3aaa6812ae
Author: Haotian Zhang <vulab@iscas.ac.cn>

drm/amdgpu: fix NULL RAS context dereference in UMC page retirement

amdgpu_umc_handle_bad_pages() and amdgpu_umc_do_page_retirement() take the
RAS context from amdgpu_ras_get_context() and dereference it without
checking for NULL.  That context is NULL whenever RAS is disabled.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_umc.c
> index 34702e5cb1b6c..283180e3f2db2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
[ ... ]
> @@ -217,6 +221,9 @@ static int amdgpu_umc_do_page_retirement(struct amdgp=
u_device *adev,
>  	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
>  	amdgpu_umc_handle_bad_pages(adev, ras_error_status);
> =20
> +	if (!con)
> +		return AMDGPU_RAS_SUCCESS;
> +

[Severity: High]
Does this early return ignore the reset parameter requested by the caller?

When KFD encounters a poison consumption error and requests a fallback GPU
reset by passing a non-zero reset flag, returning AMDGPU_RAS_SUCCESS here
without handling the reset leaves the KFD queue permanently hung.

This leaves the hardware in an unrecoverable state until the next system
reboot.

Should this trigger a generic GPU reset via amdgpu_device_gpu_recover()
when the context is NULL?

Also, is there a similar regression in amdgpu_umc_pasid_poison_handler()?

	if (adev->gmc.xgmi.connected_to_cpu ||
		adev->gmc.is_app_apu) {
		if (reset) {
			/* MCA poison handler is only responsible for GPU reset,
			 * let MCA notifier do page retirement.
			 */
			kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
			amdgpu_ras_reset_gpu(adev);
		}
		return ret;
	}

If reset is requested and xgmi.connected_to_cpu is true, this unconditional=
ly
calls amdgpu_ras_reset_gpu().

Can this still trigger a NULL pointer dereference inside amdgpu_ras_reset_g=
pu()
when RAS is disabled?

>  	if ((err_data->ue_count || err_data->de_count) &&
>  	    (reset || amdgpu_ras_is_rma(adev))) {
>  		con->gpu_reset_flags |=3D reset;
>  		amdgpu_ras_reset_gpu(adev);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008161144.2671=
028-1-vulab@iscas.ac.cn?part=3D1
