Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E1FFF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642BC10E0F1;
	Thu, 30 Apr 2026 08:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fHEhKTFf";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF1010E42C
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:52:23 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-449e96a8a80so823f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777539142; x=1778143942; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nh8FeWVgZMmI1Zz40jRCGrGIcuEoqQHDX1Vv7w5wdMA=;
 b=fHEhKTFfrA0/3+XYOEzE1Ew8rTODc7IBQGWDLfOgi1QcU6AOFk4ZvouVPI52ddqlkl
 KdWgJNHaW15xBd1L+ghQfLAhZickMAMDFnlsrFDLTx1JSargmlm1hVcGfbT7tEV1b71e
 YmyB6x1GkPVsvlmwR9Hg6qFYeosCgGzsJky+B3/SLND6Ds8BotRJ/gGcP2Dmy14cGn5z
 shwQE9d6bheRfF7ZHjA5JHgtGHSgbdU+h57Se4I/AZjzTi6E5Pq84VBYPR79x/Y0nuG5
 VnOAPnrFoxM1EtL1hQxbftgSbrsM5JcAVFtOinl9Ibd7n36ObG19m+Cm5z6jz5jj395j
 NB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539142; x=1778143942;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nh8FeWVgZMmI1Zz40jRCGrGIcuEoqQHDX1Vv7w5wdMA=;
 b=WMSnUZZDxBoW9dqapec7UIQWtBfKl4CsjqeDdJoiri1rLJhYb6Sby37ic7V5b5i5xB
 qz0raO1cIDc7gol9OoEVgs3chyiYFad/vkpiu4ULrHZqSELk/AYSzBuHelE9gpddP0jl
 RTZLUnXk11UCLr6jB+XHf2o16m40h3vUgZQZO3poDFidX4GXaVRYYXLhHdtJddPueFC/
 mQT9MHsJYc4pqqzVLBccjkfOxbhPNGx39kvUzkHK98AYmxfTES3KJrR/R6jg9CdG6pDa
 APyRbKeRoHhq3PyBiFFYw/rievjtvDgs9CiL+mFdSYzBgaYx849r6b99Zd9oR0Uq/vx6
 e3sQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xGrFUl2ezanhZDDO3e6VPOkOaBsj7CaEZF5bdiBvzNc8niCKwetQ1EiiV9LmK0og8o/+8/OnR87A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1wx4XRP8Esb9HbQC1YfO2aqdw/uEGomcWk6Zq1ZhwZ6wa13oz
 V1A6bIuk5MdXegO86StsBR6n2mZVp2jTqOwyfmRUMxW9qy06oarqdw7x
X-Gm-Gg: AeBDietKGcnjGWsj0FlcbRYLFdywkuMmNasFKlhG+PwWzxWiWW7NbhJOwUeehU1Pats
 HtZ0w6XArXA6PbfCSJ9LeX6ka0yfvElqQlVcnaB6xM7rX2lj5jsPje0BErQ+jG6sqvdO82urFW7
 Xe7zXFStH2JYOYjGtG/wYHOylm6nUVktQg0xtQfjBoU7mMZjbADgvOdfEhBbcvQIe7rI6PqUnPl
 +dMWv0nLUtfB298PSlBoEz78L/Itd5YucXpEiweyJRdjQeweluwCiGNFRAGdzvjElVv2RFkzSS9
 Lo3X9Xhf673EoSEKejZ9BifsuHfx2zpWDiageoj1S3EjweCkIamgxjVkB3Xw4DOHD0mut60ucAQ
 oEbofteQo4I2YUYxNR7ix6yWdhKaudA1SJnNz508ZMrf7auGanbEd8q5TUegnTb3fJSUvS2Vdw9
 EOsJ2fijWLFRgQwO0p3ceCmmReytPlVnEMps5FVB1DrEp+8OHOw4TEt/5v
X-Received: by 2002:a05:6000:2486:b0:43d:7b85:6c95 with SMTP id
 ffacd0b85a97d-4493fa014admr2984866f8f.33.1777539141830; 
 Thu, 30 Apr 2026 01:52:21 -0700 (PDT)
Received: from vitor-nb.Home (dsl-43-224.bl27.telepac.pt. [176.79.43.224])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7217b20sm11157241f8f.22.2026.04.30.01.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 01:52:21 -0700 (PDT)
Message-ID: <19d0a0b1d33061a0421edf883acaaa7e366646c2.camel@gmail.com>
Subject: Re: [PATCH v4] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
From: Vitor Soares <ivitro@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 30 Apr 2026 09:52:19 +0100
In-Reply-To: <DI6C5A83IG4B.1UV6WJMFQ9AA7@bootlin.com>
References: <20260407144142.1420354-2-ivitro@gmail.com>
 <DI6C5A83IG4B.1UV6WJMFQ9AA7@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
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

Hi Luca,

Thanks you for the feedback.

On Thu, 2026-04-30 at 10:10 +0200, Luca Ceresoli wrote:
> On Tue Apr 7, 2026 at 4:41 PM CEST, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
> > for both runtime PM and system sleep. This causes the DSI clocks to be
> > disabled twice: once during runtime suspend and again during system
> > suspend, resulting in a WARN message from the clock framework when
> > attempting to disable already-disabled clocks.
> >=20
> > [=C2=A0=C2=A0 84.384540] clk:231:5 already disabled
> > [=C2=A0=C2=A0 84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/clk.c=
:1181
> > clk_core_disable+0xa4/0xac
> > ...
> > [=C2=A0=C2=A0 84.579183] Call trace:
> > [=C2=A0=C2=A0 84.581624]=C2=A0 clk_core_disable+0xa4/0xac
> > [=C2=A0=C2=A0 84.585457]=C2=A0 clk_disable+0x30/0x4c
> > [=C2=A0=C2=A0 84.588857]=C2=A0 cdns_dsi_suspend+0x20/0x58 [cdns_dsi]
> > [=C2=A0=C2=A0 84.593651]=C2=A0 pm_generic_suspend+0x2c/0x44
> > [=C2=A0=C2=A0 84.597661]=C2=A0 ti_sci_pd_suspend+0xbc/0x15c
> > [=C2=A0=C2=A0 84.601670]=C2=A0 dpm_run_callback+0x8c/0x14c
> > [=C2=A0=C2=A0 84.605588]=C2=A0 __device_suspend+0x1a0/0x56c
> > [=C2=A0=C2=A0 84.609594]=C2=A0 dpm_suspend+0x17c/0x21c
> > [=C2=A0=C2=A0 84.613165]=C2=A0 dpm_suspend_start+0xa0/0xa8
> > [=C2=A0=C2=A0 84.617083]=C2=A0 suspend_devices_and_enter+0x12c/0x634
> > [=C2=A0=C2=A0 84.621872]=C2=A0 pm_suspend+0x1fc/0x368
> >=20
> > To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
> > SET_RUNTIME_PM_OPS(), enabling suspend/resume handling through the
>=20
> This is not what the patch does, the patch uses RUNTIME_PM_OPS.
>=20

I missed changing it. I will send another version fixing the commit message
to RUNTIME_PM_OPS().

> > _enable()/_disable() hooks managed by the DRM framework for both
> > runtime and system-wide PM.
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# 6.1.x
> > Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> > Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > ---
> > v3 -> v4
> > =C2=A0- Add Reviewed-by from Tomi Valkeinen
> > =C2=A0- Rebase on top of drm-misc-fixes
> > =C2=A0- Verified issue still present on current mainline
> >=20
> > v2 -> v3
> > =C2=A0- Fix warning: 'cdns_dsi_suspend' defined but not used [-Wunused-=
function]
> > =C2=A0- Fix warning: 'cdns_dsi_resume' defined but not used [-Wunused-f=
unction]
> >=20
> > v1 -> v2
> > =C2=A0- Rely only on SET_RUNTIME_PM_OPS() for the PM.
> >=20
> > =C2=A0drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 11 ++++++-----
> > =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > index 0dd85e26248c..e07a9892df4e 100644
> > --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > @@ -1230,7 +1230,7 @@ static const struct mipi_dsi_host_ops cdns_dsi_op=
s =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.transfer =3D cdns_dsi_=
transfer,
> > =C2=A0};
> >=20
> > -static int __maybe_unused cdns_dsi_resume(struct device *dev)
> > +static int cdns_dsi_resume(struct device *dev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cdns_dsi *dsi =
=3D dev_get_drvdata(dev);
> >=20
> > @@ -1241,7 +1241,7 @@ static int __maybe_unused cdns_dsi_resume(struct
> > device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0}
> >=20
> > -static int __maybe_unused cdns_dsi_suspend(struct device *dev)
> > +static int cdns_dsi_suspend(struct device *dev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cdns_dsi *dsi =
=3D dev_get_drvdata(dev);
> >=20
> > @@ -1251,8 +1251,9 @@ static int __maybe_unused cdns_dsi_suspend(struct
> > device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0}
> >=20
> > -static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend,
> > cdns_dsi_resume,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 NULL);
> > +static const struct dev_pm_ops cdns_dsi_pm_ops =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RUNTIME_PM_OPS(cdns_dsi_susp=
end, cdns_dsi_resume, NULL)
> > +};
>=20
> Not an expert here, but the docs [0] suggest using
> DEFINE_RUNTIME_DEV_PM_OPS(). Is there a good reason to not do so?
>=20
> [0]
> https://elixir.bootlin.com/linux/v7.0.1/source/include/linux/pm.h#L455-L4=
56
>=20
> Luca
>=20

In an earlier discussion [0], we concluded that bridges/panels should only =
deal
with runtime PM:

[0]
https://lore.kernel.org/all/a1cf67da-a0cb-46c5-b22b-10ecca8ab383@ideasonboa=
rd.com/

Best regards,
Vitor Soares
