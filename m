Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E74960A3801
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwH2Vmo5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C292310E7B4;
	Tue, 10 Nov 2026 16:24:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3390210E90E
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:24:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 668EC63A3C;
 Tue, 10 Nov 2026 16:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31411F008A3;
 Tue, 10 Nov 2026 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794327892;
 bh=lDoCwoU85vkRsfBqbWzM1wE7H4dXJ93uF5+A3A+ijlo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=kwH2Vmo5M7gb3xSSWSWFxzFnNG54hSqvaBED2gczNo1sxbQ0qAXGiTwK5+II5Wzq2
 CAVtoViCXXomnQtxH6JZbmvz2eJ0EC4fV+WcJUEpSv33gtf5URxxoQDQjzci8hiDrH
 ipmmU0Z7AtiaXjd9hu6q3zOXJt0LXx5wFIlJHdIksFcF49hlJeKJ/Kg9j4jBLz5ef1
 reQYfje2Kl7XSAdyQU3ZwZDT0VToDTykhXlvVwVIvqwob7N+Gsd7mPmCgd+uKf70D1
 IU2paFMSBEObiH5st5I7jr21sG5StBV4k1YfhvavAxWQHEyA3BzvIClqHcKyY03+sS
 UFX9YbJ6L86EQ==
Message-ID: <sashiko-outbox-207364@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 24/28] drm/panthor: Quiesce scheduler tick during
 system suspend
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-25-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-25-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:24:51 +0000
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
- [Medium] drm/panthor: panthor_device_system_resume() wakes idle GPU
  via tick_work
--

commit 4eba454e973401bba31950f161b35fd4637e2ab7
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Quiesce scheduler tick during system suspend

This commit adds system suspend and resume callbacks that disable the
scheduler tick work before forced runtime suspend and re-enable it on
resume or suspend failure.

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index 2ccd8ad6318d1..ba5252c27410f 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -662,3 +662,29 @@ int panthor_device_suspend(struct device *dev)
>  	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_SUSPENDED);
>  	return 0;
>  }
> +
> +int panthor_device_system_suspend(struct device *dev)
> +{
> +	struct panthor_device *ptdev =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	panthor_sched_pre_suspend(ptdev);
> +
> +	ret =3D pm_runtime_force_suspend(dev);
> +	if (ret)
> +		panthor_sched_post_resume(ptdev);
> +
> +	return ret;
> +}
> +
> +int panthor_device_system_resume(struct device *dev)
> +{
> +	struct panthor_device *ptdev =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D pm_runtime_force_resume(dev);
> +
> +	panthor_sched_post_resume(ptdev);
> +
> +	return ret;
> +}

[ ... ]

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index a343c5180e01e..3b2ed4095f80e 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -4047,6 +4047,21 @@ void panthor_job_update_resvs(struct drm_exec *exe=
c, struct drm_sched_job *sched
>  				DMA_RESV_USAGE_BOOKKEEP, DMA_RESV_USAGE_BOOKKEEP);
>  }
> =20
> +void panthor_sched_pre_suspend(struct panthor_device *ptdev)
> +{
> +	struct panthor_scheduler *sched =3D ptdev->scheduler;
> +
> +	disable_delayed_work_sync(&sched->tick_work);
> +}
> +
> +void panthor_sched_post_resume(struct panthor_device *ptdev)
> +{
> +	struct panthor_scheduler *sched =3D ptdev->scheduler;
> +
> +	enable_delayed_work(&sched->tick_work);
> +	panthor_sched_resume(ptdev);
> +}

[Severity: Medium]
Does calling panthor_sched_resume() unconditionally in
panthor_sched_post_resume() force a runtime wakeup of an idle GPU on every
system resume?

When the GPU is already runtime-suspended before system suspend,
pm_runtime_force_resume() leaves the device in RPM_SUSPENDED without
calling panthor_device_resume().  Calling panthor_sched_resume() queues
sched->tick_work immediately, and tick_work() then calls
panthor_device_resume_and_get(), powering up the GPU and queuing a second
tick from panthor_device_resume().

In addition, if pm_runtime_force_resume() fails, queuing sched->tick_work
causes tick_work() to immediately retry panthor_device_resume_and_get() and
hit drm_WARN_ON(&ptdev->base, ret).  Since panthor_device_resume() already
calls panthor_sched_resume() when the device actually resumes, only the
pm_runtime_force_suspend() error path needs to kick the tick if the device
remained active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D24
