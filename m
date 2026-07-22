Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98B9C4453D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A4710E456;
	Wed, 22 Jul 2026 10:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J8URxruo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9012410E456
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:00:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 790F8419B4;
 Wed, 22 Jul 2026 10:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A9B1F00A3A;
 Wed, 22 Jul 2026 10:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784714455;
 bh=rKYSDgXYxC7QiPmpznSWctj120VhAaKx0pnhmFPRCuI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J8URxruoIH9MuSgY+P8mozVijFK06Lq6gK/X7gOlVeUGOvJD5JiB4297MryAqr95i
 zyR9eU+Ke0CsvnDkpbLNbLVyVU9AbVo0+m///KXZexCgvAxkUWKcOqxrguM3ZWmc33
 j05z4uZXBmx0kH/zxcp85IrEoaDkwsmqa752sZom67KCEzwuiPGLYldN5u8pA/lD3u
 3lTx+4JSfmEtaUvBuvwUAiMBHde7Ic9mVvOrkZURwYOYLh1kkQSsNOZimYe29XolbF
 1HWGwz7j0gKYAFNKVxNaZzLD3hW1DWBvkY4OlmHCLubA79r3jnjBQOfQWswXepf3PB
 LvKllD+N6eGhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm/logicvc: Avoid using DRM resources after
 device is unplugged
To: "Romain Gantois" <romain.gantois@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-logicvc-uaf-v3-2-f3b2319d58a6@bootlin.com>
References: <20260722-logicvc-uaf-v3-0-f3b2319d58a6@bootlin.com>
 <20260722-logicvc-uaf-v3-2-f3b2319d58a6@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 10:00:54 +0000
Message-Id: <20260722100055.31A9B1F00A3A@smtp.kernel.org>
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
- [High] Leaking vblank event and causing userspace to hang indefinitely on=
 device unplug.
- [High] Bailing out early from CRTC disable skips mandatory DRM software s=
tate cleanup (`drm_crtc_vblank_off`).
- [High] Calling `drm_dev_unplug()` before `drm_atomic_helper_shutdown()` a=
borts hardware shutdown, leading to DMA use-after-free and system hangs.
- [High] Omitting `drm_dev_enter()` in the IRQ handler risks unclocked regi=
ster access and system crashes during device removal.
- [Medium] The external DRM panel is not properly disabled and unprepared u=
pon device unplug.
--

--- Patch [2]: [PATCH v3 2/2] drm/logicvc: Avoid using DRM resources after =
device is unplugged ---
commit 984a88d7dda613a6824feda7d8e4824b35006bb5
Author: Romain Gantois <romain.gantois@bootlin.com>
Subject: drm/logicvc: Avoid using DRM resources after device is unplugged

Some DRM resources such as plane, CRTC or encoder objects could remain in
use after the DRM device is removed. Use the drm_dev_enter/exit() mechanism
to ensure that the DRM device is not unplugged before using its resources.

> diff --git a/drivers/gpu/drm/logicvc/logicvc_crtc.c b/drivers/gpu/drm/log=
icvc/logicvc_crtc.c
> index 3a4c347eaa648..e2575fa78ab25 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_crtc.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_crtc.c
> @@ -36,6 +36,21 @@ logicvc_crtc_mode_valid(struct drm_crtc *drm_crtc,
>  	return 0;
>  }
> =20
> +static void logicvc_crtc_drop_any_event(struct drm_device *drm_dev,
> +					struct drm_crtc *drm_crtc)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&drm_dev->event_lock, flags);
> +
> +	if (drm_crtc->state->event) {
> +		drm_crtc->state->event =3D NULL;

[Severity: High]
Does setting this event to NULL leak the drm_pending_vblank_event memory?

Without calling drm_crtc_send_vblank_event(), will userspace compositors
waiting for the page flip completion hang indefinitely during an unplug?

> +		drm_warn(drm_crtc->dev, "Device is unplugged, ignoring pending vblank =
event!");
> +	}
> +
> +	spin_unlock_irqrestore(&drm_dev->event_lock, flags);
> +}

[ ... ]

> @@ -155,6 +186,12 @@ static void logicvc_crtc_atomic_disable(struct drm_c=
rtc *drm_crtc,
>  {
>  	struct logicvc_drm *logicvc =3D logicvc_drm(drm_crtc->dev);
>  	struct drm_device *drm_dev =3D drm_crtc->dev;
> +	int idx;
> +
> +	if (!drm_dev_enter(drm_dev, &idx)) {
> +		logicvc_crtc_drop_any_event(drm_dev, drm_crtc);
> +		return;
> +	}

[Severity: High]
If we return early here during an unplug, we skip the call to
drm_crtc_vblank_off(). Does this leave the DRM core's vblank state machine
active, potentially orphaning waitqueues or leaving background works
pending?

> =20
>  	drm_crtc_vblank_off(drm_crtc);

[ ... ]

> diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logi=
cvc/logicvc_drm.c
> index bbebf4fc7f51a..fb66f5fb67937 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_drm.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
> @@ -72,6 +72,10 @@ static irqreturn_t logicvc_drm_irq_handler(int irq, vo=
id *data)
>  	irqreturn_t ret =3D IRQ_NONE;
>  	u32 stat =3D 0;
> =20
> +	/* The interrupt handler will be unregistered when the device is
> +	 * removed. Therefore, there's no need for drm_dev_enter() here.
> +	 */
> +
>  	/* Get pending interrupt sources. */
>  	regmap_read(logicvc->regmap, LOGICVC_INT_STAT_REG, &stat);

[Severity: High]
Since the interrupt handler relies on devres for unregistration, it remains
active after logicvc_drm_remove() completes.

Inside logicvc_drm_remove(), logicvc_clocks_unprepare() is called which
disables the clocks. If this handler fires afterwards (e.g., from a shared
IRQ line), won't reading LOGICVC_INT_STAT_REG without clocks cause an
imprecise external abort and crash the system?

> =20
> @@ -463,7 +467,7 @@ static void logicvc_drm_remove(struct platform_device=
 *pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct drm_device *drm_dev =3D &logicvc->drm_dev;
> =20
> -	drm_dev_unregister(drm_dev);
> +	drm_dev_unplug(drm_dev);
>  	drm_atomic_helper_shutdown(drm_dev);

[Severity: High]
Calling drm_dev_unplug() here sets the device unplugged state, which causes
subsequent drm_dev_enter() checks to fail in functions like
logicvc_plane_atomic_check().

If logicvc_plane_atomic_check() returns -ENODEV, won't this abort the
drm_atomic_helper_shutdown() commit? If the hardware display controller is
never stopped and continues fetching from memory, disabling the clocks later
could cause an AXI bus lockup.

> =20
>  	logicvc_mode_fini(logicvc);

[ ... ]

> diff --git a/drivers/gpu/drm/logicvc/logicvc_interface.c b/drivers/gpu/dr=
m/logicvc/logicvc_interface.c
> index 0d037f37b950f..aa13338a29535 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_interface.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_interface.c
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

[Severity: Medium]
Does returning early here skip disabling and unpreparing the DRM panel?

If the device is unplugged, skipping drm_panel_disable() and
drm_panel_unprepare() could leave the panel permanently powered on with its
regulators and backlight enabled, causing a resource leak.

> =20
>  	if (interface->drm_panel) {
>  		drm_panel_disable(interface->drm_panel);
>  		drm_panel_unprepare(interface->drm_panel);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-logicvc-ua=
f-v3-0-f3b2319d58a6@bootlin.com?part=3D2
