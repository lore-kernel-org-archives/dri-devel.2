Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7732109316C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 01:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D94C310E47B;
	Fri, 20 Mar 2026 01:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VoVJQZa3";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CB410E47B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 01:05:12 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-666f646f5cfso4089674a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773968709; x=1774573509;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buAeCDoz5xajvgGDcUkmhrOgdBqPOrFyl/OxmzoTsCk=;
 b=VoVJQZa3XBtZvlywckqTGU+O76TKCF5TtmowgG6+ZEpci7jUacp0onO9jIW+7mGcDc
 Sln7PiqDsz67kx3kKWDYgZNXjVk5Lvd9Hq22JUuG0gw/4mYGBu8rWSsnT9L88f+5tVkK
 eYtwRg9dwy/2gKhPsrUDhcHEh21J2dMcqLbc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773968709; x=1774573509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=buAeCDoz5xajvgGDcUkmhrOgdBqPOrFyl/OxmzoTsCk=;
 b=kZv/d/fVsE/5oVHQt0jOJFpUZX0vGp2RNL6uNmeveJBiSRfsRdkztZkXgo4J/WSfWp
 8oPAX1KaF7hEl7/d4jaHZ3Znhi/QC3ywB76LDNZZnpJ1VNxnn7EfAtNBREviG/25e4cc
 TEg2HgLGXxFg0QEVG2iu++reAlH+qtY5+AiyNg4L5MmXbsEJdB5eHQeEyA83toC0iUrO
 5s40mRikESCNNUQCXOTEae1Fq3AZ72hjRWXA2Q+hpZtZQ/A0eQQezUqNsCGauiWMC8Tf
 zZLLknCLJRjFePR9XRkgapd3TA07ThB4XGrftUmdZ/Sl4x2q1v0CD3Zx6XwqR7HVbwmP
 ZedA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnxQx5FcvDD0rgp4tNKtpDY63PR4Cdm4zBcqrax5Gf9MnxY77qKZUM7lVFs0GKlI3YkOxoBSpBOEQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfBJxxHbLvFY+peU7BNfT4uwRNnShBAUIoNhWvrL+xbu57u6n5
 QV8rLGTCNtQ7xcvj/qhcU1khwA1FAL5IPfiNONfE4SroddXGMrnW8KUy6OonzaARvsfuQGTkvMh
 cVlhIpXN0
X-Gm-Gg: ATEYQzxdj6vB8GBsAe1IWc8f4+05yPR09IWYW61A8JSix34b9jKgbVYIgP7ViZ03Afv
 b5o8K7txUnziS6bL2J+ZzBv+/7Fm7LaeD60xW95sMuebYLs8eZHo2h3AFuq42Td8hYVZtKP88/X
 8bhH+L1APyn0ERC5ZEsGbsMqnwUBlHPgSw84DvoJTYyh+b6L5VTyDI0YDXiUKnVFoTG3iQGab8J
 gFctVpLz7b98EpHPfbCO+uXUpyBshthvHV2B4n9UkGYslo8LHp4IKznBlHAIdo3n4Jur+Rm3LdB
 7IsAVVXMm9G/Jan5TjDql19DZLemQdpXadrrNXelvQWBqN+1CLeXM+RmeD/8VZn++qlH9ujemMn
 +udqG7AyPho7IxKp9UajIv0mecEQX5WlinEtlBhqQchCY/r09xQoqNi5rdHypFanRvOmV7dz8pw
 DAel+/kyTXUtH6xbURnUs8m11Z2cs4AJTC0QLVrSbzN1KeRgP2Arqe07vXpNAV8w==
X-Received: by 2002:a17:906:ba8f:b0:b93:61c7:4f09 with SMTP id
 a640c23a62f3a-b982f5e06f1mr84165366b.20.1773968709258; 
 Thu, 19 Mar 2026 18:05:09 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com.
 [209.85.221.42]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98335de3d7sm48750066b.36.2026.03.19.18.05.07
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 18:05:08 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43b3d9d0695so1194445f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:05:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVIp+JG6awLlzfC+7qdkc433lbEYvg5NGNHEpxty8Y4NOUVszbR3CyCsKdrB6F+wCILSgWQuMtZO0c=@lists.freedesktop.org
X-Received: by 2002:a05:6000:2c02:b0:437:7719:ca82 with SMTP id
 ffacd0b85a97d-43b6423ca1bmr2501717f8f.3.1773968707129; Thu, 19 Mar 2026
 18:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260319050938.556235-1-alvin1.chen@lcfc.corp-partner.google.com>
In-Reply-To: <20260319050938.556235-1-alvin1.chen@lcfc.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 19 Mar 2026 18:04:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V0H17cgjbEBXkv6PG4mxycCgrCtduXrw1kEk--t5NFtg@mail.gmail.com>
X-Gm-Features: AaiRm52NJJZ0tMZKWcS1ghX988vrGPqhHcfhGY-QBPEWNVeSTpxhGXj34y1Bbl8
Message-ID: <CAD=FV=V0H17cgjbEBXkv6PG4mxycCgrCtduXrw1kEk--t5NFtg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel-edp: Add BOE NV153WUM-N42, CMN N153JCA-ELK, 
 CSW MNF307QS3-2
To: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
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

Hi,

On Wed, Mar 18, 2026 at 10:09=E2=80=AFPM Alvin1 Chen
<alvin1.chen@lcfc.corp-partner.google.com> wrote:
>
> The raw EDIDs for each panel:
>
> BOE: NV153WUM-N42
> 00 ff ff ff ff ff ff 00 09 e5 b3 0d 00 00 00 00
> 11 23 01 04 a5 21 15 78 03 af e5 97 5e 58 92 28
> 1f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 9c 3e 80 c8 70 b0 3c 40 30 20
> 36 00 49 ce 10 00 00 1a 00 00 00 fd 00 28 3c 4c
> 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
> 4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fc
> 00 4e 56 31 35 33 57 55 4d 2d 4e 34 32 0a 01 92
>
> 70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
> 00 00 60 49 60 49 3c 00 00 00 00 80 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 cb 90
>
> CMN: N153JCA-ELK
> 00 ff ff ff ff ff ff 00 0d ae 6b 15 00 00 00 00
> 16 23 01 04 a5 21 15 78 03 08 82 93 59 53 8e 27
> 1e 4f 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 42 3c 80 a0 70 b0 24 40 30 20
> a6 00 49 cd 10 00 00 1a 00 00 00 fd 00 28 3c 4a
> 4a 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
> 4d 4e 0a 20 20 20 20 20 20 20 20 20 00 00 00 fc
> 00 4e 31 35 33 4a 43 41 2d 45 4c 4b 0a 20 01 d5
>
> 70 20 79 02 00 25 01 09 94 5a 02 94 5a 02 28 3c
> 80 81 00 13 72 1a 00 00 03 01 28 3c 00 00 00 00
> 00 00 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ae 90
>
> CSW: MNF307QS3-2
> 00 ff ff ff ff ff ff 00 0e 77 29 15 00 00 00 00
> 13 23 01 04 a5 21 15 78 03 9c 81 96 5d 5a 94 28
> 1e 51 56 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 1a 3f 80 04 71 b0 23 40 30 20
> 36 00 49 cd 10 00 00 18 00 00 00 fd 00 28 3c 4a
> 4a 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
> 4f 53 54 20 54 39 0a 20 20 20 20 20 00 00 00 fc
> 00 4d 4e 46 33 30 37 51 53 33 2d 32 0a 20 01 5c
>
> 70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
> 00 00 60 46 60 46 3c 00 00 00 00 8d 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 c4 90
>
> Signed-off-by: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 679f4af5246d..775bc4474916 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1991,6 +1991,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116=
WHM-A4D"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d45, &delay_200_500_e80, "NV116=
WHM-N4B"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140=
WUM-N6S"),
> ++      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153=
WUM-N42"),

There are two "+" symbols above, which means that you're actually
putting a "+" in the source code. That's not right. I've fixed it for
you this time while applying, but please be more careful.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next.

[1/1] drm/panel-edp: Add BOE NV153WUM-N42, CMN N153JCA-ELK, CSW MNF307QS3-2
      commit: d51f217957ca1fa3a151000e86a192231284595b
