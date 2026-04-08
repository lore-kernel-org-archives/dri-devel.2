Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4D2FD5F88
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EBD210E57D;
	Wed,  8 Apr 2026 08:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pdISwvAj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C6FD10E570
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:26:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E1DE600CB
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D59C2BCB2
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775636770;
 bh=iHDkuL91kujjlOmKryVg0YeA+Yh7JR24uFyI819LhUE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=pdISwvAjl5H9g95BsbfAQadafpuWy1u3Iqzn5Bu0c3f0pbjjXTc6lLQRICPWyyvYZ
 cKM7Z1SEKsiaX3U48y6sABZ30ZvsIP4WfNmmh6u94vFb7/vi3h/SCf48cmp2TRReZV
 FW7RkmCyvnOOgLk8ZfeQDesUUnMJ1FiDSs/sieRi9IXKkFCm88MfBbSFIOqd7NAdrf
 4+3n9MwmbqwfLMKwIHlavaqCOdahysfBw4UN7JhHuM9Eqm3xuCJw+7Rr9fW8meiYZx
 LlcuO6uZp0EPRPDnQ4c6G2wqgCZMun4Q/vdQTJA65ErTI78ODaBsGPbHNa53DC4hcv
 ++s9yihfH4aeQ==
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-79853c0f5b9so94933227b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 01:26:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUjasNGNCHYBacaFaoUq6XnFJyIiHRWjyVB5Pj//OEd0oVCLo/FyEDeSs05i23dhD4bh9HM1btBrw4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpihpWt7jPjw5PuIRIFhEohuHhvStysOeWap37iz9YBRE7hPYY
 l+GPpEdavOwoOolSUxwY8jZJn5EOLZI1TmzskF+PvwH0VMYSIOVR3PZSTzdVEIDJvrgr1BJWy4d
 EoJF/fTsWl1bHX5TlhD5fgK3fmolKNKI=
X-Received: by 2002:a05:690c:c4fa:b0:79a:5fb9:62ad with SMTP id
 00721157ae682-7a4d5d538f6mr186627127b3.43.1775636769579; Wed, 08 Apr 2026
 01:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-16-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-16-5e9119b5a014@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 8 Apr 2026 10:25:58 +0200
X-Gmail-Original-Message-ID: <CAD++jLmO3fW=UkH9Qf=WzdKrUP=Yg+ZmTAuqXXXOWMWAEKS2Kw@mail.gmail.com>
X-Gm-Features: AQROBzBFUPiNlph5L0rEdl7mVBl48sE-GCLaRgA80ltifGgVhotOohWIUiAlQJM
Message-ID: <CAD++jLmO3fW=UkH9Qf=WzdKrUP=Yg+ZmTAuqXXXOWMWAEKS2Kw@mail.gmail.com>
Subject: Re: [PATCH 16/19] drm/panel: add devm_drm_panel_add() helper
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

> Add devm_drm_panel_add(), devres-managed version of drm_panel_add().
> It's not uncommon for the panel drivers to use devres functions for most
> of the resources. Provide corresponding replacement for drm_panel_add().
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
