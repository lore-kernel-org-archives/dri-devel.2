Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBFAC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E8E10E7CA;
	Mon, 24 Aug 2026 14:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SMAlbzKZ";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96EDE10E7CA
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:15:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 72B751A17F1;
 Mon, 24 Aug 2026 14:15:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 284EC5FFC1;
 Mon, 24 Aug 2026 14:15:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8C3F111C7960F; 
 Mon, 24 Aug 2026 16:15:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787580928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=fDfp3NHZrd988nm512Rv8Wp1AlDvw7budIHe/KVemzQ=;
 b=SMAlbzKZtIDsTBVND+4uH39mO4f15QMchLezjx0xEb3e5uw1HDbfBrJeU4oTTHB7B32DD3
 gHLyPPoEE4X8Xz3HGwRWTN7Z1i08zGU039VKvxJQeMIMbvAD5irvlN6MOIuzS8q9ro5D5s
 w0iPc/1uWiRDO14kpbAMgSQ/68K/5juDDyIY+pfYf5FICqhMdTCEooOmXhHpVRDwjPH+BS
 feyCEV1+1JmSvfshmjKYHq1Pi38BXuw+4QQDZo3+euQsMHZu8p3PiCD8WLXkT4irRTPss5
 ASxL5dzsR6SZ3GCfxGJb74n1Xue0YrArAMF212YKZQnVVtqvZ80i3YWCwuKNBA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 16:15:18 +0200
Message-Id: <DKX8JT5WE9O0.2J5YV3529H80A@bootlin.com>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Linus Walleij" <linusw@kernel.org>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>,
 "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 03/11] drm: of: drm_of_find_panel_or_bridge: prioritize
 the bridge, not the panel
X-Mailer: aerc 0.22.0
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-3-19cd5277cc8d@bootlin.com>
 <20260817-wonderful-helpful-falcon-db81c9@houat>
 <DKR7S2SRVHJG.2Z6RK35N9X4JU@bootlin.com>
 <20260824-bouncy-papaya-cat-2c2073@houat>
In-Reply-To: <20260824-bouncy-papaya-cat-2c2073@houat>
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

Hi Maxime,

On Mon Aug 24, 2026 at 10:16 AM CEST, Maxime Ripard wrote:
> On Mon, Aug 17, 2026 at 02:23:05PM +0200, Luca Ceresoli wrote:
>> > That being said, if we do create a panel_bridge for every panel, why d=
o
>> > we still need drm_of_find_panel_or_bridge()? We'll only really need
>> > of_drm_find_bridge(), no?
>>
>> Yes, in the long term we can get rid of drm_of_find_panel_or_bridge(), b=
ut
>> not in the short term due to the above mentioned drivers, and others whi=
ch
>> use it in "creative" ways.
>>
>> The point is about the transition. This patch was an attempt to convert =
at
>> once all the many drivers which use the most common pattern:
>>
>>       | drm_of_find_panel_or_bridge(..., &panel, &bridge);
>>       | if (panel)
>>       |     bridge =3D drm_panel_bridge_add();
>>
>> to then fix manually the remaining drivers (patches 6-11).
>>
>> But this approach doesn't fly due to the legacy users of
>> drm_of_find_panel_or_bridge() as mentioned above.
>>
>> So what about this other approach instead:
>>
>>  1. leave drm_of_find_panel_or_bridge() as is (it's already deprecated a=
nyway)
>>  2. keep patch 5 (which "breaks" mayt drivers which would create an addi=
tional
>>     panel_bridge)
>>  3. perhaps add a warning when an additional bridge is created for the
>>     some panel
>>  4. *in the same series*, manually convert *all* drivers to use
>>     of_drm_find_bridge() or of_drm_get_bridge_by_endpoint() -- like patc=
hes
>>     6-11, but done on all drivers
>>  5. apply the series atomically, because it wouldn't be bisectable betwe=
en
>>     items 2 and 4
>>
>> Your opinion?
>
> If we look at the drivers causing us troubles, fsl-ldb, samsung-dsim,
> tc358767 and waveshare-dsi can be converted directly to
> devm_drm_of_get_bridge().
>
> mcde-dsi is a mess and would be hard to fix indeed, but since it's the
> only really troublesome one, maybe we can just duplicate the code in the
> driver and drop / rewrite the common code however we see fit.

Note there are many more drivers than those converted by patches 6-11 of
this series (see cover letter). So it would be a lot more work.

But based on your reply I assume you approve the 5-point plan above. Please
let me know if my understanding is incorrect.

Also note my plan is to try converting all drivers, definitely removing all
calls to drm_panel_bridge_add() and variants but not necessarily
drm_of_find_panel_or_bridge(), which then might exist for a longer
time. I'll see how things go as I look at drivers one my one.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
