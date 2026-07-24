Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4F5C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD5710F437;
	Fri, 24 Jul 2026 16:32:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="liHC+4pF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06ABE10F437
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 16:32:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 961BA40795;
 Fri, 24 Jul 2026 16:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0521F000E9;
 Fri, 24 Jul 2026 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784910740;
 bh=nNZ5nJIsZooiVbR3/kZQKlj7zpPVY5zFLOcY6SXItMo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=liHC+4pF5K5zHrkLx88/Ekb6oMnLuPCkV4wwpuz3/KMf8LQN+6X/aqYiVNsxy0RCk
 6+PYYwEyT526l9JIcLzfj/yJ8mRlVlYDnb3TBCq+vOLY6p3jGnCQbxhgYsXBAwSw0I
 k5FDYqTHeQmC3/QLmTzm3UyYEsCm0XR97MDYtxBuJJ5k1aUGMr9tiTMKMQk2jsKRzr
 PeRyV3YeGsMfjNJqCUZ5NUVAheI2hpaoLqxIgj//yQ9vAUeuQJriHsEcWrzG6EEQ/i
 GyA/slgP6FZrtIUBrwdlAAHt/sg/yyWNh9hAU9z8bDjFrFsYGSAwrPOL7NFT8+bxZ2
 cPkvPSWA3xGVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] drm/amd/display: Remove unused DMCU/DMUB EDID
 CEA parser
To: "Alex Huang" <Alex.Huang2@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724161713.119382-5-Alex.Huang2@amd.com>
References: <20260724161713.119382-1-Alex.Huang2@amd.com>
 <20260724161713.119382-5-Alex.Huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 16:32:19 +0000
Message-Id: <20260724163220.4F0521F000E9@smtp.kernel.org>
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
- [High] FreeSync refresh rate range fallback is skipped when an AMD VSDB i=
s present but does not support FreeSync.
--

--- Patch [4]: [PATCH v2 4/4] drm/amd/display: Remove unused DMCU/DMUB EDID=
 CEA parser ---
commit 70d6e721703932c257bc5a364c485afc55d1ca84
Author: Alex Huang <Alex.Huang2@amd.com>

drm/amd/display: Remove unused DMCU/DMUB EDID CEA parser

With HDMI FreeSync detection now sourced from the common DRM EDID
parser, the DMUB parsing for AMD VSDB is no longer used.

Remove all relevant fields and files for this flow, it is no longer
necessary to ever take firmware round-trip for this.

> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/am=
d/display/dc/Makefile
> index 93d02956c5eb5..e88a9cea8d881 100644
> --- a/drivers/gpu/drm/amd/display/dc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
> @@ -63,7 +63,6 @@ include $(AMD_DC)
> =20
>  FILES =3D
>  FILES +=3D dc_dmub_srv.o
> -FILES +=3D dc_edid_parser.o
>  FILES +=3D dc_fused_io.o
>  FILES +=3D dc_helper.o
>  FILES +=3D core/dc.o

[ ... ]

[Severity: High]
While reviewing the FreeSync detection flow, I noticed an issue in
amdgpu_dm_update_freesync_caps() in amdgpu_dm.c:

amdgpu_dm_update_freesync_caps() {
	if (has_vsdb) {
		amdgpu_dm_connector->vsdb_info =3D vsdb_info;

		/* copy refresh rate info as long as VSDB advertises FreeSync */
		if (vsdb_info.freesync_supported) {
			amdgpu_dm_connector->min_vfreq =3D vsdb_info.min_refresh_rate_hz;
			amdgpu_dm_connector->max_vfreq =3D vsdb_info.max_refresh_rate_hz;
			...
		}
	} else {
		/* fall back to the base EDID range when there is no VSDB */
		amdgpu_dm_connector->min_vfreq =3D connector->display_info.monitor_range.=
min_vfreq;
		amdgpu_dm_connector->max_vfreq =3D connector->display_info.monitor_range.=
max_vfreq;
	}
}

Does this code skip the FreeSync refresh rate range fallback when an AMD VS=
DB
is present but does not support FreeSync?

If has_vsdb is true but vsdb_info.freesync_supported is false, the code ski=
ps
both the VSDB refresh rate assignment and the else block fallback.

As a result, min_vfreq and max_vfreq remain 0, and the max_vfreq - min_vfre=
q > 10
check fails.

Can this completely disable FreeSync for DP/eDP panels that contain an
AMD VSDB but do not advertise FreeSync via the VSDB (e.g., they rely on
standard DisplayID/EDID VRR range and have a VSDB solely for Panel Replay)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161713.1193=
82-1-Alex.Huang2@amd.com?part=3D4
