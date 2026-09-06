Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07A5C79F8C
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 03:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADAE710E01F;
	Sun,  6 Sep 2026 03:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XMYB6DyG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B2810E01F
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 03:25:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4853A432AB;
 Sun,  6 Sep 2026 03:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D481F00A3A;
 Sun,  6 Sep 2026 03:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788665114;
 bh=FmkQ+vIV1sbfrHW9jAKOFBYXD3B+6bvRI7qW59SemXI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XMYB6DyGYOqMmaXaO/3CvI686lWVqlE3CCdhuBjUiMTBEixXe1ImAf8R9x/GnvoRk
 d2r+Gq4alRHzBtSV7HzuTKb+9MFy8YSUxVwttT2xPv+rjCh/iCI324G3WfyN6Gd5pE
 LiFYnIb/tJuK5p74EmcYAYBYBgxj+z41Ayf5fyJ/H+UaJp2Ts1Z+h90CG31dw6wi87
 g5bWmwuBDVgqw2+eWLIPaIGsUpH3TIxoDZr8vDr2H7ZW9AGDY3DKz88DOLUp6zjWhd
 cfuYqviwmapjo31kzMR7sImFLWPL0C4Exkj/JB888bGwgrPnIa+GhoS/SZsOIKuxYt
 PUQUfvkQTnlFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: only treat a real S3 as a suspend abort on
 resume
To: willy@willyv3.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <010001a074b60857-4cb0239e-c529-4069-ba4e-e347cfe379a4-000000@email.amazonses.com>
References: <010001a074b60857-4cb0239e-c529-4069-ba4e-e347cfe379a4-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 03:25:13 +0000
Message-Id: <20260906032513.F3D481F00A3A@smtp.kernel.org>
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
- [High] The fix for spurious dGPU resets on s2idle resume is incomplete, l=
eaving identically flawed logic in soc21.c and soc24.c.
--

commit 5105966b236eb1d3339925f9a22bee109b13037a
Author: Willy VanSickle <vansicklewilly@gmail.com>

drm/amdgpu: only treat a real S3 as a suspend abort on resume

This commit fixes a spurious mode1 reset issue on dGPUs resuming from
s2idle. It updates soc15_need_reset_on_resume() to verify that the
suspend state was actually PM_SUSPEND_MEM and not resumed via firmware.

> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index 3d4573d937422..bec63957f3221 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -592,7 +592,12 @@ static bool soc15_need_reset_on_resume(struct amdgpu=
_device *adev)
>  	 * 1) S3 suspend aborted in the normal S3 suspend
>  	 * 2) S3 suspend aborted in performing pm core test.
>  	 */
> -	if (adev->in_s3 && !pm_resume_via_firmware())
> +	/* Only a real S3 (mem) that firmware did not resume is an abort.
> +	 * s2idle never resumes via firmware, so without this gate every
> +	 * s2idle resume of a dGPU is misread as an abort and mode1-reset.
> +	 */
> +	if (adev->in_s3 && !pm_resume_via_firmware() &&
> +	    adev->last_suspend_state =3D=3D PM_SUSPEND_MEM)
>  		return true;
>  	else
>  		return false;

[Severity: High]
This is a pre-existing issue, but does this incomplete fix leave the same
spurious reset bug in soc21.c and soc24.c?

Looking at drivers/gpu/drm/amd/amdgpu/soc21.c in
soc21_need_reset_on_resume():

	if (!(adev->flags & AMD_IS_APU) && adev->in_s3) {
		sol_reg1 =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
		msleep(100);
		sol_reg2 =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);

		return (sol_reg1 !=3D sol_reg2);
	}

And identically in drivers/gpu/drm/amd/amdgpu/soc24.c in
soc24_need_reset_on_resume():

	if (!(adev->flags & AMD_IS_APU) && adev->in_s3) {
		sol_reg1 =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81);
		msleep(100);
		sol_reg2 =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81);

		return (sol_reg1 !=3D sol_reg2);
	}

It appears adev->in_s3 will incorrectly evaluate to true on s2idle resumes
for dGPUs here as well, causing an unnecessary 100ms delay and a subsequent
spurious ASIC reset. Should the PM_SUSPEND_MEM and pm_resume_via_firmware()
checks be applied to these files too?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/010001a074b60857-4c=
b0239e-c529-4069-ba4e-e347cfe379a4-000000@email.amazonses.com?part=3D1
