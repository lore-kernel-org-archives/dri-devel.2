Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7337C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2145810E19C;
	Tue,  4 Aug 2026 15:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L6Pii9Hs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB4110E19C
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:49:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9CD1260A8A;
 Tue,  4 Aug 2026 15:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E851F000E9;
 Tue,  4 Aug 2026 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785858582;
 bh=HKnDy51ZtOJ3u8HY+zlWSlC/Eb8oxPlcSpnrMsQ5q9g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L6Pii9Hs6WqZBEUQ+ZZ2cSVCh9fWUAPVatRl9kLvYeRLDRPQaixdq1yxNJn4DTAXf
 PwFOWVTnav+GqHmMGby7N9+d1l4TV3K1SkmxeFclRpny0Sy29RxFoDRDzbkaEOYpR0
 DFk0gCdEYjP6PfOAaEAcxcf8AXS9OK9Y5l8UvTqUWlb8Kwuxf6zI+uO7sJc6VoSM4N
 +TDmekixvEJPiwbGQwxuOe4ZWornBPmRmD1vWFyXTRzuPVmmk5tO8Ub6kURr+nX7rv
 lSa/4RGPj2COgmE8Tf6ow3VeQkudq95v+7CdgHI+OJZW0poTIJRM4IfDVhUNcx40sh
 JLmDZPV1d4GWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] drm/amd/display: Remove unused DMCU/DMUB EDID
 CEA parser
To: "Alex Huang" <Alex.Huang2@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804143339.714548-5-Alex.Huang2@amd.com>
References: <20260804143339.714548-1-Alex.Huang2@amd.com>
 <20260804143339.714548-5-Alex.Huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:49:41 +0000
Message-Id: <20260804154942.29E851F000E9@smtp.kernel.org>
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
- [Medium] FreeSync standard fallback range is skipped for monitors with an=
 AMD VSDB that does not advertise FreeSync support.
--

--- Patch [4]: [PATCH v3 4/4] drm/amd/display: Remove unused DMCU/DMUB EDID=
 CEA parser ---
commit dc49dbde5bae751a6f9eaf5e370f73f95f12ba84
Author: Alex Huang <Alex.Huang2@amd.com>
Subject: drm/amd/display: Remove unused DMCU/DMUB EDID CEA parser

This commit removes the DMCU/DMUB EDID CEA parsing code, as HDMI FreeSync
detection is now handled by the common DRM EDID parser. All related fields
and files are deleted to avoid unnecessary firmware round-trips.

> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ ... @@ amdgpu_dm_update_freesync_caps()
>  		/* copy refresh rate info as long as VSDB advertises FreeSync */
>  		if (vsdb_info.freesync_supported) {
>  			amdgpu_dm_connector->min_vfreq =3D vsdb_info.min_refresh_rate_hz;
>  			amdgpu_dm_connector->max_vfreq =3D vsdb_info.max_refresh_rate_hz;
> =20
>  			connector->display_info.monitor_range.min_vfreq =3D
>  				vsdb_info.min_refresh_rate_hz;
>  			connector->display_info.monitor_range.max_vfreq =3D
>  				vsdb_info.max_refresh_rate_hz;
>  		}

[Severity: Medium]
Will this leave amdgpu_dm_connector->min_vfreq and max_vfreq uninitialized
when a monitor has an AMD VSDB but doesn't advertise FreeSync support within
it?

By omitting an else branch for the freesync_supported =3D=3D false conditio=
n,
it appears the fallback to connector->display_info.monitor_range is bypasse=
d.

Could this silently disable FreeSync for monitors that otherwise support it
via standard DisplayID or base EDID VRR data, since the subsequent check
(max_vfreq - min_vfreq > 10) would then fail?

>  	} else {
>  		/* fall back to the base EDID range when there is no VSDB */
>  		amdgpu_dm_connector->min_vfreq =3D connector->display_info.monitor_ran=
ge.min_vfreq;
>  		amdgpu_dm_connector->max_vfreq =3D connector->display_info.monitor_ran=
ge.max_vfreq;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804143339.7145=
48-1-Alex.Huang2@amd.com?part=3D4
