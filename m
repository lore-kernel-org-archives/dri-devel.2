Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E2BFD5F92
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E9EC10E557;
	Wed,  8 Apr 2026 08:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZZKMsX4y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEDB210E557
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:09:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A73D5444E0
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5D0C2BCB8
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775635743;
 bh=umQSa+ggsoHR8bIX76wvaugAVwppX0RMa2t3Cg4tIZ8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ZZKMsX4yRGS1ZfxC+wafZvfUSOGnZtjmNFig5zwF4JYHD/hM2vpSPdUcDgz0t01Ah
 yCwHgQlC6CGag2Cf9Cnel3qKw4RPA1A0cv9yXzT34iQR/qquBJhHCxGxKSE/2iSMX5
 Pary78qBZEGxfqlmv/RYQvsGNmRBUbKjgt7FLYI76DFdpI7djARUPc4Y6MpUCgrcFb
 z2Vl/jGlxKYdDe9FCkwmZT/Jf9cqMK2LhYzHNAzCD8r1bqNkNKDS34IzpJuKf8xjKP
 qmtMwy/9CzmVaTsN5qRgYIYKDTGQpvDI7KEm0iz636gDcblzuKkqqurfDsqlqDvGTE
 55d7qqsb0J2NQ==
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-79ab5fd969aso60429687b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 01:09:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVxTG+dRO2F0bT3XKGgCFDUnqk8SOCz6WLv6QY7nCXBm98JoEUf3x8pXmiQqApkGNAEXDKy1oSJEjI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8kSFxbuUzr9qIUUH4MMXxCSeSTevCULxTFifjLOJR0rwlcQIr
 Tjqwkn/lHoVkRW76Va0n6xxjVGGWlZ5IzAb4CcfcMgwIVsrdzx0RXu98fw3efNyzByf7kOiCYW/
 car5rC3F1zD3usVPCyxe+Br/JCKncP68=
X-Received: by 2002:a05:690c:5c0c:b0:79b:e24e:e326 with SMTP id
 00721157ae682-7a4d5f56502mr164827067b3.46.1775635742703; Wed, 08 Apr 2026
 01:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-9-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-9-5e9119b5a014@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 8 Apr 2026 10:08:51 +0200
X-Gmail-Original-Message-ID: <CAD++jLk6_q77qiBYhg3u2ivx36m767Ps_S52wEC9m6DNwqrG2Q@mail.gmail.com>
X-Gm-Features: AQROBzABeGHUAeJD_Fqtm2qwvxK49Jozh0F9hVQhu_g7y9HzP82hY8UcJC3hAqw
Message-ID: <CAD++jLk6_q77qiBYhg3u2ivx36m767Ps_S52wEC9m6DNwqrG2Q@mail.gmail.com>
Subject: Re: [PATCH 09/19] drm/panel: himax-hx8394: simplify hx8394_enable()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>, Jagan Teki <jagan@edgeble.ai>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org
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

On Wed, Apr 1, 2026 at 9:27=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Simplify hx8394_enable() function by using hx8394_disable() instead of
> open-coding it and mipi_dsi_msleep() instead of manual checks.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Excellent, thanks!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
