Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359E8C4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 22:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 439BD10E4F8;
	Wed, 22 Jul 2026 22:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lltJcGCi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0113510E4F8
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 22:07:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9672B432DC;
 Wed, 22 Jul 2026 22:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5908F1F000E9;
 Wed, 22 Jul 2026 22:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784758053;
 bh=hDXuZkh0ikxUJvPKnsDdcCR+IQhhYr4EmLzAi2IywjE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lltJcGCiq+0OR9mvTJjwRTyv9nv8FbrN9jW428DQBQJzbnb+RseE964xRt+bBoM26
 TF3zz8kFTXZSCkUx/xYgkseVGyJICyJ0w66hE+WjEhfJ14QfQTI2SExB/wZ35WSWKD
 To1RALs2PqWLEd2DBgImtRXpfIQS6L1pbPJwhn5YdQktm9H8oThmjA3AzH+IZ7AkSz
 IMTdCWV7M53r5vqdX+iKi1VBMHfghDSUVwOM5X8SoZFgL2j9rSBu/IdWFbxF/GMIFy
 yY4ypbheXFTmN4kV7TKMjNUJJ9FcphTT1t1c0RvyzdMX3hlVx5bcUJ0fDB7XgbWHmm
 sZZ51gWHgKINQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/11] drm/bridge: it6505: Add audio support
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <80ddba1acc32091567a13b360d2e407a283d10ac.1784717129.git.daniel@makrotopia.org>
References: <cover.1784717129.git.daniel@makrotopia.org>
 <80ddba1acc32091567a13b360d2e407a283d10ac.1784717129.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 22:07:32 +0000
Message-Id: <20260722220733.5908F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Data race in it6505_variable_config() clobbers active ALSA audio=
 parameters during hotplug events.

Pre-existing issues:
- [High] Concurrent read-modify-write on REG_RESET_CTRL across a sleeping r=
egion causes hardware state corruption.
--

--- Patch [10]: [PATCH v5 10/11] drm/bridge: it6505: Add audio support ---
commit 5131d6a60c257db17a0ee56c8c36b3d7edb7c72f
Author: Jiaxin Yu <jiaxin.yu@mediatek.com>

drm/bridge: it6505: Add audio support

Add audio support for it6505 by bridging to the hdmi-codec: register
an "hdmi-audio-codec" platform device from probe and wire up the
previously unused audio helpers via hdmi_codec_ops. This unblocks the
mt8186-mt6366 sound card which references it6505 as the I2S3 codec.

Link: https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek=
.com/

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 6f23203d5f2a6..75b287cda8016 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c

[ ... ]

> @@ -2631,8 +2643,10 @@ static void it6505_irq_audio_fifo_error(struct it6=
505 *it6505)
> =20
>  	DRM_DEV_DEBUG_DRIVER(dev, "audio fifo error Interrupt");
> =20
> -	if (it6505_audio_input(it6505))
> -		it6505_enable_audio(it6505);
> +	mutex_lock(&it6505->audio_lock);
> +	if (!it6505->audio.mute && it6505_audio_input(it6505))
> +		__it6505_enable_audio(it6505);
> +	mutex_unlock(&it6505->audio_lock);
>  }

[Severity: High]
This is a pre-existing issue, but does the call to it6505_audio_input()
here risk corrupting hardware state?

Looking at it6505_audio_input(), it performs a read, sleeps, and then
blindly writes back the old register value:

it6505_audio_input() {
    reg05 =3D it6505_read(it6505, REG_RESET_CTRL);
    it6505_set_bits(it6505, REG_RESET_CTRL, AUDIO_RESET, 0x00);
    usleep_range(3000, 4000);
    regbe =3D it6505_read(it6505, REG_AUDIO_INPUT_FREQ);
    it6505_write(it6505, REG_RESET_CTRL, reg05);
}

If another thread (such as a modeset or hotplug handler) modifies other bits
in REG_RESET_CTRL (like VIDEO_RESET) during the 3-4ms sleep window, won't
this blind write overwrite those concurrent changes with stale data?

[ ... ]

> @@ -3048,27 +3060,111 @@ static int __maybe_unused it6505_audio_setup_hw_=
params(struct it6505 *it6505,
>  		return -EINVAL;
>  	}
> =20
> +	mutex_lock(&it6505->audio_lock);
> +	it6505->audio.channel_count =3D params->cea.channels;
> +	it6505->audio.sample_rate =3D audio_sample_rate_map[i].rate;
> +	it6505->audio.word_length =3D word_length;
> +	mutex_unlock(&it6505->audio_lock);
> +
>  	return 0;
>  }

[Severity: Medium]
Does this leave a data race with it6505_variable_config()?

While this code correctly takes the new audio_lock to update the audio
parameters, it6505_variable_config() appears to reset these same
parameters to default values without holding the lock:

it6505_variable_config() {
    ...
    it6505->audio.sample_rate =3D AUDIO_SAMPLE_RATE;
    it6505->audio.channel_count =3D AUDIO_CHANNEL_COUNT;
    it6505->audio.type =3D AUDIO_TYPE;
    ...
}

Since it6505_variable_config() is called by it6505_irq_hpd() during hotplug
events, could an external hotplug event concurrently overwrite the ALSA
parameters negotiated here, causing the audio pipeline to use corrupted
settings when enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784717129.gi=
t.daniel@makrotopia.org?part=3D10
