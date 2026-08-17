Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD3FC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91ECC10E78C;
	Mon, 17 Aug 2026 12:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fJDBLQ5j";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A0A10E788
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:23:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0BC651A16D0;
 Mon, 17 Aug 2026 12:23:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C7F0460352;
 Mon, 17 Aug 2026 12:23:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D62DE11C706C9; 
 Mon, 17 Aug 2026 14:23:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786969395; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=c/gdv7OZId9fPe0L7xLsAdhtfCiya83tRQmqh4pfoNo=;
 b=fJDBLQ5jhg+K2ia8B0EzwSDJdVgkPUC2BVFEOT5PE6axTO6exff5GA04uwvea9NqCWnaNe
 ls+YuksYEUoXRdXPrde4U+V7dM7OjSQtiCPAbNs+1hyNj8ZyTsX5vFJKPC6znFvznmDa5O
 OFv1PSYhn/NimL15wIL+4f08GWEJA8ICdoi/So2MXWR/0JNtwA1zVLnD5T6r7NojSVaiU5
 PjkxTTXXpR3K0hJcSv93WeDTMPSDHhNjmE0spQSHLWuLxGx7Zf4Ufyb6EU9D3Zpm4p9RW6
 myF/hBpsyG1QgxPOcXKBpuQBi0jnIgA8+uvYs9mZD7HubI1A86e9kLv0DfO69g==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 14:23:05 +0200
Message-Id: <DKR7S2SRVHJG.2Z6RK35N9X4JU@bootlin.com>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 03/11] drm: of: drm_of_find_panel_or_bridge: prioritize
 the bridge, not the panel
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.22.0
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-3-19cd5277cc8d@bootlin.com>
 <20260817-wonderful-helpful-falcon-db81c9@houat>
In-Reply-To: <20260817-wonderful-helpful-falcon-db81c9@houat>
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

thanks for the quick feedback!

On Mon Aug 17, 2026 at 10:26 AM CEST, Maxime Ripard wrote:
> Hi,
>
> On Fri, Aug 14, 2026 at 04:05:51PM +0200, Luca Ceresoli wrote:
>> By the documentation drm_of_find_panel_or_bridge() returns a "drm_panel =
or
>> drm_bridge", without specifying which one is returned in case both exist=
.
>>
>> Definitely it never returns both. If both exist (and @bridge is !=3D NUL=
L),
>> the current implementation prioritizes the drm_panel pointer and returns
>> that. In most cases (including devm_drm_of_get_bridge() and
>> drmm_of_get_bridge()) this is used to implement the following logic
>> (simplified):
>>
>>     drm_of_find_panel_or_bridge(..., &panel, &bridge);
>>     if (panel)
>>         bridge =3D [devm_]drm_panel_bridge_add[_typed](panel);
>>
>> Work is in progress to make every drm_panel automatically create a
>> panel_bridge, so a panel_bridge will always be present for every
>> drm_panel. This means the above logic would create a panel_bridge that
>> already exists. Avoid it by returning the drm_bridge when both are prese=
nt,
>> instead of the drm_panel.
>>
>> For the case where @bridge =3D=3D NULL, this commit does not change anyt=
hing:
>> the 'if (bridge)' body is never executed and the drm_panel (if found) is
>> always returned.
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> I'm always a bit concerned about that kind of change, because you
> basically change some part of the API we don't really know if a driver
> relies on.

Indeed, this was a pretty wild attempt to start discussion. And in fact
Sashiko found 3 drivers which would break: sun4i, fsl-dcu and tegra. I had
a look, some could possibly be fixed quite simply, but not all.

> That being said, if we do create a panel_bridge for every panel, why do
> we still need drm_of_find_panel_or_bridge()? We'll only really need
> of_drm_find_bridge(), no?

Yes, in the long term we can get rid of drm_of_find_panel_or_bridge(), but
not in the short term due to the above mentioned drivers, and others which
use it in "creative" ways.

The point is about the transition. This patch was an attempt to convert at
once all the many drivers which use the most common pattern:

      | drm_of_find_panel_or_bridge(..., &panel, &bridge);
      | if (panel)
      |     bridge =3D drm_panel_bridge_add();

to then fix manually the remaining drivers (patches 6-11).

But this approach doesn't fly due to the legacy users of
drm_of_find_panel_or_bridge() as mentioned above.

So what about this other approach instead:

 1. leave drm_of_find_panel_or_bridge() as is (it's already deprecated anyw=
ay)
 2. keep patch 5 (which "breaks" mayt drivers which would create an additio=
nal
    panel_bridge)
 3. perhaps add a warning when an additional bridge is created for the
    some panel
 4. *in the same series*, manually convert *all* drivers to use
    of_drm_find_bridge() or of_drm_get_bridge_by_endpoint() -- like patches
    6-11, but done on all drivers
 5. apply the series atomically, because it wouldn't be bisectable between
    items 2 and 4

Your opinion?

Kind regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
