Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2F6CD6E6B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF3911A529;
	Fri,  5 Jun 2026 07:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="QSmN29ia";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BCB11A529
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 07:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=h0TITDqHiKdmqJiwNGqI/TMrkaNhKi12bHFtLKztbuQ=; b=QSmN29iayXdZogz7/akqa7Qvi5
 6sJBP6ZDiEc6Yiguv0pHSe0UJ7bmerIjwAS0CHk9upxH8qarHjOZXC44Xjm4en8HNXHscZ0GjPrX6
 71QS5YYR4JbDDGrxuEd+N2/7KD8ZMe4hmCjpTKN1yxiFPXcNIfpbQc0g85rZ6HohmyWg7uYCQnO82
 wQyyz+aIe0YnbmMqhj6FOBTZ2hww12PyzthWu7cTV1Y25IDt/rz3Tl2rw6Z4S/MbCKk87yqua2xb9
 7oAy0hQxBFLmj3zn//kjZKoPZW0k75CtjBpUxOt1qxA+HZkoMSVbqjPBNDlWjk+4idHkeW5CNPrF7
 J5+2wf9A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wVPKt-000GWl-0c; Fri, 05 Jun 2026 09:51:23 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wVPKs-000DLF-29; Fri, 05 Jun 2026 09:51:22 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
 Guangshuo Li <lgs201920130244@gmail.com>
Subject: Re: [PATCH] drm/bridge: samsung-dsim: fix TE GPIO ownership
Date: Fri, 05 Jun 2026 09:51:21 +0200
Message-ID: <7255371.MhkbZ0Pkbq@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260604114604.1422184-1-lgs201920130244@gmail.com>
References: <20260604114604.1422184-1-lgs201920130244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/28022/Fri Jun  5 08:25:05 2026)
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

Am Donnerstag, 4. Juni 2026, 13:46:04 CEST schrieb Guangshuo Li:
> samsung_dsim_register_te_irq() acquires the TE GPIO with
> devm_gpiod_get_optional(), but the descriptor is released manually in the
> request_threaded_irq() error path and in samsung_dsim_unregister_te_irq().
> The devres entry remains registered and will release the same descriptor
> again when the device is detached.
>=20
> Use the non-managed gpiod_get_optional() helper instead, so the GPIO
> descriptor lifetime matches the existing manual cleanup paths. Also clear
> dsi->te_gpio after each gpiod_put() to avoid leaving a stale descriptor
> pointer around if the host is attached again.

Shouldn't you use devm_gpiod_put instead of gpiod_put?

Best regards,
Alexander

> Fixes: e7447128ca4a ("drm: bridge: Generalize Exynos-DSI driver into a Sa=
msung DSIM bridge")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index c3eb437ef1b0..2299b7dc0c04 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1862,7 +1862,7 @@ static int samsung_dsim_register_te_irq(struct sams=
ung_dsim *dsi, struct device
>  	int te_gpio_irq;
>  	int ret;
> =20
> -	dsi->te_gpio =3D devm_gpiod_get_optional(dev, "te", GPIOD_IN);
> +	dsi->te_gpio =3D gpiod_get_optional(dev, "te", GPIOD_IN);
>  	if (!dsi->te_gpio)
>  		return 0;
>  	else if (IS_ERR(dsi->te_gpio))
> @@ -1875,6 +1875,7 @@ static int samsung_dsim_register_te_irq(struct sams=
ung_dsim *dsi, struct device
>  	if (ret) {
>  		dev_err(dsi->dev, "request interrupt failed with %d\n", ret);
>  		gpiod_put(dsi->te_gpio);
> +		dsi->te_gpio =3D NULL;
>  		return ret;
>  	}
> =20
> @@ -1886,6 +1887,7 @@ static void samsung_dsim_unregister_te_irq(struct s=
amsung_dsim *dsi)
>  	if (dsi->te_gpio) {
>  		free_irq(gpiod_to_irq(dsi->te_gpio), dsi);
>  		gpiod_put(dsi->te_gpio);
> +		dsi->te_gpio =3D NULL;
>  	}
>  }
> =20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


