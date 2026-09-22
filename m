Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340D8C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C9A910E00C;
	Tue, 22 Sep 2026 21:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OkuXBMos";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F67E10E00C
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:12:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DC4D601F1;
 Tue, 22 Sep 2026 21:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039B51F00893;
 Tue, 22 Sep 2026 21:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790111565;
 bh=WlFXFjbTLcZpTmWgFz3WDFRUYuOSY94hjkqsKSon8qc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OkuXBMospK6Vy7zLn30pG1151C2z8mdxVAgnTjCH03V6wq/eewotEW83bVFP7NGIY
 VWhq80eH9+oV+ageHCYcAtEjurva4foOfEqI4HkYTJX9YeUT/0CiinHGPzfq92sD7K
 aOga5Emc6qrn4nz7Jk5SkCZuDMt3m3Hum7QZ25vk0Gfvgo0dJZadZ1VS9sAPCgvf72
 pD8sKXaVsGiAqsbpWYTnxKewshpdOq9eenBLgjO/lj6Do3jOXfek6r5N0MM1GQB09F
 DRIOke9OoQarPgq88vWi9Utq4Nl5RqAcuqgj4J85rAbAN5egB/a6balvsQheEqZBmR
 43nvRT2cWkSLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 26/27] drm/panthor: Prevent missed post-yield cleanup
 due to reset
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-27-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-27-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:12:44 +0000
Message-Id: <20260922211245.039B51F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm: scheduler deadlock on reset due to missed post-reset hooks
- [High] drm: failed reset bypasses device unplug due to AW state transition
- [High] drm: TOCTOU race in reset causes invalid MMIO access
--

commit c5cc732c23a490baff27bd3657a378e7ad65a4e4
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Prevent missed post-yield cleanup due to reset

With v15 GPUs, FW can yield GPU access at any point. This commit introduces
pre_reset and post_reset helpers for panthor_aw which marks a granted AW as
reset-active, aiming to prevent a race condition between reset and FW yield
from suppressing post-yield cleanup.

> diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panth=
or/panthor_aw.c
> index 9ebb23eadfec5..7ef13db4acf50 100644
> --- a/drivers/gpu/drm/panthor/panthor_aw.c
> +++ b/drivers/gpu/drm/panthor/panthor_aw.c
[ ... ]
> @@ -579,5 +588,36 @@ bool panthor_aw_has_gpu_access(struct panthor_device=
 *ptdev)
[ ... ]
> +void panthor_aw_pre_reset(struct panthor_device *ptdev)
> +{
> +	struct panthor_aw *aw =3D ptdev->aw;
> +
> +	if (!aw)
> +		return;
> +
> +	panthor_aw_state_try_set(ptdev->aw, PANTHOR_AW_STATE_GPU_GRANTED,
> +				 PANTHOR_AW_STATE_RESET_ACTIVE);
> +}
> +
> +void panthor_aw_post_reset(struct panthor_device *ptdev)
> +{
> +	struct panthor_aw *aw =3D ptdev->aw;
> +
> +	if (!aw)
> +		return;
> +
> +	panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_RESET_ACTIVE,
> +				 PANTHOR_AW_STATE_GPU_GRANTED);
> +
> +	if (!panthor_aw_is_open(aw))
> +		panthor_aw_schedule_post_yield_work(aw);
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index ea35c5e1d87b4..86eb4e9a61789 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -138,18 +138,27 @@ static void panthor_device_reset_work(struct work_s=
truct *work)
>  	if (!drm_dev_enter(&ptdev->base, &cookie))
>  		return;
> =20
> +	if (!panthor_aw_has_gpu_access(ptdev))
> +		goto out_clear_pending;

[Severity: High]
If a GPU reset is scheduled (e.g., due to a job timeout), and just before
panthor_device_reset_work() runs, the firmware yields the GPU, this check
returns false and causes a jump to out_clear_pending.

Since out_clear_pending clears the reset.pending flag but skips calling
panthor_sched_post_reset(), does this leave the scheduler's tick work and
firmware watchdog permanently deadlocked, causing all jobs to hang forever
without recovery?

Additionally, does this introduce a Time-Of-Check to Time-Of-Use (TOCTOU)
race condition?

If an IRQ fires after panthor_aw_has_gpu_access(ptdev) is checked but before
panthor_aw_pre_reset(ptdev) is called, changing the state to STOPPED_IDLE,
panthor_aw_pre_reset() will silently fail to update the state since it
ignores the return value of panthor_aw_state_try_set().

Will this allow the reset sequence to continue against unpowered MMIO,
leading to bus faults because GPU access has been revoked?

> +
>  	panthor_sched_pre_reset(ptdev);
> +	panthor_aw_pre_reset(ptdev);
>  	panthor_fw_pre_reset(ptdev, true);
>  	panthor_mmu_pre_reset(ptdev);
> +
>  	panthor_hw_soft_reset(ptdev);
> +
>  	panthor_hw_l2_power_on(ptdev);
>  	panthor_mmu_post_reset(ptdev);
>  	ret =3D panthor_fw_post_reset(ptdev);
> -	atomic_set(&ptdev->reset.pending, 0);
> +	panthor_aw_post_reset(ptdev);
>  	panthor_sched_post_reset(ptdev, ret !=3D 0);
> +
> +out_clear_pending:
> +	atomic_set(&ptdev->reset.pending, 0);
>  	drm_dev_exit(cookie);
> =20
> -	if (ret) {
> +	if (ret && panthor_aw_has_gpu_access(ptdev)) {

[Severity: High]
If the MCU fails to boot during reset, panthor_fw_post_reset() will return =
an
error. Then panthor_aw_post_reset() executes and, seeing the window is not
open, calls panthor_aw_schedule_post_yield_work() which transitions the AW
state to PANTHOR_AW_STATE_GPU_STOPPED.

Since the state is now GPU_STOPPED, panthor_aw_has_gpu_access() will evalua=
te
to false. Will this completely bypass the device unplug operation, leaving a
broken device registered and accessible?

>  		panthor_device_unplug(ptdev);
>  		drm_err(&ptdev->base, "Failed to boot MCU after reset, making device u=
nusable.");
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D26
