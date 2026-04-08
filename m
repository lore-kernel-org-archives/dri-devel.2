Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A858710F995A
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 16:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186DC10E6A0;
	Wed,  8 Apr 2026 16:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fe7dq0uA";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B8C10E6A0
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 16:13:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id C87A9C5AA9A;
 Wed,  8 Apr 2026 16:13:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6F132603CE;
 Wed,  8 Apr 2026 16:13:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4291E10450178; 
 Wed,  8 Apr 2026 18:13:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775664801; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=MRJccs/yXhZXrol0PlFNh+O96bobEH1wbfkeJR4WMXo=;
 b=fe7dq0uAeunZo9tbVAmLRxBBtb3GuAIYN5p7j9dsg2braHMsWcRATiugINedke7jdsF7H2
 jWy4DWMhNnY6c2SJVBMDo/axBrMpcNSIQ8+vY3Nk3PKRZVcCYq6miJu7AMgHo8A0PSc8XK
 TjsFouHXTDDImpJia1MkbEt2aIPaKGPktJtXlyzUeKfpNfOUWIrTdVFhpbis4MO+TSXM8b
 RE9aW1xGh+u9vAOmiYU4uMJbFzZ5Tg38grgVHIe2gdmlBYNBlqmGrRRbMkDgQ+KbnBgfIx
 qAa7Sjc8+23dxHNg3Mh8qbRv/k14q4eNMTOW1hm98ToU1KzLyfAstms0xAe3Kg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 18:13:16 +0200
Message-Id: <DHNWMY5OQVHR.1S2JGRWDXNNRG@bootlin.com>
Subject: Re: [PATCH 3/3] drm/bridge: ti-sn65dsi83: add test pattern
 generation support
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Louis Chauvet" <louis.chauvet@bootlin.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Marek Vasut" <marex@denx.de>, "Linus
 Walleij" <linusw@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com>
 <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-3-2e15f5a9a6a0@bootlin.com>
 <bde82b04-ba23-4324-8ee4-179e8a2cdae3@bootlin.com>
In-Reply-To: <bde82b04-ba23-4324-8ee4-179e8a2cdae3@bootlin.com>
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

Hi Louis,

On Wed Apr 8, 2026 at 5:40 PM CEST, Louis Chauvet wrote:

>> @@ -645,7 +649,11 @@ static void sn65dsi83_atomic_pre_enable(struct drm_=
bridge *bridge,
>>   			  REG_LVDS_LANE_CHB_LVDS_TERM : 0));
>>   	regmap_write(ctx->regmap, REG_LVDS_CM, 0x00);
>>
>> -	le16val =3D cpu_to_le16(mode->hdisplay);
>> +	/*
>> +	 * Active line length needs to be halved for test pattern
>> +	 * generation in dual LVDS output.
>> +	 */
>> +	le16val =3D cpu_to_le16(mode->hdisplay / (sn65dsi83_test_pattern ? 2 :=
 1));
>
> This will always half the line length, even for "mono" LVDS output no?
>  From the comment I expect something like
>
> if (dual && test_pattern)
> 	val =3D hdisplay/2
> else
> 	val =3D hdisplay

Aargh, my bad! I think what my brain wanted to write was rather:

   le16val =3D cpu_to_le16(mode->hdisplay / (sn65dsi83_test_pattern ? dual_=
factor : 1));
                                                                    ^^^^^^^=
^^^^

which is equivalent to your code. Will fix in v3.

Thanks for the thourough review!

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
