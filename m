Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7676CF531F8
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 07:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B009410E584;
	Tue, 14 Apr 2026 07:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Roj+tOiW";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D2C10E584
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 07:28:29 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 4E84F1A3297;
 Tue, 14 Apr 2026 07:28:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1DCB65FFBB;
 Tue, 14 Apr 2026 07:28:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AA77210450D00; 
 Tue, 14 Apr 2026 09:28:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776151707; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ne2J5sJS+jQrbMgGTwn3xAIEeusKwHsxc1BQLCxTHB4=;
 b=Roj+tOiWwpFQfh5dv/aqO7ejIqwfUdSTnJz5sEEPegqa8inbSYGCSxHGgghp5/MPNQoMof
 rrs159Hu2gQDPJqAteQqN/OG3ZB26MaNIQDr1wPFRyyM9lQUz9mU5bM9fPJd2IHicUXrtP
 +Q3Kpypr1uKgqWxrcb9AXsGcGUnvDFn9r7o7R+iD80C2/kw94Aif+eV2HwAgJCjeFRE8Qd
 FAuJ3nhsQ2KbbuauyxtUa6XQiqE4NfSjcUeN9RtjftxiVKwyCjdRmLG65VBzxdbYHESfbc
 BMy/zAVDcDieuMEwntndTlN8VGd2gCG3ihF46h3SCUuN5Y6Q36BltGG1IXF+kA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 09:28:23 +0200
Message-Id: <DHSP8C1NE87A.3CRQ1MKI3DAHJ@bootlin.com>
Subject: Re: [PATCH] drm/bridge: chipone-icn6211: remove bridge when
 chipone_dsi_host_attach fails
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260410195537.295119-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260410195537.295119-1-osama.abdelkader@gmail.com>
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

On Fri Apr 10, 2026 at 9:55 PM CEST, Osama Abdelkader wrote:
> when chipone_dsi_host_attach fails in chipone_i2c_probe remove drm
> bridge before return
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/bridge/chipone-icn6211.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/b=
ridge/chipone-icn6211.c
> index 814713c5bea9..5bee10c64265 100644
> --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> @@ -760,7 +760,10 @@ static int chipone_i2c_probe(struct i2c_client *clie=
nt)
>
>  	drm_bridge_add(&icn->bridge);
>
> -	return chipone_dsi_host_attach(icn);
> +	ret =3D chipone_dsi_host_attach(icn);
> +	if (ret)
> +		drm_bridge_remove(&icn->bridge);
> +	return ret;
>  }

You can simply switch to devm_drm_bridge_add().

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
