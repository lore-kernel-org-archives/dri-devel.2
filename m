Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32115C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 05:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0814710E25E;
	Sat,  5 Sep 2026 05:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JgdKSC/l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9752910E25E
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 05:54:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2923743AEC
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 05:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FA61F00ADB
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 05:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788587673;
 bh=jxqzcQeIGie1cb4FNpKSX3iCMnz8YLMB5HRJHa4aZCY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=JgdKSC/lR2PRdX3UXHO35FTQ6X9M2TgcSJgFRwEnqC/MV/QHmbgIfRvTXTYCdjBoP
 +J5PtLTlHMfbQ3r3oqgU1Pj9XhSox6p8LoZg1jYBzwEohpE2xUpcFV7iuuRymRjCco
 xXPxtJkxmB3H+MTtG5d35TSiMSc8OlA0FxeeCrM/jpAa2u/mIU92bqN0e377GFuiVM
 lGOBvQ4DqklWMUINEifbFwrTzuIRopb2JPRU0Qjx9DOgOBpiXlLAmmOcA2St60ND2/
 icXAvbBzC/NNFIwHd8AAy5tMukMm+d2g31RYMskCX4SoQlSvVWKU2vsKcGtunqSCue
 Xd5hRGcSeBcMg==
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5b0115b9e17so1477707e87.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 22:54:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBx1y+3tFunodaB0KFApZlyMQs3hXFoPeB1/RAgZzcnZQxI4Ipp0xf6BswTG7alD4BeEplbOtMHdLNY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lVHEiAXgy168TIGyMuMzcPPFVz6SbYdBoWZxIfJ+kus3Yn8cAy
 qmTV4mYkX9YblvtdxK0XYTh5bf1mj3/T0HzMRDj3RsrOBhQl0Xpv5d4H1QTHvCmEgkrsiCKHhAW
 tUQ9CXX10pwdQ2nj6gXX0UfP7zhkTrNQ=
X-Received: by 2002:a05:6512:1285:b0:5b6:4b1:f8bd with SMTP id
 2adb3069b0e04-5b616f5b5cbmr1782508e87.30.1788587671407; Fri, 04 Sep 2026
 22:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20251222-drm-panels-sony-v2-0-82a87465d163@somainline.org>
 <CAD++jL=A5QWEfNXnmpKFMju8X1BQ8CsxMuqhia7mfMFbUaFfHg@mail.gmail.com>
 <aprT7A2w0TWrfcdn@SoMainline.org>
In-Reply-To: <aprT7A2w0TWrfcdn@SoMainline.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 07:54:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLmRi+f3BGGxXzkP1ubaP2J8Qfy-v0HAmQqzN1x=e6d3bw@mail.gmail.com>
X-Gm-Features: AcwNN1XAvRFezIXLk1kako-OF71HLCqFCnufftCArrQ1b1-qMTvV5mxqn8Q5HwI
Message-ID: <CAD++jLmRi+f3BGGxXzkP1ubaP2J8Qfy-v0HAmQqzN1x=e6d3bw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] drm/panel: Add 5 DDIC panel drivers for 14 Sony
 phones
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 Casey Connolly <casey.connolly@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Martin Botka <martin.botka@somainline.org>,
 Jami Kettunen <jami.kettunen@somainline.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>
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

On Fri, Sep 4, 2026 at 4:34=E2=80=AFPM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
> On 2026-09-03 00:22:41, Linus Walleij wrote:

> > > This is the second version of a largely reshaped series that brings 5
> > > new DDIC panel drivers (4 Samsung, 1 LGD) that are compatible with 14
> > > Sony phones:
> >
> > What's up with this series?
>
> This is repeatedly blocked on the request to factor out a generic Samsung=
 panel
> library.

OK so that's on me.

I don't want to hold back this important series over that, just go ahead
and rebase this on v7.3-rc1 and resend it and I will merge them.

Meanwhile, I shut up and code:
https://lore.kernel.org/dri-devel/20260903-drm-panels-sofef0-v1-0-9e841645b=
eba@kernel.org/

If you want to use these helpers, I can simply merge the patches because
there is an ACK. But it'd be great if you could take a look as well, sorry
for missing to add you on CC.

> And there have been many small comments left and right - including my own
> observations and self-review - that all need to get addressed.  Not a lot=
 of
> work, but they add up and it's easy enough to miss something which will m=
ake a
> reviewer "unhappy" ;)

Perfect is the enemy of good.

I often hold the stance that we should fix up minor nits in-tree rather
than at first merge.

Yours,
Linus Walleij
