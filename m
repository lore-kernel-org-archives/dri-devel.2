Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF3EC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8640F10E2E6;
	Fri, 25 Sep 2026 16:25:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SkZTyo4x";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 653D510E1E2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:25:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 70AE06022F
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288261F00898
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790353552;
 bh=6fYDLPuw7TdEq9beCl8lZHCEAKip/STw7RgtlWkrkg8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=SkZTyo4xxfFfIHkKIcVzKt/r6NVyGCRHYPlxBuj/CfdOc5/UiPnHhsNeysafJ83uT
 PrsApt20TbtzJyRpj/ArQV+ysPRtw70TjqJbVdGUsvZcqDtlWD9Kq6uCr9e2hR5TcQ
 WqHkFq31PmtukKbdE6y/W8GS9/XSR4o73yuajz9jGmCx6GdhINz2kzewMKYZle40Rz
 Jc4eglh/tm38aa+rDhaE+rYk23PpYcf8o3TBVaTamJ/idDzDGvcrFiD2suq/GxYFWK
 zgFkLbpLOozrM5LhUI306UQ1mmZ30ZjqiBsz8Sk4d6Pq2YHLUgL3h7x5LiWU8/PFE8
 PJ7V94nNq5nFA==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b8eb39a8edso580398e87.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 09:25:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwVHHp2wVy5Xt0qpUIvpDX8phALETJND3SVb8tXSSlbx69lsoJUfdZJx/XIZLKnAPL+axgO4aZoJTY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kWo5TDQhQz9xfzukdlQv4IwComK881YWPpjFsDIn6bYPtGiuLy
 vEPWt6uvu/GaunudqkKzZ8cTTU5EpZUy4wMg+OpR4/w0vMcr9LCLulZe19c2e07CmBgMNKacbiK
 8VFrWU1XEyMLu4g2x4FLm0T7Ab/zDztI=
X-Received: by 2002:a05:6512:1344:b0:5b6:1a7c:59db with SMTP id
 2adb3069b0e04-5b8df0d22f7mr2083445e87.53.1790353550897; Fri, 25 Sep 2026
 09:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-12-83afb4f1a707@bootlin.com>
 <arInho2bsfJiCgjV@houat> <DLNCQEG62F5N.O98WAO4U2FJO@bootlin.com>
 <CAD++jLkk-a0MrQUiaDD8OoDDoYVwBwSjFTj5ZBy=Xo7MS4+01g@mail.gmail.com>
 <arTlpd-KAsVpj3UH@houat>
In-Reply-To: <arTlpd-KAsVpj3UH@houat>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 25 Sep 2026 18:25:35 +0200
X-Gmail-Original-Message-ID: <CAD++jLmktDoqn2EbXsNnyGRudo-q2NCxUf+9ZjeU+WrY4CBMWw@mail.gmail.com>
X-Gm-Features: AclHuK_fq2ZWJ1A-qMmc6hpV7kHeTfdnkXq9HUzMYWRHIkAmDRIf8rPpfyjUW1o
Message-ID: <CAD++jLmktDoqn2EbXsNnyGRudo-q2NCxUf+9ZjeU+WrY4CBMWw@mail.gmail.com>
Subject: Re: [PATCH v3 12/19] drm/mcde: dsi: don't create a panel_bridge
To: Maxime Ripard <mripard@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 Paul Kocialkowski <paulk@sys-base.io>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Albert Esteve <aesteve@redhat.com>, 
 Anusha Srivatsa <asrivats@redhat.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
 asahi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
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

On Thu, Sep 24, 2026 at 10:57=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
> On Thu, Sep 24, 2026 at 09:51:53AM +0200, Linus Walleij wrote:

> > > Linus, unless you have more info I'm going to apply the patch as
> > > is. Removing this special case would be welcome as a later patch.
> >
> > I'd say go ahead as-is.
>
> I'm fine with that, but I really want this removed at some point.

If Luca wanna fix this up (drop this path) that's fine by me,
else send a patch immediately after this is applied and I'll
ACK it.

> > I do have the idea to code up and submit the AV8100 encoder
> > and I have the hardware to test it, but every other user should
> > be using panels directly, and I would be the only non-panel
> > user so I can deal with it when it comes up.
>
> It won't change a thing. All existing "panel" users will be bridge users
> after this patch is merged. So whether you want to enable a bridge or
> not shouldn't matter, the only thing that does is whether the existing
> users would still work.

I know, all it does is create a snag that I would run into myself.

But it's not gonna be a problem for anyone else, that's all I meant.

Yours,
Linus Walleij
