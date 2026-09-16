Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA6BC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE96510EA85;
	Wed, 16 Sep 2026 13:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fdYZ0bpW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269A510EA85
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:01:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D432143E08
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC831F008A4
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789563675;
 bh=KUlZikuQBkjASqlS0r34MSesaEU1v9kEjK8BGJ0I3Q4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=fdYZ0bpW2p1hVYvKeayGkdkxciHhMiJfLULqihCfb+ZwktFd6bGix7u2YFbMKupIK
 x9QI3/AXOWqPpDN9EkRS8dyZCuZ77P7NMx7p7xODZ1BMXU1t7q8mzI6QMCuIkus53F
 S0Ct1uT0GV0e+U1aetYaC3q7XYCOMCBNCoAAIBDY2SHiRLWhYRgVGoS/Hx35dpV2K/
 kngyOo52nB9KS+7k+s8lALEzz+fhIUcGNkVSgtxrscvs0l0dMf9e1fhMZ9XFOpRnmm
 yLc64zxL/lY7yMdwtEo0BnqvngH4caS7GlM9+oEQbo7WH3Y6zQZDjJ9jTWiiivGcXo
 1kjSiLO9biR5g==
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b5e4f16f15so873306e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:01:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwPZPoy5zd54kEz0LVs42ynCKdFKR18KQlOudNpEHi5ziYyGZf27hLfdU+tYg/8hLIhgmGIJIN4FN8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kgffuKXnRW8R46uYlZVM5wh3hB2Jx7UAdtghxk534TzHqwqhru
 LWISsZDBwSJMioAH9gZVJht4HOWLPW/LwVBab/hUszWW0JiYnHGGAGZQDPSPi/RkmHww366Uo9k
 70AdnR0tfD/7wLVsDgpa1pq1ajaJOdHY=
X-Received: by 2002:a05:6512:3d21:b0:5b6:1a42:7d52 with SMTP id
 2adb3069b0e04-5b8b66299b4mr1409484e87.13.1789563674354; Wed, 16 Sep 2026
 06:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260915154644.104460-1-osama.abdelkader@gmail.com>
 <20260915154644.104460-3-osama.abdelkader@gmail.com>
In-Reply-To: <20260915154644.104460-3-osama.abdelkader@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 15:01:02 +0200
X-Gmail-Original-Message-ID: <CAD++jLmaowjhdX5wuuGAm6LFVR9T77zDhBj4pVPKSm_N-4jr_g@mail.gmail.com>
X-Gm-Features: AcwNN1Vdr9AqVc01Vh27EmawQxNTv6BylWfNoRByVbacDfo9kn7WN143c8tZFNQ
Message-ID: <CAD++jLmaowjhdX5wuuGAm6LFVR9T77zDhBj4pVPKSm_N-4jr_g@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] drm/panel: Use managed helpers in Novatek and
 Raydium panels
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: luca.ceresoli@bootlin.com, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Robert Chiras <robert.chiras@nxp.com>,
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

On Tue, Sep 15, 2026 at 5:47=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:

> Use the managed MIPI DSI attach and panel add helpers in Novatek and Rayd=
ium
> panel drivers and drop the corresponding manual detach and panel remove
> calls from remove paths.
>
> Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
(...)
> ---
> v5:
> - nt35510: keep mipi_dsi_attach()/mipi_dsi_detach() manual instead of
>   devm_mipi_dsi_attach(), since nt35510_remove() also powers off the
>   panel; deferring the detach to devm would run it after the power-off
>   instead of before it, changing the teardown order. (Luca)

Good catch.

>  11 files changed, 49 insertions(+), 179 deletions(-)

Nice diffstat!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
