Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82629CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE96910F39F;
	Wed, 30 Sep 2026 13:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RQiQA7nE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA24D10F39F
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:04:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2B774013B;
 Wed, 30 Sep 2026 13:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1A81F00898;
 Wed, 30 Sep 2026 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790773482;
 bh=AQvh+O0NvybWlpdm77ulkfTvPy5MbCUMv7l3nTfxobg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RQiQA7nE0kAhwvSzRuMuffeYwv3jeivm+Qz+Y/VcIQWSjvbNuuGYxfcCA/0CHTSQU
 wb0FbM8Cxbwns5MM7ndWshIF5tS9+VZRZCAYnCdg6yIHwAIADY43Arpb9A3mPM/xeJ
 cUp5BxFWuNsfztKERp6ZIIHcEI8eIjcjcpkIlKvXMR6Mi0XEO0LcZyXFCemTBgJpmm
 LQIZwsLDJhStvN4zAaM0UEjkHi/BrOOaLVMUxUFD0iiVoaGnYtrS9qZklNJeId+YJg
 P7D/EevTrl402N9JwIlF3N2j4mhuHP6IOxRZ0RnmRyq7/6CYb1JbWUUeMiijK2JsV2
 3v9BX8C30tGZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] drm/msm/dp: Add static HDR metadata support for
 DP and eDP
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930-msm-dp-hdr10-v1-13-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-13-dbbf8b2b42bc@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:04:41 +0000
Message-Id: <20260930130442.5C1A81F00898@smtp.kernel.org>
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
- [High] drm/msm/dp: late HDR capability check in atomic_enable violates at=
omic contract
--

commit dd06afce910f68ea34833e6875a317b2680f0949
Author: Xilin Wu <sophon@radxa.com>

drm/msm/dp: Add static HDR metadata support for DP and eDP

This commit adds static HDR metadata processing for DP and eDP displays.
It introduces Generic2 packet formatting, revalidates sink capabilities,
and forces a modeset on metadata changes.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -708,7 +718,7 @@ int msm_dp_display_atomic_check(struct msm_dp *msm_dp=
_display,
>  	const struct drm_display_info *info =3D &conn_state->connector->display=
_info;
>  	struct msm_dp_display_private *dp;
>  	unsigned int clock =3D mode->clock;
> -	int bpp;
> +	int bpp, ret;
> =20
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
> @@ -717,17 +727,25 @@ int msm_dp_display_atomic_check(struct msm_dp *msm_=
dp_display,
> =20
>  	guard(mutex)(&dp->plugged_lock);
> =20
> +	ret =3D msm_dp_utils_pack_hdr_sdp(conn_state, &state->hdr_sdp);
> +	if (ret)
> +		return ret;
> +
> +	state->hdr_enabled =3D !!conn_state->hdr_output_metadata;

[Severity: High]
Should the hardware capability validation for HDR be moved here?

This is the correct function where the DP controller's hw_revision and all
static sink HDR capability checks must be performed. Validating here ensures
that userspace receives an error prior to the commit, rather than failing
late during the enable phase.

[ ... ]
> @@ -760,6 +778,18 @@ static int msm_dp_display_prepare_link(struct msm_dp=
_display_private *dp)
> =20
>  	dp->stream_pm_active =3D true;
> =20
> +	if (dp->panel->hdr_enabled) {
> +		const struct drm_display_info *info =3D &msm_dp_display->connector->di=
splay_info;
> +		const struct hdr_static_metadata *hdr =3D &info->hdr_sink_metadata.hdm=
i_type1;
> +		u8 eotf =3D dp->panel->hdr_sdp.db[2];
> +
> +		if (dp->panel->hw_revision < DP_HW_VERSION_1_0 ||
> +		    !(hdr->metadata_type & BIT(HDMI_STATIC_METADATA_TYPE1)) ||
> +		    !(hdr->eotf & BIT(eotf)) ||
> +		    (eotf !=3D HDMI_EOTF_TRADITIONAL_GAMMA_SDR && info->bpc < 10))
> +			return -EINVAL;
> +	}
> +

[Severity: High]
Does this late hardware capability validation violate the atomic contract?

Returning an error during the atomic_enable phase (from=20
msm_dp_display_prepare_link) causes a silent modesetting failure where the=
=20
hardware state diverges from the software state, leading to a wedged displa=
y=20
pipeline and DRM core warnings.

If a local user with DRM master privileges submits an atomic commit with HD=
R=20
metadata on a DP controller with an older hw_revision, the commit passes=20
validation but fails here. The atomic modesetting contract requires all suc=
h=20
configuration constraints to be rejected during msm_dp_display_atomic_check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-msm-dp-hdr=
10-v1-0-dbbf8b2b42bc@radxa.com?part=3D13
