Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1270FEEF33
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 13:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0942910E411;
	Tue,  7 Apr 2026 13:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="dgeGbjWo";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBBB10E411
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 13:00:05 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-66e8cc714fbso4783658a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 06:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775566804; cv=none;
 d=google.com; s=arc-20240605;
 b=MxEkbplWwChGGQC491ZvGqTJX4Oc+q9nRGt02iBkU8wP1dfshy19sxHflOOgQWpSrw
 IK+Ap9z0j4IRRKn3kI0mFODa5P/lgkqjNGYYkJxCvs9Of7R29s34eUZqT+KpQ1GoVqPv
 E11gcJqE6TyFzsJ4dHu0jrVkZabqo5MXK/JfbocLIfTEG39iNTd7nYr0uz1SUv3EoBwt
 l/FygbyUwEIufJt4Ev/k5xI7O6X/ZYm6ccXKs1ki6qr4TKFq0aD48Geh8tVBmuXYCBCm
 fFc2FUsYaSEoE5CE+QvFdVLTGHS8awHW4ez/nUDwacqKkCVreVp5to86WJab2xiuZZ0D
 2/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kL2sSGAkL4PZPcVc5FJ4HxqW1Olr8C1QXuJ6qTxnTUE=;
 fh=/7kV+3uYdGvPEfFyTl0VfvoV/YsYfUbqYjrLZG2V9t4=;
 b=f2ewXKcJ9ZlUTAdzFaNi12ECbq/uWVQr2QHTUbTGi7QbU/L/nRT+Qr8NWwoX17ixwC
 ManJqmCeLH19mTkHJ1zgu+vlfu8X0ZLCXU3EHRxq39+oE3ToxLk8WS6yoLAicbR9DyFi
 TEyPgZSLbfayMAtj4R104KIQJ+HLGDJh0r82YSFgDTySrMZG5yrIkXQJBBJR66zMLAZY
 xlfWXb4RK3yS5+GJW8qR2YI5CdH87Gl8ysnBzhLfz/z174vUYGp2eSWCC9zlO9l8qhe+
 +QBYrku8ES7RYXWUVJyi1+mRm9taZcjyxLs58tiZbWYOt8k+Qip3cpIin5e2DztaWeFH
 CUWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1775566804; x=1776171604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kL2sSGAkL4PZPcVc5FJ4HxqW1Olr8C1QXuJ6qTxnTUE=;
 b=dgeGbjWoS4oAQo0gcd4WP1DtkcGR2Ou2o4+qPUjCDGig3AP5FQFI304iRA8uKFRHAU
 H1VeUi4bMWBDGOdQ5AcEUgkreWcei2hZn/CeYVWcEBYjTTVk1Q5AbapfTRqSxA8teS5y
 5YDbNA4OcN47QOcZ6h42IWgxy/PNZn2uIFz3LyEheJIHJhmSbi5ZRPHys9j+nGIVXdPR
 FMIN9v9cpbHn7oTzxK1QBiXG+TEPnUXBIHhk22WbKDfVmc84NpaaAW5y8WCYqb+O2d/t
 Y6eHVNamNeQsSI6dNKii9PZ2gyz0sKu0Ka+CpS7ghjGQxK521Aw2tRhB9qw7g4ONkr5Q
 /9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775566804; x=1776171604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kL2sSGAkL4PZPcVc5FJ4HxqW1Olr8C1QXuJ6qTxnTUE=;
 b=RrmM+Ymd6h0+uIIiHdZ+pK11GZHuixCOys1gCJdpJyQcERwYWt6mqCUL7YrSV8J4mk
 Kio957FOmCWkwsxRS6W4g+xl5MGyN6k/zv+OIeeSF82jFjaAqfKawtodZfPtcSbinxK3
 i9z9ZIAdPyrrprASW5io/vUnYROMrCnlB+G9/sAsmMecXDd47tuoxGEOw5WGvI93H3uV
 vgwF+pn2f4IpE1+9SMjfLa/I37cvV600ddS0W68/b9ov7v+JB0mrTP06SGE1LNUxMqCA
 3afNB+hij0mPRzQVKU3llTLLJcfIy2VxmM1Q0VtO7Q96KCX0HnnnFJfuzp0Oiyko1jex
 dr5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZBckroWSmTsTPyYocOciuSAK4ionWcaUbXGLDr1OrNVOTpn251SGBtTidRvJMCH2ky1K74Jl+WBw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEK/ocIJ+xdzAd1zWOOyzuUicYjaI/+oFXbPWcCnfkYZmole1h
 ZposhpmBR6+nWEApbVjoEQfiJhVnGWZ9fQYV6v0+6Gsr+aslv+FpwCfFT28f1J+TWtfm2/fi31M
 Drqlbi6OqtUB4dL2qdPbT+a4O71tZF9ie4WZtO1Bxhg==
X-Gm-Gg: AeBDiesZd5aKHHtBez6IHrQgYb0cIJYnQEvCzoSuv3PpqkbWHfxCxk0nQNJHC79nYtJ
 IvHyXrmRSXbtBdr2dTYGVSkokQxw3DvxSgabf1EB2x/3i+riIVHT90E98alZ5xzulN3f6YU8n6O
 itWydQtjeeCmEg/hhUfloKKMIXI/u5hozasdazrcuQeTHniOdyV6Om4xux353UWDZMkbU2Jkelo
 FNmJYNKIFZyrCVwhrXd4CXnhoxNZE6GpzH1347YUAwBCztLAYGGzLij4GfgHCEj+6bBf2ehpH93
 /6k0uTLzHd31AMIN51KNkB2hDGRzvg9kdZm1zJLPZdifVVOnUshmMWb0X0QqWewGHXdgNFDjIX5
 KTuGPxAY4JSOSTdYvzYnJCpUCEg==
X-Received: by 2002:a05:6402:324c:b0:66e:df62:8826 with SMTP id
 4fb4d7f45d1cf-66edf6288a7mr2661001a12.8.1775566803791; Tue, 07 Apr 2026
 06:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJgF-xs=3fbKQO5Mj=coPMXq0ecWmV0bJDNFN44coEHV3WS=wg@mail.gmail.com>
 <20260331015202.51017-1-guilherme.bozi@usp.br>
In-Reply-To: <20260331015202.51017-1-guilherme.bozi@usp.br>
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Date: Tue, 7 Apr 2026 10:00:00 -0300
X-Gm-Features: AQROBzCMYxUk4VwRBwx6RguB_k0T4nYWVxTkeiFno4LHqPyS6xqSNyRshlEpVPo
Message-ID: <CAJgF-xswWgRGJGUDFRw+q4YOz1cVc5fqXumHBGxpLE_4736FQg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd/display: Deduplicate DCN DDC register
 assignment
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

Just a gentle ping on this.
Any feedback on v3 would be appreciated.

Thanks.


On Mon, Mar 30, 2026 at 10:52=E2=80=AFPM Guilherme Ivo Bozi
<guilherme.bozi@usp.br> wrote:
>
> Several DCN generations implement identical define_ddc_registers()
> functions to assign DDC register, shift and mask pointers based on
> GPIO ID.
>
> Introduce a shared inline helper,
> dcn_define_ddc_registers_common(), and convert all DCN
> implementations to use it.
>
> This reduces duplication and improves maintainability without
> changing behavior.
>
> No functional changes intended.
>
> Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
> ---
>
> v2:
>         - Corrected type mismatch (ddc_shift - ddc_sh_mask)
>
> v3:
>         - Fix threading (previous version was not sent as reply)
>         - Squashed fix to avoid build breakage
>
>  .../display/dc/gpio/dcn20/hw_factory_dcn20.c  | 27 ++++---------
>  .../display/dc/gpio/dcn21/hw_factory_dcn21.c  | 27 ++++---------
>  .../display/dc/gpio/dcn30/hw_factory_dcn30.c  | 27 ++++---------
>  .../dc/gpio/dcn315/hw_factory_dcn315.c        | 27 ++++---------
>  .../display/dc/gpio/dcn32/hw_factory_dcn32.c  | 27 ++++---------
>  .../dc/gpio/dcn401/hw_factory_dcn401.c        | 26 ++++---------
>  .../amd/display/dc/gpio/hw_factory_dcn_ddc.h  | 39 +++++++++++++++++++
>  7 files changed, 86 insertions(+), 114 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_dd=
c.h
>
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c=
 b/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
> index e0bd0c722e00..905d14079b91 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
> @@ -32,6 +32,8 @@
>  #include "../hw_hpd.h"
>  #include "../hw_generic.h"
>
> +#include "../hw_factory_dcn_ddc.h"
> +
>  #include "hw_factory_dcn20.h"
>
>
> @@ -182,25 +184,12 @@ static void define_ddc_registers(
>                 struct hw_gpio_pin *pin,
>                 uint32_t en)
>  {
> -       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> -
> -       switch (pin->id) {
> -       case GPIO_ID_DDC_DATA:
> -               ddc->regs =3D &ddc_data_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_data_regs_dcn[en].gpio;
> -               break;
> -       case GPIO_ID_DDC_CLOCK:
> -               ddc->regs =3D &ddc_clk_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_clk_regs_dcn[en].gpio;
> -               break;
> -       default:
> -               ASSERT_CRITICAL(false);
> -               return;
> -       }
> -
> -       ddc->shifts =3D &ddc_shift[en];
> -       ddc->masks =3D &ddc_mask[en];
> -
> +       dcn_define_ddc_registers_common(
> +               pin, en,
> +               ddc_data_regs_dcn,
> +               ddc_clk_regs_dcn,
> +               ddc_shift,
> +               ddc_mask);
>  }
>
>  static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c=
 b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
> index 2f57ee6deabc..f347b8c7e2b6 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
> @@ -32,6 +32,8 @@
>  #include "../hw_hpd.h"
>  #include "../hw_generic.h"
>
> +#include "../hw_factory_dcn_ddc.h"
> +
>  #include "hw_factory_dcn21.h"
>
>  #include "dcn/dcn_2_1_0_offset.h"
> @@ -170,25 +172,12 @@ static void define_ddc_registers(
>                 struct hw_gpio_pin *pin,
>                 uint32_t en)
>  {
> -       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> -
> -       switch (pin->id) {
> -       case GPIO_ID_DDC_DATA:
> -               ddc->regs =3D &ddc_data_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_data_regs_dcn[en].gpio;
> -               break;
> -       case GPIO_ID_DDC_CLOCK:
> -               ddc->regs =3D &ddc_clk_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_clk_regs_dcn[en].gpio;
> -               break;
> -       default:
> -               ASSERT_CRITICAL(false);
> -               return;
> -       }
> -
> -       ddc->shifts =3D &ddc_shift[en];
> -       ddc->masks =3D &ddc_mask[en];
> -
> +       dcn_define_ddc_registers_common(
> +               pin, en,
> +               ddc_data_regs_dcn,
> +               ddc_clk_regs_dcn,
> +               ddc_shift,
> +               ddc_mask);
>  }
>
>  static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c=
 b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
> index 36a5736c58c9..25eef1ee10fe 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
> @@ -32,6 +32,8 @@
>  #include "../hw_hpd.h"
>  #include "../hw_generic.h"
>
> +#include "../hw_factory_dcn_ddc.h"
> +
>  #include "hw_factory_dcn30.h"
>
>
> @@ -199,25 +201,12 @@ static void define_ddc_registers(
>                 struct hw_gpio_pin *pin,
>                 uint32_t en)
>  {
> -       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> -
> -       switch (pin->id) {
> -       case GPIO_ID_DDC_DATA:
> -               ddc->regs =3D &ddc_data_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_data_regs_dcn[en].gpio;
> -               break;
> -       case GPIO_ID_DDC_CLOCK:
> -               ddc->regs =3D &ddc_clk_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_clk_regs_dcn[en].gpio;
> -               break;
> -       default:
> -               ASSERT_CRITICAL(false);
> -               return;
> -       }
> -
> -       ddc->shifts =3D &ddc_shift[en];
> -       ddc->masks =3D &ddc_mask[en];
> -
> +       dcn_define_ddc_registers_common(
> +               pin, en,
> +               ddc_data_regs_dcn,
> +               ddc_clk_regs_dcn,
> +               ddc_shift,
> +               ddc_mask);
>  }
>
>  static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315=
.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
> index 5feebb3b95ca..571a6f1b0cf9 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
> @@ -32,6 +32,8 @@
>  #include "../hw_hpd.h"
>  #include "../hw_generic.h"
>
> +#include "../hw_factory_dcn_ddc.h"
> +
>  #include "hw_factory_dcn315.h"
>
>  #include "dcn/dcn_3_1_5_offset.h"
> @@ -191,25 +193,12 @@ static void define_ddc_registers(
>                 struct hw_gpio_pin *pin,
>                 uint32_t en)
>  {
> -       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> -
> -       switch (pin->id) {
> -       case GPIO_ID_DDC_DATA:
> -               ddc->regs =3D &ddc_data_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_data_regs_dcn[en].gpio;
> -               break;
> -       case GPIO_ID_DDC_CLOCK:
> -               ddc->regs =3D &ddc_clk_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_clk_regs_dcn[en].gpio;
> -               break;
> -       default:
> -               ASSERT_CRITICAL(false);
> -               return;
> -       }
> -
> -       ddc->shifts =3D &ddc_shift[en];
> -       ddc->masks =3D &ddc_mask[en];
> -
> +       dcn_define_ddc_registers_common(
> +               pin, en,
> +               ddc_data_regs_dcn,
> +               ddc_clk_regs_dcn,
> +               ddc_shift,
> +               ddc_mask);
>  }
>
>  static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c=
 b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
> index 985f10b39750..d6e97b246bae 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
> @@ -32,6 +32,8 @@
>  #include "../hw_hpd.h"
>  #include "../hw_generic.h"
>
> +#include "../hw_factory_dcn_ddc.h"
> +
>  #include "hw_factory_dcn32.h"
>
>  #include "dcn/dcn_3_2_0_offset.h"
> @@ -203,25 +205,12 @@ static void define_ddc_registers(
>                 struct hw_gpio_pin *pin,
>                 uint32_t en)
>  {
> -       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> -
> -       switch (pin->id) {
> -       case GPIO_ID_DDC_DATA:
> -               ddc->regs =3D &ddc_data_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_data_regs_dcn[en].gpio;
> -               break;
> -       case GPIO_ID_DDC_CLOCK:
> -               ddc->regs =3D &ddc_clk_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_clk_regs_dcn[en].gpio;
> -               break;
> -       default:
> -               ASSERT_CRITICAL(false);
> -               return;
> -       }
> -
> -       ddc->shifts =3D &ddc_shift[en];
> -       ddc->masks =3D &ddc_mask[en];
> -
> +       dcn_define_ddc_registers_common(
> +               pin, en,
> +               ddc_data_regs_dcn,
> +               ddc_clk_regs_dcn,
> +               ddc_shift,
> +               ddc_mask);
>  }
>
>  static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401=
.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
> index 928abca18a18..06a4d7a8a1ac 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
> @@ -12,6 +12,7 @@
>  #include "../hw_hpd.h"
>  #include "../hw_generic.h"
>
> +#include "../hw_factory_dcn_ddc.h"
>
>  #include "dcn/dcn_4_1_0_offset.h"
>  #include "dcn/dcn_4_1_0_sh_mask.h"
> @@ -195,25 +196,12 @@ static void define_ddc_registers(
>                 struct hw_gpio_pin *pin,
>                 uint32_t en)
>  {
> -       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> -
> -       switch (pin->id) {
> -       case GPIO_ID_DDC_DATA:
> -               ddc->regs =3D &ddc_data_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_data_regs_dcn[en].gpio;
> -               break;
> -       case GPIO_ID_DDC_CLOCK:
> -               ddc->regs =3D &ddc_clk_regs_dcn[en];
> -               ddc->base.regs =3D &ddc_clk_regs_dcn[en].gpio;
> -               break;
> -       default:
> -               ASSERT_CRITICAL(false);
> -               return;
> -       }
> -
> -       ddc->shifts =3D &ddc_shift[en];
> -       ddc->masks =3D &ddc_mask[en];
> -
> +       dcn_define_ddc_registers_common(
> +               pin, en,
> +               ddc_data_regs_dcn,
> +               ddc_clk_regs_dcn,
> +               ddc_shift,
> +               ddc_mask);
>  }
>
>  static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h b/d=
rivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h
> new file mode 100644
> index 000000000000..863177cf67e8
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef __DAL_HW_FACTORY_DCN_DDC_H__
> +#define __DAL_HW_FACTORY_DCN_DDC_H__
> +
> +static inline void dcn_define_ddc_registers_common(
> +               struct hw_gpio_pin *pin,
> +               uint32_t en,
> +               const struct ddc_registers *data_regs,
> +               const struct ddc_registers *clk_regs,
> +               const struct ddc_sh_mask *shift,
> +               const struct ddc_sh_mask *mask)
> +{
> +       struct hw_ddc *ddc =3D HW_DDC_FROM_BASE(pin);
> +
> +       switch (pin->id) {
> +       case GPIO_ID_DDC_DATA:
> +               ddc->regs =3D &data_regs[en];
> +               ddc->base.regs =3D &data_regs[en].gpio;
> +               break;
> +
> +       case GPIO_ID_DDC_CLOCK:
> +               ddc->regs =3D &clk_regs[en];
> +               ddc->base.regs =3D &clk_regs[en].gpio;
> +               break;
> +
> +       default:
> +               ASSERT_CRITICAL(false);
> +               return;
> +       }
> +
> +       ddc->shifts =3D &shift[en];
> +       ddc->masks =3D &mask[en];
> +}
> +
> +#endif /* __DAL_HW_FACTORY_DCN_DDC_H__ */
> --
> 2.47.3
>
