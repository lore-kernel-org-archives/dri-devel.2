Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA570EDB7DC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4824410E39C;
	Tue,  7 Apr 2026 09:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lx5pJPqL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F06D10E39C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:38:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A6ED944536
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF34C116C6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775554719;
 bh=qbaq9SOSmcdlK6NYNjMAzasR5YXSYeew4YreKIiRi6s=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Lx5pJPqLMn+Ew0GMFQwy9BSmW9OWtPdYd4svuWD4HPDsXdDt41HC5squdUR+3TfUI
 WQKK/fCTLSZW9L3IP+ELfFxDjGkMyTGh51Z8BaqCAnMYLVA4MmkltPMtJY2B6qhxEc
 90xrs2AmtZKKEh1Nl/2fMO++eybPScjtJmG5OFVWDbctpt8MYWf3gG+njm6s1rlzse
 Lik6kozC+x2dy8nzsSCJKb+xu0LK2rf1plQb4xGfcyVfilxxhlHuuy4ZIDucTeU+ku
 xqHkFSoafuPKV5BmIQN+CUCz8AsYOK+V0pCSUypIFRatHBBxyAqG+t6QmufsAe2WL2
 6imJCRKaUC3WQ==
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-79827d28fc4so39864357b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:38:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUytkPB3agLCTh0h8gCXbtkD8HeJ1jnOc1te3NMzbxhozOSfyQjpLysH9wcBqirngynj+hV54U7Mzk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz17qJdt/ZVUlJ8pAr6xR4q8kz2+jcapiEZPLXDzH1QFUTG5SwK
 ccWWgqzzZipCLSdnYwYzzJW6wmISpjLkcoTK2gMoELmWji55DmzJKtHw9Fm/Z4jzMNH5RbCUPrJ
 wxZWaQsZ7yq2tzrnmAtZJC7ou8BaKVuE=
X-Received: by 2002:a05:690c:2610:b0:79d:62ed:31a1 with SMTP id
 00721157ae682-7a4d6447e08mr154470037b3.7.1775554718691; Tue, 07 Apr 2026
 02:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-1-5e9119b5a014@oss.qualcomm.com>
 <20260402-sticky-wooden-silkworm-5bdff4@quoll>
In-Reply-To: <20260402-sticky-wooden-silkworm-5bdff4@quoll>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 7 Apr 2026 11:38:27 +0200
X-Gmail-Original-Message-ID: <CAD++jL=T9eOXujPSpTp_uNJ2rxN9P9Ybt28+H-YF_=3+_RXCkQ@mail.gmail.com>
X-Gm-Features: AQROBzALI39VVdEDsFgw7SSBvHbcnyWw7WWRVVsV9Lkg9uQSRntSmFhNhKeoDIc
Message-ID: <CAD++jL=T9eOXujPSpTp_uNJ2rxN9P9Ybt28+H-YF_=3+_RXCkQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] dt-bindings: display/panel: himax, hx83102: describe
 Waveshare panel
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>, Jagan Teki <jagan@edgeble.ai>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org
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

On Thu, Apr 2, 2026 at 10:30=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> On Wed, Apr 01, 2026 at 10:26:20AM +0300, Dmitry Baryshkov wrote:

> > +          # Waveshare 12.3-DSI-TOUCH-A panel
> > +          - waveshare,12.3-dsi-touch-a
>
> I don't think we use '.' in compatibles, so waveshare,12-3-dsi-touch-a

Qualcomm happen to use periods in similar cases for their
"qualcomm universal peripheral":
Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml

I don't know if the policy changed since, but that's a big and widespread
platform and I never saw it challenged so I think it's kind of established
that we do.

Yours,
Linus Walleij
