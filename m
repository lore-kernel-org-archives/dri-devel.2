Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D7ACA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D6B10F591;
	Thu,  1 Oct 2026 06:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Eb7QsxdV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93BF010F588
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:59:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 18E2E60234
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3F61F0089F
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790837979;
 bh=QJwfbKCyn/gh6UMXa/B9wDnCdxqQxEqYbYvEbOHcRzo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Eb7QsxdVvwC6Q6ASOE6RHWopINjqmVsM+asCISC8KzX4TbbjLlLnsFGewjxLBiuAL
 USpbOV25b9ZmxZxGODhRZ/pIOUEV4j/7ISqQiq/4Q3iBTdt2DVLljYevQD1l6XoyiL
 /6myJolVu0oJo4EALqct9L6A2ND53yX9mOAI/X1jCNzZ1CH/ZbM+48f/OViR41yaiE
 YSWVB+jXEhQSQQdD456ShpIZi68mzYXHl+aRD0Dw6RexksYrZgHbY19oPl/9V4B29b
 xtsP823iFmnkNIANNLcxBYI21WhoxAkFuarvbrBPjvq3midaRtXgYMBNaY+ttNwSXN
 HLUC7j9fQRUAA==
Received: by mail-lr2-f39.google.com with SMTP id
 38308e7fff4ca-3a77da28307so11226671fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 23:59:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwnUTclyof70OSRc2bW9a0bm8NsUHgIISh0hAmUcLepsQBz2oMmWVT9k1ZKIamiWwkbWrSWtJhdSn4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLIfUzSp2YxSkmC5i53c1quETh53xSw6BwWJ32s/a+ET7r+VCyX
 zw1txeX1wn8CFTbLeRH6LqNA+FKYvLpqEuORMwxb+5s8z/s+ai1HFsIINnY20rsFd2wxmIQVK+j
 H3zegWR3rimk79AVkG8oG6tRIImr/pOs=
X-Received: by 2002:a2e:a99a:0:b0:3a7:812b:d0b with SMTP id
 38308e7fff4ca-3a7812b1f22mr7437971fa.11.1790837978465; Wed, 30 Sep 2026
 23:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-8-83afb4f1a707@bootlin.com>
In-Reply-To: <20260916-drm-bridge-every-panel-v3-8-83afb4f1a707@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 08:59:25 +0200
X-Gmail-Original-Message-ID: <CAD++jL=G5ObsdvbhHFsEOeGYQFSd8Ggo7jaEupRTEdPmQD1e1A@mail.gmail.com>
X-Gm-Features: AclHuK_sHPl7UkC73IJwZdQ3ifWpNCzHWYkFbMbP-K9-g_pDmrUnJv1iVcxQNBo
Message-ID: <CAD++jL=G5ObsdvbhHFsEOeGYQFSd8Ggo7jaEupRTEdPmQD1e1A@mail.gmail.com>
Subject: Re: [PATCH v3 08/19] drm/todo: add entry for removing the
 panel_bridge API
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

> Now that a drm-bridge is embedded into every drm_panel during the panel
> creation, the panel_bridge does not really exist anymore. Its API has bee=
n
> deprecated and kept until drivers convert to the bridge API.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
