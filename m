Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FE1C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9891B10F0F0;
	Tue, 15 Sep 2026 19:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TVhdWlgZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB4710F0DA;
 Tue, 15 Sep 2026 19:01:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 90BB960142;
 Tue, 15 Sep 2026 19:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579041F0089C;
 Tue, 15 Sep 2026 19:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789498863;
 bh=aAtHTiiwEGDc+I3dJKuf2MW6AH765zePtamAifVw7sM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TVhdWlgZY3z0gaEJujQOp+k4P1wkSbVHufjnlE0orSLovVIzkP7y7HB/XyYgYShuP
 PLapINhxiJMjIferD5SQJZ7yQVrl+70RGHC/ot3k5rqOQHtrhKTjFXm7hbtujMeRWU
 2iCF6haI1unABotnfNn6JUewkXnr5Nz/mmuGlgQtwZGLAHGfEOEb3MLrykmW4Mknx/
 uuqZ8fbxJ/cYz9JFoLWw0evw9p7pOBd3YDygNWul0AppO8Vctoc/yRCPXf+7URyllr
 sOe7+KjLp7WEgJ/YKjMACJWh3FcgWYyPmoaLNQ2QjVHGjJ4wD0xvgNTzNPf5sK+v7I
 +2EQwdbixk7cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/18] drm/i915/alpm: Disallow ALPM for UHBR link rate
To: "Animesh Manna" <animesh.manna@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260915180449.277933-19-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-19-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 19:01:00 +0000
Message-Id: <20260915190102.579041F0089C@smtp.kernel.org>
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
- [High] drm/i915: ALPM and Panel Replay stay enabled with zeroed params on=
 external DP UHBR
--

commit 735fad731be8c8f544adf68949ae9f43b62606f2
Author: Animesh Manna <animesh.manna@intel.com>

drm/i915/alpm: Disallow ALPM for UHBR link rate

This commit attempts to reject ALPM parameter computation for external DP
running at a UHBR rate on NVL platforms. eDP is explicitly excluded from th=
is
check to keep eDP ALPM working at all link rates.

> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index 84777c8d31bb4..51805a6bca867 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
> @@ -453,6 +453,12 @@ bool intel_alpm_compute_params(struct intel_dp *inte=
l_dp,
>  	int precharge =3D intel_dp_aux_fw_sync_len(intel_dp) - preamble;
>  	u8 max_wake_lines;
> =20
> +	/* DP2.1 ALPM is not supported on UHBR (128b/132b) link rates on NVL. */
> +	if (DISPLAY_VER(display) =3D=3D 35 &&
> +	    !intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP) &&
> +	    intel_dp_is_uhbr(crtc_state))
> +		return false;
> +

[Severity: High]
Does returning false here successfully prevent ALPM and Panel Replay from b=
eing
enabled on external DP?

Looking at _panel_replay_compute_config() in
drivers/gpu/drm/i915/display/intel_psr.c, there is an early return for non-=
eDP
displays:

    if (!intel_dp_is_edp(intel_dp))
        return true;

    /* Remaining checks are for eDP only */

    if (!crtc_state->has_alpm)
        return false;

Because of this early return, the failed ALPM parameter computation is bypa=
ssed
for external DP. Later in intel_sel_update_config_valid(), has_alpm is
unconditionally overwritten:

    crtc_state->has_alpm =3D intel_alpm_is_possible(intel_dp);
    return true;

Could this sequence leave ALPM and Panel Replay enabled with uninitialized
(zeroed) wake lines and times, potentially violating DP specifications and
preventing the external display from waking up correctly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915180449.2779=
33-1-animesh.manna@intel.com?part=3D18
