Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB5FC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8CD10E652;
	Fri,  3 Jul 2026 18:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="b1Em13SV";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 335AE10E652
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=uLFc/USnoLD2hdkK6f4FbXFFpkJWctZScq6uqGjV+8Q=; b=b1Em13SVmD7Gxe4wQguf4VtJvA
 KQ6XnrbNh6sBpdgYe8/uWZOI08NhZ8Af8uTMIJ913qcXEuuywZwoht0+2Cp2JiuVaqo/jvXGNqEz9
 o3xuvt3gabxgrQ2Hd/zlHbU9G+FwcAvlbCIBtMnilDfgfwuazZupUHxAyjNPZDZR9OgFV9V1BU0vF
 ogdLlr5eH7Y0mF/ylKhy9Sg2wTYTHaX/kkrmoDB4IpWQOcfC1n706osycop0ka6lcwDvFJx98Cqap
 oINWRvxPexdduOl/EEHLOt7SC52t+SwG7wm7vSH2JXlRvDpcH0wdQx1xgv0z6V16Ohdrgp+V6VSu8
 6b86iuZw==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Diogo Silva <diogompaissilva@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, linux-arm-kernel@lists.infradead.org,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 "javierm@redhat.com" <javierm@redhat.com>
Subject: Re: [PATCH v4] drm/rockchip: Remove dependency on DRM simple helpers
Date: Fri, 03 Jul 2026 20:30:41 +0200
Message-ID: <2837071.mvXUDI8C0e@phil>
In-Reply-To: <CAJpoHp489qKfkfLOX-XPLpOWo86gibZB=NM_dXPbv0yDGmxysg@mail.gmail.com>
References: <20260608124018.480365-2-diogompaissilva@gmail.com>
 <CAJpoHp6DnspnA0rirGb6E=A9wCS3eaDn=eFaqmae98Q+39b1PA@mail.gmail.com>
 <CAJpoHp489qKfkfLOX-XPLpOWo86gibZB=NM_dXPbv0yDGmxysg@mail.gmail.com>
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

Hi Diogo,

Am Donnerstag, 2. Juli 2026, 22:18:58 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Diogo Silva:
> Simple KMS helper are deprecated since they only add an intermediate
> layer between drivers and the atomic modesetting.
> This patch removes the drm_simple_encoder_init() helper usage in the
> rockchip drivers by open coding it and using the encoder atomic helpers
> directly. This is a step to eventually get rid of this simple KMS helper,
> once all drivers that use it have been converted.
>=20
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
> ---
> v4:
>  - improved commit message based on Javier Canillas feedback
>=20
> v3:
>  - rebase on drm-tip tree
>=20
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c  | 9 ++++++---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c           | 9 ++++++---
>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c  | 9 +++++++--
>  drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c | 8 ++++++--
>  drivers/gpu/drm/rockchip/dw_dp-rockchip.c        | 1 -
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c      | 1 -
>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c   | 1 -
>  drivers/gpu/drm/rockchip/rk3066_hdmi.c           | 8 ++++++--
>  drivers/gpu/drm/rockchip/rockchip_lvds.c         | 9 +++++++--
>  drivers/gpu/drm/rockchip/rockchip_rgb.c          | 8 ++++++--
>  10 files changed, 44 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 776954c7d052..46c245e35d21 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -30,7 +30,6 @@
>  #include <drm/drm_of.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>=20
>  #include "rockchip_drm_drv.h"
>=20
> @@ -303,6 +302,10 @@ rockchip_dp_drm_encoder_atomic_check(struct
> drm_encoder *encoder,
>         return 0;

the tool you're using to send patches seems broken.
In the patch all the places that should be tabs are replaced as spaces.
This of course does not apply.

Ideally use git send-email or b4 for sending patches.

Also, please don't send new versions as replies to previous ones.
Tooling can get confused by this, so please start a new thread for
the next version.

Thanks
Heiko



