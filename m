Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0743C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3032A10E670;
	Mon, 13 Jul 2026 20:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YuEpS8+T";
	dkim-atps=neutral
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B4A10E670
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 20:11:23 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-97622cc1f40so719779241.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783973482; x=1784578282;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LZlod+e1uDv6Tp/oYJcGTQuaGxXKAIOzzH8wDVB6B7o=;
 b=YuEpS8+Tuws54wIogcj3GhlkIn3EO38Oq0XxyZc/In6yqLJT18VlneqUM18wS4VI0/
 yJI6LUYUu+fjYZFblisn6jNOuEH7s1b8+utRF64GQPx7C71ZguSOLZAxFZ3k5nj2aRWA
 offb/UtU827Y4WFPgpiSVhEOhvhpTnhbjojEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973482; x=1784578282;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LZlod+e1uDv6Tp/oYJcGTQuaGxXKAIOzzH8wDVB6B7o=;
 b=sCnzbwn/zOXpsGo8FuXmDRRetc7iHWLbuUQQGWbI9rOu78mzM848ndWP7TwUy03ynE
 Htgp7+GvW3LOPfJe4IJBFpb/kVrDhO4Qbh8SlUeqXZwSo/gyhuhtmVf9ER7fYeKekYxH
 Qsvl6fiyLyHp7WYbOo0h/X/9QNlK3xffRBDaxFaj11siX0cMoQSvbt1lvK+5CVUv2Lss
 gbfyBf/vxwCowTGHN5uL14KfRJpD6PZWjRXceJWLHAxiLOQhMoQAAu1ad8YSHMARAM10
 s/bkJ+v+rRw6CFUw+ByXT4j+CcbRi1nL9BufUL0nM7fhsBCuP/am4kT7dg+MIuqLWfIc
 BxNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpXSirFs8zw9pnTcA9ZrUxWD9tDFQzkoKJz21sNxrA4JrLEY9yTJk3XsWp+c0KAs8FPj6J7Dwqbfc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLsbTgIaBxwE9oatFJriLgxYbXrUKo7F07Mk3/UAOZGlrJPqOW
 QeQlwRH844gmBKASVu3trDtrq+CWQJkhSULhQvhQ2aJrUVKsw/KzvpHyH0GBqeIavLosrroXlYA
 Xrco=
X-Gm-Gg: AfdE7clhlu/z7ZqqPlRO0zfXQbOHjHF+R/sLYuQ2Q69Fx+S5Bx5+WIkgWnsL/n+uKTk
 AlgyelmAKGEfGib0tB81oc3Ecn1WA1/MZR6I8NMsgV01mFT6sRkjSlONFDf2KzWaqFmljx229CE
 izcSra9B+cMpAnAH568q8xQJolh2AeiJY/1iI+C4+bm1t3NTi9pz+HBGzQBur/YGuPEC4nhFHzw
 QKutJ0GOsKUXCugtPSYXHw21wCaR7v9vq9fOiAQyuynwJka14EW81YpNJo9giSFzi8VNorc8Io3
 1TF0pxSCjVDRXLSvjtew0z0wveAPWi4e0j+yaL5v2VKMjNbrDRxrHyQ9qj+sdJIGpaOuJ3ph8yF
 ssInrg0us7UqGfFcB7E//12RIXs0MWvLC4+LVCzVGdQHVkgaNGOZ14eVaVCwqtiZsuFZA25GYf7
 nucYeLv88pzBJ56brUh8JTjn69nd1xb+eaJbRqcM1wOPcqLzVbwoA=
X-Received: by 2002:a05:6102:c11:b0:73e:5068:823d with SMTP id
 ada2fe7eead31-74533d8a4b5mr6901791137.18.1783973482578; 
 Mon, 13 Jul 2026 13:11:22 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com.
 [209.85.217.48]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-744d6e38d35sm9673080137.12.2026.07.13.13.11.20
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 13:11:20 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-73b909fbb6bso2267015137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:11:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6S8mMHefAePWkTHKYxqm8myMVLN+YxBCHz8FzIKN6IUiu2btYDg/diuFgKzOIaazJjjpl8okOC6g=@lists.freedesktop.org
X-Received: by 2002:a05:6102:5605:b0:737:bfe6:3b03 with SMTP id
 ada2fe7eead31-74533bc9032mr5929953137.7.1783973479445; Mon, 13 Jul 2026
 13:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260706224414.1015766-1-nico.antinori.7@gmail.com>
 <CAD=FV=UTtNdi_cUaqDXXWWFzZADh_HB=sJuZqKV=VB8tgFTwEg@mail.gmail.com>
In-Reply-To: <CAD=FV=UTtNdi_cUaqDXXWWFzZADh_HB=sJuZqKV=VB8tgFTwEg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 13 Jul 2026 13:11:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VKA_SKpyew8o64_Fn6qG_mS5snXm1XAazG+3+mn_YJcQ@mail.gmail.com>
X-Gm-Features: AUfX_mw54ZGdoYJIFpDZ_csf_4F_WNipu_An5eSERMPBRjO9TuCn5xHygWB0_AE
Message-ID: <CAD=FV=VKA_SKpyew8o64_Fn6qG_mS5snXm1XAazG+3+mn_YJcQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: novatek-nt37801: Use mipi_dsi_*_multi()
 functions
To: =?UTF-8?Q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Brigham Campbell <me@brighamcampbell.com>, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org
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

Hi,

On Mon, Jul 6, 2026 at 7:31=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Mon, Jul 6, 2026 at 3:44=E2=80=AFPM Nicol=C3=A1s Antinori
> <nico.antinori.7@gmail.com> wrote:
> >
> > Replace mipi_dsi_* functions with their non-deprecated mipi_dsi_*_multi
> > counterparts. This change reduces error-checking boilerplate and improv=
es
> > readability.
> >
> > Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
> > ---
> > Changelog:
> > v2:
> > Implement feedback from the previous thread to simplify code in the
> > novatek_nt37801_prepare() function. This converts novatek_nt37801_on() =
to
> > return void and passes the mipi_dsi_multi_context struct directly as an
> > argument.
> >
> > v1:
> > https://lore.kernel.org/dri-devel/20260701125624.199786-1-nico.antinori=
.7@gmail.com/T/#u
> >
> >  drivers/gpu/drm/panel/panel-novatek-nt37801.c | 110 ++++++++----------
> >  1 file changed, 48 insertions(+), 62 deletions(-)
>
> Yah, looks great. Thanks!
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ...barring anything else coming  up, I'll plan to apply in ~1 week.

Pushed to drm-misc-next:

[1/1] drm/panel: novatek-nt37801: Use mipi_dsi_*_multi() functions
      commit: 5958ff1a715dd885210ce7208f1aa1fa930e8671
