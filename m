Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3BEFDEE4D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E290510F2BA;
	Thu, 23 Apr 2026 21:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SFGC7eJH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CDE10F2F6
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:27:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BA63C44526
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7694FC2BCF4
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776979629;
 bh=e9Rcsq/gDVzpVBiuBUUAyTPNtpV1E0msTNpXLoxK/0s=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=SFGC7eJH+DqjXdjlFpRT0dZfHQQn2gMKoZnlQf6xBXdFPgVCJ9PiIN+BPpfgJb1Ye
 +TpsnTuzZNgGDQSQr2ThpfoWncius3rsG577335bKo90o0ADuk2swaogtzFg6iEchE
 M/vji5KfRY1L0SMC3ro8jV/Lxwa9SYtbi16n8ibsnD7p3lnl+QOHHPR+xR7+yvPCVO
 CEn2mwHt8+f8Ssc8R0hsF9bdHQWknyjPG/hfuCk5BYYxeOkHtEz48Qi1slhZS0OIP0
 Sm99K/tobA2j9novCIJBWfkMW5cDkpuv8/AyFC3ygCM4sIBkTRYiSSd+B00Uhymv5F
 eNQhgGEgiUPVg==
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5a3d42263e4so6838954e87.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:27:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ83CPPDj8JyPjl+wkLJswXQV3I/0V6c2679Pcm0aW93bvnNkZiQtusDIFbEfvl7ZQWqipt4lwriZts=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMCiHPrCALjGCPdtLiu7tLSsbOwqOpeSPuATf/WUMmr3blNiDE
 6Ws9bmedL6bQZeEP3NubMVrI11tF9ZmrhxeCz+gbHRh476BXPJleKy8CrSlya+W2DdI1OhXJusJ
 YPbJbihzTI2lMvsZejAFHGoUbFnpX+ng=
X-Received: by 2002:a05:6512:2308:b0:5a4:e6:8fb4 with SMTP id
 2adb3069b0e04-5a4172c3f74mr8712250e87.14.1776979628103; Thu, 23 Apr 2026
 14:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
 <20260413-waveshare-dsi-touch-v3-15-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-15-3aeb53022c32@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Apr 2026 23:26:56 +0200
X-Gmail-Original-Message-ID: <CAD++jLmFSkE2E+cLJ9vbSAwigCbNNKMDR_f-hx9DigHYDY2dtw@mail.gmail.com>
X-Gm-Features: AQROBzB6SvxuS6f4Q2qg3ozLYuU_-L1bno2SYmVK5w1krDbgPzv9edT7vhYQdpY
Message-ID: <CAD++jLmFSkE2E+cLJ9vbSAwigCbNNKMDR_f-hx9DigHYDY2dtw@mail.gmail.com>
Subject: Re: [PATCH v3 15/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 WXGA DSI panels
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
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Riccardo Mereu <r.mereu@arduino.cc>
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

On Mon, Apr 13, 2026 at 4:06=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Add configuration for several Waveshare 8.0" and 10.1" WXGA DSI panels
> using JD9365 controller
>
> Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
