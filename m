Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C46DCA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8518E10E311;
	Wed, 30 Sep 2026 19:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n470vNXa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F6310E28B
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:59:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF64E41AAA
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C841F008A6
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790798345;
 bh=D/tJ8XO5I/d4e+Rte4uhp801DYYIQLeDeH32x1bw40c=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=n470vNXaLCPDVYGZ/r3nlV6tajokuBHd+PHbSK0cEQ+vv2GulqzwQiy66EZ4VBmjT
 69NLtDKBO86cNARwGsnk+cRv+A5DyBlFf9vpdDurovVZsaw0DdczKUbMZuq6rewqkH
 PiEyze6nTwpI/c223FfDLgyeJYdNjW28PcWxK0XTTsRlRNlSgsVyApfojdQD+QFsu/
 87OHFEi8nbeiHUG0DXEd7/4Kqyv+7nxGOda9dvd7YSPTrbso+XKqepnLjJTLUjnBAY
 jOzdTna7aVE0e3RJ33nvCEiST8pBalurkjU8EHpBy7/aGuCl6klNJJXd4wv6pV+n8/
 oszjDqjdABKxg==
Received: by mail-lr2-f35.google.com with SMTP id
 38308e7fff4ca-3a77ef47f6eso6361801fa.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:59:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzCDR3QzxDiJ5/h+0I4aU1twY/jAbcVjuKlmGhJJrG889J5C6lJ+BVYZbQTLG+sK8LRmGz6Vj/ygoE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKIWlcI/yn95XXRkbZe3SP1hCYCmPkGs7yk7OFHLFAHhLrhbQJg
 eOt0XJBjIaxR6PN/ISKlatQE1JeCxWc8TiGMLQzsidCzTYpfLYEUOQMhioS2vf7SEnktMQpf1Hg
 MvQclT11322Et+Mio6cWi5t6Bxj77uJg=
X-Received: by 2002:a05:651c:2107:b0:3a6:70bf:622e with SMTP id
 38308e7fff4ca-3a7791d1688mr7596131fa.4.1790798344186; Wed, 30 Sep 2026
 12:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
 <20260727-spotted-winged-mantis-7aa1ce@quoll>
 <CAD++jLkX0m6_GJd4Pd1Ko4tghta4AXQ5ALZpLe_x-3xxqu1Cvw@mail.gmail.com>
 <668e83d0-a017-4f59-bc76-bf6c9a80b5ba@kernel.org>
 <CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com>
 <bc3e618f-2e7a-4439-9466-8cd9695242e5@linaro.org>
In-Reply-To: <bc3e618f-2e7a-4439-9466-8cd9695242e5@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 21:58:51 +0200
X-Gmail-Original-Message-ID: <CAD++jL=EZ5o=tAQZCTp9N7fKLJcxs7d0mg02dK04y_TNYtCZHQ@mail.gmail.com>
X-Gm-Features: AclHuK9gg0cHcaEM-2OSIkVk8KJVeFTXpszMdFCa2oeVci2UZbbhBGtCUcsPNPs
Message-ID: <CAD++jL=EZ5o=tAQZCTp9N7fKLJcxs7d0mg02dK04y_TNYtCZHQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] dt-bindings: display: Add Synaptics R63455 panel
 support
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jun Nie <jun.nie@linaro.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
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

On Wed, Sep 30, 2026 at 6:43=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
> On 9/30/26 09:44, Linus Walleij wrote:
> > On Tue, Sep 29, 2026 at 3:35=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:

> > The current binding does not reflect the physical topology of the
> > actual device, and the bindings need improvements. I have a feeling
> > there is one display controller with two physical panels.
>
> No there's really 2 controller and 2 separate panels, but they are not
> classic panel, they are a pair of panels+lens which are in front of
> the eyes which forms a single "image" for the brain, so they are
> technically a single display and requires to be hard synchronized.

OK

> See it like a single physical panel with 2 controllers which
> shouldn't be used separately.

If you have one reset line to them each, and as proven
by the driver in this series also grab and assert both, they
are by definition *already* used separately.

DT needs to describe the hardware.

Defining two nodes below the main node for the two
controllers and adding a reset line to each describes the
hardware perfectly fine?

It's not like I don't understand that this will complicate things
on the drivers side, of course it does. But a binding is a binding
is a binding. It needs to describe the hardware.

Yours,
Linus Walleij
