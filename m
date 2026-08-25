Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA91C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34E110EAD3;
	Tue, 25 Aug 2026 15:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="D6x9q9Zk";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A291110EAD2
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 15:59:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DB3111A17DD;
 Tue, 25 Aug 2026 15:59:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id ACA98604C4;
 Tue, 25 Aug 2026 15:59:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 005C711C7A67C; 
 Tue, 25 Aug 2026 17:59:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787673574; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=3NZXFqkmkTqDCn9vPnJRnN4Vb1TE/i8iMGnvkqgygHM=;
 b=D6x9q9ZkHOG7H7Hcdy+yhiOVusHNpegIj62Q/KDcPS40P56i4J/A5XjVLpN0EHzlf479t+
 CVeBsYu0f6LkL0wnO/Tz4O+Rvw5aBpojWNTEh932XU5pxhOfiOE0jF5fUg0iQeL/eTMCkM
 5NYbLbNZ4xxEzmZTXD8nNouhsV6coffCUU9y/AihwHbyRmo8k5L43NJYH8y/gFZHKiVWRI
 oV+2lhwZIxReXV73grHyqcyKQuiq4oWufmcJoU4/twKtSjEY79pV94ZrDG5wrwIFHoeK1Y
 xXddQQ5JTVg7fFcP8b4gf9c3AfuD9td3YTlG9bAgofuhSp4XYC0Xtwqp/rNkxw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 17:59:23 +0200
Message-Id: <DKY5E1PJ172I.2LYOZZT775PE9@bootlin.com>
Subject: Re: [PATCH v3 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE panels
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>,
 <luca.ceresoli@bootlin.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jessica Zhang" <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jerry Han"
 <hanxu5@huaqin.corp-partner.google.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260812130429.16850-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260812130429.16850-1-osama.abdelkader@gmail.com>
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

On Wed Aug 12, 2026 at 3:04 PM CEST, Osama Abdelkader wrote:
> Use the managed MIPI DSI attach helper in BOE panel drivers and drop the
> corresponding manual detach calls from remove paths.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Please, next time use proper tools to send your series ina single thread
with a cover letter. This v3 is made of 6 e-mails in 6 separate threads,
which is very annoying to handle.

>
> ---
> v3:
> - Move the changelog after the `---`.
>
> v2:
> - break long description lines.
> - add Signed-off-by tag
>
>  drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c       | 8 +-------
>  drivers/gpu/drm/panel/panel-boe-himax8279d.c         | 8 +-------
>  drivers/gpu/drm/panel/panel-boe-td4320.c             | 8 +-------
>  drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 4 +---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c       | 8 +-------
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c       | 7 +------
>  6 files changed, 6 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu=
/drm/panel/panel-boe-bf060y8m-aj0.c
> index 84c21c62a43e..6a74523a6614 100644
> --- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> +++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> @@ -359,7 +359,7 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_dev=
ice *dsi)
>
>  	drm_panel_add(&boe->panel);

Why not converting drm_panel_add() to the devm variant too? Without it...

>
> -	ret =3D mipi_dsi_attach(dsi);
> +	ret =3D devm_mipi_dsi_attach(&dsi->dev, dsi);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
>  		return ret;
> @@ -371,12 +371,6 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_de=
vice *dsi)
>  static void boe_bf060y8m_aj0_remove(struct mipi_dsi_device *dsi)
>  {
>  	struct boe_bf060y8m_aj0 *boe =3D mipi_dsi_get_drvdata(dsi);
> -	int ret;
> -
> -	ret =3D mipi_dsi_detach(dsi);
> -	if (ret < 0)
> -		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> -
>  	drm_panel_remove(&boe->panel);
>  }

...the remove sequence will be incorrect: removing the panel first (open
coded) and detaching the DSI device afterwards (devm, done after .remove
returns).

Same for the other files.

Note that patch 2 is correct in this respect.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
