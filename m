Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A647C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 04:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 991E710E211;
	Tue,  7 Jul 2026 04:17:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VtW3Xkr+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E02DC10E211
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 04:17:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A55DC409DC;
 Tue,  7 Jul 2026 04:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7351F000E9;
 Tue,  7 Jul 2026 04:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783397831;
 bh=YlIOHWQGj8LSp98kq9vPuvVRJp2E5/gRNz6i0vWYCEs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VtW3Xkr+xcY+ZPMw9h2xmMMDaJVkmJDIkvJfgvMzfpK5VEXbu+Dl7aUvq3f+h36La
 1A38E+MwGsBUPagV4F/dOJ7TrS47A5dOvKOAXLMKxSJS5mb5nppnAoliSqN/TWJVgU
 og4L1eEW6MtFleVUMhUGIXSq1+lfOw32YmtKp1PYaxV0fQ7z4oNYz/HyPcFlGB5E77
 9vGrGJ6i8DMbssBMqE2eurk8+iWY+NvDE9ZMbjry8y3Hd1jaMVsvKmjQystMKBcqX5
 yH1NPn3fy4zQprUBKrrTimv9Nz4g21vkq1+po9BENa5hK7tnypFFthIMLITEk0NEE/
 yKJ23srUEk8Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore mandatory
 samsung DP DT properties
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260707040613.1992841-4-damon.ding@rock-chips.com>
References: <20260707040613.1992841-1-damon.ding@rock-chips.com>
 <20260707040613.1992841-4-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 04:17:10 +0000
Message-Id: <20260707041711.4F7351F000E9@smtp.kernel.org>
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
- [Critical] Failing probe when deprecated DT properties are missing breaks=
 DT ABI and prevents their deprecation.
--

--- Patch [3]: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore mandatory sa=
msung DP DT properties ---
commit b573dba50acc6087122ffa4a65680322f4d004f8
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties

This commit reverts a change that made the samsung,link-rate and
samsung,lane-count properties optional for Exynos DP. It adds error checking
to fail the probe early if these properties are missing, aiming to prevent
link training failures caused by zero values.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 8cf6b73bceac0..293d8adfe9856 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
[ ... ]
> @@ -1258,10 +1259,14 @@ static int analogix_dp_dt_parse_pdata(struct anal=
ogix_dp_device *dp)
>  		 * NOTE: those property parseing code is used for
>  		 * providing backward compatibility for samsung platform.
>  		 */
> -		of_property_read_u32(dp_node, "samsung,link-rate",
> -				     &video_info->max_link_rate);
> -		of_property_read_u32(dp_node, "samsung,lane-count",
> -				     &video_info->max_lane_count);
> +		if (of_property_read_u32(dp_node, "samsung,link-rate", &val))
> +			return dev_err_probe(dp->dev, -EINVAL,
> +					     "Failed to get samsung,link-rate\n");

[Severity: Critical]
Does failing the probe when this property is missing break the DT ABI?

Since samsung,link-rate is a deprecated property, a modern schema-compliant
Device Tree might intentionally omit it. If a system boots with such a DT,
this check will fail the probe with -EINVAL and disable the display.

Could the driver instead fall back to hardware maximums or sensible defaults
when the deprecated property is absent, rather than returning an error?

> +		video_info->max_link_rate =3D val;
> +		if (of_property_read_u32(dp_node, "samsung,lane-count", &val))
> +			return dev_err_probe(dp->dev, -EINVAL,
> +					     "Failed to get samsung,lane-count\n");

[Severity: Critical]
Does making samsung,lane-count mandatory similarly break backward compatibi=
lity
for valid Device Trees that have intentionally omitted this deprecated prop=
erty?

> +		video_info->max_lane_count =3D val;
>  		break;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707040613.1992=
841-1-damon.ding@rock-chips.com?part=3D3
