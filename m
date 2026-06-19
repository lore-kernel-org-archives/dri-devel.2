Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAF7CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 08:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD7D89E33;
	Fri, 19 Jun 2026 08:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IR7V04HO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB9689E33
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 08:30:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9B04601E1
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 08:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3570D1F000E9;
 Fri, 19 Jun 2026 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781857823;
 bh=G60InooKcNilZInlfD8hpwjgfhnQDQ68GoGPGgAaeSU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IR7V04HOQfOubwmiyE9vqaXJu20KmDVPpi+xTn8SLfzP7HW6w537LwN+dkn2SeBE5
 +qjFB2qQ5I31WFZsUjJLbbFfCas0o6cilC0SxM69UJ73Ac2b2eGGezrHlKV+4LAY3P
 notoY6D2FfG5GNx/krE2Ie9KgEENFOvXLh4Eq1JG1yTMXPK49v9P5RRHp2++HPmRzr
 pthMtlW9as9eoc0Wlw5YQ8WUj3u5FHG6GBAH2+ALlCqpNg6cAzYHTQ+kax/mMHG61o
 sNXnRqClVFXcj4a5JcmyeO/QsTwVR8qOO7Fylk9dZIaTZMI6+goduf/d6UcsYAqeUA
 gxvAej/Ro7kCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: avoid 64-bit division
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260619082313.3583603-1-arnd@kernel.org>
References: <20260619082313.3583603-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 08:30:22 +0000
Message-Id: <20260619083023.3570D1F000E9@smtp.kernel.org>
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
- [High] Missing 64-bit cast leads to 32-bit multiplication overflow in num=
erator calculation.
- [High] 32-bit overflow in `modulo_hz * 100` causes incorrect divisor and =
potential divide-by-zero.
- [Medium] `ASSERT` logic is broken due to 32-bit integer overflow.
--

commit 9cda336bf5ea701c3d123b38512793b3554f5c3b
Author: Arnd Bergmann <arnd@arndb.de>

drm/amd/display: avoid 64-bit division

This commit avoids 64-bit division on 32-bit targets in DCE clock source
calculations by replacing open-coded division with div_u64().

> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index 83dcfae6c3c0d..ed9a6733d3457 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -1229,9 +1229,9 @@ static bool get_dp_dto_frequency_100hz(
>  			 */
>  			modulo_hz =3D REG_READ(MODULO[inst]);
>  			if (modulo_hz) {
> -				temp =3D div_u64((uint64_t)clock_hz * dp_dto_ref_khz * 10, modulo_hz=
);
> -				ASSERT(temp / 100 <=3D 0xFFFFFFFFUL);
> -				*pixel_clk_100hz =3D (unsigned int)(temp / 100);
> +				temp =3D clock_hz * dp_dto_ref_khz * 10;

[Severity: High]
Does this drop a required 64-bit cast, leading to a 32-bit multiplication
overflow?

Both clock_hz and dp_dto_ref_khz are 32-bit unsigned integers representing
frequencies. dp_dto_ref_khz is typically around 600,000 (600 MHz in kHz),
and clock_hz can also be extremely large. Their product easily exceeds the
32-bit maximum.

Without the (uint64_t) cast that was present in the original code, the
multiplication is performed entirely using 32-bit arithmetic. The result
overflows, wraps around, and is then implicitly cast to the 64-bit temp
variable, resulting in an incorrect numerator.

> +				ASSERT(temp <=3D INT_MAX * modulo_hz * 100);

[Severity: Medium]
Can this expression overflow 32-bit integer limits and break the assertion
logic?

The expression INT_MAX * modulo_hz * 100 is evaluated using 32-bit integer
arithmetic. Since INT_MAX is already nearly half of the maximum 32-bit
unsigned value, multiplying it by 100 and any typical modulo_hz frequency
will overflow 32-bit limits multiple times, producing an arbitrary wrapped
value.

The 64-bit temp is then compared against this 32-bit value.

> +				*pixel_clk_100hz =3D div_u64(temp, modulo_hz * 100);

[Severity: High]
Does modulo_hz * 100 overflow, resulting in an incorrect divisor or a
potential divide-by-zero?

modulo_hz is a 32-bit unsigned integer representing a clock frequency
(often around 600 MHz). Multiplying it by 100 evaluates as a 32-bit
operation, which exceeds UINT_MAX and wraps around.

The div_u64() function expects a u32 divisor, so it uses this truncated,
wrapped value instead of the intended divisor.

If modulo_hz happens to be exactly 1073741824 (about 1.07 GHz),
modulo_hz * 100 wraps to exactly 0, which would trigger a divide-by-zero
kernel panic in div_u64().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619082313.3583=
603-1-arnd@kernel.org?part=3D1
