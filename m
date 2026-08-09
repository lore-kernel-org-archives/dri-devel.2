Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04DFC5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 09:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E4610E294;
	Sun,  9 Aug 2026 09:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EmctPLPI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590FE10E294
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 09:23:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB78460008;
 Sun,  9 Aug 2026 09:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388231F000E9;
 Sun,  9 Aug 2026 09:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786267432;
 bh=J2WIlAa5WxBs7CWbjKaD823Mvlqiv5py3eU6GGo/h14=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EmctPLPIQ7aR4t4lBguBbxcnznZr3LEgOpbA3erNYlcqgHtmpAxi1EIR8QhoIl6tc
 XR935P8LJdBJjqQE/GnfcQBA8pEonl+zkIumBqWhpx9RWOkXszIpgJ/iEv0gno4GyO
 vZOONw2J7XwQ+kWjFixdc8JWz/FrTXCDutsIFInxWgTibSqSU5/cxMfhrXkWzO+ZeL
 hv6GHDCCXoxAR4QUyX5Vv9Kvjclc7hW7pvvWXKTvzDjwYS2zvXtHieDQ+wbigzO5SK
 nc5K3F43tTvNXCgN4B/sTzxV4MKTGpm0QP6r2zxzS2uVEVIkqxE0rSBfL6YCAD1tN7
 gltha/E1DiWSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] drm/amdgpu/ras: Fix delayed work cancellation
 order during teardown
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809084735.9743-7-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
 <20260809084735.9743-7-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:23:51 +0000
Message-Id: <20260809092352.388231F000E9@smtp.kernel.org>
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
- [Critical] Widened race condition allowing delayed work to be re-queued, =
leading to a Use-After-Free.
--

--- Patch [6]: [PATCH v4 6/6] drm/amdgpu/ras: Fix delayed work cancellation=
 order during teardown ---
commit 0a6b2c827639f23d781a308f6731a9c602763c4a
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

drm/amdgpu/ras: Fix delayed work cancellation order during teardown

This commit reorders the cancellation of delayed work in amdgpu_ras_fini()
and amdgpu_ras_recovery_fini(). It moves cancel_delayed_work_sync() and
cancel_work_sync() before mutex destruction and subsystem teardown to
prevent work handlers from attempting to acquire destroyed locks.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 764cd49504083..23b9844d9f1ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
[ ... ]
> @@ -4751,6 +4750,8 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
>  	if (!adev->ras_enabled || !con)
>  		return 0;
> =20
> +	cancel_delayed_work_sync(&con->ras_counte_delay_work);
> +

[Severity: Critical]
This isn't a bug introduced by this patch, but by moving this
cancel_delayed_work_sync() earlier in amdgpu_ras_fini(), does this widen a =
race
condition that could lead to a Use-After-Free?

If a userspace process calls the AMDGPU_CTX_OP_QUERY_STATE2 ioctl concurren=
tly
with device teardown, amdgpu_ctx_query2() can asynchronously re-queue the w=
ork:

drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c:amdgpu_ctx_query2() {
    ...
    schedule_delayed_work(&con->ras_counte_delay_work,
                          msecs_to_jiffies(AMDGPU_RAS_COUNTE_DELAY_MS));
    ...
}

Because the ioctl lacks drm_dev_enter() synchronization, it can re-arm the =
work
after this cancellation but before the end of amdgpu_ras_fini().

When kfree(con) is called later in amdgpu_ras_fini(), will the re-armed
ras_counte_delay_work access the freed con structure?

>  	amdgpu_ras_critical_region_fini(adev);
>  	mutex_destroy(&con->critical_region_lock);
> =20
[ ... ]
> @@ -4785,8 +4786,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
>  	if (AMDGPU_RAS_GET_FEATURES(con->features))
>  		amdgpu_ras_disable_all_features(adev, 0);
> =20
> -	cancel_delayed_work_sync(&con->ras_counte_delay_work);
> -
>  	amdgpu_ras_set_context(adev, NULL);
>  	kfree(con);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809084735.9743=
-1-sreekuttan2156239@gmail.com?part=3D6
