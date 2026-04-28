Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B2CFF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FAC410EC9E;
	Tue, 28 Apr 2026 13:47:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MaQ93KGS";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA1C10EC9D;
 Tue, 28 Apr 2026 13:47:53 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 3168BC5EF0B;
 Tue, 28 Apr 2026 13:48:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 625B2601D0;
 Tue, 28 Apr 2026 13:47:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ACB6C10728C08; 
 Tue, 28 Apr 2026 15:47:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777384070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=8hH5f9pRWZjIKa7upLj6O1FMpKJtS+Zt3OkL4sYouao=;
 b=MaQ93KGSH+Hk8abA6MbWHlda1aC2uqGX/4nTQBQA//FFqhT5t6lxHiZAYhudeVv24bAcD5
 +G529G8DcjVQCvZ6Re1R8BX0iwjTpBm/zn6H4ufwwZu9XJZWY0o9lZJBOYADSOOX2eMsNg
 O35B1w4pJ1d2XnuAlOPaVvL7Ur0NlIhodLk8jTJOzrDDLV4OH5CeU3InEdnDiS8kQ0S98H
 0FCfEbRGWyo/1C5x3+YL2T4Z+YsB9IcvDrtlnIgcKhUhqsmOxqvTD+NWyf5q8B76mXUEN5
 5oNzad17rT+3SHX03p3YtPB5IYEtUY88RnIRW9qAggvL74Ih7I506P8YyCBR1w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 15:47:41 +0200
Message-Id: <DI4U2DT3OBMR.23T3F7X8P75RU@bootlin.com>
Subject: Re: [PATCH v2 08/11] drm/bridge: adv7511: switch to
 of_drm_get_bridge_by_endpoint()
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
X-Mailer: aerc 0.20.1
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-8-4300744a1c47@bootlin.com>
 <TY3PR01MB113466B70BFD2899AB0CF47AD86372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134674FDD088299A4382D3D286372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <DI4TGV2WURTY.39OXE7WWKRLA1@bootlin.com>
 <TY3PR01MB11346E82D19FBE8544F51624286372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346E82D19FBE8544F51624286372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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

On Tue Apr 28, 2026 at 3:31 PM CEST, Biju Das wrote:
>> >> > @@ -1251,10 +1251,9 @@ static int adv7511_probe(struct i2c_client
>> >> > *i2c)
>> >> >
>> >> >  	memset(&link_config, 0, sizeof(link_config));
>> >> >
>> >> > -	ret =3D drm_of_find_panel_or_bridge(dev->of_node, 1, -1, NULL,
>> >> > -					  &adv7511->next_bridge);
>> >> > -	if (ret && ret !=3D -ENODEV)
>> >> > -		return ret;
>> >> > +	adv7511->bridge.next_bridge =3D of_drm_get_bridge_by_endpoint(dev=
->of_node, 1, -1);
>> >> > +	if (IS_ERR(adv7511->bridge.next_bridge) && PTR_ERR(adv7511->bridg=
e.next_bridge) !=3D -ENODEV)
>> >> > +		return PTR_ERR(adv7511->bridge.next_bridge);
>> >>
>> >> Does it crash, if the error is  -EPROBE_DEFER?
>> >
>> > I see a crash with patch [1], which is fixed by avoiding the direct as=
signment.
>>
>> Ah, dammit! Good catch, thanks for the quick testing and follow-up!
>>
>> Indeed this driver assumes next_bridge is either NULL or a valid pointer=
, but due to the 'if(IS_ERR()
>> && some_other_condition)' now it can also be -ENODEV (not -EPROBE_DEFER,=
 but that's irrelevant).
>>
>> This affects the msm and zynqmp_dp patches equally.
>>
>> I'm sending a v3 soon with these fixed. I'm just not sure which approach=
 to use to fix (same for all
>> the 3 patches). Alternatives are:
>>
>>  1. -ENODEV is accepted, set next_bridge to NULL when it happens:
>>
>>       -       if (IS_ERR(adv7511->bridge.next_bridge) && PTR_ERR(adv7511=
->bridge.next_bridge) !=3D -
>> ENODEV)
>>       -               return PTR_ERR(adv7511->bridge.next_bridge);
>>       +       if (IS_ERR(adv7511->bridge.next_bridge)) {
>>       +               if (PTR_ERR(adv7511->bridge.next_bridge) =3D=3D -E=
NODEV)
>>       +                       adv7511->bridge.next_bridge =3D NULL;
>>       +               else
>>       +                       return PTR_ERR(adv7511->bridge.next_bridge=
);
>
> The point is you cannot return PTR_ERR as it will lead to crash, if it is
> direct assignment.

It would definitely crash when the next_bridge is dereferenced (which
happens in adv7511_bridge_attach()) but I don't see how it can crash
here. Here it _can_ be assigned -ENODEV, but it would be immediately be
cleared to NULL, or to enother error, but we'd immediately return. And in
case of return, when next_bridge is cleared by __drm_bridge_free ->
drm_bridge_put, the error value would be ignored thanks to patch 1.

>
>    if (IS_ERR(adv7511->bridge.next_bridge)) {
> 	int err =3D PTR_ERR(adv7511->bridge.next_bridge);
> 	adv7511->bridge.next_bridge =3D NULL;
> 	return err;
>   }

Is this if() condition wrong? The driver needs to accept the -ENODEV return
value, the next_bridge is conditional in the curent driver code.

>
> Cheers,
> Biju
>
>>  2. let nexxt_bridge hold -ENODEV but ignore it when it is used (only in
>>     the attach op, for all 3 drivers):
>>
>>       -       if (adv->bridge.next_bridge) {
>>       +       if (!IS_ERR_OR_NULL(adv->bridge.next_bridge)) {
>>
>> While the latter approach involves less code, it might let errors sneak =
in in case new usages of
>> next_bridge are added with just a NULL check.
>>
>> Opinions about the two?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
