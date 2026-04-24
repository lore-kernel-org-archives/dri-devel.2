Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8498DFED3FC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 20:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CFE10E089;
	Fri, 24 Apr 2026 20:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WXqVmki+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E76410E089
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 20:47:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D9DCB4034F
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 20:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DF5C2BCB4
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 20:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777063627;
 bh=jw+MgYZVVHgfn3vtTTfB+rLOtsgMZ5y6tsJcAYzS4SA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=WXqVmki+zweyn313GcGXqCCf3atLGl8cQ/gT6LuW9fthCetmh2BwQqcJqXvzJLX15
 8IWgGoeBh3SDD1Tn88vEvo6yJ7MvN/GokI3damcSed2M6eP/cthBna2VNGwCZN+QZ+
 IPKq/NYRB5tcucdTHD6E8l13pZf8ZpoXLa6OsPbu7tdER2tusUtYwpPQBz4soaHQxv
 LHarndVh+Lx/P+JZPDCxESdxzouZc9aAHT46xxUYmRlLgKaDp9HKedJmFa6CBK8fqM
 5u7MVcx8Y6FNQKKD8BFJEECihFbXOP7dFAGM8OqO4Said7LKapnAtdEfHcm23TdyxZ
 o/2axPcYVtdTg==
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5a415fd6bceso9199132e87.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 13:47:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8ooaO1OeY2aCZc3Z6CJBEKYoVc0AD3AEHfx0YiaHhTEEZFlNnfL+/nkTXuNAG+Q7WjP8W6AlRipno=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrhWclSW8cmfuJX3nrCKW+e0PbSAQ5loU3aK0qbqKG8/svAk85
 Oy06ITghTguKS1I5PLLZP9e8IA8AmiVRrgQH24RghPRcSNzVdE0//x6KeQ+Bkpfxh+/TQd4SiFO
 qdaKnT4GbfSqqkusS12V7a3kOyGhxk+g=
X-Received: by 2002:a05:6512:3e20:b0:5a2:c962:59f1 with SMTP id
 2adb3069b0e04-5a4172a3042mr9516685e87.16.1777063626467; Fri, 24 Apr 2026
 13:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com>
 <20260418-waveshare-dsi-touch-v4-2-b249f3e702bd@oss.qualcomm.com>
In-Reply-To: <20260418-waveshare-dsi-touch-v4-2-b249f3e702bd@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 24 Apr 2026 22:46:54 +0200
X-Gmail-Original-Message-ID: <CAD++jL=CT4CDViP0tz=F670f2YEPfzzxU0pBiu-eVa0B6XeALQ@mail.gmail.com>
X-Gm-Features: AQROBzC_zC31n0yaYjbDYVpdboDyP2JOJXGqdTaVQIcUTzUXKKm5ahVP2tMdfpY
Message-ID: <CAD++jL=CT4CDViP0tz=F670f2YEPfzzxU0pBiu-eVa0B6XeALQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] drm/panel: ilitek-ili9881c: support Waveshare 7.0"
 DSI panel
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
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

On Sat, Apr 18, 2026 at 1:16=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Enable support for Waveshare 7.0" DSI TOUCH-A panel. It requires
> additional voltage regulator, iovcc.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
