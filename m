Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17922C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 05:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71CDA10E544;
	Wed,  9 Sep 2026 05:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KD/TwhJ9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E013710E544
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 05:51:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83B1B438AD;
 Wed,  9 Sep 2026 05:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EA31F00A3A;
 Wed,  9 Sep 2026 05:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788933100;
 bh=wY0dgqQzdeCiUdLnkLIuQkS6BZkXE1Xym7yGIArrxOw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KD/TwhJ9zjrA/Pu3pSlYnm8fW7n0gBdt/cEOI8SrWN4Q37KtpJrDyfGwCLXIV6UXw
 NyYKkwDzx9rgMWbaqTBygWW05MfNLE10ppD9RW+2WQGIrguJSMQvXiK0H9r3pDKYR2
 48OUgoavIi+/usaDtcxMURHKw3gwJ94sG5opY9Nq6NLxcZqlkpcryrtzAfA8LlqN7K
 pR1d5zMFuvsLwEP1CiJzt33+Kvg98LwHTvaNaGSLf0jjVsshFTmYUjSey1mXlkaIZj
 PRwEcI7Q3bVWTPKgTf6c5l8FCuAFYyooeCtETf1mBtLfdRvM4HMf83/Lk3sf8GV1uo
 lLQl6NRaEkqBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vc4: drain the hangcheck timer and works on V3D unbind
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909053509.657074-1-fanwu01@zju.edu.cn>
References: <20260909053509.657074-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 05:51:39 +0000
Message-Id: <20260909055140.46EA31F00A3A@smtp.kernel.org>
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

New issues:
- [Medium] Canceling `job_done_work` without explicitly draining `job_done_=
list` directly leaks completed jobs and resources.

Pre-existing issues:
- [High] Missing drm_dev_enter() in DRM ioctls allows concurrent V3D unbind=
 to directly cause a NULL pointer dereference.
- [High] Spurious interrupt execution directly after `vc4->v3d` clearance c=
auses a NULL pointer crash.
--

commit c625fc5a6f0d8fd20c510d6e8829315b01c15ab3
Author: Fan Wu <fanwu01@zju.edu.cn>

drm/vc4: drain the hangcheck timer and works on V3D unbind

The hangcheck timer, which every submitted job arms and which queues
reset_work once a job stops making progress, and the job_done_work,
which the render-done interrupt queues to release completed jobs, are
never drained at teardown. This commit shuts the hangcheck timer down
and cancels reset_work and job_done_work during vc4_v3d_unbind().

> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> index f32410420d3e4..11d4df3164b49 100644
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
[ ... ]
> @@ -497,8 +498,18 @@ static void vc4_v3d_unbind(struct device *dev, struc=
t device *master,
>  	struct drm_device *drm =3D data;
>  	struct vc4_dev *vc4 =3D to_vc4_dev(drm);
> =20
> +	/* Kill the timer, then reset_work: vc4_irq_reset() re-enables it. */
> +	if (vc4->gen =3D=3D VC4_GEN_4) {
> +		timer_shutdown_sync(&vc4->hangcheck.timer);
> +		cancel_work_sync(&vc4->hangcheck.reset_work);
> +	}
> +
>  	vc4_irq_uninstall(drm);

[Severity: High]
This is a pre-existing issue, but could this lead to a spurious interrupt
execution causing a NULL pointer crash?

When vc4_v3d_unbind() executes, it disables the hardware interrupts and lat=
er
sets vc4->v3d =3D NULL, but it does not unregister the IRQ handler (since i=
t is
devm-managed by the parent device).

If a spurious interrupt arrives after this point, would vc4_irq() execute a=
nd
unconditionally dereference vc4->v3d via the V3D_READ macro, causing an
immediate crash?

> =20
> +	/* Nothing can queue job_done_work any more; drain it. */
> +	if (vc4->gen =3D=3D VC4_GEN_4)
> +		cancel_work_sync(&vc4->job_done_work);

[Severity: Medium]
Will this cancel_work_sync() directly leak completed jobs and resources?

If there are completed jobs pending in the job_done_list when the device is
unbound, the work is canceled before it can process the list.

Since no subsequent cleanup code (e.g., vc4_gem_destroy()) iterates over and
frees the items in job_done_list, won't these jobs and their associated BOs=
 be
permanently leaked?

> +
>  	/* Disable the binner's overflow memory address, so the next
>  	 * driver probe (if any) doesn't try to reuse our old
>  	 * allocation.

[Severity: High]
This isn't a bug introduced by this patch, but does the ioctl path lack
drm_dev_enter() protection, allowing concurrent V3D unbind to directly cause
a NULL pointer dereference?

A user-space application could concurrently call DRM_IOCTL_VC4_SUBMIT_CL wh=
ile
the administrator unbinds the v3d component via sysfs. The ioctl checks
if (!vc4->v3d) without holding a reference (e.g., drm_dev_enter()):

drivers/gpu/drm/vc4/vc4_gem.c:vc4_submit_cl_ioctl() {
	if (!vc4->v3d) {
		DRM_DEBUG("VC4_SUBMIT_CL with no VC4 V3D probed\n");
		return -ENODEV;
	}
	...
}

Immediately after this check, vc4_v3d_unbind() executes and sets
vc4->v3d =3D NULL.

Would the ioctl then proceed to access vc4->v3d (e.g., in vc4_v3d_pm_get()),
resulting in a direct NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909053509.6570=
74-1-fanwu01@zju.edu.cn?part=3D1
