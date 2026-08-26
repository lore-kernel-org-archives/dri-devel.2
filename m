Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ECFC61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4A110EC3B;
	Wed, 26 Aug 2026 08:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mt5hnjcW";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE29A10EC3B
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:03:56 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-66d1082054fso561241d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 01:03:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731435; cv=none;
 d=google.com; s=arc-20260327;
 b=W/0Pu4VUorq5oV8cBOaOy4Cms9fWTo4njjxcmBzhZi8XiH+pkX72qEMQxrl6QEi3Zc
 Pk5qC+zNCdRfrReCxtZoXP1Xz0Rse1bBfiDvybdZj1trNGpCCNmInwWXsFozr7cigV0N
 hTLfDk9UzwgOEq05W16jzZAOtV5ZaVgxejYoXeXy9NFVDtl275ggEIBbJJTT7QjKEQYF
 NKd33vRUz2+oPPY4ExS0cmCC1t5f4OapflrbbiUPgOAC5up06CpvLrWmT9832/i/2vC/
 fCYdB4gZNRbwPLtWugwsyULtj8if6yZPMwgHxuKKSlr+34PSVJj0lduRydbjYvGTSbL3
 0nQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E527r35PH3U3M7/ba4/IfQXpLEJINpkZTHz2CHClcLI=;
 fh=muCQ/tawxieGkVWyY6B0gPk2too+EIxaHy+H97sqEhw=;
 b=AiZCLLRWnWKp3LOhREkpUSw2L+Dfj0JxdcUX5sKNq8E8/k8e/MWqtS8eKZ3yP0xvX2
 CSbOdaRHtsZ+0TF9DozCVAfhJdjlAh8x1gpx43oJDvLgwyz436ZHjNmLgdeTJl9gBOKZ
 5BSlBkhRAeKyHkbOwPYwI2kXbMIpmyVr+HBPnkG0HMIDpaElWrPrbhgTr8kctYAYjaXM
 0eXlYiEKNRpBqjSmHKxZd7VBM4eaVa5cvaYgrU6UIZJI+fMW6IHG4v/MlRDcXcYFONG8
 x2qLazjc8ZrcHEKKNnTvckSb5VUA+9btUrP51IrDth9UN+syd68MsUzUMorukAroGh3z
 RfNw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787731435; x=1788336235; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E527r35PH3U3M7/ba4/IfQXpLEJINpkZTHz2CHClcLI=;
 b=Mt5hnjcWD1vpkA0gaF7X6IxbZ5DpAv4mm6xUkz9l5cgOX9jSW7pcHCyiH0438L3KG4
 xIajnJm79S+u6OZWRiBb/NH80M4KuFk8UETxc3LChIdFkdVztR7ayoVvF6c/9lMzngla
 8SimXHEknulvLN21/Cn5kotBcIZKeoNtP1Cy0Ctu6p9vjlErd11tevXN+qBkiaqgDpi0
 e9g6kdU5ggw7RlBceoxuoHXUy+ASm1/howMsXwcCDYqZQmLW2D/GPqViD9FIcW/buagH
 6numdRegdf4fUT1OPQKekvGn1gLoOrEbLATb4bWNchmrFvAl+GYvNQWYdRBikMNglv1K
 ia3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787731435; x=1788336235;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E527r35PH3U3M7/ba4/IfQXpLEJINpkZTHz2CHClcLI=;
 b=XHM+eKA9deFkF9VLMi0XSPKZ5GuWEzZDQnknNHV0XsEuc7vjdhs9pTwz/5HgC+IZ8X
 3UpiVyltcjK+rqvSLnRm+0HJ+CgJW6nn8rSX7gwQsQLimdvWgH331OC8EQb1rG7m7rp5
 KC1D9PgHtW7rVphBS0pnHmMifLL89zZX6CQYMxpK6ZuB/u8l3xLbKgRfQC5RkEBzndpR
 1ZXCTnh5Tu1XDRvikG1nyUqqrnH0qVn6DnOZqAv6MypO+gRtYKu+ePxv8eN4D6PMBhJ2
 B/o58frmbOsiZbVe7I1A0MHqZH/WOhTR9M+ggNUnNBtBUflWogPRdVbdFScJ2KIxIwDy
 nLfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQ1wQ5GUz89vGF33qX9PwsvDnz9HZKvMTIXZ3cgnAOUjMjJ7956t4DJuPmGA/r1scOksl80HeXoGQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lO2tx4/fcp4MpG0XF8KCwVuc6aFXm3bIjePG1t/DjKz1ZPGzpx
 U+ggiEMU9fdBodikxVt+sdbK+45LJjAXbbRME0KsgI0bZmn3GGulGwxhZBSlgdVxMi0iaFzBisf
 OvJIKBDYFiAzygzCfe0mpjtxMgE2zJ10=
X-Gm-Gg: AR+sD13Er67KW2RUQziKGAugpSqdFIpvkh6mMg8HSvlQVXZ3IQbze7C+A7UbCSTfvaj
 ikshyzODMA+rYzdI+52Vhwpm5sBh4QYtTtYHv2B1huYvtKYjkCxbsLPUV5oJ+CkYqAUSUJkxYLN
 MwHlhHqjdBbn+av6rlCWcg9+rI5taj7P1hh1onhcVN7I9sJ5GF7lfPPjLJEPoFC7qXQsjy4F7uU
 8+VJGRn8AwcxTpPikHh86wwjnHnbstout9G0SIcPRw3DYEVU7BhZdJaNkdrrO41qp8Psqv/SClt
 6Tn4X9IEosAoqEckM233mLi5KDJo0G7ofr02Ws7S5JA3CZ8=
X-Received: by 2002:a05:690e:2455:b0:667:f3d7:eb35 with SMTP id
 956f58d0204a3-66d257691abmr1344105d50.6.1787731435407; Wed, 26 Aug 2026
 01:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260808121752.2819486-1-lgs201920130244@gmail.com>
 <626c4fa0-8e7f-4ef5-a027-b6ae2aa36099@kernel.org>
In-Reply-To: <626c4fa0-8e7f-4ef5-a027-b6ae2aa36099@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:03:42 +0800
X-Gm-Features: AcwNN1Vol6DpYyKDV-cri24sXXF_Z7PWR_q7g87D7ApkpF8hGkZUW9sBryzNqjI
Message-ID: <CANUHTR8KWSjBgV0QSAeitKKoLL==fMkpmcrZV6Zv-LBYNz-vew@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: g2d: fix autosuspend cleanup on probe failure
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 14:17, Guangshuo Li wrote:
> > g2d_probe() calls pm_runtime_use_autosuspend(), but its failure path
> > does not call the matching pm_runtime_dont_use_autosuspend() before
> > disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during cleanup, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call to the probe
> > failure path before disabling runtime PM.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: d7f1642c90ab ("drm/exynos: add G2D driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
