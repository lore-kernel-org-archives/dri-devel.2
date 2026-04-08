Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A53BFD5F92
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C977810E571;
	Wed,  8 Apr 2026 08:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ntQiLtGr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8592810E571
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:27:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4745544518
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21660C2BCC9
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775636823;
 bh=dAv+La3U8Nx7XhasEfBGS7ePrE8r3GYXA+jCkywSwRE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ntQiLtGrqe75QaxaTjlLuIXUQ5w/YPlxE50wIJaVITYqYOK/uu8leefTE6fv3S0k/
 a9CfrcK3ThgRtVQ77ZEyzI2deZDSr9ZboU70AVDO6vbk8bpPvRBblhOT9yUs7kuT81
 j2R0y8nDYTF4Pn1mqEwGJu7lHejyJbM1lVDre5TYqz4QZrtJa99dwwjS5qMmyyULlq
 vZ24nWKGm4VU6U1wzsYMB/GZq8XpSS95P25Re6QTg0g+C62cbiCimpPiYtH5LBMJRj
 MEH5StlIOA6TsGhtHDa7cnbYejkmdDOVWYIylPyCCtuOWs9NmIJ1jPe5kr9DpFTBCf
 5HgwMdA7b83XA==
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-79a535e7c00so64463767b3.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 01:27:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWNM6LcROGPR9CGxsyMY10mkxP3yOChvRHPRRxlEsWEl8Wdn4Bj38+lRArala7auGyiThnlILv3ZDQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7dcl9Odvfw6xhxjpCii5Zg26zUfsTzbJ1Pkeosqule06qFL4F
 1xCiCifSuqmh9NK5f4D7rf9UJU5mujH6vEZb5gkxvrfJWel2i64GrM7eG3MvhhD3MYFhnf8sKxa
 zjxvhBk5LxIe+yDd+rzS2OpsH4cXOh+8=
X-Received: by 2002:a05:690c:6610:b0:79d:4f01:5bc1 with SMTP id
 00721157ae682-7a4d84c32a6mr196936127b3.31.1775636822459; Wed, 08 Apr 2026
 01:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-15-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-15-5e9119b5a014@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 8 Apr 2026 10:26:51 +0200
X-Gmail-Original-Message-ID: <CAD++jL=DmZc-+n4z57QzirGj-S=UBqHKVUkV2dUkQp8HjXA33A@mail.gmail.com>
X-Gm-Features: AQROBzAl5SihlBoUxkuLl6r0BxYNCbci2S_noIkx70TcWl8cgQaobuFx_PSi9DY
Message-ID: <CAD++jL=DmZc-+n4z57QzirGj-S=UBqHKVUkV2dUkQp8HjXA33A@mail.gmail.com>
Subject: Re: [PATCH 15/19] drm/panel: ilitek-ili9881c: support Waveshare 7.0"
 DSI panel
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

Hi Dmitry,

thanks for your patch!

On Wed, Apr 1, 2026 at 9:27=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Enable support for Waveshare 7.0" DSI TOUCH-A panel. It requires
> additional voltage regulator, iovcc.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
(...)
> +       ILI9881C_COMMAND_INSTR(0x01, 0x00),
> +       ILI9881C_COMMAND_INSTR(0x02, 0x00),

Same comment about using a jam table here.

Yours,
Linus Walleij
