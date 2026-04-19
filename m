Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B1FEA719D
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 20:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C04210E057;
	Sun, 19 Apr 2026 20:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fZKySIqx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FC510E057
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:16:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 084B94414F
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD132C2BCAF
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776629773;
 bh=GDhTvkiJqhINQX5MFA+xMV3KNOf+hKPswGRtUCHk2Eo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=fZKySIqx759C0B5DAtD3vJfzO4j7Sdarm83OG9RGYY4dXRpBpdL5wS21CedxDP8T9
 h25+qF68ZMlU5K+FoJ7GjfNusGnbgZI88NzgSOsSNsP82rI8LwQOvLwQMUvP4Mvj6C
 u0pNN5VYY4dupjIs3/dIjNmGjBnaXGFUVVSrFkXZ9HtkIguCax80rRyCCw3QxAvr22
 VnUycuFTlvaeGd1KdWTax6aJ64Ran0KVPH4tm0HneF0YopVjEb4NTVyndAWo4PPbst
 AOqG7m4xKu03HHY8iUCEEmSn9rsNynnmBimNn3ToLQwrrNpsWHb51Iko7lEJKHvlsp
 B4bUP5ILNxV2A==
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-38eab6cf7d8so23409641fa.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 13:16:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+eMYTl2S9LArJXXHZkzp4cJU5/JGakeBS+qfMIBZBiI2QhSikOWF/HRe3tBIzys9ZAMnxntKy0C6s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyC4gVWlHhNiMkiETxewXYOKybZEVbZJyv8oDyLoy0TvqFng9PB
 GZHzqsF0W73QaiZXtjAzYFCaB7tCfw3MvLFA8Y1CRYOStsPUo5f/g0JX9rz4p0xpFQVEMLwtiXQ
 XJ1/r8Rl2O4WWx8KgkIjzcAQ9gCcYm14=
X-Received: by 2002:a05:6512:61a2:b0:5a3:ffdc:1d22 with SMTP id
 2adb3069b0e04-5a4172e4ffamr3383211e87.36.1776629772615; Sun, 19 Apr 2026
 13:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-14-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-14-75cdbeac5156@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 19 Apr 2026 22:16:01 +0200
X-Gmail-Original-Message-ID: <CAD++jL=iJmYKB2psb0A=RUAFZhKtc6KQmsB9HED1-LQAAFbYmA@mail.gmail.com>
X-Gm-Features: AQROBzDjOWLTCpwVHd-bfYDfUqw6vHHRtJrX45Wrd5GY8ZZuzBfZra5z61yRT00
Message-ID: <CAD++jL=iJmYKB2psb0A=RUAFZhKtc6KQmsB9HED1-LQAAFbYmA@mail.gmail.com>
Subject: Re: [PATCH v2 14/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 round DSI panels
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
 linux-gpio@vger.kernel.org, Riccardo Mereu <r.mereu@arduino.cc>
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

On Sat, Apr 11, 2026 at 2:11=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Add configuration for Waveshare 3.4" and 4.0" round DSI panels using
> JD9365 controller.
>
> Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
