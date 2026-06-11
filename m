Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127D6CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6212A10ED5F;
	Thu, 11 Jun 2026 08:01:58 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBD810ED56
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 08:01:57 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-7dc67a5e102so79274237b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 01:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781164916; x=1781769716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wg1AD3f/1jWyYR3P0Z5p8wEPI+MYZzqh5FcI4v1k2P8=;
 b=Q+TP+mk3QWOEEuqL42h49jFVSLOfMJ2LGRUTgtoPslfvRZzRyRiMWDtXcwUCceBYLM
 oSX5WtAYJSWCyCS7/7E8azztOEPevgtkLnCeGy/wj4vfdYafuDW6m76ta1QgMOHkL5TM
 Bokwq4RIsoAb7LHYH1Sw8AGh983Hzk18vx4Y5IZ0PPetDqnm4jf47tEl/7GC+TKO9OMR
 +XIg1NDiQng7PiekOpQ6V7JEqCe1NiDeGMO8kQZ71QZz/qp5rW0xzqDvHU3IGRTnyU8c
 rb0bt5RApxy3+/WO6kFrHm3oA+xlK+cWGDXbWlu4xvXmxMLI4aUCYp9jhE4o+q+pELeZ
 NcLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jb86onX+m0IEvHK2YAkbDbncI6kCioa+gax+/oIaUMdgbXJWz2yyx8YYj/nXm3+dM4G4RI8Uufxk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxOZzGLwhdik12JzDhm+Zc9gKvKUI+ZFJbHgCQbJXrTLtuqXUh
 4ugzkQyNimBxthfNz7rzpJYMtGltkD/j1VaV8ug6lIfZsJN4V/7LEGjNPJMlbUpB3kI=
X-Gm-Gg: Acq92OH+mC7TF6n5O8yyH071TotHcs85UfwzjpNVDjIcxV8l5qWZh4h4vyqPhhnG/sj
 IpmQpcLgKqo3S6l9nofqkY/irUiCbeAv94TgxJvjpBxgXpgR+S6HDepBlqAfNAUgsgI3QP8H5mk
 +IOF2bknAyGggRs55GYiv0lY6h/nlBt7VVGUPA8KZ8/poc1N8Y5LULVZ5J5uVBrUNnPbz2j0IFS
 GUUR62Ew6HCHC1xFgq5qPV1pXZCjxSFbTnVOxdksPTyUvMiXINfsonBcEQjSca+3/cwB79Ugfc2
 fniS7FfsCVe2r58FGzdVxy709X6Q0Q1nMtitWrAMwrpvMg1uzgMr8AZ6dNCDYJm+M8tbyDFVCLU
 E/QWB0Nfw0a1pDmfsjUAUPqw9ytttVVaJ7JKjMWuuyziL4q/GQenSQXqpJv1xWi2YbJn82xMSeI
 cQvhM2Bc9GGaiv1JEhttzUTUB3wqZpkSXoC4KVfrJHN/lIK5wVVhT3CH0v1lOHs3fHtIi2To2oY
 1w=
X-Received: by 2002:a05:690c:e372:b0:7c0:56f:5b70 with SMTP id
 00721157ae682-7f656ea3c44mr17401777b3.29.1781164915876; 
 Thu, 11 Jun 2026 01:01:55 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com.
 [209.85.222.181]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d1e8777a69sm11773886d6.21.2026.06.11.01.01.55
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 01:01:55 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-9159951f05aso884842485a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 01:01:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+g1fmNCwOaHeMDLfCPGa5MzA1RSkq0HClFRzgxsug1e4lkbJksxRT+k8t65xoRW20eYqCuqw89hnM=@lists.freedesktop.org
X-Received: by 2002:a05:6102:54a0:b0:631:28c1:155c with SMTP id
 ada2fe7eead31-71d5d8a78fdmr441637137.7.1781164516527; Thu, 11 Jun 2026
 00:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260611005952.146825-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260611005952.146825-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Jun 2026 09:55:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVkxCo3p6SEB4a=wUY+qXE9AxqmYtsGyLH_+wb_e328Pw@mail.gmail.com>
X-Gm-Features: AVVi8CfMFk11kDzU1W7A90vpbtR6Nnss2ELpEbzCC4jdTDTJHmSm7MM16QZwFsU
Message-ID: <CAMuHMdVkxCo3p6SEB4a=wUY+qXE9AxqmYtsGyLH_+wb_e328Pw@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: renesas: r8a77965-salvator-x: Enable GPU
 support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Frank Binns <frank.binns@imgtec.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Magnus Damm <magnus.damm@gmail.com>, Matt Coster <matt.coster@imgtec.com>, 
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
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

On Thu, 11 Jun 2026 at 03:00, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Enable GPU on Salvator-X with R-Car M3-N.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
