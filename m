Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5442BC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B141E10E9B6;
	Mon, 20 Jul 2026 16:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b5Jler4a";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9709210E9B3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 16:01:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A929600AD;
 Mon, 20 Jul 2026 16:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4BA1F000E9;
 Mon, 20 Jul 2026 16:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784563278;
 bh=bKsCXdX2i/N1qGF7kuvYE3KUkDY2xMaitSOnRQ2PSec=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b5Jler4aR0lwFF56cqDepIGAsh2GNNqnDB57rvL1hgj68LaVbSB7Ytc2sgQxn1U84
 EeVsisMBgHNHCkS8kw/NtujdVrgeSejYdAu1//9NZHrp7I4+Oa1BxjstBJXtWcvbht
 l3537knlEbjFoSyZ3/HT5B5h+qjEMUNGYJ4O8D2nx1bvD4mRw92d+5Kfo/EyclaY3p
 4nG8PwhtbyoW2prjq27WidL1hdZSaF0fHycsunDA2kY1fjIVJJszJYtJo2bYRgZ2fL
 fpdE3Iwje8O1tyGSirHgtF3wA6doU1eNVXl+tRhut2/bqW4Wjs2/AiF72yPUcLzqBx
 TVSJtp8bW1Rhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/bridge: it6505: Add audio support
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <47c469b0e62513997236b8c4f6779159c1998143.1784561622.git.daniel@makrotopia.org>
References: <cover.1784561622.git.daniel@makrotopia.org>
 <47c469b0e62513997236b8c4f6779159c1998143.1784561622.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 16:01:18 +0000
Message-Id: <20260720160118.9A4BA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Concurrent execution of audio hardware configuration sequences wit=
hout serialization.
- [High] The AUDIO_FIFO_ERROR threaded IRQ blindly re-enables the audio str=
eam, circumventing ALSA's requested mute state.
- [Low] The debug log for unsupported channel counts prints the old/driver-=
configured channel count instead of the requested invalid count.

Pre-existing issues:
- [High] Missing cancellation for pre-existing workqueues in `it6505_i2c_re=
move` leads to Use-After-Free.
--

--- Patch [1]: [PATCH v2 1/2] drm/bridge: it6505: Add audio support ---
commit 368cb1a1072339bd0c22621289d60b4bd60b3bc6
Author: Jiaxin Yu <jiaxin.yu@mediatek.com>

drm/bridge: it6505: Add audio support

This commit adds audio support for the it6505 by bridging to the hdmi-codec
and registering an "hdmi-audio-codec" platform device. It wires up the
audio setup and shutdown helpers via hdmi_codec_ops.

Link: https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek=
.com/

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 8ecb43611dba8..d84441926e8e0 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c

[ ... ]

> @@ -2974,9 +2968,9 @@ static void __maybe_unused it6505_delayed_audio(str=
uct work_struct *work)
>  		it6505_enable_audio(it6505);
>  }
> =20
> -static int __maybe_unused it6505_audio_setup_hw_params(struct it6505 *it=
6505,
> -						       struct hdmi_codec_params
> -						       *params)
> +static int it6505_audio_setup_hw_params(struct it6505 *it6505,
> +					struct hdmi_codec_params
> +					*params)
>  {

[Severity: Low]
Does the error logging in this function print the wrong variable?

When an unsupported channel count is passed in params, the code errors out:

    if (params->cea.channels <=3D 1 || params->cea.channels > 8) {
        DRM_DEV_DEBUG_DRIVER(dev, "channel number: %d not support",
                     it6505->audio.channel_count);
        return -EINVAL;
    }

Should this log the invalid requested channel count (params->cea.channels)
instead of the previously configured or uninitialized driver state
(it6505->audio.channel_count)?

>  	struct device *dev =3D it6505->dev;
>  	int i =3D 0;

[ ... ]

> @@ -3031,18 +3025,52 @@ static int __maybe_unused it6505_audio_setup_hw_p=
arams(struct it6505 *it6505,
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
> +	if (enable) {
> +		cancel_delayed_work_sync(&it6505->delayed_audio);
> +		if (it6505->powered)
> +			it6505_disable_audio(it6505);

[Severity: High]
The commit message asks for input on whether a lock is warranted since
it6505_enable_audio() and it6505_disable_audio() can run concurrently.

Could this lack of serialization leave the hardware in a corrupted state?

These functions perform multi-step, non-atomic sequences of register writes,
such as toggling AUDIO_RESET and EN_AUD_MUTE. If it6505_audio_mute() calls
it6505_disable_audio() asynchronously while the IRQ handler or delayed work
is calling it6505_enable_audio(), they could interleave and break audio
playback.

[Severity: High]
Does the AUDIO_FIFO_ERROR IRQ handler respect the mute state requested here?

If the stream is muted by ALSA, it6505_audio_mute() disables audio. However,
if an AUDIO_FIFO_ERROR IRQ fires, it6505_irq_audio_fifo_error() appears to
blindly restart the audio stream:

drivers/gpu/drm/bridge/ite-it6505.c:it6505_irq_audio_fifo_error() {
    ...
    if (it6505_audio_input(it6505))
        it6505_enable_audio(it6505);
}

Could this bypass the software mute state and send InfoFrames without audio
data, potentially triggering the DP-to-HDMI dongle failure this
delayed-enable workaround was meant to prevent?

> +	} else {
> +		queue_delayed_work(system_wq, &it6505->delayed_audio,
> +				   msecs_to_jiffies(180));
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -3644,6 +3711,8 @@ static void it6505_i2c_remove(struct i2c_client *cl=
ient)
>  {
>  	struct it6505 *it6505 =3D i2c_get_clientdata(client);
> =20
> +	platform_device_unregister(it6505->audio_pdev);
> +	cancel_delayed_work_sync(&it6505->delayed_audio);
>  	drm_bridge_remove(&it6505->bridge);
>  	drm_dp_aux_unregister(&it6505->aux);
>  	it6505_debugfs_remove(it6505);

[Severity: High]
This is a pre-existing issue, but is it possible for other background
works to trigger a use-after-free here?

it6505_i2c_remove() cancels the newly added delayed_audio work, but
struct it6505 is allocated via devm_drm_bridge_alloc(). Once this function
returns, devres will immediately free the it6505 memory.

If any of the previously existing works (link_works, hdcp_wait_ksv_list, or
hdcp_work) are pending or executing, could they dereference the freed struct
it6505 memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784561622.gi=
t.daniel@makrotopia.org?part=3D1
