Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5B7C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C580C10E049;
	Wed, 16 Sep 2026 13:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cw40UgIn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7599810E049
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:05:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0EA8602D0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5832C1F0089B
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789563956;
 bh=hChrl4CK53bswETCADzXSQQfDk9g/3yul6e82joAVAY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Cw40UgInzcRZ4lXdbos4fZ6UVy/3sGB2KW17PBmWZ+MpBG4FaksCL+yGHdHBw4J7V
 D2OthPG8Izbj+iBMyECsqBTVlJAiBf3HZ8lKXZMx0gUEWGuXUyMO3sIygJgqYKJeC1
 P03b8bVfNiWZJAEA7d4jxM5mlSr85btRSpcfsPA96Nms2DMem/ap1t0zB4zrr75+Yd
 l3G2OyfY6okEsqoqxBYsHX06fMqTHXX4zaTGYjgJPcaSlQK9HUhMEyN2hp9os2foDf
 ojQP63UUXBdjPhAsecGGcl9a4YHlFVu0S1IwlyV6d8DtZBVnn3EEw7Fm1jGJtQPmbD
 AovPeOpFhw3Qg==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f1744fso1324522e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:05:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzYVwX8jzMRA2ka3JN4CxbRLEt8jLWN6W5ewYZIboN4jLu2Lafx4IY42m/3y/Lfu5Po1rIDXEHRfGs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nhaqlJFwLZk8RSu2ubnvsY/CHLu8/Op0ihKipn7msL3702DMu2
 Uwv3IILkPzo+LiA1oqDCxk7ptAmmQKbt16dggB+3ToeINUgvWFoai93GQd7nNyv9eARNG8+pfVV
 K1ij9mmzwh4rHZaOo0UZIEC2OOfXKeWU=
X-Received: by 2002:a05:6512:a8c:b0:5b6:4ae:8c02 with SMTP id
 2adb3069b0e04-5b8b6625b06mr853364e87.29.1789563955033; Wed, 16 Sep 2026
 06:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-17-2ab8ee24538e@bootlin.com>
In-Reply-To: <20260903-drm-bridge-every-panel-v2-17-2ab8ee24538e@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 15:05:41 +0200
X-Gmail-Original-Message-ID: <CAD++jLnCw1p88cZgDPQw89-62NKVRNqor+p36HOb9xnu=MRdaQ@mail.gmail.com>
X-Gm-Features: AcwNN1V4cKCQ7bA02n2CXGc5EhQzCVMKKQ2XQjUhhoN30pCeY779l2poTZvMli8
Message-ID: <CAD++jLnCw1p88cZgDPQw89-62NKVRNqor+p36HOb9xnu=MRdaQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 17/19] drm/tve200: remove unused includes
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Thu, Sep 3, 2026 at 10:13=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:

> The drm_panel API is completely unused in this file.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
