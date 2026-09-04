Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDF5C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9961910F9E6;
	Fri,  4 Sep 2026 09:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BaNj9YUp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4108510F9E6
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:35:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2393540827;
 Fri,  4 Sep 2026 09:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE18D1F00AC4;
 Fri,  4 Sep 2026 09:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788514507;
 bh=BvxQRBqC0mriVLpuAAqPMSTpG2eZgxOT5xKqoFKwNTE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BaNj9YUpg7AgIOwTlvpN9V4eW+Ged09O8eZSCdPt0/LCjZVNHKfdkvvjQI/Ukqua8
 BlDAIPdDDQR/j09KEKq9Nm+fIt6+lWS0Ts1he6x4T8Clet7Tjsq186h0+PpsMbxZzy
 +Sb7gKfVWAfXCnR8i8UXfKpA/sLX/LFA8iDFWr0mPi93rSX60p3EnoGVu7HpTJw9z+
 zrGPXSBB6lDVOVlkg2o4mc5INptJX8YYn8xSA6oz1egZAoJOoeb2z+0skOMBQppIj1
 3Ah2Cz3Aeb3+A5fxG/yQARaxXdJHEnxpzHg/CD7CvjgDZLoqCnk9MeRlbtcGv7TJxt
 85XCsonHpZnWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: check dc_state_create_copy() for NULL
 in dm_suspend
To: "Jiangshan Yi" <yijiangshan@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904091817.578894-1-yijiangshan@kylinos.cn>
References: <20260904091817.578894-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:35:06 +0000
Message-Id: <20260904093506.CE18D1F00AC4@smtp.kernel.org>
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
- [Critical] Returning -ENOMEM from dm_suspend during a GPU reset completel=
y breaks the IP suspend/resume state machine, causing a catastrophic crash.
- [High] Early return in dm_suspend skips mandatory display hardware quiesc=
ence.
--

commit d4363889494fc230af4a110aa153d204cdd1e986
Author: Jiangshan Yi <yijiangshan@kylinos.cn>

drm/amd/display: check dc_state_create_copy() for NULL in dm_suspend

This commit adds a NULL check for dc_state_create_copy() during GPU suspend.
It returns -ENOMEM immediately if the copy fails, attempting to prevent a
NULL pointer dereference in the resume path.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

[ ... ]

> @@ -1602,9 +1602,14 @@ static int dm_suspend(struct amdgpu_ip_block *ip_b=
lock)
>  		dc_allow_idle_optimizations(adev->dm.dc, false);
> =20
>  		dm->cached_dc_state =3D dc_state_create_copy(dm->dc->current_state);
> +		if (!dm->cached_dc_state) {
> +			drm_err(adev_to_drm(adev),
> +				"Failed to allocate cached DC state during suspend\n");
> +			mutex_unlock(&dm->dc_lock);
> +			return -ENOMEM;

[Severity: High]
Does this early return skip mandatory display hardware quiescence?

By returning early, dm_suspend() bypasses calling
amdgpu_dm_commit_zero_streams() and amdgpu_dm_irq_suspend().

It looks like the display hardware might be left fully active, fetching
from VRAM and firing interrupts while the GPU reset asserts, which violates
hardware reset requirements.

[Severity: Critical]
Could returning an error here introduce a regression by breaking the IP
suspend/resume state machine?

If -ENOMEM is returned during a GPU reset, it aborts the
amdgpu_device_ip_suspend_phase1() sequence and bypasses phase 2 entirely.
Hardware reset proceeds unconditionally, wiping the ASIC state.

Because the hardware status would remain true for major IP blocks,
amdgpu_device_reinit_after_reset() might silently skip their initialization,
leading directly to a system crash upon scheduler restart.

> +		}
> =20
> -		if (dm->cached_dc_state)
> -			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
> +		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
> =20
>  		res =3D amdgpu_dm_commit_zero_streams(dm->dc);
>  		if (res !=3D DC_OK) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904091817.5788=
94-1-yijiangshan@kylinos.cn?part=3D1
