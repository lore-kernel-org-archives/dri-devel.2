Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB411CD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 18:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E4E311297F;
	Sat, 30 May 2026 18:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="F+2f5duo";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50B911297F
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1780167110; x=1780426310;
 bh=6hqDjImuAem/6OD61cXZG6OTmI0pwB62MXq+JBsU1ro=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=F+2f5duosDoNeeas6k96BIJQWCi40bwxVBoqIt02focXKYWocMzPVIyh7+ejcgi+8
 MVBlI2w7lKe2Ez6ePyHcqv2ZDMOl+8yIwI1xmh7lyVNkLfDTJDqHlwfbbKDbrTVXXm
 INOHt+hbL7n3xD7tLa/1EJVG3M40uZIXrWWwpaulQofj+Lldy2H3dvOyjB9K3+sIol
 6OTtluybHinTDEgw6a8F7TURF9B6Rti2rxFGKgP8jEEH+MDLk4qelyP3xKJRCVr+dg
 8WINYj7kKvSBxo7cd7ADgXzCQPYUx8R7KlngJ3pe5bjqKuXNldHpCklMCViLr8ECtM
 I3I28Sz/5b5KQ==
Date: Sat, 30 May 2026 18:51:42 +0000
To: Sudarshan Shetty <tessolveupstream@gmail.com>, luca.ceresoli@bootlin.com
From: Sean Nyekjaer <sean@geanix.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, alexander.stein@ew.tq-group.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] drm: bridge: ti-sn65dsi83: Disable video burst
 mode for LVDS stability
Message-ID: <ahsxWhXMhzbAj_3G@Seans-MacBook-Pro.local>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: aa8b75addb1c0b0e117d1a5c77bbeb83e9192027
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Luca,

On Wed, May 27, 2026 at 02:27:36PM +0100, Sudarshan Shetty wrote:
> The current DSI configuration enables MIPI_DSI_MODE_VIDEO_BURST.
> while burst mode is supported by the hardware, its use
> depends on continuous clock behavior from the DSI host. In practice,
> burst mode may introduce instability depending on the host controller
> implementation, as the DSI link may transition to low-power state
> between bursts.
>=20
> Testing showed improved display stability when using non-burst mode on
> affected panels.
>=20
> Remove MIPI_DSI_MODE_VIDEO_BURST and use non-burst video mode.
>=20

We briefly talked about this at Embedded Recipes
I promised to sent a link:
https://lore.kernel.org/all/E35054BA-FBE5-4CEE-905C-1F5D20140590@geanix.com=
/

When burst mode is enabled, the LVDS clock gets way to high for my
panel. I don't know if it's the DSI controller in the STM32MP1 or
something not supported on the TI side.

We have been running with this fix for 2 years :)

> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>

Tested-by: Sean Nyekjaer <sean@geanix.com>

> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index c03ff1ea9df8..6b5a6019c30d 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -976,8 +976,8 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ct=
x)
> =20
>  =09dsi->lanes =3D dsi_lanes;
>  =09dsi->format =3D MIPI_DSI_FMT_RGB888;
> -=09dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> -=09=09=09  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
> +=09dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HSA =
|
> +=09=09=09  MIPI_DSI_MODE_NO_EOT_PACKET;
> =20
>  =09ret =3D devm_mipi_dsi_attach(dev, dsi);
>  =09if (ret < 0) {
> --=20
> 2.34.1
>=20

