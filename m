Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5B606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPZ80kof
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE20C11234C;
	Thu, 29 Oct 2026 14:26:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FE8D112368
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:26:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D89236025A
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746A81F01828;
 Thu, 29 Oct 2026 14:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793283961;
 bh=xOebAHIgteBm/QdjMHIP+c4BDAPTpBSqCedBVwmcDHU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FPZ80kofPTLAWGLGfLzlfl/K2PqPSsC04Igw9Si3Qw1DPPWJlGrX3WT7yhAiG7EES
 d2/bYH/wmVnvXjg1pz3CoPhKn03kDOd4/92zB7UeEfFcFeDjlNkOeRmfGf7xXvURGt
 vcEbWvu1UjGro0Dm/Z6/yplGSL1+0C7jSgU7znO+/b4nKV3dytCCf2Dsi1gr06ZHUe
 cOUxyOayenOr1xmiPlr5JmvHroHt4+Cn0T4d9aOrQ8UwxVDomsWm95N5CCCKkabWvT
 deNMRsvUJzeZaV6SLLY5rhs3bV9EmhV5J6eu+tdO7dNDOr6LG+5FjEiGoWLKij4nMN
 4fS3UuCoeZhQw==
Message-ID: <sashiko-outbox-189512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/31] accel: ethosu: Guard operations after unplug
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-ethosu-fixes-v4-9-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-9-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:26:01 +0000
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
- [Medium] accel: ethosu: mixing __free() and scoped_guard() with goto clea=
nup labels
--

commit cbd771f7e8b7995eaa7aedcd81a7cde35a4b6ada
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Guard operations after unplug

This commit guards ethosu device file open and private ioctl operations
with drm_dev_enter() and drm_dev_exit(), and switches device removal from
drm_dev_unregister() to drm_dev_unplug(). It also drops drm_dev_enter()
from the BO wait ioctl so fence waits do not delay scheduler teardown.

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index 6875ed17a004d..91b2c2ab0a03e 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
[ ... ]
> @@ -139,27 +132,34 @@ static int ethosu_ioctl_cmdstream_bo_create(struct =
drm_device *ddev, void *data,
> =20
>  static int ethosu_open(struct drm_device *ddev, struct drm_file *file)
>  {
> -	int ret =3D 0;
> +	struct ethosu_file_priv __free(kfree) * priv =3D NULL;
> +	int cookie, ret;
> =20
>  	if (!try_module_get(THIS_MODULE))
>  		return -EINVAL;
> +	if (!drm_dev_enter(ddev, &cookie)) {
> +		module_put(THIS_MODULE);
> +		return -ENODEV;
> +	}
> =20
> -	struct ethosu_file_priv __free(kfree) *priv =3D kzalloc_obj(*priv);
> +	priv =3D kzalloc_obj(*priv);
>  	if (!priv) {
>  		ret =3D -ENOMEM;
> -		goto err_put_mod;
> +		goto err_dev_exit;
>  	}
>  	priv->edev =3D to_ethosu_device(ddev);
> =20
>  	ret =3D ethosu_job_open(priv);
>  	if (ret)
> -		goto err_put_mod;
> +		goto err_dev_exit;
> =20
>  	ethosu_perfmon_open_file(priv);
>  	file->driver_priv =3D no_free_ptr(priv);
> +	drm_dev_exit(cookie);
>  	return 0;
> =20
> -err_put_mod:
> +err_dev_exit:
> +	drm_dev_exit(cookie);
>  	module_put(THIS_MODULE);
>  	return ret;
>  }

[Severity: Medium]
In drivers/accel/ethosu/ethosu_drv.c, ethosu_open() declares priv with
__free(kfree) =3D NULL at the top of the function before try_module_get() a=
nd
drm_dev_enter(), and then mixes __free(kfree) with goto err_dev_exit when
kzalloc_obj() or ethosu_job_open() fails.

Because scope-based cleanup runs when the function scope exits after the
err_dev_exit label executes, drm_dev_exit(cookie) and
module_put(THIS_MODULE) will run before kfree(priv), reversing the reverse
acquisition (lifo) teardown order and mixing goto error handling with
cleanup.h helpers.

Should ethosu_open() avoid mixing __free(kfree) and goto labels so that
priv is freed before exiting the drm device section and dropping the module
reference?

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index f22cacb19e3dc..8ffdc83d06f98 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
[ ... ]
> @@ -557,26 +558,34 @@ static int ethosu_ioctl_submit_job(struct drm_devic=
e *dev, struct drm_file *file
>  int ethosu_ioctl_submit(struct drm_device *dev, void *data, struct drm_f=
ile *file)
>  {
>  	struct drm_ethosu_submit *args =3D data;
> -	int ret =3D 0;
> +	int cookie, ret =3D 0;
>  	unsigned int i =3D 0;
> =20
> +	if (!drm_dev_enter(dev, &cookie))
> +		return -ENODEV;
> +
>  	struct drm_ethosu_job __free(kvfree) *jobs =3D
>  		kvmalloc_objs(*jobs, args->job_count);
> -	if (!jobs)
> -		return -ENOMEM;
> +	if (!jobs) {
> +		ret =3D -ENOMEM;
> +		goto out_dev_exit;
> +	}
> =20
>  	if (copy_from_user(jobs,
>  			   (void __user *)(uintptr_t)args->jobs,
>  			   args->job_count * sizeof(*jobs))) {
>  		drm_dbg(dev, "Failed to copy incoming job array\n");
> -		ret =3D -EFAULT;
> +		ret =3D -EFAULT;
> +		goto out_dev_exit;
>  	}
> =20
>  	for (i =3D 0; i < args->job_count; i++) {
>  		ret =3D ethosu_ioctl_submit_job(dev, file, &jobs[i], args->perfmon_id);
>  		if (ret)
> -			return ret;
> +			goto out_dev_exit;
>  	}
> =20
> -	return 0;
> +out_dev_exit:
> +	drm_dev_exit(cookie);
> +	return ret;
>  }
> diff --git a/drivers/accel/ethosu/ethosu_perfmon.c b/drivers/accel/ethosu=
/ethosu_perfmon.c
> index 2a9b3cc1447bd..8d3635ba3347b 100644
> --- a/drivers/accel/ethosu/ethosu_perfmon.c
> +++ b/drivers/accel/ethosu/ethosu_perfmon.c
[ ... ]
> @@ -260,44 +289,54 @@ int ethosu_ioctl_perfmon_set_global(struct drm_devi=
ce *dev, void *data,
>  	struct ethosu_file_priv *ethosu_priv =3D file_priv->driver_priv;
>  	struct drm_ethosu_perfmon_set_global *req =3D data;
>  	struct ethosu_device *ethosu =3D to_ethosu_device(dev);
> -	struct ethosu_perfmon *perfmon;
> +	struct ethosu_perfmon *old =3D NULL, *perfmon;
> +	int cookie, ret =3D 0;
> =20
> -	if (req->flags & ~DRM_ETHOSU_PERFMON_CLEAR_GLOBAL)
> -		return -EINVAL;
> +	if (!drm_dev_enter(dev, &cookie))
> +		return -ENODEV;
> +
> +	if (req->flags & ~DRM_ETHOSU_PERFMON_CLEAR_GLOBAL) {
> +		ret =3D -EINVAL;
> +		goto out_dev_exit;
> +	}
> =20
>  	perfmon =3D ethosu_perfmon_find(ethosu_priv, req->id);
> -	if (!perfmon)
> -		return -EINVAL;
> +	if (!perfmon) {
> +		ret =3D -EINVAL;
> +		goto out_dev_exit;
> +	}
> =20
>  	/* If the request is to clear the global performance monitor */
>  	if (req->flags & DRM_ETHOSU_PERFMON_CLEAR_GLOBAL) {
> -		struct ethosu_perfmon *old;
> -
>  		scoped_guard(mutex, &ethosu->perfmon_state.lock) {
>  			old =3D ethosu->global_perfmon;
> -			if (!old) {
> -				ethosu_perfmon_put(perfmon);
> -				return -EINVAL;
> +			if (old) {
> +				ethosu->global_perfmon =3D NULL;
> +				ethosu_perfmon_stop_locked(ethosu, old, true);
>  			}
> +		}
> =20
> -			ethosu->global_perfmon =3D NULL;
> -			ethosu_perfmon_stop_locked(ethosu, old, true);
> +		ethosu_perfmon_put(perfmon);
> +		if (!old) {
> +			ret =3D -EINVAL;
> +			goto out_dev_exit;
>  		}
> =20
>  		ethosu_perfmon_put(old);
> -		ethosu_perfmon_put(perfmon);
> =20
> -		return 0;
> +		goto out_dev_exit;
>  	}
> =20
>  	scoped_guard(mutex, &ethosu->perfmon_state.lock) {
> -		if (ethosu->perfmon_state.active || ethosu->global_perfmon) {
> -			ethosu_perfmon_put(perfmon);
> -			return -EBUSY;
> -		}
> -
> -		ethosu->global_perfmon =3D perfmon;
> +		if (ethosu->perfmon_state.active || ethosu->global_perfmon)
> +			ret =3D -EBUSY;
> +		else
> +			ethosu->global_perfmon =3D perfmon;
>  	}
> +	if (ret)
> +		ethosu_perfmon_put(perfmon);
> =20
> -	return 0;
> +out_dev_exit:
> +	drm_dev_exit(cookie);
> +	return ret;
>  }

[Severity: Medium]
Similarly, in drivers/accel/ethosu/ethosu_job.c, ethosu_ioctl_submit()
mixes a mid-function __free(kvfree) declaration for jobs with goto
out_dev_exit, which causes drm_dev_exit(cookie) to run before kvfree(jobs).
In drivers/accel/ethosu/ethosu_perfmon.c, ethosu_ioctl_perfmon_set_global()
also mixes scoped_guard(mutex, &ethosu->perfmon_state.lock) with goto
out_dev_exit labels.

Per include/linux/cleanup.h, goto-based cleanup and scope-based cleanup
helpers should not be mixed within the same function. Could these functions
either use scope-based cleanup consistently or use explicit cleanup along
the goto paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-ethosu-fix=
es-v4-0-4aa25e22578e@kernel.org?part=3D9
