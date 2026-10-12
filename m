Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C42CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9847810F180;
	Mon, 12 Oct 2026 14:41:15 +0000 (UTC)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA3310F186
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:41:08 +0000 (UTC)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-677af43eed4so1544387d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791816067; cv=none;
 d=google.com; s=arc-20260327;
 b=mpstTlRHPHQQ5jsyM+vXXEBS61cYGiYxVLBBXGWri6X63EviFHdJSGmVg6u0oDN9Kz
 ErmDYPpeXl/IVG+4C1MmnP3J4RLnIana1RhHbgcAeIbDptBF3W8C/vrhGfCetlPfwI+H
 wI1wgcLTQhpeSE+5wQTh2+o0ytih/gSAwuPtju22jmptYWloopNqbDYXpB0SETY8oSlI
 Mx5oOz9Aa5PCYuBgCwXZoxA/2imlrOf8ipcjPVCC2VLMgc4iBmG2iFl9uUgyRu32gN3z
 rNi0a8PtSTmwueVcAJD/LGMZzhP8OxYq3VoV+JKlT8RDrb2FKnHknNKi6s70P2til2QK
 dCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hVt+2VZkW4XSaJKirxsUTpM7f+JQAOjlXtbg/RMP49g=;
 fh=DI3blECntUcDHQbGypjXN87m1A1k928khvGPx1zrNLY=;
 b=Sfy5TZRWKbuGgou5pR6UZoPsfr21eD9aIgQ1pD/ueZJ4xzjfrM1/OSpQMSa6vgZBol
 HBxSD+0aJ02I1pu1cSEnsvbLTM5xjMPlF3sk9B1HMHF//81VuweOrgMlLfC5vWUzSI+9
 5SeJ06x0CbIejVvzIcziVP9U/+0uHLPRO9berDdqUO3O9XnFjp9pb/i5+Qe8bOfAFaY/
 K9ybGhhQNE5Ap/YDUOhjOnxTlEo7h453mBCmXMI3Ku27+z+rZ/2bKH+mwQOuv7HbKwOS
 R13ny9bb7kX3FuF1/BIouMAl8ZdmysujbEYyrZJ3KUbHSEgeSMDyxEG9/xS9YiEvQO4J
 UvAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791816067; x=1792420867; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hVt+2VZkW4XSaJKirxsUTpM7f+JQAOjlXtbg/RMP49g=;
 b=QoaodpheO0c9qLCD3F1ccuBJHiU6M4LY8JSpIi90L+uVGAIQIaRsTy9eA2lcq7TZ0j
 2oJfVArC752z4id68bbL9+5ic/AcvkULBwV8Sz99WI4mXoA25zI0uXXY+rpg47L+4Sk1
 eRQXLVfHtEklShH9wxfdNgUPWzdrtUurQGN8alBNr4KGG+TaLz09wTlZIJCiDPO8KsjG
 5be6iZHDBWO4ve7+PEuXpNAKto2U5OGmvccnowo/EZ25UWVBoGSEfksh1LF6Yb28cHu/
 t/1t1/lSsQb/qWoLm89VUKzR0+GewnBc5Y1Z0Li9AK8bSh0Zl1IQOKuwwbMhNtcJjSQX
 vp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791816067; x=1792420867;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hVt+2VZkW4XSaJKirxsUTpM7f+JQAOjlXtbg/RMP49g=;
 b=qkP2bPqObkGVBu+WycONR9vCtdFFaP3zBe5SjEV8/3VyQCU3KUCYr5q94YFApVi/HP
 DEahZm6wVlAAbu+ac4246Zhq5jROcRt6TJrQV6FzXQJpGmlZVDtifAegiLdv7RG0BhoC
 JD7WcZq8zgdxM27Je6zTZhbNZ4jgjpSpVssJynd0XIOZSteXA5coWwjnPGikY2w9zkxZ
 fXVnkhr9nyHemNvUoIKjXDGizjqKdGBUZpcD/gjuK437gv3JcK22YReSGPPR4jYV5iUO
 wLsVPFWmSt0FNEC+3HZc7TUeRTmyM/v3b2qN0GT4hpm9XUWqXrdzA9xw7ScvvENkgkJI
 5pTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcACVacnwky38RZBmUoDBupbUUQoPiWOubQfYLOgD9sE92U0xvziQ/dqEsOgDLnIPllud8FgcxjFA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI08xNPYxR3GlpBdECmAnDdrk03jhPQdgqCjcT4g08PGB0G6mfT
 2xGnXzVYAOgFDFv5bxZV3TBzxIkACRQB5LqXD5gzMWwl0CKAEAmeqFxWGC1yKLrWkVVhvRqdEDk
 b44ueqd+f6UYsiKE2VZUUecqof8tFX1vX4TLef2EoUg==
X-Gm-Gg: AYBFou3cqMhwcPDst9hU+/2PlTo4nAkF91AvLHgxwa7FxWGT83Y7raRvesy90zifRCG
 DpG3GFf7Pn36BXSShs/BcABGgkFkwI75kXk94bMOQPFyWJBLfiyWs0rv4AZmUgSV/Llv9I67CLG
 3xulmM6h5mVBEg5jqsTe2Ft28ejSWJf0/aKHg3c9A++/vi12jNOef7NWJaBamfItOsWuZ4o4a03
 RX61iqxG7es9o4EglUfSJB22LKZa8ysnyzTIpLWtPPV9wz1qTPKAEjPEj8vZhDKa3TfU6dHEZ7u
 5AK1zxD5ut163cgRW7ulXSWjpbrW0ueHaVUQ3WygcisbiMpXaHDBDdyUzdMu66Sz
X-Received: by 2002:a05:690e:1907:b0:66f:b528:cc51 with SMTP id
 956f58d0204a3-6793698594fmr4322156d50.21.1791816067411; Mon, 12 Oct 2026
 07:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-6-c042266b9eeb@linaro.org>
 <CAD++jLm2dVVKM075MDoStTudO+2hdECS-XucFiMGnM1H-Xk=TA@mail.gmail.com>
 <CABymUCN1oxuqPi=s1cpBHvMJorHN62uieD8Pf=Y--WBPp-=NHA@mail.gmail.com>
 <CAD++jLnkr+M9Tn_zAL8+owO7H706XYSMosSz-1D20rwbUukQ3A@mail.gmail.com>
In-Reply-To: <CAD++jLnkr+M9Tn_zAL8+owO7H706XYSMosSz-1D20rwbUukQ3A@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 12 Oct 2026 22:40:56 +0800
X-Gm-Features: AclHuK8DXIfIQSpEn-02OXtKO750H1QIkJhmjnTnvXTflrGk6XkO0SctyamV-mw
Message-ID: <CABymUCNzxWhud1qtv3os=f2txZ=nrTdMrQ6BOYkbfK87D=AnHQ@mail.gmail.com>
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

Linus Walleij <linusw@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=881=E6=97=
=A5=E5=91=A8=E5=9B=9B 03:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 30, 2026 at 6:31=E2=80=AFPM Jun Nie <jun.nie@linaro.org> wrot=
e:
> > > On Mon, Jul 27, 2026 at 10:09=E2=80=AFAM Jun Nie <jun.nie@linaro.org>=
 wrote:
>
> > > If you have a datasheet for this display controller, then please add =
some
> > > one-line comments before each command to explain what is being set
> > > up.
> >
> > I hope I had datasheet, but the answer is no. All I have is an init seq=
uence
> > with the information in the above macro definition. Let just live with =
it @_@
>
> I would send the message "upward" that you need a proper datasheet
> for this, from whoever wants this to happen.
>
> I have seen from the presentation that you will be working on
> compensation for chromatic aberration for this device, and that is only
> going to have a point if the color representation on the display can be
> trusted to begin with. Which means
> gamma correction. (Which we don't yet support in the panels,
> but hey, another opportunity to be first!)
>
> Gamma is invariably going to be one of these
> "magic commands", at that point of depth you really need the manual
> to see what is going on.
>
> Yours,
> Linus Walleij

Compensation for chromatic aberration can be done either on the GPU,
or display controller, or by panel. As long as the R/G/B channel
can be processed individually, that's enough for the aberration. I will
work on the solution with processing inside the display controller. So ther=
e
is no dependency on this specific panel.

Jun
