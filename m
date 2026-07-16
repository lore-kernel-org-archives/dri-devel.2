Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A094C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F45D10E302;
	Thu, 16 Jul 2026 17:03:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="kRH+MMYr";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F8110E302
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 17:03:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 1183F4E40DFF;
 Thu, 16 Jul 2026 17:03:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C9DC26035F;
 Thu, 16 Jul 2026 17:03:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DFCD711BD3CC2; 
 Thu, 16 Jul 2026 19:03:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784221409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=kVRvkObIlHmfUp8lHLrZGvVXT9EJSwAPptTGH9qOjbE=;
 b=kRH+MMYrKetJax9EXRLWiIPNISa/1QeIL6wDsfuDXBwS2dWfydIejyiKjKl8CWgnn/CBb2
 qYTErUsvrwmTiTD1+L9fRj1M5AaiM0hwG4SU7gp0phjle2ZwGMA4EFN5uEpHiabIW3GXyt
 06D02Z3FYBUAySukDjPYjEQft6K3beH0HpVtxhxEf+xuvENti8QDe3HWb7Q7gl/PhzRF4r
 OfLCzCFTxxaincKRE3hwbNTjLrbnWZ2KRTCFjFhOx8ItlQPbsydngB6j63aE2AkQCx9qaG
 MTdaXZE717ButWeh3TF6Ra7mQ/7pfnxbEYR7d6w9HymRPKqv+pFZVzqlJAmTdA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 19:03:22 +0200
Message-Id: <DK05P8X4FI5W.15SH3XRO3MXN9@bootlin.com>
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Linus
 Walleij" <linusw@kernel.org>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Marek Vasut" <marex@denx.de>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Esben Haabendal" <esben@geanix.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 3/3] drm/bridge: ti-sn65dsi83: Support LVDS Channel B
 on SN65DSI84
X-Mailer: aerc 0.21.0
References: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
 <20260715-ti-sn65dsi83-fixes-v2-3-ebc4c3fe29b6@geanix.com>
 <178421534409.28815.14030419996947306239.b4-review@b4>
 <8SgSn8BXZAxJ8Pj2MJVVpzkmvK0_xII-D_cs86jsXDPC0LxlvGuDXozzxKLQC58S48HUCD4MkrAP_trxtZNRIk9fOoyMeQEEiW9yfkTB4bo=@geanix.com>
In-Reply-To: <8SgSn8BXZAxJ8Pj2MJVVpzkmvK0_xII-D_cs86jsXDPC0LxlvGuDXozzxKLQC58S48HUCD4MkrAP_trxtZNRIk9fOoyMeQEEiW9yfkTB4bo=@geanix.com>
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

Hi,

On Thu Jul 16, 2026 at 6:03 PM CEST, Esben Haabendal wrote:
> On Thursday, 16 July 2026 at 17:22, Luca Ceresoli <luca.ceresoli@bootlin.=
com> wrote:
>> On Wed, 15 Jul 2026 15:10:33 +0200, Esben Haabendal <esben@geanix.com> w=
rote:
>>
>> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/b=
ridge/ti-sn65dsi83.c
>> > index 7e73035d7798..02ae2b8179b0 100644
>> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> > @@ -893,6 +895,7 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ct=
x, enum sn65dsi83_model model)
>> >  {
>> >  	struct drm_bridge *panel_bridge;
>> >  	struct device *dev =3D ctx->dev;
>> > +	u32 panel_port =3D 2;
>>
>> Thanks for having applied the changes I had suggested.
>>
>> I'm afraid I realized right now the "panel_port" name is not ideal becau=
se
>> there could be another bridge at the output port and not directly a
>> panel. Should you have a reason to send a v3 I'd rename to output_port (=
and
>> keep my R-by if that's the only change). Otherwise I can do it while
>> applying the patch.
>
> What about the panel_bridge member of struct sn65dsi83? We use
> panel_port/output_port as argument to devm_drm_of_get_bridge() and assign=
 the
> bridge we get from that to ctx->panel_bridge. So are you sure that it mak=
es
> sense to rename panel_port to output_port? Or do you want to rename the
> panel_bridge member also?

Ah, I understand. Well, the panel_bridge name is confusing, perhaps doe to
historical legacy. Perhaps the name was given when the next thing after the
sn65dsi8x could only be a panel. Now if you look at the
devm_drm_of_get_bridge() code it is one of:

  1. a panel_bridge created on the fly to wrap a panel
     (a panel is connected at the sn65dsi8x output)
  2. a pre-existing drm_bridge that does not wrap a panel
     (a LVDS-to-something-else-bridge is connected at the sn65dsi8x output)

In the latter case the panel_bridge does not make sense. But it works
because int he end it is a struct drm_bridge *, not a panel-specific thing.

I am about to change all that and eventually have:

 - a panel_bridge created for every drm_panel
 - all interactions with the next element done accessing the next_bridge,
   no more accessing a drm_panel directly
 - drm_of_find_panel_or_bridge() disappear, because there will be no need
   to access the "next panel"
 - devm_drm_of_get_bridge() just return the next bridge, not bothering
   about panels

I hope this clarifies.

That said, I wouldn't bother renaming existing variables, but for new
variables being added I'd try to use the best possible name. Here you are
storing the number of the output port, so I suggested output_port.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
