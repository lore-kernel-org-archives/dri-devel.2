Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD87FD5F88
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E0910E573;
	Wed,  8 Apr 2026 08:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LcwDZkpm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1422410E573
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:27:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EF9E74425D
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA6DC2BCB1
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775636844;
 bh=Nh/HgkDdzSl2nd13YnkWx/Pm3GBsXpIS/jjsAxO2JZA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=LcwDZkpm2MXkNjBMqFo5DXJzgm94Tuojzj5XvJd9cwY2DXDMgCdxOFdN8idqT+oje
 6ty6QjsFAlpDlJzKrcJph6KNTZFm2pQlBn5dG0gqLFRzI6cnF7BOWCFfvIKSj0l/eo
 ih16Q5TWM8uQKmbJ8Kpy94Av6+Xrd72Z5MUBuKyxca70LvZQ1IYX8OicKYxlsLjiEC
 XdpVINSbV+rsEcfb8Cj0wDdGOytZ0hdR70ulTSXNyKd3CPhORwk+7oHwv4wSvdeuAX
 iZYpdm2BO3F+2cUtupGaK+rq7CMQgQF3qotT/c/KDryj9+hqBJC4qOQeqEiKhz8JNm
 kHa0FP8Wm8wAA==
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-7a2b6adbfa6so56277947b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 01:27:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVpj1ad7CUmUqymwyC2Tl9lKDFNogsu9DQuhd7lG6bY0LROdIEYGhS9PVFdamaPypH3/D+VGmzJ3Kg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvH67L1a0NxnoaylzLmfxG5x1lOcmd3mqDt52d4sX7ggYAWKxR
 P8AZ/qKyNgNUSbM2OncpiBmxTLAKv32GJoID20W8a92Tz012BtWKFIsDwB/Ls12wOd8e6nOJxzb
 MaO1JTkygUcAIiHvjDH44qaW771/r9Us=
X-Received: by 2002:a05:690c:385:b0:79a:2ef2:7f7 with SMTP id
 00721157ae682-7a4d6e21e14mr210763987b3.23.1775636844272; Wed, 08 Apr 2026
 01:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-17-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-17-5e9119b5a014@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 8 Apr 2026 10:27:11 +0200
X-Gmail-Original-Message-ID: <CAD++jLnQb02FhQDngY_ZnOeQq-2Naxg4MT38BtQK+2TGFymeDw@mail.gmail.com>
X-Gm-Features: AQROBzDZLZBjPdZdwCQGMrQ2dNUUfDDmI-jmdfj9Sal7q_dMbU4JwTx-3FFyxlc
Message-ID: <CAD++jLnQb02FhQDngY_ZnOeQq-2Naxg4MT38BtQK+2TGFymeDw@mail.gmail.com>
Subject: Re: [PATCH 17/19] drm/panel: add driver for Waveshare 8.8" DSI
 TOUCH-A panel
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

> Add driver for the panel found on Waveshare 8.8" DSI TOUCH-A kit. It
> uses ota7290b IC as a controller.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
