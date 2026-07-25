Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A127C531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 02:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F0E910E0CF;
	Sat, 25 Jul 2026 02:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J9XhQcgu";
	dkim-atps=neutral
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31FB810E0CF
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 02:15:43 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-97715c7df46so257720241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 19:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784945742; x=1785550542;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nqNPVvSW5V5bY/RZvF68OH9COyKKZVjvtcYkEWUBduo=;
 b=J9XhQcguTbJSqlPKHM150a2OwehDIOxatWeaW4uKTIgccd/HILNRe8vwrTdAOhNcAG
 M21RUFf6l1ltPGFfeoz1kNMge1n7tsS1wZTRyK0h5dGXcUlv1WaNKjX04rNEn5DSHCju
 ARFCN52KJCYzmofecd2oxrvSgIQjRLv56N/98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784945742; x=1785550542;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nqNPVvSW5V5bY/RZvF68OH9COyKKZVjvtcYkEWUBduo=;
 b=O+RO4mAyMHJl5Efg7I7ZHTKdfJHKI7008O1t1nfDuMlyXAr/RO713MSCCseQ8m4UZH
 iSLwSLHZ9Us2joKrZ4OFp8Y4IgRPWx5JpZ9ptJgb13O5hG0c4T6z+p5R6iZvuV6nB0BM
 w540aysUIteFBFa9IGLLv8UgYGYGXBEk5bBYHsKYzsSm02waoAq6904pp5BxOfGNfYOe
 0V95lSKtvl3xLld0U9aKJZpVblvLnoh5vYgaJ596we8/xNnC9Oi0XfI7LTF0zpekNySn
 8373O38Flo7AykeSahUWNhDPsrL+jK9pplAxZcjUZq6RnKkLmEh6OLfWMMyB82HjluDu
 z1Ow==
X-Forwarded-Encrypted: i=1;
 AHgh+RrO/gKGNSCK+0svuxLJ4gcZxRE3+pYJIMudwJyczSUM8KsXuOUF7TTa8CTMKB3PIX5LDUU5g+xMYSo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUJYqmL2Jv6BfLqEk9eIQZ62/ks94Dpr41uSgIhO4ia7Hjg4Ts
 hUAL6lzozu6/fm1AeNnQexA4yDYQaalZ1Qn/6rdrz73cIopah1JoUeGqnJMM6B04hx0a6PaHeaC
 AwJg=
X-Gm-Gg: AR+sD13+EFfLXKcuO3Ah+L6btbMVhrIUZZ6g6OwcRGhwk5LBxKrNMm8kaIzUdVqrrb4
 96oChJxWDJaGeNFu8++nVrB865u8R0+R1AEwrLWiw19s+cfMqsWVmMRqv6kLIg0LARgGnI3nBue
 ChBmcEwPgOXoqEdaPZNZaxxoJgGhJ+VmFvQFcDvyQ9gv1OEpiC5ZzBYPTZ7eCtrboRcEkGZjxBj
 fGo6eZmm1t0qbjnaxqGzMMAao4/W+I94VJLVVId+NpbQhIVzQjE0XUSNfR1oYdiwYs/yjihoC1w
 I3o8r9/X4Fe8+yEBGkt84YYHwGN6mj+5y9kO+F3DeWJmuw7Ne0tedlNR1XddS1lvxQMGR63qbAO
 CRppmVYYHo6TDG+tZYn7/PLwannrZe0hkUtScqLGyCNjCrfuNUI+JmI76MPN8hju65fI6YJetA5
 hSE64Om7yhZwlv03xmV2I9Vrrzw5+PSWfkTCLVEZ3lz3E791tyW9s=
X-Received: by 2002:a05:6102:5794:b0:74a:b5e3:e96f with SMTP id
 ada2fe7eead31-7503e26761cmr790080137.7.1784945741714; 
 Fri, 24 Jul 2026 19:15:41 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com.
 [209.85.217.53]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7503436f542sm565561137.4.2026.07.24.19.15.40
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 19:15:41 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-745497ac8fcso373524137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 19:15:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rokbqwu8CQXpaJE5JeZ0QtMf8whHatv6yWmrWvn2Cc9qvp3eoNc/C2iD0BFa5aLTmHRq9SlXFz0UXs=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3711:b0:737:f0ba:508f with SMTP id
 ada2fe7eead31-7503dc567d0mr833841137.3.1784945739245; Fri, 24 Jul 2026
 19:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260723203601.806697-1-michail.tatas@gmail.com>
In-Reply-To: <20260723203601.806697-1-michail.tatas@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Jul 2026 19:15:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+0_oVB2oHg=R+JAyFZFd2EXWAVhHv5oX6QGjB0RCKUg@mail.gmail.com>
X-Gm-Features: AUfX_myjo6U8AtleOEUxdwK7ailr_GVvsZOgZmUBfuocWHRjrNIT4c9QCnE8IrA
Message-ID: <CAD=FV=X+0_oVB2oHg=R+JAyFZFd2EXWAVhHv5oX6QGjB0RCKUg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] drm/panel: ilitek-ili9805: convert to *_multi API
To: Michail Tatas <michail.tatas@gmail.com>
Cc: michael@amarulasolutions.com, neil.armstrong@linaro.org, 
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
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

Hi,

On Thu, Jul 23, 2026 at 1:36=E2=80=AFPM Michail Tatas <michail.tatas@gmail.=
com> wrote:
>
> This series converts panel-ilitek-ili9805 to the
> mipi_dsi_*_multi helpers and cleans up the resulting code.
>
> Patch 1: Convert the individual DSI calls to their
> *_multi variants
>
> Patch 2: Replace the ILI9805_INSTR table with per
> panel init functions using the *_multi API, dropping
> struct ili9805_instr
>
> Patch 3: makes ili9805_power_off() and ili9805_deactivate()
> return void, since no one checks their return values.
>
> Michail Tatas (3):
>   drm/panel: ilitek-ili9805: Use _multi variants
>   drm/panel: ilitek-ili9805: Use dsi_multi in init
>   drm/panel: ilitek-ili9805: make cleanup funcs void
>
>  drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 212 ++++++++-----------
>  1 file changed, 87 insertions(+), 125 deletions(-)

Thanks for the extra small cleanups. Planning to apply v4 mid-next
week unless something comes up.

-Doug
