Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C3DC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 21:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0E110E4D3;
	Wed, 22 Jul 2026 21:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JsOTyO2t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4DBF10E4D3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 21:23:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E1FA40111;
 Wed, 22 Jul 2026 21:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDA11F000E9;
 Wed, 22 Jul 2026 21:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784755396;
 bh=v9jtjJznIZViId7HzsvuaHAQ3JDnsyxRyHvgdwSsAIk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JsOTyO2tbjW5RGcFV7pxgUPP9NDFx8w5MvujKJIUvzpqywTsrpg8I3SLj24Pidu5e
 d4IhkinHkSY+NwYgBh27MKj7JG2tCRDhndiwkgrV0c/jAR5+hxoVrkv5vCPDqYOgon
 OMXfPxh0ZQWb6H6oohwzyO0SPAOFO5et7t7fVgNc9PF2A9Lig4kV1yjYYFQmIJH4+C
 hMIxzhtYfxk1RtGoMkC2A1leKeK+/AHUidBJW3Pm01bVu7ul4ORWkx2S8ovXzxiCJk
 Z9C05YcLAyKm5CwH8AsgYc78bhoq1UK2dqJZHfXz/ehuZVNWsBZqX78lMI9ej2S6Rp
 HMlp0hEGN2R/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/11] drm/bridge: it6505: avoid division by zero in
 audio FS debug print
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <699a55456c1eb21b450b01f9d55277f72ddf12d9.1784717129.git.daniel@makrotopia.org>
References: <cover.1784717129.git.daniel@makrotopia.org>
 <699a55456c1eb21b450b01f9d55277f72ddf12d9.1784717129.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 21:23:15 +0000
Message-Id: <20260722212316.3EDA11F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing I2C read error handling in `it6505_audio_input()` leads to=
 logic reset and false positive audio enable.
--

--- Patch [7]: [PATCH v5 07/11] drm/bridge: it6505: avoid division by zero =
in audio FS debug print ---
commit ebf71cd14ba5699a1da0c18fc4c670be657e122d
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: avoid division by zero in audio FS debug print

This commit adds a check for regbe > 0 before printing debug information
about the audio input frequency in it6505_enable_audio(). This prevents a
division by zero when regbe is 0 or negative due to an I2C read failure.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index fc95f8d4f4129..81d2c96445318 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -1622,8 +1622,11 @@ static void it6505_enable_audio(struct it6505 *it6=
505)
>  	it6505_set_bits(it6505, REG_AUDIO_SRC_CTRL, AUDIO_FIFO_RESET, 0x00);
>  	it6505_set_bits(it6505, REG_RESET_CTRL, AUDIO_RESET, 0x00);
>  	regbe =3D it6505_read(it6505, REG_AUDIO_INPUT_FREQ);

[Severity: High]
This is a pre-existing issue, but since we are handling I2C read failures
for REG_AUDIO_INPUT_FREQ here, I noticed a similar problem in
it6505_audio_input().

If it6505_read() fails, it returns a negative error code. In
it6505_audio_input():

	reg05 =3D it6505_read(it6505, REG_RESET_CTRL);
	it6505_set_bits(it6505, REG_RESET_CTRL, AUDIO_RESET, 0x00);
	usleep_range(3000, 4000);
	regbe =3D it6505_read(it6505, REG_AUDIO_INPUT_FREQ);
	it6505_write(it6505, REG_RESET_CTRL, reg05);

The negative error code in reg05 is stored without validation and passed
directly to it6505_write(). Because the regmap uses 8-bit values, the integ=
er
is truncated (e.g., -5 becomes 0xFB). Will this inadvertently assert critic=
al
hardware reset bits such as ALL_LOGIC_RESET and VIDEO_RESET?

Additionally, at the end of it6505_audio_input():

	return regbe !=3D 0xFF;

Since regbe can be a negative error code if the second read fails, this che=
ck
evaluates to true. Could this falsely signal that audio should be enabled,
leading to unexpected behavior?

> -	DRM_DEV_DEBUG_DRIVER(dev, "regbe:0x%02x audio input fs: %d.%d kHz",
> -			     regbe, 6750 / regbe, (6750 % regbe) * 10 / regbe);
> +	if (regbe > 0)
> +		DRM_DEV_DEBUG_DRIVER(dev,
> +				     "regbe:0x%02x audio input fs: %d.%d kHz",
> +				     regbe, 6750 / regbe,
> +				     (6750 % regbe) * 10 / regbe);
>  	it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_AUD_MUTE, 0x00);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784717129.gi=
t.daniel@makrotopia.org?part=3D7
