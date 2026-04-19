Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0EDEA7197
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 20:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F52110E119;
	Sun, 19 Apr 2026 20:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cEWHcbDm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F3D910E119
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:17:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EC501402A5
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C382DC2BCF6
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776629828;
 bh=CP8bkuBKJOFmVGmEVu1l1muELYYVmpgOJntoDr4vk9Q=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=cEWHcbDm6vKPyyB+UnYS+7FTWWZc4QZGNpZStMMYR1r0QoeMMS9diRSyhiJKVKZHe
 cU/sCS0cE4N8qlvoibxk3BkEYImb6j132yLJQzIiqQtT20fdNcpg7GovnPtPpq2LIe
 q+YvVMAZAqAVJNuDSNCGujDttyvAEAhEXrikJm9leb9ZHyQ6qWR3xoVYJsitMZl7qh
 uvG6YzHmH3+xWwsMQ/dulyaP2chRh11u3vNJtJKzBSBL9ux2H956JHpm3NMmUPcjjk
 i/XoJ7cXrklZ0B0NjF2eQCZk1VCyLaO3MBI0DLnYkmAkiji5rmJDsh8jmvoLFvFqQH
 zOmXlgUU4q2Yw==
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-59dcdf60427so2049264e87.3
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 13:17:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8/4vwT5ZlISGR7LqpbMwHSXrUUV9C+OG745RNEu8vruSYCMS6+X19HxltkoWj3bppVXAcqRiEt8uQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwU29fewMn0tJFNqCWlNo56a3rKuB3o+ifZ82BOGxNNP7q5u2CW
 LmgdPfetkG7sCBPmeTZIEwXidePVUmzmUlwQTSbRlfIeqXTxYer3QLxb/ksLLM6aOkQrg5RYeUt
 YDLjzuOhwIGIO98ToGKMQ8k5ISAW950s=
X-Received: by 2002:a05:6512:32c8:b0:5a2:7b6e:fbb0 with SMTP id
 2adb3069b0e04-5a4172f4fc5mr3763987e87.36.1776629827515; Sun, 19 Apr 2026
 13:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-16-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-16-75cdbeac5156@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 19 Apr 2026 22:16:55 +0200
X-Gmail-Original-Message-ID: <CAD++jLk4WdBjSKOxidrmNFaHnKRoCEJ0BZs75tzGaBs_GgcpVQ@mail.gmail.com>
X-Gm-Features: AQROBzD4gh7x6mle0p09cPVW0iDsM4bdaCE_PLixWm3RoYCv64TOfpPLn5u7mzs
Message-ID: <CAD++jLk4WdBjSKOxidrmNFaHnKRoCEJ0BZs75tzGaBs_GgcpVQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 720p DSI panels
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
 linux-gpio@vger.kernel.org, Riccardo Mereu <r.mereu@arduino.cc>
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

On Sat, Apr 11, 2026 at 2:11=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Add configuration for Waveshare 9.0" and 10.1" 720p DSI panels using
> JD9365 controller.
>
> Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
