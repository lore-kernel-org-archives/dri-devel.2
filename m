Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C01C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E2710E2CE;
	Mon, 31 Aug 2026 15:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fs8o0wKM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158F510E2CE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:26:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59CB2601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B5D1F000E9;
 Mon, 31 Aug 2026 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788189959;
 bh=WegxipJCi8cJFyMvrOIoP0B494w188am2/VgVfd7w+M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fs8o0wKMab9hVkeEWK6PizaXkgh1MAsxOnDgUHdrFoHUoUHgYRZePCSpBR0Zz45t5
 Bgr0zoQYumCHHBYtyTe5vd8QbSkAPdRjGr84xeud6gOJQARkulZDQ/47lixBggG/tM
 s9+nB2ghCQ5AWy35mM7dkHn6VpY1BxZZqqL8iRyLGHrDT/VKw0iratXIWJigLZnZ+5
 hZ0alHxA0nZMnn0/AaIDUIVnzqOcy4l3pctLLVfKClwnbAnd6HAvDYi9u6aDh8wGUk
 LiBbgyOS4dk4PlwJIfm+sZK7fjinzC9GxFlQ/C859BOKla1XkkNqxzo59zwQCGM649
 SyG86aXRh7Vqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/amd/display: Fix 8K Mode Not Parsed by
 EDID
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-264-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-264-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:25:58 +0000
Message-Id: <20260831152558.D8B5D1F000E9@smtp.kernel.org>
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
- [High] Ignoring the return value of `drm_edid_connector_update()` leads t=
o a slab-out-of-bounds read during `memmove` if the update fails and the co=
nnector retains a previously larger EDID blob.
--

commit f834146b80d7916aeba3bf8175e4f9717ecbf6f3
Author: Fangzhi Zuo <Jerry.Zuo@amd.com>
   =20
drm/amd/display: Fix 8K Mode Not Parsed by EDID
   =20
This commit fixes 8K mode parsing by changing the way the EDID length is
determined. Instead of using the raw extension block count, it now relies
on the length of the property blob updated by drm_edid_connector_update()
to copy the full EDID into the sink's raw_edid buffer.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index d0f770dd0a956..c2de763d621d3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -1031,11 +1031,25 @@ enum dc_edid_status dm_helpers_read_local_edid(
>  			continue;
> =20
>  		edid =3D drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
> -		if (!edid ||
> -		    edid->extensions >=3D sizeof(sink->dc_edid.raw_edid) / EDID_LENGTH)
> +		/*
> +		 * Use the length of the EDID property blob populated by
> +		 * drm_edid_connector_update() above. It reflects the true number
> +		 * of EDID blocks, including any HDMI Forum EDID Extension Override
> +		 * Data Block (HF-EEODB) count, which the raw byte 0x7e extension
> +		 * count can hide (e.g. HDMI 8K sinks).
> +		 */
> +		if (!edid || !connector->edid_blob_ptr ||
> +		    connector->edid_blob_ptr->length > sizeof(sink->dc_edid.raw_edid))
>  			return EDID_BAD_INPUT;
> =20
> -		sink->dc_edid.length =3D EDID_LENGTH * (edid->extensions + 1);
> +		/*
> +		 * FIXME: amdgpu_dm today does not consider the HF-EEODB, which
> +		 * may contain additional mode info for sinks. This is a
> +		 * workaround until dc_edid is refactored out from DC into
> +		 * amdgpu_dm's ownership, allowing amdgpu_dm to use drm_edid
> +		 * directly
> +		 */
> +		sink->dc_edid.length =3D connector->edid_blob_ptr->length;
>  		memmove(sink->dc_edid.raw_edid, (uint8_t *)edid, sink->dc_edid.length);

[Severity: High]
Can this lead to a slab-out-of-bounds read if drm_edid_connector_update()
fails?

Earlier in dm_helpers_read_local_edid(), the code updates the connector:

    drm_edid_connector_update(connector, drm_edid);

The return value of this update is ignored. If a monitor was previously
connected with a large EDID (e.g., 512 bytes), and a subsequent probe
reads a smaller EDID (e.g., 128 bytes), this update might fail due to a
memory allocation failure.

If it fails, connector->edid_blob_ptr will retain its previous 512-byte
size. Because 512 is less than sizeof(sink->dc_edid.raw_edid), the checks
above will pass.

The code will then proceed to the memmove() and use the stale 512-byte
length to copy from the newly allocated, smaller 128-byte edid buffer,
causing a read out of bounds.

Should the return value of drm_edid_connector_update() be checked, or
should we ensure the length is retrieved directly from the current
drm_edid before doing the copy?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-264-sashal@kernel.org?part=3D1
