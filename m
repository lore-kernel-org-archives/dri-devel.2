Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B181C982DA
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AFD210E079;
	Sun, 20 Sep 2026 22:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OcHgpT1x";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E53F10E079
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 22:26:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D7100449F9
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 22:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8141F0089A
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 22:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789943175;
 bh=OZ0jYotdh7ql4qVQopBl9OhnmROuW0b1nFBPITg46xA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=OcHgpT1xwIO6XWROQZZtX0pP7rtvLkq5r+4C9tDUCySI/aHerQeHmuoGb280LlR7k
 kFhNUn+GqhwuRliePOfHEBYyn7A1//D2+tB41XNUVXh8fVuQJNgDDpOfzagYu7lTeS
 vTmTNWBIwMt61BJSLWQJ2F3TAkuAQ4/QUOU8MTxm8x+uS7KL+YfwjMsf02PjLHE5TE
 zHjXQDvyHm9RemWH9GeXYHwPrZ3I+Er3ID5hNWumjVobOl5SNWq+3ROOk7f0eqweOC
 yvedHq1a3zS00PZfnmfBlJv+8Y56bRJschNdI1KFW2dqtDkPS3UU3dTmtSLndujkca
 /eIM6LOzE+ybA==
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b8b402f4e3so2451838e87.2
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:26:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBw9YMy2goW0ikGcBwV5Q5Y9hZ7WD6CZMUaK1FRG5JQdJ3SbXRS6vukCiJngU7hyFuMS5IFyAts4yME=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kR7qurstWpoXOpr+Cbz/d0in3S4ydWdkLzpo6DzDM3BBjY7Dcf
 tykSA1ILydqfD8gahrMLctbcbIz7VJIMp8ecoW0WFeS+AVcfLLznFZCt0Go/HfB6MSpaxXJxHA4
 GNs4c5hu5ys0PXBizVLIoytA9Bn7P1NA=
X-Received: by 2002:a05:6512:1293:b0:5b8:9ee1:10fd with SMTP id
 2adb3069b0e04-5b8c195b2a3mr2597654e87.32.1789943174146; Sun, 20 Sep 2026
 15:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-11-83afb4f1a707@bootlin.com>
In-Reply-To: <20260916-drm-bridge-every-panel-v3-11-83afb4f1a707@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:26:00 +0200
X-Gmail-Original-Message-ID: <CAD++jL=Hu4XDUoBK5RfaQ9K3Jh4NfPkGFfoxa2tL_zSekPEUBA@mail.gmail.com>
X-Gm-Features: AcwNN1UOMCqRmdLLuJ0tewhusvy6SfVdZOwl8-NuoTCzIELTWmTcNqdeLCv7gec
Message-ID: <CAD++jL=Hu4XDUoBK5RfaQ9K3Jh4NfPkGFfoxa2tL_zSekPEUBA@mail.gmail.com>
Subject: Re: [PATCH v3 11/19] drm/mcde: dsi: remove unused includes
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jessica Zhang <jesszhan0024@gmail.com>,
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

On Wed, Sep 16, 2026 at 3:47=E2=80=AFPM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:

> The helpers are included but unused.
>
> However symbols from drm_atomic_helper.h are used, and were previously
> available as a side effect of drm_atomic_helper.h including
> drm_atomic_state_helper.h. Add drm_atomic_state_helper.h.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
