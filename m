Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28245C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F8C310F0DC;
	Wed, 23 Sep 2026 14:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ahSVsNsK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C28810F0D6;
 Wed, 23 Sep 2026 14:27:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34EBF401D5;
 Wed, 23 Sep 2026 14:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56F11F00893;
 Wed, 23 Sep 2026 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790173642;
 bh=xo37cdmnh+svtcxNkd5zKazT/OKpa6V/sR3x6PQMQC8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ahSVsNsK0t4OhaxqU3UAxp4Kk63mjC304tOhgP+F9OjMH4UXQiHJYJYxB2XnKatbz
 O6UuIypRVixa2nF6IqMZlG/+Va+/zO24O5ZGr30O5N779SJe/MCpjaXx0mPRlpuYfr
 ijvCsTzVATTNR+BtDCQ/FuOUjm2o//9C9fGhc2q5qzOTQH2GNMkJsjk1BiNh81UPkq
 B+4YXKzc7ldvv5dpFYKwo59ntO37l9xKXOcSogBjix0lO9A0yDDkMh6QJEs3qq2KUM
 p/KAwPKcE4Q05wMmMnflaF4JPxvina+g0IaYkNXYJbrX8i6iRwfiKlp0NuxGu101zW
 Njl0rUeBR31OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/i915/dp: Only send AS SDP when VRR/CMRR is
 enabled or PR !async
To: "Xizhe Tang" <xizheTang2005@163.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260923195200.21362-1-xizheTang2005@163.com>
References: <20260923195200.21362-1-xizheTang2005@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 14:27:21 +0000
Message-Id: <20260923142721.D56F11F00893@smtp.kernel.org>
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
- [Low] drm/i915: build failure due to missing vrr qualifier for cmrr
--

commit 040a3a223ae954dab43478f6da5edfc88f5ff693
Author: Xizhe Tang <xizheTang2005@163.com>

drm/i915/dp: Only send AS SDP when VRR/CMRR is enabled or PR !async

This commit alters the condition for sending the Adaptive-Sync SDP by check=
ing
explicitly for VRR or CMRR enablement in the CRTC state. This prevents vert=
ical
streaking on eDP panels that advertise VRR but run at fixed refresh rates.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9252

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 0cd5e6b5034cf..612bc2846475b 100644
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
Does this cause a compilation error in intel_dp_needs_as_sdp()?=20

Looking at the definition of intel_crtc_state in
drivers/gpu/drm/i915/display/intel_display_types.h, cmrr is nested inside v=
rr:

    struct intel_crtc_state {
        ...
        struct {
            ...
            /* Content Match Refresh Rate state */
            struct {
                bool enable;
                u64 cmrr_n, cmrr_m;
            } cmrr;
        } vrr;
        ...
    };

Because cmrr is nested, accessing it directly via crtc_state->cmrr.enable w=
ill
fail to compile. Should this be accessed as crtc_state->vrr.cmrr.enable
instead, similar to how it is checked in intel_dp_compute_as_sdp() further
down in this same file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923195200.2136=
2-1-xizheTang2005@163.com?part=3D1
