Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3930CA6009
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C3E510E501;
	Wed,  7 Oct 2026 23:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VMmSabgo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E00F10E501
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 23:58:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 740C143DDC;
 Wed,  7 Oct 2026 23:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA1A1F000FF;
 Wed,  7 Oct 2026 23:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791417525;
 bh=VdZDD6fy5ckUCHBlhoLpSKnwvPQeWCuU9+V/tnFkAXY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VMmSabgomzB8x2v0qIRAvg0vDCruee5HZJQKGz7ork6YQuWlfYLv1VOKIudtldktj
 YXcG+C0UA2T0/GyfLbdk9+5wjvdRWlVCuFgmh+4prnsaRr8q5GFHCwhmUtdC/OWNnj
 t08MuLs4p5udB/BBzj4PKXc2y3syfd+lv4YqEL93gqFBtB9MZyJlY5ziQyNd4mL/Va
 X1xKH2BzR9V1+8M1BNx6z5Pp/ISDrdC8L0jtKcj+qyEeY+N9BZxb4OxCRD7Y2RLRzx
 LS8fAteV1oDVz1iijMTobHiFTvnWXmIRHkwyLLZfXjFi2169nNoP73rPqihvMDrJfm
 267iPkPITn/pQ==
Message-ID: <sashiko-outbox-163445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 15/15] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-claude-fixes-v13-15-d6a493185860@collabora.com>
References: <20261008-claude-fixes-v13-0-d6a493185860@collabora.com>
 <20261008-claude-fixes-v13-15-d6a493185860@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 23:58:44 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/panfrost: sticky DEAD flag causes AS reference leak on multipl=
e GPU resets
- [High] drm/panfrost: UAF in perfcnt context due to devres lifecycle misma=
tch
- [Medium] drm/panfrost: perfcnt->state is destroyed on ERESTARTSYS signal =
interrupt in panfrost_perfcnt_dump_locked()
- [Low] drm/panfrost: cleanup.md violation by mixing goto and scoped_guard =
in panfrost_perfcnt_enable_locked
--

commit be4c8f35c54f411638ee240c72cfc88e3f4b3c5d
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix races between perfcnt and reset sequence

This commit updates the Panfrost driver to use the reset rw_semaphore
when configuring performance counters and during dump ioctls to avoid
races with the reset sequence. It also expands the DUMP uAPI to report
reset states back to userspace and bumps the DRM minor version.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -118,12 +118,22 @@ static int panfrost_perfcnt_dump_locked(struct panf=
rost_device *pfdev, u32 *stat
>  {
[ ... ]
>  	scoped_guard(rwsem_read, &pfdev->reset.lock) {
>  		*state =3D perfcnt->state;
>  		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
>  			return -EIO;
> =20
>  		perfcnt->state =3D 0;
> =20
>  		reinit_completion(&pfdev->perfcnt->dump_comp);
[ ... ]
>  	ret =3D wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump=
_comp,
>  							msecs_to_jiffies(1000));
> =20
>  	/* A reset might come through in the gap between the completion returni=
ng and the following
>  	 * check, but because no sample was produced, we don't care to relay th=
e state back to UM.
>  	 */
>  	if (!ret)
>  		ret =3D -ETIMEDOUT;
> =20
>  	/* We should not touch perfcnt's state when the completion wait was int=
errupted by UM */
>  	if (ret < 0)
>  		return ret;

[Severity: Medium]
Could the perfcnt state be permanently lost if the completion wait is
interrupted by a signal like -ERESTARTSYS?=20

The state is cleared before the wait, and if ret is less than zero, the
function returns early without restoring it. When the kernel restarts the
ioctl, userspace might miss the reset flag because the state has already
been zeroed out.

[ ... ]
> @@ -182,10 +182,19 @@
>  static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  					  struct drm_file *file_priv,
>  					  unsigned int counterset)
>  {
[ ... ]
>  	if (perfcnt->user =3D=3D user) {
>  		scoped_guard(rwsem_read, &pfdev->reset.lock) {
>  			if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD) {
>  				ret =3D panfrost_perfcnt_hw_enable(pfdev);
>  				if (!ret)
>  					perfcnt->state =3D 0;
>  				return ret;
>  			}
>  		}
> =20
>  		return 0;
>  	}

[Severity: High]
Does this cause an Address Space reference leak after multiple resets?

If a prior hardware reset fails, the PANFROST_PERFCNT_SESSION_DEAD flag
is set in panfrost_perfcnt_reset(). A subsequent successful reset drops
owns_as_ref but does not clear the dead flag.=20

If userspace then issues an enable ioctl, it takes this path and calls
panfrost_perfcnt_hw_enable() which observes owns_as_ref is already true,
and takes a second address space reference without releasing the first.

[ ... ]
> @@ -247,16 +247,15 @@
>  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
> =20
>  	scoped_guard(rwsem_read, &pfdev->reset.lock) {
>  		/*
>  		 * Clear the counters to start from a fresh state.
>  		 */
>  		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
>  		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> =20
>  		ret =3D panfrost_perfcnt_hw_enable(pfdev);
>  		if (ret)
>  			goto err_vunmap;

[Severity: Low]
Is it safe to jump out of a scoped guard using a goto label?

If panfrost_perfcnt_hw_enable() fails, it jumps out of the scoped guard to
the err_vunmap label. The cleanup subsystem guide recommends not mixing
goto-based error handling and scope-based cleanups in the same function
due to the potential for confusing ownership semantics.

[ ... ]
> @@ -326,9 +326,14 @@
>  int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
>  				struct drm_file *file_priv)
>  {
>  	struct panfrost_device *pfdev =3D to_panfrost_device(dev);
>  	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
>  	struct drm_panfrost_perfcnt_dump *req =3D data;
>  	void __user *user_ptr =3D (void __user *)(uintptr_t)req->buf_ptr;
>  	int ret;
> =20
>  	ret =3D panfrost_unstable_ioctl_check();
>  	if (ret)
>  		return ret;
> =20
> +	if (req->pad)
> +		return -EINVAL;
> +
>  	mutex_lock(&perfcnt->lock);

[Severity: High]
Might this trigger a memory corruption if the device is unbound while the
DRM file descriptor remains open?

The perfcnt structure is allocated with devm_kzalloc() tied to the platform
device pfdev->base.dev, so it is freed when the device unbinds. However,
the DRM file operations can outlive the platform device.=20

When userspace calls this ioctl later, it unconditionally dereferences
pfdev->perfcnt and attempts to acquire perfcnt->lock. Could this be
protected with a drm_dev_enter() unplug check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-claude-fix=
es-v13-0-d6a493185860@collabora.com?part=3D15
