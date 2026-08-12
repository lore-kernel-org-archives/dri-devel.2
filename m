Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F321EC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1EE10EFE6;
	Wed, 12 Aug 2026 13:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="LzX9zBNT";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C7F910EFE6
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:46:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4C8E64E411BF;
 Wed, 12 Aug 2026 13:46:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 192516045E;
 Wed, 12 Aug 2026 13:46:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5EA6711C4CF15; 
 Wed, 12 Aug 2026 15:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786542375; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=uVMK0QQ5PLCgvDGXDEbA3PHLMBcAOC/CW0vnbC1kxus=;
 b=LzX9zBNTFrm6q5tYeCVHcfNzhTsGAzk3mUdUOUvaDPegWtT04Un8sx+sT6Jz1yBj72D/LW
 pGdiz03k1Ao/NXxY0m5Eou2DgGq6OsAgqA0qInyw7ne76Vat7q7COYvZss1fpWoeb0CJ2q
 2vEI85bwp3XJQP6k9UHrc4WIL18GskMHJbdPRNVHn945Ckr+Fsrrip4ZLpX8HTTxQyksk5
 0Mjj6r5PVJdSKadLxfIl3yDqkXJ8egSH7VOnhKzi75CLDOesRadfaxLOFTx9RL8OoFKn2/
 2kvFCvb0GGobQxCQqs3QGKuTL3t8FpGYR4v1IjuKIwogUTg1S12m3JCOTA4cyA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 15:45:59 +0200
Message-Id: <DKN0ETWJ22OV.3QPJV5URU6GSY@bootlin.com>
To: "Maxime Ripard" <mripard@kernel.org>, "Osama Abdelkader"
 <osama.abdelkader@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE panels
Cc: <luca.ceresoli@bootlin.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Jerry Han"
 <hanxu5@huaqin.corp-partner.google.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260812130429.16850-1-osama.abdelkader@gmail.com>
 <20260812-psychedelic-accomplished-swift-4f0081@houat>
In-Reply-To: <20260812-psychedelic-accomplished-swift-4f0081@houat>
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

Hello,

On Wed Aug 12, 2026 at 3:26 PM CEST, Maxime Ripard wrote:
> On Wed, Aug 12, 2026 at 03:04:18PM +0200, Osama Abdelkader wrote:
>> Use the managed MIPI DSI attach helper in BOE panel drivers and drop the
>> corresponding manual detach calls from remove paths.
>>
>> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
>>
>> ---
>> v3:
>> - Move the changelog after the `---`.
>>
>> v2:
>> - break long description lines.
>> - add Signed-off-by tag
>>
>>  drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c       | 8 +-------
>>  drivers/gpu/drm/panel/panel-boe-himax8279d.c         | 8 +-------
>>  drivers/gpu/drm/panel/panel-boe-td4320.c             | 8 +-------
>>  drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 4 +---
>>  drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c       | 8 +-------
>>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c       | 7 +------
>>  6 files changed, 6 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gp=
u/drm/panel/panel-boe-bf060y8m-aj0.c
>> index 84c21c62a43e..6a74523a6614 100644
>> --- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
>> +++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
>> @@ -359,7 +359,7 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_de=
vice *dsi)
>>
>>  	drm_panel_add(&boe->panel);
>>
>> -	ret =3D mipi_dsi_attach(dsi);
>> +	ret =3D devm_mipi_dsi_attach(&dsi->dev, dsi);
>>  	if (ret < 0) {
>>  		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
>>  		return ret;
>> @@ -371,12 +371,6 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_d=
evice *dsi)
>>  static void boe_bf060y8m_aj0_remove(struct mipi_dsi_device *dsi)
>>  {
>>  	struct boe_bf060y8m_aj0 *boe =3D mipi_dsi_get_drvdata(dsi);
>> -	int ret;
>> -
>> -	ret =3D mipi_dsi_detach(dsi);
>> -	if (ret < 0)
>> -		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
>> -
>>  	drm_panel_remove(&boe->panel);
>>  }
>
> mipi_dsi_detach is now called after drm_panel_remove. Your commit log
> should mention it, and explain why it's not a concern.

Indeed. Or switch from drm_panel_add() to devm_drm_panel_add(), which would
avoid the issue mentioned by Maxime and cleanup even more the code.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
