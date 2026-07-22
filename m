Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CAEC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6624110EBFD;
	Wed, 22 Jul 2026 01:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iFVAKXDd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF4810EBFD
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:16:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 76DC240E34;
 Wed, 22 Jul 2026 01:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCB01F000E9;
 Wed, 22 Jul 2026 01:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784682992;
 bh=IYkSq9tGc3lSFWdDxkJwVpu/hkXbzvkcv+65NtqXktc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iFVAKXDdquz4sGHxIKFgQZoh3+1J3kr94vXZPmGayXxTOcYaC39yOdvj5u873AdO+
 cA596WIO6g4bvpIwcaSyDhcPeaxajlrpNg4ndVmCbNbHlzos8/a91uaa8im5xilEJI
 7Jcg2ASGs1sp4SdEn40Wyt7zJyywsIHfdfrgNJ3czQpcwMM6BfrFsDDeOYt5IAmGpT
 Zud7TrjCW/gPbJNWhgz/MzRxStQWKWmqC8d3lXikVOn4jVJMavx4q8tTHsJE5BotrO
 2f/2kITU0C1k524ecyz+e0yKZB4RvF9EEtBaXqSReb1l31QcMV5YldGWFE+v+Nu+Bu
 sH8jNhYo7Q1cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] drm/bridge: it6505: guard against zero channel
 count in audio infoframe
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <94721d5c75645a574263cc849249c56e504c2ade.1784681487.git.daniel@makrotopia.org>
References: <cover.1784681487.git.daniel@makrotopia.org>
 <94721d5c75645a574263cc849249c56e504c2ade.1784681487.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 01:16:31 +0000
Message-Id: <20260722011632.2FCB01F000E9@smtp.kernel.org>
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
- [High] Kernel panic due to division by zero when calculating audio input =
frequency.
- [High] Kernel panic due to division by zero when calculating video pixel =
clock.
--

--- Patch [3]: [PATCH v4 3/5] drm/bridge: it6505: guard against zero channe=
l count in audio infoframe ---
commit 8ace85a52fcbf9bce4f2a154064b6799263b545d
Author: Daniel Golle <daniel@makrotopia.org>
Subject: drm/bridge: it6505: guard against zero channel count in audio info=
frame

This commit guards against a zero channel count in it6505_enable_audio_info=
frame()
to prevent an out-of-bounds stack read. It also fixes a debug print logging=
 an
incorrect channel count on failure.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 2a8298ee6c03c..443ea55797441 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c

[ ... ]

While reviewing this, I noticed a couple of pre-existing issues in this fil=
e:

drivers/gpu/drm/bridge/ite-it6505.c:it6505_calc_video_info() {
	...
	if (sum =3D=3D 0) {
		DRM_DEV_DEBUG_DRIVER(dev, "calc video timing error");
		return;
	}

	sum /=3D 3;
	pclk =3D 13500 * 2048 / sum;
	...
}

[Severity: High]
This is a pre-existing issue, but can this integer division shrink small su=
ms
to 0?

If the accumulated readings are very small (e.g., sum is 1 or 2), the
integer division sum /=3D 3 will truncate the sum to 0.

The subsequent division for pclk will divide by zero and panic the kernel.

Should there be a check to ensure sum is still non-zero after the division
by 3?

[ ... ]

> @@ -1575,6 +1575,9 @@ static void it6505_enable_audio_infoframe(struct it=
6505 *it6505)
>  	struct device *dev =3D it6505->dev;
>  	u8 audio_info_ca[] =3D { 0x00, 0x00, 0x01, 0x03, 0x07, 0x0B, 0x0F, 0x1F=
 };
> =20
> +	if (!it6505->audio.channel_count)
> +		return;
> +
>  	DRM_DEV_DEBUG_DRIVER(dev, "infoframe channel_allocation:0x%02x",
>  			     audio_info_ca[it6505->audio.channel_count - 1]);
> =20

drivers/gpu/drm/bridge/ite-it6505.c:it6505_enable_audio() {
	...
	regbe =3D it6505_read(it6505, REG_AUDIO_INPUT_FREQ);
	DRM_DEV_DEBUG_DRIVER(dev, "regbe:0x%02x audio input fs: %d.%d kHz",
			     regbe, 6750 / regbe, (6750 % regbe) * 10 / regbe);
	...
}

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for regbe to
be 0 here?

If the hardware measures no audio clock, this register could return 0.

The debug print macro then divides by regbe, which would cause a kernel
panic due to division by zero.

Could we check if regbe is non-zero before using it as a divisor?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784681487.gi=
t.daniel@makrotopia.org?part=3D3
