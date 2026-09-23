Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9CAC98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ADA810F0AC;
	Wed, 23 Sep 2026 14:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LyOW4owm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98C810F0AC;
 Wed, 23 Sep 2026 14:26:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A070143BB2;
 Wed, 23 Sep 2026 14:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD7D1F00893;
 Wed, 23 Sep 2026 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790173605;
 bh=/p92UirDNwuGH3pxSCvY41H6rcurb37wBzBH+BeVeYQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LyOW4owm9HKdQOnBhncWaq0yvUhega3Jl+XlulssENmFTc0HR4ibM+5YRjtz+G5Xi
 MhDZbFQcj+aarAZU/JribYvEneVEWjVBtBjkac8NlsWfGJ5DsvZ8VNkJ70VZ8wCm1m
 BznY9+ZaYwXX7A5tBGDC2ipQ6R5bhk22eP1sZWmJuHAVj9Zf/D4tbmQeSDPqeKeZKv
 w/4E3f1xbLuAdxtki1O3Ut8zoX35B7Iivqil1pQkKUwoE742YK0gfwKcDX/PbRc74g
 OHO9MpKn2AYTDEY9uVjduhLsYrfxJIviZETqMqgSbMTHO8IddfeOPlRdYEXvFU5unQ
 AmC3S0gW4ktpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/i915/dp: Only send AS SDP when VRR/CMRR is
 enabled or PR !async
To: "Xizhe Tang" <xizheTang2005@163.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260923195149.21329-1-xizheTang2005@163.com>
References: <20260923195149.21329-1-xizheTang2005@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 14:26:44 +0000
Message-Id: <20260923142645.4DD7D1F00893@smtp.kernel.org>
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
- [Low] drm/i915: missing vrr prefix for cmrr access in intel_dp_needs_as_s=
dp()
--

commit d1eecbeb3255f083df2a9a20caa676b6bc9c6e5e
Author: Xizhe Tang <xizheTang2005@163.com>

drm/i915/dp: Only send AS SDP when VRR/CMRR is enabled or PR !async

This commit modifies the Adaptive-Sync SDP terminal condition to gate on VRR
or CMRR enablement. This change resolves vertically streaked visuals during
the first modeset at boot on fixed refresh rate eDP panels.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9252

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -3111,7 +3111,8 @@ static bool intel_dp_needs_as_sdp(struct intel_dp *=
intel_dp,
>  	    !intel_psr_pr_async_video_timing_supported(intel_dp))
>  		return true;
> =20
> -	return intel_vrr_possible(crtc_state);
> +	return crtc_state->vrr.enable ||
> +	       crtc_state->cmrr.enable;

[Severity: Low]
Will this cause a build failure when compiling intel_dp.c?

Looking at the intel_crtc_state structure in intel_dp_needs_as_sdp(), cmrr =
is
nested inside the vrr substructure, not directly under crtc_state.

Should this be accessed as crtc_state->vrr.cmrr.enable instead, similar to
how it is safely accessed slightly later in intel_dp_compute_as_sdp()?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923195149.2132=
9-1-xizheTang2005@163.com?part=3D1
