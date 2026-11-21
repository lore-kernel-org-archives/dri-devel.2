Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35B7606A32A
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=zfxowsvl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B94810E010;
	Sat, 21 Nov 2026 13:33:44 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC3E310E010
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=EJoKIhVOzRTnCw3xv/1juimw9ds0gPz48EALk+RpXY0=; b=zfxowsvl0narWz7XL1vtgZauEK
 BeLrteWBesDZMjmKbHncnpM+0lnUPnWydEKcvIeQn5xgTESNLgleJn9C1SYHBWARI12RGqOM5sPUx
 2blof2VIlx/5AfA+Z3Z8RL/gtwH+GLS7Vi/lQzpkXCewoD5gSHMcTwr2KGkMNkA22x5rUXSe3ckDV
 u47yJpyTjikF6ObpU2At8jVp6q3IzaIwe1wmyhfzSGK32698Gs2/ESWyLTkyZsW1y0Ex2QgkaofcK
 8dKRJTqabwMvTB4RHz5QJoSdOTWL5VlLGReRMpF3Ga6Oqnvxj1f97ifIjaUM3HVsMmctRVSyZgjMN
 1RU8AIdQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sandy Huang <hjc@rock-chips.com>, ZhuXiangyu <1194781887@qq.com>
Cc: Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 ZhuXiangyu <1194781887@qq.com>
Subject: Re: [PATCH] drm/phy: rockchip: fix RK3506 DSI low-power command
 handling
Date: Sat, 21 Nov 2026 14:33:23 +0100
Message-ID: <I1iUkWzgR2mQ2vL4ooyigA@sntech.de>
In-Reply-To: <tencent_F495CC22423581B98A12990F93C04F33CB06@qq.com>
References: <tencent_F495CC22423581B98A12990F93C04F33CB06@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Samstag, 21. November 2026, 09:05:55 Mitteleurop=C3=A4ische Normalzeit s=
chrieb ZhuXiangyu:
> Two bugs keep the RK3506 MIPI-DSI link from initialising a panel: the
> DPHY programs the wrong high-speed timing entry, and the PHY data lanes
> are never enabled in the GRF.
>=20
> 1. phy-rockchip-inno-dsidphy picks the wrong HS timing entry
>=20
>    The 1.5 GHz inno DSI PHY timing table stores its rates in Mbps while
>    the other tables and the lookup use Hz. The mode enable code compares
>    inno->pll.rate in Hz (e.g. 372000000) against timings[].rate in Mbps
>    (e.g. 400), so the comparison never matches. The loop runs to the end
>    and the last, fastest entry is used, which programs a TLPX/LPX
>    counter that is far too large. The panel then cannot decode the
>    low-power DCS commands and stays in sleep mode, so the display stays
>    black even though the LP packets are visible on the data lane.
>=20
>    Convert the 1.5 GHz timing table rates to Hz so that the lookup
>    selects the correct entry.
>=20
> 2. The RK3506 DSI GRF lane enable bits are never written
>=20
>    rk3506_chip_data only clears the turnaround / force-stop fields, so
>    the PHY data lanes stay disabled unless the boot loader happens to
>    enable them. Program RK3506_DSI_PHY_ENABLE_LANE0/1 as well.
>=20
> Tested on the RK3506B JerryTech board: the panel now receives the init
> sequence over LP and the framebuffer console is visible.
>=20
> Fixes: 785a9d5bb145 ("phy: rockchip: inno-dsidphy: Add support for rk3506=
")
> Fixes: cabeacc7eadc ("drm/rockchip: dsi: Add support for rk3506")
> Signed-off-by: ZhuXiangyu <1194781887@qq.com>

don't mix subsystems in patch submission please.

All the process issues, Krzysztof pointed out in another thread still
apply too.


Heiko



