Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1E1C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA2CC10E560;
	Mon, 31 Aug 2026 09:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ACEtme1g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9233810E560
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:11:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5003443615;
 Mon, 31 Aug 2026 09:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116691F000E9;
 Mon, 31 Aug 2026 09:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788167483;
 bh=8eDY05PWqDBJon77E3UmaSdQHx8jyrE0JXH1Jz0mKdI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ACEtme1ggKU1nIgj8kDq9nBXUrjGon2xO7zqdVxWz9QyUzpfXIZaCWXrb7r0DTQRj
 AJkC7g7TRPGg/IKyOnCCmrsv8Shh5k+6SvuOxSxJNxs1zTGiHApFgdF2jYAerTUPWe
 MjMoa5tcGi6PJW03cuxe/rEXnf9o0UBYTg80W4a8C/OE2Svzd1xDG64UqYrVHYtgss
 HEFS7dFLAY63ZqWii8P9HAeCrEWrfCdvmODNRyYrlTObbpTcmp/oGA6n8hDCjvxdoC
 bMZdhF7FsXP6Uih2/l/EN/rbCdI7mfHwZNQY8e9i2slPmHZcUaPIa2Ay8niRhgUtx2
 rXqTEFHrcTKSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/29] drm/msm/dp: add support for MST channel slot
 allocation
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-13-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-13-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:11:22 +0000
Message-Id: <20260831091123.116691F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Calling a sleeping function (`msleep`) from an atomic commit callb=
ack violates DRM display guidelines.
- [Medium] Incorrect initialization of `ts_enum` causes an off-by-one error=
, artificially increasing the target symbol count when `raw_target_sc` is a=
n exact integer.
- [Medium] The fixed-point math intended to quantize `raw_target_sc` is a m=
athematical no-op, defeating its documented purpose.
- [Medium] Potential division by zero kernel panic if DP link parameters (`=
lanes` or `lclk`) are zero.
--

commit 104a5d3e2340f37c5f0003fb078fcd9efe33ba4d
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add support for MST channel slot allocation

DP MST streams share 64 MTP slots in a time-multiplexed manner. Add
support for calculating the rate governor, slot allocation, and slot
reservation in the DP controller.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 109a841675997..73aabd219125d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c

[ ... ]

> @@ -2675,6 +2715,117 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_=
ctrl_private *ctrl,
>  	msm_dp_write_stream_link(ctrl, panel->stream_id, REG_DP_SOFTWARE_NVID, =
nvid);
>  }
> =20
> +/*
> + * Calculate MST Rate Governor parameters x_int and y_frac_enum.
> + *
> + * The RG paces symbol delivery per MTP via: M =3D x_int + y_frac_enum/2=
56

[ ... ]

> +static void msm_dp_ctrl_mst_calculate_rg(struct msm_dp_ctrl_private *ctr=
l,
> +					 struct msm_dp_panel *panel,
> +					 u32 *p_x_int, u32 *p_y_frac_enum)
> +{
> +	u64 min_slot_cnt, max_slot_cnt;

[ ... ]

> +	lclk =3D ctrl->link->link_params.rate;
> +
> +	/* min_slot_cnt */
> +	numerator =3D pclk * bpp * 64 * 1000;
> +	denominator =3D lclk * lanes * 8 * 1000;
> +	min_slot_cnt =3D drm_fixp_from_fraction(numerator, denominator);

[Severity: Medium]
Is there a risk of a division by zero kernel panic here if the DP link
parameters fall back to zero?

In msm_dp_ctrl_mst_calculate_rg(), the denominator is computed directly
from lclk and lanes. If link training fails completely or a buggy DP sink
causes the driver to fall back to a state with zero lanes or zero link cloc=
k,
passing this zero denominator to drm_fixp_from_fraction() could trigger a
panic inside div64_u64_rem().

Should these link parameters be validated before attempting this division?

> +
> +	/* max_slot_cnt */
> +	numerator =3D pbn * 54 * 1000;
> +	denominator =3D lclk * lanes;
> +	max_slot_cnt =3D drm_fixp_from_fraction(numerator, denominator);
> +
> +	/* raw_target_sc */
> +	numerator =3D max_slot_cnt + min_slot_cnt;
> +	denominator =3D drm_fixp_from_fraction(2, 1);
> +	raw_target_sc =3D drm_fixp_div(numerator, denominator);
> +
> +	/* target_sc */
> +	temp =3D drm_fixp_from_fraction(256 * lanes, 1);
> +	numerator =3D drm_fixp_mul(raw_target_sc, temp);
> +	denominator =3D drm_fixp_from_fraction(256 * lanes, 1);
> +	target_sc_fixp =3D drm_fixp_div(numerator, denominator);

[Severity: Medium]
Does this fixed-point math actually quantize the target symbol count as
intended?

The code computes target_sc_fixp by multiplying raw_target_sc by
(256 * lanes) and then dividing it by the exact same fixed-point constant.
Because drm_fixp operations preserve the fixed-point fractional precision a=
nd
do not implicitly coerce to integers, this division restores the unquantized
raw value, acting as a mathematical no-op.

To correctly quantize raw_target_sc into 1/(256*lanes) steps, does the
numerator need to be converted to an integer before the division?

> +
> +	ts_enum =3D 256 * lanes;
> +	ts_denom =3D drm_fixp_from_fraction(256 * lanes, 1);
> +	ts_int =3D drm_fixp2int(target_sc_fixp);
> +
> +	temp =3D drm_fixp2int_ceil(raw_target_sc);
> +	if (temp !=3D ts_int) {

[Severity: Medium]
Will this initialization of ts_enum cause an off-by-one error when
raw_target_sc evaluates to an exact integer?

If raw_target_sc is an exact integer, temp !=3D ts_int evaluates to false,
skipping the recalculation block. Because ts_enum was initially set to
256 * lanes instead of 0, ts_frac_fixp subsequently evaluates to exactly 1.0
in fixed-point space.

This extraneous 1.0 adds an extra target slot, which when multiplied by lan=
es,
artificially increases the final target_strm_sym count and causes the rate
governor to pace symbols faster than mathematically intended.

> +		temp =3D drm_fixp_from_fraction(ts_int, 1);
> +		temp1 =3D raw_target_sc - temp;
> +		temp2 =3D drm_fixp_mul(temp1, ts_denom);
> +		ts_enum =3D drm_fixp2int(temp2);
> +	}

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 00c9b55925f93..6f79328c8b790 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -1497,6 +1509,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *d=
p)
>  	msm_dp_display =3D container_of(dp, struct msm_dp_display_private, msm_=
dp_display);
> =20
>  	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
> +	msm_dp_ctrl_mst_timeslot_setup(msm_dp_display->ctrl);
>  	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
>  }

[Severity: High]
Can this call chain lead to sleeping in an atomic context?

The atomic modesetting core calls the atomic disable hooks which leads to
msm_dp_display_atomic_disable(). This function unconditionally calls
msm_dp_ctrl_mst_send_act().

Looking at msm_dp_ctrl_mst_send_act() in dp_ctrl.c:

int msm_dp_ctrl_mst_send_act(...) {
    ...
    msm_dp_write_link(ctrl, REG_DP_MST_ACT, 0x1);
    wmb();
    msleep(frame_time_ms);
    ...
}

Since DRM encoder and bridge atomic callbacks run in atomic context during
non-blocking commits, sleeping here with msleep() violates the atomic
context contract and could lead to system instability, deadlocks, and
kernel warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D13
