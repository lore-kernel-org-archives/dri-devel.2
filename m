Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FD3C5AC67
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 18:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5061010F284;
	Thu,  6 Aug 2026 18:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Glz0rDcY";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5222910F284
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 18:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786039281; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fI5hflcGYGR78Sx2OUja5rJ3MURm64Sfve2tS6OUsW/xi/ciIhu7qlzNryG1CTddv/s5oOXEyDo2W9ZKJ6lkIG8g90e6703g3Dk8blxOgbYEmH0iQctBJBjuJ6RNNXsVMsb+pvrZfYWyfXpMcTtOhJd9EHKGQIgnxwRd/cngbvI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786039281;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VvqVDCFd/DWfRyPbMPVLFfs2uBTy+cvknpQHmfC9ir0=; 
 b=TiyvRR/BkSubqsDw4jOEgMp400km0U/+8/U8GPOzmSE1oFK56nXO2mQ5LkJyxAMpEF5lLeF5DdQvopvSHdKuze/FykRY6FWFBbMLOQdnPVs8m3GOVkPV1iv628J/YDv8Ftbr28Unh1gPiEwQcLTVfayN5BVeiHH2ePc/xVgdRTA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786039281; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=VvqVDCFd/DWfRyPbMPVLFfs2uBTy+cvknpQHmfC9ir0=;
 b=Glz0rDcYaFk9/2KrItwkKjHBTB6+FxhTaXberHy774dCEoBmZX9+ZqYuFsZQLacp
 YH8F3wg6Ef2bhrgdtkRZT2pwK1R8NifNEFYJ8E0tbEp68AO12u4bdhhGR3Z+4RheLWq
 Yat1cNeb6jvtisudhO1hnMn76UE5Q+zLvRL7JsEY=
Received: by mx.zohomail.com with SMTPS id 1786039278681438.7405188318794;
 Thu, 6 Aug 2026 11:01:18 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 1273C1808BD; Thu, 06 Aug 2026 20:01:13 +0200 (CEST)
Date: Thu, 6 Aug 2026 20:01:13 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Vinod Koul <vkoul@kernel.org>, Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-phy@lists.infradead.org
Subject: Re: [PATCH v6 3/7] drm/display: Add soft depend for
 aux-hpd-typec-dp-bridge module
Message-ID: <anTLpHm_bIPSsdvz@venus>
References: <20260804070730.68-1-kernel@airkyi.com>
 <20260804070730.68-4-kernel@airkyi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="byd6tvu63oubmgfz"
Content-Disposition: inline
In-Reply-To: <20260804070730.68-4-kernel@airkyi.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/286.26.37
X-ZohoMailClient: External
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


--byd6tvu63oubmgfz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 3/7] drm/display: Add soft depend for
 aux-hpd-typec-dp-bridge module
MIME-Version: 1.0

Hi,

On Tue, Aug 04, 2026 at 03:07:26PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>=20
> The aux-hpd-typec-dp-bridge module serves as a generic TypeC
> DisplayPort HPD bridge and is not required by any other
> module. Therefore, it will not be auto-loaded.
>=20
> Given that the drm_display_helper module houses DisplayPort-related
> helper code, add a MODULE_SOFTDEP() within it to suggest loading the
> aux-hpd-typec-dp-bridge module beforehand.
>=20
> Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Booting defconfig without manual HPD bridge registration works now :)

Greetings,

-- Sebastian

>=20
> (no changes since v6)
>=20
> ---
>  drivers/gpu/drm/display/drm_display_helper_mod.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_display_helper_mod.c b/drivers/g=
pu/drm/display/drm_display_helper_mod.c
> index d8a6e6228773..f0152d6b0b2d 100644
> --- a/drivers/gpu/drm/display/drm_display_helper_mod.c
> +++ b/drivers/gpu/drm/display/drm_display_helper_mod.c
> @@ -18,5 +18,6 @@ static void __exit drm_display_helper_module_exit(void)
>  	drm_dp_aux_dev_exit();
>  }
> =20
> +MODULE_SOFTDEP("pre: aux-hpd-typec-dp-bridge");
>  module_init(drm_display_helper_module_init);
>  module_exit(drm_display_helper_module_exit);
> --=20
> 2.53.0
>=20

--byd6tvu63oubmgfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmp0y+gACgkQ2O7X88g7
+po1aRAAoVOEYS4tq1yTJqRuHjwNUobsS9PYSr5qD/DQPC1oCG4gOnrFa6dbHHJq
rUBAu1add5nl7fsbmBqBskTWJmavNvRP/MD1gFLf3O/2kaHGMTu8J/kGohL8lK1c
ZmCWvUErRM40JPnmDgi+HyLrAfewMZS+gcxolhfB7dvbR47MWiBXV52aZ8umglFW
arbLXrh6q8/ibncTclQ4NW6D0loqyrKhSdTLNtGisYCcwJzvLmGhZdCfGEIcdHz8
B7l8pHmmcL2M5udlUV1TFp9f6PR37gMhPFF6eu1EY0nr6+6RAR6RcSXKmz7fH+2K
FgWL3Cw9o2Q851SH3VDapSyi01F5NVHiDJZrUCuCl5VylS4xJ7ZohMXVqxhi/7BF
wnQEOY92uKvJ8SZErnu/mxuyttYFn7QAh26REhCDfmOBkvguo6fskjKSqrCKpJsZ
WCijZVU3WVoiZrhhp0NISmGU0qQu/+Gl6de6bYAZYh6ohdbhgu5oFSOlHQdK8cBI
2pYuo7inWqpmh02xPRs1HFrnLQCptZMkm1VIBrIiVSam95dQqhSvRLqi7xeXu6Hu
uYJzZ3c1gh8lRBqYaXBO/lWZ81/+uUVFXgFfHTvMNRrfFklmCOvus9i43qf/Z66k
1z3ifHGU1tZVyDyyEqOXWPdvk4KwHtPgwI57NWSEgep83nQ8fnw=
=6FUg
-----END PGP SIGNATURE-----

--byd6tvu63oubmgfz--
