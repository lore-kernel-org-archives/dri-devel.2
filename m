Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60340606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUQaw9EJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A00310E143;
	Tue, 10 Nov 2026 16:23:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB4C10E143
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:23:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B1D5407A5;
 Tue, 10 Nov 2026 16:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E6B1F0089F;
 Tue, 10 Nov 2026 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794327820;
 bh=Zse2/yMHZ5fb01lPVZpfo5pfw6F+QRZDmO6Qt+aFWOc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=iUQaw9EJ9M7PUwiuE1T4PpXhbss/VBo0B0dT3djfjGjS9eyyMIfk6Mt5pFQBKM28A
 k4aUvpNBbsqHNU/z8+yQxZGPwnlGkL8RLqYA3ldl5BJ9hImy13OAcTMV6ZoYwWoSF9
 AVp2dczeZCajM4HHLZUV+tq1cbW9ub+4pgr+74Ja1Qy+mErrTyvSqqp8w4j6mcUG+q
 /bTvuBUNgrnATq71rNDBLfbhJDK6LGIEHeZskjaPZK1ErtFY5lVbF8obs+7w6neoW8
 ggbxypjpex40rn6mW9xEwMBK8PvhUlNq+urb+in7vWHR4BpEKx4avbMUfnJn9LYSqY
 ciNW3YDfwi1RA==
Message-ID: <sashiko-outbox-207361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/28] drm/panthor: Synchronize HW component PM
 transitions
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-24-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-24-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:23:39 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/panthor: missing slow-reset fallback in
  panthor_device_resume_hw_components()
--

commit b392fdf733ca625b6c9ab7dbb3e11caa5a1d1b14
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Synchronize HW component PM transitions

This commit splits hardware component suspend and resume into
panthor_device_suspend_hw_components() and
panthor_device_resume_hw_components(), serializing transitions with
ptdev->pm.hw_component_lock and ptdev->pm.hw_component_state.

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index 98c0dd3ce7bcb..2ccd8ad6318d1 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
[ ... ]
> @@ -484,21 +491,55 @@ int panthor_device_mmap_io(struct panthor_device *p=
tdev, struct vm_area_struct *
>  	return 0;
>  }
> =20
> -static int panthor_device_resume_hw_components(struct panthor_device *pt=
dev)
> +int panthor_device_suspend_hw_components(struct panthor_device *ptdev)
> +{
> +	guard(mutex)(&ptdev->pm.hw_component_lock);
> +
> +	if (atomic_read(&ptdev->pm.hw_component_state) =3D=3D
> +	    PANTHOR_DEVICE_PM_STATE_SUSPENDED)
> +		return 0;
> +
> +	if (!pm_runtime_suspended(ptdev->base.dev)) {
> +		panthor_fw_suspend(ptdev);
> +		panthor_mmu_suspend(ptdev);
> +		panthor_gpu_suspend(ptdev);
> +		panthor_pwr_suspend(ptdev);
> +	}
> +
> +	atomic_set(&ptdev->pm.hw_component_state,
> +		   PANTHOR_DEVICE_PM_STATE_SUSPENDED);
> +
> +	return 0;
> +}
> +
> +int panthor_device_resume_hw_components(struct panthor_device *ptdev)
>  {
>  	int ret;
> =20
> +	guard(mutex)(&ptdev->pm.hw_component_lock);
> +
> +	if (atomic_read(&ptdev->pm.hw_component_state) =3D=3D
> +	    PANTHOR_DEVICE_PM_STATE_ACTIVE)
> +		return 0;
> +
>  	panthor_pwr_resume(ptdev);
>  	panthor_gpu_resume(ptdev);
>  	panthor_mmu_resume(ptdev);
> =20
>  	ret =3D panthor_fw_resume(ptdev);
> -	if (!ret)
> +	if (!ret) {
> +		atomic_set(&ptdev->pm.hw_component_state,
> +			   PANTHOR_DEVICE_PM_STATE_ACTIVE);
>  		return 0;
> +	}
> =20
>  	panthor_mmu_suspend(ptdev);
>  	panthor_gpu_suspend(ptdev);
>  	panthor_pwr_suspend(ptdev);
> +
> +	atomic_set(&ptdev->pm.hw_component_state,
> +		   PANTHOR_DEVICE_PM_STATE_SUSPENDED);
> +
>  	return ret;
>  }

[Severity: Medium]
Should the ptdev->reset.pending check and the fast-to-slow reset retry live
inside panthor_device_resume_hw_components() under
ptdev->pm.hw_component_lock rather than only in panthor_device_resume()?

drivers/gpu/drm/panthor/panthor_device.c:panthor_device_resume() {
    ...
		if (atomic_read(&ptdev->reset.pending)) {
			ptdev->reset.fast =3D false;
			atomic_set(&ptdev->reset.pending, 0);
		}

		ret =3D panthor_device_resume_hw_components(ptdev);
		if (ret && ptdev->reset.fast) {
			drm_err(&ptdev->base, "Fast reset failed, trying a slow reset");
			ptdev->reset.fast =3D false;
			ret =3D panthor_device_resume_hw_components(ptdev);
		}
    ...
}

When access-window arbitration later calls
panthor_device_resume_hw_components() while runtime PM remains active,
panthor_device_resume() is not run.  A pending reset in ptdev->reset.pending
is then ignored, and a failed fast reset does not fall back to a slow reset
by reloading firmware sections, causing component resume to fail.  In
panthor_device_resume(), ptdev->reset.fast is also modified outside
ptdev->pm.hw_component_lock and the lock is dropped between the fast-reset
attempt and the slow-reset retry.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D23
