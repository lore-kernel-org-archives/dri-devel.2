Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B16CD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3AB10EB41;
	Wed, 17 Jun 2026 20:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RJT12VEB";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5759210EB41
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 20:58:06 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-59e8ededf4dso164517e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781729885; x=1782334685;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VaZW2+PuX7Z8DAFrqZaGYjPQTrf2K7Jhi60tx/veRRU=;
 b=RJT12VEBXy0gWySrgB3vyVn/PnDFBtwDOPb4WQWuXq6o/YTj918o4cnzCOWDd44Di2
 nhLEKVYNe4YLbhw7YDfUkafOlAMOK2y16WZyDy49MSFzoI7Hj5zWOVq8O9zsP55RwSSB
 p/DJ8S0RZVhCGceGVxrsgsBejA4YAgpVOz8Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781729885; x=1782334685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VaZW2+PuX7Z8DAFrqZaGYjPQTrf2K7Jhi60tx/veRRU=;
 b=SSP8rx7LC7L4v4xJHXkAo61JfYXu8X/oUk0bWCtA4E0NPl6Oa9ZesTQi94shVq+KOH
 LS4ETisXRP8edTAOZ1U9gIuS9pZ6RDfQ/tPgZAWKlnnRT4eNGpiy8r2sjdTv4x7d+hvz
 ccohMIKZZUwn9O8awCn5wX7u0+XhqvrF6E5+1ZBCe/huGaJc2oHxYFsXTx1pGLcjBpbA
 4W/J5kX55pbCSu/cxMuue9zpSgDKyAbt4ghr/HI6qUpvpmd+wovwRmhYGCI/9ovwgymT
 avHtIHf2o+vrafWbTN3nZAZK/Ms3G7+WGgPB1K1B8Q7RU+LqxqI5N0ochUd6oHDuVNjS
 9HXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+b7xrOJCJNGNSufBeyGzBM5P6x9lbRy0aV5K5uNfKG6ozNRBOmpydLe4us8VPurcoMhRTcx9ARF3Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkXYSp/RB7NViueM7wqJiU6lk4D45s+mz2jiGa1pblBBMj4CKi
 wEohaIRQ0PKz1LCk2lX+hmu7bDj7py20k0PPfXXnDZ5kWnzjqLKnhb1q40DnKOHe2Bv0eu1cMYg
 jTxA=
X-Gm-Gg: AfdE7ck2sd/ZSFnQdaytqVeDcVu/kyIjuMh4gGn8qNSKmg+W23CVyQn/tNTZLCSSbsM
 lelwA4Bk/iNQwrRq/Bc2JIg78RjmY9v3EZgn3VI8OkszvTD5lZMvCAsAcpr2UYMnkqA5Gw+a0w2
 holDfGy185MCx788cRuiKijHJ3Dhxj2l8GlrO4pXqwPuwKdqELeUzbFefUvd+tEeqF4f1I2SjkT
 U6/c3V1pZ9Ik9+tkL+ffdqAlXP1opgWjop6beBQlnc9xadD8dTETzYOB9aeCKX4O51iWkLQmY+e
 QNus5BiFLB+fxbJsnuifCP+NsbmNOak5klZFst/S/wkUFtdNETBVOeaonKfNXGe/hrZaPCGhrAg
 cdt3JJUHWhQhg4bAXg35me4H+noSPi9j9mQs5pyPZ/eCcZnkeitQXO+C0NJE+P1FwSJP9uVoSDp
 8kuSJoNPPMYG9X4cv7fLwAgaUFS7mlAM6v8Ko+MAygl15Vze8n/kMjSS5sEqVxRg==
X-Received: by 2002:a05:6122:3982:b0:5a3:5483:3fdc with SMTP id
 71dfb90a1353d-5bbc0cb6509mr2918007e0c.9.1781729885070; 
 Wed, 17 Jun 2026 13:58:05 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com.
 [209.85.217.50]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb901f2d7bsm9331958e0c.17.2026.06.17.13.58.03
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 13:58:03 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-6c25b040555so191000137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 13:58:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9Es+DtOxSgvwCcXA340P6kRg2FaSz57NA7DEurdMCmuz7FrDnj2sGOl8D9AA0J+Yjdb78YhkOyujE=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3e11:b0:726:9ee1:8783 with SMTP id
 ada2fe7eead31-7269ee19755mr2122404137.10.1781729882777; Wed, 17 Jun 2026
 13:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260617101101.3474684-1-zhouhaikun5@huaqin.corp-partner.google.com>
In-Reply-To: <20260617101101.3474684-1-zhouhaikun5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 17 Jun 2026 13:57:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WijoqoZ3m2L0ytf4LWC_ufqWh_srcABBntkbuXzK5iPA@mail.gmail.com>
X-Gm-Features: AVVi8Cdqvt3JND5S8ibkjzmWblpnzGhQdfCY3eReKtzKWjvxt5a8z3rNtQTiCx8
Message-ID: <CAD=FV=WijoqoZ3m2L0ytf4LWC_ufqWh_srcABBntkbuXzK5iPA@mail.gmail.com>
Subject: Re: [PATCH] Support new NV140FHM-N5B and TM156VDXP25 edp panel
To: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, sam@ravnborg.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 daniel@ffwll.ch, airlied@gmail.com
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

On Wed, Jun 17, 2026 at 3:11=E2=80=AFAM Haikun Zhou
<zhouhaikun5@huaqin.corp-partner.google.com> wrote:
>

Note: your ${SUBJECT} line is missing the proper prefixes. A better subject=
:

drm/panel-edp: Support NV140FHM-N5B and TM156VDXP25

I'll fix when applying.

> the NV140FHM-N5B need 200ms delays from the backlight on to valid data,

"the" should be capitalized ("The"). I'll fix when applying, plus some
other minor cleanups to this message.


> 100ms delays from backlight off to valid data, the TM156VDXP25 need
> 100ms delays from the backlight off to valid data.
>
> NV140FHM-N5B raw edid:
> 00 ff ff ff ff ff ff 00 09 e5 98 0d 00 00 00 00
> 10 23 01 04 a5 1f 11 78 01 c8 d5 95 5d 59 94 29
> 23 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 94 37 80 a0 70 38 3c 40 30 20
> 36 00 35 ae 10 00 00 1a 76 2c 80 a0 70 38 3c 40
> 30 20 36 00 35 ae 10 00 00 1a 00 00 00 fd 00 28
> 3c 44 44 0e 01 0a 20 20 20 20 20 20 00 00 00 fc
> 00 4e 56 31 34 30 46 48 4d 2d 4e 35 42 0a 01 87
>
> 70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
> 00 00 53 ff 53 ff 3c 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 90
>
> TM156VDXP25 raw edid:
> 00 ff ff ff ff ff ff 00 51 a1 39 21 00 00 00 00
> 0d 24 01 04 a5 22 13 78 03 6e 95 99 5b 58 8d 28
> 21 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 af 2b 80 a0 70 38 28 40 30 20
> 36 00 58 c2 10 00 00 1a 00 00 00 fd 00 28 3c 43
> 43 0e 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
> 4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
> 00 54 4d 31 35 36 56 44 58 50 32 35 0a 20 01 ef
>
> 70 20 79 02 00 21 00 1d 72 0d 90 07 80 07 38 04
> 80 95 69 5b 8d 95 8d 87 42 21 02 35 54 b0 5c b0
> 5c 00 42 12 78 22 00 14 ff 21 02 85 7f 07 9f 00
> 2f 00 1f 00 37 04 27 00 02 00 05 00 2b 00 0c 27
> 00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
> b0 5c b0 5c 81 00 1e 72 1a 00 00 03 01 28 3c 00
> 00 53 ff 53 ff 3c 00 00 00 00 e3 05 04 00 e6 06
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90 90
>
> Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 81e1866d54e78..3e6d8f17c3072 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2010,6 +2010,15 @@ static const struct panel_delay delay_80_500_e50_d=
50 =3D {
>         .disable =3D 50,
>  };
>
> +static const struct panel_delay delay_200_500_e50_po2e200_d100 =3D {
> +       .hpd_absent =3D 200,
> +       .unprepare =3D 500,
> +       .enable =3D 50,
> +       .powered_on_to_enable =3D 200,
> +       .disable =3D 100,
> +};
> +
> +

Checkpatch in strict mode yells.

-:68: CHECK:LINE_SPACING: Please don't use multiple blank lines
#68: FILE: drivers/gpu/drm/panel/panel-edp.c:1900:
+
+

I can fix when applying.

Also: not that there's any great way to sort these timings structures,
but I feel it belongs immediately after "delay_200_500_e50_po2e200"
since it's so similar. I'll move it.


>  #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, =
_delay, _name) \
>  { \
>         .ident =3D { \
> @@ -2144,6 +2153,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116=
WHM-A4D"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d45, &delay_200_500_e80, "NV116=
WHM-N4B"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140=
WUM-N6S"),
> +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d98, &delay_200_500_e50_po2e200=
_d100, "NV140FHM-N5B"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153=
WUM-N42"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ddf, &delay_200_500_e80, "NV116=
WHM-T01"),
>
> @@ -2250,6 +2260,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>
>         EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, "T=
M140VDXP01-04"),
>         EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e50_d100, "=
TL140VDMS03-01"),
> +       EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e50_d100, "=
TM156VDXP25"),

Wow, I had to do quite a few manual fixups when applying. :( Please
work with others in your organization to learn how to more correclty
post up patches.

[1/1] drm/panel-edp: Support NV140FHM-N5B and TM156VDXP25
      commit: b9e2d5cdaab05c997be3a69d9b372d7676683e1b


-Doug
