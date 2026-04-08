Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7861BFD5F92
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D134710E56A;
	Wed,  8 Apr 2026 08:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EFUIV8Vz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD9B10E55C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:08:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 13A874446E
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5995C2BCB1
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775635700;
 bh=Z1Ts+VSZ8ou/NVe55RhyiohrVm9KZyDeSwhovMasKD8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EFUIV8VzagVTGspbyWcs99qygrmbWHOf3+hu2/gd9pXn9sEVpWWttAUWKnsJTkfKm
 GQsm2BAFr0YvwRbV4wxTCKYxqIR9rf2+akW2xVglsXTL9O/MA8DEmp2LPtb/HYMzUy
 2o+udoxr+wB53XnefG9Yw44IRJU7WpigKpVxtz2LBtYDZvf66cL3h7y1u9jZ7QttpS
 HFm3gSG3dgCSRfzHGvq8Xu2r8zcKnryvWoKA7dSaq78EzUzdjV/Os5zyUF7gz1u6Gn
 bUeZC8+HRZTzeIoi3Pa+GdqQ8sK1j/M17LfUQjQSU3Y00rRCLjVRc7MYnXY65PUGj7
 LLUBCRZyXw13w==
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-79a74765703so47984357b3.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 01:08:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUPB22MYJ0nbBnCJ+DmNylPSgbKkd7Um+/rv3Rs16NubCReoiVZ94KU2IWqgh0WFZ6KN2yWV+tbbto=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywt7Po+2GVaBUtjwlyqnDSGYtPsbVh3tu//+UX5WeqpwbRhxVOJ
 31DOhG8nzIn7yfMFGMH2dw8iKZURsllDqlrE+GzzWwr13apRI2KEwN0S1TtX8pTWfuY5JEXK16k
 V0mgSO1ndRVKwMbP5pCYjqDGCyq2FF0M=
X-Received: by 2002:a05:690c:83:b0:79f:3715:1980 with SMTP id
 00721157ae682-7a4d31e8531mr208856957b3.12.1775635700366; Wed, 08 Apr 2026
 01:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-8-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-8-5e9119b5a014@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 8 Apr 2026 10:08:09 +0200
X-Gmail-Original-Message-ID: <CAD++jLk4_hrHPau6o_hcDHxkogcb1gJN_B-7=mG2h_yy+jcABw@mail.gmail.com>
X-Gm-Features: AQROBzD0nHt18W_nwPr3GegJacTTDqPAXGlhjqavd0Oyh2PTNzHmEVgvGVfoQsM
Message-ID: <CAD++jLk4_hrHPau6o_hcDHxkogcb1gJN_B-7=mG2h_yy+jcABw@mail.gmail.com>
Subject: Re: [PATCH 08/19] drm/panel: himax-hx8394: set prepare_prev_first
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
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

On Wed, Apr 1, 2026 at 9:27=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Sending DSI commands from the prepare() callback requires DSI link to be
> up at that point. For DSI hosts is guaranteed only if the panel driver
> sets the .prepare_prev_first flag. Set it to let these panels work with
> the DSI hosts which don't power on the link in their .mode_set callback.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
