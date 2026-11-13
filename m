Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35345606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqhssK/G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5653810E7BF;
	Fri, 13 Nov 2026 09:36:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA97910E7BF
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:36:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49968463CE;
 Fri, 13 Nov 2026 09:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030401F000D1;
 Fri, 13 Nov 2026 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794562605;
 bh=FkCAL6aqDwXijotLXYO5NGe+1AcTt/AeYCsB9gc3nWU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kqhssK/GC/HPnPgBzVhpyhwC4i1JczHDYQfbxBOhcpCI9sAdn1rkKQ75hz/1DPgSP
 zJj6qfay3KLZ7rJ2xWRKT1u+Iiu8ks79JSwIy3ik8pMUUAzVZBYP9+zLJjVrSKolYX
 uLniYR2ya+ClLxPyyuHxffJXGtYS4Ty5R+5SvACL29kNl2UfLq6oJJTdu8ZA7HOYVu
 xZnaHcr/bJc/7N68XtBAek7eX1J0oI88S1ipmYLk6x9RVNw3m/mXC1MOc5Ty4I4FNj
 uEKEvYaDTvf3UvRdSzZgwwtb0GmUhMTu0FNQjWE9T9Y2qb2P/8ojB6HbPx/E0pYqQj
 Y40AFIa+4Aijw==
Message-ID: <sashiko-outbox-212557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/14] drm/panfrost: Power the GPU up for a reset
 queued from the MMU code
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261113-panfrost-long-jobs-v3-1-80ae78d38f6e@gmail.com>
References: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
 <20261113-panfrost-long-jobs-v3-1-80ae78d38f6e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:36:43 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/panfrost: unclocked MMIO access in
  panfrost_device_resume() on error
- [Low] drm/panfrost: race when clearing reset.pending in
  panfrost_reset_work()
--

commit 7ec017c5585451d1f5d87f4425f33e0c841194f8
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/panfrost: Power the GPU up for a reset queued from the MMU code

This commit takes a runtime PM reference in panfrost_reset_work() and
disables the reset work across system suspend and resume so GPU registers
are not accessed while the GPU is powered off.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 40eda3612f849..2c11a67216e0f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c

[ ... ]

> @@ -604,14 +604,36 @@ static int panfrost_device_resume(struct device *de=
v)
>  	return ret;
>  }
> =20
> +static void panfrost_device_enable_reset(struct panfrost_device *pfdev)
> +{
> +	enable_work(&pfdev->reset.work);
> +	if (atomic_read(&pfdev->reset.pending))
> +		queue_work(pfdev->reset.wq, &pfdev->reset.work);
> +}
> +
> +static int panfrost_device_resume(struct device *dev)
> +{
> +	int ret =3D panfrost_device_power_up(dev);
> +
> +	panfrost_device_enable_reset(dev_get_drvdata(dev));
> +	return ret;
> +}

[Severity: Medium]
Can panfrost_device_resume() queue pfdev->reset.work onto an unclocked GPU
when panfrost_device_power_up() fails?

If pm_runtime_force_resume() fails in panfrost_device_power_up(), it has
already called pm_runtime_set_suspended() and pm_runtime_enable(), and the
err_resume path disables the GPU_PM_CLK_DIS clocks and GPU_PM_VREG_OFF
regulator.  Calling panfrost_device_enable_reset() unconditionally then
queues panfrost_reset_work(), where pm_runtime_resume_and_get() runs
panfrost_device_runtime_resume() -> panfrost_device_reset() without
re-enabling those clocks or regulators, causing an unclocked MMIO access
and synchronous external abort on arm64.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 3a46dd61cf87f..7319511db19f5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -810,7 +810,18 @@ static void panfrost_reset_work(struct work_struct *=
work)
>  	struct panfrost_device *pfdev;
> =20
>  	pfdev =3D container_of(work, struct panfrost_device, reset.work);
> +
> +	/* The GPU may have been runtime suspended since the work was queued.
> +	 * If it cannot be resumed, no job is on it, and
> +	 * panfrost_device_runtime_resume() resets it later.
> +	 */
> +	if (pm_runtime_resume_and_get(pfdev->base.dev)) {
> +		atomic_set(&pfdev->reset.pending, 0);
> +		return;
> +	}

[Severity: Low]
Can clearing pfdev->reset.pending after pm_runtime_resume_and_get() fails
race with a concurrent job submission and leave the job unstarted?

kworker                                 CPU1
panfrost_reset_work()
  pm_runtime_resume_and_get() -> fails
                                        panfrost_job_run()
                                          pm_runtime_get_sync() -> succeeds
                                          panfrost_job_hw_submit()
                                            panfrost_enqueue_job()
                                            if (!atomic_read(&reset.pending=
))
                                              /* sees 1, skips JS_COMMAND_S=
TART */
  atomic_set(&pfdev->reset.pending, 0);
  return;                               <-- job left unstarted until timeout

rpm_resume() does not latch runtime_error on callback or supplier failure,
so a concurrent panfrost_job_run() can resume the GPU after
pm_runtime_resume_and_get() drops dev->power.lock.  Because
panfrost_device_runtime_resume() resets the GPU without clearing
pfdev->reset.pending, panfrost_job_hw_submit() sees reset.pending =3D=3D 1 =
and
relies on panfrost_reset() to resubmit the job, which never happens once
panfrost_reset_work() clears reset.pending and returns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-panfrost-l=
ong-jobs-v3-0-80ae78d38f6e@gmail.com?part=3D1
