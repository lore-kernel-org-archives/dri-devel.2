Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FB3606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjrINAiz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD5D10EB6E;
	Thu, 12 Nov 2026 09:09:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B3A10E59B
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:09:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD25143790;
 Thu, 12 Nov 2026 09:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4851F00A0A;
 Thu, 12 Nov 2026 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794474574;
 bh=3mQehppUHHAJeTyUQ0vUHOAy2sbUk9EN9zUy/eEW218=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BjrINAiz7NpHcxsUmxsHmnqX8bcKqTlY7i+DZA7HcFkO6Ccd2bwmLmhjMwqszCoTD
 d67lcqgu+Z2LSmrkURYwgGLtd0WufjuV3k3B7nCFhJ2BDRtIfa9bexpK+Pgy+zIIfU
 TipevoAX85ac9D2Ktgc6UrNTDpIkkX6GXPKleJaTpG5fMxF7AQlTbO1ykZSB13rL5q
 Gtu0hCqPBRQDxVxGVIWoL9jvybm/x5/Bh0sSQWLopszNzZnejkx/nfxaAITo2AJ+hb
 U2dX3ouE6SWXRFgfO5fDVazIO/dDSw3iz5EHy6dtEztZYfVOXcYMoQnfpy9kQNz1G7
 GFJNmbjjJbQow==
Message-ID: <sashiko-outbox-210830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/11] drm/panfrost: Power the GPU up for a reset
 queued from the MMU code
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-panfrost-long-jobs-v2-1-a06830da3d99@gmail.com>
References: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
 <20261112-panfrost-long-jobs-v2-1-a06830da3d99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 09:09:33 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/panfrost: race with system suspend in
  panfrost_reset_work()
--

commit 4c2188106dfefcf238af31be2bfb9e60d51e0307
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/panfrost: Power the GPU up for a reset queued from the MMU code

This commit acquires a runtime PM reference in panfrost_reset_work() before
calling panfrost_reset(), and clears reset.pending if
pm_runtime_resume_and_get() fails.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 3a46dd61cf87f..0c2fda80c51ef 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -810,7 +810,21 @@ static void panfrost_reset_work(struct work_struct *=
work)
>  	struct panfrost_device *pfdev;
> =20
>  	pfdev =3D container_of(work, struct panfrost_device, reset.work);
> +
> +	/* The work can run long after it was queued, when the GPU has gone
> +	 * idle and been runtime suspended. Power it up for the reset: its
> +	 * registers are not accessible while it is suspended. If it cannot
> +	 * be resumed (runtime PM is disabled during system sleep), there is
> +	 * no job on it, and panfrost_device_runtime_resume() resets it when
> +	 * it comes back up.
> +	 */
> +	if (pm_runtime_resume_and_get(pfdev->base.dev)) {
> +		atomic_set(&pfdev->reset.pending, 0);
> +		return;
> +	}
> +
>  	panfrost_reset(pfdev, NULL);
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
>  }

[Severity: Medium]
Can panfrost_reset_work() still race with panfrost_device_suspend() and
access GPU registers while the GPU is powered off?

pfdev->reset.wq is allocated without WQ_FREEZABLE and
panfrost_device_suspend() does not flush or cancel pfdev->reset.work.
Holding a runtime PM usage reference does not block
pm_runtime_force_suspend(), which ignores usage_count and calls
panfrost_device_runtime_suspend() directly:

kworker                               CPU0
panfrost_reset_work()
  pm_runtime_resume_and_get()
                                      panfrost_device_suspend()
                                        pm_runtime_force_suspend()
                                          panfrost_device_runtime_suspend()
                                            panfrost_jm_is_idle() -> true
                                            panfrost_gpu_power_off()
                                        panfrost_clks_disable()
  panfrost_reset()
    job_write(pfdev, JOB_INT_MASK, 0) <-- external abort (GPU powered off)

In addition, if the GPU is RPM_ACTIVE when pm_runtime_force_suspend()
disables runtime PM and usage_count > 1 (for example if
__pm_runtime_resume() incremented usage_count while
panfrost_device_runtime_suspend() was running, or perfcnt is enabled),
pm_runtime_force_suspend() sets needs_force_resume and leaves both
runtime_status and last_status set to RPM_ACTIVE.  rpm_resume() then
returns 1 even with disable_depth > 0, so pm_runtime_resume_and_get()
returns 0 while the GPU is suspended.

Finally, when pm_runtime_resume_and_get() fails, clearing
pfdev->reset.pending is not serialized against panfrost_device_resume().
If the device resumes concurrently and panfrost_job_hw_submit() observes
reset.pending =3D=3D 1, it places the job in pfdev->jobs without writing
JS_COMMAND_START, and panfrost_reset_work() then clears reset.pending and
returns without resetting or starting that job.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-panfrost-l=
ong-jobs-v2-0-a06830da3d99@gmail.com?part=3D1
