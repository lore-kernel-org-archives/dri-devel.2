Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46FCCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E209010E440;
	Thu,  4 Jun 2026 09:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SUcrUcIE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187ED10E440
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 09:09:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E2507434A9;
 Thu,  4 Jun 2026 09:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC051F00898;
 Thu,  4 Jun 2026 09:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780564175;
 bh=3q579KPuijB082EPKTTXXCUaljELE9Y08YI1IIAXBtI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SUcrUcIESqoXk75PIHzUgNFz+LZthwlmpYIaGWcTgmmbuqdCXZ9GnN0HxNVHwKRXV
 f+1zevLQMM8dIiSrUx9xAtvCpA67nT/GnhrCYFQ55USxlvkgZJE2fNseKtwfqAO8eB
 KNHYErba5Mbq0C3alpl9BvZWdUFCWd8PtWvbq94F3JWL5ZcJzNQReVXGQUsqIES+ES
 CCeo754lej5T0WjuKuaQNferkHEyvCsh/V1dv/OfgCWmtjoK16iQx8JuEL1ix7VbAz
 RQnbf5GMvrWa23DmDVahIGZQLsi4UXdEKyitC0cbMDtlnViUWWagd2KZLrYQVYlthl
 wPE7YZCti/2lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] drm/bridge: analogix_dp: Add validation for
 samsung,lane-count property
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260604085220.2862986-4-damon.ding@rock-chips.com>
References: <20260604085220.2862986-4-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 09:09:35 +0000
Message-Id: <20260604090935.7FC051F00898@smtp.kernel.org>
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

New issues:
- [High] The patch makes the deprecated and optional `samsung,lane-count` p=
roperty a strict requirement, causing an unconditional probe failure if it =
is omitted.

Pre-existing issues:
- [High] Missing handling for absent DT properties causes lane count and li=
nk rate to be incorrectly clamped to 0, breaking link training.
--

commit 65a66d32582ccfce55e0e84f53bc63077d25103c
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Add validation for samsung,lane-count property

Add validity check for samsung,lane-count to ensure DT-provided
lane count values are specification-compliant.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 8cf6b73bceac0..f23c2ae6e10d0 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
[ ... ]
> @@ -1260,8 +1261,11 @@ static int analogix_dp_dt_parse_pdata(struct analo=
gix_dp_device *dp)
>  		 */
>  		of_property_read_u32(dp_node, "samsung,link-rate",
>  				     &video_info->max_link_rate);
> -		of_property_read_u32(dp_node, "samsung,lane-count",
> -				     &video_info->max_lane_count);
> +		ret =3D of_property_read_u32(dp_node, "samsung,lane-count",
> +					   &video_info->max_lane_count);
> +		if (ret || !drm_dp_lane_count_is_valid(video_info->max_lane_count))
> +			return dev_err_probe(dp->dev, ret ? ret : -EINVAL,
> +					     "failed to parse samsung,lane-count\n");

[Severity: High]
Does this make the optional and deprecated samsung,lane-count property a
strict requirement?

If samsung,lane-count is absent from the device tree, of_property_read_u32()
returns -EINVAL. This causes the condition to evaluate to true, aborting the
probe with an error.

According to the device tree bindings
(Documentation/devicetree/bindings/display/samsung/samsung,exynos5-dp.yaml),
this property is marked as deprecated and explicitly optional because the
lane count can be read from the monitor. Does this patch break compatibility
with device trees that rightfully omit this deprecated property?

[Severity: High]
This is a pre-existing issue, but there is an underlying problem in
analogix_dp_full_link_train() when these optional properties are omitted:

analogix_dp_full_link_train() {
    ...
	/* Setup TX lane count & rate */
	if (dp->link_train.lane_count > max_lanes)
		dp->link_train.lane_count =3D max_lanes;
	if (dp->link_train.link_rate > max_rate)
		dp->link_train.link_rate =3D max_rate;
    ...
}

If the deprecated samsung,lane-count or samsung,link-rate properties are
rightfully omitted from the device tree, their corresponding limits remain =
0.

The driver then executes the above clamp logic, which incorrectly clamps the
valid DPCD values to 0. This completely breaks DP link training and results
in a non-functional display.

Should the driver ignore the limits if they are 0 (e.g., checking if
max_lanes is non-zero before clamping), allowing it to correctly fall back
to the monitor's DPCD capabilities? Fixing the probe failure above will
just expose this runtime breakage.

>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604085220.2862=
986-1-damon.ding@rock-chips.com?part=3D3
