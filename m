Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBA9C531D0
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5BF10E665;
	Sat, 25 Jul 2026 05:25:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="khsNSgKS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A976F10E665
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:25:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 64C8141369;
 Sat, 25 Jul 2026 05:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1247F1F000E9;
 Sat, 25 Jul 2026 05:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784957130;
 bh=4yhKbF89D+sur4LPo1FJj2/Q26z5xTkhor4JhoJ68qk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=khsNSgKSq+XQ5QiWyViI4HY6vTelqKZNNY5Z5eh+evsa33yWk6Xf+XDcBJYpS9Sok
 DMZG4UgddNDxEyg59VEjlE88IiCQY3rL4hmAXRC+8Lz7gUw01hZfDSQ7iEP3P343Iq
 VKD/2kEIuojbN+1GMXiHoOv+MHklTFozfnvJGJd6BhrQrfFVrE7MbQoe2n0a/i9R2Y
 ZNXS6ZB/8tqAiGBCyDFn2qpvECf3deFEeUmYhSEH2bRYBoGzpmgkEJj5hAS/NNYmQE
 OGP7TPmlRZIFIZt9JjUfs1xubY0D1vVUvD1heTBj9+oWn9mlJxOKeLCWs2w0Rd52hQ
 xtk5cWkmD4eVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/13] drm/bridge: it6505: Add audio support
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <849db02af75f9f8bab9e211395435fda12d27c3e.1784947240.git.daniel@makrotopia.org>
References: <cover.1784947240.git.daniel@makrotopia.org>
 <849db02af75f9f8bab9e211395435fda12d27c3e.1784947240.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:25:29 +0000
Message-Id: <20260725052530.1247F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing PM runtime reference in audio callbacks leads to TOCTOU ra=
ce with device power-off.
--

--- Patch [12]: [PATCH v6 12/13] drm/bridge: it6505: Add audio support ---
commit 10341e11c958ca412de2f96980c0f7ee9f5854c5
Author: Jiaxin Yu <jiaxin.yu@mediatek.com>

drm/bridge: it6505: Add audio support
   =20
Add audio support for it6505 by bridging to the hdmi-codec: register
an "hdmi-audio-codec" platform device from probe and wire up the
previously unused audio helpers via hdmi_codec_ops. This unblocks the
mt8186-mt6366 sound card which references it6505 as the I2S3 codec.

Link: https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek=
.com/

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index aeaa7b5ecf5aa..c560f1258f6d7 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
[ ... ]
> -static void __maybe_unused it6505_audio_shutdown(struct device *dev, voi=
d *data)
> +static void it6505_audio_shutdown(struct device *dev, void *data)
>  {
>  	struct it6505 *it6505 =3D dev_get_drvdata(dev);
> =20
> +	mutex_lock(&it6505->audio_lock);
> +	it6505->audio.mute =3D true;
>  	if (it6505->powered)
> -		it6505_disable_audio(it6505);
> +		__it6505_disable_audio(it6505);
> +	mutex_unlock(&it6505->audio_lock);
> +	cancel_delayed_work_sync(&it6505->delayed_audio);
> +}
[ ... ]
> +static int it6505_audio_mute(struct device *dev, void *data,
> +			     bool enable, int direction)
> +{
> +	struct it6505 *it6505 =3D dev_get_drvdata(dev);
> +
> +	DRM_DEV_DEBUG_DRIVER(dev, "mute: %d", enable);
> +
> +	/*
> +	 * Delay enabling audio until the stream is unmuted; InfoFrames
> +	 * without audio data upset some DP-to-HDMI dongles.
> +	 */
> +	if (enable) {
> +		mutex_lock(&it6505->audio_lock);
> +		it6505->audio.mute =3D true;
> +		if (it6505->powered)
> +			__it6505_disable_audio(it6505);
> +		mutex_unlock(&it6505->audio_lock);
> +		cancel_delayed_work_sync(&it6505->delayed_audio);
> +	} else {
> +		mutex_lock(&it6505->audio_lock);
> +		it6505->audio.mute =3D false;
> +		mutex_unlock(&it6505->audio_lock);
> +		queue_delayed_work(system_wq, &it6505->delayed_audio,
> +				   msecs_to_jiffies(180));
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Does this code race with device power-off?

If the audio stream is unmuted via ALSA, it6505_audio_mute() queues
it6505->delayed_audio to run after 180ms.

If a user unplugs the DP cable during this delay, it6505_extcon_work() calls
pm_runtime_put_sync() on the parent device, invoking the runtime suspend
callback it6505_poweroff().

it6505_poweroff() disables regulators and asserts the reset GPIO before
clearing the it6505->powered flag at the very end of the function. It does
not cancel the delayed work.

If it6505_delayed_audio() (or a concurrent it6505_audio_mute() /
it6505_audio_shutdown()) checks it6505->powered before it6505_poweroff()
updates the flag, they could proceed to issue I2C writes while the device's
power is physically cut. This can result in I2C bus lockups since unpowered
chips may pull SDA/SCL lines low.

Should these functions use a PM runtime reference (e.g., via
pm_runtime_get_if_active()) to safely access the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784947240.gi=
t.daniel@makrotopia.org?part=3D12
