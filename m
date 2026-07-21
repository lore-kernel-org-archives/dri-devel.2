Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7D4C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DFB010EACB;
	Tue, 21 Jul 2026 17:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GA5jZfeh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3F610EACB
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:03:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 08FAB40E48;
 Tue, 21 Jul 2026 17:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BB91F00A3A;
 Tue, 21 Jul 2026 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784653428;
 bh=cLj6nm+IoUjQk9F9IMqkKQdl7yM/NLvv8rV2siaOA34=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GA5jZfeh8PeHnA8n7aIeDasP/wGussxZoMBn0LtM4arfkm5iooWXBIXrZ7eztqOvl
 Z1qleFNy5zQsg5IuzTaWL4PzQTmN12GgvQVC2/ZsDgttk8VYCvqRdMfKg600HfBfNj
 eWaWlQrM5cnejn0Wwnr2XvzNoSVQOpS10eqOA+Py7UBv1DBg7MLoXbQDEFTHUr0ggO
 mN8al47yU4OIHEs65vLzScA2WYO7nocwwdi5T0fxarYS/P2h4sC3C6hIrzKNTZM8CE
 Mzqp15ykfpD+X2yb/s2AVFlV05iJBHeBHCTgSIwxvlnGj6vzVUdoTck/T6fX2nqk/G
 amQEO2BNKsv6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] drm/amd/display: Use HDMI FreeSync range from
 common EDID parser
To: "Alex Huang" <Alex.Huang2@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721164430.2121326-3-Alex.Huang2@amd.com>
References: <20260721164430.2121326-1-Alex.Huang2@amd.com>
 <20260721164430.2121326-3-Alex.Huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:03:48 +0000
Message-Id: <20260721170348.B6BB91F00A3A@smtp.kernel.org>
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
- [High] Missing payload length checks in AMD VSDB version 2 and 3 parsing =
leads to out-of-bounds memory reads when processing malformed EDIDs.
--

--- Patch [2]: [PATCH 2/4] drm/amd/display: Use HDMI FreeSync range from co=
mmon EDID parser ---
commit 1c50a992def070041d1c59487f692155608cc345
Author: Alex Huang <Alex.Huang2@amd.com>
Subject: drm/amd/display: Use HDMI FreeSync range from common EDID parser

This commit modifies the AMD GPU display driver to use the common DRM EDID
parser for detecting HDMI FreeSync capabilities, rather than relying on the
AMD VSDB parser in the DMUB firmware.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9c564cd5edeea..fd9bb205c8f08 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

[ ... ]

> @@ -13932,8 +13770,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_co=
nnector *connector,
>  		}
> =20
>  	} else if (drm_edid && sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A=
) {
> -		i =3D parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
> -		if (i >=3D 0) {
> +		i =3D get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
> +		if (i) {

[Severity: High]
Does relying on the common DRM EDID parser here expose us to out-of-bounds
memory reads when processing malformed EDIDs?

Looking at the common parser in drivers/gpu/drm/drm_edid.c,
drm_parse_amd_vsdb() fails to validate the payload length before delegating
to version-specific parsers:

drivers/gpu/drm/drm_edid.c:drm_parse_amd_vsdb() {
    ...
	info->amd_vsdb.version =3D common->version;

	drm_parse_amd_vsdb_v1(info, data);

	if (common->version >=3D 2)
		drm_parse_amd_vsdb_v2(info, data);

	if (common->version >=3D 3)
		drm_parse_amd_vsdb_v3(info, data, cea_db_payload_len(db));
}

The v2 parser unconditionally accesses struct fields up to offset 12 without
checking if the payload length is sufficient:

drivers/gpu/drm/drm_edid.c:drm_parse_amd_vsdb_v2() {
    ...
	info->amd_vsdb.luminance_range1.max_luminance =3D p->lum1_max;
	info->amd_vsdb.luminance_range1.min_luminance =3D p->lum1_min;
	info->amd_vsdb.luminance_range2.max_luminance =3D p->lum2_max;
	info->amd_vsdb.luminance_range2.min_luminance =3D p->lum2_min;
    ...
}

Similarly, the v3 parser unconditionally accesses fields up to offset 14:

drivers/gpu/drm/drm_edid.c:drm_parse_amd_vsdb_v3() {
    ...
	/* vfreq is provded in a different set of fields for v3. */
	max_frame_rate =3D p->max_vfreq_ext_low |
			 (p->max_vfreq_ext_high & 0x3) << 8;
    ...
}

If a monitor provides an AMD VSDB block with version 2 or 3 but a payload
length smaller than required, could this lead to an out-of-bounds read of
up to 7 bytes in the slab?

>  			amdgpu_dm_connector->vsdb_info =3D vsdb_info;
>  			sink->edid_caps.freesync_vcp_code =3D vsdb_info.freesync_mccs_vcp_cod=
e;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721164430.2121=
326-1-Alex.Huang2@amd.com?part=3D2
