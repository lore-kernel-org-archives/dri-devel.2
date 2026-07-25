Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3EBC531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 03:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 595D110F4D3;
	Sat, 25 Jul 2026 03:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fFMapHMn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3189610F4D3
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:20:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8E004108D;
 Sat, 25 Jul 2026 03:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9E31F000E9;
 Sat, 25 Jul 2026 03:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784949622;
 bh=i3Rica2tPlmJrd2mRLAG0g5uBhemlN0utdaFnVQgc8c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fFMapHMnFNhHiihDH+qlrPtjG/oIk+roQynB5CTuMQD1LAbtnLEZef/jZQM7nfNvC
 Kz6Tz15V/yJ2aDgLZAohfm0azoo8wrytcfUr8NL7zyPs7CF7emu7ij88tq2fI6YFwh
 mydY1ACYnM8EZb/cKNW71fcIY/cEHGfLpy9oS0a+WCGhjAIC7zDw5aSMKY96M7ySRB
 TugvoS2Zk5oxL7KjkJH9ikYKUm+1sh02nQ6I9Wg5/JUCcZzn4vpNDAr4Ge9BaxzQUN
 j2JI7MbtUaGVsHKGeVTg+sr4kMObJiRQQzXdgtcMWjOQ3XYaR97MDmGzViQATcch2z
 XalrxVS0K4X9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/13] drm/bridge: it6505: avoid division by zero in
 pixel clock calculation
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <a9664c9ddd026a22cd246c0aac878d3c0e204d50.1784947240.git.daniel@makrotopia.org>
References: <cover.1784947240.git.daniel@makrotopia.org>
 <a9664c9ddd026a22cd246c0aac878d3c0e204d50.1784947240.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 03:20:22 +0000
Message-Id: <20260725032022.9C9E31F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unhandled hardware state when reading REG_AUDIO_INPUT_FREQ leads t=
o division by zero and kernel panic.
- [Medium] Missing error handling for I2C reads leads to data corruption in=
 video timing calculations.
- [Medium] Data race in `it6505_calc_video_info` corrupts pixel clock count=
er reading.
--

--- Patch [6]: [PATCH v6 06/13] drm/bridge: it6505: avoid division by zero =
in pixel clock calculation ---
commit 00522edef86150c061773cb0103cee92136a7a79
Author: Daniel Golle <daniel@makrotopia.org>
Subject: drm/bridge: it6505: avoid division by zero in pixel clock calculat=
ion

This commit fixes a potential division by zero in the pixel clock
computation. It moves the division of the counter sum to after the zero
check to avoid truncation of small values. This prevents sums of 1 or 2
from being evaluated as 0 and bypassing the check.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 3806b0b966376..b7eb746c8f8e5 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -751,12 +751,13 @@ static void it6505_calc_video_info(struct it6505 *i=
t6505)
>  		sum +=3D rddata;

[Severity: Medium]
This is a pre-existing issue, but does this bitwise mask without checking f=
or
negative error codes cause data corruption?

If I2C reads fail and return -ENODEV, the negative return value is
directly bitwise-masked and treated as a valid hardware reading.

For example, earlier in it6505_calc_video_info():

    htotal =3D it6505_read_word(it6505, REG_INPUT_HTOTAL) & 0x1FFF;

And similarly for the counter:

    rddata =3D it6505_read_word(it6505, REG_PCLK_COUNTER_VALUE) & 0xFFF;
    sum +=3D rddata;

Could this lead to negative error codes being added to the counter sum,
corrupting the subsequent pixel clock math?

[Severity: Medium]
This isn't a bug introduced by this patch, but is there a data race in
it6505_calc_video_info() that corrupts the pixel clock counter reading?

This function performs a multi-step hardware sequence without holding any
locks:

    it6505_set_bits(it6505, REG_DATA_CTRL0, ENABLE_PCLK_COUNTER,
                    ENABLE_PCLK_COUNTER);
    usleep_range(10000, 15000);
    it6505_set_bits(it6505, REG_DATA_CTRL0, ENABLE_PCLK_COUNTER, 0x00);
    rddata =3D ...

Since this can be executed concurrently by the threaded IRQ handler
it6505_irq_scdt() and the debugfs read handler
receive_timing_debugfs_show(), could a debugfs read occurring during the IRQ
handling interleave register writes?

One thread might disable the counter prematurely while the other is sleepin=
g,
resulting in an abnormally small reading.

Is this race condition the root cause of the division by zero that this pat=
ch
attempts to mitigate?

>  	}
> =20
> +	sum /=3D 3;
> +
>  	if (sum =3D=3D 0) {
>  		DRM_DEV_DEBUG_DRIVER(dev, "calc video timing error");
>  		return;
>  	}
> =20
> -	sum /=3D 3;
>  	pclk =3D 13500 * 2048 / sum;
>  	it6505->video_info.clock =3D pclk;
>  	it6505->video_info.hdisplay =3D hdew;

[Severity: High]
This is a pre-existing issue not introduced by this patch, but can reading =
an
unhandled hardware state lead to a kernel panic?

Looking at it6505_enable_audio():

    regbe =3D it6505_read(it6505, REG_AUDIO_INPUT_FREQ);
    DRM_DEV_DEBUG_DRIVER(dev, "regbe:0x%02x audio input fs: %d.%d kHz",
                         regbe, 6750 / regbe, (6750 % regbe) * 10 / regbe);

If the hardware register contains 0, for instance if the audio clock is not
fully active or uninitialized, will the subsequent DRM_DEV_DEBUG_DRIVER mac=
ro
trigger a division by zero when evaluating 6750 / regbe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784947240.gi=
t.daniel@makrotopia.org?part=3D6
