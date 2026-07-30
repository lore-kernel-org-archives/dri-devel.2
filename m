Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D80C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530F210EB85;
	Thu, 30 Jul 2026 01:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B2d5yfOY";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B77910EB85
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:39:32 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-93108a3c326so19002285a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785375571; x=1785980371;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bOAT49hjvBzCOPWhaRfDWtDf31fYaWLBSB9ycAdDcwo=;
 b=B2d5yfOY6XmQLcChOg4wL2NFjTuSqjTVNlLcpkuCsGA1KBplR5QmEqjW36qG6vMq3n
 l2Z6mYK2Lhfz+2mDFSDIVWCZUSC0hucyqftckY93nIAfXIFwjiATGNkVziX/UO87yvva
 LMM8uuu6fr1MKD+Uq9lvc9TiZHpehbFy+HYF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785375571; x=1785980371;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bOAT49hjvBzCOPWhaRfDWtDf31fYaWLBSB9ycAdDcwo=;
 b=bs3Pj6R53r1qU+LEHh32IM21jwZSUiejdNMKitipY7YdNm226MC3EvQuJadMQxQP88
 SmjxgbLIeYWKCVCqJQ/UaufHfFwQFdkw/IWyRextvmu2vmXy/ACeghfaOrHj58YBl4VA
 uXAgtEA7LGEandTFBECi3FLj2KTO8B+bPsiYFxQvQwTzibqVLqvqgEVXsGHtHE90B3Og
 VpK7O6Pu9pOw8cF8ewawhS5W0ZY5Nq6XLtJNrS3QXY4FVKW52dAcjQ8ysBit+Y8++0Pq
 ItrXFEU0xQK+gxGz3cYd3NozNCcHJg2VNsqj6N0/bZi3/a/meqJvjaIhDjMRuaZII9fu
 UZkA==
X-Gm-Message-State: AOJu0YxU6LexRwrq3FNLV5MewYulItJcKsUd/831JhIsQK2uaj1rbJxu
 Tk/RA/TbKCnU6mpFeWuTT1pXzYhucOvy1AJawoYMgoVbooSsCC8oPwSP9zRT3KTNi0kTiPQJ+6m
 9n/M=
X-Gm-Gg: AR+sD10SkDZGawkKahS+snm5eA6kbxhgr2e+Had5KJCzUKNxXQ6EgGn5fDs4gr14PZw
 wIsXFxQVvgOrIB39kc2OLrTPfH4AWZRjwWzhXqOeK7+UEyOATUdJTZm8NaqF/Y1SOqLAZZih+JN
 nrY4v6P7hkZEAnjT/2hVFI3DfwdwRTmNvlQXN774Rv8sLMdeLixMwXSVUg79SFYhWIDjSKWMoFD
 jySLd5swks+Z0bblGa5z6JRK8RP3F2r52E21VWdfpZssY2ITTDsDUvZrf33DZh+79qrdcP95dcI
 x3Gwal0LlxuSCte9/79Stt/D/iqXN6t6+pFCTklM3jLNNocaWtQ3nmczZsEssNnv+DtUKjF1DIk
 FmPR5+q9mxY72uTMjCFvOhaGNucZgdQi3lCqlGjB4VR95LypoCXc6Grn3tJT8SBEoZTGp+lxagn
 FQJVDkDEd6SAZVbEjOlXTRPjaRHIgZgG32a1/5UH8fcvvVVa+x7SeijF3aXmpR8lv931tVQaVny
 6joxw8uC7oOrlV92jIyW+8P578=
X-Received: by 2002:a05:620a:4622:b0:930:d48:a3d2 with SMTP id
 af79cd13be357-93487d8ed3dmr28343885a.21.1785375571376; 
 Wed, 29 Jul 2026 18:39:31 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com.
 [209.85.219.47]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933e73696a8sm309020585a.46.2026.07.29.18.39.30
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 18:39:30 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-8ef1dc934d1so2081346d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:39:30 -0700 (PDT)
X-Received: by 2002:a05:6214:1cc7:b0:8e5:8d7b:5188 with SMTP id
 6a1803df08f44-90834fc5cb5mr3246786d6.9.1785375569291; Wed, 29 Jul 2026
 18:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <82fc6395-3425-4f71-ba58-813856cee61d@gmail.com>
In-Reply-To: <82fc6395-3425-4f71-ba58-813856cee61d@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 29 Jul 2026 18:39:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wh+Mf4jxQ2VdcTcr-D27QrJcQG3XP6MuCJZdRAmSZ1ow@mail.gmail.com>
X-Gm-Features: AUfX_mw8HqmcrW2QIQJzG4kshwpLty9evb5-KkiUFHq93NSsM0u5D-yCo_zYPfw
Message-ID: <CAD=FV=Wh+Mf4jxQ2VdcTcr-D27QrJcQG3XP6MuCJZdRAmSZ1ow@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add BOE NE140QDM-NX2
To: Weiji Wang <nebclllo0444@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Mon, Jul 27, 2026 at 12:58=E2=80=AFPM Weiji Wang <nebclllo0444@gmail.com=
> wrote:
>
> Add timing from datasheet for BOE NE140QDM-NX2.
>
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 09 e5 f2 0a 00 00 00 00
> 20 1f 01 04 a5 1e 13 78 03 ee 96 a3 54 4c 99 26
> 0f 4e 51 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 60 d2 00 a0 a0 40 32 60 30 20
> 35 00 2e bd 10 00 00 18 c8 9d 00 a0 a0 40 32 60
> 30 20 35 00 2e bd 10 00 00 18 00 00 00 fd 00 30
> 78 c6 c6 36 01 0a 20 20 20 20 20 20 00 00 00 fe
> 00 4e 45 31 34 30 51 44 4d 2d 4e 58 32 20 01 f8
>
> 70 13 79 00 00 03 01 14 30 69 00 05 ff 09 9f 00
> 2f 00 1f 00 3f 06 31 00 02 00 04 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 4d 90
>
> Signed-off-by: Weiji Wang <nebclllo0444@gmail.com>
> ---
> V1 -> V2: Changed entry sorting and shifted to 'delay_200_500_e50_p2e80'
>
> v1:
> https://lore.kernel.org/dri-devel/697e79c2-98a9-4bb3-b5fb-db327cbe1bce@gm=
ail.com/
>
>   drivers/gpu/drm/panel/panel-edp.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c
> b/drivers/gpu/drm/panel/panel-edp.c
> index 14dd40afa899..c6cdcd12002e 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2036,6 +2036,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a84, &delay_200_500_e50,
> "NV133WUM-T01"),
>       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50,
> "NV116WHM-N4C"),
>       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ae8, &delay_200_500_e50_p2e80,
> "NV140WUM-N41"),
> +    EDP_PANEL_ENTRY('B', 'O', 'E', 0x0af2, &delay_200_500_e50_p2e80,
> "NE140QDM-NX2"),

git is telling me that your patch is malformed. I guess somehow your
mailing client word-wrapped it? ...and it seems to have converted your
tabs to spaces. You probably need to adjust your setup.

Since it's a one-line patch, I managed to whip it into shape and I've
applied it, but you'll definitely have to fix that up for any other
patches you send out.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add BOE NE140QDM-NX2
      commit: 354b9c43d36ce9b41e48b2d67c5d9b953a0e9d64
