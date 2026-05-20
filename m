Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F63CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 12:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138F110E12D;
	Wed, 20 May 2026 12:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="hLz4TQ3h";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C321B10E12D
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=HHt+TFrYjMfuRQl1MVKyeuc2S+ijjqDSWSoLDdYR0l8=; b=hLz4TQ3hna8ofoDEFHiDj/e1LS
 TrhQQrdvYA6zU+UWTod7JWwPpx8fc+Aa1/Ikw/aND2X2DZuFwACPyNOrvmlMYlQJORJVfRNcmrE5I
 duuSidF2B3I20C4cJ4iXerzImbtTAxmYMg69HD1RCE6yeKssaqEQ0CNw6QKgOKd7ezQwXZjUj93yD
 ng4K2bMg9LlcrouWgu3osCSQpFb2c2qeXP5QTEyInpmTAm3edF4wBqrF3chd1UmuPhxN+lbr2/4Md
 aLFFcpB5bHSQNHwzAUgc6dpBC/kq9LHiBuHc+vjj4Z4Bg/EI5CsYh8yKPYIL27NSkdL5rnKQaTyVs
 jwNC7ghg==;
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH 1/8] drm/display: hdmi: Add common TMDS character rate
 constants
Date: Wed, 20 May 2026 14:58:04 +0200
Message-ID: <5267693.KgjxqYA5nG@phil>
In-Reply-To: <20260519144712.1418302-2-javierm@redhat.com>
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-2-javierm@redhat.com>
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

Am Dienstag, 19. Mai 2026, 16:46:57 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Javier Martinez Canillas:
> Several DRM drivers already define their own constants for minimum and
> maximum TMDS character rates.
>=20
> By defining common rate constants in a shared header, drivers can just use
> them instead of having driver local define macros or use magic numbers.
>=20
> The values defined in the <drm/display/drm_hdmi_helper.h> header correspo=
nd
> to maximum TMDS character rates defined by each HDMI specification versio=
n:
>=20
>   - DRM_HDMI_TMDS_CHAR_RATE_MIN:    25 MHz (minimum for all versions)
>   - DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0: 165 MHz (HDMI 1.0 maximum)
>   - DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3: 340 MHz (HDMI 1.3 maximum)
>   - DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0: 600 MHz (HDMI 2.0 maximum)
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

checked against the rate definitions, and of course they match :-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>=20
>  include/drm/display/drm_hdmi_helper.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/include/drm/display/drm_hdmi_helper.h b/include/drm/display/=
drm_hdmi_helper.h
> index 9c31ed90516b..0ee246ff82e0 100644
> --- a/include/drm/display/drm_hdmi_helper.h
> +++ b/include/drm/display/drm_hdmi_helper.h
> @@ -5,6 +5,12 @@
> =20
>  #include <linux/hdmi.h>
> =20
> +/* HDMI spec TMDS character rate limits (in Hz) */
> +#define DRM_HDMI_TMDS_CHAR_RATE_MIN	25000000
> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0	165000000
> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3	340000000
> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0	600000000
> +
>  struct drm_connector;
>  struct drm_connector_state;
>  struct drm_display_mode;
>=20




