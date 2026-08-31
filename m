Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15034C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E2510E0A5;
	Mon, 31 Aug 2026 15:16:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UO2l57F0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7770E10E2A0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:16:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BEA1D60120
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BD11F00A3D;
 Mon, 31 Aug 2026 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788189407;
 bh=bBeRLYDPb4rcQg0WUGf64Drd3zUlco/Nzm2X7X8kJQg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UO2l57F08bCcCo35jRM6GNVrRNJtRv3HpYZgZnDWZzTknKC3jUNoK4juztjaLoB+Z
 CYJqX+qK5Zn1bk1IrVIHvI2MIsD+uTROWlsmvnFysB+NyFMTX96TaGxYl89SpIk3vO
 e2vi1ZeunjeHnus6YEZKQ73iEvsNMmqYq9JnoSc/QGxa9aXsrZLQ+D9+2Guh1+w26A
 F5Ae+YyJY8j8mXS6MQ3l2i4Nfrq8ZfTYft85qkC1usf2kg0xF3u4VGzbfhbsAKdjhM
 /HcyG64mQlEmAUhuqcHExj5hyGDxzVD6/lHmJyNR66gV7Qd2l/1Ob+86FXwp6rZINE
 OtudjjiIuovEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] drm/amd/pm/si: Don't schedule thermal
 work when queue isn't initialized
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-251-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-251-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:16:46 +0000
Message-Id: <20260831151647.48BD11F00A3D@smtp.kernel.org>
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
- [High] Scheduling an uninitialized thermal workqueue in kv_dpm_process_in=
terrupt triggers a kernel panic when amdgpu.dpm=3D0.
- [High] Scheduling an uninitialized thermal workqueue in cik_irq_process t=
riggers a kernel panic when radeon.dpm=3D0.
--

commit 8aa1c10862ca264ac27db63ef5b31d5ef1328d80
Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>

drm/amd/pm/si: Don't schedule thermal work when queue isn't initialized

When DPM is turned off with the amdgpu.dpm=3D0 module parameter, the thermal
work queue isn't initialized so we shouldn't schedule any work on it.

> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7659,7 +7659,7 @@ static int si_dpm_process_interrupt(struct amdgpu_d=
evice *adev,
>  		break;
>  	}
> =20
> -	if (queue_thermal)
> +	if (queue_thermal && amdgpu_dpm)
>  		schedule_work(&adev->pm.dpm.thermal.work);

[Severity: High]
This is a pre-existing issue, and not a bug introduced by this patch, but
does the same uninitialized workqueue crash also happen in kv_dpm.c?

Looking at kv_dpm_process_interrupt() in
drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c, it still has the unguarded
schedule_work call:

    if (queue_thermal)
        schedule_work(&adev->pm.dpm.thermal.work);

And similar to the issue you fixed in si_dpm.c, kv_dpm_sw_init() skips the
INIT_WORK call when DPM is disabled:

    if (amdgpu_dpm =3D=3D 0)
        return 0;

    INIT_WORK(&adev->pm.dpm.thermal.work, amdgpu_dpm_thermal_work_handler);

If a thermal interrupt fires on KV/CI hardware while booted with
amdgpu.dpm=3D0, wouldn't this queue a zero-initialized work struct and atte=
mpt
to execute a NULL function pointer? Should the same amdgpu_dpm guard be
added to kv_dpm_process_interrupt()?


[Severity: High]
This is also a pre-existing issue, but it looks like the radeon driver
might share the exact same vulnerability in cik.c.

In drivers/gpu/drm/radeon/radeon_pm.c, radeon_pm_init() skips INIT_WORK
when DPM is disabled, falling back to the old method:

    if (rdev->pm.pm_method =3D=3D PM_METHOD_DPM)
        return radeon_pm_init_dpm(rdev);
    else
        return radeon_pm_init_old(rdev);

But cik_irq_process() in drivers/gpu/drm/radeon/cik.c unconditionally
schedules the work if a thermal interrupt arrives:

    if (queue_thermal)
        schedule_work(&rdev->pm.dpm.thermal.work);

If a user boots with radeon.dpm=3D0 on CIK hardware and a thermal interrupt
triggers, could this result in the same workqueue panic? Does
cik_irq_process() need a rdev->pm.dpm_enabled guard added to its
schedule_work call?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-251-sashal@kernel.org?part=3D1
