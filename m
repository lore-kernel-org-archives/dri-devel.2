Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D60C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 19:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8233010E54C;
	Mon, 13 Jul 2026 19:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KCq+IGk4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0C1210E54C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 19:49:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6AB2E417AF;
 Mon, 13 Jul 2026 19:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFE11F00A3A;
 Mon, 13 Jul 2026 19:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783972185;
 bh=kKLKE/t1lGW7vPijl67zVO8If2lVKI6XZ6BKAwoJev8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KCq+IGk4KmzOIu4oUuQm1LiXhqv0jJ4oas2GrQ+fj5yWvjP4IBnWPJlXq3JpJfUEe
 lwr8+QQhiLuE2l3ihX7fa+Jn4rI400DjLKwi1ZzKupdlyJxkgFiTDny3wHJj6HgmEf
 mbVDciDYpgHzl7iaZbSu4ZOM4JgjZgi1ibvVvmeBsVbddgAgK+Q1ql9sJJrSULQRdM
 gh7eu/SncxDAKRQBQjcmXEEkLuSvQFLO6TWHoGdvZ4IZDwx1AIB1y7DTRhy5Pu/Dih
 9MMsW/rx7I9Q7LdCRrSX4Qb6TpAbHTl9S8Ip/NediJ7JSLdQj/Taw/aDrlLKGBcSml
 DTotZyYbkkUfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/amd/display: Use drm_edid_block_count()
 instead of raw extensions
To: =?utf-8?b?VGltbyBQcsO2bWVy?= <timo.proemer04@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713193237.2639-3-timo.proemer04@gmail.com>
References: <20260713193237.2639-1-timo.proemer04@gmail.com>
 <20260713193237.2639-3-timo.proemer04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 19:49:44 +0000
Message-Id: <20260713194945.2AFE11F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Kernel heap out-of-bounds read due to mismatch between HF-EEODB bl=
ock count and raw `edid->extensions` byte.

Pre-existing issues:
- [Critical] Heap buffer overflow in amdgpu_dm_connector_funcs_force() when=
 copying EDID.
--

--- Patch [2]: [PATCH v2 2/2] drm/amd/display: Use drm_edid_block_count() i=
nstead of raw extensions ---
commit bb5e357c1182326e11f3ce4e756df91c3df854a6
Author: Timoyoungster <timo.proemer04@gmail.com>

drm/amd/display: Use drm_edid_block_count() instead of raw extensions

Instead of manually calculating the EDID block count by reading the
extensions field from the raw edid structure (edid->extensions + 1),
utilize the core DRM helper drm_edid_block_count().

This now includes possible HF-EEODB extension blocks, which are not
included in edid->extensions and were previously truncated with the
memmove.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 71e2627f9a9d4..82f3cce870a3c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -1220,11 +1221,15 @@ enum dc_edid_status dm_helpers_read_local_edid(
>  			continue;
> =20
>  		edid =3D drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
> -		if (!edid ||
> -		    edid->extensions >=3D sizeof(sink->dc_edid.raw_edid) / EDID_LENGTH)
> +		if (!edid)
>  			return EDID_BAD_INPUT;
> =20
> -		sink->dc_edid.length =3D EDID_LENGTH * (edid->extensions + 1);
> +		block_count =3D drm_edid_block_count(drm_edid);
> +
> +		if (block_count > sizeof(sink->dc_edid.raw_edid) / EDID_LENGTH)
> +			return EDID_BAD_INPUT;
> +
> +		sink->dc_edid.length =3D EDID_LENGTH * block_count;
>  		memmove(sink->dc_edid.raw_edid, (uint8_t *)edid, sink->dc_edid.length);

[Severity: High]
Does this create an out-of-bounds read when the copied EDID is parsed downs=
tream?

If a malicious display provides an EDID with an extension count of 255 but =
an
HF-EEODB block specifying a count of 2, drm_edid_block_count() will return =
2.
The bounds check passes, and memmove() copies 256 bytes into raw_edid.

However, the raw extensions byte in the copied data remains 255.
When this is later parsed in dm_helpers_parse_edid_caps() which delegates to
drm_edid_is_valid(), doesn't that legacy helper use the unmodified extensio=
ns
byte to iterate up to 256 times, reading past the end of the 2048-byte
raw_edid array on the kernel heap?

Should the raw extensions byte in the copied buffer be manually updated to =
match
block_count - 1, preventing legacy functions from performing out-of-bounds
reads?

Also, looking at related EDID copying code in the same subsystem:

[Severity: Critical]
This isn't a bug introduced by this patch, but does the following code in
amdgpu_dm_connector.c:amdgpu_dm_connector_funcs_force() have a heap buffer
overflow?

amdgpu_dm_connector_funcs_force() {
    ...
    memmove(dc_em_sink->dc_edid.raw_edid, edid, (edid->extensions + 1) * ED=
ID_LENGTH);
    ...
}

If a malicious display or I2C emulator provides an EDID with extensions set=
 to
255 and valid block checksums, and userspace with DRM privileges forces a
connector status update, it appears this could copy up to 32KB into the 2KB
dc_em_sink->dc_edid.raw_edid buffer, corrupting the heap.

Is a bounds check needed here similar to the one performed in
dm_helpers_read_local_edid()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713193237.2639=
-1-timo.proemer04@gmail.com?part=3D2
