Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8F7C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024F010ECAB;
	Tue, 29 Sep 2026 04:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aD531Xx5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5145D10ECAB
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:42:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 601DE60210;
 Tue, 29 Sep 2026 04:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12C31F000FF;
 Tue, 29 Sep 2026 04:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790656924;
 bh=WbgP2LvsPbZ7nvEIGqLePx2id4NEpS9rUYqo8ILI29A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aD531Xx5wodV5XvHz7uDKDLKTJ1TjG9xwfZXtVeYAd17Gi8do3W2ZNh828fxMjeJA
 /MetGXCp+rm1EXmK43eXoZ0ZCJZqCLUwbOBSWKh3jAua4yun24mf1LDhhPWRDqwG+o
 p59WLvXaVOdtAoo50LNWiqB6ikO5r6/rtQHJPKQrgAHhQ//dRXtKOmFMSqNUcFxagi
 SsE55ypkeFdrN7BFgGtm0982cnHn0rF41OATEmhL+d88c5TSHqG2FVa9dleLGUjGXH
 V9EMYfOroM0SOWxdSJ/wwbE3xOnNILJXki9DgjzQjEEpFKZgjtDcQiztGKfileP2FO
 wnG3YtJ8bfLsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/35] drm/msm/dp: add support for MST channel slot
 allocation
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-13-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-13-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:42:03 +0000
Message-Id: <20260929044203.E12C31F000FF@smtp.kernel.org>
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
- [Medium] drm/msm/dp: ts_enum initialization inflates slot count for exact=
 integers
- [Medium] drm/msm/dp: y_frac_enum rounds up to 256 causing register trunca=
tion
--

commit 70d204acda89b0781eca4707fd51efbc7d294508
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add support for MST channel slot allocation
   =20
DP MST streams share 64 MTP slots in a time-multiplexed manner. Add
support for calculating the rate governor, slot allocation, and slot
reservation in the DP controller.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 929e0f94f8ddb..02732bd4efa1b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c

[ ... ]

> @@ -2701,6 +2741,117 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_=
ctrl_private *ctrl,

[ ... ]

> +	ts_enum =3D 256 * lanes;
> +	ts_denom =3D drm_fixp_from_fraction(256 * lanes, 1);
> +	ts_int =3D drm_fixp2int(target_sc_fixp);
> +
> +	temp =3D drm_fixp2int_ceil(raw_target_sc);
> +	if (temp !=3D ts_int) {
> +		temp =3D drm_fixp_from_fraction(ts_int, 1);
> +		temp1 =3D raw_target_sc - temp;
> +		temp2 =3D drm_fixp_mul(temp1, ts_denom);
> +		ts_enum =3D drm_fixp2int(temp2);
> +	}
> +
> +	/* target_strm_sym */
> +	ts_int_fixp =3D drm_fixp_from_fraction(ts_int, 1);
> +	ts_frac_fixp =3D drm_fixp_from_fraction(ts_enum, drm_fixp2int(ts_denom)=
);
> +	temp =3D ts_int_fixp + ts_frac_fixp;

[Severity: Medium]
Does this initialization inflate the target slot count when raw_target_sc
evaluates to an exact integer?

Since ts_enum is initialized to 256 * lanes, it means the default fraction
is 1.0. When raw_target_sc is an exact integer, the condition temp !=3D ts_=
int
evaluates to false, causing the recalculation of ts_enum to be skipped.

This leads to ts_frac_fixp incorrectly evaluating to 1.0 (instead of 0.0),
which mistakenly adds an extra symbol per MTP to target_strm_sym and
artificially inflates the required slot count.

> +	temp1 =3D drm_fixp_from_fraction(lanes, 1);
> +	target_strm_sym =3D drm_fixp_mul(temp, temp1);
> +
> +	/* x_int */
> +	x_int =3D drm_fixp2int(target_strm_sym);
> +
> +	/* y_enum_frac */
> +	temp =3D drm_fixp_from_fraction(x_int, 1);
> +	temp1 =3D target_strm_sym - temp;
> +	temp2 =3D drm_fixp_from_fraction(256, 1);
> +	y_frac_enum_fixp =3D drm_fixp_mul(temp1, temp2);
> +
> +	temp1 =3D drm_fixp2int(y_frac_enum_fixp);
> +	temp2 =3D drm_fixp2int_ceil(y_frac_enum_fixp);
> +
> +	y_frac_enum =3D (u32)((temp1 =3D=3D temp2) ? temp1 : temp1 + 1);

[Severity: Medium]
Can this rounding logic overflow the fraction register and truncate it?

If the fractional part of target_strm_sym is very close to 1.0=20
(e.g., 0.999), the ceiling calculation yields 256. When packed into=20
the hardware register via rg =3D y_frac_enum | (x_int << 16) in
msm_dp_ctrl_update_rg(), the value 256 is represented as 0x100.

If the DP controller's y_frac_enum field only accepts an 8-bit fraction,
writing 0x100 could overflow the field and truncate it to 0 without
carrying the increment over to x_int, resulting in a subtle bandwidth
deficit and potential display underflows.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D13
