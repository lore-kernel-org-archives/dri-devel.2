Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB80C606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEFTbln5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D6210E1F8;
	Sun,  1 Nov 2026 08:46:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1CF110E1F8
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 08:46:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 71B0343C4B;
 Sun,  1 Nov 2026 08:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1138F1F000C1;
 Sun,  1 Nov 2026 08:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793522762;
 bh=qtdKx141v8KBlJu41Rw7tDYEQBgZ0gP3sm2y+3yt0g4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PEFTbln58H7hkr3oRZ3hA4gbut5usSQvg5vdnSkrFmofQ/Ea4aeor0WPDJNKyUDIr
 DBexHuUsuFwwDKRcos2uXHwZjGwfS42MzvkoUCrVDHgm11K37FOXcus+wBP4b53EFR
 UU9Qh4AKsdpezNOgR9XUwJXUP9lW8W4ak0yaJhqw1e5jTvrHY8nYpmbn6IXZCtAasZ
 ajv8VELb2JlU+wICJoO7xq1Jk+VfFQK6Auv2Fo5YNZVPYwxgpRuxLVHoDBytuZopLu
 Y1HsEMxRvsYqtC16KWQrKVDB59g3FWD9qVal746Jah/DHEQ5RyZZtKbnZhlqokYXCs
 riagmnK2mz4Jg==
Message-ID: <sashiko-outbox-192339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 04/15] accel/rocket: let the core suspend after a reset
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261101082307.151957-5-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-5-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 08:46:01 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] accel/rocket: asynchronous autosuspend in rocket_reset() skips dom=
ain reset
- [Medium] accel/rocket: pm_runtime_put_autosuspend() precedes detach and r=
eset
--

commit a40b84e5c2017a835f035c1e3114023e0444d2a9
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: let the core suspend after a reset

This commit replaces pm_runtime_put_noidle() with
pm_runtime_put_autosuspend() in rocket_reset() when dropping the
in-flight job's runtime PM reference so that the NPU core can runtime
suspend and power-cycle its domain after a timeout.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.c=
om/

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 5b2abf40b618c..152a9098634b9 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -467,12 +467,12 @@ rocket_reset(struct rocket_core *core, struct drm_s=
ched_job *bad)
> =20
>  	/*
>  	 * No handler is running now, but we might still have stuck jobs. Let's
> -	 * make sure the PM counters stay balanced by manually calling
> -	 * pm_runtime_put_noidle().
> +	 * make sure the PM counters stay balanced by putting the reference the
> +	 * job took, and request idle while doing it so the core can suspend.
>  	 */
>  	scoped_guard(mutex, &core->job_lock) {
>  		if (core->in_flight_job)
> -			pm_runtime_put_noidle(core->dev);
> +			pm_runtime_put_autosuspend(core->dev);

[Severity: High]
As reported by Sashiko on v14 [1], can pm_runtime_put_autosuspend() skip
the required power domain cycle when another job is already queued or
submitted shortly after the reset?

In rocket_core_init(), runtime PM autosuspend is configured with a 50 ms
delay:

    pm_runtime_use_autosuspend(dev);
    ...
    pm_runtime_set_autosuspend_delay(dev, 50);

When rocket_reset() calls pm_runtime_put_autosuspend(core->dev), it marks
the device busy and schedules the autosuspend timer 50 ms in the future,
returning while core->dev is still in RPM_ACTIVE. Immediately after that,
rocket_reset() runs rocket_core_reset(core), clears core->reset.pending,
and restarts the scheduler via drm_sched_start(&core->sched, 0).

If another job is already queued in the scheduler (for example from a
multi-job submission in rocket_ioctl_submit()) or submitted within the
50 ms window, rocket_job_run() will call:

    ret =3D pm_runtime_resume_and_get(core->dev);

while core->dev is still RPM_ACTIVE, which increments usage_count and
cancels the pending autosuspend without ever suspending the device or
cycling its power domain. On RK3576, won't this leave the NPU bus
interface and IOMMU wedged for subsequent jobs?

[Severity: Medium]
Also in rocket_reset(), is it safe to call
pm_runtime_put_autosuspend(core->dev) before
iommu_detach_group(NULL, core->iommu_group) and rocket_core_reset(core)
have completed?

Unlike the normal completion path in rocket_job_handle_irq(), which
detaches the IOMMU group before dropping the runtime PM reference:

    iommu_detach_group(NULL, iommu_group_get(core->dev));
    dma_fence_signal(core->in_flight_job->done_fence);
    pm_runtime_put_autosuspend(core->dev);
    core->in_flight_job =3D NULL;

rocket_reset() drops the last runtime PM reference on core->dev before
calling iommu_detach_group() and rocket_core_reset():

    scoped_guard(mutex, &core->job_lock) {
            if (core->in_flight_job)
                    pm_runtime_put_autosuspend(core->dev);

            iommu_detach_group(NULL, core->iommu_group);

            core->in_flight_job =3D NULL;
    }

    /* Proceed with reset now. */
    rocket_core_reset(core);

If autosuspend_delay_ms is set to 0 or negative via sysfs, or if the reset
worker is preempted past the autosuspend delay, runtime suspend on pm_wq
can run rocket_device_runtime_suspend() and drop supplier references via
__rpm_put_suppliers(core->dev) concurrently with iommu_detach_group() and
rocket_core_reset(core).

Could this turn off core clocks and the power domain before
rocket_core_reset() pulses the synchronous reset lines, and race with
rk_iommu_identity_attach() in drivers/iommu/rockchip-iommu.c:

    iommu->domain =3D identity_domain;
    ...
    ret =3D pm_runtime_get_if_in_use(iommu->dev);
    WARN_ON_ONCE(ret < 0);
    if (ret > 0) {
            rk_iommu_disable(iommu);
            pm_runtime_put(iommu->dev);
    }

such that both rk_iommu_identity_attach() and rk_iommu_suspend() skip
rk_iommu_disable(iommu)?

[1] https://lore.kernel.org/r/20260924102135.92217-5-gahing@gahingwoo.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101082307.1519=
57-1-gahing@gahingwoo.com?part=3D4
