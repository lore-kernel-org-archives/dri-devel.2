Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8BDC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 408B010E422;
	Mon, 13 Jul 2026 08:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BzFhdGsK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81C1E10E422
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:45:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B68A7601D9;
 Mon, 13 Jul 2026 08:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FB71F000E9;
 Mon, 13 Jul 2026 08:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783932330;
 bh=08M0kGlLdXtDuH2Pe7aLBP8JT+c07YRGGizKjhwgbE8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BzFhdGsKTqCcAS0tR4lmSZfX6r8W3wFVcYexiP8a/3mR8VPk0MGGIaFfXXCwIkLBa
 nWnJUqVKq80qc7bOGqQJ19pfj4+WcmfjGve2j6xWbkmPWNwC37Z7fe2nZM3Udu03Q3
 4xdN/Lf5U5wzVmjIru3ydR7xLQSKDkHHrbFYwODuncPoOQaF7hdG/CUQ1ydL9+6Miq
 NpShdG55/2k9kz+GJg+OrWdsmZGY3Z8fBunIRQudjcIAOeQCXOKwdAoyzEXDul9Ih2
 /vKtfnPgwJ6qGHygxd3I3KwkNIdH1Zc2hsIIEYXHD8VBwhpZs0Ru9NSBYbUVJVwNoj
 bvXA1MGgkM7dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe/oa: Check managed mutex initialization errors
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713083053.321091-1-lilinmao@kylinos.cn>
References: <20260713083053.321091-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:45:29 +0000
Message-Id: <20260713084530.42FB71F000E9@smtp.kernel.org>
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
- [High] Missing drm_dev_enter/drm_dev_exit protection in OA stream file op=
erations leads to NULL pointer dereferences and UAF on device unbind.
- [High] Sync entries and memory are permanently leaked when xe_oa_emit_oa_=
config() fails in xe_oa_config_locked().
- [High] Concurrent execution of xe_oa_fini and xe_oa_add_config_ioctl can =
cause radix tree corruption and a memory leak because the ioctl lacks drm_d=
ev_enter() protection.
--

--- Patch [1]: [PATCH] drm/xe/oa: Check managed mutex initialization errors=
 ---
commit 6dc1dc862e4088df59048042e54f422ac372d344
Author: Linmao Li <lilinmao@kylinos.cn>

drm/xe/oa: Check managed mutex initialization errors

drmm_mutex_init() can fail while registering its managed cleanup action.
On failure, the reset path destroys the mutex, so continuing OA setup
leaves an unusable lock that later paths may acquire.

Return the error from per-GT OA initialization and abort device-wide OA
initialization if the metrics lock cannot be initialized.

Fixes: a9f905ae7b6f ("drm/xe/oa/uapi: Initialize OA units")
Fixes: cdf02fe1a94a ("drm/xe/oa/uapi: Add/remove OA config perf ops")

> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
> index b3acbcd678b7c..302a2ef4494be 100644
> --- a/drivers/gpu/drm/xe/xe_oa.c
> +++ b/drivers/gpu/drm/xe/xe_oa.c
> @@ -2718,9 +2718,7 @@ static int xe_oa_init_gt(struct xe_gt *gt)
> =20
>  	__xe_oa_init_oa_units(gt);
> =20
> -	drmm_mutex_init(&gt_to_xe(gt)->drm, &gt->oa.gt_lock);
> -
> -	return 0;
> +	return drmm_mutex_init(&gt_to_xe(gt)->drm, &gt->oa.gt_lock);
>  }
> =20
>  static void xe_oa_print_gt_oa_units(struct xe_gt *gt)
> @@ -2860,7 +2858,10 @@ int xe_oa_init(struct xe_device *xe)
>  	oa->xe =3D xe;
>  	oa->oa_formats =3D oa_formats;
> =20
> -	drmm_mutex_init(&oa->xe->drm, &oa->metrics_lock);
> +	ret =3D drmm_mutex_init(&oa->xe->drm, &oa->metrics_lock);
> +	if (ret)
> +		goto exit;
> +
>  	idr_init_base(&oa->metrics_idr, 1);
> =20
>  	ret =3D xe_oa_init_oa_units(oa);

While reviewing this patch, I noticed a few pre-existing issues in this fil=
e:

[ ... ]

> static ssize_t xe_oa_read(struct file *file, char __user *buf,
> 			  size_t count, loff_t *ppos)
> {
> 	struct xe_oa_stream *stream =3D file->private_data;
[ ... ]
> 			mutex_lock(&stream->stream_lock);
> 			ret =3D __xe_oa_read(stream, buf, count, &offset);
                    ^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does xe_oa_read() lack
drm_dev_enter/drm_dev_exit protection?

File operations like xe_oa_read() and xe_oa_ioctl() operate on an independe=
nt
file descriptor. When the device unbinds, devm-managed mappings like
stream->gt->mmio are released.

If a local user calls read() or ioctl() on the open stream file descriptor =
after
the device is hot-unplugged or unbound, can this cause a NULL pointer
dereference or a kernel crash when accessing unmapped MMIO memory?

[ ... ]

> 	stream->num_syncs =3D param.num_syncs;
> 	stream->syncs =3D param.syncs;
>=20
> 	err =3D xe_oa_emit_oa_config(stream, config);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but if xe_oa_emit_oa_config() fails, does this
permanently leak the stream->syncs memory and the dma_fence references?

If the user provides valid sync entries but xe_oa_emit_oa_config() fails
due to memory pressure or batch buffer submission failures, the error is
propagated without cleaning up stream->syncs.

Since xe_oa_emit_oa_config() only frees stream->syncs on the success path, =
and
xe_oa_stream_destroy() does not free stream->syncs, is there any path that
cleans up these references after a failure?

[ ... ]

> static void xe_oa_fini(void *arg)
> {
> 	struct xe_device *xe =3D arg;
> 	struct xe_oa *oa =3D &xe->oa;
>=20
> 	if (!oa->xe)
> 		return;
>=20
> 	idr_for_each(&oa->metrics_idr, destroy_config, oa);
> 	idr_destroy(&oa->metrics_idr);
>=20
> 	oa->xe =3D NULL;
> }

> int xe_oa_add_config_ioctl(struct drm_device *dev, u64 data, struct drm_f=
ile *file)
> {
[ ... ]
> 	if (!oa->xe) {
> 		drm_dbg(&xe->drm, "xe oa interface not available for this system\n");
> 		return -ENODEV;
> 	}
[ ... ]
> 	id =3D idr_alloc(&oa->metrics_idr, oa_config, 2, 0, GFP_KERNEL);
             ^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does concurrent execution of xe_oa_fini()=
 and
xe_oa_add_config_ioctl() cause radix tree corruption?

xe_oa_add_config_ioctl() checks if (!oa->xe) locklessly and does not use
drm_dev_enter() to guarantee the hardware device remains bound.

Concurrently, driver unbind invokes xe_oa_fini(), which calls
idr_destroy(&oa->metrics_idr) before setting oa->xe =3D NULL.

If the ioctl evaluates !oa->xe before xe_oa_fini() nullifies it, could it
proceed to call idr_alloc() on a concurrently destroyed IDR structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713083053.3210=
91-1-lilinmao@kylinos.cn?part=3D1
