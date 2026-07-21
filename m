Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13077C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B96910E0F7;
	Tue, 21 Jul 2026 16:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lSpZTuZk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA7B10E0F7
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 16:59:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83BC84115F;
 Tue, 21 Jul 2026 16:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530981F000E9;
 Tue, 21 Jul 2026 16:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784653175;
 bh=7WYCd/o/7wPHFeVBfJBzSo+unEZ3bh3rQR5MkpxteRc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lSpZTuZkkfrRYTyOV11b4x/D8MkLuY8TLCVxai/0UBVLhuRwqhu03N6TMts7WAPD8
 lumMfUyqnMDZa8mh7feibu0C4+NrKgfYS1jk1TNz/Jknq6tEpZj17JxNNCJROJeOEp
 NQmUb+i+O6TfwQoJ7PQThBPgq7Kku/NAUw9qVIDBy7WSnFKx1IBc2idnIggpcaHcwi
 fX7akHIeJkNC+PzzaIESrhRsOSKSRykdUYicS5GxAXa4Av5pbn2eSvj7PV/0OkfcbK
 MuHRqiKROG4ErTpSM4DhX3z7W+VV6/HAqnuiYMg7GiclB3DaQHiqJs25lNEwazZDSq
 2YRvSbbh2nIDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/amd/display: Remove unused DMCU/DMUB EDID CEA
 parser
To: "Alex Huang" <Alex.Huang2@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721164430.2121326-5-Alex.Huang2@amd.com>
References: <20260721164430.2121326-1-Alex.Huang2@amd.com>
 <20260721164430.2121326-5-Alex.Huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:59:34 +0000
Message-Id: <20260721165935.530981F000E9@smtp.kernel.org>
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
- [High] Parsing AMD VSDB blocks of version 2 or 3 without verifying the pa=
yload length leads to out-of-bounds memory reads on malformed EDIDs.
--

--- Patch [4]: [PATCH 4/4] drm/amd/display: Remove unused DMCU/DMUB EDID CE=
A parser ---
commit f5b939679f4dd7676bcd444c9eae98b5a45015a4
Author: Alex Huang <Alex.Huang2@amd.com>

drm/amd/display: Remove unused DMCU/DMUB EDID CEA parser

With HDMI FreeSync detection now sourced from the common DRM EDID parser,
the DMUB parsing for AMD VSDB is no longer used. This commit removes all
relevant fields and files for this flow.

>     With HDMI FreeSync detection now sourced from the common DRM EDID
>     parser, the DMUB parsing for AMD VSDB is no longer used.

[Severity: High]
Does the common DRM EDID parser validate the payload length before parsing?

Looking at drm_parse_amd_vsdb() in drivers/gpu/drm/drm_edid.c, the version
checks lack corresponding payload length validation before calling the v2
and v3 parsing functions:

drivers/gpu/drm/drm_edid.c:drm_parse_amd_vsdb() {
	if (common->version >=3D 2)
		drm_parse_amd_vsdb_v2(info, data);

	if (common->version >=3D 3)
		drm_parse_amd_vsdb_v3(info, data, cea_db_payload_len(db));
}

If a malformed EDID presents a block with payload_len =3D 8 and version =3D=
 3,
drm_parse_amd_vsdb_v2() unconditionally accesses fields up to offset 12
(p->lum2_min):

drivers/gpu/drm/drm_edid.c:drm_parse_amd_vsdb_v2() {
    ...
	info->amd_vsdb.luminance_range2.min_luminance =3D p->lum2_min;
}

Similarly, drm_parse_amd_vsdb_v3() unconditionally accesses fields up to
offset 14 (p->max_vfreq_ext_high):

drivers/gpu/drm/drm_edid.c:drm_parse_amd_vsdb_v3() {
    ...
	max_frame_rate =3D p->max_vfreq_ext_low |
			 (p->max_vfreq_ext_high & 0x3) << 8;
    ...
}

Can this lead to out-of-bounds memory reads on malformed EDIDs? Since the
block could be as short as 8 bytes, these accesses might read past the
allocated buffer into adjacent heap memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721164430.2121=
326-1-Alex.Huang2@amd.com?part=3D4
