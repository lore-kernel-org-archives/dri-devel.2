Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6061C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4659310F221;
	Thu, 16 Jul 2026 08:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ioc95cn6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3480C10F221
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 08:41:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E36F840DC0;
 Thu, 16 Jul 2026 08:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5331F00A3D;
 Thu, 16 Jul 2026 08:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784191277;
 bh=qJvG6jf7qAkUuW3esHmQdAKgHHkK+ajwURbJP/Hgw/c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ioc95cn6CYoQ1c3u34h5HZQuzvQtKK8TY0IfOKNH4siKREhDConFP22It7OwTRFos
 eIToA90mAU2ITitSD+EpZU4Dp31m2SuRohwRsaEuFq9MJ5KcXBggY4uvhIrElaNR9S
 8NBIvK/l61fiTF0ooU+Ag+KYe5D1ImSxPXo5TMsEAt0oUvCjSkP9f1Tt7n7jxa8VU8
 XsHw8VhW0wtfrRXvedJhqfQkw4HOujaNWg7RGgEmfXBnd9jaiQNxOaqg1fEmWVBNfh
 5mTI9TRjQ36umQxW2orLLXt/HyDPAakaCYjmZxTSorrdUMfczsGYrf48zpM1Bzrb/q
 kSEy+/63VY+ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] accel/ethosu: propagate SRAM initialization errors
To: zhaoguohan@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716082530.1023538-3-zhaoguohan@kylinos.cn>
References: <20260716082530.1023538-1-zhaoguohan@kylinos.cn>
 <20260716082530.1023538-3-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 08:41:17 +0000
Message-Id: <20260716084117.9C5331F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing hardware stop and wait for active jobs in the device r=
emoval path leads to DMA Use-After-Free.
- [High] The driver registers a shared interrupt handler but fails to check=
 the device PM status before accessing hardware, and its suspend callback l=
acks IRQ synchronization.
- [High] Prematurely calling `drm_sched_fini()` during device removal leads=
 to a Use-After-Free when userspace closes open DRM file entities.
- [High] Missing `drm_dev_enter()` and `drm_dev_exit()` protection in `etho=
su_ioctl_submit` allows a TOCTOU race with device removal.
- [High] Calling `drm_sched_fini()` on `drm_sched_init()` failure causes a =
crash on uninitialized work items.
- [Medium] The device is not synchronously suspended during driver unbind/r=
emoval, leaving its hardware clocks permanently enabled.
--

--- Patch [2]: [PATCH 2/3] accel/ethosu: propagate SRAM initialization erro=
rs ---
commit d63b5342071ce711d48106e8b0fded82dbcf48e8
Author: GuoHan Zhao <zhaoguohan@kylinos.cn>

accel/ethosu: propagate SRAM initialization errors

This patch fixes a bug where ethosu_sram_init() errors were ignored in
ethosu_init(), leading to jobs programming physical address zero for SRAM. =
It
adds proper error propagation and synchronous suspension in the probe path.

Link: https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kyl=
inos.cn?part=3D1

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index d1153b15ca3ee..479156f79bc18 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -320,7 +320,9 @@ static int ethosu_init(struct ethosu_device *ethosude=
v)
>  	ethosudev->npu_info.id =3D id =3D readl_relaxed(ethosudev->regs + NPU_R=
EG_ID);
>  	ethosudev->npu_info.config =3D config =3D readl_relaxed(ethosudev->regs=
 + NPU_REG_CONFIG);
> =20
> -	ethosu_sram_init(ethosudev);
> +	ret =3D ethosu_sram_init(ethosudev);
> +	if (ret)
> +		goto err_runtime_suspend;
> =20
>  	dev_info(ethosudev->base.dev,

[ ... ]

> @@ -389,7 +391,7 @@ static void ethosu_remove(struct platform_device *pde=
v)
>  {
>  	struct ethosu_device *ethosudev =3D dev_get_drvdata(&pdev->dev);
> =20
>  	drm_dev_unregister(&ethosudev->base);
>  	ethosu_job_fini(ethosudev);

[Severity: Medium]
This is a pre-existing issue, but does this removal path lack a synchronous
suspend of the device?

Since devres cleanup will eventually call pm_runtime_disable() which clears
the state but leaves hardware powered on if it was active, will failing to
call pm_runtime_put_sync_suspend() here lead to the clocks and power domains
leaking and remaining active indefinitely?

[Severity: High]
This isn't a bug introduced by this patch, but doesn't ethosu_job_fini()
destroy the DRM scheduler via drm_sched_fini() prematurely?

If userspace still holds a DRM file descriptor open after the device is
unbound, closing the file descriptor will call ethosu_job_close() which
invokes drm_sched_entity_destroy() on the already finalized scheduler.

Can this cause a use-after-free accessing destroyed DRM scheduler structure=
s?

>  	ethosu_sram_fini(ethosudev);
>  }

[Severity: Critical]
This is a pre-existing issue, but is the SRAM freed while the hardware might
still be active?

If ethosu_remove() is executed while the NPU is actively executing a job,
ethosu_sram_fini() will immediately free the SRAM pool via gen_pool_free().

Since there is no halt of the hardware or wait for the in-flight job to
finish, could the hardware continue performing DMA read/writes to the freed
SRAM pool, leading to a DMA use-after-free?

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -230,8 +230,8 @@ static irqreturn_t ethosu_job_irq_handler(int irq, vo=
id *data)
>  {
>  	struct ethosu_device *dev =3D data;
>  	u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);

[Severity: High]
This is a pre-existing issue, but this interrupt is requested with IRQF_SHA=
RED
in ethosu_job_init(). If the device enters autosuspend and turns off its
clocks, could this unconditionally read NPU_REG_STATUS and cause a synchron=
ous
external abort or spurious interrupt logic?

Should ethosu_job_irq_handler() use pm_runtime_get_if_active() before check=
ing
the hardware registers?

Additionally, shouldn't ethosu_device_suspend() call synchronize_irq() to
ensure no handler is mid-flight before disabling clocks?

[ ... ]

> @@ -337,9 +337,7 @@ int ethosu_job_init(struct ethosu_device *edev)
>  	ret =3D drm_sched_init(&edev->sched, &args);
>  	if (ret) {
>  		dev_err(dev, "Failed to create scheduler: %d\n", ret);
>  		goto err_sched;
>  	}
> =20
>  	return 0;
> =20
>  err_sched:
>  	drm_sched_fini(&edev->sched);

[Severity: High]
This isn't a bug introduced by this patch, but should drm_sched_fini() be
called if drm_sched_init() fails?

If drm_sched_init() cleans up its internal resources upon returning an erro=
r,
would unconditionally calling drm_sched_fini() here attempt to destroy
workqueues and free resources that were never successfully initialized,
potentially leading to a panic?

[ ... ]

> @@ -485,9 +483,8 @@ int ethosu_ioctl_submit(struct drm_device *dev, void =
*data, struct drm_file *file
>  {
>  	struct drm_ethosu_submit *args =3D data;
>  	int ret =3D 0;

[Severity: High]
This is a pre-existing issue, but doesn't this ioctl lack drm_dev_enter() a=
nd
drm_dev_exit() unplug protection?

If userspace aggressively calls the DRM_ETHOSU_SUBMIT ioctl while the device
is being unbound, can it race with ethosu_remove()?

Without drm_dev_enter(), this could push a job onto the scheduler via
drm_sched_entity_push_job() while the removal thread is simultaneously
tearing it down with drm_sched_fini(), causing a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716082530.1023=
538-1-zhaoguohan@kylinos.cn?part=3D2
