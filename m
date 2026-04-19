Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F3EEA7197
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 20:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D5610E3F6;
	Sun, 19 Apr 2026 20:17:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k0yWmB1R";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A964510E3F6
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:17:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E80EB60172
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6026EC2BCC9
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776629848;
 bh=vGJo+SaxSWs6hFGmVYpOqq0e1ET6Hp1Iu418S3/2SA8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=k0yWmB1RLhR1+Q7pN5Cygcj8z09ZnEo9Y7O87M/ZnpbQ4VnDemT1kjjdmP0Yrj8we
 TxWPDHxxy4Sb55p18W2w86OtRQX0KpqVLiBxZGTli3nDqZ6m1Vp6B2pXxiuY6mRliU
 5NQ80g2PFrbpJ8wrpkHHj60q9h/Tk8kbYQTq5TbYuAHVa+pznhWNlibv7zhmh1VKgV
 6uvaZf3FsTR6w27GkvNE8RhoeWbdwOW9vWM31nuOMWo5q0oU4sCOlpVxiyewykhXfc
 N4d7L0H023hQ2BsSaFx5GdR9M5ZVU3DB81uVRPJzkPI6LSw5+WFroCG8WVolUbGPaJ
 +S+pQiE3u0dPw==
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-38e7d984096so24902321fa.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 13:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/3aVKud8EJHfUy/PMpouhxMUQKioLgGGgyOvjKJJ++woWgvWMOEjm4ETmpJXeiGzV0GrWciNYyJeo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxseFHg6kcuXzQjOn3r44pkVqi4u1U+/Ggh4AzZ2zEmlsKEqGfU
 6EmkLALF7dmvJBpMKKK59Ib+bxuomOQImVuIcOGUwptfk+8HbGQgMf8CSreR30sH96Ur1lps7wD
 nZuUgAoa/yERmCKsEzVX1bVITZHzYTGQ=
X-Received: by 2002:a05:6512:158c:b0:5a4:4ea:9982 with SMTP id
 2adb3069b0e04-5a4172bcc5cmr2945049e87.8.1776629847092; Sun, 19 Apr 2026
 13:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-17-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-17-75cdbeac5156@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 19 Apr 2026 22:17:15 +0200
X-Gmail-Original-Message-ID: <CAD++jLkNa2zQCuwtfTE1yoe_UC2KWmOE_PinnGuwib6uW-osdQ@mail.gmail.com>
X-Gm-Features: AQROBzCQnwRSISZoWKgQ3HtyJ1lLaRQ_hELeZOJi2QkBaCgUhauUnht9TK33V2c
Message-ID: <CAD++jLkNa2zQCuwtfTE1yoe_UC2KWmOE_PinnGuwib6uW-osdQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/21] drm/panel: ilitek-ili9881c: support Waveshare
 7.0" DSI panel
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

On Sat, Apr 11, 2026 at 2:11=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Enable support for Waveshare 7.0" DSI TOUCH-A panel. It requires
> additional voltage regulator, iovcc.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
