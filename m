Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D29DC531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 03:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F69A10E0D6;
	Sat, 25 Jul 2026 03:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jhzG8tex";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC7210E0D6
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:16:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1576A42A9D;
 Sat, 25 Jul 2026 03:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E191F000E9;
 Sat, 25 Jul 2026 03:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784949384;
 bh=vIwpGcQl3GWAN9j3Ip8H+OV+bkorLPHrAaSl7g0iJ3E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jhzG8tex6G6jJRlrdTinb8TdQQD2+lV48DIbVTwIu4IEf+xK8I0MplXR1apC27KTz
 e3ppWi71q0oO71WE0hlrzeqFl2x04P4pzMzNi0gdweLIKqmUBihV4kUBdIptlGZqML
 V6K5gaVbauSs+CNVbfmQrtTQ3KllqHeJbPufr0EmcD2I1zGgOiHU+FGKV3s+8eEt25
 Rq4WDJJl7ugQXc0WPe5RfG+OUEN4ZLEwW5w+Hx0cQY0PGclYGlmMYVxa20p97CjHh6
 c+o/x0HU0HV4qCSTXITCYoxrMpPdXCAkxIIrqzgOYGh+AiAKJYXb07FHE2w/0akoMA
 duLzgU5NFKpdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/13] drm/bridge: it6505: avoid division by zero in
 audio FS debug print
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <b3e19f2081a34df3814f766ab1ab95dc6f12a02d.1784947240.git.daniel@makrotopia.org>
References: <cover.1784947240.git.daniel@makrotopia.org>
 <b3e19f2081a34df3814f766ab1ab95dc6f12a02d.1784947240.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 03:16:23 +0000
Message-Id: <20260725031623.C3E191F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unhandled negative error code from it6505_read() is written back t=
o REG_RESET_CTRL, inadvertently resetting the entire device.
- [High] Unhandled negative error codes from it6505_read_word() silently co=
rrupt the video timing calculations.
--

--- Patch [7]: [PATCH v6 07/13] drm/bridge: it6505: avoid division by zero =
in audio FS debug print ---
commit fb85e4882527f59c0b49c06140294c57c71382ab
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: avoid division by zero in audio FS debug print

This commit ensures the divisor is greater than zero before calculating and
printing the audio input frequency in the debug output. This prevents a div=
ision
by zero crash if the audio clock hasn't been latched and it6505_read() retu=
rns 0.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index b7eb746c8f8e5..04711c8f4a041 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -1623,8 +1623,11 @@ static void it6505_enable_audio(struct it6505 *it6=
505)
>  	it6505_set_bits(it6505, REG_AUDIO_SRC_CTRL, AUDIO_FIFO_RESET, 0x00);
>  	it6505_set_bits(it6505, REG_RESET_CTRL, AUDIO_RESET, 0x00);
>  	regbe =3D it6505_read(it6505, REG_AUDIO_INPUT_FREQ);
> -	DRM_DEV_DEBUG_DRIVER(dev, "regbe:0x%02x audio input fs: %d.%d kHz",
> -			     regbe, 6750 / regbe, (6750 % regbe) * 10 / regbe);
> +	if (regbe > 0)
> +		DRM_DEV_DEBUG_DRIVER(dev,
> +				     "regbe:0x%02x audio input fs: %d.%d kHz",
> +				     regbe, 6750 / regbe,
> +				     (6750 % regbe) * 10 / regbe);
>  	it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_AUD_MUTE, 0x00);
>  }

[Severity: High]
This is a pre-existing issue, but I noticed another place where it6505_read=
()
errors might cause problems. In it6505_audio_input(), if an I2C read fails,
does this write the negative error code back to REG_RESET_CTRL?

drivers/gpu/drm/bridge/ite-it6505.c:it6505_audio_input() {
    ...
    reg05 =3D it6505_read(it6505, REG_RESET_CTRL);
    ...
    it6505_write(it6505, REG_RESET_CTRL, reg05);
    ...
}

If it6505_read() returns -19 (-ENODEV), the lower 8 bits (0xED) would set
both ALL_LOGIC_RESET (BIT 2) and VIDEO_RESET (BIT 0). Could this
unintentionally reset the entire hardware state machine?

[Severity: High]
This is also a pre-existing issue, but similar unhandled negative error cod=
es
seem to be present in it6505_calc_video_info():

drivers/gpu/drm/bridge/ite-it6505.c:it6505_calc_video_info() {
    ...
    htotal =3D it6505_read_word(it6505, REG_INPUT_HTOTAL) & 0x1FFF;
    hdes =3D it6505_read_word(it6505, REG_INPUT_HACTIVE_START) & 0x1FFF;
    ...
}

If it6505_read_word() returns a negative error code (e.g. -19), would the
bitwise AND with 0x1FFF transform it into a large positive integer (e.g.
0x1FED)?  Could these invalid values then corrupt the video timing state wh=
en
accumulated into the pixel clock calculations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784947240.gi=
t.daniel@makrotopia.org?part=3D7
