Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADDEC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 515AC10EF57;
	Wed, 23 Sep 2026 08:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SWtYxIpL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D0410EF63;
 Wed, 23 Sep 2026 08:05:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BBDD9600AA;
 Wed, 23 Sep 2026 08:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C32F1F000FF;
 Wed, 23 Sep 2026 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790150739;
 bh=o0se6JQraOaAQ+aPLonTJHZ9bDgejyLLp6g5fqx16U4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SWtYxIpLm9JV1Mk9Y3tZIWC0SFF22edleZ7gWS+1W9EiFvM8rBbK3vC0sARx6nvfh
 joVANOXnqnsP+N+PIlHginvoY+IbLHS/mu4WICvKTnjXY6Qe6zykxCCXW6lUOTgQ3s
 QHFJpjdMmAtCbQn3nB5m3FPbVCbT1JlkjBYGZQ8yzBRCV6oduo6zlo7MxJi7qnpJ+i
 fj/3Dc3cuDr7Ngj668N6tuIhop6SvvS9bMlEyO0u61PdY/p5dugng5W+oIQeRK6gyi
 0g0uHGJT1D2OPl4+csA1c2ZWCj4kWampFT51VAaEq9Z62VcBhIS0ltHoYIXAHqbL+6
 rBpNlmA66Ga6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/dp: Only send AS SDP when VRR is enabled or PR
 !async
To: "Xizhe Tang" <xizheTang2005@163.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260923052937.22817-1-xizheTang2005@163.com>
References: <20260923052937.22817-1-xizheTang2005@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 08:05:38 +0000
Message-Id: <20260923080539.3C32F1F000FF@smtp.kernel.org>
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
- [High] drm/i915/dp: AS SDP transmission disabled for CMRR
--

commit ec709d876da894a1dbf999ecfaaa9f0515c311ce
Author: Xizhe Tang <xizheTang2005@163.com>

drm/i915/dp: Only send AS SDP when VRR is enabled or PR !async

This commit changes the terminal condition for transmitting the
Adaptive-Sync SDP on DP links from intel_vrr_possible() to
crtc_state->vrr.enable, avoiding sending the AS SDP to fixed-refresh
links that merely advertise VRR capability.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9252

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -3113,7 +3113,7 @@ static bool intel_dp_needs_as_sdp(struct intel_dp *=
intel_dp,
>  	    !intel_psr_pr_async_video_timing_supported(intel_dp))
>  		return true;
> =20
> -	return intel_vrr_possible(crtc_state);
> +	return crtc_state->vrr.enable;

[Severity: High]
Does this inadvertently disable AS SDP transmission when Continuous Mode
Refresh Rate (CMRR) is active?

When CMRR is configured on the fixed refresh rate path, it sets
crtc_state->vrr.cmrr.enable to true, but crtc_state->vrr.enable is left as
false. Returning crtc_state->vrr.enable here evaluates to false for CMRR,
causing intel_dp_needs_as_sdp() to skip AS SDP transmission and breaking
CMRR synchronization.

Consequently, in intel_dp_compute_as_sdp() this leads to unreachable code:

intel_dp_compute_as_sdp() {
    ...
    if (!intel_dp_needs_as_sdp(intel_dp, crtc_state))
        return;
    ...
    if (crtc_state->vrr.cmrr.enable) {
        as_sdp->mode =3D DP_AS_SDP_FAVT_TRR_REACHED;
        ...

The CMRR configuration block becomes dead code because the function
exits early when vrr.enable is false.

Should this condition also check for crtc_state->vrr.cmrr.enable to
ensure AS SDP is still transmitted for CMRR?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923052937.2281=
7-1-xizheTang2005@163.com?part=3D1
