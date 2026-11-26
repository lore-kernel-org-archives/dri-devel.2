Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE6606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcHEU8T+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF7D10E580;
	Thu, 26 Nov 2026 21:16:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E44810E97D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:16:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3CD6E41AEA;
 Thu, 26 Nov 2026 21:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE7C1F000C1;
 Thu, 26 Nov 2026 21:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795727768;
 bh=J7G70HaiUhw1xln6aKRIdyMZ9kQGrq+q+E7aocLlvR0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lcHEU8T++QudBeaZzhR/lOBTPfuZ0whzeyPhpRKixmcRHXTONO3SHsH7bqx1oKu3b
 6eO5NbQrgNI8T9f/HMNL2n6ocENf4wbh6IWE7ivhySYo9RjfhEd37LUMGfq5/FlXzD
 xeApf3EpYLN4YiLT6guOZkcEYJwwSDWURKvXnO4CJ+C9J/jyKhDtbfsIxqJFZ3hdVI
 h1NNgyGbxRhos8OIeMEELJCPntRcrj9qcs3jyhKF+6rrTuuR9Yb1qW7TwweKOpcwqT
 y1Q4Tb/bn0LlYuGvXWrROWh6Zk+0gtXQSCv5eDulhHDinnm1zWuejx4JKkp/jvJQ8R
 LVo6QVPvyuAIA==
Message-ID: <sashiko-outbox-236225@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/3] drm/panthor: Expose performance counter queries
 and ioctls
To: "Lukas Zapolskas" <lukas.zapolskas@arm.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261126-panthor-performance-counters-v8-3-6e7db0ec33f5@arm.com>
References: <20261126-panthor-performance-counters-v8-0-6e7db0ec33f5@arm.com>
 <20261126-panthor-performance-counters-v8-3-6e7db0ec33f5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 21:16:07 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/panthor: infinite busy-loop in
  panthor_perf_handle_fw_events()
- [Medium] drm/panthor: race between panthor_perf_pool_destroy() and
  unplug
- [Medium] drm/panthor: PRFCNT_EN overwrite in
  panthor_perf_handle_fw_samples()
--

commit b28f9d76443cda266099b6a812924734c3213c0a
Author: Lukas Zapolskas <lukas.zapolskas@arm.com>

drm/panthor: Expose performance counter queries and ioctls

This commit exposes the DRM_PANTHOR_DEV_QUERY_PERF_INFO device query and the
five performance counter session ioctls, and wraps the session ioctls with a
drm_dev_enter()/drm_dev_exit() cleanup class.

> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pant=
hor/panthor_drv.c
> index 09cc3f699154a..e6e708d9e18f0 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c

[ ... ]

> @@ -1590,6 +1599,110 @@ static int panthor_ioctl_bo_query_info(struct drm=
_device *ddev, void *data,
>  	return 0;
>  }
> =20
> +static int panthor_drm_dev_enter(struct drm_device *ddev)
> +{
> +	int cookie;
> +
> +	if (!drm_dev_enter(ddev, &cookie))
> +		return -ENODEV;
> +
> +	return cookie;
> +}
> +
> +static void panthor_drm_dev_exit(int cookie)
> +{
> +	if (cookie >=3D 0)
> +		drm_dev_exit(cookie);
> +}
> +
> +DEFINE_CLASS(panthor_drm_dev, int, panthor_drm_dev_exit(_T),
> +	     panthor_drm_dev_enter(ddev), struct drm_device *ddev)
> +
> +static int panthor_ioctl_perf_session_create(struct drm_device *ddev, vo=
id *data,
> +					     struct drm_file *file)
> +{
> +	int ret;
> +	unsigned long sid =3D 0;
> +	struct drm_panthor_perf_session_create *args =3D data;
> +
> +	CLASS(panthor_drm_dev, cookie)(ddev);
> +	if (cookie < 0)
> +		return cookie;
> +
> +	if (args->pad)
> +		return -EINVAL;
> +
> +	ret =3D panthor_perf_session_create(file, args, &sid);
> +	if (ret)
> +		return ret;
> +
> +	return sid;
> +}

[Severity: Medium]
Once panthor_ioctl_perf_session_create() registers a session in
pfile->sessions, can closing the DRM file race with panthor_device_unplug()
and cause a use-after-free or NULL pointer dereference in
panthor_perf_pool_destroy()?

The session ioctls guard against device unplug with panthor_drm_dev, but
panthor_postclose() -> panthor_perf_pool_destroy() does not call
drm_dev_enter(), and panthor_perf_unplug() does not take perf->op_lock:

CPU0                                  CPU1
panthor_postclose()
  panthor_perf_pool_destroy()
    perf =3D pfile->ptdev->perf
                                      panthor_device_unplug()
                                        panthor_fw_unplug()
                                          panthor_perf_unplug()
                                            panthor_kernel_bo_destroy(perf-=
>rb)
                                            perf->rb =3D NULL
                                            ptdev->perf =3D NULL
                                          /* destroys fw section BOs */
    guard(mutex)(&perf->op_lock)
    perf_disable(perf)
      panthor_perf_fw_stop_sampling()
        /* accesses destroyed glb_iface BO */  <-- use-after-free
    perf_enable(perf)
      panthor_perf_fw_start_sampling()
        panthor_perf_fw_write_config(ptdev->perf)
                                               <-- NULL pointer dereference

> +
> +static int panthor_ioctl_perf_session_start(struct drm_device *ddev, voi=
d *data,
> +					    struct drm_file *file)
> +{
> +	struct panthor_file *pfile =3D file->driver_priv;
> +	struct drm_panthor_perf_session_start *args =3D data;
> +
> +	CLASS(panthor_drm_dev, cookie)(ddev);
> +	if (cookie < 0)
> +		return cookie;
> +
> +	if (args->pad0)
> +		return -EINVAL;
> +
> +	return panthor_perf_session_start(pfile, args->handle, args->user_data);
> +}

[Severity: High]
When a session is active or transitioning while a GPU reset is pending, does
panthor_perf_handle_fw_events() spin in an unthrottled busy-loop on the
WQ_HIGHPRI perf->sample_workq workqueue?

drivers/gpu/drm/panthor/panthor_perf.c:panthor_perf_handle_fw_events() {
    ...
	if (panthor_device_reset_is_pending(ptdev)) {
		queue_work(perf->sample_workq, &perf->sample_work);
		return;
	}
    ...
}

Because perf->sample_work is a non-delayed work item executing on a
WQ_HIGHPRI | WQ_UNBOUND workqueue, re-queueing it from inside its own handl=
er
while ptdev->reset.pending is set causes it to re-run immediately at high
priority without yielding, starving normal-priority workers such as
ptdev->reset.wq or spinning until resume if reset.pending was left set by an
aborted reset during suspend.

> +
> +static int panthor_ioctl_perf_session_sample(struct drm_device *ddev, vo=
id *data,
> +					     struct drm_file *file)
> +{
> +	struct panthor_file *pfile =3D file->driver_priv;
> +	struct drm_panthor_perf_session_sample *args =3D data;
> +
> +	CLASS(panthor_drm_dev, cookie)(ddev);
> +	if (cookie < 0)
> +		return cookie;
> +
> +	if (args->pad0)
> +		return -EINVAL;
> +
> +	return panthor_perf_session_sample(pfile, args->handle, args->user_data=
);
> +}

[Severity: Medium]
When panthor_perf_handle_fw_samples() accumulates multiple firmware samples
in one pass (insert_idx - extract_idx > 1), does overwriting
blk->counters[PANTHOR_CTR_PRFCNT_EN] cause session_populate_sample() to lea=
ve
unrequested counter values in the user ringbuffer?

drivers/gpu/drm/panthor/panthor_perf.c:panthor_perf_handle_fw_samples() {
    ...
			blk->counters[PANTHOR_CTR_TIMESTAMP_LO] =3D block[PANTHOR_CTR_TIMESTAMP_=
LO];
			blk->counters[PANTHOR_CTR_TIMESTAMP_HI] =3D block[PANTHOR_CTR_TIMESTAMP_=
HI];
			blk->counters[PANTHOR_CTR_PRFCNT_EN] =3D block[PANTHOR_CTR_PRFCNT_EN];
    ...
			if (prfcnt_en =3D=3D 1)
				goto advance_block;

			for (size_t k =3D PANTHOR_HEADER_COUNTERS;
			     k < ptdev->perf_info.counters_per_block; k++)
				blk->counters[k] +=3D block[k];
    ...
}

The counter values are summed across all samples in [extract_idx, insert_id=
x),
but PANTHOR_CTR_PRFCNT_EN is overwritten with the last non-zero prfcnt_en
instead of being bitwise-ORed.  Because session_populate_sample() copies the
entire accumulated perf_sample into the user-mapped session BO with memcpy()
and only zeroes out unrequested counters that are set in the final
PANTHOR_CTR_PRFCNT_EN mask, any counter group enabled in an earlier sample =
of
the batch but not the last one is not cleared.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-panthor-pe=
rformance-counters-v8-0-6e7db0ec33f5@arm.com?part=3D3
