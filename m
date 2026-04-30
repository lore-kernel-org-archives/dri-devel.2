Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D62DFF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 915FC10F285;
	Thu, 30 Apr 2026 08:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fwNzz+Na";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F7D710F285
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:10:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E5A324E42B73;
 Thu, 30 Apr 2026 08:10:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AC82760495;
 Thu, 30 Apr 2026 08:10:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 17DA91072B755; 
 Thu, 30 Apr 2026 10:10:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777536634; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dnqNnTF0DYaAxbSZWlFQjgF0Ulm0iKJS5gN4T0zzOZ8=;
 b=fwNzz+Nahzd38yd2W8yYXV3nQsiEuOlIsLSQuH5OhRM1zDbACIAU/uKtL012G9uEA2HkmS
 nB3OykRQmJIxe0b9U7rd8nFEVcqvZbj7i7PEncC8dtmG0AnoyXJ+ZZWxuh39kFr8+bAdEt
 oUumRVDNKQoPOxcGlC6PGhC7FIEa2dzQ9cGl6bFnVG8F/weTPUqAl+XJUwskomgQ34DPWh
 lTB9JC/oGYDeGhyLBwuRd1o6tA7d/5sVC7VkpxCakZZHfBDi9atmyXLyyq+KtiUfnzG5so
 Cb/C0zlhjp8UankqPtmDYFWIOYJkkgrJBVDkkPo3sz3dyCIxqUUhzmIPQJcTLg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 10:10:29 +0200
Message-Id: <DI6C5A83IG4B.1UV6WJMFQ9AA7@bootlin.com>
Subject: Re: [PATCH v4] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
Cc: "Vitor Soares" <vitor.soares@toradex.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>
To: "Vitor Soares" <ivitro@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260407144142.1420354-2-ivitro@gmail.com>
In-Reply-To: <20260407144142.1420354-2-ivitro@gmail.com>
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

On Tue Apr 7, 2026 at 4:41 PM CEST, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>
> The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
> for both runtime PM and system sleep. This causes the DSI clocks to be
> disabled twice: once during runtime suspend and again during system
> suspend, resulting in a WARN message from the clock framework when
> attempting to disable already-disabled clocks.
>
> [   84.384540] clk:231:5 already disabled
> [   84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/clk.c:1181 clk_co=
re_disable+0xa4/0xac
> ...
> [   84.579183] Call trace:
> [   84.581624]  clk_core_disable+0xa4/0xac
> [   84.585457]  clk_disable+0x30/0x4c
> [   84.588857]  cdns_dsi_suspend+0x20/0x58 [cdns_dsi]
> [   84.593651]  pm_generic_suspend+0x2c/0x44
> [   84.597661]  ti_sci_pd_suspend+0xbc/0x15c
> [   84.601670]  dpm_run_callback+0x8c/0x14c
> [   84.605588]  __device_suspend+0x1a0/0x56c
> [   84.609594]  dpm_suspend+0x17c/0x21c
> [   84.613165]  dpm_suspend_start+0xa0/0xa8
> [   84.617083]  suspend_devices_and_enter+0x12c/0x634
> [   84.621872]  pm_suspend+0x1fc/0x368
>
> To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
> SET_RUNTIME_PM_OPS(), enabling suspend/resume handling through the

This is not what the patch does, the patch uses RUNTIME_PM_OPS.

> _enable()/_disable() hooks managed by the DRM framework for both
> runtime and system-wide PM.
>
> Cc: stable@vger.kernel.org # 6.1.x
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
> v3 -> v4
>  - Add Reviewed-by from Tomi Valkeinen
>  - Rebase on top of drm-misc-fixes
>  - Verified issue still present on current mainline
>
> v2 -> v3
>  - Fix warning: 'cdns_dsi_suspend' defined but not used [-Wunused-functio=
n]
>  - Fix warning: 'cdns_dsi_resume' defined but not used [-Wunused-function=
]
>
> v1 -> v2
>  - Rely only on SET_RUNTIME_PM_OPS() for the PM.
>
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu=
/drm/bridge/cadence/cdns-dsi-core.c
> index 0dd85e26248c..e07a9892df4e 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -1230,7 +1230,7 @@ static const struct mipi_dsi_host_ops cdns_dsi_ops =
=3D {
>  	.transfer =3D cdns_dsi_transfer,
>  };
>
> -static int __maybe_unused cdns_dsi_resume(struct device *dev)
> +static int cdns_dsi_resume(struct device *dev)
>  {
>  	struct cdns_dsi *dsi =3D dev_get_drvdata(dev);
>
> @@ -1241,7 +1241,7 @@ static int __maybe_unused cdns_dsi_resume(struct de=
vice *dev)
>  	return 0;
>  }
>
> -static int __maybe_unused cdns_dsi_suspend(struct device *dev)
> +static int cdns_dsi_suspend(struct device *dev)
>  {
>  	struct cdns_dsi *dsi =3D dev_get_drvdata(dev);
>
> @@ -1251,8 +1251,9 @@ static int __maybe_unused cdns_dsi_suspend(struct d=
evice *dev)
>  	return 0;
>  }
>
> -static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend, cdns_dsi_=
resume,
> -			    NULL);
> +static const struct dev_pm_ops cdns_dsi_pm_ops =3D {
> +	RUNTIME_PM_OPS(cdns_dsi_suspend, cdns_dsi_resume, NULL)
> +};

Not an expert here, but the docs [0] suggest using
DEFINE_RUNTIME_DEV_PM_OPS(). Is there a good reason to not do so?

[0] https://elixir.bootlin.com/linux/v7.0.1/source/include/linux/pm.h#L455-=
L456

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
