Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8DF606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RryJ3RLd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7BD110E3EA;
	Thu, 22 Oct 2026 07:26:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2AE10E3EA
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 07:26:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A168F601F1;
 Thu, 22 Oct 2026 07:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C2E1F000C1;
 Thu, 22 Oct 2026 07:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792654008;
 bh=9XYMz1BbVGgtN8C+PUsNMOsQ0cIMgqdzWHbLwOirjM0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RryJ3RLdID8pvZA4u8SoHLb4h2Jzji+/BNh/CSO1EuqHU/x3ow/IwPf+KIXoP+yHV
 7KyZIXxS6N0zbiEX7zbBQzyNzAjKkZynnTwsaxbyoTZr+kfmSruuTxN8BsJMR4f27z
 7qevEUH7q36JN+zgG6CszLZiTlzV4lLdAQEd7Ij++z6R9qFN62O8/Mmb8SxMwyAO/M
 Piu7TD8IndzraClKYi9FtDTg4wJohXT00z89ACGbcJVe4+VeheQ/q4AET2xL4PmHFa
 teF+RwKsmokiNiZevNWuW+GrJr1a91/PsIDqI9KNLoUkPOvt85vFyxp4XeEeGHoq+/
 C937M+thnBR7A==
Message-ID: <sashiko-outbox-181126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/rockchip: vop2: Use drm_format_info_min_pitch()
 for plane offsets
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022071737.508-2-kernel@airkyi.com>
References: <20261022071737.508-1-kernel@airkyi.com>
 <20261022071737.508-2-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 07:26:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/rockchip: vop2: dead store to UV offset in vop2_plane_atomic_u=
pdate()
--

commit 6df46f75e1463ad71a6132367733e70876d282fa
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: vop2: Use drm_format_info_min_pitch() for plane offsets

This commit updates vop2_plane_atomic_update() to calculate plane horizontal
byte offsets using drm_format_info_min_pitch() instead of fb->format->cpp[]
to support block-based 10-bit formats.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index bfb3841425687..410a8fea3ff4a 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1290,7 +1290,7 @@ static void vop2_plane_atomic_update(struct drm_pla=
ne *plane,
> =20
>  	afbc_en =3D drm_is_afbc(fb->modifier);
> =20
> -	offset =3D (src->x1 >> 16) * fb->format->cpp[0];
> +	offset =3D drm_format_info_min_pitch(fb->format, 0, src->x1 >> 16);
> =20
>  	/*
>  	 * AFBC HDR_PTR must set to the zero offset of the framebuffer.
> @@ -1309,6 +1309,7 @@ static void vop2_plane_atomic_update(struct drm_pla=
ne *plane,
>  		int hsub =3D fb->format->hsub;
>  		int vsub =3D fb->format->vsub;
> =20
> +		offset =3D drm_format_info_min_pitch(fb->format, 1, src->x1 >> 16) / h=
sub;
>  		offset =3D (src->x1 >> 16) * fb->format->cpp[1] / hsub;

[Severity: High]
In vop2_plane_atomic_update() in
drivers/gpu/drm/rockchip/rockchip_drm_vop2.c, should the old
fb->format->cpp[1] assignment be removed here?

Leaving it in place immediately overwrites the offset returned by
drm_format_info_min_pitch() when fb->format->is_yuv is true, so planes with
a non-zero src->x1 on block-based 10-bit formats will still compute an
incorrect uv_mst address.

>  		offset +=3D (src->y1 >> 16) * fb->pitches[1] / vsub;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022071737.508-=
1-kernel@airkyi.com?part=3D1
