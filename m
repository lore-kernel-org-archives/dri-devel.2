Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2622C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4AD110E78D;
	Mon, 17 Aug 2026 12:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C5LHORVY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C5489BAE
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:25:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1510944046
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01151F01562
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786969549;
 bh=FcusQ/AC2xra2d5KQuB4ytTUOO4cXXbsOAkQZeZaKmc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=C5LHORVYqsnn//mOdHBbwAywbNnPPvk3n+qtQUPu++E9aWSCw9nExrCCxl4ny7fS3
 zjyRopPz2XFaK9+39/1NwNTTlX8Nf+Sy4nPHfVKn4dGRJWa3da82+co6vbNsRtDTNi
 MCiJ6Rch39Bcn/BozG7mCkD0E2x5cDuZIes09WwicqdtfVfMZc7tCLgOu4GOyAzRfL
 t8cWScZ4MXmo6zwNI1psSI8KkACN40ucwCDWCNwD0j9PPuBrT6OlCApio1z2Zn+UMD
 Wb9eICBTGLZbOGnCvryILHRq7lkAxVX2685HxInX86gI+9pqNLmVHeszAhOh7pr5CU
 KDENRWbx+37hw==
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5b14d1f9315so2745202e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:25:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rqtl5WOFtRdlJI7KDv02ppBd/zLlvtI43aSugIFgFZMxmdGv1wdyfhHz3i7dzqALurjBBey0vqmSxM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoPHh0CdlLv6fXM0MH6MeBMp5MIeV/ZD4KrNeHMCrfnW/+LrLz
 mwz7YHmgR87TyRIn1VVFLutd78Xfka0xjIHagQ9HHaN0H1TlM8EccJESTu8E1tSgQKYeuJCfoaN
 EBkYujyHM1WTWwhIzuJ4UXPsxBNLK6dw=
X-Received: by 2002:a05:6512:2203:b0:5b0:20b0:9589 with SMTP id
 2adb3069b0e04-5b4706ab97amr10137e87.38.1786969547696; Mon, 17 Aug 2026
 05:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-8-19cd5277cc8d@bootlin.com>
In-Reply-To: <20260814-drm-bridge-every-panel-v1-8-19cd5277cc8d@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:25:33 +0200
X-Gmail-Original-Message-ID: <CAD++jLkdF2wyWLtXnuO7egzwHqijtkGpd91SYT6Fhc++x9kf1g@mail.gmail.com>
X-Gm-Features: AcwNN1UqNtn9LzLW55q-_zTzJtSt9-eppGtM9bVmeuXXWsyeBoklQx2u837Wir8
Message-ID: <CAD++jLkdF2wyWLtXnuO7egzwHqijtkGpd91SYT6Fhc++x9kf1g@mail.gmail.com>
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

This looks like it can be queued already irrespective of other
patches,
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
