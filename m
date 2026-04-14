Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60302F531F6
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 07:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A6D10E583;
	Tue, 14 Apr 2026 07:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="qeg300j2";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD9F10E583
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 07:33:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DF2391A329B;
 Tue, 14 Apr 2026 07:33:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B5D715FFBB;
 Tue, 14 Apr 2026 07:33:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 84C791045009A; 
 Tue, 14 Apr 2026 09:33:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776151990; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=PjP986RvOAOPjOhP6DlRfE+VYZcwr8ScV33B3p29H38=;
 b=qeg300j2iwDsArj0vAC0Jyse4C4yYDkwji7W2EGklN0XIkktI6JfIeDMZGTmLEIFfxoXLb
 HpUXk+cwVwto6oFBN3CqCFFRAjVAMWyuqqOyT9qv6fg2xKqgVjMBscBqMLxCcoTBU59kks
 tih2XbdLN9p2yu8M31ILY3xVuJ82oKtn0+X1/SiD7qYdmCkk6w44Cxz8T9JG/pHm+NAqG1
 R92Q+9hybdZLZRtSAGehTU38HTfl25rgTnT7Le9bYIbvv44coYuQ3hQ3gMC1g6gHZJePZW
 ouIpZ2SAs7ZvptdET0UTfiaNHJ+FSPYh/9tkSwsPm3vqGJxFJU46UNAQ/TWYfA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 09:33:07 +0200
Message-Id: <DHSPBYSL28UY.NJ06LD1BT69N@bootlin.com>
Subject: Re: [PATCH 1/3] drm/sti: remove bridge when sti_hda component_add
 fails
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Alain Volmat"
 <alain.volmat@foss.st.com>, "Raphael Gallais-Pou" <rgallaispou@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260410212801.413827-2-osama.abdelkader@gmail.com>
In-Reply-To: <20260410212801.413827-2-osama.abdelkader@gmail.com>
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

On Fri Apr 10, 2026 at 11:27 PM CEST, Osama Abdelkader wrote:
> when component_add fails in sti_hda_probe remove drm
> bridge before return
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/sti/sti_hda.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.=
c
> index b7397827889c..1b4ba9097005 100644
> --- a/drivers/gpu/drm/sti/sti_hda.c
> +++ b/drivers/gpu/drm/sti/sti_hda.c
> @@ -741,6 +741,7 @@ static int sti_hda_probe(struct platform_device *pdev=
)
>  	struct device *dev =3D &pdev->dev;
>  	struct sti_hda *hda;
>  	struct resource *res;
> +	int ret;
>
>  	DRM_INFO("%s\n", __func__);
>
> @@ -783,7 +784,10 @@ static int sti_hda_probe(struct platform_device *pde=
v)
>
>  	platform_set_drvdata(pdev, hda);
>
> -	return component_add(&pdev->dev, &sti_hda_ops);
> +	ret =3D component_add(&pdev->dev, &sti_hda_ops);
> +	if (ret)
> +		drm_bridge_remove(&hda->bridge);
> +	return ret;
>  }

At a quick look it seems that you can simply use devm_drm_bridge_add() in
all the three drivers in this series.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
