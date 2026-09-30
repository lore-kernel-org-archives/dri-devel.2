Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D704CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A964C10E3F6;
	Wed, 30 Sep 2026 16:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="knn0W9yP";
	dkim-atps=neutral
Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com
 [74.125.224.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F59D10E3CC
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:31:49 +0000 (UTC)
Received: by mail-yx2-f43.google.com with SMTP id
 956f58d0204a3-66e4ab201ecso5242198d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790785908; cv=none;
 d=google.com; s=arc-20260327;
 b=rvW8c4H3uVyYG/TfT3Uv1H2ZI7QcRX7Bv+tZVeV0FyZI/sspPPBbRVGDrxYQblTP61
 2ItfzinwUNmOvnw35LQNl5xry4nLNytWjGhIMj7OQvDQZbVu0xVkk65F6RMRfSISgN9X
 s5vesolDr2Wk6PZdJAk/ijCBqlIc9Gbf2u0/50L7QQwh4AIJ4A0a7mcEGrF7xpKk1Ing
 84ue91mgu2NM2L9PK8anWFfXsJrY8O3WV7gv9d2lFqOr3VL03IwJZ2btFxWuHVV3Ijqn
 Q1Peb5q8BzZL6k0fEruvTH/X5LmGDIQwXFjF9PBzk/A1R+JUoNeMlSDo+U+uGxpzo0Vo
 vK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kBFSz8Hg+47uuDgA4INkTekVz9fv548HRY4ltJTPkUw=;
 fh=8Z/7fvNkZeR0hzrHbs0XJLKLDVmmxzS3tBp7klmjDXI=;
 b=rPckSEjaiB0QIK73vCZyI0wxcZuvHpDZ9z275em0TmQC9v+lhFsnWbUt7vWTInYzbI
 /mBqAh4LJsj2JfRN8dasN6GJsTMb6CxuM1LBj1w2K5ZacQUgVdYONmIDPr7JyWIDtGBJ
 azaTRJiheStG5k2wyAqQfON1FCmfcTfwg977e3KVgz4AXcnRMRZT0ycYxixYb6NcMd+H
 l4W5cKVdSe5HK13p8uwCIGV/1Jd5Z9Gj+POsY0zeMbBTAn5zS6U4fbXsNJRCXJllESZq
 HbpTPlnGQTprxE05AmtWZcBxAegQr21BlJ0vvuIhHWPb/tdT13TLvkhCyZoDWkv3i1WR
 jLZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790785908; x=1791390708; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kBFSz8Hg+47uuDgA4INkTekVz9fv548HRY4ltJTPkUw=;
 b=knn0W9yPiEWvjGihoTW9X+FvlUb6rzigJfLpS01CIbXdU3uWawsQH/tCL+aCCu6LUy
 Cbg+pAAP4A9K9u9ES/uln5autcMpfqwK/0Qwn/GjKM6lsj0cjzKX6pUUUrZCmg6IY2Gr
 BQLbNYj67eO7QzztaGxhktbsWJ16Rhv8UA3AEoBEzM6hJWhh5o+M4Lc7I/d8VkrzyZSR
 ZG7kduSTVGPakav+EUTleV0PRRq5Q6HjwG8Ir3f+0vwdUKMwM34h5f4oLdU73RRUpXh6
 /dti/3tYgv4nBMyc9qwFP+hH5WmY78/pgNlv1Dq3nXtpwKCTOaqjmUnQV7FoMYA5UxP1
 Mhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790785908; x=1791390708;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kBFSz8Hg+47uuDgA4INkTekVz9fv548HRY4ltJTPkUw=;
 b=zE5QKQRXRNpOMby7pUoVmo751Hm7aJNFXZ88DttZSeNQqSq908fUN3tNV3E+HlHE+f
 oIQ/55CfyTCILfjEbPZRmDRJ/Kk/q4v0et23yl5zd/MNtgVoxmJUNbhPRVhP8XTIoqvD
 TpAyLWMKBvfWC63vQskXYWp0ySYSFDAV+SZJk6oBxYEXroXORQ63Q/P52hnSgjTt4cZm
 E9OvmoH4J79ZmJ3J3PiGA7BlgvYV4+Pqyn14F0crhV0NB8ypairTmp3eNzFWsG8FmMAh
 8rWuyF0VVkNdYiOIq4f5cGMv/bFI+SzuZntYIgOvXRvJBlhVOd0rJMnVvA9OYlhvAiYk
 guVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCunow3F++IYqJ6NY8a9f+VojlMS+zgoKcFnU9rzpseFTXPLZWnZO2XTgrNVvFmjEaxahkq3EAuWs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJjDBoIzoAKyVjf1ibID24asVqYnS/uUjL9jEiC3KH5aYqfrfSd
 z/GzmPFIyi+L1GlBP4bD+uYvkD9/rZlmvGRQuuoKpEU7xuLBlQxg/qHWkoEH/T+VFNdUkiWmWr/
 noqpEKVMCFnnm6wO9kRVINzH7gK+wF+oB8mmdNe3jEQ==
X-Gm-Gg: AYBFou0KREignpJHruOX5KOa4EzwFLmQNtY+aOlAl/iMU6BNXJjZjB0ddGX1cud4DSR
 dH4s43dTMc1Ljr5l+x9PuluFlNn1ecWDwZu4OW2aJqv0v4iWLVzBN4BYRcLf8WlHV4xJpuKbo4Q
 zXqZhpe37MZHyOcf2wE6+Jcg8EHoARHyWQbDyFjkqexVY0LCSFE3U+M2dsCnFQ9Mr/Q3USWHNMe
 UyRKuNHosvJ3G6VfH3khzcuQ97ZhfFZOvJCZ4Hq5V6bVi5AZfu5l/xOpa2XP1xWqTnWPmAv/RIs
 6KiEWTav8k4f1WAuh/uEEF7paNRRw22yrtY/GX3pepPXZ/EoxFnTDHBBFiY8eBG4
X-Received: by 2002:a05:690e:408b:b0:672:99e1:11e7 with SMTP id
 956f58d0204a3-676834ee0a2mr951729d50.132.1790785908030; Wed, 30 Sep 2026
 09:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-6-c042266b9eeb@linaro.org>
 <CAD++jLm2dVVKM075MDoStTudO+2hdECS-XucFiMGnM1H-Xk=TA@mail.gmail.com>
In-Reply-To: <CAD++jLm2dVVKM075MDoStTudO+2hdECS-XucFiMGnM1H-Xk=TA@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 1 Oct 2026 00:31:37 +0800
X-Gm-Features: AclHuK-Ut7huYikkw-ut_7tEiGgl7jCeAuf3fgmv1fyl04iaoD4uVhF3GKH3maM
Message-ID: <CABymUCN1oxuqPi=s1cpBHvMJorHN62uieD8Pf=Y--WBPp-=NHA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drm/panel: Add driver for Synaptics R63455 DSI
 panel
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

Linus Walleij <linusw@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8829=E6=97=
=A5=E5=91=A8=E4=BA=8C 21:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Jun,
>
> thanks for your patch!
>
> On Mon, Jul 27, 2026 at 10:09=E2=80=AFAM Jun Nie <jun.nie@linaro.org> wro=
te:
>
> > +#define R63455_MF_CMD_ACCESS_PROTECT   0xb0
> > +#define R63455_SEQ_CTL                 0xd6
> > +#define R63455_DSI_CTL                 0xb6
> > +#define R63455_DISP_MODE               0xb7
> > +#define R63455_GEN_OUTPIN_SET          0xb9
> > +#define R63455_DISP_SET1               0xc0
> > +#define R63455_DISP_SET2               0xf1
> > +#define R63455_DISP_SET3               0xc6
> > +#define R63455_DISP_SET3_2             0xcd
> > +#define R63455_DISP_SET4               0xcf
> > +#define R63455_DISP_SET5               0xec
> > +#define R63455_DISP_SET6               0xef
> > +#define R63455_TE_GPIO_CTL             0xbe
> > +#define R63455_PPS_SET                 0xe6
>
> This is more details than we usually get, which is nice.
>
> > +       r63455_dsi_write_seq(ctx, dsi_ctx, R63455_MF_CMD_ACCESS_PROTECT=
, 0x00);
> > +       r63455_dsi_write_seq(ctx, dsi_ctx, R63455_SEQ_CTL, 0x00);
> > +       r63455_dsi_write_seq(ctx, dsi_ctx,
> > +                            R63455_DSI_CTL,
> > +                            0x20, 0x6b, 0x80, 0x06, 0x33, 0x9a, 0x00, =
0x1a,
> > +                            0x7a);
> > +       r63455_dsi_write_seq(ctx, dsi_ctx, R63455_DISP_MODE,
> > +                            0x54, 0x00, 0x00, 0x00);
> > +       r63455_dsi_write_seq(ctx, dsi_ctx, R63455_GEN_OUTPIN_SET,
> > +                            0xf, 0xe4, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00,
> > +                            0xf, 0xb2, 0x00, 0x64);
> > +       r63455_dsi_write_seq(ctx, dsi_ctx, R63455_DISP_SET3,
> > +                            0x08, 0x70, 0x28, 0x48, 0x00, 0x00, 0x13, =
0x21,
> > +                            0xff, 0x00, 0x0f, 0x01, 0x14, 0x17, 0x00, =
0x00,
> > +                            0x00, 0x02, 0x40, 0x0C, 0x00, 0x00, 0x00, =
0x20,
> > +                            0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x70, =
0x08,
> > +                            0xD0, 0x02, 0x21, 0x6F, 0x08, 0x5A, 0x00, =
0x00,
> > +                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, =
0x00,
> > +                            0x00, 0x00, 0x00, 0x00, 0x00);
> > +       r63455_dsi_write_seq(ctx, dsi_ctx, R63455_DISP_SET1,
> > +                            RTN, 0x86, LE16_BYTE0(VBP), LE16_BYTE1(VBP=
), 0x08,
> > +                            0x70, BE16_BYTE0(VFP), BE16_BYTE1(VFP), 0x=
00,
> > +                            0x00, 0x08, 0x3B, 0x00, 0x00, 0x19, 0x01, =
0x22);
> > +       r63455_dsi_write_seq(ctx, dsi_ctx, R63455_DISP_SET3_2, 0x00);
> > +       r63455_dsi_write_seq(ctx, dsi_ctx, R63455_DISP_SET4,
> > +                            0x8b, 0x00, 0x80, 0x46, 0x61, 0x00, 0x8b);
> > +       r63455_dsi_write_seq(ctx, dsi_ctx, R63455_DISP_SET5,
> > +                            BE16_BYTE0(VID_VS_DELAY),
> > +                            BE16_BYTE1(VID_VS_DELAY),
> > +                            0x00, 0x00, 0x00);
> > +       r63455_dsi_write_seq(ctx, dsi_ctx, R63455_DISP_SET6,
> > +                            0x00, 0x24, 0x00, 0x00, 0x1f, 0x00, 0x00, =
0x00,
> > +                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, =
0x00,
> > +                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, =
0x00,
> > +                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, =
0x00,
> > +                            0x03, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, =
0x00,
> > +                            0x00, 0x00, 0x0A, 0x0A, 0x00, 0x00, 0x00, =
0x03,
> > +                            0x1D, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, =
0x00,
> > +                            0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, =
0x00,
> > +                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, =
0x00,
> > +                            0x00);
> > +       r63455_dsi_write_seq(ctx, dsi_ctx, R63455_TE_GPIO_CTL,
> > +                            0x00, 0x6A, 0x02);
>
> So for the commands above we have a little more knowledge than just
> opaque numbers about what the display controller is doing.
>
> If you have a datasheet for this display controller, then please add some
> one-line comments before each command to explain what is being set
> up.

I hope I had datasheet, but the answer is no. All I have is an init sequenc=
e
with the information in the above macro definition. Let just live with it @=
_@

>
> It still bugs me that we accept this much magic numbers in panel
> drivers but I guess I just take a deep breath and live with it.
>
> Yours,
> Linus Walleij
