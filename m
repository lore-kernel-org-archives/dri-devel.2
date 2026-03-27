Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB7110F2846
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11A010ED0A;
	Fri, 27 Mar 2026 15:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l3J6dqFL";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A342610ED0A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 15:42:24 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so430262966b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774626142; x=1775230942;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xpiE5qLCX/z93h07XaX47BnRvPE83mmoK7+XLkD9gY=;
 b=l3J6dqFLL+jG/80YYeA0PBLENuH/+cpcwPSFCqz9ltD7t4tUlWV3PqlsJxxAwhh5ed
 1h4jdVW2kmvExdP+lVcU3dCCyFig1nyE3LunikNZImhRCouF7dICwkm1rsIRIA7OONtF
 qTMIkOEdvyNnLlGXClSCPvpgffJtPfikJjTro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774626142; x=1775230942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5xpiE5qLCX/z93h07XaX47BnRvPE83mmoK7+XLkD9gY=;
 b=KJ3E4NVKvTcv33S3hV4w95fSgcxRKFY0K9JZAN3WT53B9WRXbDggYsEZgx6hn9u+BX
 IGyAJipM2gngh32c5DKKdSFq0szv1CfI/+J60fDIuNm0vREX8O5fNuusMp8tQ2MR0pYn
 c/19X3/X+Jwz6X20mOmbwLauKxl21Xsr+0pC/Jh8J624ZpBXhpxVxCA9e6AOFg0bUfdM
 kLNdCOO2AOitji8bjmNrqC6iSzkU4+yixE4mQk7G1SPlJi+cA9JWiaxnPRFP4+btpV0E
 gS/U6EFlsAqoGyZeP1/TZ0Qao+7YnTUxd3V4NdSCUeh41hpTqv9/tO2h4O0Z/WqoQ7vb
 5F7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbS9I7JxVkrw9Ut6OIR3qwyppdkmLGCyyc9pmRe0iBlfCveJLKgcjphU76DJAM/c/qVXeOXR0Kick=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNkaVTwFm6YqapnDdjliEwwBj9LyrpylEeMb0ft3lUhqVswahA
 7BhwjzlBLe5K9Go32YdRWTrH7VwyfJEmrVjBD4jlJlHOix1VpP9TOH7knVHaUCF9IIVdS7llLUe
 YL4Twmw==
X-Gm-Gg: ATEYQzyvlpCiuVr781O1MwleYLmy7JyfLVVy8cqQmqg726376xDI86dkuWs39eWYcr3
 zXrixIofNCUT7ThiF1qS6b0xLGKFrs0sNGg8MWDiVkaJmBxuFiaPFmJQGnyE/AE/mAVDap2Fc/Y
 RbCugnANpmj+qO3TJwQbX8R5HXQpt7grVhVte4Rg7IeDn+eJ2z0NNJ4gIuWgXKGyYLT7TMy+Z9b
 m/Fz/Yx3cHiJclJpiq87Md7zmUGDCp/l86wPYOfhshN3KE5pNLFC2WCDBFUJsrAq1YyTetYmvc3
 /iABplvVqqv6bDLVSfi9LTkiIl1QD2F9CaFawEj/a3OasT0gRQFHBeuFPZbrfzVuRRFeKei4E+B
 fGaCV/9ZsU47o5bJzpICXXc7BsIFe6B2cvq2Foyf9f89AMiyMtLbvGJqmdqF9k7GAvgQafD2s0G
 8+uFxMgpy2mxER3uqmQxi94j2ATuBm7IFfkPeSb+n1K31HolRG0q/hvl6379W3Qg==
X-Received: by 2002:a17:907:d20e:b0:b96:f863:deba with SMTP id
 a640c23a62f3a-b9b507a7e5emr199834966b.32.1774626142377; 
 Fri, 27 Mar 2026 08:42:22 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com.
 [209.85.221.45]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66ad6a58cb0sm2399290a12.25.2026.03.27.08.42.19
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 08:42:20 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so1580262f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 08:42:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVMYFq+h1O0RSZ8Qnh8EfOgTEC9n0slTva6m8XYK4vY2jgjTOdVONMdD486CbiTY3vZTmgvt5mxGVs=@lists.freedesktop.org
X-Received: by 2002:a05:6000:24c6:b0:43b:4582:e90d with SMTP id
 ffacd0b85a97d-43b9e9fadfbmr4874445f8f.42.1774626139114; Fri, 27 Mar 2026
 08:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260324061444.242917-1-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20260324061444.242917-1-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 27 Mar 2026 08:42:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xuf5T6tmbNXFrQjiKL4W5op0OnR9pvBmnh4Me+czvtRA@mail.gmail.com>
X-Gm-Features: AQROBzAhm1Ip4tQjiRAbA6k1_tTaiqSpq9K_vhTgfY--V6r2eIpK-ym3SOvPvQc
Message-ID: <CAD=FV=Xuf5T6tmbNXFrQjiKL4W5op0OnR9pvBmnh4Me+czvtRA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel-edp: Add 2 panels used by MT8186 Chromebooks
To: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
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

On Mon, Mar 23, 2026 at 11:14=E2=80=AFPM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> The raw EDIDs for each panel:
>
> CSW
> - PNB601LS1-2
> 00 ff ff ff ff ff ff 00 0e 77 0a 11 00 00 00 00
> 30 23 01 04 a5 1a 0e 78 03 a1 35 9b 5e 58 91 25
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
> 36 00 00 90 10 00 00 1a 06 14 56 dc 50 00 28 30
> 30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0c 3d ff 0c 3c 7d 0e 0b 17 7d 00 00 00 00 e8
>
> LGD
> - LP116WHA-SPB1
> 00 ff ff ff ff ff ff 00 30 e4 fe 07 01 01 00 00
> 00 24 01 04 a5 1a 0e 78 03 72 e5 9c 5e 5b 94 27
> 19 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 d5 21 56 a0 50 00 b2 30 30 20
> f8 0c 00 90 10 00 00 1a 8e 16 56 a0 50 00 b2 30
> 30 20 f8 0c 00 90 10 00 00 1a 00 00 00 fd 00 28
> 3c 39 39 09 01 0a 20 20 20 20 20 20 00 00 00 02
> 00 0f 3d ff 0f 3c 7d 0d 0a 15 7d 00 00 00 01 da
>
> 70 20 79 02 00 25 00 09 57 52 01 57 52 01 28 3c
> 80 81 00 15 74 1a 00 00 03 01 28 3c 00 00 4a 5a
> 4a 5a 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ef 90
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)

The ${SUBJECT} of your patch is too generic. There are far too many
patches saying "add N panels for <some> Chromebook". Please choose
more descriptive subjects.

In this case, I've fixed it for you to:

drm/panel-edp: Add CSW PNB601LS1-2 and LGD LP116WHA-SPB1

Patches typically get applied more quickly if I don't need to do
manual fixups like this.


> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 497dcd48f57b..7d80524a9406 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2072,6 +2072,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1100, &delay_200_500_e80_d50, "M=
NB601LS1-1"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, "M=
NB601LS1-3"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, "=
MNB601LS1-4"),
> +       EDP_PANEL_ENTRY('C', 'S', 'W', 0x110A, &delay_200_500_e50, "PNB60=
1LS1-2"),

Convention in the Linux kernel (and, more importantly, in this file)
is lowercase hex. I've changed the above 0x110A to 0x110a.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next.

[1/1] drm/panel-edp: Add CSW PNB601LS1-2 and LGD LP116WHA-SPB1
      commit: e88b5cc6d6e5b1ba257f00e5c186ba137e6e8bc3
