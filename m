Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7F8C4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 17:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39AB210E35E;
	Sat, 18 Jul 2026 17:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jj8eKvhR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B84A810E35E
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:18:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDBA06001A;
 Sat, 18 Jul 2026 17:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6082F1F000E9;
 Sat, 18 Jul 2026 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784395112;
 bh=vkE5a9pVtM3YmHoLpNy/9wWVxol5PTceMj3orlfhjqM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jj8eKvhRHg2FHtSXxeGwrO3ZB7AZ0gNmo0RH1lrvuluP9+GHuhgJ0vkGaw06XfWsr
 D+DHryAUVlGnrgCJaVCdeaZvGwq+YczmuUaHvqj4mLA0gmr7F4VYYvw5OeN6OUIYH3
 WTmM2RNyT2yQhYF/Yj3XmaaslIjkAL44TnQmPTyVKuw3Cwtc6lpUF6VaVURXlASWww
 s5JN0SuGfn6Vu9MDWxSoa/M5NbUN5DBry9EMEefgFczaR2LpujsipyzsnIav7T/1jt
 qMZzhFCvcjFp89YptKkNQniJObjSyKSWptRCDvRVbY118pDEw0pSJJUMtLFHV3uLSH
 IuVbenp7VPv6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: it6505: Add audio support
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2cc7d3922a66de483200d75c9f98badb5391c85a.1784393979.git.daniel@makrotopia.org>
References: <cover.1784393979.git.daniel@makrotopia.org>
 <2cc7d3922a66de483200d75c9f98badb5391c85a.1784393979.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 17:18:31 +0000
Message-Id: <20260718171832.6082F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Resource leak and Use-After-Free of hdmi-codec platform device
- [High] Missing synchronous cancellation of `delayed_audio` on driver remo=
val causes Use-After-Free
- [High] Pending `delayed_audio` work is not cancelled during ALSA audio sh=
utdown
- [High] `delayed_audio` workqueue is initialized after device registration
- [High] Concurrent I2C operations in audio enable/disable lack synchroniza=
tion
- [Medium] Audio workaround logic fails to disable audio when muted

Pre-existing issues:
- [High] Pre-existing missing synchronous cancellation of HDCP work on driv=
er removal
--

--- Patch [1]: [PATCH 1/2] drm/bridge: it6505: Add audio support ---
commit 645bfa307d3295ef683ceb3cf17d99b78c9a13a0
Author: Jiaxin Yu <jiaxin.yu@mediatek.com>

drm/bridge: it6505: Add audio support

Add audio support for it6505 by bridging to the hdmi-codec, registering
an "hdmi-audio-codec" platform device from probe. The it6505's audio
setup/shutdown helpers were merged earlier as unused code; wire them up
via hdmi_codec_ops so the DAI actually appears.

Link: https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek=
.com/

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 8ecb43611dba8..698ae01b3a474 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
[ ... ]
> @@ -2960,7 +2953,7 @@ static void it6505_remove_notifier_module(struct it=
6505 *it6505)
>  	}
>  }
> =20
> -static void __maybe_unused it6505_delayed_audio(struct work_struct *work)
> +static void it6505_delayed_audio(struct work_struct *work)
>  {
>  	struct it6505 *it6505 =3D container_of(work, struct it6505,
>  					     delayed_audio.work);
> @@ -2974,9 +2967,9 @@ static void __maybe_unused it6505_delayed_audio(str=
uct work_struct *work)
>  		it6505_enable_audio(it6505);
>  }

[Severity: High]
With the wiring up of delayed_audio and the hdmi_codec_ops,
it6505_enable_audio() and it6505_disable_audio() can now execute concurrent=
ly
from the system workqueue, ALSA process context, and threaded IRQs.

Since both functions perform multi-step unprotected hardware configuration,
could their I2C operations interleave and corrupt the audio configuration
registers? Is a mutex needed to protect these sequences?

[ ... ]
> -static void __maybe_unused it6505_audio_shutdown(struct device *dev, voi=
d *data)
> +static void it6505_audio_shutdown(struct device *dev, void *data)
>  {
>  	struct it6505 *it6505 =3D dev_get_drvdata(dev);
> =20
> @@ -3039,10 +3032,40 @@ static void __maybe_unused it6505_audio_shutdown(=
struct device *dev, void *data)
>  		it6505_disable_audio(it6505);
>  }

[Severity: High]
Does this leave pending delayed work active?

If a user starts the audio stream and closes it within 180ms, the delayed w=
ork
might still execute after this shutdown completes, which would re-enable the
audio hardware on a closed stream.

Should this call cancel_delayed_work_sync(&it6505->delayed_audio) before
disabling the audio?

> -static int __maybe_unused it6505_audio_hook_plugged_cb(struct device *de=
v,
> -						       void *data,
> -						       hdmi_codec_plugged_cb fn,
> -						       struct device *codec_dev)
> +static int it6505_audio_hw_params(struct device *dev, void *data,
> +				  struct hdmi_codec_daifmt *daifmt,
> +				  struct hdmi_codec_params *params)
> +{
> +	struct it6505 *it6505 =3D dev_get_drvdata(dev);
> +
> +	return it6505_audio_setup_hw_params(it6505, params);
> +}
> +
> +static int it6505_audio_mute(struct device *dev, void *data,
> +			     bool enable, int direction)
> +{
> +	struct it6505 *it6505 =3D dev_get_drvdata(dev);
> +
> +	DRM_DEV_DEBUG_DRIVER(dev, "mute: %d", enable);
> +
> +	/*
> +	 * Some DP-to-HDMI dongles get into a bad state if the InfoFrame is
> +	 * sent without audio data, so only enable it6505's audio once the
> +	 * stream is unmuted (i.e. actually playing).
> +	 */
> +	if (enable)
> +		cancel_delayed_work(&it6505->delayed_audio);

[Severity: Medium]
Will this fail to disable audio when the stream is muted after being unmuted
for more than 180ms?

If enable is true (which typically means muting in ALSA semantics), and the
delayed work has already executed, canceling the work will do nothing.

Should this actively call it6505_disable_audio() if the stream is being mut=
ed?

Also, could using the non-synchronous cancel_delayed_work() introduce a race
condition if the worker is concurrently executing?

> +	else
> +		queue_delayed_work(system_wq, &it6505->delayed_audio,
> +				   msecs_to_jiffies(180));
> +
> +	return 0;
> +}
[ ... ]
> +static int it6505_register_audio_driver(struct device *dev)
> +{
> +	struct it6505 *it6505 =3D dev_get_drvdata(dev);
> +	struct hdmi_codec_pdata codec_data =3D {
> +		.ops =3D &it6505_audio_codec_ops,
> +		.max_i2s_channels =3D 8,
> +		.i2s =3D 1,
> +		.no_capture_mute =3D 1,
> +		.data =3D it6505,
> +	};
> +	struct platform_device *pdev;
> +
> +	pdev =3D platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
> +					     PLATFORM_DEVID_AUTO, &codec_data,
> +					     sizeof(codec_data));
> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);
> +
> +	INIT_DELAYED_WORK(&it6505->delayed_audio, it6505_delayed_audio);

[Severity: High]
Could this result in an uninitialized work structure being used?

If the ALSA driver binds and invokes the mute_stream callback immediately a=
fter
platform_device_register_data() returns, queue_delayed_work() could be call=
ed
before INIT_DELAYED_WORK() is executed.

[Severity: High]
Does this code leak the platform device on driver unbind?

The returned pdev is discarded, meaning platform_device_unregister() is nev=
er
called during driver teardown.

Since the platform device's .data pointer references the struct it6505 allo=
cated
by the I2C driver, could this also lead to a use-after-free when the ALSA
subsystem interacts with the codec after the I2C driver is unbound?

[Severity: High]
When the I2C driver is removed, the newly added delayed_audio work does not
appear to be cancelled anywhere.

Since struct it6505 is freed by devres on unbind, could a pending delayed w=
ork
execute on the freed memory and cause a use-after-free?

[Severity: High]
This is a pre-existing issue, but similar to the delayed_audio work, the I2C
driver's remove path appears to be missing synchronous cancellation for
hdcp_work and hdcp_wait_ksv_list.

Could this also lead to a use-after-free if the module is removed while HDCP
authentication is ongoing?

> +	DRM_DEV_DEBUG_DRIVER(dev, "bound to %s", HDMI_CODEC_DRV_NAME);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784393979.gi=
t.daniel@makrotopia.org?part=3D1
