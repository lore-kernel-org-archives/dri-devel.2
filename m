Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AB9C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F5910E136;
	Fri, 21 Aug 2026 13:41:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fpY13xRB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86FF10E136
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 13:41:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9795B43A72
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 13:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A221F0155A
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 13:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787319697;
 bh=savjDRzypaWpuMo2A7Z9mQU2Ay+uV7mKsZsDzwVuIC0=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=fpY13xRBJmfBoDF0Fi16I++w19fcPtMULYKneBUd0KSJbWscayXh7wqOrDgsaHm8A
 rYs0RZEtuNJhV6ieZrtXcsGmNiIxJeCA1Ze5BtW3sxt7MWxAJceR96nKAfoDyvPTM3
 hKtYTFI4zUytKB/tdMi46Y+xL3CDqEvevF7eOVHLmVqtp7drDbnzDb7JJrdcAlHQud
 PScVVEgzOk78JUCsthSjeVMaZbnybWIuA0c8FxJQ4JaxP9vL7OyaSTIcUiDkpC4amX
 31Gj6tzRjS4/x+rnIns9c/H3lMfFms2dSUzuIzSMfXr2MWdCH0RuS0qPBPW8hUWuk0
 IxpZ3/UhF8+yg==
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-39ca300db70so10513121fa.2
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 06:41:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpojEim3RXfugF0Jtrd3WaC3WQt8cAzuYtI06U3VSp0EdKJL/lT7G8f4lhjVsIXP0AYMPb1XYipEjE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m/0Z0TCajNi7KrJPwWZH8afUH0Cpn5inPnQhiS8AyvBUngGTYh
 xsvRpolP3bT9a3qNHqgLoX3GRP0gkAUtTkA6P6DcIQnx5O2RLMYjhM4k6v7JH66WjEfqJsunLWm
 OEc9fvxHvN48F1M93reGfZMohOUo5AFw=
X-Received: by 2002:a2e:a554:0:b0:39b:a75:e8da with SMTP id
 38308e7fff4ca-3a1aeb53dfdmr17313911fa.3.1787319695666; Fri, 21 Aug 2026
 06:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787239944.git.geert+renesas@glider.be>
 <0f37278d04c02461e17f42032a379dccfb773171.1787239944.git.geert+renesas@glider.be>
In-Reply-To: <0f37278d04c02461e17f42032a379dccfb773171.1787239944.git.geert+renesas@glider.be>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 21 Aug 2026 21:41:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v6468b2sH8uiKtdaLM+T4vw2i69SiH4uf6H3iOhvF4aCJw@mail.gmail.com>
X-Gm-Features: AcwNN1UwlPg8igVRqeTcbGzuXti5pk8Q0JsLEMMpjQ-PubogbpTOAywOmnQUcf0
Message-ID: <CAGb2v6468b2sH8uiKtdaLM+T4vw2i69SiH4uf6H3iOhvF4aCJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/sun4i: Make sure clk_init_data is fully
 initialized
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org
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
Reply-To: wens@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, Aug 21, 2026 at 6:03=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
>
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Chen-Yu Tsai <wens@kernel.org>
