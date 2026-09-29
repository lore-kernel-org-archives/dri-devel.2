Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927C8CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE3710EE9B;
	Tue, 29 Sep 2026 12:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jI/dbVEp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C979C10E651
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:54:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A00B43FB6
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3271F008A6
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790686495;
 bh=Igy42JddWg1pvkuq6wti/LXMBzd9rwbkMAjmT2jtT+0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=jI/dbVEpToIZjYPOtLcxlN0h3WJDkOrANgmtO2i8XE78vv7VqR/PeARfiiQonmD4Y
 EfBPRo8EPGNjbLhfNaSxRWKg0T9DFBFNWmC85RWdDJoIOa0Ynz4W+76kgEl+irxVxw
 kktRI/6tfdO5HM4dgxyQVCBp3XqZoGQu2mEsDYXSp3ysm8/D2CWAgl04HglIdkPYtr
 l5YQANrrCKSdWfXtAvwYSEbqm/p/BOsLanOvE8UF90BZapp7hVj4WQxtfQu0hm8sbi
 ph4lpmHta4oBf+e77DRO+G1s4achZKJl7Q68baOsp2LTfo4LA7PxFvkSv34Qu4Cj+E
 hayQnICxL/rHA==
Received: by mail-oa2-f13.google.com with SMTP id
 586e51a60fabf-466ccdd7695so1645237fac.1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 05:54:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzGPZiOVkuNl/XT33zEPlxzHNGmJV/VoZUUHwA2UQhhs4qrnpMgunk63azUUViiXjwP8zu+1QmPRic=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nDxTYd9wtGd4kY53DrSp1kAvqESzG5/bL25Rh6m3YmguK2KNUq
 tYo9ATuyIyEdGPFKQTnAyxtyYN1d96BwF+0fEJdQZCDfgLf/xQ4AZFnaC4Xa9pA9fZTODX+qgoj
 VL6Ki+/fGNtXun+oyo1aCwPY1ACyF7ug=
X-Received: by 2002:a05:6870:d1c2:b0:48f:e0e5:a1dd with SMTP id
 586e51a60fabf-491e7a6d6b0mr14229510fac.50.1790686494627; Tue, 29 Sep 2026
 05:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
 <20260727-spotted-winged-mantis-7aa1ce@quoll>
In-Reply-To: <20260727-spotted-winged-mantis-7aa1ce@quoll>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 29 Sep 2026 14:54:40 +0200
X-Gmail-Original-Message-ID: <CAD++jLkX0m6_GJd4Pd1Ko4tghta4AXQ5ALZpLe_x-3xxqu1Cvw@mail.gmail.com>
X-Gm-Features: AclHuK_CheQSKIMDhFg2gRDpav4ZMyb1OqvfpMBU-vTMPZz8dP06MGN3wLf1QRU
Message-ID: <CAD++jLkX0m6_GJd4Pd1Ko4tghta4AXQ5ALZpLe_x-3xxqu1Cvw@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] dt-bindings: display: Add Synaptics R63455 panel
 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jun Nie <jun.nie@linaro.org>, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
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

On Mon, Jul 27, 2026 at 10:29=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> On Mon, Jul 27, 2026 at 04:08:44PM +0800, Jun Nie wrote:

> > +  reset-gpios:
> > +    maxItems: 2
> > +    description: 2 reset pins for 2 physical panels
>
> Won't work. gpio-consumer-common expects only one reset line. You need
> two separate properties.

Hm that is a big confusion for the head.

reset-gpios is by it's very nature plural, because we structured
all GPIOs like that, exactly in order to indicate that they can be
arrays. :/

I think it's appropriate to patch gpio-consumer-common to accept
> 1 gpios, in a separate patch, can even be sent outside
of this series.

Unless the DT maintainers have some good reason to slap my
hands for that suggestion...

Yours,
Linus Walleij
