Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2E2606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOWwqsrQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8081710E058;
	Sat, 31 Oct 2026 08:50:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E4110E058
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 08:50:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8ADFB41157;
 Sat, 31 Oct 2026 08:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510971F000C1;
 Sat, 31 Oct 2026 08:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793436601;
 bh=KqU5jt1LhrgvdnbkCG2Lsjgv/TxzuB5piVjCOjV6LMY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mOWwqsrQh26fAki+25JjG4xo121E6AqhfdVTPVCcweDopa5fjB3LzaTU1/ui802GE
 +ENAaji/KnyIWyq7F+NquRu2STCDhgc/LesIp35glyalU30NEIqlI8I/7DZ7f1LKTp
 HhPbJVV5W3euFFwff/Vb6t8GBBX8SJu66oCqGEs83/PZEnA/5BkSiBzRlBcyO000kc
 mnbZ96mEHVjVmJzcKzg4w+6U65YRG1+07+QKFcEZfBS6hi30vaunwBSYNKwyuI42NW
 x0ABlakXHlhAnQsbkJr8S9FvYm94wHh5kfoMFsuVpwGApG21YCyEcDjzsNywfqoVUE
 ofQKAI7dyNeLA==
Message-ID: <sashiko-outbox-191847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/rocket: Report per-core engine usage through fdinfo
To: "Sidong Yang" <sidong.yang@furiosa.ai>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261031083642.1076356-1-sidong.yang@furiosa.ai>
References: <20261031083642.1076356-1-sidong.yang@furiosa.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 08:50:00 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] accel/rocket: out-of-bounds access on elapsed_ns[] when num_cores =
changes
--

commit 2905630551e831e7463221f4054336a62cdc4cc3
Author: Sidong Yang <sidong.yang@furiosa.ai>

accel/rocket: Report per-core engine usage through fdinfo

This commit adds per-core engine usage accounting for client jobs on the
Rocket NPU and exposes the per-core elapsed nanoseconds and BO memory stats
through fdinfo.

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 8bbbce594883e..5b81d1ecc0e49 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c

[ ... ]

> @@ -86,10 +107,19 @@ rocket_open(struct drm_device *dev, struct drm_file =
*file)
>  	}
> =20
>  	rocket_priv->rdev =3D rdev;
> +
> +	rocket_priv->engine_usage =3D kzalloc_flex(*rocket_priv->engine_usage,
> +						 elapsed_ns, rdev->num_cores);
> +	if (!rocket_priv->engine_usage) {
> +		ret =3D -ENOMEM;
> +		goto err_free;
> +	}
> +	kref_init(&rocket_priv->engine_usage->kref);
> +
>  	rocket_priv->domain =3D rocket_iommu_domain_create(rdev->cores[0].dev);
>  	if (IS_ERR(rocket_priv->domain)) {
>  		ret =3D PTR_ERR(rocket_priv->domain);
> -		goto err_free;
> +		goto err_put_engine_usage;
>  	}

[ ... ]

> @@ -139,7 +172,29 @@ static const struct drm_ioctl_desc rocket_drm_driver=
_ioctls[] =3D {
>  	ROCKET_IOCTL(FINI_BO, fini_bo),
>  };
> =20
> -DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
> +static void rocket_show_fdinfo(struct drm_printer *p, struct drm_file *f=
ile)
> +{
> +	struct rocket_device *rdev =3D to_rocket_device(file->minor->dev);
> +	struct rocket_file_priv *rocket_priv =3D file->driver_priv;
> +	unsigned int core;
> +
> +	/*
> +	 * These are estimates: the time is taken around the whole period a job
> +	 * occupies a core, so it also covers handling the completion interrupt
> +	 * and, for a job made of several tasks, the gaps between them.
> +	 */
> +	for (core =3D 0; core < rdev->num_cores; core++)
> +		drm_printf(p, "drm-engine-npu%u:\t%llu ns\n", core,
> +			   rocket_priv->engine_usage->elapsed_ns[core]);

[Severity: High]
Can this read or write past the end of rocket_priv->engine_usage->elapsed_n=
s[]
if rdev->num_cores changes after rocket_open()?

In rocket_probe(), the DRM device is registered via rocket_device_init() ->
drm_dev_register() when the first core probes, and rdev->num_cores is then
incremented one by one as each subsequent core probes:

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
	if (rdev =3D=3D NULL) {
		/* First core probing, initialize DRM device. */
		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver);
		...
	}

	unsigned int core =3D rdev->num_cores;
	...
	rdev->cores[core].index =3D core;

	rdev->num_cores++;
}

If userspace (for example systemd-udevd reacting to the drm_dev_register()
uevent, or a client opening the device while remaining cores are still prob=
ing
or deferred) calls rocket_open() before all cores have finished probing,
rocket_priv->engine_usage is allocated with the smaller rdev->num_cores cou=
nt
at that moment. Once the remaining cores finish probing and increment
rdev->num_cores, calling rocket_show_fdinfo() will iterate up to the new
rdev->num_cores and read past the end of elapsed_ns[].

Similarly, if a lower-indexed core is unbound via rocket_remove(),
rdev->num_cores is decremented while higher-indexed cores retain their
original core->index. If a file is opened afterwards, rocket_job_handle_irq=
()
indexing engine_usage->elapsed_ns[core->index] can also write out of bounds:

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
	...
	core->in_flight_job->engine_usage->elapsed_ns[core->index] +=3D
		local_clock() - core->in_flight_job->start_ns;
	...
}

Would it make sense to record the total core count allocated for rdev->cores
in rocket_device_init() (or store the allocated array length in struct
rocket_engine_usage) so that the allocation size and bounds stay consistent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031083642.1076=
356-1-sidong.yang@furiosa.ai?part=3D1
