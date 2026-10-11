Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D934CA9ECF
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D292B10E379;
	Sun, 11 Oct 2026 17:52:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dbbodPa2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E89F10E379
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:52:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 884B5600E2;
 Sun, 11 Oct 2026 17:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163C71F0089B;
 Sun, 11 Oct 2026 17:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791741132;
 bh=P/XzrpahFDJGhfdQoOV07mNrHtMO3VESxMJhvCJK8ps=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dbbodPa2mtff2msGC4e+eH5DPtf8wOF8Bh70N5kXTwAz8p0jauWKhr9FwKBSkut15
 MOATwRjMjvexT7OKM4c2esP/EaOvw8qcFrVhqNl10BoA6Qk6G79xBsQpgGfLXnmFLg
 gUpvk4ViP8vzboQGfhZ6SNW23C4+pX36jdHpa7RxZjDHq4quqyHjNU+6RH01+30TQe
 ZpCS8vGjn+UPtOH+qJHWi7S55xDltrwVwmp4zMRxv7yAjV0XZ9X9iOc57EaQhnIy1x
 ZFpGqJPb6+llRyGRR0S8lc0CwmiBMM1NpkNW2GfKjeBLcCz3Yy6u2rT7Qjh83il89c
 bf/j47CgDrklw==
Message-ID: <sashiko-outbox-167361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/8] drm/panthor: Expose the panthor perf ioctls
To: "Lukas Zapolskas" <lukas.zapolskas@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261011-panthor-performance-counters-v7-8-12c32495062f@arm.com>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-8-12c32495062f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 17:52:11 +0000
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
- [High] drm: panthor: leak of SRCU read lock on error paths in perf sessio=
n ioctls
- [High] drm: panthor: integer overflow in sample size calculation allows o=
ut-of-bounds write
- [High] drm: missing drm_dev_exit() on error paths causes SRCU lock leak
- [Low] drm/panthor: missing bounds validation for perf block_set
--

commit 67ed39f94766c6f1ca32b076cb6cf69b5aaa9f5d
Author: Lukas Zapolskas <lukas.zapolskas@arm.com>

drm/panthor: Expose the panthor perf ioctls

This patch implements the PANTHOR_PERF_SESSION ioctl series.

> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pant=
hor/panthor_drv.c
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c

[ ... ]

> +static int panthor_ioctl_perf_session_create(struct drm_device *ddev, vo=
id *data,
> +					     struct drm_file *file)
> +{
> +	int ret, cookie;
> +	unsigned long sid =3D 0;
> +	struct drm_panthor_perf_session_create *args =3D data;
> +
> +	if (!drm_dev_enter(file->minor->dev, &cookie))
> +		return -ENODEV;
> +
> +	if (!mem_is_zero(args->pad, sizeof(args->pad)))
> +		return -EINVAL;

[Severity: High]
Does this error path leak the SRCU read lock acquired by drm_dev_enter()?
Returning directly without calling drm_dev_exit() leaves the lock held,
which can cause a system deadlock when drm_dev_unplug() waits indefinitely=
=20
in synchronize_srcu().

> +
> +	ret =3D panthor_perf_session_create(file, args, &sid);

[Severity: High]
When calling panthor_perf_session_create(), does the calculation of
user_sample_size overflow on 32-bit systems?

Inside panthor_perf_session_create() in panthor_perf.c:

	user_sample_size =3D ptdev->perf_info.sample_size * slots;

Since size_t is 32-bit on 32-bit architectures, and slots is derived from
the userspace-provided sample_slots, a large power-of-two value can cause
this multiplication to wrap to exactly 0.

If user_sample_size wraps to 0, panthor_perf_bo_get() will skip its bounds
validation. This would allow userspace to map a small buffer object while
retaining a massive ringbuf_slots value, which could result in out-of-bounds
writes into adjacent kernel virtual memory during sample collection. Should
this use size_mul() to saturate on overflow?


[Severity: Low]
Is the block_set parameter from userspace bounds-checked before it is passed
to panthor_perf_session_add() here?

Inside panthor_perf_session_add() in panthor_perf.c, the unvalidated set is
stored directly:

	perf->set_config =3D set;

Later in panthor_perf_fw_write_config(), it gets truncated by the hardware
masking macro GLB_PERFCNT_CONFIG_SET:

	perfcnt_config |=3D GLB_PERFCNT_CONFIG_SET(perf->set_config);

Should this be validated against the maximum number of blocks to return an
-EINVAL error for non-existent sets, as documented in the uAPI?

> +	if (ret)
> +		return ret;

[Severity: High]
Does this error path also leak the SRCU read lock by returning directly
without calling drm_dev_exit(cookie)?

> +
> +	drm_dev_exit(cookie);
> +	return sid;
> +}
> +
> +static int panthor_ioctl_perf_session_start(struct drm_device *ddev, voi=
d *data,
> +					    struct drm_file *file)
> +{
> +	int cookie, ret;
> +	struct panthor_file *pfile =3D file->driver_priv;
> +	struct drm_panthor_perf_session_start *args =3D data;
> +
> +	if (!drm_dev_enter(file->minor->dev, &cookie))
> +		return -ENODEV;
> +
> +	if (args->pad0)
> +		return -EINVAL;

[Severity: High]
Can this early return leak the SRCU lock? We need drm_dev_exit(cookie) here
before returning.

> +
> +	ret =3D panthor_perf_session_start(pfile, args->handle, args->user_data=
);
> +
> +	drm_dev_exit(cookie);
> +	return ret;
> +}
> +
> +static int panthor_ioctl_perf_session_sample(struct drm_device *ddev, vo=
id *data,
> +					     struct drm_file *file)
> +{
> +	int cookie, ret;
> +	struct panthor_file *pfile =3D file->driver_priv;
> +	struct drm_panthor_perf_session_sample *args =3D data;
> +
> +	if (!drm_dev_enter(file->minor->dev, &cookie))
> +		return -ENODEV;
> +
> +	if (args->pad0)
> +		return -EINVAL;

[Severity: High]
Can this early return leak the SRCU lock? We need drm_dev_exit(cookie) here
before returning.

> +
> +	ret =3D  panthor_perf_session_sample(pfile, args->handle, args->user_da=
ta);
> +
> +	drm_dev_exit(cookie);
> +	return ret;
> +}
> +
> +static int panthor_ioctl_perf_session_stop(struct drm_device *ddev, void=
 *data,
> +					   struct drm_file *file)
> +{
> +	int cookie, ret;
> +	struct panthor_file *pfile =3D file->driver_priv;
> +	struct drm_panthor_perf_session_stop *args =3D data;
> +
> +	if (!drm_dev_enter(file->minor->dev, &cookie))
> +		return -ENODEV;
> +
> +	if (args->pad0)
> +		return -EINVAL;

[Severity: High]
Can this early return leak the SRCU lock? We need drm_dev_exit(cookie) here
before returning.

> +
> +	ret =3D panthor_perf_session_stop(pfile, args->handle, args->user_data);
> +
> +	drm_dev_exit(cookie);
> +	return ret;
> +}
> +
> +static int panthor_ioctl_perf_session_destroy(struct drm_device *ddev, v=
oid *data,
> +					      struct drm_file *file)
> +{
> +	int cookie, ret;
> +	struct panthor_file *pfile =3D file->driver_priv;
> +	struct drm_panthor_perf_session_destroy *args =3D data;
> +
> +	if (!drm_dev_enter(file->minor->dev, &cookie))
> +		return -ENODEV;
> +
> +	if (args->pad0)
> +		return -EINVAL;

[Severity: High]
Can this early return leak the SRCU lock? We need drm_dev_exit(cookie) here
before returning.

> +
> +	ret =3D panthor_perf_session_destroy(pfile, args->handle);
> +
> +	drm_dev_exit(cookie);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-panthor-pe=
rformance-counters-v7-0-12c32495062f@arm.com?part=3D8
