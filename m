Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9207C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123FD10E65F;
	Mon,  6 Jul 2026 12:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FtEQJYii";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEA510E16D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:34:42 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so4294569a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783341281; x=1783946081; darn=lists.freedesktop.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x9DuFiLJFQhXF47fb9omkU+r2KlD4K7BS2Tl2g+RiHE=;
 b=FtEQJYiizEiFTlUJyxnNkxoFliQyIJvYWy/tfWwFqcgb5SuD/2E9fbOVtZ1dGbTg3E
 1qsVcXQV505l5oGPadGDzLi9zWIbrzUf8l02QBuQ6HmPRbHhtleTkjGziuVsrpqg0FkC
 heBYqZHe1m/RZK9L01qvHueG/+96amXvna7aegHOgG1J8EPXaOHXw48rj4o1IhbhrM0z
 CLq7EjF3CFRYawlq/709J3y9kMfZyM/UelGb/U53qol3B9ASKM8Uj9QiOHCcvM/nZVDe
 znCS2Rzz7pRHHuAdbB22MK8fa9WokfmAe8zOxY1wCrJjGte4tDfB6wRak8m+HgBPILyX
 NfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341281; x=1783946081;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x9DuFiLJFQhXF47fb9omkU+r2KlD4K7BS2Tl2g+RiHE=;
 b=KtHiun1npnWyKkWl0XtnQIoEPZ/YmlEGV7+zXtfasXH/o1SyUeINpGD3PdvZxDfcTP
 R3XhwWFwH2r25hglxQDUWwMdi82Ty8VBhC7voAV2zTGyFIHoUYwp34+Tz2Vjyp371i0F
 vkCd7sexKq8cYpsObyOTElkR0ebAUsvaxyPtzSVUxqbtpQX5F+AHyBChducGaNiecUmm
 ixz3ELB+Z2ycwJUgXD40E/mGUCkfKYLwdcsXcDPdbeAn5Tdafm8WRrtvzUbjCLPLc1kz
 1i/BIIAMq/eS+HZ/yOsgDp4zxuroSywvvIWWohilcx1beaQox5Tb9nNkN5pj8TbYAMK3
 WWtA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp80l9a0rMUo/1BU+6+8TRZvilWtJCrOq9rJ8jEaLTZrkTpZxzS/S69ulNepnkOo0GYlR2JeH2VV7I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzivtpQJ/y+8yZ+QfB6f0hETr8E1zFoa4/5H3ZzTNp6AsmWKrd5
 zQM4X2NV3uvQr2h0m2JNrCfJh8t7njYDG/ENiopAkXfOEE6isO4D7og=
X-Gm-Gg: AfdE7cmxtsIFuoVSTPE1C2UXwWxPlaZitACb1rrWFUiivxiy0K5rT1PvXizUArdYE1e
 ssxrchGP4ZRDKLtyaoxUGDbH8gkJMD28OdFNGQR11gWBsCwX7ldRgLVYgkuiEG/2OtXs8nGdVVL
 rZs0lYtEL73zgGmdtHrIiXkI/XDUJ34mEJ3zKdSnWIwICsTexzhwD0MaUMNAEUrBWOBs1OpoRN5
 VAdJg5iIaqWzcA1nJYCKsSzwaotLMQPBMWHqPNOEabvWStZq/0gdaVeRoPCqM4QTzV3ggJDV4Ql
 778jKBV9pKJlTCmW71bb5A85ihx4k3h3HaP6BAnwZ6HG7oOLaF6BDqR2vqCSlf+syFJSKTMc1tw
 EtA+onWsIRRRfG7SL9p8O9uUknjsmZtnwQnmrMQ5+IjVz9PFCtQ5LHprNK4c1FHvjNjQ5EW5wch
 PJEUw4iUDr0ZCqar3pVM/XY5KK1FMlQ6lnPRQO4+LOZP788BFH7PHRXdtDiFk=
X-Received: by 2002:a17:907:a709:b0:c12:caad:6efa with SMTP id
 a640c23a62f3a-c15a676bf23mr21887566b.4.1783341281063; 
 Mon, 06 Jul 2026 05:34:41 -0700 (PDT)
Received: from localhost ([186.158.238.108]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d7a375sm3926102a12.15.2026.07.06.05.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 05:34:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 09:34:34 -0300
Message-Id: <DJRHPZG7YKTX.1HUB8IXSAR0R0@gmail.com>
Subject: Re: [PATCH] drm/panel: novatek-nt37801: Use mipi_dsi_*_multi()
 functions
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
To: "Doug Anderson" <dianders@chromium.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Brigham Campbell"
 <me@brighamcampbell.com>, "David Airlie" <airlied@gmail.com>, "Jessica
 Zhang" <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>
X-Mailer: aerc 0.20.0
References: <20260701125624.199786-1-nico.antinori.7@gmail.com>
 <CAD=FV=VKKb1Xy2Y7D1Lv8DXhaG1_zHZqTk2Q74oT-YKGd5CCiQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VKKb1Xy2Y7D1Lv8DXhaG1_zHZqTk2Q74oT-YKGd5CCiQ@mail.gmail.com>
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

On Sat Jul 4, 2026 at 12:59 PM -03, Doug Anderson wrote:
> Hi,
>
> On Wed, Jul 1, 2026 at 5:56=E2=80=AFAM Nicol=C3=A1s Antinori
> <nico.antinori.7@gmail.com> wrote:
>>
>> Replace mipi_dsi_* functions with their non-deprecated mipi_dsi_*_multi
>> counterparts. This change reduces error-checking boilerplate and improve=
s
>> readability.
>>
>> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
>> ---
>> Note: I Compile-tested this patch since I don't own the panel to test it=
.
>>
>>  drivers/gpu/drm/panel/panel-novatek-nt37801.c | 16 ++++++----------
>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu=
/drm/panel/panel-novatek-nt37801.c
>> index d6a37d7e0cc6..daa356bbc182 100644
>> --- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
>> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
>> @@ -128,7 +128,8 @@ static int novatek_nt37801_off(struct novatek_nt3780=
1 *ctx)
>>  static int novatek_nt37801_prepare(struct drm_panel *panel)
>>  {
>>         struct novatek_nt37801 *ctx =3D to_novatek_nt37801(panel);
>> -       struct device *dev =3D &ctx->dsi->dev;
>> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
>> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>>         struct drm_dsc_picture_parameter_set pps;
>>         int ret;
>>
>> @@ -145,15 +146,10 @@ static int novatek_nt37801_prepare(struct drm_pane=
l *panel)
>>
>>         drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
>>
>> -       ret =3D mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
>> -       if (ret < 0) {
>> -               dev_err(panel->dev, "failed to transmit PPS: %d\n", ret)=
;
>> -               goto err;
>> -       }
>> -
>> -       ret =3D mipi_dsi_compression_mode(ctx->dsi, true);
>> -       if (ret < 0) {
>> -               dev_err(dev, "failed to enable compression mode: %d\n", =
ret);
>> +       mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
>> +       mipi_dsi_compression_mode_multi(&dsi_ctx, true);
>> +       if (dsi_ctx.accum_err) {
>> +               ret =3D dsi_ctx.accum_err;
>>                 goto err;
>>         }
>
> Sure, this looks pretty good.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> For bonus points, I think you could change novatek_nt37801_on() to
> return "void" and take a "struct mipi_dsi_multi_context". Since
> drm_dsc_pps_payload_pack() is harmless, the function can now just be:
>
>   novatek_nt37801_on(&dsi_ctx);
>   drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
>   mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
>   mipi_dsi_compression_mode_multi(&dsi_ctx, true);
>   if (dsi_ctx.accum_err) {
>     ...
>   }


Will send a v2 with those changes. Thank you for the suggestion!
