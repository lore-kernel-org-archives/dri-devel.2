Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDCEC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 17:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E4410E152;
	Fri, 10 Jul 2026 17:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XwhKmW4C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 978B110E152
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 17:53:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1BC8543AFF
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 17:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008181F00A3A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 17:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783706036;
 bh=phiSEDYoliL0m9tNM6ZLUUhQmJA1rM+eXKgC07xIv1U=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=XwhKmW4C4Er4ULJZ5KYUTVUkTBKEiDQ6EEhlQ9IJb5KOOSSIxXLK5k9h+zOA+vDNW
 aHhIc6h30kH4GVa0vQEDmktWwsyawHNgjhnxjDPmFVnwZhqL4/z7EFlaZxU6FQab3U
 oT5kkzlO+iMZbf0kLWGVuqTeMzZRpuhKW6x/DDQP1/FvGyK8ryXFQqU9MPyEHzk2Zu
 pI93ZzEGdKdvxPsV0ftFJDjPPWhYJZnjKpb33NLtcpLo6Vt8wzhLHp132Wv4HqDZs/
 ImTkMUGv02/KGlGBN77rGEFQxJPKDivIGyl1ceXDoNPfq5dQxMClmjHuk+jdHAbWQe
 wY2Eoo3H8UQcQ==
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5b0231a3e86so89094e87.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 10:53:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrJgICKFme53mPvf4s95HyJjLDRNzSUMAcwrxCM8jmz/Cp/gx9XpLq/gI8YKgg6DjurGLwP2wSKr+A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVwNkcuaNpWytHGw1N6m+gVtib+RYyj1feZzijr0yxo3110Nk0
 B+4bS386iOC2V+wyXb7a5nv6Lb5urKKcMfFkhDyighixrUxE8Ml0spZd72DPH300BLncWLpggW3
 8mpfYXSB++dopUO1B9j7fT4EASNh60is=
X-Received: by 2002:a05:6512:14c:b0:5b0:bc3:dbf3 with SMTP id
 2adb3069b0e04-5b02369c6f8mr26402e87.30.1783706034779; Fri, 10 Jul 2026
 10:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260704070648.35249-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260704070648.35249-1-acharyalaxman8848@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 19:53:41 +0200
X-Gmail-Original-Message-ID: <CAD++jLkmXwDvMfZm1h9AE3Bk413jEku0EAR_H6wY13SZWbwstQ@mail.gmail.com>
X-Gm-Features: AUfX_mwGMD-lc0djukQz1DO5QHpP1YDlbF613wMlC6h4ooQhkL5CQs_347CuUQs
Message-ID: <CAD++jLkmXwDvMfZm1h9AE3Bk413jEku0EAR_H6wY13SZWbwstQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel: samsung-s6d16d0: Power off on prepare
 failure
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
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

On Sat, Jul 4, 2026 at 9:06=E2=80=AFAM Laxman Acharya Padhya
<acharyalaxman8848@gmail.com> wrote:

> If enabling tearing mode or exiting sleep mode fails after the
> regulator is enabled, s6d16d0_prepare() returns without asserting
> reset or disabling the supply. Since the DRM panel core leaves the
> panel unprepared, a later unprepare call skips the driver callback
> and the supply remains enabled.
>
> Assert reset and disable the supply before returning the DSI command erro=
r.
>
> Fixes: ac1d6d74884e ("drm/panel: Add driver for Samsung S6D16D0 panel")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

Patch applied!

Yours,
Linus Walleij
