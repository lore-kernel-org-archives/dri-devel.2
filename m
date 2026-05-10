Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB7FCD3447
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 00:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F36410E125;
	Sun, 10 May 2026 00:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WPUjhBxD";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE1DE10E125
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 00:13:36 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-bccb9dca1beso83123466b.1
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 17:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778372012; x=1778976812;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Y2OikZwvTXae6ifoGXbPdJ3I9QjWbZV4HrLUwu54wg=;
 b=WPUjhBxDzJxlAIpgM1zHx+eTzIODVoh1mVdvwFPGszuUwz6Qu8d6bTiYBw/+EJe0B2
 qDUFuClUL6S3qRNfJKx4DtOk8bF0OAUBOdyTB1aGzwamV0r3DluWMK11C9Ko4KM6W6UB
 dSmh4LNjg+eYf0To2AiSmtBzkT6lBIuhfuy5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778372012; x=1778976812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Y2OikZwvTXae6ifoGXbPdJ3I9QjWbZV4HrLUwu54wg=;
 b=WR/ZLhlD1Bc5BA6sH4k42NEw6pxpYY8nNEi1JGHACpThjDkl6sL2jrGGFyZ1jppPVv
 1KtYzblkwK1CXG9YTY/TFLwNDRT0FDdGZIHC9hTEA9STEv86dY2Lf6SUj2lBTBg0NMJ3
 f9YtlpvPkRPGftln/ckSjnxFQbix7qaJwtQRS4eEBUKIAjqGOxQCr4Zqf18qShmUxVKR
 dkAjY79WrLL1YiIGom46s9uqEAy9O8TBbYeWF/5eCIqzo6Tw3j1L7XZtczNzgevHZwCE
 //JE+GG3y9rzSrFl1r41i+oJjfRE7p5wI0fMuMdIMawZR5gEchxhemWNY2CE0aY71ka8
 JJcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RqDOnPRzZrnEPJi0jwb6v5dOdyTzkm8CUjEWHFJZDou8adfSOmc6DIZ6i7EtW3nPOyt42jvtYh80=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWZ/oIU3zLhubjcCw2qlu76lFxOIfx+JpPSgzHUQ9EDwjaDWfq
 g1Uoii8vHiqy8OsO9RShyaiKt23R6fMdz6e+AMtsTaIJ8g64q71HoinI5Bqyt6llKxPP7ZF0eSb
 0f59mLg==
X-Gm-Gg: Acq92OGQrD1Q2l37yMckrSUhe+rVhEIEHhcJAx1Qb7k4KfgneJFZkAhT1NZPL8BNURC
 ZgBVyg44qBmqUrD1BW5t+90heDIhCLwCUqyqb7MTb3uJuM4RkKtavn2QLLWkIPQ0yt6tJ3TLm6m
 QUK5apgWUUFpm9h9ak/F94YgcFdRQNA+xyzXay3bQIHgRzm8BXUKqEFNKu9inVICVm7KTeUA1Zo
 Cvxq0csax9uEWqAX5OA29oP+OfG7wD62Enl8SeuMK0/KjHu9a3Y4wlFay68mM8OFGwSvHrW24Xf
 HW0NkVXAz8aM+9RDQNZphd2rguqKvCoiBNIJuIvwTKU7Bam/sa1PicKhqcloVCMYVzi/sUhePDw
 aNf19moZ+Mu/rqhWbliABl2tzRXikGC1Nwi8fYhbe/X56Az3nbiWJaubDRcabplJeMR8ebIBsdK
 yHJf+pDBFZgGSzimr1AET3yxobPgvGcJVe0SMY5IAJO2AQAEiKgjnHJRKLUC5FZg==
X-Received: by 2002:a17:907:3f22:b0:bcd:c899:904e with SMTP id
 a640c23a62f3a-bcdc899a588mr51716466b.7.1778372011898; 
 Sat, 09 May 2026 17:13:31 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com.
 [209.85.221.45]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcdb5512676sm39550666b.29.2026.05.09.17.13.30
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 May 2026 17:13:31 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-44b052142e1so1734741f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 17:13:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8sF1KGPFgh5JuFgZm/UUM6U/buiWZA3cMMFdv0+MkJK4t1I4wN8Vwj7DeUu6sA6wJlaTki+GOXnrg=@lists.freedesktop.org
X-Received: by 2002:a05:6000:2886:b0:439:c299:4d8f with SMTP id
 ffacd0b85a97d-4568a941236mr5922534f8f.17.1778372009322; Sat, 09 May 2026
 17:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260506170607.10813-1-terry_hsiao@compal.corp-partner.google.com>
 <20260506170607.10813-3-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20260506170607.10813-3-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Sat, 9 May 2026 17:13:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XedZd9Y+hME1-z1vFhLB01v+2pHAhUiEzo==ucwx+8Lg@mail.gmail.com>
X-Gm-Features: AVHnY4KTZIGiYUPln5oDOcNKIPZvH87tt5e7yLw4OMt0Zf-mOZsHweKALsKqVV8
Message-ID: <CAD=FV=XedZd9Y+hME1-z1vFhLB01v+2pHAhUiEzo==ucwx+8Lg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] drm/panel-edp: Add BOE NT140WHM-N4T, BOE
 NT140WHM-T05, BOE NV140FHM-N40
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

On Wed, May 6, 2026 at 10:06=E2=80=AFAM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> @@ -2021,8 +2022,10 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV14=
0FHM-T09"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140=
FHM-N47"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b66, &delay_200_500_e80, "NE140=
WUM-N6G"),
> +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b85, &delay_200_500_e50, "NT140=
WHM-T05"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140=
FHM-N47"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c26, &delay_200_500_p2e200, "NV=
140WUM-T08"),
> +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c6f, &delay_200_500_e50, "NV140=
FHM-N40"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Unkn=
own"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT11=
6WHM-N44"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf2, &delay_200_500_e200, "NV15=
6FHM-N4S"),

I notice that the new panels you added all use "enable 50", but the
panels with nearby IDs tend to have longer delays. Are you sure 50 is
the correct value?

In any case, I'll apply this and if you re-check and find you need a
longer delay, please send a followup patch.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[2/4] drm/panel-edp: Add BOE NT140WHM-N4T, BOE NT140WHM-T05, BOE NV140FHM-N=
40
      commit: a58ff7da4835e76a5ffc078ecfd2773de90e5d8c
