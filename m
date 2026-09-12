Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BB9C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 15:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0403910E00E;
	Sat, 12 Sep 2026 15:21:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XIsLR96/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280E810E00E
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:21:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4101419F7;
 Sat, 12 Sep 2026 15:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEF21F000FF;
 Sat, 12 Sep 2026 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789226499;
 bh=tfUwPQv4Rl9+ZbA8fgmfBvtRPXMTVr7OxbvEe6JN5H0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XIsLR96/YjrSrWphnjlULFWv8cOgG6Inn9ZN+aropIIpRXsJt/Q9sA0UmIacS9UUN
 JkWYJjHbPSMFya8X40EuLqiaq/FAp7PMR0ht+v4maCFzTW/WVZQcaErD+U2LO/3Afs
 +rsjVjBhlkPv0ci9SyEMdw5NuzQawJOqGEFZYBZryAcd4EAJVQXNnqRA6S6V0QVJkI
 6OVs6fBbItMWjk5FXqTZLRa6DFWsykPhPhESTegXSZ0kSjxOY0u50H3DdM2byjWD2S
 PnOWxdEm3mY4r/3IJCfAhqRCC9iS/ByYvfXqj3rjQTI7YZXttY1E3OkSdjJ6zsr0MF
 IueAcp7CZZvHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/a6xx+: Increase GMU FW init timeout
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912150915.28700-1-robin.clark@oss.qualcomm.com>
References: <20260912150915.28700-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 15:21:39 +0000
Message-Id: <20260912152139.7CEF21F000FF@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unbalanced GPU RSC state machine on GMU firmware initialization fa=
ilure paths.
- [High] Missing error check for pm_runtime_get_sync() in a6xx_gmu_resume().
--

commit cd0bcd058768ca73ba4d2dc9f94b51c0f5269a1d
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a6xx+: Increase GMU FW init timeout

This commit increases the GMU firmware initialization timeout from 10ms to
100ms. This matches the timeout used by the kgsl driver and prevents
sporadic initialization failures.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.c
> index 27cac853975f9..6d49c51df1a27 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -320,7 +320,7 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
>  	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 0);
> =20
>  	ret =3D gmu_poll_timeout(gmu, REG_A6XX_GMU_CM3_FW_INIT_RESULT, val,
> -		(val & mask) =3D=3D reset_val, 100, 10000);
> +		(val & mask) =3D=3D reset_val, 100, 100000);
> =20
>  	if (ret)
>  		DRM_DEV_ERROR(gmu->dev, "GMU firmware initialization timed out\n");

[Severity: High]
This is a pre-existing issue, but can the GPU RSC remain implicitly started
if firmware loading fails here?

Looking at a6xx_gmu_fw_start(), if a6xx_gmu_fw_load() fails, it returns an
error before GMU_STATUS_FW_START is set:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_fw_start() {
    ...
	ret =3D a6xx_rpmh_start(gmu);
	if (ret)
		return ret;

	if (state =3D=3D GMU_COLD_BOOT) {
		if (WARN(!adreno_gpu->fw[ADRENO_FW_GMU],
			"GMU firmware is not loaded\n"))
			return -ENOENT;

		ret =3D a6xx_gmu_fw_load(gmu);
		if (ret)
			return ret;
	}
    ...
}

In the error path, does a6xx_rpmh_stop() abort early because
GMU_STATUS_FW_START is unset?

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_rpmh_stop() {
    ...
	if (!test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
		return;
    ...
}

If the driver skips the RSC initialization sequence on the next resume atte=
mpt
because GMU_STATUS_PDC_SLEEP remains cleared, could this leave the hardware
uninitialized and cause subsequent operations to hang?

[Severity: High]
This isn't a bug introduced by this patch, but does this code ignore the
return value of pm_runtime_get_sync()?

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_resume() {
    ...
	pm_runtime_get_sync(gmu->dev);

	a6xx_gmu_gxpd_get(gmu);
    ...
}

If pm_runtime_get_sync() fails and returns a negative error code, could
proceeding to interact with the GMU clocks and registers via
a6xx_gmu_gxpd_get() lead to a bus stall or system crash because the PM doma=
in
is inaccessible?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912150915.2870=
0-1-robin.clark@oss.qualcomm.com?part=3D1
