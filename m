Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B819C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627E910E5FB;
	Tue, 22 Sep 2026 18:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="mk6JemS/";
	dkim-atps=neutral
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Tue, 22 Sep 2026 18:17:24 UTC
Received: from mta1.migadu.com (out-42.mta1.migadu.com [95.215.58.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896C210E5FB
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 18:17:24 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=2yklJXh1jDhjZosVDlDIrp4aXiVIg5PtSRAofTMK6Zo=; 
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790101042; v=1; x=1790705842;
 b=mk6JemS/cGZl63P24vGGZSuQWkZXEMI9cU+3oFqEyLxvA9bydhN2xQuraI99lWj9Yic3GWML
 D7sslXlMxyEX5HjtaLnv5JM9NCdFoGUglIvb+ICd7u5lgHsVFQvMWCYna4HazkhHP6efov54+mR
 ajWyJZlA4QQVxMumrJHAIJwf0AtrtenH+DCik+7M7L/DoW5Y0xLIlXzh/y8FdfJ/778AiVeACv4
 39ryS5Sun4nvQ1blRgFKFiXY4V5adIt8YlZSCARoJYY2bBdAES78lwMiRY36zE2csIC90qq2L3w
 xR6MJsW9O3SlvRv+Yih4RyhXuf+ZiPuHSw5SsIkXltHWQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id ab83d78d1a42a1f1;
 Tue, 22 Sep 2026 18:11:18 +0000
X-Mizu-Trace-ID: ab83d78d1a42a1f1
X-Migadu-Flow: FLOW_OUT
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 20:11:13 +0200
Message-Id: <DLM1Q8SJMXVA.5DQFQM21KJ82@cknow-tech.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-rockchip@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm: rockchip: add drm_plane_create_blend_mode_property
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Johan Jonker" <jbx6244@gmail.com>, "Sandy Huang" <hjc@rock-chips.com>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Andy Yan"
 <andy.yan@rock-chips.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0-24-g39041fd9f179
References: <20260909-blend-v2-1-37e27af4faee@gmail.com>
In-Reply-To: <20260909-blend-v2-1-37e27af4faee@gmail.com>
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

On Wed Sep 9, 2026 at 11:20 PM CEST, Johan Jonker wrote:
> A validate_blend_mode_for_alpha_formats() function was added that
> fills the kernel log with warnings for Rockchip VOP version 1 SoCs.
> Add a drm_plane_create_blend_mode_property() function as fix.
> VOP version 1 doesn't support blending with a pixel alpha background
> layer, only with a constant alpha. Advertise blending capability with
> DRM_MODE_BLEND_PIXEL_NONE.

On a 7.3-rc1 kernel without this patch, I saw the following:

Rock64 (RK3328):
```sh
root@rock64-test:~# dmesg --level 4 | grep PLANE
[    7.567004] rockchip-drm display-subsystem: [drm] [PLANE:35:plane-0] pix=
el format with alpha exposed but blend mode not setup. Please fix.
[    7.567083] rockchip-drm display-subsystem: [drm] [PLANE:38:plane-1] pix=
el format with alpha exposed but blend mode not setup. Please fix.
[    7.567132] rockchip-drm display-subsystem: [drm] [PLANE:42:plane-2] pix=
el format with alpha exposed but blend mode not setup. Please fix.
```

RockPro64 (RK3399):
```sh
root@rockpro64:~# dmesg --level 4 | grep PLANE
[    5.695597] rockchip-drm display-subsystem: [drm] [PLANE:35:plane-0] pix=
el format with alpha exposed but blend mode not setup. Please fix.
[    5.695636] rockchip-drm display-subsystem: [drm] [PLANE:38:plane-1] pix=
el format with alpha exposed but blend mode not setup. Please fix.
[    5.695665] rockchip-drm display-subsystem: [drm] [PLANE:42:plane-2] pix=
el format with alpha exposed but blend mode not setup. Please fix.
[    5.695692] rockchip-drm display-subsystem: [drm] [PLANE:45:plane-3] pix=
el format with alpha exposed but blend mode not setup. Please fix.
[    5.695718] rockchip-drm display-subsystem: [drm] [PLANE:48:plane-4] pix=
el format with alpha exposed but blend mode not setup. Please fix.
[    5.695745] rockchip-drm display-subsystem: [drm] [PLANE:51:plane-5] pix=
el format with alpha exposed but blend mode not setup. Please fix.
```

And on a (7.3-rc4) kernel *with* this patch, those warnings were gone.
Thanks! Feel free to include

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # Rock64, RockPro64

Cheers,
  Diederik

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>
> Changed V2:
> Add comment line
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 ++
>  1 file changed, 2 insertions(+)
>
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
>
> ---
> base-commit: 9d80aa4617b32f5054c5aa471d06b66704854935
> change-id: 20260909-blend-c89d2c9f6984
>
> Best regards,


