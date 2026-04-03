Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9A4D730A9
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 06:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98FE610F294;
	Fri,  3 Apr 2026 06:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="J6vAZSbD";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C159210F294
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 06:50:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 653AD1A3114;
 Fri,  3 Apr 2026 06:50:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 28ACB603C1;
 Fri,  3 Apr 2026 06:50:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A7D55104511F1; 
 Fri,  3 Apr 2026 08:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775199036; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=LH3skQP6GTlzPiY1OJgOP3dEsK1r+TyeIvszKOXNfqQ=;
 b=J6vAZSbDIxnWOQi8efV17BuZOduHbXLOM/cyaip2+/BOx8azwkfKmwrh3WC5SW/nhZI27+
 muilFROtYLXnBnTfWz2JpWplHIWFMkBr3ZsuWBINW4kOw0frioa3KVKokUoq1BgiEWFfBb
 8Gx5td4aN+avLmfwjAquP83DmT2ktJbh4VSLunyzxuHimZrm8USMFMKZXBYosD4JPOxNyd
 eBK1PAdTG2aZicfbHH7MY2FQPipDjk9ayLJ+5lnVn3KcmMkYm/hV4No7fyPwxX2U+CI7Ce
 Kd9LXXb2i4ZALP2yNmMe9GZB1KKTPvw0fnwnmq3W0POcYxXJhMX/jG+Atk/9Ig==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 08:50:29 +0200
Message-Id: <DHJBJBQEIBVE.1MWBVWSTQ0THU@bootlin.com>
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: Fix bridge leak when host
 attach fails
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, "Manikandan
 Muralidharan" <manikandan.m@microchip.com>, "Kees Cook" <kees@kernel.org>,
 "Heiko Stuebner" <heiko@sntech.de>, "Andy Yan" <andy.yan@rock-chips.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260402210054.42074-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260402210054.42074-1-osama.abdelkader@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Osama,

On Thu Apr 2, 2026 at 11:00 PM CEST, Osama Abdelkader wrote:
> dw_mipi_dsi_host_attach() and dw_mipi_dsi2_host_attach() call
> drm_bridge_add() before pdata->host_ops->attach(). If attach fails,
> the bridge stayed registered without drm_bridge_remove(), leaking the
> bridge reference and leaving the device on the global bridge list.
>
> On failure, undo in the same order as host_detach(): for dw-mipi-dsi,
> drm_of_panel_bridge_remove() then drm_bridge_remove(); for dw-mipi-dsi2,
> drm_bridge_remove() then drm_of_panel_bridge_remove().
>
> Fixes: 90910a651123 ("drm/bridge/synopsys: dsi: add ability to have glue-=
specific attach and detach")
> Fixes: 0d6d86253fef ("drm/bridge/synopsys: Add MIPI DSI2 host controller =
bridge")
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c  | 7 ++++++-
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c | 7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/=
drm/bridge/synopsys/dw-mipi-dsi.c
> index ca4dea226f4b..ffa169c2de73 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -345,10 +345,15 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_=
host *host,
>  	if (pdata->host_ops && pdata->host_ops->attach) {
>  		ret =3D pdata->host_ops->attach(pdata->priv_data, device);
>  		if (ret < 0)
> -			return ret;
> +			goto err_remove_bridge;
>  	}
>
>  	return 0;
> +
> +err_remove_bridge:
> +	drm_of_panel_bridge_remove(host->dev->of_node, 1, 0);

It was added by a devm_action, you shouldn't remove it here. Besides,
devm_drm_of_get_bridge() might return A) a panel_bridge or B) a pointer to
another, pre-existing bridge (and the called can't know which one got
returned). drm_of_panel_bridge_remove() unconditionally removes a
panel_bridge so it's wrong in case B.

Which means the drm_of_panel_bridge_remove() in _host_detach is probably
wrong and you should look at it.

> +	drm_bridge_remove(&dsi->bridge);

This is correct, even though using devm_drm_bridge_add() instead of
drm_bridge_add() above is probably the simplest solution.

Same for the other driver in this patch.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
