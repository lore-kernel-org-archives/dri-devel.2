Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB612FD5F8F
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A53810E56C;
	Wed,  8 Apr 2026 08:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DjJUWZ8p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB2610E56C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:15:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 010486012A
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32FBC2BCC4
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775636147;
 bh=Z1Ts+VSZ8ou/NVe55RhyiohrVm9KZyDeSwhovMasKD8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DjJUWZ8p+SrYZMJe8a7MP/eKq6noIw+mM8ZBQN2VSSPp7t8H4gTwqMDq/NJVd0jjK
 XROF5dzZrwwfVLsMfdCa5K8zQVWscKCo0yn06R/meLJiSxRz/PluiLBKTx3IS4kD44
 D2JGDmNXuXVV2wJ0nt68vInXT/6LPHFQZCIbZMETGRmapO224VQUkLwOPr/btLV/J7
 Q3LtR8MajB6r0oEDBU4o2elNrokdZdV4kslHPn0M9aUj4qTB9dLlNSe2s2Rr1P2rNo
 uxSAVIif+Uh78xnf69h81njib6Uf3keCxOm9dTpEhfNSnvXuAzkuIIcgbMQxb81AdW
 /vvmbiJZjmT5g==
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-7a43424f861so55879957b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 01:15:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXvpjMXoEskMoaiAJmVfSlmSOXiHjFiUOCLnT/uygzWANcQPVLZpY/Ee5+2lvMKZVGCqh1WXuHl1R4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrsrgMinsnGWpsCvxe7/mqVJ6V1YlNBI95xUQXa8QdwgTgrmkc
 fSoPGP57ObDQy9UJ/7utWLN2opgaJDuKLynG0uzFT9uFhhk9//r/wKrpUe4tr2BSnaXCqKINWaU
 eREHmsAfGql+tQyLqdEE7S9T1x9W1ovg=
X-Received: by 2002:a05:690c:12:b0:79e:21eb:e9ca with SMTP id
 00721157ae682-7a4d566ad29mr202825207b3.30.1775636147018; Wed, 08 Apr 2026
 01:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-13-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-13-5e9119b5a014@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 8 Apr 2026 10:15:36 +0200
X-Gmail-Original-Message-ID: <CAD++jLm1kjuodURGsQt9ChA11zKJPf9Eayw7dy7LN_fdfWoAGw@mail.gmail.com>
X-Gm-Features: AQROBzDH7UQOKJUwrcrXsozOYhM9A3Hna5Srzfu5ji4HDrC0JSqqCxNeZwfuyJ0
Message-ID: <CAD++jLm1kjuodURGsQt9ChA11zKJPf9Eayw7dy7LN_fdfWoAGw@mail.gmail.com>
Subject: Re: [PATCH 13/19] drm/panel: jadard-jd9365da-h3: set
 prepare_prev_first
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
