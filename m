Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8B606A333
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XsHPv4wR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F7D10E6FD;
	Tue, 24 Nov 2026 16:50:12 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6190E10E6FD
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:50:06 +0000 (UTC)
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:900:1d::4e])
 (Authenticated sender: pza@pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4D1282004B4;
 Tue, 24 Nov 2026 17:50:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1795539000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xUNyxepBbFqbxj/zwUONmjhAUEyk5osQzRo/USZMoIE=;
 b=XsHPv4wROfnoOR/Al1PfP2g38rWs2d8VdHYo97JJQEXtxJQT+N9uvgkIodiO5oNj6sh83H
 U5QGh7npHqJdM274F9Au9Ot4fma0AqtAjry/jfArpCu5LZpvK4yjAgSPwBAKpJszDhx7ZI
 tq5nHwrqNUdqOwdNWEVIUuhV3kq2Yrx/8m8yi9bF+kC8dw7PkngMPQVPp5sivJI2Nyl4zM
 qVMPEaynFWz55N4R5TfNj6mSgRJ9UcPlZtRdhkKOHNQD0mKVEbX3rwZU+lbngYVw+E1pa4
 2EV2Tyy+r9dmljp1UlOabvuzrcsb6Q9G1yh0bvxK8BG/O2RNSZJzfWwvU0NjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1795539000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xUNyxepBbFqbxj/zwUONmjhAUEyk5osQzRo/USZMoIE=;
 b=eW1vTA85NWp23HDiCbP0J1mb8m2Lel19Xv6D6ekUqtuU14YSbb7sY2dCrVbSRh0fdPIv7f
 +nrr/ExGSsjMy1JF2Aniv8cXiMu459RvZ4QIn1De9svO5dufohaA1URv6JumlbUbCDUSPP
 9hZ8+yfy+6TmMjbhOSVemV7fQ9oNToBaeUqKrdj5eLellXEq6hi5vT/glZ7FyrI2Vtn+/A
 eej/RP8YybOZVrzMW65gCW5zL2Ssiq7iHbO04cjLtQCwEIBcVZCOdRLfQccTgA3M6U5u5J
 5e68zrfEtPiskFTK0W2zVcQXP6dDkdbf1Bwuel+0uHhiYXXUO6twQXeKJMoIpg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795539000; a=rsa-sha256;
 cv=none;
 b=ahaXNxWTVb8qE7MA4+PnYkPbav+7Cg387gT7Qa6bu+zvF+t9SX2c2Dj5+Luv1cf/iKBoD2
 hWVdVGUb7F14T0oXeuXuDBAWzelX0ZF1NZ8ibFgFXgIcfIyNXFPvu9JPfhbw3IpEcPRsNG
 G9zEPanTyaBMjVX8h1HuyLFmIVQQFJIYSh1mKuemLyRfvEbjEcgnDUB4wWyzUd6HYJGphe
 uRamHNbrRkKGZBMIOKKS15Ay8c9n1rq2NPKX0ww1oHM9F/EM4TwO/gIeIp6Bas+BRH+wPX
 38Mk1oJN8UZ/vHpsFKSxqy22y9fGJ31oky6YZG6f12ajstjuTCywOtPA4tYkQA==
Message-ID: <831aebd692fc5ddbbd1cf57f1aad3bcc0d3f30d2.camel@pengutronix.de>
Subject: Re: [PATCH v8 16/18] drm/bridge: starfive: Add JH7110 HDMI
 controller driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart	 <Laurent.pinchart@ideasonboard.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Emil Renner
 Berthing	 <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, Heiko
 Stuebner	 <heiko@sntech.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti	
 <alex@ghiti.fr>, Dominique Belhachemi <db@domibel.de>, Andy Yan
 <andyshrk@163.com>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Yakir Yang <kuankuan.y@gmail.com>,  Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Conor Dooley <conor@kernel.org>,
 William Qiu	 <william.qiu@starfivetech.com>, Xingyu Wu
 <xingyu.wu@starfivetech.com>,  Sandy Huang <hjc@rock-chips.com>, Manivannan
 Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall	 <hello@big-grey.co.uk>, Icenowy
 Zheng <zhengxingda@iscas.ac.cn>, Chaoyi Chen	 <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <u.kleine-koenig@baylibre.com>, Cristian Ciocaltea	
 <cristian.ciocaltea@collabora.com>, Byron Stanoszek <gandalf@winds.org>, 
 Owen O'Hehir <oo.hehir@gmail.com>
Date: Tue, 24 Nov 2026 17:50:00 +0100
In-Reply-To: <20261124-jh7110-clean-send-v8-16-de92635dd857@samsung.com>
References: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
 <CGME20261124155429eucas1p1015c7cd9beec294fefdcd6900dd407f6@eucas1p1.samsung.com>
 <20261124-jh7110-clean-send-v8-16-de92635dd857@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

On Di, 2026-11-24 at 16:52 +0100, Michal Wilczynski wrote:
> Add the HDMI controller (bridge) driver for the StarFive JH7110.
>=20
[...]
>=20
> Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Tested-by: Byron Stanoszek <gandalf@winds.org>
> Tested-by: Owen O'Hehir <oo.hehir@gmail.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig            |  11 ++
>  drivers/gpu/drm/bridge/Makefile           |   1 +
>  drivers/gpu/drm/bridge/jh7110-inno-hdmi.c | 297 ++++++++++++++++++++++++=
++++++
>  3 files changed, 309 insertions(+)
>=20
[...]
> diff --git a/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c b/drivers/gpu/drm/=
bridge/jh7110-inno-hdmi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a0283f83ddc93e3e6c9e9192b=
73dca9a63f9d9ab
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
> @@ -0,0 +1,297 @@
[...]
> +
> +struct stf_inno_hdmi_controller {
> +	struct clk_bulk_data clks[CLK_CTRL_NUM];
> +	struct reset_control *tx_rst;

tx_rst is never used outside of starfive_inno_hdmi_controller_probe(),
it could be a local variable.

> +	struct phy *phy;
> +	bool enabled;
> +};
> +
[...]
> +static void stf_inno_hdmi_rst_assert(void *data)
> +{
> +	reset_control_assert(data);
> +}
> +
> +static int starfive_inno_hdmi_controller_probe(struct platform_device *p=
dev)
> +{
[...]
> +	ctrl->tx_rst =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(ctrl->tx_rst))
> +		return dev_err_probe(dev, PTR_ERR(ctrl->tx_rst), "failed to get tx res=
et\n");
> +
[...]
> +
> +	ret =3D reset_control_deassert(ctrl->tx_rst);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev, stf_inno_hdmi_rst_assert,
> +				       ctrl->tx_rst);
> +	if (ret)
> +		return ret;

This looks like it could be simplified with
devm_reset_control_get_exclusive_deasserted().

regards
Philipp
