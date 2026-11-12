Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6209606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0wpD7lg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC8E10E4BD;
	Thu, 12 Nov 2026 04:00:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E95310E4DA
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 04:00:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4AA1161DE0;
 Thu, 12 Nov 2026 04:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78D81F00A05;
 Thu, 12 Nov 2026 04:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794456039;
 bh=WXJUzzbmAFxjHQam5K25PJK9xHjhqRNSzwsBSVcoSmQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M0wpD7lghK3n6pKOSzWlYPXAqAdVzEC45hB172U19xYvsOT0ShvPkiU2ZTOt2XNny
 vPLPlB6pOl2k4Fqk4I/yXPwOvVJVUU6I6jfvSDMlVWxuZZqK1ceEpM2z7XKTo9jj3R
 qItH+KP0i+VS2kUKe2ZaKGaF/1UEQk0JgukusSK++ZedaKiy8d4AlaZA8tf/D1xeTD
 XwTsy0tIp4XCne9M786ET2ajjzAk6k129CpkoP3xngE9LunNCEu21eZj+cnA+UcYsD
 0BiJFOZ37WCzwJLkMHaIcVXkVPA8SbHp7RBhwLpouAvECZRt1g1gaXuBHBFLCUiM/3
 8VVuwSSTeZPFA==
Message-ID: <sashiko-outbox-210307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] drm/fl2000: Add KMS display pipeline
To: "Angel Gabriel Crispin Valdivia" <angelcrispinvaldivia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261111-fl2000-upstream-v2-4-201f87708cb0@gmail.com>
References: <20261111-fl2000-upstream-v2-0-201f87708cb0@gmail.com>
 <20261111-fl2000-upstream-v2-4-201f87708cb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:00:38 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/fl2000: USB reset callbacks race unlocked
  drm_mode_config_reset() with ioctls
- [Medium] drm/fl2000: nonzero return from fl2000_resume() in post_reset
  unbinds driver
- [Medium] drm/fl2000: fl2000_drm_resume() leaves active CRTC
  unprogrammed if suspend fails
- [Medium] drm/fl2000: unscheduled intr->work in
  fl2000_intr_read_status() strands HDMI IRQs
--

commit 7aa37254cbf5a2f4dd511499c2b10b545e13febc
Author: Angel Gabriel Crispin Valdivia <angelcrispinvaldivia@gmail.com>

drm/fl2000: Add KMS display pipeline

This commit adds the DRM/KMS display pipeline for the Fresco Logic FL2000
USB display adapter, including plane/CRTC/encoder setup, HDMI and VGA
connectors, interrupt handling, and suspend/resume support.

> diff --git a/drivers/gpu/drm/fl2000/fl2000_drm.c b/drivers/gpu/drm/fl2000=
/fl2000_drm.c
> new file mode 100644
> index 0000000000000..04efcf583d7de
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_drm.c

[ ... ]

> +int fl2000_drm_suspend(struct fl2000_device *fdev)
> +{
> +	int ret;
> +
> +	/* No hotplug events while going to sleep */
> +	fl2000_intr_suspend(fdev->intr);
> +
> +	/* Saves the state, turns the outputs off and stops the stream */
> +	ret =3D drm_mode_config_helper_suspend(&fdev->drm);
> +	if (ret) {
> +		drm_err(&fdev->drm, "Cannot save the display state (%d)\n", ret);
> +		fl2000_stream_disable(fdev->stream);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * fl2000_drm_resume() - bring the display back after system sleep or a =
USB reset
> + * @fdev: the DRM device
> + *
> + * Called once for the device, when all of it is awake again, also after=
 a reset-resume. The chips
> + * may have lost power: they are set up as at bind time before the saved=
 state is restored.
> + *
> + * Return: 0 on success, a negative error code otherwise
> + */
> +int fl2000_drm_resume(struct fl2000_device *fdev)
> +{
> +	struct regmap *regmap =3D fdev->regmap;
> +	int ret =3D 0;
> +
> +	/* First, as the IT66121 is reached through the FL2000 I2C engine */
> +	fl2000_regmap_drop_cache(regmap);
> +
> +	it66121_resume(fdev->bridge);
> +
> +	/* The same order as in fl2000_drm_create() */
> +	fl2000_chip_setup(fdev);
> +
> +	/* There is nothing to restore if saving the state failed */
> +	if (fdev->drm.mode_config.suspend_state) {
> +		ret =3D drm_mode_config_helper_resume(&fdev->drm);
> +		if (ret)
> +			drm_err(&fdev->drm, "Cannot restore the display after sleep (%d)\n", =
ret);
> +	}

[Severity: Medium]
If drm_mode_config_helper_suspend() fails in fl2000_drm_suspend(), does
fl2000_drm_resume() leave an active CRTC unprogrammed and its stream
stopped?

When drm_mode_config_helper_suspend() fails, fdev->drm.mode_config.suspend_=
state
remains NULL and the DRM software state stays enabled, while
fl2000_drm_suspend() disables fdev->stream.  On resume, it66121_resume()
and fl2000_chip_setup() reset both chips, clearing the PLL, timings, and
HDMI transmitter state, but because suspend_state is NULL,
drm_mode_config_helper_resume() is skipped.  The hardware stays unprogrammed
and the stream stays disabled while fdev->crtc.state remains active, so
subsequent page flips or plane updates do not trigger a modeset and the
display remains blank.

> diff --git a/drivers/gpu/drm/fl2000/fl2000_drv.c b/drivers/gpu/drm/fl2000=
/fl2000_drv.c
> index 31d1535530a6e..663fb5daa05ae 100644
> --- a/drivers/gpu/drm/fl2000/fl2000_drv.c
> +++ b/drivers/gpu/drm/fl2000/fl2000_drv.c

[ ... ]

> +static int fl2000_resume(struct usb_interface *interface)
>  {
> -	dev_dbg(&interface->dev, "resume\n");
> +	struct fl2000_devs *devs =3D usb_get_intfdata(interface);
> +
> +	if (!devs || !devs->suspended)
> +		return 0;
> +
> +	devs->suspended =3D false;
> +
> +	return fl2000_drm_resume(devs->fdev);
> +}
> +
> +/*
> + * A reset of the USB device (the storage function of the adapter asks f=
or one when it times out)
> + * is the same as far as the display goes. Nonzero would make the USB co=
re unbind the driver.
> + */
> +static int fl2000_pre_reset(struct usb_interface *interface)
> +{
> +	fl2000_suspend(interface, PMSG_SUSPEND);
> =20
>  	return 0;
>  }
> =20
>  static struct usb_driver fl2000_driver =3D {
>  	.name =3D KBUILD_MODNAME,
>  	.probe =3D fl2000_probe,
>  	.disconnect =3D fl2000_disconnect,
>  	.suspend =3D fl2000_suspend,
>  	.resume =3D fl2000_resume,
> +	.reset_resume =3D fl2000_resume,
> +	.pre_reset =3D fl2000_pre_reset,
> +	.post_reset =3D fl2000_resume,

[Severity: High]
Can calling drm_mode_config_helper_suspend() and
drm_mode_config_helper_resume() from .pre_reset and .post_reset cause a
use-after-free on DRM modeset states when a USB reset runs concurrently
with userspace ioctls?

Unlike system sleep, usb_reset_device() runs while userspace is active.
drm_mode_config_helper_resume() -> drm_atomic_helper_resume() calls
drm_mode_config_reset() before acquiring modeset locks:

drivers/gpu/drm/drm_atomic_helper.c:drm_atomic_helper_resume() {
	...
	drm_mode_config_reset(dev);

	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
	...
}

drm_mode_config_reset() destroys and reallocates plane->state, crtc->state,
and connector->state without holding any modeset locks:

CPU0 (usb_reset_device)           CPU1 (compositor ioctl)
fl2000_resume()
  fl2000_drm_resume()
    drm_mode_config_helper_resume()
      drm_atomic_helper_resume()
                                  drm_mode_atomic_ioctl()
                                    drm_atomic_get_crtc_state()
                                      drm_modeset_lock(&crtc->mutex, ...)
        drm_mode_config_reset()
          atomic_destroy_state()
            kfree(crtc->state)
                                      atomic_duplicate_state(crtc)
                                        __drm_atomic_helper_crtc_duplicate_=
state()
                                          <-- use-after-free / NULL deref

In addition, between fl2000_pre_reset() and .post_reset,
drm_mode_config_helper_suspend() leaves the CRTC disabled with all modeset
locks released, so concurrent page flips from the running compositor fail
with -EINVAL.

[Severity: Medium]
Also, if fl2000_drm_resume() returns an error during .post_reset, does that
cause the USB core to unbind the driver and fail to rebind it?

fl2000_pre_reset() ignores the return value of fl2000_suspend() because
usb_reset_device() treats a nonzero return as a request to unbind and
rebind the interface, but .post_reset is wired directly to fl2000_resume().
usb_reset_device() calls .post_reset in reverse interface order (2, 1, 0):
on interface 2, fl2000_resume() clears devs->suspended and returns any
error from fl2000_drm_resume(), setting needs_binding =3D 1 on interface 2,
and then returns 0 on interfaces 1 and 0.
usb_unbind_and_rebind_marked_interfaces() then unbinds interface 2 (running
fl2000_disconnect() and releasing all interfaces) and only attempts to
rebind interface 2, which does not match fl2000_id_table.

> diff --git a/drivers/gpu/drm/fl2000/fl2000_interrupt.c b/drivers/gpu/drm/=
fl2000/fl2000_interrupt.c
> new file mode 100644
> index 0000000000000..8f8f9fac1ea35
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_interrupt.c

[ ... ]

> +static int fl2000_intr_read_status(struct fl2000_intr *intr, u32 *status)
> +{
> +	int ret;
> +
> +	ret =3D fl2000_read_status(intr->regmap, status);
> +	if (ret)
> +		return ret;
> +
> +	atomic_or(*status & FL2000_SINK_EVENTS, &intr->events);
> +
> +	return 0;
> +}
> +
> +/**
> + * fl2000_intr_monitor_connected() - does the FL2000 sense a monitor on =
its monitor input
> + * @intr: interrupt context
> + *
> + * The chip powers the DAC and the PLL only while this is the case. On t=
he boards with both
> + * outputs the input follows whichever monitor is plugged in, so it does=
 not tell VGA from HDMI.
> + * While HDMI is being driven the sense is forced on and tells nothing: =
that counts as not sensing,
> + * or an HDMI monitor going away would look like a VGA one showing up, u=
ntil the CRTC is disabled.
> + *
> + * Return: 1 if a monitor is sensed, 0 if not, a negative error code if =
the status cannot be read
> + */
> +int fl2000_intr_monitor_connected(struct fl2000_intr *intr)
> +{
> +	u32 status;
> +	int ret;
> +
> +	ret =3D fl2000_intr_read_status(intr, &status);
> +	if (ret)
> +		return ret;

[Severity: Medium]
When fl2000_intr_monitor_connected() reads FL2000_VGA_STATUS_HDMI_EVENT
during VGA connector detection, can that strand the event in intr->events
without acknowledging the IT66121 interrupt?

Reading FL2000_VGA_STATUS_REG clears the pending interrupt and event bits
in the FL2000 hardware.  When fl2000_vga_detect_ctx() ->
fl2000_intr_monitor_connected() reads the status register (for example
during initial probing in fl2000_drm_create() before fl2000_intr_start(),
or during periodic polling before the USB interrupt endpoint fires),
fl2000_intr_read_status() saves FL2000_SINK_EVENTS into intr->events, but
nothing queues intr->work to run fl2000_drm_hotplug() and call
it66121_ack_interrupts().  The IT66121 interrupt line then remains asserted
and cannot signal further HDMI hotplug events.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-fl2000-ups=
tream-v2-0-201f87708cb0@gmail.com?part=3D4
