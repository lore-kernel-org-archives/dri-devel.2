Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52780C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F2610E177;
	Tue,  4 Aug 2026 15:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WuZvIrr/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F81C10E177
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:35:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06B5060A75;
 Tue,  4 Aug 2026 15:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893421F000E9;
 Tue,  4 Aug 2026 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785857743;
 bh=TYetphJNPgj8BWiAp+/mUnftps/hVL6HopV32c0/nP0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WuZvIrr/HS2kx4qgebRfwSGMCGDPGib/hIIzGTLcsacxsSsCE9twTLOX2D6Bwm9pS
 KAH/OcBiuOecEvymaafCfEAhXD041t28HUs8WebjRgvaCfZlZliimGW93ZJ/MVxINx
 MR9/rhJGKhaNKB1dMJptvFNYx5bWeERmi58lgwaUREbTOfp7AW/VNzfs2KNhLB9iLh
 R7GeqhqDx7ICA+Y5oVi/6hj7JSdX1je3jdQlIfhWWiZSK8eWUf6lDf5v7JuwDAj+Y9
 /H1PWLasBmNOQpYt06c1ShPiWrXsoo97icTic+ebLQRsw/gA8PLhs2Ou7U4bWbX7ms
 Zud6q8c1TsymQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] drm/amd/display: Clean up FreeSync capability
 detection
To: "Alex Huang" <Alex.Huang2@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804143339.714548-4-Alex.Huang2@amd.com>
References: <20260804143339.714548-1-Alex.Huang2@amd.com>
 <20260804143339.714548-4-Alex.Huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:35:42 +0000
Message-Id: <20260804153543.893421F000E9@smtp.kernel.org>
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
- [High] Missing fallback to EDID monitor range when an AMD VSDB is present=
 but does not advertise FreeSync support, breaking VRR on DP/eDP displays.
--

--- Patch [3]: [PATCH v3 3/4] drm/amd/display: Clean up FreeSync capability=
 detection ---
commit 54e384ef3776414446c8d6bb002d768a87198a34
Author: Alex Huang <Alex.Huang2@amd.com>

drm/amd/display: Clean up FreeSync capability detection

This commit refactors FreeSync capability detection in the amdgpu_dm driver.
It extracts duplicate code for reading the AMD VSDB and sets up the connect=
or
fields outside of the specific display interface branches. It also falls ba=
ck
to the monitor_range data if the VSDB is not present.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 44b8dd000f5ca..6d83e9a425377 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -13766,63 +13766,57 @@ void amdgpu_dm_update_freesync_caps(struct drm_=
connector *connector,
>  	     connector->display_info.monitor_range.max_vfreq =3D=3D 0))
>  		parse_edid_displayid_vrr(connector, edid);
> =20
> -	if (edid && (sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT ||
> -		     sink->sink_signal =3D=3D SIGNAL_TYPE_EDP)) {
> -		if (amdgpu_dm_connector->dc_link &&
> -		    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_p=
aram) {
> -			amdgpu_dm_connector->min_vfreq =3D connector->display_info.monitor_ra=
nge.min_vfreq;
> -			amdgpu_dm_connector->max_vfreq =3D connector->display_info.monitor_ra=
nge.max_vfreq;
> -			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq >=
 10)
> -				freesync_capable =3D true;
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
Does this code inadvertently drop the EDID monitor range fallback when an A=
MD
VSDB is present but does not support FreeSync?

Looking at amdgpu_dm_update_freesync_caps(), if has_vsdb is true but
vsdb_info.freesync_supported is false, the code skips updating the frequency
limits in the if block.

Because has_vsdb is true, the else block is also bypassed, leaving
amdgpu_dm_connector->min_vfreq and max_vfreq at their default zero values.

Would this cause the subsequent VRR capability check=20
max_vfreq - min_vfreq > 10 to fail, disabling FreeSync on DP/eDP displays?

Should the EDID fallback assignment be applied whenever
!vsdb_info.freesync_supported, rather than only when the VSDB is entirely
absent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804143339.7145=
48-1-Alex.Huang2@amd.com?part=3D3
