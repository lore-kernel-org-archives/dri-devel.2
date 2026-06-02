Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997DFCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 15:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA69510F204;
	Tue,  2 Jun 2026 15:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="gQeJJRTQ";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3206510F204
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=dJzkqUtVg54mBprGrZtQSWQkiwWBq/0aCh5qUpxBt0w=; b=gQeJJRTQB6Dg11khGhrcVXu63F
 d0RG0hYUA6OciYzZiAle8Fnk87FXjgvhJBxnKlh7OVQ8c5BFSFH50OjDwxEm0v5Oug2LoGOoRAff/
 /BapZxdQro6zjQWEnrok3Xu91ao6JlxxmJZz9CcitdpyRD36ZatxqGwtqIuy5NiIdJxF5qzzjL0Z1
 bzQC0bqJF2BmWHIrknloT/w32TAFEaogrC/i6gpK3fln2NNr6/Rq6vTwkOJHVpTppKr1oZfWlcYZL
 ZQtJ0sxju1t7J37uuRu5jy9JGmd8bNvDXojYEQYEQjpIFKhPcD0u2IAKsHNmfNVSCIhmil9gewqIR
 0ZiXPtIA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 Maxime Ripard <mripard@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 62/76] drm/rockchip: cdn-dp: Switch to atomic_create_state
Date: Tue, 02 Jun 2026 17:02:37 +0200
Message-ID: <4650339.9PvXe5no7K@phil>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-62-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-62-875d828d31bc@kernel.org>
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

Am Samstag, 30. Mai 2026, 16:00:07 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Maxime Ripard:
> The drm_bridge_funcs.atomic_reset callback and its
> drm_atomic_helper_bridge_reset() helper are deprecated.
>=20
> Switch to the atomic_create_state callback and its
> drm_atomic_helper_bridge_create_state() counterpart.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

having looked at the first parts of the series adding
the new functionality, this change looks good:

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

>=20
> ---
> To: Sandy Huang <hjc@rock-chips.com>
> To: "Heiko St=C3=BCbner" <heiko@sntech.de>
> To: Andy Yan <andy.yan@rock-chips.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/roc=
kchip/cdn-dp-core.c
> index 190cce9530c8..e159e1627f3c 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -823,11 +823,11 @@ static int cdn_dp_audio_mute_stream(struct drm_brid=
ge *bridge,
>  }
> =20
>  static const struct drm_bridge_funcs cdn_dp_bridge_funcs =3D {
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>  	.detect =3D cdn_dp_bridge_detect,
>  	.edid_read =3D cdn_dp_bridge_edid_read,
>  	.atomic_enable =3D cdn_dp_bridge_atomic_enable,
>  	.atomic_disable =3D cdn_dp_bridge_atomic_disable,
>  	.mode_valid =3D cdn_dp_bridge_mode_valid,
>=20
>=20




