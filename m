Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6114FC98315
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8707C10F37E;
	Thu, 24 Sep 2026 07:52:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ptqlc8kx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1EB10F37E
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:52:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C620F4478F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA63E1F000FF
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790236329;
 bh=flhXc27wZ7lq+96q79C1lo9pyNK1W5OvD7SOTlgsYQY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Ptqlc8kxRS/O4MemHmjZ01Ds3sA61fs3CTI+JusAagmLQsN1Akqn2+RqNvZW8Uu1B
 fkVtGl19o2GvoAfTGg+wN4khUgWOJ9FZX6ktZ8KPNQnifbt782gXCEup9k83OVKU2t
 EPotrLbjrIE8X+v32os82VcQO6ZZF9OCqIB3J9O376A1cE7zOP/KVOHPHmH04n7+6z
 tdkyUv/Up2f/Iz9O8fAfZSk8Nri0naYfsAwGJoOlvBHaXT1tsMl7JNC0kw9wS2Iska
 V2pq+RIOw9lvDpy2GpXUcGS99+p1HdKg7KmPutL/KHb/YUGMP+2Bo5mPAMtHNBa5Oe
 8VnDmcBpmgBvw==
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a47f740839so16500661fa.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 00:52:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBytrwlxj3m4V08L4WflXSOwKxm7y828kMfHw+8nhWjlCR29uyNrKZ1XEn/5LxGQxVZLtagK71YRtbU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mJYYFP2numrbzreUhX74moykx9dIQC+i8A2tbKVeF8gyvOKdA6
 bTMMTHD8+tgRIlM5Q4Tl2FQGh7+JtfHEqOH9GN4vXX5EVJnD+rOqh4lAzqPAcg4iONFCKkWlp4W
 JaguQN/J5TG1yvYIEkSTtv8s5Mdy0z1M=
X-Received: by 2002:a05:6512:6c8:b0:5b8:b419:b7b with SMTP id
 2adb3069b0e04-5b8e0a18d1cmr355916e87.49.1790236328001; Thu, 24 Sep 2026
 00:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-12-83afb4f1a707@bootlin.com>
 <arInho2bsfJiCgjV@houat> <DLNCQEG62F5N.O98WAO4U2FJO@bootlin.com>
In-Reply-To: <DLNCQEG62F5N.O98WAO4U2FJO@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 24 Sep 2026 09:51:53 +0200
X-Gmail-Original-Message-ID: <CAD++jLkk-a0MrQUiaDD8OoDDoYVwBwSjFTj5ZBy=Xo7MS4+01g@mail.gmail.com>
X-Gm-Features: AclHuK8rPixm6Txa-uGEDmLc8FjUZWkrHeBO_IgguNN-8bSfUZSDFWgY_JslL90
Message-ID: <CAD++jLkk-a0MrQUiaDD8OoDDoYVwBwSjFTj5ZBy=Xo7MS4+01g@mail.gmail.com>
Subject: Re: [PATCH v3 12/19] drm/mcde: dsi: don't create a panel_bridge
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maxime Ripard <mripard@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
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

Hi Luca,

sorry for my slowness!

On Thu, Sep 24, 2026 at 9:01=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
> On Tue Sep 22, 2026 at 9:09 AM CEST, Maxime Ripard wrote:

> >> -    } else if (bridge) {
> >> +    if (!bridge) {
> >> +            dev_err(dev, "no bridge\n");
> >> +            return -ENODEV;
> >> +    } else if (!drm_bridge_is_panel(bridge)) {
> >>              /* TODO: AV8100 HDMI encoder goes here for example */
> >>              dev_info(dev, "connected to non-panel bridge (unsupported=
)\n");
> >>              return -ENODEV;
> >
> > I wonder if we still need that branch. Every panel is a bridge now, and
> > it looks like we don't have any specific panel handling in this driver,
> > so I guess it supports bridges already?
> >
> > Linus, do you know why this condition was here in the first place?
>
> I had the same thought while writing the patch, but I chose to be
> conservative.
>
> Linus, unless you have more info I'm going to apply the patch as
> is. Removing this special case would be welcome as a later patch.

I'd say go ahead as-is.

I do have the idea to code up and submit the AV8100 encoder
and I have the hardware to test it, but every other user should
be using panels directly, and I would be the only non-panel
user so I can deal with it when it comes up.

Yours,
Linus Walleij
