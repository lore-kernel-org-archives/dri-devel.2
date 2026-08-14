Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18DEC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA4A10F360;
	Fri, 14 Aug 2026 07:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B/PjdI+I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3C910E0DF
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:18:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D38F43D5C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424021F00ACA
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786691890;
 bh=X3aX/m4MB0X3J5aMa/h79XzwF1V2FVJZpR75vh+PJzY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=B/PjdI+Ip9eI8+nXdvJz5j8gFcQ+E0DS5Ad5tJ17uEq+s35C1033xI59l3Ja+YVpk
 VwZxc8iKDFG0rw9Wv0Vm3J3b7Feyy9T83NNKhD7SEBiZ6Z20GxP2gDV/+o6Or3RTqV
 xPJdLdp1Bs7EkhBQ59GhAZeY2W66aG99osvxU+omGLCZC3H3rUjv5GIB4NhoM7fGLp
 BHo88ygeZgmSbamHOUqvh7N+zFlIGhw1qBcLIwZOQO4kUgZzz3cHs6eBLuQMlyLO/b
 hiXuVWkdvYs2/mevJZvFT/NquTzPQ/u3lr36vZYl84fWJuPVvF+1agWtjUUWcKhqrm
 cPhJ1Yd9jSvVA==
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5b01146b205so477797e87.2
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 00:18:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqVVL9YYLOB7+Uy9BV/mrpZm8HKPqQEwA3osdh8EsjMlyi5fWM4IL1Ux3zRhQH7zMnaIO//W7W4vM4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIx6r0EGptMvbBnVGLTXz0d/gtY/1ii59XNqIWyzaMGxR0bPP7
 bthbw1rZOj7JR8EvZ1zE8SBRHwbUpYiH8Y6n6f5RdIUsV/rky/TSv8Q8jqLDKWO3obIw6Wz314o
 TBsegeuKptGj99CLBgDfzQ/G6I/eKaNY=
X-Received: by 2002:a05:6512:308c:b0:5b2:eb46:1e66 with SMTP id
 2adb3069b0e04-5b45915e439mr474693e87.14.1786691889008; Fri, 14 Aug 2026
 00:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260810-mipi-dsi-s6d16d0-multi-v2-1-8fcdfbf9bbd2@gmail.com>
In-Reply-To: <20260810-mipi-dsi-s6d16d0-multi-v2-1-8fcdfbf9bbd2@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 09:17:56 +0200
X-Gmail-Original-Message-ID: <CAD++jLkms1eTK5_73M_p0BTCjrxhKKjrTfhy-a3=_hLAehVYTw@mail.gmail.com>
X-Gm-Features: AcwNN1WHjnnLJPz2wJzVJYL6dCPhRv9F4UwJHd7u8fso1g2ynbjSo_lQpf4-T8w
Message-ID: <CAD++jLkms1eTK5_73M_p0BTCjrxhKKjrTfhy-a3=_hLAehVYTw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: samsung-s6d16d0: Use mipi_dsi_*_multi();
 fix minor bugs
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
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

On Tue, Aug 11, 2026 at 1:45=E2=80=AFAM Akash Sukhavasi
<akash.sukhavasi@gmail.com> wrote:

> The mipi_dsi_dcs_*() functions used by this driver are deprecated
> in favour of their _multi() counterparts, as noted in
> Documentation/gpu/todo.rst. The _multi() variants record the
> first error in a context structure and skip subsequent calls once
> an error is set, removing the need to check the return value
> after each command. They also log failures internally, making the
> per-call dev_err() calls redundant.
>
> Convert prepare(), enable(), disable(), and unprepare() to use
> mipi_dsi_dcs_*_multi().
>
> unprepare() previously returned an error if
> mipi_dsi_dcs_enter_sleep_mode() failed, skipping RESET assertion
> and regulator_disable(). Because drm_panel_unprepare() does not
> clear panel->prepared when the callback returns an error,
> drm_panel_prepare() would then return early on the next call,
> leaving the panel powered and unable to be re-initialised. The
> converted code always asserts RESET, disables the regulator, and
> returns 0.
>
> Also fix a typo in a comment ("Enabe" -> "Enable").
>
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>

Patch applied to drm-misc-next.

I can't test it for the moment but that is no reason to hold
back the patch, I will deal with the fallout of there is
some problem!

Yours,
Linus Walleij
