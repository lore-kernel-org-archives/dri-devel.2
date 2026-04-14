Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A68F531F8
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 07:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B75E10E582;
	Tue, 14 Apr 2026 07:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rBXNcC+Q";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C003A10E582
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 07:24:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E44D4C5B1BF;
 Tue, 14 Apr 2026 07:25:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F0D245FFBB;
 Tue, 14 Apr 2026 07:24:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6970610450C2F; 
 Tue, 14 Apr 2026 09:24:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776151492; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=hqdHhQTAs+jH/daUBn6nCHtIM4ikF68EijxW04F+ShE=;
 b=rBXNcC+Q1zhPC9HRpFH60KohBhrEhabVQksEfCpHB3R6ABnBj12DEjtbrM13efTH0gbF6v
 QL1ufdYY/+pqrM+SU+wu9nwp8kSUaosrVrpxTGp1jt8vzwEs7RCCp1X/ErdnaPffcyiZIb
 tkuHseeRMwK7HVDzaGJ6EtdXIxAnpJCCwAML8LNP7W1qyuSQP58AV6u/G/qct7nhWSIePm
 utJhJWqvCIcH2eu6OGxTW0u5COnZV70WL3EzhodrRAiHd92jDdbv8IXWlF5s0goGgXmFPu
 toxldaiBIMHg9TqGsQPDLweVW1URTPL6t6NdPiyI8/Pds1RmgOdQSTs67yZi3A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 09:24:48 +0200
Message-Id: <DHSP5LBPI5DE.3I9EJO2V8UPH4@bootlin.com>
Subject: Re: [PATCH] drm/sti: hdmi: remove bridge when component_add fails
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Alain Volmat"
 <alain.volmat@foss.st.com>, "Raphael Gallais-Pou" <rgallaispou@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260410194141.275998-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260410194141.275998-1-osama.abdelkader@gmail.com>
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

On Fri Apr 10, 2026 at 9:41 PM CEST, Osama Abdelkader wrote:
> when component_add fails in sti_hdmi_probe remove the drm bridge
> and put i2c adapter before return
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/sti/sti_hdmi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdm=
i.c
> index f8222e60b1e0..839c80a7d954 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -1460,8 +1460,13 @@ static int sti_hdmi_probe(struct platform_device *=
pdev)
>  	platform_set_drvdata(pdev, hdmi);
>
>  	drm_bridge_add(&hdmi->bridge);
> -	return component_add(&pdev->dev, &sti_hdmi_ops);
> +	ret =3D component_add(&pdev->dev, &sti_hdmi_ops);
> +	if (ret)
> +		goto remove_bridge;
> +	return 0;
>
> + remove_bridge:
> +	drm_bridge_remove(&hdmi->bridge);
>   release_adapter:
>  	i2c_put_adapter(hdmi->ddc_adapt);

This function has an insane amount of sections like:

  if (IS_ERR(...)) {
      DRM_ERROR(...);
      ret =3D PTR_ERR(...);
      goto release_adapter;
  }

I guess all these can be dramatically simplified by using a devm
action. of_get_i2c_adapter_by_node() has no devm_ version but you can add a
release action using devm_add_action_or_reset(). This would allow to
simplify all the error management if()s and avoid any gotos.

On top of that you can just switch to devm_drm_bridge_add().

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
