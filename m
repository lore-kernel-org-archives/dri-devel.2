Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60E6CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2613010F590;
	Thu,  1 Oct 2026 06:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZTEqIekg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C2410F588
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:59:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5CD344795
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DD91F0089B
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790837966;
 bh=adKEV0wp8fnkm3B2gVtkxUbYQ0N4xZbbOvQZcLnu0xk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=ZTEqIekgpZghTg8Qn8vwEmbcMeMYl2MORgJxn3aIHii9lmlTTHXZULIZaVG6qSbBU
 P1GpvEyVhrBhMi/mxpGoxmyOhDj0twY5/81waMYx34MNJYpyJW/LGUPeAxIk4Gb3tS
 291yIQxl1AzJd+hKdqlRFd6inzcyYydgb3tNfWPDRy9FVVDUzeGQbpXp2S02THGyJO
 cBNMWgzFXyDjGvG+KjD2jVAWTdEuZ5SPtgBv4hf/VJBW5T/eR3p7ntSCwVWjJbxHS/
 EtdsuoEljzPiJkqs+B/W+oywc3R6jty9xcO198geJNwEC8Z9ZM5JTuumBUxhIb+jXo
 21JWDU1ZRilHQ==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5ba3ae12b79so1533517e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 23:59:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxRncNesTLmH5e7bbGkU6Q3cGjjcUdzKbREYe0XWsK44yuxrEQLYgixW3+zUqmsz7UHJpgJVx11SDg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKkpB2H0VHnNavVW8lnbOx6CFaFoi7j446DdZclhbq/OfeePIK4
 wqmjJFUbqmyaWaqGPwGDX5TzxRxyN8dcVJnLL8ct0rw4Z9Vh1Y1HVgIZYTjZT1xujap8bL0T4C0
 KX36aC2ZlmiTklPAFSpygmbXTIVU9KpQ=
X-Received: by 2002:a05:6512:3ba0:b0:5ba:3b01:36a5 with SMTP id
 2adb3069b0e04-5ba405ee75amr1389712e87.14.1790837964923; Wed, 30 Sep 2026
 23:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-7-83afb4f1a707@bootlin.com>
In-Reply-To: <20260916-drm-bridge-every-panel-v3-7-83afb4f1a707@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 08:59:09 +0200
X-Gmail-Original-Message-ID: <CAD++jLkhYNZ4R4Z60zTzNoZwCtk4rcL-pCbgdHpNEzV-4oO_Wg@mail.gmail.com>
X-Gm-Features: AclHuK8feDgrhg1tWHz9y2oJ4IDmaC5Th2MaGXRPg_l1XDpQ6IeWaj3r9RadEo0
Message-ID: <CAD++jLkhYNZ4R4Z60zTzNoZwCtk4rcL-pCbgdHpNEzV-4oO_Wg@mail.gmail.com>
Subject: Re: [PATCH v3 07/19] drm/panel: deprecate panel-bridge APIs
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

On Wed, Sep 16, 2026 at 3:46=E2=80=AFPM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:

> Now that a drm_bridge is embedded into every drm_panel, the panel_bridge =
is
> not needed anymore. Its APIs are just accessing the embedded drm_bridge
> transparently.
>
> Deprecate them all, encouraging to use the drm_bridge API.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
