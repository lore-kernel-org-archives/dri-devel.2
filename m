Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845BBCD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 22:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A0A10E896;
	Mon,  4 May 2026 22:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j4AwNg2h";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C75B810E896
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 22:47:39 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-bab8ae52954so695612766b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777934856; x=1778539656;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EFLAQZTvZr+bNwaBPn0b1qZPFp/QiS7LgKDiG9a6TU=;
 b=j4AwNg2haXpE5qpp4ft1+Q74l7Oj5axJTb/dkTygKsSGnt+f+vIZlnKukSPl4iHBlh
 /Jv+Y5ShPLeKpIWYk9wJoTP6MadTkSnQvleYTVTSF1BO1eUCKYPxOzxg8xLZLgJiwtYX
 V+Bqn3ur6eiyQuRNp6Z1qD5GnJHT+jHGXH08g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777934856; x=1778539656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7EFLAQZTvZr+bNwaBPn0b1qZPFp/QiS7LgKDiG9a6TU=;
 b=kuWjOKRfqXv70d6vIPaVr8o01GxXvpzj5wVuq+B5oubUaOLaIq7d7+4DQTi3lEwe3w
 rrL+59cZoxSBXYUl9+0ZsnfNKg1FFLElKqcl9gUKckaHndBMYjOWa0u5jB8CwIAJZEKQ
 IKbS85CmFtdCaOhkAVQivYPcO1Fma42sDd6L+oda8Ls1R8BBB71PzvR/n1PjKRW42xf4
 FvgDi5YW3fvhOo+MdOTKgVdmHN4zybpCJoOqCDT/aWcbTzyBnGrnywc9sV0t6pc/KJH9
 otJmHykcEZ8s8SOzbf49Jd+c3eG6IT3m8MrKDGFNgFlhx2ksRowKuTQBRBG6MV3pH03s
 c34w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HEQcX77WCr5ARDuArgxyLokjtpV3FkvC2rS5Hhe7ZWT/XjOFvaQSSsa7pKiXA2UcqWPTSLu9JWgk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFCViVI8ZoTMlYQ1JoHsZD4ZYtJWNP7F4j9/1Pvn5W0Lw1mtAo
 80HJRzROvO/lxVNGlkR7BBLLl0KAkgzkI0dhki4t+XJjIL74BgrDbYso8mA/gduMSzjwh0MGNco
 1E7U43g==
X-Gm-Gg: AeBDiesNmoS9h2x+0io5G6KdrI7UtD4xPXLjsOSnjwTIqxOkHJcOZwONp3Y+e8aVAZ0
 O5tTas3Sl6mXR+oEQuRCxLeDLeCUItqH/WGiwCJr2AQo8E/cuiRimWEf5wsdaxKLP7E6N6X68j/
 L3Nqu6XeLfTqavbgwp6uQw1Qi7ODl/q+m6mF+/FQkSD45pbKN9hYUpCTw/CuBsTXVCgDnSy5mRV
 XmChKtuQVklsIVZ5mYJVEYBHfTzR4Oqojjlzz4njg16tn9bc/tLF4WQDOWtdf9geQk4/Tl2ypau
 lAGKz9GEgvF5/fRHM375Tp0m8wriw/1bJ2vEP0JM7KAI6rXA/pEe+3O39BnOz9u/Mdy/63fALrl
 AIgxUaoBNsCvaxzN2deDSWztQ2AC7ZY1RwfqqBZqadM/YbyNUm59sl93zPWU/o5FlnxdreXHLY7
 8z5H5dhFAYA6Rw00KzkI5veOpqkSkEADm3J6Dag0UKbVS8PxE1rrf6VQEmGf+GR9kV1emNAbrTO
 zW8p2Bn1jM=
X-Received: by 2002:a17:907:9703:b0:bc2:d964:72f4 with SMTP id
 a640c23a62f3a-bc2d9647379mr288284366b.14.1777934855867; 
 Mon, 04 May 2026 15:47:35 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
 [209.85.221.50]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bbe6aa5865csm427218266b.27.2026.05.04.15.47.34
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 15:47:34 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso1766815f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 15:47:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8zBIVTzNOOHbC3o8/IShq4y2SyInhkFhVf937FpP9Peaz95zFIyGDFlYP1549f5CaR5IRl0O8QBYE=@lists.freedesktop.org
X-Received: by 2002:a05:6000:44d7:b0:44d:821:1a0b with SMTP id
 ffacd0b85a97d-44d08211b96mr10576224f8f.29.1777934853301; Mon, 04 May 2026
 15:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
 <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
 <d9faab05aab120fee367394edcb35bd131c97646.camel@iscas.ac.cn>
 <CAD=FV=X-FUw_MqE2ufv=ngBS3ho4vg-QKokav+MeP7XAAjXUbg@mail.gmail.com>
 <151c1c1d52fce8c3b1dac3a919be3086ce3426df.camel@iscas.ac.cn>
 <CAD=FV=XPAWEiN4EFvY0sA7uEBqxpc0iiD28Y9BmpguoerG1hpg@mail.gmail.com>
 <d349eb9a8632d847eca48ece1e6c88b717dddde1.camel@iscas.ac.cn>
 <CAD=FV=USy4DWrkKrhqbUGR5JWJzcJz_J1PVt0Z=o_LVn_iON-w@mail.gmail.com>
In-Reply-To: <CAD=FV=USy4DWrkKrhqbUGR5JWJzcJz_J1PVt0Z=o_LVn_iON-w@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 May 2026 15:47:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U-LPUGyuEYS1fj7N+x-bHExVGQb+K0Y+BghSTALFCXXg@mail.gmail.com>
X-Gm-Features: AVHnY4ImODE6ejb7j0AN2nutpolTGLLLL7T5afsRsY5Tf0sxdNKbt3HVLiqE74Q
Message-ID: <CAD=FV=U-LPUGyuEYS1fj7N+x-bHExVGQb+K0Y+BghSTALFCXXg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after sending
 disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 28, 2026 at 1:52=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> > > > > > > > Cc: stable@vger.kernel.org # 6.11+
> > > > > > > > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out
> > > > > > > > as
> > > > > > > > separate driver")
> > > > > > >
> > > > > > > This "Fixes" looks wrong. The bug was still there even before
> > > > > > > the
> > > > > > > driver was broken out. ...and it looks like the driver that
> > > > > > > this
> > > > > > > was
> > > > > > > broken out of (panel-boe-tv101wum-nl6.c) still has the same
> > > > > > > bug?
> > > > > >
> > > > > > Yes, but I think the fix shouldn't be propagated to the other
> > > > > > driver
> > > > > > because of the same reason with breaking out the original
> > > > > > driver.
> > > > >
> > > > > ...but doesn't all the same logic apply to the other driver?
> > > > > Nothing
> > > > > ever adds MIPI_DSI_MODE_LPM back in.
> > > > >
> > > > > Even if you don't fix the other driver yourself right now, the
> > > > > proper
> > > > > "Fixes" tag is when the problem was introduced, not when the
> > > > > driver
> > > > > forked out.
> > > >
> > > > I think the Fixes tag should point to where the driver is forked
> > > > out,
> > > > and if I'm going to send a patch for panel-boe-tv101wum-nl6, it
> > > > will
> > > > has a Fixes tag pointing to the further commit affecting that
> > > > driver.
> > >
> > > You're free to have your own opinion, but that doesn't match my
> > > understanding of the Fixes tag. If you can convince Neil or some
> > > other
> > > drm-misc committer to land your changes with the Fixes tag as you
> > > have
> > > it, then I won't object, but I won't land it. Best of luck!
> >
> > I checked the forking commit, and the forking process doesn't involve
> > moving a `dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM` clause from the pane=
l-
> > boe-tv101wum-nl6 driver to the panel-himax-hx83102 driver, which means
> > that this clause in the new driver is new, and shouldn't be trivially
> > backported to the old driver (because this process will affect other
> > non-hx83102 panels in that driver). Even if the unblanking issue exists
> > before the forking point, the specific code fixed by this commit is
> > created by the forking point (just by copying), instead of the previous
> > commit introducing the starry panel or the initial addition of the LPM
> > masking code to panel-boe-tv101wum-nl6 .
>
> In general in Linux drivers support more than one device. If you have
> a fix for a driver, then you make the fix. You don't couch your fix
> with "if (this_is_the_device_i_tested) do_my_fix()"
>
> Said another way, if we hadn't forked support of this panel into a
> separate driver, then you'd _have_ to be fixing to
> panel-boe-tv101wum-nl6 driver, correct? You wouldn't add a special
> case just for your panel--you'd fix it for the whole driver.
>
> Another argument here is that someone could (conceivably) still have
> an old kernel built from before the driver forked out. Maybe they care
> about supporting "panel-himax-hx83102" panels on their old kernel.
> They'd want the fix tagged so that they could find it.
>
>
> > In addition, this isn't a regression fix, so Fixes tag is only
> > informative for backporting. The previous paragraph has already proved
> > that pointing it further isn't meaningful for backporting.
>
> Sure, it's not a regression, but it's still a fix for a bug in the
> panel driver. I don't know why someone wouldn't want to backport it if
> they were using this panel.

I see you've now also got a fix for panel-boe-tv101wum-nl6.c [1]. If
that patch also lands, then IMO this becomes fine.

[1] https://lore.kernel.org/r/20260503091708.1079962-1-zhengxingda@iscas.ac=
.cn/

Reviewed-by: Douglas Anderson <dianders@chromium.org>
