Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F46606A334
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wD5zPBe6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B3D1121D2;
	Thu, 12 Nov 2026 15:39:27 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 405B81121C3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:39:21 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id AF2AB4E41593;
 Thu, 12 Nov 2026 15:39:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7BD705FF85;
 Thu, 12 Nov 2026 15:39:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8C23B11BC12B5; Thu, 12 Nov 2026 16:39:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794497954; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=JNnYp35o/nf6vmTuNBxPUZDLjYmnLfH8FNhphGFUILw=;
 b=wD5zPBe6kaum/BhnlH6o+LaQ7BAShR19kjnPomalW1TpQGj6uPuqzef7EcWSGlDS1OF8SH
 DSTpRZNPSr6dZhWViBlT+EdYHo/E2WR0ink4eAqmHj8FvCWiZztJ7R+X9Mxi9SAh75cIfW
 9ndpaN6jBbDTTQ6PBJ5Y3SUlTGmj99QYHcxyy4vsV5txUrG6ak/t7JCioBN+gM3RkPDBn8
 aaK7KGVaPok38beWMpECPkVhTserR9yBDYI0SwAlrvXJM8LFO+qk9Tv6SJJVrJA2HMa3Lo
 xkBkqyucxvXaR2FllFwFLk2SWwCN4yi4rZvDSaRP0v1dgw0sLMDEO5w4PAAqgA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 16:39:06 +0100
Message-Id: <DMTCFJVH99S4.27AWO8PN3ZPK7@bootlin.com>
Cc: "Damon Ding" <damon.ding@rock-chips.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>
To: "Jun Yan" <jerrysteve1101@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Heiko Stuebner"
 <heiko@sntech.de>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3] drm/bridge: analogix_dp: use devm_phy_optional_get()
 for the DP PHY
X-Mailer: aerc 0.22.0
References: <20261110023721.2014061-1-jerrysteve1101@gmail.com>
In-Reply-To: <20261110023721.2014061-1-jerrysteve1101@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

On Tue Nov 10, 2026 at 3:37 AM CET, Jun Yan wrote:
> The DP PHY is optional: the Rockchip RK3399 eDP controller (used as the
> internal eDP port) has no separate PHY device and relies on its built-in
> PHY, which is programmed directly through the GRF registers, so its DT
> node carries no "phys"/"phy-names" property.
>
> Requesting the PHY with devm_phy_get() therefore returns -ENODEV (or
> -ENOSYS when CONFIG_GENERIC_PHY is disabled) and the driver logs a
> misleading "no DP phy configured" error at probe time before falling back
> to a NULL phy.
>
> Use devm_phy_optional_get() instead, which returns NULL when the PHY is
> absent and otherwise behaves identically, and drop the manual -ENODEV/
> -ENOSYS handling. This also removes the spurious error message.
>
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
> ---
> Changes in v3:
>   - Add missing changelog entries and reference links
>   - Link to v2: https://lore.kernel.org/dri-devel/20261013134659.335829-1=
-jerrysteve1101@gmail.com/
>
> Changes in v2:
>   - Added comments to explain the changes made.
>   - Link to v1: https://lore.kernel.org/dri-devel/20260924020417.868588-1=
-jerrysteve1101@gmail.com/
>
>  .../drm/bridge/analogix/analogix_dp_core.c    | 22 ++++++-------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 6df6963740d2..637b1bff0f6c 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1426,21 +1426,13 @@ analogix_dp_probe(struct device *dev, struct anal=
ogix_dp_plat_data *plat_data)
>  	if (ret)
>  		return ERR_PTR(ret);
>
> -	dp->phy =3D devm_phy_get(dp->dev, "dp");
> -	if (IS_ERR(dp->phy)) {
> -		dev_err(dp->dev, "no DP phy configured\n");
> -		ret =3D PTR_ERR(dp->phy);
> -		if (ret) {
> -			/*
> -			 * phy itself is not enabled, so we can move forward
> -			 * assigning NULL to phy pointer.
> -			 */
> -			if (ret =3D=3D -ENOSYS || ret =3D=3D -ENODEV)
> -				dp->phy =3D NULL;
> -			else
> -				return ERR_PTR(ret);
> -		}
> -	}
> +	/*
> +	 * RK3288/RK3399 use Analogix DP controller built-in PHY,
> +	 * no extra PHY configuration is required.
> +	 */
> +	dp->phy =3D devm_phy_optional_get(dp->dev, "dp");
> +	if (IS_ERR(dp->phy))
> +		return ERR_CAST(dp->phy);

The original code ignbores -ENOSYS, devm_phy_optional_get() does not. So,
either -ENOSYS was just impossible, or this patch potentially changes the
behaviour.

Can you elaborate on that?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
