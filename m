Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8728DC5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7AB10EDB5;
	Tue, 11 Aug 2026 21:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="erdHCg76";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047C910EDB5
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:55:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2326E600AE;
 Tue, 11 Aug 2026 21:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBC91F000E9;
 Tue, 11 Aug 2026 21:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786485320;
 bh=BO3z4VwEkT7GJcuc9oQgUkCYTGkGv0RyCVH07MJpiPo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=erdHCg76RvXFi75jPmPYI9p5lS2djLBUE12iRT2A7zqO4EyD/oILOSDP+37LwDZFD
 Q3csIi03T8qvZ3w4+kibVsD5se3PZhmHMacCQYVqHSV/BNxuuuIRQlmh8E3WgfGfty
 23xIi7DSQX5CuyBwwD+BOFRcWyMRGZk88Wxf7TZ4NyNwEcnvnotAh3ZOKPMg7aYwTc
 dIecH13UZgKFubacZEeVgxIgJPLI/nGCsbOsOqaPw6ELJ2nDxJyRO6xdoUfu+LCMDD
 mws2y6ZNfDLwrA9+UEZjpJZuU7XNyaJxC+q38x4E1X4l38ZgRwi9v3W4QlDVcF/I6O
 3tLetkaBEhkcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/11] drm/panfrost: Introduce a reset lock
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811-claude-fixes-v5-9-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-9-3d692c9e98c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 21:55:20 +0000
Message-Id: <20260811215520.ADBC91F000E9@smtp.kernel.org>
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
- [High] The GPU reset path acquires the read/write semaphore in shared (re=
ad) mode instead of exclusive (write) mode, failing to provide mutual exclu=
sion against driver entry points.
--

--- Patch [9]: [PATCH v5 09/11] drm/panfrost: Introduce a reset lock ---
commit 4a244ba91270b92c6bb1ef0025f7f540dbdc5eff
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: envelope GPU reset sequence with rw_semaphore

This commit introduces a read/write semaphore to prevent driver entry
points from accessing hardware registers while a GPU reset is ongoing.
The query timestamp ioctl is updated to hold this semaphore during
execution.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 5b66173c75b9..e0390b6c0d22 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -602,6 +602,8 @@ bool panfrost_exception_needs_reset(const struct panf=
rost_device *pfdev,
> =20
>  void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_jo=
b_int)
>  {
> +	guard(rwsem_read)(&pfdev->reset.lock);

[Severity: High]
Does acquiring this lock as a shared reader (rwsem_read) instead of an
exclusive writer (rwsem_write) fail to provide mutual exclusion?

Since the protected ioctl path in panfrost_ioctl_query_timestamp() also
acquires the lock in read mode, won't both paths execute concurrently?

This could allow an unprivileged userspace program calling the timestamp
ioctl to access hardware registers while the GPU reset is ongoing, which
defeats the intended mutual exclusion.

> +
>  	panfrost_gpu_soft_reset(pfdev);
>  	panfrost_gpu_power_on(pfdev);
>  	panfrost_mmu_reset(pfdev);

[ ... ]

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 958f1d36ab10..ff23b1a979bb 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -41,9 +41,12 @@ static int panfrost_ioctl_query_timestamp(struct panfr=
ost_device *pfdev,
>  	if (ret)
>  		return ret;
> =20
> -	panfrost_cycle_counter_get(pfdev);
> -	*arg =3D panfrost_timestamp_read(pfdev);
> -	panfrost_cycle_counter_put(pfdev);
> +	/* We should not read timestamp register while the GPU  is being reset =
*/
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {

[Severity: High]
As noted above, since both the reset path and this ioctl path acquire the
lock in read mode, will this scoped_guard fail to wait for an ongoing reset
to complete?

> +		panfrost_cycle_counter_get(pfdev);
> +		*arg =3D panfrost_timestamp_read(pfdev);
> +		panfrost_cycle_counter_put(pfdev);
> +	}
> =20
>  	pm_runtime_put(pfdev->base.dev);
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-claude-fix=
es-v5-0-3d692c9e98c2@collabora.com?part=3D9
