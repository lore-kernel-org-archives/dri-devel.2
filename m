Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199F8C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 01:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B9A10E5AC;
	Sat,  5 Sep 2026 01:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jucplZxF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C2B10E5AC
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:02:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA4F7439B8
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6C21F00A3D;
 Sat,  5 Sep 2026 01:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788570144;
 bh=T/L5w8GLxq92bhPhGN6ANbxbq0xQl0UssMsqXedAUFg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jucplZxFfeWQFAYZejtc/ycfJTPswA3rqawZue7tGKld7wvR+dIOtMdewpKrFVef+
 EU0+1fOkYWVXR2cIqi3z3ge036ZMUuF4G3HxQw8KOlG67Sc8EO2kehrS4hCgygV313
 KlvSxJdVR5QgY1aDTsUe5v5pdVFWe/hf6fqWwKdNCSaerDt5EV0Ea5vphfaMvFRhSx
 24YkS4ZmYxFDYYMHhP4bWzvUTC90voN7EyhFThL9KDdxH3vZxjymsPCmgXHlSrRdZc
 LQWOA+x4k+G4VgegaXT89B5WIGgEyIhVjATmPj1U8QaizjtDF37/3SrybgFjMNGqZ2
 wIBG9hwDk3IvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/19] accel: ethosu: Disable clocks on PM setup failure
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-3-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-3-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 01:02:24 +0000
Message-Id: <20260905010224.8B6C21F00A3D@smtp.kernel.org>
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
- [High] The driver leaks hardware clocks on removal because it fails to sy=
nchronously suspend the device or flush pending autosuspends before PM runt=
ime is disabled.
- [High] Destroying the DRM scheduler in `ethosu_remove()` while userspace =
holds open file descriptors leads to a Use-After-Free in `ethosu_postclose(=
)`.
- [Medium] The return value of `ethosu_sram_init()` is ignored, which can c=
ause the driver to silently mask memory allocation failures.
--

commit 527f62d6ec40e5aa68386e337081401539f1068b
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Disable clocks on PM setup failure

ethosu_init() enables the clocks directly to reset and query the NPU
before runtime PM takes over. If runtime-PM setup fails, the error path
returns while those clocks remain enabled. Disable the clocks before
returning the setup error to balance the initial direct resume.

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index c684e28ac7871..65b148e770e57 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -311,8 +311,10 @@ static int ethosu_init(struct ethosu_device *ethosud=
ev)
>  	pm_runtime_set_autosuspend_delay(ethosudev->base.dev, 50);
>  	pm_runtime_use_autosuspend(ethosudev->base.dev);
>  	ret =3D devm_pm_runtime_set_active_enabled(ethosudev->base.dev);
> -	if (ret)
> +	if (ret) {
> +		ethosu_device_suspend(ethosudev->base.dev);
>  		return ret;
> +	}
>  	pm_runtime_get_noresume(ethosudev->base.dev);
> =20
>  	ethosudev->npu_info.id =3D id =3D readl_relaxed(ethosudev->regs + NPU_R=
EG_ID);

[Severity: Medium]
This is a pre-existing issue, but should the return value of
ethosu_sram_init() be checked in ethosu_init()?

drivers/accel/ethosu/ethosu_drv.c:ethosu_init() {
...
	ethosu_sram_init(ethosudev);

	if (!ethosu_is_u65(ethosudev))
		ethosudev->pmu_regs +=3D 0x1000;
...
}

If gen_pool_dma_alloc() fails in ethosu_sram_init(), it returns -ENOMEM.
However, ethosu_init() ignores this return value and continues initializati=
on
with a 0-sized SRAM pool.

If SRAM is configured in the device tree but allocation fails, the error is
suppressed.

[Severity: High]
This is a pre-existing issue, but does this driver leak hardware clocks on
removal?

drivers/accel/ethosu/ethosu_drv.c:ethosu_remove() {
	struct ethosu_device *ethosudev =3D dev_get_drvdata(&pdev->dev);

	drm_dev_unregister(&ethosudev->base);
	ethosu_job_fini(ethosudev);
	if (ethosudev->sram)
		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
			      ethosudev->npu_info.sram_size);
}

It appears the remove function completes without synchronously suspending t=
he
device or flushing pending autosuspends before PM runtime is disabled.

If a job completes and releases its PM reference via
pm_runtime_put_autosuspend() (delay 50ms), and the device is unbound via
ethosu_remove() before the autosuspend timer expires, the devm teardown
sequence will call pm_runtime_disable().

This cancels pending autosuspend timers without suspending the hardware,
leaving the clocks permanently enabled.

As stated in the subsystem guidelines, synchronous suspend
(pm_runtime_force_suspend() or pm_runtime_put_sync()) is required before
pm_runtime_disable().

[Severity: High]
This is a pre-existing issue, but could destroying the DRM scheduler in
ethosu_remove() while userspace holds open file descriptors lead to a
use-after-free?

If userspace has an open file descriptor for the device and a privileged us=
er
unbinds the driver via sysfs, ethosu_remove() calls ethosu_job_fini(), which
executes drm_sched_fini(&dev->sched).

This frees the scheduler's runqueues (sched->sched_rq[i]).

Later, when userspace closes the file descriptor, the DRM core invokes:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_close() {
	struct drm_sched_entity *entity =3D &ethosu_priv->sched_entity;

	drm_sched_entity_destroy(entity);
}

drm_sched_entity_destroy() attempts to flush the entity by accessing the fr=
eed
scheduler runqueues. This accesses entity->rq->sched, where entity->rq is a
dangling pointer to the freed runqueue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D3
