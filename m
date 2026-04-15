Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F6DF419B9
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B7D10E1EA;
	Wed, 15 Apr 2026 13:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VSRIQxVA";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3643F10E6E0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 13:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=lhottTYc7RM1jdLqnyonzT5k/dg3DnW974HgNK0Q368=; b=VSRIQxVA2pT1LTIND1TMdSWd80
 ic6mtIRWFAj5GY4vG412A2Q7V8ELw8+w6A4EarnxgZFBy+vXpO4YOs4AcdDbTGKmS1yuIh+x7ueoQ
 AeD4aDl3Hz6an8CXI4LdkClsyqdjJIjDvW5nU4HY0sQCmiVkBc1j+Lot/SWUM/Ig1xJ5FcTU3BpDq
 q9AsIYAnD/Y52SedKPvlfiTzxXXQYhsiCSdcEwaK0f3bDpkWQg53bh3XyYzeUg/kegWRC8dWdLfhX
 5VGaCKVq6K9AaM0jy+pZ+7KXAXis3xUqxRL4Z5t6zSbh4oj/G1LiAoaE8OC0dDPIUz/XKNrIqM3XK
 IU0UAxng==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wD0eB-000B8k-1X; Wed, 15 Apr 2026 15:51:15 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wD0eA-000OuZ-05; Wed, 15 Apr 2026 15:51:14 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 marex@denx.de, valentin@compulab.co.il, luca.ceresoli@bootlin.com,
 philippe.schenker@toradex.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
Date: Wed, 15 Apr 2026 15:51:13 +0200
Message-ID: <6721341.e9J7NaK4W3@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260412053811.662461-2-tessolveupstream@gmail.com>
References: <20260412053811.662461-1-tessolveupstream@gmail.com>
 <20260412053811.662461-2-tessolveupstream@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/27972/Wed Apr 15 08:24:27 2026)
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

Am Sonntag, 12. April 2026, 07:38:11 CEST schrieb Sudarshan Shetty:
> The current DSI mode configuration enables VIDEO_BURST and disables
> horizontal front porch (HFP) and back porch (HBP) transmission using
> MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP.
>=20
> However, the SN65DSI83/84 bridge relies on receiving full horizontal
> timing information over DSI in order to correctly reconstruct the LVDS
> output timings. When HFP and HBP are not transmitted, the bridge cannot
> recreate the required timing parameters, resulting in unstable or
> missing display output on some panels.
>=20
> Additionally, while burst mode is supported by the hardware, its use
> depends on continuous clock behavior from the DSI host. In practice,
> burst mode may introduce instability depending on the host controller
> implementation, as the DSI link may transition to low-power state
> between bursts.
>=20
> In testing, removing burst mode and ensuring full horizontal timing
> transmission results in stable LVDS output across affected panels.
>=20
> Update the DSI mode flags to:
>   - Drop MIPI_DSI_MODE_VIDEO_BURST
>   - Drop MIPI_DSI_MODE_VIDEO_NO_HFP
>   - Drop MIPI_DSI_MODE_VIDEO_NO_HBP
>=20
> This aligns with common system configurations where non-burst mode is
> preferred and full timing information is transmitted over DSI.
>=20
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>

Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com># imx8mq, imx8m=
m, imx8mm

on both tm070jvhg33 and g133han01 displays.

Best regards
Alexander

> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index fef6bca3273f..9d51dc2b75bc 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -976,9 +976,8 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ct=
x)
> =20
>  	dsi->lanes =3D dsi_lanes;
>  	dsi->format =3D MIPI_DSI_FMT_RGB888;
> -	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> -			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
> -			  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
> +	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HSA |
> +			  MIPI_DSI_MODE_NO_EOT_PACKET;
> =20
>  	ret =3D devm_mipi_dsi_attach(dev, dsi);
>  	if (ret < 0) {
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


