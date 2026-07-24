Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D4EC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77ED710E07E;
	Fri, 24 Jul 2026 16:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D0MIRs0d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EEC10E07E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 16:26:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 714C94024F;
 Fri, 24 Jul 2026 16:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C831F000E9;
 Fri, 24 Jul 2026 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784910388;
 bh=SgC4B4IHvJAn51XgkvvycSfqqmZYAMBdrgymCgMkun4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D0MIRs0d+o29Ay8oTas62EmeMzIlo/6Pm4srQELkmSV2o7P0Mel+yZTcG/pjM1usa
 jydrCR6TWMDGw5Nlkvqrp+wgvjqCEbXG+p/qbCJiV8xTuXs1i4LSWtV+1l6pizor+0
 07v3DSIKro2m/N5nP9kI0EiN3uOYrX9OSg000lqMdEOQZFnHXkKrYy9qlDbISab7q0
 TC0RPt2vYXBUn52X3Y6MnweFw1YoeWUVq3JhdmXdTwiTXnJwoLuBj/+3633QOlMkH7
 BV8D0h24qMGTMD6Lk+4HWcrbkoBuWllrL6Xg91t+mIk4ee4CWiPf7aS45tyqqM+rfD
 2dHw1MC2k+1EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/amd/display: Clean up FreeSync capability
 detection
To: "Alex Huang" <Alex.Huang2@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724161713.119382-4-Alex.Huang2@amd.com>
References: <20260724161713.119382-1-Alex.Huang2@amd.com>
 <20260724161713.119382-4-Alex.Huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 16:26:27 +0000
Message-Id: <20260724162628.29C831F000E9@smtp.kernel.org>
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
- [High] Missing fallback to the standard EDID/DisplayID monitor range when=
 an AMD VSDB is present but does not advertise FreeSync support, breaking D=
isplayPort/eDP Adaptive-Sync.
--

--- Patch [3]: [PATCH v2 3/4] drm/amd/display: Clean up FreeSync capability=
 detection ---
commit 1df3d41bf0a00d7e8fa9373df7587957270091d3
Author: Alex Huang <Alex.Huang2@amd.com>

drm/amd/display: Clean up FreeSync capability detection

This commit refactors FreeSync capability detection by extracting common
code and fetching VSDB data early. It relies on the AMD VSDB refresh rates
if FreeSync is advertised, otherwise falling back to the monitor range.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -13751,63 +13751,57 @@ void amdgpu_dm_update_freesync_caps(struct drm_=
connector *connector,
[ ... ]
> +	has_vsdb =3D get_amd_vsdb(amdgpu_dm_connector, &vsdb_info) !=3D 0;
> +
> +	if (has_vsdb) {
> +		amdgpu_dm_connector->vsdb_info =3D vsdb_info;
> +
> +		/* copy refresh rate info as long as VSDB advertises FreeSync */
> +		if (vsdb_info.freesync_supported) {
> +			amdgpu_dm_connector->min_vfreq =3D vsdb_info.min_refresh_rate_hz;
> +			amdgpu_dm_connector->max_vfreq =3D vsdb_info.max_refresh_rate_hz;
> +
> +			connector->display_info.monitor_range.min_vfreq =3D
> +				vsdb_info.min_refresh_rate_hz;
> +			connector->display_info.monitor_range.max_vfreq =3D
> +				vsdb_info.max_refresh_rate_hz;
>  		}
> +	} else {
> +		/* fall back to the base EDID range when there is no VSDB */
> +		amdgpu_dm_connector->min_vfreq =3D connector->display_info.monitor_ran=
ge.min_vfreq;
> +		amdgpu_dm_connector->max_vfreq =3D connector->display_info.monitor_ran=
ge.max_vfreq;
> +	}

[Severity: High]
If a monitor has an AMD VSDB (for example, to advertise Panel Replay Mode)
but does not set the freesync_supported bit, does this unintentionally
bypass the fallback to the standard EDID or DisplayID monitor range?

If has_vsdb is true but vsdb_info.freesync_supported is false, the refresh
rates are not set in the if block. Because the fallback logic is isolated in
the else block, it is completely skipped.

This leaves min_vfreq and max_vfreq at 0 for such displays, which causes
Variable Refresh Rate (FreeSync/Adaptive-Sync) to silently fail during
the subsequent DisplayPort and eDP capability checks:

> +	if (sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT ||
> +	    sink->sink_signal =3D=3D SIGNAL_TYPE_EDP) {
> +		if (amdgpu_dm_connector->dc_link &&
> +		    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_p=
aram &&
> +		    amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > =
10)
> +			freesync_capable =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161713.1193=
82-1-Alex.Huang2@amd.com?part=3D3
