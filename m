Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3083CC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D1510E1CA;
	Thu, 24 Sep 2026 18:24:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LWK9q0ds";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC9610E1CA
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:24:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 227E2601F6;
 Thu, 24 Sep 2026 18:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48391F000FF;
 Thu, 24 Sep 2026 18:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790274277;
 bh=XnCNg4ImSp6U3oQqzf4APEYwBYzaGSNBJF9J8Ob7B9M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LWK9q0dsH4FKMoqMFv2uVx4Rgze3ktnqad/VyecVIX3MTfVoQ+inlOZtHWk6Hi5FH
 17NIixAG39brrlX99RObZs9ZkU/jBnODEQgCSe3rXyW4nx9mxDBpLzx+rPPBcC6ZVT
 fOTKstGc2Ds71jThm61ce+SV7Ki+C8b9ApN1jZI9n1kIYxwRHpFgARFv6Gb/PYM/MO
 HYL6W0XgmohjWOQkzQXM69EjknM4EwRWHa7tzNcJkCZ8RhRTCaaAvTJh1wZ8yuVOs0
 QnjOZWFgI+YkUPCAHemuhQuDfGi9JWGHy85H3e/6qShRCvWWFCTlHuSISByl4mI/0+
 lN8u6EDtAti5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/15] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260924-claude-fixes-v10-6-755929b3cc19@collabora.com>
References: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
 <20260924-claude-fixes-v10-6-755929b3cc19@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:24:37 +0000
Message-Id: <20260924182437.A48391F000FF@smtp.kernel.org>
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
- [High] drm/panfrost: PM domain race in remove path due to early pm_runtim=
e_set_suspended()
--

commit a90e5a94bd1de191941b3e25b2a2eb1b45c873d9
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove

This commit adjusts the PM reference count at device probe and removal
time to ensure the device goes to sleep when idle and doesn't leak
references on unload. It also reorders pm_runtime_set_suspended() to
occur before panfrost_device_fini() in the teardown paths so resource
unwinding happens in the opposite order of initialization.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 55fc22e8d4d4e..02ddd391231c0 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
[ ... ]
> @@ -866,13 +871,16 @@ static int panfrost_probe(struct platform_device *p=
dev)
>  	if (err < 0)
>  		goto err_out1;
> =20
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
> =20
>  	return 0;
> =20
>  err_out1:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> -	panfrost_device_fini(pfdev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> +	panfrost_device_fini(pfdev);

[Severity: High]
Does moving pm_runtime_set_suspended() before panfrost_device_fini() in
panfrost_probe() create a race condition with the PM workqueue?

When pm_runtime_set_suspended() is called, it triggers rpm_put_suppliers()
which drops the active reference for the attached secondary PM domains
(shader/tiler) and queues an asynchronous suspend via pm_request_idle().

Concurrently, panfrost_device_fini() proceeds to execute
panfrost_gpu_fini(), which writes to GPU MMIO (e.g., SHADER_PWROFF_LO) and
polls for power transitions.

Could the PM workqueue power off the domains asynchronously during this
teardown, leading to hardware lockups or fatal bus errors if MMIO accesses
are made to unpowered domains?

>  err_out0:
>  	return err;
>  }
> @@ -884,9 +892,11 @@ static void panfrost_remove(struct platform_device *=
pdev)
>  	drm_dev_unregister(&pfdev->base);
> =20
>  	pm_runtime_get_sync(pfdev->base.dev);
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> -	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> +	panfrost_device_fini(pfdev);

[Severity: High]
Can this race condition also happen in the panfrost_remove() path?

Similar to the probe error path, setting the status to RPM_SUSPENDED
before panfrost_device_fini() might prematurely power off the secondary PM
domains while hardware teardown is still accessing them.

>  }
> =20
>  static ssize_t profiling_show(struct device *dev,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-claude-fix=
es-v10-0-755929b3cc19@collabora.com?part=3D6
