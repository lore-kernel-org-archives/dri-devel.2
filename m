Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C0606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=W8AYzVgc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3DEE10EB95;
	Tue, 20 Oct 2026 11:24:35 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6986710EB95
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 11:24:29 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DF86CC62200;
 Tue, 20 Oct 2026 11:25:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5AA3460393;
 Tue, 20 Oct 2026 11:24:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 910C810328BF8; 
 Tue, 20 Oct 2026 13:24:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792495462; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=WPYH5eJzAisIOEp1pjCJoZqCbTGKIzLWnktSJcS/LYc=;
 b=W8AYzVgcUXXMyE2vqRY6IUNDBTT8EWJ+rlvHhYdj949JwsCr4CW9KtROwxHXXDvIr+GHAm
 keCsUkflawBRPvMZr9ofeHk6qUbty2S61i2g/895K/Gp/2s5Yk9CbQn/VVJm2fix4e9Uhk
 mt5qfJQzWZGZCBVYZoIv4cCv9FCiXYFFHbu1nwzSJZWyKH1GTKQrlRuPIlCYktNahC9EF2
 RHVNM6F4W0Zp9xRPhHRjJtX+wJmTN8UdWpxzDVqrNd+BcYWd98R4YPEeVARcQyfzOCJ91m
 jrWpp2ZN67zmIjvGFNbO6v4les6kJveWyUFfigtvtcInQBFkY85hY7TwTfwKdg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 13:24:17 +0200
Message-Id: <DM9MLWZC070K.3PS5NTIT64D25@bootlin.com>
Subject: Re: [PATCH v7 1/3] drm/panel: Use devm_mipi_dsi_attach in BOE panels
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Jessica Zhang" <jesszhan0024@gmail.com>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jerry Han"
 <hanxu5@huaqin.corp-partner.google.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <cover.1789994813.git.osama.abdelkader@gmail.com>
 <e9b653b02636c19b60d1153ee78284a8b915df3c.1789994813.git.osama.abdelkader@gmail.com>
In-Reply-To: <e9b653b02636c19b60d1153ee78284a8b915df3c.1789994813.git.osama.abdelkader@gmail.com>
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

Hello Osama,

On Mon Sep 21, 2026 at 3:17 PM CEST, Osama Abdelkader wrote:
> Use the managed MIPI DSI attach and panel add helpers in BOE panel driver=
s
> and drop the corresponding manual detach and panel remove calls from
> remove paths.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

...

> diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/d=
rm/panel/panel-boe-himax8279d.c
> index 4a8560b4b899..facf37bd1c14 100644
> --- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> +++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> @@ -851,9 +851,7 @@ static int panel_add(struct panel_info *pinfo)

As a separate series, renaming the functions in this file to name the
driver name would be nice, e.g. from panel_probe() to
boe_himax8279d_probe(). Would be much more grep-friendly.

> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu=
/drm/panel/panel-boe-tv101wum-nl6.c
> index 150dff3ab6c3..cf9f15fae272 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -1736,9 +1736,7 @@ static int boe_panel_add(struct boe_panel *boe)

Same for this driver.

This patch looks good:
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
