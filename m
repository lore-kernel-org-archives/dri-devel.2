Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49678CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FCE10F214;
	Wed, 30 Sep 2026 07:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QqijGpMZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 137F610F213
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:44:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C1A5443F39
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FBB1F008A1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790754259;
 bh=FtLOcaaScRzLoTwiQLz6MZYTj7kinYwBxEJCUpaO0oc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=QqijGpMZuiw88teEb5g++MFkOcXc14m0SFfKeu2eH5Sfl49kEEcnwbqrf8v9FipWi
 X+l0v14h3whYKb5O8HGh0TKYQlNo7wuaF6i6jIrWtRI9+/hD5ar3seKJfRQHHzMWBd
 bSMtr3WRUGbq5GyparrcSbbggvDs5UgjO3n4H6r7+3lsxbqwr8wt0FtRkIc+73+adf
 It+OLyUiactbFJUATBtvkXFH98pLvGh5rZVFl2HFFSvKz/foivBWNMAmVVFZHoNq4n
 23IYvrcxkga/LNozwcE9K9EGYKXeVqCnxCz3DwnKNU/YYE9wKsF3sM95MZVhpIj4uH
 oBXKHnAK1bBFw==
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b8eacb7c8fso4388129e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:44:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwrdg1ppDRr9O4b9CDmxavVKoNr7lDmbERlnulZ0zqx1k4V6thpOgT4usInP/w7NJ2odd+7yWkIi9c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJPn9gA5hOeRU4bkjVr3zlwUzYxN9REBsousoXHFL+zgcV+/G/B
 nfs1j8eh54/00RZ+Nb4UxOfhHeQ2iFW/VX4fHYBoZVJUHiWzoUYY1Vhu60zB+O8t6nyNmmKSGEO
 OhumvzKFpZaqM/kUV+7lQjVFGZkf10Os=
X-Received: by 2002:a05:6512:3592:b0:5ba:3b1c:2f5f with SMTP id
 2adb3069b0e04-5ba406088a3mr140468e87.60.1790754258346; Wed, 30 Sep 2026
 00:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
 <20260727-spotted-winged-mantis-7aa1ce@quoll>
 <CAD++jLkX0m6_GJd4Pd1Ko4tghta4AXQ5ALZpLe_x-3xxqu1Cvw@mail.gmail.com>
 <668e83d0-a017-4f59-bc76-bf6c9a80b5ba@kernel.org>
In-Reply-To: <668e83d0-a017-4f59-bc76-bf6c9a80b5ba@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 09:44:06 +0200
X-Gmail-Original-Message-ID: <CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com>
X-Gm-Features: AclHuK9JQOplVIXeKlWlmUy3qK_WlTaornnEdXd3kmRQorHCOhHPlOKdxs8zWKE
Message-ID: <CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com>
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

On Tue, Sep 29, 2026 at 3:35=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:

> This entire binding seems like stitching two devices together, which
> might be fine (I don't even remember this stuff... two months old) or
> might be artificial grouping of separate devices.

I think that's a good point and fair pushback.

Neil and Jun talk about it yesterday at XDC (1:15 into the stream):
https://www.youtube.com/watch?v=3D6tNGW8PoSzw

The current binding does not reflect the physical topology of the
actual device, and the bindings need improvements. I have a feeling
there is one display controller with two physical panels.

In that case I think it's better if we do:

panel: panel@0 {
    /* This is the two-panel package with one display controller */
    compatible =3D "sharp,ls026b3sa06", "synaptics,r63455";
    reg =3D <0>;
    #address-cells =3D <1>;
    #size-cells =3D <0>;

    panel@0 {
        reset-gpios =3D <&pm8550_gpios 3 GPIO_ACTIVE_HIGH>;
        reg =3D <0>;
         ....
    };

    panel@1 {
        reset-gpios =3D <&pm8550_gpios 11 GPIO_ACTIVE_HIGH>;
        reg =3D <1>;
        ....
    };

...
};


Yours,
Linus Walleij
