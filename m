Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2887CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E7910E0F0;
	Wed, 30 Sep 2026 19:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dxagNlyy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC07E10E311
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:49:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89C7C440B7
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718071F000FF
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790797745;
 bh=KBjoGURW6Lp0xuEIrYUnIleO+gefEsMNlz5gVLaCbrA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=dxagNlyy5eOr8Y1m7m/XmQK9pXVnqB8ZIFTzMKunnFGyyZYj4FL+8eSCkFyFXHQuN
 QENr9Q1J+n3MUzDaTqJm7qjNeOHORQ/stL8Vz//Rg8n16W9BuFOPMg0wuRV+RLiAN9
 mn7SO9OHYIFNbVBIhv/niKGcaa9ZRB8+iuX2cOQSCamPudNHID/gfZJ02O6MfdAVAA
 w3sYXzHfPj6gEwS6d3wrcPifWe4i7BUfI4IPXuSBemTYWnzjLBiHvcMymOn3zL4ldO
 XfTwobEYq7WqTIN1SKivo2X/kAs4L6+MZcZ8/XcCok4Ue2QFjuEbb/qQFT04NoEKR3
 ZEWW6CPaHEDAA==
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b8eacb7c8fso5096904e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:49:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBx/afwY06R1wa9Lf58fb2Wx92gpnpQCGf6+JBpMyZSd16L/+awwcO27fld6tIX+Z96fwwOFRO6e+84=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJQywHh02djqSKQurNfp8G1w4MH1pLIjrhULmzdT1U4HSybGIBl
 Uo0mPJ0dKc68CBn0Xm/de4O+MWopaZp70MELaghC7pkCGF0/RiDx9ImpYFzNX2ODOJlPpxYHeT2
 2m3SaZSgABEEJVjgDWeU+mM388aGaF1M=
X-Received: by 2002:a05:6512:33d3:b0:5b8:d8ec:bee5 with SMTP id
 2adb3069b0e04-5ba405ea03emr1058463e87.24.1790797744086; Wed, 30 Sep 2026
 12:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-6-c042266b9eeb@linaro.org>
 <CAD++jLm2dVVKM075MDoStTudO+2hdECS-XucFiMGnM1H-Xk=TA@mail.gmail.com>
 <CABymUCN1oxuqPi=s1cpBHvMJorHN62uieD8Pf=Y--WBPp-=NHA@mail.gmail.com>
In-Reply-To: <CABymUCN1oxuqPi=s1cpBHvMJorHN62uieD8Pf=Y--WBPp-=NHA@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 21:48:51 +0200
X-Gmail-Original-Message-ID: <CAD++jLnkr+M9Tn_zAL8+owO7H706XYSMosSz-1D20rwbUukQ3A@mail.gmail.com>
X-Gm-Features: AclHuK8lnxj_P_eEplQvchjcjf4j1lYtGX2m3t6HeEPZ8smFgSi0dE0qiPGPASE
Message-ID: <CAD++jLnkr+M9Tn_zAL8+owO7H706XYSMosSz-1D20rwbUukQ3A@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drm/panel: Add driver for Synaptics R63455 DSI
 panel
To: Jun Nie <jun.nie@linaro.org>
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

On Wed, Sep 30, 2026 at 6:31=E2=80=AFPM Jun Nie <jun.nie@linaro.org> wrote:
> > On Mon, Jul 27, 2026 at 10:09=E2=80=AFAM Jun Nie <jun.nie@linaro.org> w=
rote:

> > If you have a datasheet for this display controller, then please add so=
me
> > one-line comments before each command to explain what is being set
> > up.
>
> I hope I had datasheet, but the answer is no. All I have is an init seque=
nce
> with the information in the above macro definition. Let just live with it=
 @_@

I would send the message "upward" that you need a proper datasheet
for this, from whoever wants this to happen.

I have seen from the presentation that you will be working on
compensation for chromatic aberration for this device, and that is only
going to have a point if the color representation on the display can be
trusted to begin with. Which means
gamma correction. (Which we don't yet support in the panels,
but hey, another opportunity to be first!)

Gamma is invariably going to be one of these
"magic commands", at that point of depth you really need the manual
to see what is going on.

Yours,
Linus Walleij
