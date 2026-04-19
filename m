Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1B3EA719D
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 20:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B534510E0DE;
	Sun, 19 Apr 2026 20:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IsKUyjy/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CAF210E0DE
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:16:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5409E44596
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A112C2BCF5
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776629799;
 bh=hlN82U3u5JGIfEK3aCxmpqJVvZHn8H0jsQ+771+7n0s=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IsKUyjy/vvwOFYoWiOM6lZZoizOKwCFEO4N+EyDgTKdb7zqwGo4asI5K+rQ10Vuwj
 jMl5Zm9uYs9lq9UO4MYdB4/5JZfXbuRdY/lxVC/p2T/EyiUrllwSkx9U8WfGDh0u3g
 CWw2je+DxwFgkMDoPwTDBVZdFc5TJqKhBjYc+qd2j0YICJ3l0c8No1NZvVQuBBpXLZ
 c0xA9P5GnrDpb11BzLJKViQcuSMGAfXMAm9rcbcb3CbYQGNEp0GjkaX0K5oW/b9bAa
 QT+A2klQhexiRQ4AXZ7G7ff62QniZWuVd69nVeZbjVVzFXbQFqqBBliGEKp9z3jvNh
 4QezrBYaP9/tg==
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5a40b2bc96dso2760273e87.3
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 13:16:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ97y5C/mFXWVmzhWVz4L058KOMfALBqxH9R5ITm9KW8Wuwg9cy/ivQOdOOqVg6WI1UQ0uUq4pwMZsQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEL2Xjh38FrY7F0GlrvI2aJ5oCUR8u1J8U0i+SDvZQjIZdEySZ
 mrmO/ogqmFk5R3Ogxk2TBhVXPFIp+11V0QgcDx/YXTxuxqKPuiCnJKqsvtF8TdrE5qg5MaycJ9d
 mISSUX64YdG0nctDOf8LDZllVODzpIGU=
X-Received: by 2002:a05:6512:ba1:b0:5a2:c05c:118e with SMTP id
 2adb3069b0e04-5a4172c36e1mr3505118e87.11.1776629797744; Sun, 19 Apr 2026
 13:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-15-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-15-75cdbeac5156@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 19 Apr 2026 22:16:26 +0200
X-Gmail-Original-Message-ID: <CAD++jL=0i4Z_xt7E4e_1JYJ7J7bGDGpEunS30DxZw3=ioh35jw@mail.gmail.com>
X-Gm-Features: AQROBzDnFYGHHrw3HiuqBxQobwvrUSVyXOaQI0N4JGjLUJJBSKx7_rBzcGkbSOI
Message-ID: <CAD++jL=0i4Z_xt7E4e_1JYJ7J7bGDGpEunS30DxZw3=ioh35jw@mail.gmail.com>
Subject: Re: [PATCH v2 15/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 WXGA DSI panels
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

> Add configuration for several Waveshare 8.0" and 10.1" WXGA DSI panels
> using JD9365 controller
>
> Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
