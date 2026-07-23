Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E897C4453F
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D430810EF6B;
	Thu, 23 Jul 2026 02:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mGBaOVdb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163F810EF6D
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:03:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4CE05600AD;
 Thu, 23 Jul 2026 02:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF97A1F000E9;
 Thu, 23 Jul 2026 02:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784772185;
 bh=tpauiiPUueKHKs2jaAHxd/SC/g+2YquzRZWvYH4dXI8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mGBaOVdbtyR79J1B1XMbPitTzPrIQbhiUV1xZQ2D4s5F0cexP0YTWxmeVgMfID4hO
 slvKPiqWQu7lGYrQZw0iMYsxGmq9D4Tb44CBb3QhL0pwlQu/tHHTwP1R+DklDUKQcu
 r67rGxTYaDkF6aYF0kl728+NWtTohP0JyCLwt0/YTknsKHv9TTMFyDjlbR3Js6jUG3
 F3j1nDL0/5DC+Jxt0OKq2YIuFayGU1xfNtIBHQWj7oOArUxuEhSfapQvCeB7YTXY7z
 fsAt8ao6Bo2HDKL3JrzfH45HSgOFcO2NkHk+7QpG2sC2ukykPBh+bBbGny70HWa7SB
 0/B9v5CtYKNUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: fix wrong plane_count check in
 dm_gpureset_toggle_interrupts()
To: yaolu@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723015503.32122-1-yaolu@kylinos.cn>
References: <20260723015503.32122-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 02:03:04 +0000
Message-Id: <20260723020304.CF97A1F000E9@smtp.kernel.org>
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
- [High] The patch introduces a critical boolean logic error in `dm_gpurese=
t_toggle_interrupts` that breaks DCN interrupt toggling during GPU reset.
--

--- Patch [1]: [PATCH] drm/amd/display: fix wrong plane_count check in dm_g=
pureset_toggle_interrupts() ---
commit 019af4e190dd8d0cacc73ad6b2cdd860d90cbb1b
Author: Lu Yao <yaolu@kylinos.cn>
drm/amd/display: fix wrong plane_count check in dm_gpureset_toggle_interrup=
ts()

The else-if branch in dm_gpureset_toggle_interrupts() condition was incorre=
ctly
checking plane_count !=3D 0, which the author states is the same as the
preceding if-branch and can never be true in the else path.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f8d8132ea50ed..e3d490d27171f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1587,7 +1587,7 @@ static void dm_gpureset_toggle_interrupts(struct am=
dgpu_device *adev,
>  			if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
>  				drm_warn(adev_to_drm(adev), "Failed to %sable vblank interrupt\n", e=
nable ? "en" : "dis");
> =20
> -		} else if (acrtc && state->stream_status[i].plane_count !=3D 0) {
> +		} else if (acrtc && state->stream_status[i].plane_count =3D=3D 0) {

[Severity: High]
Does this change unintentionally break interrupt toggling for DCN hardware?

The commit message states that the preceding if-branch already checks for
plane_count !=3D 0, making it impossible to be true here. However, looking =
at
the preceding if-condition in dm_gpureset_toggle_interrupts():

		if (acrtc && state->stream_status[i].plane_count !=3D 0 &&
		    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D 0) {

The if-branch also requires amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D 0. =
For
DCN hardware, this IP version check evaluates to false, which causes the
execution to fall through to this else-if branch even when plane_count !=3D=
 0.

With this patch changing the check to plane_count =3D=3D 0, won't DCN strea=
ms
with active planes incorrectly skip toggling VUPDATE_NO_LOCK during a GPU
reset?

>  			/* DCN only needs to toggle VUPDATE_NO_LOCK */
>  			rc =3D amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, enable);
>  			if (rc)
>  				drm_warn(adev_to_drm(adev), "Failed to %sable vupdate interrupt\n",
>  					 enable ? "en" : "dis");
>  		}
>  	}
> =20
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723015503.3212=
2-1-yaolu@kylinos.cn?part=3D1
