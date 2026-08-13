Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EF9C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243B610E025;
	Thu, 13 Aug 2026 17:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dICXPOth";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4401610E025
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:25:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C30AC40640;
 Thu, 13 Aug 2026 17:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8631F00A3A;
 Thu, 13 Aug 2026 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786641927;
 bh=JKVAVtnpvTb+OSD+pjJVAgcMXjxIdXO4lrWDvbXyoW4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dICXPOthUxRV5kQ+cMO1io1IC0w9sTWOhl18XrqXb6tdKp3u673RYUMP8r7IlkCkM
 6c7TLZ3frLZtNMf87OFIv38/xiER2qKgtSKK4/FFlkRZVdW5slYuabY1FHRl2d4uCO
 y473XeJcL2gWDcQjLFirfen6c5ykn4SUJIgrfxZ1LQtFVL/oT6egKgaTUVbk8f5/rB
 A03C0q9AVtxTds7uTE4FtEOT75W0SjJXpL+DjGRM1dZ54YwK1+2RxHMX0uwlGqwfNb
 2ASms2RVlhTDZtEizK54M6bW7ctJJLGL/iZP+18i+tQxNMGIn4jAbfDURllw0YxA7J
 P3zHRpZpB3qWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Scale custom brightness curve from
 full range
To: "Akhmed Zhitaev" <zhitaevakh@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813170959.22073-1-zhitaevakh@gmail.com>
References: <20260813170959.22073-1-zhitaevakh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:25:27 +0000
Message-Id: <20260813172527.7B8631F00A3A@smtp.kernel.org>
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
- [High] Double scaling of the brightness value when a custom brightness cu=
rve is used, causing the minimum backlight level to be incorrectly raised.
--

--- Patch [1]: [PATCH] drm/amd/display: Scale custom brightness curve from =
full range ---
commit d7add749f0052e896a6fee3206021e51b2fd8540
Author: Akhmed Zhitaev <zhitaevakh@gmail.com>

drm/amd/display: Scale custom brightness curve from full range

This patch changes the input scaling for custom brightness curves to
map the userspace [0..max] range to the curve's [0..255] range. This
prevents generating a curve input greater than 255 for panels with a
nonzero minimum PWM level.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 941c1a3128249..7908b15370845 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> -/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
> -static inline u32 scale_input_to_fw(int min, int max, u64 input)
> +/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
> +static inline u32 scale_input_to_fw(int max, u64 input)
>  {
> -	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
> +	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
>  }
> =20
>  /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> @@ -5281,7 +5281,7 @@ static void convert_custom_brightness(const struct =
amdgpu_dm_backlight_caps *cap
>  				      unsigned int min, unsigned int max,
>  				      uint32_t *user_brightness)
>  {
> -	u32 brightness =3D scale_input_to_fw(min, max, *user_brightness);
> +	u32 brightness =3D scale_input_to_fw(max, *user_brightness);
>  	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
>  	int left, right;

[Severity: High]
This isn't a bug introduced by this patch, but does the current code
double-scale the brightness when a custom brightness curve is used?

Looking at scale_fw_to_input() in drivers/gpu/drm/amd/display/amdgpu_dm/amd=
gpu_dm.c,
it maps the curve's [0..255] output to [min..max]:

static inline u32 scale_fw_to_input(int min, int max, u64 input)
{
	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min),
					   AMDGPU_MAX_BL_LEVEL);
}

This is used at the end of convert_custom_brightness(), meaning the output
brightness value is returned in the [min..max] range.

However, in convert_brightness_from_user(), the output gets rescaled again:

	convert_custom_brightness(caps, min, max, &brightness);

	// Rescale 0..max to min..max
	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);

Because scale_fw_to_input() already mapped it to [min..max], and
convert_brightness_from_user() rescales it to [min..max] again under the
assumption that the value is in [0..max], the minimum offset is applied twi=
ce.

Since this patch explicitly aims to fix the brightness scaling logic introd=
uced
by commit 8dbd72cb7900, should scale_fw_to_input() or
convert_brightness_from_user() also be updated to avoid raising the minimum
backlight level incorrectly for panels using custom brightness curves?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813170959.2207=
3-1-zhitaevakh@gmail.com?part=3D1
