Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57CBC61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFDDE10E1D6;
	Fri,  4 Sep 2026 14:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YixLadOF";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AB7A10E1D6
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 14:48:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id F0D851A19AB;
 Fri,  4 Sep 2026 14:48:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B55026057F;
 Fri,  4 Sep 2026 14:48:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 19E5F11C7AE8F; 
 Fri,  4 Sep 2026 16:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788533281; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=WG6jc4T+xg/xDGKYL/X/qc4fpUcaXjV/4duU3TUqWFI=;
 b=YixLadOFPb7oaSYwtBDqAsSPkqXYHNAWlrv35SKjptFimjAOxY3yHxoNmra9+TbFFlDjzC
 PqFJIvDHQur8vg/p8D5gBEP2v68DZ+NYnT3NLKeeEFnMkZcJwTj9oPNn5M19caNmMtnzMx
 kLdjrvLzWVgRgSHfMhpg1J8aG3TQT2ElDp19KyEutDa15Y3yojmYZhE8YK+vIrop5OFlqE
 5OE2Hyp86aWILt4Za0M5a2Veh7kKxaqBaCtGWkwCGw0SbAuAaCZ330O3C8uNCDmIBKr1AM
 7BgDyiy4YTlId54+JpOsJ3kMcbsYOosivJ2+6RtJOO5JFp4nbDxmDD27GjvPhw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 16:47:51 +0200
Message-Id: <DL6M4Q7I9197.2TQXYZ3CANZHI@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge: samsung-dsim: fix TE GPIO lifetime for
 host attach
Cc: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
 <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Li
 Youhong" <liyouhong@kylinos.cn>
To: "Li Youhong" <dayou5941@163.com>, <inki.dae@samsung.com>,
 <jagan@amarulasolutions.com>, <m.szyprowski@samsung.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260904014958.1572918-1-dayou5941@163.com>
In-Reply-To: <20260904014958.1572918-1-dayou5941@163.com>
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

Hello Li,

On Fri Sep 4, 2026 at 3:49 AM CEST, Li Youhong wrote:
> From: Li Youhong <liyouhong@kylinos.cn>
>
> When the Exynos DSI driver was generalized into samsung-dsim, the TE
> GPIO acquisition was switched from gpiod_get_optional() to
> devm_gpiod_get_optional() while keeping the matching gpiod_put() calls.
> That combination is wrong for a managed descriptor.
>
> However, dropping the puts and keeping the managed get is also wrong:
> samsung_dsim_register_te_irq() runs from the DSI host attach callback,
> and host detach/reattach can happen without destroying the device that
> owns the managed action. A second attach would then request the GPIO
> again without having released it.
>
> Switch back to a non-managed gpiod_get_optional() and keep the explicit
> gpiod_put() on the request_irq() error path and in
> samsung_dsim_unregister_te_irq().
>
> Fixes: e7447128ca4a ("drm: bridge: Generalize Exynos-DSI driver into a Sa=
msung DSIM bridge")
> Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---
> v2:
> - Prefer non-devm gpiod_get_optional() and keep gpiod_put(), because TE
>   GPIO is acquired in host attach and must be released on host detach
>
>  drivers/gpu/drm/bridge/samsung-dsim.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1862,7 +1862,8 @@ static int samsung_dsim_register_te_irq(struct sams=
ung_dsim *dsi, struct device
>  	int te_gpio_irq;
>  	int ret;
>
> -	dsi->te_gpio =3D devm_gpiod_get_optional(dev, "te", GPIOD_IN);
> +	/* Released on host detach; do not use the managed get. */
> +	dsi->te_gpio =3D gpiod_get_optional(dev, "te", GPIOD_IN);

The comment is not really needed, this should be obvious by reading the
code. No need to resend just for that, I can remove it while applying.

Other than that it's OK:
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
