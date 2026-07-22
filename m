Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F8CC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE5E10E174;
	Wed, 22 Jul 2026 01:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MW8dexEd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0575510E174
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:15:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C871A41688;
 Wed, 22 Jul 2026 01:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976E31F000E9;
 Wed, 22 Jul 2026 01:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784682930;
 bh=/MBZBfUwM1CuJwfGXyz5dV3P6YfHZqrEMUV1GsgyppU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MW8dexEdb3HwUh7YJesd3DbM/CKraBww3uZYtYtmZMx+keM3Um0/oUHBZVuWXVsaf
 s4DQKmjXdYrB84B056YPL1IEvfalUmqV/49Ep4BXrGyblATkJ9s+gCbwjoXscSdzaD
 f4AUC3QsQj4C0gu7SI9HaAp/p1E2nbJPlvUOkDLLTUWA4SJyA9TU6WUuWtcH4KknZj
 qLBq8WFkvPucNVcBpydQab2EtArW0T8vwFF1vAZ71wOQHu691FsaopjxxLmvTx1Ffz
 EjbN9NsmvfiGJBgFYz/VdE6UYYcXl5AwT2X7Ea+lzKUnrPbkAhIfYKrl8Ge35qyceN
 lx6XDCf8VfIjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] drm/bridge: it6505: Add audio support
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <82871481f951bbba67febdf7a7445d01f0bd60f2.1784681487.git.daniel@makrotopia.org>
References: <cover.1784681487.git.daniel@makrotopia.org>
 <82871481f951bbba67febdf7a7445d01f0bd60f2.1784681487.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 01:15:30 +0000
Message-Id: <20260722011530.976E31F000E9@smtp.kernel.org>
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
- [High] Data race and dangling pointer dereference (Use-After-Free) in `it=
6505_plugged_status_to_codec`.

Pre-existing issues:
- [High] Use-After-Free of device_node `ep` in `it6505_parse_dt`.
- [High] Potential divide-by-zero kernel panic if the audio input frequency=
 register reads as 0.
--

--- Patch [4]: [PATCH v4 4/5] drm/bridge: it6505: Add audio support ---
commit cb584e38b3bb2386c2c945750f3e9126c5d8acfa
Author: Jiaxin Yu <jiaxin.yu@mediatek.com>

drm/bridge: it6505: Add audio support

This commit adds audio support for the it6505 bridge by registering an
hdmi-audio-codec platform device. It wires up the previously unused audio
setup and shutdown helpers via hdmi_codec_ops. The patch also introduces
locking to serialize audio enable/disable paths across different contexts.

Link: https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek=
.com/

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c

[ ... ]

> @@ -1629,6 +1640,14 @@ static void it6505_enable_audio(struct it6505 *it6=
505)
>  	it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_AUD_MUTE, 0x00);
>  }

[Severity: High]
This is a pre-existing issue, but since this patch wires up the audio helpe=
rs
and makes them reachable, can this code cause a divide-by-zero panic?

In __it6505_enable_audio(), the variable regbe is read from the hardware:

    regbe =3D it6505_read(it6505, REG_AUDIO_INPUT_FREQ);
    DRM_DEV_DEBUG_DRIVER(dev, "regbe:0x%02x audio input fs: %d.%d kHz",
                         regbe, 6750 / regbe, (6750 % regbe) * 10 / regbe);

If the hardware register reads as 0 (e.g., due to an uninitialized clock or=
 bus
error), regbe will be 0. If CONFIG_DRM_USE_DYNAMIC_DEBUG is disabled, the m=
acro
expands to a standard function call, meaning the division 6750 / regbe is
unconditionally evaluated before the call, triggering a kernel panic.

[ ... ]

> -static int __maybe_unused it6505_audio_hook_plugged_cb(struct device *de=
v,
> -						       void *data,
> -						       hdmi_codec_plugged_cb fn,
> -						       struct device *codec_dev)
> +static int it6505_audio_hook_plugged_cb(struct device *dev,
> +					void *data,
> +					hdmi_codec_plugged_cb fn,
> +					struct device *codec_dev)
>  {
>  	struct it6505 *it6505 =3D data;

[Severity: High]
Can this cause a use-after-free if the hdmi-audio-codec driver is unbound
concurrently?

When the codec driver unbinds, its remove function calls this hook to set
it6505->plugged_cb and it6505->codec_dev to NULL. However, this is done
without holding mode_lock.

Concurrently, if an HPD interrupt or DRM ioctl invokes it6505_bridge_detect=
(),
it calls it6505_plugged_status_to_codec():

static void it6505_plugged_status_to_codec(struct it6505 *it6505)
{
        enum drm_connector_status status =3D it6505->connector_status;

        if (it6505->plugged_cb && it6505->codec_dev)
                it6505->plugged_cb(it6505->codec_dev, ...);
}

Could the detect thread pass the if-condition, get preempted while the codec
unbinds and its module unloads, and then resume to call the now-dangling
function pointer with the freed codec_dev?

[ ... ]

> @@ -3616,6 +3712,12 @@ static int it6505_i2c_probe(struct i2c_client *cli=
ent)
>  		return err;
>  	}
> =20
> +	err =3D it6505_register_audio_driver(dev);
> +	if (err < 0) {
> +		dev_err(dev, "Failed to register audio driver: %d", err);
> +		return err;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does this code lead to a use-after-free
during device probe?

In it6505_parse_dt() (which is called earlier in it6505_i2c_probe()), the ep
node is released via of_node_put(ep) and subsequently dereferenced:

    ep =3D of_graph_get_endpoint_by_regs(np, 1, 0);
    of_node_put(ep);

    if (ep) {
        len =3D it6505_get_data_lanes_count(ep, 1, 4);

If of_node_put(ep) drops the last reference, the node is freed, and the
subsequent call to it6505_get_data_lanes_count(ep, ...) will access freed
memory.

>  	INIT_WORK(&it6505->link_works, it6505_link_training_work);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784681487.gi=
t.daniel@makrotopia.org?part=3D4
