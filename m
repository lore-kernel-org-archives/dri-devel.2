Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D88C44520
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 02:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924B410E26B;
	Tue, 21 Jul 2026 02:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KmUpFI9s";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB29E10E26B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 02:38:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2F3660A61;
 Tue, 21 Jul 2026 02:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708AA1F000E9;
 Tue, 21 Jul 2026 02:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784601533;
 bh=OYRIPClAFO9ZdXnZgz3JDYsJchWNKG4JZR12GPLuCNc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KmUpFI9stJzY4uyUaployRdnfkXq0MLhaSo60dlsAFzScITy1mhDx6K6Nd3RAQX7+
 ml9Oj0/4Y7hxe21ID6Eq72N9czurjEnPmkowRC9ce2RtWPc96keIX6baQl4PIAgsqy
 0slMKbDIc9aPUf+Vw5e0umySGbWBxiFKRr5jq6zKXCb/wQbwvnXKLo9OMJdsma7JWQ
 HusejKYcB8QpqK762tQbSiSCCDEvEYPMG//bInepAW5rACeIqgNHn1eJvuyHzJy2Ip
 lMn6DO0ikHm1qmEBfUlsV1GfMXW+e4djC8oUomZwHYtT50XNUkVNQnxujJEdyYDor7
 uYt3cGagxd7PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] drm/bridge: it6505: Add audio support
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <6e27cdb00758a7a55a12293be21e3a3bafe34296.1784600387.git.daniel@makrotopia.org>
References: <cover.1784600387.git.daniel@makrotopia.org>
 <6e27cdb00758a7a55a12293be21e3a3bafe34296.1784600387.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 02:38:52 +0000
Message-Id: <20260721023853.708AA1F000E9@smtp.kernel.org>
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
- [High] TOCTOU race and unsynchronized hardware access in audio FIFO error=
 IRQ handler.
- [High] Use-After-Free of audio codec device during driver removal.
- [High] Uninitialized audio mute state causes premature audio enablement.
--

--- Patch [3]: [PATCH v3 3/4] drm/bridge: it6505: Add audio support ---
commit 6cb75640ad011b0aa639c8886372817492ac07db
Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: drm/bridge: it6505: Add audio support

This commit adds audio support for the it6505 by bridging to the hdmi-codec.
It registers an hdmi-audio-codec platform device from probe and wires up
audio setup/shutdown helpers via hdmi_codec_ops.

Link: https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek=
.com/

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index f2ed76a05f6bc..37036ef5403fb 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2627,6 +2635,9 @@ static void it6505_irq_audio_fifo_error(struct it65=
05 *it6505)
> =20
>  	DRM_DEV_DEBUG_DRIVER(dev, "audio fifo error Interrupt");
> =20
> +	if (it6505->audio.mute)
> +		return;
> +
> +	if (it6505_audio_input(it6505))
> +		it6505_enable_audio(it6505);
>  }

[Severity: High]
Does this create a race condition where the mute state can be overridden?

Since it6505_irq_audio_fifo_error() checks it6505->audio.mute locklessly,
and it6505_audio_input() sleeps for 3-4ms:

drivers/gpu/drm/bridge/ite-it6505.c:it6505_audio_input() {
    ...
    reg05 =3D it6505_read(it6505, REG_RESET_CTRL);
    it6505_set_bits(it6505, REG_RESET_CTRL, AUDIO_RESET, 0x00);
    usleep_range(3000, 4000);
    regbe =3D it6505_read(it6505, REG_AUDIO_INPUT_FREQ);
    it6505_write(it6505, REG_RESET_CTRL, reg05);
    ...
}

If userspace triggers mute_stream(true) during this sleep, it acquires
the audio_lock and disables audio via REG_RESET_CTRL. When
it6505_audio_input() wakes up, it writes back the stale reg05 value.

Then it6505_enable_audio() is called, which grabs the lock and re-enables
audio without re-checking the mute flag. Should the mute flag be checked
again under the lock, or the hardware access synchronized differently?

[ ... ]

> @@ -3056,6 +3104,39 @@ static int it6505_audio_hook_plugged_cb(struct dev=
ice *dev,
>  					void *data,
>  					hdmi_codec_plugged_cb fn,
>  					struct device *codec_dev)
>  {
>  	struct it6505 *it6505 =3D data;
> =20
>  	it6505->plugged_cb =3D fn;
>  	it6505->codec_dev =3D codec_dev;
>  	it6505_plugged_status_to_codec(it6505);
> =20
>  	return 0;
>  }
> =20
> +static const struct hdmi_codec_ops it6505_audio_codec_ops =3D {
> +	.hw_params =3D it6505_audio_hw_params,
> +	.mute_stream =3D it6505_audio_mute,
> +	.audio_shutdown =3D it6505_audio_shutdown,
> +	.hook_plugged_cb =3D it6505_audio_hook_plugged_cb,
> +};
> +
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
> +	INIT_DELAYED_WORK(&it6505->delayed_audio, it6505_delayed_audio);

[Severity: High]
Does this leave it6505->audio.mute initialized to false?

Since the structure is zero-initialized, mute defaults to false before
ALSA configures it. If a FIFO error interrupt fires early, could this
cause it6505_irq_audio_fifo_error() to prematurely enable audio before
valid parameters are set? Should the initial mute state be set to true?

[ ... ]

> @@ -3647,6 +3735,8 @@ static void it6505_i2c_remove(struct i2c_client *cl=
ient)
>  {
>  	struct it6505 *it6505 =3D i2c_get_clientdata(client);
> =20
> +	platform_device_unregister(it6505->audio_pdev);
> +	cancel_delayed_work_sync(&it6505->delayed_audio);
>  	cancel_work_sync(&it6505->link_works);
>  	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
>  	cancel_delayed_work_sync(&it6505->hdcp_work);

[Severity: High]
Can this cause a use-after-free of the codec device?

Unregistering the platform device frees the codec device, but the threaded
IRQ (which is devm-managed) and extcon_wq are not shut down until later.

If an HPD interrupt fires or the workqueue is already running,
it6505_extcon_work() can call it6505_plugged_status_to_codec():

drivers/gpu/drm/bridge/ite-it6505.c:it6505_plugged_status_to_codec() {
    ...
    if (it6505->plugged_cb && it6505->codec_dev)
        it6505->plugged_cb(it6505->codec_dev,
                           status =3D=3D connector_status_connected);
    ...
}

This will dereference the freed it6505->codec_dev. Could the platform
device unregistration be moved after the workqueues and IRQ are stopped,
or should the pointers be explicitly cleared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784600387.gi=
t.daniel@makrotopia.org?part=3D3
