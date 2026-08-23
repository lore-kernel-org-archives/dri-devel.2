Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD18C5DF81
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 19:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D08C10E4BA;
	Sun, 23 Aug 2026 19:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="yRSIcm0K";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52C810E4BA
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 19:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=JHIFFPoPBok4Enb1vmDibOlXvjE96+mvh5k+3E9o3Q4=; b=yRSIcm0K+2lJ8cWUbdK8pWzTNU
 TfHVkAKDP77B+xQF1Lglr2vLwDSXcVqdK98cKyUGyWv/LbnUxHInIWIS1LHajfG4pHqhUqTK7/jbn
 3havtYtAE6CumxuekTvkOpAh7mSNKUxsHSPKioljrWIH/NDBW5f3rj9etT+SrupqI2rreW59nW30o
 1YeV+dee1Jz81c6P9o/BorXHbbiMHrLRLRVPH6wqpHCp+87xUDFqwaUGE6qb6Zy8CmvPHI/42wKgB
 O3MVopmuwtwwUiupII0/cqJ0YE29nRPx/Vkl9qZ+LmbM2uVCm26N5OZkloDFFzGp2bZkTjIZNDQkG
 GRCXoH2A==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>, andy.yan@rock-chips.com
Cc: hjc@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] drm: rockchip: add
 drm_plane_create_blend_mode_property
Date: Sun, 23 Aug 2026 21:19:28 +0200
Message-ID: <25031028.6Emhk5qWAg@diego>
In-Reply-To: <1ab6fb88-3b84-49b5-aa05-202a84edbd3d@gmail.com>
References: <1ab6fb88-3b84-49b5-aa05-202a84edbd3d@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Johan,

Am Sonntag, 23. August 2026, 14:29:09 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Johan Jonker:
> A validate_blend_mode_for_alpha_formats() function was added that
> fills the kernel log with warnings for Rockchip VOP version 1 SoCs.
> Add a drm_plane_create_blend_mode_property() function as fix.

This is missing explanation on why PIXEL_NONE is the correct value.

VOP2 seems to support all 3 blend modes? So a sentece explaining
the pixel_none value would be helpful.


Heiko

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>=20
> https://lore.kernel.org/all/20260526181700.25310-3-leandro.ribeiro@collab=
ora.com/
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/dr=
m/rockchip/rockchip_drm_vop.c
> index 0090d8ff0c79..0bc5b606f021 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1850,6 +1850,8 @@ static void vop_plane_add_properties(struct drm_pla=
ne *plane,
>  	if (flags)
>  		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
>  						   DRM_MODE_ROTATE_0 | flags);
> +	drm_plane_create_blend_mode_property(plane,
> +					     BIT(DRM_MODE_BLEND_PIXEL_NONE));
>  }
> =20
>  static int vop_create_crtc(struct vop *vop)
>=20




