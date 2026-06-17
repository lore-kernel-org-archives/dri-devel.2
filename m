Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC38CD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C69F10EE24;
	Wed, 17 Jun 2026 06:45:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q1T18Ax8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3BDB10EE54
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 06:45:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 76D89444E2;
 Wed, 17 Jun 2026 06:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF2D1F000E9;
 Wed, 17 Jun 2026 06:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781678703;
 bh=TWvh/izarUXq73Rdi1mwXUtafLnHlMF7oyE1K6r6HjQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q1T18Ax8SmnEIB2h1SoKpd++979lGk6fu9ci5sbcYEgcwdomM15isJXD2r30utCcB
 I9OzeqcAivwcuxFwtFSiEDrZ9MzN4M4tmo/d2jnbJ3MBu4O4Pm3dwLcjG1wTb4Rhu7
 veigPE0tJ53DskmOV8z9ZRTZAaHkACcfJp6nluzjgvrDZ7KWCn6+Ak36YQOfVj9Dxu
 HXwW5rkFYvOihfuanYgSYmCOes8UA9Ym5iblKt+kgbfIlGUasgaWegykKz1OhHKrki
 ioDMUPk/Tg1NZr/kPRpTyKULrf6f3BeSDgdayVvyx4I1NiAT9HmudJ3WhDBRuf8EO4
 /QoWltg9RF+Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu/soc24: reset dGPU if suspend got aborted
To: "Jakob Linke" <jakob@linke.cx>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617062415.19898-1-jakob@linke.cx>
References: <20260617062415.19898-1-jakob@linke.cx>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 06:45:02 +0000
Message-Id: <20260617064503.3BF2D1F000E9@smtp.kernel.org>
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
- [Medium] Unconditional 100ms delay added to all normal S3 resumes due to =
a missing suspend-abort check.
- [Medium] Flawed condition or contradictory documentation for detecting su=
spend abort.
--

commit f65d16d9bd092a9093fda22e85afb7762ebbe6a5
Author: Jakob Linke <jakob@linke.cx>

drm/amdgpu/soc24: reset dGPU if suspend got aborted

For SOC24 ASICs (RDNA4 / Navi 4x dGPUs) re-enabling PM features fails if an
S3 suspend got aborted. Apply the same workaround as soc15 and soc21 to
detect the aborted-suspend state and reset the device before re-init.

> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amd=
gpu/soc24.c
> index 265db9331d0bb..9dce30d2bb8d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
[ ... ]
> @@ -496,8 +496,36 @@ static int soc24_common_suspend(struct amdgpu_ip_blo=
ck *ip_block)
>  	return soc24_common_hw_fini(ip_block);
>  }
> =20
> +static bool soc24_need_reset_on_resume(struct amdgpu_device *adev)
> +{
> +	u32 sol_reg1, sol_reg2;
> +
> +	/* Will reset for the following suspend abort cases.
> +	 * 1) Only reset dGPU side.
> +	 * 2) S3 suspend got aborted and TOS is active.
> +	 *    As for dGPU suspend abort cases the SOL value
> +	 *    will be kept as zero at this resume point.
> +	 */
> +	if (!(adev->flags & AMD_IS_APU) && adev->in_s3) {
> +		sol_reg1 =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81);
> +		msleep(100);

[Severity: Medium]
Does this add an unconditional 100ms delay to all S3 resumes?

Since adev->in_s3 is true during all S3 resumes, not just aborted ones, this
path seems to execute and sleep every time the system normally wakes up.

Could this use a fast-path check, like skipping the sleep if sol_reg1 is
non-zero, or perhaps checking !pm_resume_via_firmware() similar to what the
soc15 workaround does?

> +		sol_reg2 =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81);
> +
> +		return (sol_reg1 !=3D sol_reg2);

[Severity: Medium]
Is the block comment above accurate about the SOL value behavior?

The comment states that for dGPU suspend abort cases, the SOL value will be
kept as zero at this resume point. If both sol_reg1 and sol_reg2 read as ze=
ro,
the condition (0 !=3D 0) will evaluate to false, and the reset will not be
triggered.

If the SOL registers stay zero during an abort, does this logic actually fa=
il
to detect the abort case entirely?

> +	}
> +
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617062415.1989=
8-1-jakob@linke.cx?part=3D1
