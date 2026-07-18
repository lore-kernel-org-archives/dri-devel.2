Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9DDC4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 07:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1E910E543;
	Sat, 18 Jul 2026 07:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jBLBwgSr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AE510E543
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 07:27:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 968FC6001A;
 Sat, 18 Jul 2026 07:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5911F000E9;
 Sat, 18 Jul 2026 07:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784359640;
 bh=VmJRJWP8ytBBxcxwmjQ5RL2CcvcS4FQK9hmZwjN5pPw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jBLBwgSrjP7dRGk1qioi+rqT9efm/ImSCIkx41vsZnHxLCYJm5vMXvlts5GP6vkES
 +c876+muLERI35O44LuaJljjBwMppXssgze+KnuvPLGeQCBf//OfCm+HcywZIV4bl+
 jtGjaIBvBrRJhCJ4s0HvU394RHEBPQQPDlhnrV0A5/N4fjIgpD9Zd5iGK6Pck+LZDj
 9zj56riHilm/XMadTCBPd8UGWnSah3KvY3spiRGt7cHDIVntUzto7iSAt/0t4mpLzA
 p2R5GBN65b7PK1DGqnMCVUsvW20bc4nJo8KsKqTC4f52hh0eqDUlDymLwYQ9qOSZ1c
 QwrxIIwzGuvMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/v3d: release CPU job resources on pre-init failures
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260718071047.3037514-1-lgs201920130244@gmail.com>
References: <20260718071047.3037514-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 07:27:19 +0000
Message-Id: <20260718072720.2A5911F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing `v3d_job_deallocate()` on pre-init validation error paths =
causes a kernel panic in `drm_sched_job_cleanup()`.
- [High] Incomplete cleanup on `v3d_get_extensions()` failure causes resour=
ce leaks and deadlocks for chained extensions.
- [High] Early validation failures for INDIRECT_CSD CPU jobs bypass WW mute=
x unreservation and leak nested jobs.
--

--- Patch [1]: [PATCH v3] drm/v3d: release CPU job resources on pre-init fa=
ilures ---
commit 0d9b615d1fa0aedf4a08be6bbd88de15b262217c
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/v3d: release CPU job resources on pre-init failures

This commit extracts CPU job resource cleanup into a new helper function
and calls it on pre-init failure paths in the drm/v3d driver. This helps
prevent leaking extension resources if validation fails before the job
destructor is installed.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 7682b24f13ec5..77e94c25b2afd 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c

[ ... ]

> @@ -1320,12 +1326,14 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void=
 *data,

[Severity: High]
This is a pre-existing issue, but since the v3 patch notes mention removing
v3d_cpu_job_free_resources() from the v3d_get_extensions() error path,
can an error during extension parsing leak resources?

If v3d_get_extensions() loops through a chain of user extensions and a later
extension fails to parse, it returns an error immediately. Are the resources
and reservations acquired by previously parsed extensions in the chain unro=
lled
and freed?

For example, if an INDIRECT_CSD extension parses successfully but a
subsequent extension fails, it appears the BO reservations locked in
v3d_setup_csd_jobs_and_bos() are never unlocked, which could lead to a WW
mutex deadlock. Does v3d_get_extensions() handle chained extension failures
fully?

>  	/* Every CPU job must have a CPU job user extension */
>  	if (!cpu_job->job_type) {
>  		drm_dbg(dev, "CPU job must have a CPU job user extension.\n");
> +		v3d_cpu_job_free_resources(cpu_job);
>  		ret =3D -EINVAL;
>  		goto fail;
>  	}
> =20
>  	if (args->bo_handle_count !=3D cpu_job_bo_handle_count[cpu_job->job_typ=
e]) {
>  		drm_dbg(dev, "This CPU job was not submitted with the proper number of=
 BOs.\n");
> +		v3d_cpu_job_free_resources(cpu_job);
>  		ret =3D -EINVAL;
>  		goto fail;
>  	}

[Severity: High]
This is a pre-existing issue, but does jumping to the fail label here leave
cpu_job allocated and crash during cleanup?

When jumping to the fail block, cpu_job is not set to NULL and
v3d_job_deallocate() is not called. The fail block executes:

fail:
        v3d_job_cleanup((void *)cpu_job);

This eventually calls drm_sched_job_cleanup(&job->base). Because
v3d_job_init() has not been called yet, job->s_fence is NULL. Can this
result in a NULL pointer dereference and kernel panic in
drm_sched_job_cleanup()?

[Severity: High]
This is also a pre-existing issue, but can these early validation paths leak
nested jobs and cause deadlocks for INDIRECT_CSD jobs?

When an INDIRECT_CSD extension is parsed earlier, v3d_setup_csd_jobs_and_bo=
s()
allocates nested csd_job and clean_job structures and locks their GEM BO
reservations. If validation fails here, the code jumps to fail, bypassing t=
he
fail_unreserve label.

While v3d_cpu_job_free_resources() drops the indirect GEM reference, it
does not free the nested jobs or unlock their context. At the fail block,
the local csd_job and clean_job variables are still NULL (they are assigned
later in the function), so v3d_job_cleanup() does nothing for them. Can
this permanently leak the jobs and leave the BOs locked?

> @@ -1335,6 +1343,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *=
data,
>  	ret =3D v3d_job_init(v3d, file_priv, &cpu_job->base,
>  			   v3d_cpu_job_free, 0, &se, V3D_CPU);
>  	if (ret) {
> +		v3d_cpu_job_free_resources(cpu_job);
>  		v3d_job_deallocate((void *)&cpu_job);
>  		goto fail;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718071047.3037=
514-1-lgs201920130244@gmail.com?part=3D1
