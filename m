Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8F1C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F8310E3BA;
	Wed, 16 Sep 2026 14:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BN6xSyFJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B415610E3BA
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:34:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6705C403EB;
 Wed, 16 Sep 2026 14:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CD01F000FF;
 Wed, 16 Sep 2026 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789569247;
 bh=gBgrbzGZO3GjqAPvcZd2tB3tJg0JiTVzzKrGcEJopi8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BN6xSyFJ9C15PkW4Fa44dWUM7zplE0SOd2ihKgRtOyiycEVdmmMYc7IYWmdtaPVcU
 Q2uPcwcyBkQAW/sbNYvoCh0jkb0Bz3KEyPp9wvjmIK6rbqTqG/rolYcyGk9vP3Yh6F
 Q2X0Ov9GjFExT7a6XG60GcCG4SCKPgC8BcQpJASjQ2tZEGIr86+ITlIQVOvJcxfDiv
 Mq8cGYAqXUlm7vR/4xjnwRLeAibKZHZsU+HFs0D43gm+gbvdc3fKPqVl0F5IkAOZVE
 KIgw7aOeY07a+4MsLsCzgiz+ROU4d+Kkl/x8kqboCdMEh52x9GhXUImNAl6psp33zE
 6Z9AM/NNXPsIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/19] thermal: qcom: tsens: Add support for MSM8952
 tsens
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, lee@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, mfd@lists.linux.dev,
 conor+dt@kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-16-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-16-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:34:06 +0000
Message-Id: <20260916143406.C2CD01F000FF@smtp.kernel.org>
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
- [High] thermal: qcom: OOB write in init_8952() via under-sized #qcom,sens=
ors DT property
--

commit 6a35eb56487d35e206bcac22420641583d749610
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>
One line subject: thermal: qcom: tsens: Add support for MSM8952 tsens

This commit adds tsens support for MSM8952, introducing initialization
and calibration offsets.

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
> +{
> +	for (int i =3D 0; i < priv->num_sensors; ++i)
> +		priv->sensor[i].slope =3D 3200;
> +
> +	priv->sensor[0].p1_calib_offset =3D 2;
> +	priv->sensor[0].p2_calib_offset =3D -1;
> +	priv->sensor[1].p1_calib_offset =3D -4;

[Severity: High]
In tsens_probe(), priv->sensor is dynamically allocated based on num_sensor=
s,
which can be overridden by the #qcom,sensors device tree property:

	priv =3D devm_kzalloc(dev,
			     struct_size(priv, sensor, num_sensors),
			     GFP_KERNEL);

If the device tree property limits num_sensors to a smaller value (for
example, 2), would these hardcoded assignments overwrite memory beyond the
allocated array bounds?

[ ... ]

> +	priv->sensor[10].p1_calib_offset =3D -3;
> +	priv->sensor[10].p2_calib_offset =3D -2;
> +
> +	return init_common(priv);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D16
