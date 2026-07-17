Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649E1C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC71010E489;
	Fri, 17 Jul 2026 15:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KadJ4PEr";
	dkim-atps=neutral
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A463110E489
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 15:40:33 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-7383cdb7800so3179436137.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784302832; x=1784907632;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1LTRCgSFoxKqoO+f0vjNmVxCnjcCSEY4MiefjXT7rIM=;
 b=KadJ4PEr3fyCEoPpGNt8eD9mcNtTOqpUGPK4q/VUxIOr5SNxPnXnirYHxHo+Pty8Fr
 SULdH9c2Ib8utcA0olmDcVrFwO+STLl8R8WVn/a8EVwOsLMQdLyrZhy8+74Xmci5HM1W
 YJV7IV4PjdTK29UmfsHvVEJO4vZsoEGbBLp3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784302832; x=1784907632;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1LTRCgSFoxKqoO+f0vjNmVxCnjcCSEY4MiefjXT7rIM=;
 b=EkrhxA92NPKs0bH7CNDPgPh9APWqkc1oHQwSVTVJfeMU0bn+MFrQ8hZg9RoQhckCwg
 QdvAiG0XZHUxGpCmsW6+xmSDNqGP+OkcPFxEwEiLSocGa9/Ctx/AdWFFrskWQF8sOv+H
 M6xBbDP6n54zQ2MTNCV4DlZmqLPiMbM+ilm/Xmveh6U6tTf9MtmLct+yb8RaGzIpvaiX
 hA0EkrFlELPh9+lPFvhev0274pym/O26NBYxJzTIleQufgHT/Df34B2rY1TsLunW7oOH
 yG92UEhGgZWsa0irkSkwiTWrq3bV3R1riHRIN9bjsEgsIxqkLB3epAQje4FmN4gSgpia
 H+/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMh7jIlUFhTN0vVoucY8z99SEIDsyqXhsRb9RB/KM0Gf84jNM9SGY+tUustbH+ydaOGxkS46kELmM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyyxcndGTKbJzSS3zwvPP0dQ2FwQugdVmURwjgW/p1Gow3AGMw
 T8qXVLbfjK1+cyWb44ZnZlFpfu7jvCFU+Bkq8t8eZcbpU9+OFjXdcJEOvg2fXqgOC8UGv7tQez7
 RYP0=
X-Gm-Gg: AfdE7ckPSRRJWIDOvLEfbDMMFkRSnP1JKBfxmI/oLKsDiRMFlBhOe/J4P3lpcK1QU0+
 IEZWI4QnUIUM0YE2wDo7VM3k6oPWq1gD63PUgV2TwTHX4j2Qf3VHRSJCIIJz6jF7hRUtt/Nn7IX
 PZ5DLbuaJ8stCHbWV+LuJHKlKS98g0ANXyhx6uMB7dus+/ywSH0Atiw0/WObGqSSSUET4XEzT1l
 IqX64Os3rqoPVsLOuW9SyaMVgRPYMis0xgmIIIl30rBMnAhbKsQU1gDfUIgU5FkKPlHe+4Kpt5N
 OQOXBtJAsiVpfzwQPGXSlM9iNC0ZSFECXFMgt0xDNjH0dgP3XdldPJGgmg19VQYNztrhihq2wbs
 iw9HYstxRZGKyl4mMUxDAlIOBDag6tmfb76kXgKHQQ5wft5Tg46DNYfPPNmgZU6qCNPg7f7ax8q
 M1v8K5NCMaOtz5vV6JtSLTlOcQ5YUlhOcfcmMnvTMo
X-Received: by 2002:a05:6102:41ac:b0:739:77a7:90bc with SMTP id
 ada2fe7eead31-74753727549mr823191137.23.1784302832474; 
 Fri, 17 Jul 2026 08:40:32 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com.
 [209.85.222.50]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-747581e8f0esm684909137.10.2026.07.17.08.40.31
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 08:40:31 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-9725084c547so2544881241.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 08:40:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rpa82vPu1nrgLC5a2NYYydxeZl2IjNzzcaeTGEM/eTDEPxNGfw1plgYx3M4dsd9wHvHviU+yzE9b7s=@lists.freedesktop.org
X-Received: by 2002:a05:6102:5810:b0:737:5c42:858b with SMTP id
 ada2fe7eead31-747534cdf79mr792514137.11.1784302830399; Fri, 17 Jul 2026
 08:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-1-57c70c23d0d6@oss.qualcomm.com>
 <CAD=FV=UaPKiGSL6mhVdywp67skSr2B7977f3kZ23FFHaD=95RQ@mail.gmail.com>
 <20260605152825.GA3740391-robh@kernel.org>
 <CAD=FV=U7jz-xwA+-Fic2thZaK6eCDhc-PZ1fqpCMAUmy3V3Y+Q@mail.gmail.com>
 <CAL_JsqK6u=x=ScTnW1jJCPZpCUb3mT0NZpsKqe6PqZmrNEKZiQ@mail.gmail.com>
 <CAD=FV=XBn78eOC_zG0S2U-W3whrVYEpghKF_WgX+3zpUJ82-5g@mail.gmail.com>
 <6e7ae036-e63b-4f83-947c-992f3199dbab@oss.qualcomm.com>
In-Reply-To: <6e7ae036-e63b-4f83-947c-992f3199dbab@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 Jul 2026 08:40:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VSgE5z71HzZwCiVKhYjt2CPesPD_HNejFZg4xMpV1bTQ@mail.gmail.com>
X-Gm-Features: AUfX_mwKjGGKjxDAeqITUG5KUm08CfVu1NRr1wpnrdcgFny_h3p0H-VAhH4pTdQ
Message-ID: <CAD=FV=VSgE5z71HzZwCiVKhYjt2CPesPD_HNejFZg4xMpV1bTQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: samsung,
 atna33xc20: Add ATNA40HQ08-0
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
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

On Fri, Jul 17, 2026 at 6:06=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 6/6/26 12:41 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jun 5, 2026 at 10:14=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
>
> [...]
>
> >> Well yes, people have a hard time using compatible strings that don't
> >> sound generic. That's too bad for them.
> >
> > OK, so sounds like going forward I should NAK changes to this file and
> > tell people to just use:
> >
> > compatible =3D "samsung,atna33xc20";
> >
> > ...to mean "Generic Samsung AMOLED panel with power sequencing that
> > matches atna33xc20"
> >
> > Yes, it means that if we find quirks with a specific panel later, it
> > could possibly be harder to work around them. However, since we have
> > several ways to identify the panel (via EDID and via DDC) this seems
> > fairly low risk. You can't perfectly predict the future anyway.
>
> Are we going forward with this guidance? I have another laptop with
> another ATNAxxx panel (ATNA60HR07-0) that I intend to submit a DT for
> soon

That would be my preference.

-Doug
