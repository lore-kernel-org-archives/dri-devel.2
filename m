Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60F9C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4319610EAC4;
	Mon, 13 Jul 2026 18:50:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nTDIFZ8L";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D124410EAC4
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 18:50:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 139C960103;
 Mon, 13 Jul 2026 18:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9251A1F000E9;
 Mon, 13 Jul 2026 18:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783968652;
 bh=I3zQobyzCvlt962kiYrzLeC/ZnXFcpbAQKE2dZ9gzHA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nTDIFZ8LpneFq943aNn/JbXZZy5LUEZkWfMv8YcatVTqRgt4Mc0F6bdb1F8NdhTcK
 FwOrW/0t6d1PKwaklTK73iukQ7NxcqSOp839ib/wK87pADE0xbI4svlxlR9+slIVHb
 sfi6IgZlQeoTJt7pPnX3He3KOKZHLOuvuzAxCARe9vg55AX/cwptAYpLncCdhYR5gA
 qJluH9EppnR7XDGqKWODp0WILQmZTa4Pa7Obn5JbxjXP0uSegD3akaQhv5cuF90esM
 ECzaUKZOnyAHJlOsKyPZt8w8FVUguFHiWx5aToLbgHtMaXdfKnpfvaNfDnpFUAO73j
 vuq4tcmUj2RqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/amd/display: Use drm_edid_block_count() instead
 of raw extensions
To: =?utf-8?b?VGltbyBQcsO2bWVy?= <timo.proemer04@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713183841.5921-3-timo.proemer04@gmail.com>
References: <20260713183841.5921-1-timo.proemer04@gmail.com>
 <20260713183841.5921-3-timo.proemer04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 18:50:51 +0000
Message-Id: <20260713185052.9251A1F000E9@smtp.kernel.org>
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
- [Critical] Heap buffer overflow in `sink->dc_edid.raw_edid` due to mismat=
ched bounds check when handling HF-EEODB EDID extensions.
--

--- Patch [2]: [PATCH 2/2] drm/amd/display: Use drm_edid_block_count() inst=
ead of raw extensions ---
commit 9d8e550a87693a10ec905e77e53d8e77319a53c9
Author: Timo Pr=C3=B6mer <timo.proemer04@gmail.com>

drm/amd/display: Use drm_edid_block_count() instead of raw extensions

This commit replaces the manual EDID block count calculation with the core
DRM helper drm_edid_block_count(). It aims to include possible HF-EEODB
extension blocks that were previously truncated.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
[ ... ]
> @@ -1224,7 +1225,9 @@ enum dc_edid_status dm_helpers_read_local_edid(
>  		    edid->extensions >=3D sizeof(sink->dc_edid.raw_edid) / EDID_LENGTH)
>  			return EDID_BAD_INPUT;
> =20
> -		sink->dc_edid.length =3D EDID_LENGTH * (edid->extensions + 1);
> +		block_count =3D drm_edid_block_count(drm_edid);
> +
> +		sink->dc_edid.length =3D EDID_LENGTH * block_count;
>  		memmove(sink->dc_edid.raw_edid, (uint8_t *)edid, sink->dc_edid.length);

[Severity: Critical]
Can this cause a heap buffer overflow when handling HF-EEODB extensions?

Looking at dm_helpers_read_local_edid(), the bounds check right before this
change still validates against the raw edid->extensions count:

    if (!edid ||
        edid->extensions >=3D sizeof(sink->dc_edid.raw_edid) / EDID_LENGTH)
        return EDID_BAD_INPUT;

If an EDID specifies a small edid->extensions count (e.g., 1) but an
HF-EEODB overrides the block count to a much larger value (e.g., 32), the
bounds check evaluates to 1 >=3D 16 and passes.

The new logic then calculates a length based on the larger block_count
returned by drm_edid_block_count() and passes it directly to memmove().

Since sink->dc_edid.raw_edid is a fixed-size buffer, does this result in
copying more data than the buffer can safely hold?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713183841.5921=
-1-timo.proemer04@gmail.com?part=3D2
