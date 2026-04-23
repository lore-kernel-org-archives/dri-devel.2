Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080C8FDEE4E
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B6F10E273;
	Thu, 23 Apr 2026 21:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pr5rX5+i";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3695E10E273
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:24:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D568640833
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E91C2BCB2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776979485;
 bh=bwLbQ5NviOj/bY0u6od11N2GNC6P5OodS0ixTy9vUk8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Pr5rX5+iSOtoDmywesPolyZqj/RoYZzXZzqAKOCPXaAPVbQy181gcY4KqmWelL3xe
 iI8OxPQrJC/OTrH/ZLz0rOUiOTVtcX+tgL8fQldFAyifEXq4Ro7X9rCkCPHaEon8lf
 78I3H6UHjrVSc0vZ/rmfbV584lCxPbmjMUsEw20EYHIC1m11yOmA53E7zZ9iwFFwMY
 h1y3TQiPQ/Mn6Lkn2GPmkG1BtNNIAudFgaxnIc/Wmh/3c8UYfH/tzhp03vDl1Esv5z
 JNQTUBvUtjQZhZCzy7NjdstndEvcCFBbiVJ8BrVj/ubjrTdizCo6szD4gaROtGlr3Q
 7rfjwEOk7fYLQ==
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-38df1889fb9so69503501fa.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:24:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ95FDsQrzpQtfBLSSbS6jTk4p9r0UUZ3q4KmJsQBagh+hstUeCub7avmSi0BSO6B0oO+nlOddYKuRg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyptNJonYIg+u3eetfcgdI8c0HBs7ihIn2XPZUNDncok2qX2vUp
 Uh02ccle+/5Rep+MMPNhNqoUohVAwromhUrJ8aI4m3rm8snuF3VFYs9tTAGMzlXg8sqsXVaqLSu
 KvXasmaPHCcwCzRrIwljf1oBHDRvz/vk=
X-Received: by 2002:a05:6512:118b:b0:5a2:8568:826a with SMTP id
 2adb3069b0e04-5a4172eece0mr8397088e87.34.1776979484421; Thu, 23 Apr 2026
 14:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
 <20260413-waveshare-dsi-touch-v3-17-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-17-3aeb53022c32@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Apr 2026 23:24:32 +0200
X-Gmail-Original-Message-ID: <CAD++jLnsVc3xqKfhuZo08wQFkGrgDiw+OAhTOfUi7vD5ZFY2_g@mail.gmail.com>
X-Gm-Features: AQROBzCz31PGPdHjUDpQGU0MKBOAMjnGwCLXEjwbbDFHz8TqNnaOCqTWhFhlvZ4
Message-ID: <CAD++jLnsVc3xqKfhuZo08wQFkGrgDiw+OAhTOfUi7vD5ZFY2_g@mail.gmail.com>
Subject: Re: [PATCH v3 17/21] drm/panel: ilitek-ili9881c: support Waveshare
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
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
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

On Mon, Apr 13, 2026 at 4:06=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Enable support for Waveshare 7.0" DSI TOUCH-A panel. It requires
> additional voltage regulator, iovcc.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
