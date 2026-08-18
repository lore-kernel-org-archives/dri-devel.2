Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E04FC5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C1F710E491;
	Tue, 18 Aug 2026 03:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CCzcf9Py";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 211A910E491
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:03:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4B7D40806;
 Tue, 18 Aug 2026 03:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD131F00A3A;
 Tue, 18 Aug 2026 03:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787022190;
 bh=qBz+3Y6QP3ulDBLXBd4Y6dqUwDPI351LcxAP41Hq/eg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CCzcf9Py2H52kqujS4Eunq6u/Vm1AAJ2cwi/LF7VAZ8d8u93qc/GXYbtP0Y97OK4C
 PwcV1txEG1qGRgwnFH4EPLlmx2T+zU4tnoPJPBLN1/Fey50atxxTvTYSzwIujOgV6j
 qrZGSIPcq0bKV4wF9QRh1TFxwPPEmZV5poYTyWlOksVY8W9O5FISIyB+cF4HHl7nXa
 7PJXigmmaNZxPw7pokQjt4sCvHXoeT+bgH3hQ7RcvqgnDZYJfeJ5WBijppDGO+l1zQ
 x2ESrkJsKLO6q4LLcr9TMZ/lDYcI2pXVik4PuEjXiP3fNVwxcTDo+ScSnfNgeBneXz
 I5gyS44mHxUGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu/dc: Avoid PSR AUX WARN on unhealthy eDP link
To: rh_king@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818024219.2921012-1-rh_king@163.com>
References: <20260817031640.2097973-1-rh_king@163.com>
 <20260818024219.2921012-1-rh_king@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 03:03:10 +0000
Message-Id: <20260818030310.7AD131F00A3A@smtp.kernel.org>
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
- [High] Callers of `dpcd_set_link_settings()` ignore its return value, tur=
ning the new early aborts into a logic flaw that causes link training to fa=
il or fall back to lower bandwidths on transient AUX errors.
--

--- Patch [1]: [PATCH v2] drm/amdgpu/dc: Avoid PSR AUX WARN on unhealthy eD=
P link ---
commit 3a9a75a9b46189406373e0f0c7bc3d7ed3668c23
Author: Kean Ren <rh_king@163.com>

drm/amdgpu/dc: Avoid PSR AUX WARN on unhealthy eDP link

This commit addresses a kernel warning caused by PSR AUX timeouts on an
unhealthy eDP link after resume. It adds early returns to
dpcd_set_link_settings() when DPCD writes fail, and adds a check for active
links in edp_setup_psr().

> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_traini=
ng.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
[ ... ]
> @@ -1117,15 +1117,25 @@ enum dc_status dpcd_set_link_settings(
>  				link->dpcd_caps.max_ln_count.bits.POST_LT_ADJ_REQ_SUPPORTED;
>  	}
> =20
> +	/* Bail out on the first DPCD write failure so callers can react and
> +	 * subsequent operations (e.g. PSR setup) do not keep poking an
> +	 * unhealthy AUX channel. Without this, a transient AUX/HPD glitch
> +	 * during resume leads to a cascade of DPCD errors and ultimately a
> +	 * WARN at dce_aux_transfer_raw() because AUX_SW_DONE never asserts.
> +	 */
>  	status =3D core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
> -		&downspread.raw, sizeof(downspread));
> -	if (status !=3D DC_OK)
> +				      &downspread.raw, sizeof(downspread));
> +	if (status !=3D DC_OK) {
>  		DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_DOWNSPREAD_CTRL) failed\=
n", __func__, __LINE__);
> +		return status;
> +	}

[Severity: High]
By returning early here, do we cause link training to permanently fall back
to lower bandwidths if a transient AUX error occurs?

It looks like the callers of dpcd_set_link_settings() do not check its
return value. For example, in dp_perform_8b_10b_link_training():

    else
        dpcd_set_link_settings(link, lt_settings);
   =20
    if (lt_settings->lttpr_mode =3D=3D LTTPR_MODE_NON_TRANSPARENT) {

And similarly in dp_perform_128b_132b_link_training():

    dpcd_set_link_settings(link, lt_settings);
   =20
    if (result =3D=3D LINK_TRAINING_SUCCESS) {
        result =3D dp_perform_128b_132b_channel_eq_done_sequence(...);

If a transient error occurs on the first DPCD write, dpcd_set_link_settings=
()
now bails out early and skips critical configurations like DP_LANE_COUNT_SET
and DP_LINK_BW_SET.=20

Because the callers ignore the return value, they will blindly proceed with
clock recovery on a sink that was not fully configured. Does this guarantee
a CR lock failure, which triggers the driver's fallback logic to permanently
downgrade the link bandwidth?

Should the callers be updated to handle the error return from
dpcd_set_link_settings() so they can abort or retry properly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818024219.2921=
012-1-rh_king@163.com?part=3D1
