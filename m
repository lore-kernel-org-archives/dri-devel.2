Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB9EC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB89910EC02;
	Mon, 14 Sep 2026 08:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UyPCHc67";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7970C10EC05
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:19:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 188A44375E
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10521F000FF
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789373953;
 bh=BKRDGeu9OvCqTSJJOcDI+h2SnvOE0ecpgpKwpnOvYSM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=UyPCHc67Us3q2zR+NJDKxDm67/vws1dIt1hKN5y7waD38ni2VcdByXvMd9h32BS1+
 wWXgDrKdAEgXuRGiR5+TgwtgE3Qqd+Heb9u6cvpLQorkhtQGvdiCa7yV0011YeIJMy
 C7hTVSvVpsQN5Hz0Uw0o7NQDpvOfSBQ1lmg1oIFt2Xoxu/RIagBiHWZqFMPKh4wn+u
 LIZ/4+IxoKkSSUcQNLweDZiLiFpCCKNKsNbh1QDsUGh5zZpF6OtJmNbFuzdFBAtGHn
 yDdY2nuC5GXdmk1pyOwlnH5Od2c7ktiRA8RRWKFn69TmR9qjKqkw665M+mvEdlK6Dy
 fvrxZJdp599og==
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5b4afc8465eso4186083e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:19:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzjgoNrNw7P1b0qlM4YpaYD+w5+9WK/+NFqD/QhpSJ+Lmu3+9zq3r4Q3NHO/hALxlKc1xe1kTv9dT0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5ntVnO7SjbWeOc3qXl1VldxjCD+DaWhuOD7bUZwDpNnhHX8m0
 7iyIFFy2rDNvNtJzH905WlTRP0/ZZuKsXALA8ygY0bodLaV9ABr+yQG0gL2oYk7ooTTnGWTguG0
 uzn052CXdlYa+DDfYJGoNsOLgyMYHvn0=
X-Received: by 2002:a05:6512:b83:b0:5b6:1a7c:fd81 with SMTP id
 2adb3069b0e04-5b8ae69e682mr379688e87.39.1789373951557; Mon, 14 Sep 2026
 01:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-8-19cd5277cc8d@bootlin.com>
In-Reply-To: <20260814-drm-bridge-every-panel-v1-8-19cd5277cc8d@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 10:18:57 +0200
X-Gmail-Original-Message-ID: <CAD++jLkqFPm99r4L_3whHG1N0k1aCCJj0sDjMRTZN-7mgBaAeg@mail.gmail.com>
X-Gm-Features: AcwNN1XU1jSnsxnc26IQx4SlPy6FXnURlodugh4j4_jBv3FHCcqi7b14XgKpGIo
Message-ID: <CAD++jLkqFPm99r4L_3whHG1N0k1aCCJj0sDjMRTZN-7mgBaAeg@mail.gmail.com>
Subject: Re: [PATCH 08/11] drm/mcde: dsi: simplify device_node management
 using scoped for_each variant
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Aug 14, 2026 at 4:07=E2=80=AFPM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:

> Before further modifying this function, simpify the struct device_node
> management using the scoped variat of for_each_available_child_of_node().
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

I applied this patch (8/11) to drm-misc-next.

Yours,
Linus Walleij
