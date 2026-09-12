Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43BCC79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2CD810E47C;
	Sat, 12 Sep 2026 08:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RcGmhrdP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9573B10E47C
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:51:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A92C60209;
 Sat, 12 Sep 2026 08:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422BD1F000FF;
 Sat, 12 Sep 2026 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789203085;
 bh=ODPsh160UbnsA7ODNyf6Eev5Vn1YdxIcSEej72cJkY4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RcGmhrdPI3C6ZmL6piwomcCndbq8svweriHDqQZRfY448RRI/ImQHaROTSYY0S5WJ
 XZAqqflX4TfTZOaOoProyFoY7n9yXP00sPEst06PHIgVAjNRsoi+TwIQn/kZ7uvyvf
 /zEgHWiZbrIWvi5+THYeJnkvnnGDirZzWOkrBQEoS5u8eSL2UWHYoR1OxO2Yea9aAH
 61YrE7ubE+2Ck140HixmkDryXz1srTgg7bRDtO3bqsols3EQoZt1qyxLcxhR06C/sj
 yUlsuDHhwlntHT+pykfeC5CocjMcbxHSN9plfPRzp2jykkiEKy5o3vOIPok2iyi1o5
 uIe1ZNYO77oow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 17/20] thermal: qcom: tsens: Add support for MSM8952
 tsens
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, mfd@lists.linux.dev,
 lee@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-17-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-17-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:51:24 +0000
Message-Id: <20260912085125.422BD1F000FF@smtp.kernel.org>
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
- [High] Heap Out-Of-Bounds Write in `init_8952` when device tree overrides=
 `#qcom,sensors`.
- [High] Use-After-Free via Section Mismatch: `init_8952` is annotated with=
 `__init`, but can be called after boot memory is freed.
- [Medium] Potential thermal calibration inaccuracy by replacing SoC-specif=
ic logic with hardcoded generics.
--

commit 7ec3bedeaa96c98b6f844188546432e42095ad77
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

thermal: qcom: tsens: Add support for MSM8952 tsens
   =20
Add MSM8952 support for tsens.
   =20
Downstream does a lot of advanced things with calculations.
But seems like using tsens-v1 directly works too.

Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621

> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens=
-v1.c
> index faa5d00788ca6..f4201748ea297 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -145,6 +145,37 @@ static const struct reg_field tsens_v1_regfields[MAX=
_REGFIELDS] =3D {
>  	[TRDY] =3D REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
> =20
> +static int __init init_8952(struct tsens_priv *priv)

[Severity: High]
Since the tsens driver probe can be deferred due to nvmem calibration data
dependencies, or the device could be manually unbound and rebound via sysfs,
could this __init annotation cause a use-after-free?

The ops_8952 struct stores the pointer to this function in .rodata. If the
function is freed after boot memory is reclaimed, calling priv->ops->init()
during a deferred probe will jump to a freed address.

[Severity: Medium]
The commit message notes that downstream does advanced calculations, but th=
is
implementation replaces them with static generic offsets. Could this lead to
thermal calibration inaccuracies?

If these static offsets do not accurately reflect the physical thermal
curves of all MSM8952 chips, could the kernel read skewed temperatures
and fail to act on thermal events?

> +{
> +	for (int i =3D 0; i < priv->num_sensors; ++i)
> +		priv->sensor[i].slope =3D 3200;
> +
> +	priv->sensor[0].p1_calib_offset =3D 2;
> +	priv->sensor[0].p2_calib_offset =3D -1;

[ ... ]

> +	priv->sensor[9].p1_calib_offset =3D 0;
> +	priv->sensor[9].p2_calib_offset =3D 0;
> +	priv->sensor[10].p1_calib_offset =3D -3;
> +	priv->sensor[10].p2_calib_offset =3D -2;

[Severity: High]
Could this result in a heap out-of-bounds write?

In tsens_probe(), num_sensors defaults to 11 but can be overridden by the
"#qcom,sensors" device tree property. The priv->sensor array is then
dynamically allocated based on this count using struct_size().

If a device tree specifies a num_sensors value less than 11, these hardcoded
unconditional assignments will write beyond the bounds of the allocated heap
array.

> +
> +	return init_common(priv);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D17
