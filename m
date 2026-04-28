Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38730FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCF910E355;
	Tue, 28 Apr 2026 15:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="gVVwineO";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0249310E355
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 15:19:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 713CB1A3470;
 Tue, 28 Apr 2026 15:19:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 405A9601D0;
 Tue, 28 Apr 2026 15:19:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1450210728DF4; 
 Tue, 28 Apr 2026 17:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777389585; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=RAgbK/PFrZxkYcwrI5Pr+C2og+72bnYc7J9cHzu5HUQ=;
 b=gVVwineOM5SHRwLBuAnvbzeR1iW8sBeVyQOCO6ydDiC+I6Q6noSoS14xqbfcbsc6Bq+XMh
 Jwt4B0Fpl3gGy3IymaPF/ZFT8FwKtuGn/v+SQ90iC48Uxw29etQeF8YLFXM3dVfjnyvU91
 hg8zcXvJTlsYixVfQiKLFI+gcN+KJA7Kry+E1efUTE6iTJschzAPdGnz4DigimH/pzLS9X
 KiRN1Qh6EHso0o/4V22kHeag1HWcNtY/MOmt7hj092mW1y6KB75TaUorTkoo2/VmrGw8xg
 vKMzjq4xnXHQEXVNp/inBkeFygQdRZu48q2SMQElkOno5REAIgLdWi7rUD50ow==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 17:19:32 +0200
Message-Id: <DI4W0PE0FD0H.19OLT7KIRBT7H@bootlin.com>
Cc: "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
 <linux-arm-msm@vger.kernel.org>, "freedreno@lists.freedesktop.org"
 <freedreno@lists.freedesktop.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
To: "Biju Das" <biju.das.jz@bp.renesas.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "Tian Tao" <tiantao6@hisilicon.com>,
 "Xinwei Kong" <kong.kongxinwei@hisilicon.com>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, "John Stultz" <jstultz@google.com>, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>,
 "laurent.pinchart" <laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "tomi.valkeinen" <tomi.valkeinen@ideasonboard.com>, "Michal Simek"
 <michal.simek@amd.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 08/11] drm/bridge: adv7511: switch to
 of_drm_get_bridge_by_endpoint()
X-Mailer: aerc 0.20.1
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-8-4300744a1c47@bootlin.com>
 <TY3PR01MB113466B70BFD2899AB0CF47AD86372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134674FDD088299A4382D3D286372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <DI4TGV2WURTY.39OXE7WWKRLA1@bootlin.com>
 <TY3PR01MB11346E82D19FBE8544F51624286372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <DI4U2DT3OBMR.23T3F7X8P75RU@bootlin.com>
 <TY3PR01MB113465B0308DE16ACC48D1E8186372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346293C9AAF8BC4B3FCAD6586372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113466FD12513A25C0126A55F86372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113466FD12513A25C0126A55F86372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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

Hello Biju,

On Tue Apr 28, 2026 at 4:45 PM CEST, Biju Das wrote:
> Hi Luca,
>
>> -----Original Message-----
>> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of B=
iju Das
>> Sent: 28 April 2026 15:39
>> Subject: RE: [PATCH v2 08/11] drm/bridge: adv7511: switch to of_drm_get_=
bridge_by_endpoint()
>>
>>
>>
>> > -----Original Message-----
>> > From: Biju Das
>> > Sent: 28 April 2026 15:02
>> > Subject: RE: [PATCH v2 08/11] drm/bridge: adv7511: switch to
>> > of_drm_get_bridge_by_endpoint()
>> >
>> > Hi Luca,
>> >
>> > > -----Original Message-----
>> > > From: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> > > Sent: 28 April 2026 14:48
>> > > Subject: Re: [PATCH v2 08/11] drm/bridge: adv7511: switch to
>> > > of_drm_get_bridge_by_endpoint()
>> > >
>> > > Hello,
>> > >
>> > > On Tue Apr 28, 2026 at 3:31 PM CEST, Biju Das wrote:
>> > > >> >> > @@ -1251,10 +1251,9 @@ static int adv7511_probe(struct
>> > > >> >> > i2c_client
>> > > >> >> > *i2c)
>> > > >> >> >
>> > > >> >> >  	memset(&link_config, 0, sizeof(link_config));
>> > > >> >> >
>> > > >> >> > -	ret =3D drm_of_find_panel_or_bridge(dev->of_node, 1, -1, N=
ULL,
>> > > >> >> > -					  &adv7511->next_bridge);
>> > > >> >> > -	if (ret && ret !=3D -ENODEV)
>> > > >> >> > -		return ret;
>> > > >> >> > +	adv7511->bridge.next_bridge =3D of_drm_get_bridge_by_endpo=
int(dev->of_node, 1, -1);
>> > > >> >> > +	if (IS_ERR(adv7511->bridge.next_bridge) && PTR_ERR(adv7511=
->bridge.next_bridge) !=3D -
>> ENODEV)
>> > > >> >> > +		return PTR_ERR(adv7511->bridge.next_bridge);
>> > > >> >>
>> > > >> >> Does it crash, if the error is  -EPROBE_DEFER?
>> > > >> >
>> > > >> > I see a crash with patch [1], which is fixed by avoiding the di=
rect assignment.
>> > > >>
>> > > >> Ah, dammit! Good catch, thanks for the quick testing and follow-u=
p!
>> > > >>
>> > > >> Indeed this driver assumes next_bridge is either NULL or a valid
>> > > >> pointer, but due to the 'if(IS_ERR() && some_other_condition)'
>> > > >> now it can also be -ENODEV (not -
>> > > EPROBE_DEFER, but that's irrelevant).
>> > > >>
>> > > >> This affects the msm and zynqmp_dp patches equally.
>> > > >>
>> > > >> I'm sending a v3 soon with these fixed. I'm just not sure which
>> > > >> approach to use to fix (same for all the 3 patches). Alternatives=
 are:
>> > > >>
>> > > >>  1. -ENODEV is accepted, set next_bridge to NULL when it happens:
>> > > >>
>> > > >>       -       if (IS_ERR(adv7511->bridge.next_bridge) && PTR_ERR(=
adv7511->bridge.next_bridge) !=3D
>> -
>> > > >> ENODEV)
>> > > >>       -               return PTR_ERR(adv7511->bridge.next_bridge)=
;
>> > > >>       +       if (IS_ERR(adv7511->bridge.next_bridge)) {
>> > > >>       +               if (PTR_ERR(adv7511->bridge.next_bridge) =
=3D=3D -ENODEV)
>> > > >>       +                       adv7511->bridge.next_bridge =3D NUL=
L;
>> > > >>       +               else
>> > > >>       +                       return PTR_ERR(adv7511->bridge.next=
_bridge);
>> > > >
>> > > > The point is you cannot return PTR_ERR as it will lead to crash,
>> > > > if it is direct assignment.
>> > >
>> > > It would definitely crash when the next_bridge is dereferenced
>> > > (which happens in
>> > > adv7511_bridge_attach()) but I don't see how it can crash here. Here
>> > > it _can_ be assigned -ENODEV, but it would be immediately be cleared
>> > > to NULL, or to enother error, but we'd immediately return. And in
>> > > case of return, when next_bridge is cleared by __drm_bridge_free ->
>> > > drm_bridge_put, the error value would
>> > be ignored thanks to patch 1.
>> >
>> > OK, I haven't noticed the newly introduced check in drm_bridge_put() i=
n patch#1.
>> >
>> > I guess, we should avoid putting error values in bridge.next_bridge.
>> > It should be either NULL or Valid pointer, not PTR_ERR.
>>
>> FTR, I get a crash in attach. I will apply the suggested changes and wil=
l let you know the result.
>>
>> [   18.957324] pc : drm_bridge_attach+0x34/0x210 [drm]
>> [   18.969425] lr : adv7511_bridge_attach+0x38/0xb8 [adv7511]
>>
>> [   18.969610]  drm_bridge_attach+0x34/0x210 [drm] (P)
>> [   18.969845]  adv7511_bridge_attach+0x38/0xb8 [adv7511]
>> [   18.969867]  drm_bridge_attach+0xf0/0x210 [drm]
>> [   18.970042]  rzg2l_mipi_dsi_attach+0x24/0x3c [rzg2l_mipi_dsi]
>> [   18.970064]  drm_bridge_attach+0xf0/0x210 [drm]
>> [   18.970262]  rzg2l_du_encoder_init+0x9c/0x250 [rzg2l_du_drm]
>> [   18.970293]  rzg2l_du_modeset_init+0x30c/0x4d0 [rzg2l_du_drm]
>> [   18.970307]  rzg2l_du_probe+0xc8/0x174 [rzg2l_du_drm]
>> [   18.970321]  platform_probe+0x5c/0xa4
>> [   18.970336]  really_probe+0xbc/0x2c0
>> [   18.970348]  __driver_probe_device+0x80/0x14c
>> [   18.970359]  driver_probe_device+0x3c/0x164
>> [   18.970369]  __driver_attach+0x90/0x1a4
>> [   18.970379]  bus_for_each_dev+0x7c/0xdc
>> [   18.970388]  driver_attach+0x24/0x30
>> [   18.970397]  bus_add_driver+0xe4/0x208
>> [   18.970406]  driver_register+0x68/0x130
>> [   18.970416]  __platform_driver_register+0x24/0x30
>>
>
> I confirm the crash is fixed by your suggested changes for V3.

Very quick feedback loop! Thanks a lot Biju.

Sending v3 in a moment.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
