Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FD2C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502A710E750;
	Mon, 24 Aug 2026 11:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AqgZGV4R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00BFD10E751
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:35:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C337941401;
 Mon, 24 Aug 2026 11:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3C21F000E9;
 Mon, 24 Aug 2026 11:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787571337;
 bh=vgj5r6GmLT8MjQbvl6fgLukUg+xKTjUDCD1xunx7hbE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AqgZGV4RFhxqKosX+puCoBka+Zh/xs5XO5XC5OrmUK72cYgXRPJhxGszTXgyCxGgP
 p0BFyzGfKDJgTl/S+4D81uK/+uAwhmm9M0Z83qaaGfQlR9TYAz3T6WRvZ5sBLNC6hn
 kxT5a/W9mtPbVzbo/fF3Tt9tji8uf3JJtbHxn0LBNS14S05jq6sYFAlhG0lWK6rb/z
 zqxLbkeHosLibZQw7u0uJRoSTY0RXC5y3ZiX3vKgzAQAlKRGpYfPIjN94BHolJG/6q
 4hXaVdzssJOMSSDERXfLymNnyZXei0rHZc5AWtqPnGGryH+Xa5AUVeca2Uy40f+E9V
 6/FJkP7NncZGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/msm/dp: skip LTTPR init when no LTTPRs are present
To: "Saurabh Anand" <saurabh.anand@oss.qualcomm.com>
Cc: olteanv@gmail.com, vkoul@kernel.org, linux-phy@lists.infradead.org,
 neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260824-qcom-dp-typec-reconnect-fixes-v1-3-2825e5bf8a96@oss.qualcomm.com>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
 <20260824-qcom-dp-typec-reconnect-fixes-v1-3-2825e5bf8a96@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:35:36 +0000
Message-Id: <20260824113537.4E3C21F000E9@smtp.kernel.org>
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
- [Medium] Skipping `drm_dp_lttpr_init()` for negative `lttpr_count` bypass=
es the required LTTPR transparent mode fallback and is based on a flawed pr=
emise.
--

--- Patch [3]: [PATCH 3/4] drm/msm/dp: skip LTTPR init when no LTTPRs are p=
resent ---
commit 586e314c50820df2341a91e8a30d3963d3346281
Author: Saurabh Anand <saurabh.anand@oss.qualcomm.com>

drm/msm/dp: skip LTTPR init when no LTTPRs are present

This patch adds an early return when drm_dp_lttpr_count() returns a zero or
negative value. The goal is to skip LTTPR initialization when no repeaters
are detected or an error occurs reading the count.

> drm_dp_lttpr_count() returns 0 when no LTTPRs are detected and a
> negative value on error. The previous code passed the result directly
> to drm_dp_lttpr_init() without checking, which would call into the
> LTTPR transparency-mode setup with a zero or negative repeater count.

Is this description of drm_dp_lttpr_init() accurate?

Looking at drm_dp_lttpr_init(), it safely returns 0 on its own if
lttpr_count is zero:

int drm_dp_lttpr_init(struct drm_dp_aux *aux, int lttpr_count)
{
	int ret;

	if (!lttpr_count)
		return 0;
	...
}

It appears it already avoids calling into the transparency-mode setup
when the count is zero.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -253,6 +253,10 @@ static int msm_dp_display_lttpr_init(struct msm_dp_d=
isplay_private *dp, u8 *dpcd
>  		return 0;
> =20
>  	lttpr_count =3D drm_dp_lttpr_count(dp->link->lttpr_common_caps);
> +
> +	if (lttpr_count <=3D 0)
> +		return 0;
> +

[Severity: Medium]
Does skipping drm_dp_lttpr_init() for negative counts bypass the required
transparent mode fallback for non-compliant repeaters?

Looking at drm_dp_lttpr_init() in drivers/gpu/drm/display/drm_dp_helper.c,
it relies on receiving negative counts to trigger its fallback logic:

int drm_dp_lttpr_init(struct drm_dp_aux *aux, int lttpr_count)
{
	...
	ret =3D drm_dp_lttpr_set_transparent_mode(aux, true);
	if (ret)
		return ret;

	if (lttpr_count < 0)
		return -ENODEV;
	...
}

When lttpr_count is negative (e.g., -ERANGE or -EINVAL), the early return in
msm_dp_display_lttpr_init() causes the fallback to force transparent mode to
be entirely skipped. Could this cause link training to fail on setups with
non-compliant LTTPRs where the repeater count is invalid?

>  	rc =3D drm_dp_lttpr_init(dp->aux, lttpr_count);
>  	if (rc) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-qcom-dp-ty=
pec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com?part=3D3
