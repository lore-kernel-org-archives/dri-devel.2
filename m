Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F0EC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4753B10E40E;
	Mon, 21 Sep 2026 18:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g9l4aCVe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E24010E40E
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:30:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BEA3E4025E;
 Mon, 21 Sep 2026 18:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170471F000FF;
 Mon, 21 Sep 2026 18:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790015452;
 bh=68CLDjYIP6lmfl6NPmKCNglItNv8hvpwIrOxM6A+RA8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g9l4aCVeKCeG9Efb8LLAXRgeWw+YgBfHmONYpwlEmQBmWWLI0ssCNqRWhsLBNbPkH
 G9HDYwuBJJiOfCCQ+16pSupehcXAEw0oc5JA6e4cK5v//zlwT1qyfBLFcdEpUg+2PJ
 TXS1MHK6r6C09meYS157EZZ0OKHw/l0woNpI9ve0U4arD09S7BGBAbbtWSvHU15Di0
 C+vg/YWqy0RZl1rnlfOmR1rGse6GkHQ0u8UPF1YFNvGpTXDD2uh/ZOrnkpprzRhRgf
 y7HVibMPDO8Xf70M19+AIqrU/eFJZM9WnPhjIyVO/KOT9nLlqkA7pkLc5fDO84RPio
 8StDcuSDlcL2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/19] thermal: qcom: tsens: Add support for MSM8952
 tsens
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, lee@kernel.org,
 robh@kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-16-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-16-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:30:51 +0000
Message-Id: <20260921183052.170471F000FF@smtp.kernel.org>
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
- [High] thermal: tsens: Use-after-free in tsens_probe() via __init section=
 mismatch
- [High] thermal: tsens: Heap buffer overflow in init_8952() via DT override
--

commit 5408ae137c176a5df112132baa926440df23a1b3
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

thermal: qcom: tsens: Add support for MSM8952 tsens

This commit adds TSENS thermal sensor support for the Qualcomm MSM8952
platform. It introduces calibration data for 11 sensors and wires up the
associated platform data structure.

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
Does marking this function as __init risk a use-after-free if the device is
probed late?

If tsens_probe() runs after the initial kernel boot sequence, for instance =
due
to a standard -EPROBE_DEFER or a manual sysfs bind, the .init.text section
containing this function will have already been freed. Since this function =
is
assigned to ops_8952.init and invoked dynamically by tsens_probe(), executi=
ng
it after boot would jump into freed memory:

drivers/thermal/qcom/tsens.c:tsens_probe() {
    ...
    if (priv->ops->init) {
        ret =3D priv->ops->init(priv);
    ...
}

> +{
> +	for (int i =3D 0; i < priv->num_sensors; ++i)
> +		priv->sensor[i].slope =3D 3200;
> +
> +	priv->sensor[0].p1_calib_offset =3D 2;
> +	priv->sensor[0].p2_calib_offset =3D -1;

[Severity: High]
Could these unconditional writes overflow the priv->sensor flexible array?

In tsens_probe(), the array size is dynamically allocated based on the
"#qcom,sensors" device tree property:

drivers/thermal/qcom/tsens.c:tsens_probe() {
    ...
    of_property_read_u32(np, "#qcom,sensors", &num_sensors);
    ...
    priv =3D devm_kzalloc(dev,
                 struct_size(priv, sensor, num_sensors),
                 GFP_KERNEL);
    ...
}

If a malformed or custom device tree overrides this property to a value less
than 11, the array will be allocated with fewer elements. However, this code
unconditionally writes to hardcoded indices up to priv->sensor[10], which
could cause a heap buffer overflow.

> +	priv->sensor[1].p1_calib_offset =3D -4;
> +	priv->sensor[1].p2_calib_offset =3D -4;
[ ... ]
> +	priv->sensor[10].p1_calib_offset =3D -3;
> +	priv->sensor[10].p2_calib_offset =3D -2;
> +
> +	return init_common(priv);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D16
