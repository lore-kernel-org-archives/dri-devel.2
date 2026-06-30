Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5967C43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8B710E1B0;
	Tue, 30 Jun 2026 09:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="apXLlcRX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B397110E1B0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:41:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 967A541083;
 Tue, 30 Jun 2026 09:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597321F000E9;
 Tue, 30 Jun 2026 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782812471;
 bh=nqW2ZwKx0IIdB0uWs0TIrPG22UUaqs1GMeNvP3Cp3m0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=apXLlcRX9gp7JpuQVRIr3ni1NynfkkOEaTbz9AqpfWb4i12VTbpaQnH6uSdcc0a7y
 KAtxAzbHLqgrGW5gL8K3+PWF8h5D8BuuI9svqFSU3HCeVnaDC648SozxV9iXlwBliK
 0v3zlMIzehN4mS5XYAZee1I4Ne5IOdy6q36RHEvWfJRxLkCbXH7KBMUwEF6qjYG3eK
 rjlEltTboiSehKFoIOkZFOoJERdSr+0WCKeLObgrjPdB1UUchUJ0RlqpI+2Sx1nK4y
 rVGqmGRiURK9A7RyVYLHaRW/3DsNpO7nI6y8nJOdb38PE1U5ck9uS00wx6KaCu4lJ3
 oWFTIPHAZ52Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/logicvc: Avoid using DRM resources after
 device is unplugged
To: "Romain Gantois" <romain.gantois@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630-logicvc-uaf-v2-2-99e881833860@bootlin.com>
References: <20260630-logicvc-uaf-v2-0-99e881833860@bootlin.com>
 <20260630-logicvc-uaf-v2-2-99e881833860@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:41:10 +0000
Message-Id: <20260630094111.597321F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Early returns in atomic callbacks and the IRQ handler leak pending=
 DRM events, which can lead to deadlocks and userspace hangs.
- [High] Calling `drm_dev_unplug()` before `drm_atomic_helper_shutdown()` p=
revents the hardware from being properly disabled, leading to resource leak=
s and potential bus faults.
- [Medium] The IRQ handler incorrectly returns `IRQ_NONE` after successfull=
y clearing a valid device interrupt if the device is unplugged.

Pre-existing issues:
- [High] Missing `drm_dev_enter()` guard in `logicvc_plane_atomic_disable` =
allows a Use-After-Free of the devm-managed regmap during async commits.
- [High] Unconditional regmap accesses in the IRQ handler before verifying =
device presence can cause synchronous external aborts (bus faults).
--

commit 69266e323a62e95eebd5b09b60ba6e1876f02ff5
Author: Romain Gantois <romain.gantois@bootlin.com>

drm/logicvc: Avoid using DRM resources after device is unplugged

Some DRM resources such as plane, CRTC or encoder objects could remain in
use after the DRM device is removed. Use the drm_dev_enter/exit() mechanism
to ensure that the DRM device is not unplugged before using its resources.

> diff --git a/drivers/gpu/drm/logicvc/logicvc_crtc.c b/drivers/gpu/drm/log=
icvc/logicvc_crtc.c
> index 3a4c347eaa648..f3a224a883b2f 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_crtc.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_crtc.c
> @@ -40,10 +40,15 @@ static void logicvc_crtc_atomic_begin(struct drm_crtc=
 *drm_crtc,
>  				      struct drm_atomic_state *state)
>  {
>  	struct logicvc_crtc *crtc =3D logicvc_crtc(drm_crtc);
> -	struct drm_crtc_state *old_state =3D
> -		drm_atomic_get_old_crtc_state(state, drm_crtc);
>  	struct drm_device *drm_dev =3D drm_crtc->dev;
> +	struct drm_crtc_state *old_state;
>  	unsigned long flags;
> +	int idx;
> +
> +	if (!drm_dev_enter(drm_dev, &idx))
> +		return;

[Severity: High]
If the device is unplugged, does this early return bypass the block that
consumes and clears the pending DRM event? Userspace applications waiting
for page flip completion events might hang indefinitely if these events
are stranded.

[ ... ]
> @@ -155,6 +170,10 @@ static void logicvc_crtc_atomic_disable(struct drm_c=
rtc *drm_crtc,
>  {
>  	struct logicvc_drm *logicvc =3D logicvc_drm(drm_crtc->dev);
>  	struct drm_device *drm_dev =3D drm_crtc->dev;
> +	int idx;
> +
> +	if (!drm_dev_enter(drm_dev, &idx))
> +		return;

[Severity: High]
Similar to the atomic_begin function, does this early return skip signaling
the leftover event at the end of the function?

Also, when drm_atomic_helper_shutdown() synthesizes a commit to disable the
display pipeline during unbind, will this check cause the hardware CRTC
disable routine via drm_crtc_vblank_off() to be skipped entirely?

> diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logi=
cvc/logicvc_drm.c
> index bbebf4fc7f51a..2112646386e36 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_drm.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
> @@ -71,6 +71,7 @@ static irqreturn_t logicvc_drm_irq_handler(int irq, voi=
d *data)
>  	struct logicvc_drm *logicvc =3D data;
>  	irqreturn_t ret =3D IRQ_NONE;
>  	u32 stat =3D 0;
> +	int idx;
> =20
>  	/* Get pending interrupt sources. */
>  	regmap_read(logicvc->regmap, LOGICVC_INT_STAT_REG, &stat);

[Severity: High]
This isn't a bug introduced by this patch, but does accessing the hardware
registers here unconditionally before verifying device presence risk a bus
fault? Since the IRQ is devm-managed, it might fire in a small window after
logicvc_clocks_unprepare() has turned off the clocks during teardown,
leading to synchronous external aborts.

>  	/* Clear all pending interrupt sources. */
>  	regmap_write(logicvc->regmap, LOGICVC_INT_STAT_REG, stat);
> =20
>  	if (stat & LOGICVC_INT_STAT_V_SYNC) {
> +		/* DRM device could be unplugged. */
> +		if (!drm_dev_enter(&logicvc->drm_dev, &idx))
> +			return ret;

[Severity: Medium]
If the device is unplugged, this returns the initial value of ret (IRQ_NONE)
even though the interrupt was genuine and just successfully cleared in the
hardware. Could this cause the kernel's IRQ core to eventually disable a
shared IRQ line due to repeated spurious interrupt reports?

[Severity: High]
Additionally, does skipping the vblank handler here leak the stashed event,
similar to the early returns in the atomic callbacks?

[ ... ]
> @@ -463,7 +470,7 @@ static void logicvc_drm_remove(struct platform_device=
 *pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct drm_device *drm_dev =3D &logicvc->drm_dev;
> =20
> -	drm_dev_unregister(drm_dev);
> +	drm_dev_unplug(drm_dev);
>  	drm_atomic_helper_shutdown(drm_dev);

[Severity: High]
Does calling drm_dev_unplug() before drm_atomic_helper_shutdown() break the
hardware disable sequence?

Since drm_dev_unplug() marks the device as unplugged first, the subsequent
drm_atomic_helper_shutdown() will fail the new drm_dev_enter() checks in
the disable callbacks. Will this leave hardware CRTCs and external panels
powered on and active while the driver unbinds?

> diff --git a/drivers/gpu/drm/logicvc/logicvc_interface.c b/drivers/gpu/dr=
m/logicvc/logicvc_interface.c
> index 0d037f37b950f..aa13338a29535 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_interface.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_interface.c
[ ... ]
> @@ -43,17 +47,25 @@ static void logicvc_encoder_enable(struct drm_encoder=
 *drm_encoder)
[ ... ]
>  static void logicvc_encoder_disable(struct drm_encoder *drm_encoder)
>  {
>  	struct logicvc_interface *interface =3D
>  		logicvc_interface_from_drm_encoder(drm_encoder);
> +	int idx;
> +
> +	if (!drm_dev_enter(drm_encoder->dev, &idx))
> +		return;

[Severity: High]
Similar to the CRTC disable path, does this early return skip
drm_panel_disable() and drm_panel_unprepare() when the encoder is being
shut down during device unbind?

> diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/lo=
gicvc/logicvc_layer.c
> index de1f4a8a61557..51fb68e642adc 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_layer.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
[ ... ]
> @@ -230,6 +244,8 @@ static void logicvc_plane_atomic_update(struct drm_pl=
ane *drm_plane,
[ ... ]
>  static void logicvc_plane_atomic_disable(struct drm_plane *drm_plane,
>  					 struct drm_atomic_state *state)
>  {
>  	struct logicvc_layer *layer =3D logicvc_layer(drm_plane);
>  	struct logicvc_drm *logicvc =3D logicvc_drm(drm_plane->dev);
>  	u32 index =3D layer->index;
> =20
> +	/* No need for drm_dev_enter() here. The regmap outlives the DRM device=
. */
> +
>  	regmap_write(logicvc->regmap, LOGICVC_LAYER_CTRL_REG(index), 0);
>  }

[Severity: High]
This is a pre-existing issue, but does this comment make a flawed assumption
about the resource lifecycle? The regmap is tied to the platform device via
devres and is freed when remove() returns. If a non-blocking atomic commit
tail worker executes after remove() has completed, could this unconditional=
ly
write to the already-freed regmap, causing memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-logicvc-ua=
f-v2-0-99e881833860@bootlin.com?part=3D2
