Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDFFC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D4F10EB84;
	Tue,  1 Sep 2026 07:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kYcuXaIA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED6610EB84
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 07:47:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B2F241258;
 Tue,  1 Sep 2026 07:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEC11F000E9;
 Tue,  1 Sep 2026 07:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788248834;
 bh=e1DLk6ucAHuKsx8Q8p8d2aEHEsNR2jTNnqoe2W6sj5I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kYcuXaIAwhxGZGDLQxm/i4DtNAiGMTe6Xg06XURM+ice/SPardR8Tiz6okZ5Fgurn
 uk1utyYdDhg6L+WNl72ZbmV6SUlhy3PRGaqO4vA1coXQuVrWkAERHZc5PU2RTJMeqF
 auyWhKK6F3TyKQGUCJKzIAYd1gNP3H9iG4wyqKubmzoOnBd0krH29EZCAjOgq6eKcR
 7G+yuGGjuqCaNBmhtDrC9mWTajTmB4zp3pBAt6bavCsch1Axt2leVaqGVXavZe9xMM
 XC4A5Vgo5ZNT/NyNZqg39jvTUAre3qJQXzBe0+6CTx2TwKM1YIwiRcuJpVYcVdTUEe
 mJOBTHMn/PcKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: use kzalloc_objs() instead of kzalloc()
 with multiply
To: "Hrushiraj Gandhi" <hrushirajg23@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901072615.522925-1-hrushirajg23@gmail.com>
References: <20260901072615.522925-1-hrushirajg23@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 07:47:13 +0000
Message-Id: <20260901074714.5AEC11F000E9@smtp.kernel.org>
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
- [High] Double free of `dqm->fence_mem`, `dqm->hung_db_array`, `dqm->hqd_i=
nfo` and packet manager due to `dqm->sched_running` remaining true on `star=
t_cpsch` error path.
--

commit 9326059d02e56cf390501c700d0f8e0e83592163
Author: Hrushiraj Gandhi <hrushirajg23@gmail.com>

    drm/amdkfd: use kzalloc_objs() instead of kzalloc() with multiply
   =20
    dqm->detect_hang_info, dqm->hung_db_array and dqm->hqd_info are all
    allocated with a hand-computed count * sizeof(TYPE) size. If count
    were ever attacker- or firmware-influenced and large enough, the
    multiply could wrap size_t and produce a too-small allocation that
    the code then writes count-many elements into.
   =20
    kzalloc_objs() computes the same size via size_mul(), which saturates
    to SIZE_MAX on overflow instead of wrapping, so the allocation itself
    fails cleanly (already handled here via the existing NULL checks)
    rather than silently succeeding undersized.
   =20
    dqm->detect_hang_info_size is left as-is since it is also used later
    for a memset() call; only the allocation itself is converted.
   =20
    No functional change in the non-overflowing case.
   =20
    Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 69cd4441e240c..488176e947c3e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2160,17 +2160,15 @@ static int start_cpsch(struct device_queue_manage=
r *dqm)
>  			      NUM_XCC(dqm->dev->xcc_mask);
> =20
>  	dqm->detect_hang_info_size =3D num_hw_queue_slots * sizeof(struct dqm_d=
etect_hang_info);
> -	dqm->detect_hang_info =3D kzalloc(dqm->detect_hang_info_size, GFP_KERNE=
L);
> +	dqm->detect_hang_info =3D kzalloc_objs(*dqm->detect_hang_info, num_hw_q=
ueue_slots);
> =20
>  	if (!dqm->detect_hang_info) {
>  		retval =3D -ENOMEM;
>  		goto fail_detect_hang_buffer;

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leave
dqm->sched_running set to true?

Earlier in start_cpsch(), dqm->sched_running is set to true. When this
allocation fails, the error path executes kfd_gtt_sa_free() on dqm->fence_m=
em
and uninitializes the packet manager:

fail_detect_hang_buffer:
	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
fail_allocate_vidmem:
fail_set_sched_resources:
	if (!dqm->dev->kfd->shared_resources.enable_mes)
		pm_uninit(&dqm->packet_mgr);

Because it fails to clear dqm->sched_running or set dqm->fence_mem to NULL,
subsequent cleanup via stop_cpsch() will proceed rather than exiting early.
This causes stop_cpsch() to call kfd_gtt_sa_free() on the dangling fence_mem
pointer and pm_uninit() a second time. The second pm_uninit() call passes a
NULL pointer which gets dereferenced, leading to a kernel panic.

Additionally, stop_cpsch() frees dqm->hung_db_array and dqm->hqd_info witho=
ut
nullifying them, meaning a subsequent start/stop cycle could trigger a doub=
le
free on those arrays as well.

Could dqm->sched_running be set to false and the freed pointers cleared to
NULL in this error path to avoid the double free?

>  	}
> =20
> -	dqm->hung_db_array =3D kzalloc(hung_array_size * sizeof(u32), GFP_KERNE=
L);
> -	dqm->hqd_info =3D kzalloc(
> -		hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info),
> -		GFP_KERNEL);
> +	dqm->hung_db_array =3D kzalloc_objs(*dqm->hung_db_array, hung_array_siz=
e);
> +	dqm->hqd_info =3D kzalloc_objs(*dqm->hqd_info, hqd_info_size);
> =20
>  	dqm_unlock(dqm);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901072615.5229=
25-1-hrushirajg23@gmail.com?part=3D1
