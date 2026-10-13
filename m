Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082B6CC6B15
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 23:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ABFE10F533;
	Tue, 13 Oct 2026 23:13:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7991E10F533
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 23:13:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 61FF2444F5
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 23:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A191F0089B
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 23:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791933227;
 bh=8vYqCm7KC7EITyBWnZgA8g6ZC83e12z/29ej2dElvqw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=YG/yibQvJjxNbB5ctvKfgTq/R7zuHrA1Hh1+J0egqCWrVJ1X+Go48DuAqMiTpAH5/
 Q3Q58Eyo3nbvoRanaUSVGtKuIzpm8GuADZ79jC8jBHwmVD35u6ayqN5fyq97UyBS3Y
 VIzOzsFY5TS09NNobgTekEln3lGqP3JYlOyA8h1KvMEDi8OPRtnFNu0nKmRmawcrnD
 Mgi7NbiqV4HVC1egGpC6bxSyBLIMBiKylhOqPdfL7S5aTdKQGOqJiIb61c/tVRxaFf
 dA09dgVpCIOdYsx7rfuuacB3coAHOIWzARNabgEUGKudsEdfPxrhKdkeJhJOedxERh
 Ur5Xm+CAbIc8A==
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-3a9787a14ecso2927941fa.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 16:13:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwjbkqVmuZ7+fJl/zfgGQZFfWfGo0RFMv5MLcer3RjhF3L7e8bEplSLP7Qn7m2hdWqrIo82KXm9Yyw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK3/9Pxjd6NaQImZFwzp9ZkvM0ZbLoXXE3KbRxHGEqYLj90vnNw
 fddAZMOH7/PQW8ixwKm5C12fvJzcAoZcH8bxsJhwxh5UJeduZhmF7yLbt153faC6D8Okx6b/M/0
 K5cyfrB1pJyvy+nDDo7j8eE84ar+Q2oM=
X-Received: by 2002:a2e:a991:0:b0:3a9:76b7:c515 with SMTP id
 38308e7fff4ca-3a9c5253a1bmr30955151fa.8.1791933225889; Tue, 13 Oct 2026
 16:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-6-c042266b9eeb@linaro.org>
 <CAD++jLm2dVVKM075MDoStTudO+2hdECS-XucFiMGnM1H-Xk=TA@mail.gmail.com>
 <CABymUCN1oxuqPi=s1cpBHvMJorHN62uieD8Pf=Y--WBPp-=NHA@mail.gmail.com>
 <CAD++jLnkr+M9Tn_zAL8+owO7H706XYSMosSz-1D20rwbUukQ3A@mail.gmail.com>
 <CABymUCNzxWhud1qtv3os=f2txZ=nrTdMrQ6BOYkbfK87D=AnHQ@mail.gmail.com>
In-Reply-To: <CABymUCNzxWhud1qtv3os=f2txZ=nrTdMrQ6BOYkbfK87D=AnHQ@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 14 Oct 2026 01:13:33 +0200
X-Gmail-Original-Message-ID: <CAD++jLmTexHgKOJV5DafVDsZoA1wqWgEgqJffYvkuZiyBt73HA@mail.gmail.com>
X-Gm-Features: AclHuK_LQ7qdt0SsmTQO1sCjo0vhFcFDmOgCJe5wkiAhYi6eBoW9zOsBp_zlskg
Message-ID: <CAD++jLmTexHgKOJV5DafVDsZoA1wqWgEgqJffYvkuZiyBt73HA@mail.gmail.com>
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

On Mon, Oct 12, 2026 at 4:41=E2=80=AFPM Jun Nie <jun.nie@linaro.org> wrote:

> Compensation for chromatic aberration can be done either on the GPU,
> or display controller, or by panel. As long as the R/G/B channel
> can be processed individually, that's enough for the aberration. I will
> work on the solution with processing inside the display controller. So th=
ere
> is no dependency on this specific panel.

Surely that usecase will still require full control of the display
pipeline, a bunch of magic register writes at the end of the
pipeline with a comment /* this is where the magic happens */
isn't going to give a sense that things are under control.

Yours,
Linus Walleij
