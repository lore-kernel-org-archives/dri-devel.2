Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83BBC44520
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 02:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C2F10E26F;
	Tue, 21 Jul 2026 02:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WVItYcx4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D3510E26F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 02:42:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E62C60A61;
 Tue, 21 Jul 2026 02:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1551F000E9;
 Tue, 21 Jul 2026 02:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784601774;
 bh=yzALuV5DrXr3ZRPHG0k2t4XlfbZP0ahAklZK6K5TO/U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WVItYcx4kFZQW+qoEgEhH+RzRc1De7sIzK2MAOiqMDWwL/S8XwCSjShxLiiZ+eZ1H
 snwK/nxOXx9n4K5SixKzoQM9vxOemrFkIsph5qcXPBUsxXS0QxTfdQTcOm6oz5O5xC
 23Sza5qUs53QR7cJL+/0Ff04VtbGIbpJP7uZWeIBtJmFrGp1Fbl8ket/EDm2eqyngs
 dzA1rfXPxM7iPdPCUj5lS6Fh3IjvE4pYAhMPloFzmJpiOKU0404lq3IN/jx4D8kLmm
 AVwxdgl/hQbTvmaWcaGFTHXPXKR9NiG8gp06PHU7JIrzYB1d9B0asOJtpZNOMcUlAN
 ZN5GzyoeXe1Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] drm/bridge: it6505: Don't reject audio hw_params
 without an encoder
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <c82134d59d36fbc66e75d397ae50141ad447220b.1784600387.git.daniel@makrotopia.org>
References: <cover.1784600387.git.daniel@makrotopia.org>
 <c82134d59d36fbc66e75d397ae50141ad447220b.1784600387.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 02:42:54 +0000
Message-Id: <20260721024254.AF1551F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The interrupt handler can still execute and re-queue work items af=
ter `cancel_work_sync()` in `it6505_i2c_remove()`, leading to Use-After-Fre=
e.
- [High] Missing `pm_runtime_disable()` in `it6505_i2c_remove()` leaves the=
 device in an inconsistent PM state.
- [High] Unprotected modification and TOCTOU race on `it6505->audio.mute` l=
eading to unintended audio enablement.
- [Medium] Cached audio parameters are overwritten by default values on dis=
play hotplug, defeating the secondary goal of the patch.
- [Medium] Audio configuration fields in `it6505->audio` are modified witho=
ut consistent locking, leading to potential race conditions.
--

--- Patch [4]: [PATCH v3 4/4] drm/bridge: it6505: Don't reject audio hw_par=
ams without an encoder ---
commit af4a3bfaf41a8f5bf333fd6908bc4e3f4fabd9a8
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: Don't reject audio hw_params without an encoder

it6505_audio_setup_hw_params() returns -ENODEV when the bridge is not
attached to a DRM encoder. This commit drops the encoder check so the
parameters are always cached.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 37036ef5403fb..435601b6929ed 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2999,9 +2999,6 @@ static int it6505_audio_setup_hw_params(struct it65=
05 *it6505,
>  			     params->sample_rate, params->sample_width,
>  			     params->cea.channels);
> =20
> -	if (!it6505->bridge.encoder)
> -		return -ENODEV;
> -

[Severity: Medium]
This is a pre-existing issue, but does removing this check fully solve the
problem if the cached parameters are overwritten on hotplug?

When a stream starts with no display attached, it6505_audio_setup_hw_params=
()
caches the correct settings as intended. However, if a display is hotplugged
later, the HPD interrupt handler sees a disconnected state beforehand and z=
eroed
it6505->dpcd.

Upon reconnect, it finds it6505->dpcd[0] =3D=3D 0 and calls
it6505_variable_config():

    it6505->audio.sample_rate =3D AUDIO_SAMPLE_RATE;
    it6505->audio.channel_count =3D AUDIO_CHANNEL_COUNT;

Does this unconditionally reset the audio variables to default values, caus=
ing
audio to play with 2 channels and 48kHz rather than the dynamically configu=
red
stream parameters?

[Severity: Medium]
This is a pre-existing issue, but does this function need to take the
audio_lock when modifying the audio configuration fields?

In it6505_audio_setup_hw_params():

    it6505->audio.channel_count =3D params->cea.channels;

This modifies the fields in it6505->audio without taking it6505->audio_lock.

Since it6505_enable_audio() can be called from asynchronous paths (like
it6505_delayed_audio or IRQ) which takes audio_lock and reads these fields,
could this result in hardware being programmed with a partially updated sta=
te
if readers see a mix of old and new parameters?

>  	if (params->cea.channels <=3D 1 || params->cea.channels > 8) {
>  		DRM_DEV_DEBUG_DRIVER(dev, "channel number: %d not support",
>  				     params->cea.channels);

[Severity: High]
This is a pre-existing issue, but can the interrupt handler still execute a=
nd
re-queue work items after they are cancelled during driver unbind?

In it6505_i2c_remove():

    cancel_work_sync(&it6505->link_works);
    cancel_work_sync(&it6505->hdcp_wait_ksv_list);
    cancel_delayed_work_sync(&it6505->hdcp_work);
    cancel_work_sync(&it6505->extcon_wq);

Since the device interrupt (it6505->irq) is not disabled before cancelling
these work items, could an incoming interrupt spawn the threaded handler and
call schedule_work(&it6505->link_works) after cancel_work_sync() returns,
leading to a use-after-free when the work item executes?

[Severity: High]
This is a pre-existing issue, but is there a missing pm_runtime_disable() in
the driver removal path?

While it6505_i2c_probe() successfully enables runtime PM with
pm_runtime_enable(dev), it6505_i2c_remove() does not appear to call
pm_runtime_disable(dev) before returning. Can this leave the PM core with
references to the unbound device, leading to a resource leak or lifecycle
violation?

[Severity: High]
This is a pre-existing issue, but is there a time-of-check to time-of-use r=
ace
on the audio mute state?

In it6505_irq_audio_fifo_error(), the mute state is read outside of the loc=
k:

    if (it6505->audio.mute)
        return;

    if (it6505_audio_input(it6505))
        it6505_enable_audio(it6505);

If ALSA mutes the stream concurrently, it6505_audio_mute() sets mute to true
and disables audio. After it returns, if the IRQ wakes up and unconditional=
ly
calls it6505_enable_audio() which takes the lock and turns audio back on,
could this defeat the mute and cause hardware malfunction by sending an
InfoFrame without audio data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784600387.gi=
t.daniel@makrotopia.org?part=3D4
