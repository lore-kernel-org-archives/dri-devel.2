Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5566C44529
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4825F10E16E;
	Mon, 20 Jul 2026 20:08:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BYJzbwZA";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B674A10E16E
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 20:08:14 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-73a442f7cd3so4435173137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784578093; x=1785182893;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qZK1H78g4ElM4lCk4yo6u/+rQvzyoecCzo3mQeXpIGc=;
 b=BYJzbwZAChGeTBdRS69P2etNlqUokrQ06JdoRdH9JvgwJzejqI/7Tp7TVFGgqmbYEq
 upxPe2d6oxNd/SzuZ4IdElg5hk4Yu/TVqFGbPlfhB49quuP6RpyUXQDoi6AzL0ncOQnN
 8f68M9kR7V3kQAggzDoNjiAYHYOhLWJaggslc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784578093; x=1785182893;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qZK1H78g4ElM4lCk4yo6u/+rQvzyoecCzo3mQeXpIGc=;
 b=hRSjs7KiOTgmXwsYb04JLRa62hQoP8MD6jnIs+A8waumieEjXM0Dk8L33/FFfgnfO3
 MOqQgwu4jE8B+Wxg5yvaDqrrUJDehAjT4xTXiQZiNPlZVpIBAuUnTGRc3tSlA5Ew/oqY
 nGp3O69PsRuemU7z3t3JZskrj/WpQdignf7aFEL79aItq+Hfkqy8ErKqghStU+zGTzuj
 j8Y/FMdTnhSZtnwhZGP7uMeMfKGg4kTw7IwOpyf1TEFbhV57FpqeoAFSVVQFTgJLOmMF
 H5muK2Ko4WBBPFc2ro/CjbRv/fviSuL4mhotPvfXolv8yVQdraULqyPiJPMFOEPot70m
 +kZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJfDD4QMB92H1SH+4g+PjK/mCu1YrdY32iZ1B9vVTYYCyoxZzNCMQZMSYsKLgKgrOCkDMZLfHKUQY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMvEI+Pw6xeWIv+MJd6B+uRkB87DDksBdDEMXRHQEpxL4EaRTg
 nBQ54i9Lx4esBRW8E4tcy6yUR5K4iHrzbdop3jMYs1ybWe4O3o1BBL/HMKe8L4Y08EbfgahEEeS
 Kn6Y=
X-Gm-Gg: AfdE7cmI814Ir0w+H9j27e19Uy2zQ0togYLY+rGY1LVKQqxlQt2DK6yeBxTlUaZRbfR
 KbFniClYmLntDVyen8EFKS4/5uO7KdXZWpC5sQDuqJKCTePmOjkntBIoOZAXpYCBYCjLMKmg+bi
 GI2xORUdgxAM4ENtF5nwo32otm26wiOIumL/SBD3BqvUQnpytqqFj3Hft5xVkV1B5VzrfkUV+Ds
 UctTW6zuxc2JB1gG54YCuy+hy3t0fW+TArDm32Cx7eXmI35Vov9xfwx1590hNAO6VxtvbtL1r89
 T6CiXKjclFfP1XjxO/hWbxOPKwZqq6q9tD12dBff6NoEOT0f+qV0pt0Fa3DhS3VyZRitWcIhKZX
 cuohx9PTNUGt/v9ivad+bBeOWDDENM3HF32livawNE6FsYqPU3pftjH59jEyNlP/L4NleMQJ7u5
 +D6QAVyl1tjQpHdTSRo1WprjkSEz43Yhow7aW7wlp8
X-Received: by 2002:a05:6102:b0a:b0:73e:9fae:5845 with SMTP id
 ada2fe7eead31-747531315acmr5052018137.0.1784578093471; 
 Mon, 20 Jul 2026 13:08:13 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com.
 [209.85.217.48]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-747581b09absm9425094137.8.2026.07.20.13.08.12
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 13:08:12 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-74a9ac9cda6so496683137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:08:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4I9/AJYHgRpLB+a7GsaM7WlSRTmF5Q83nWDYoLKbQMWH0FrUAnTRakNHeTnD+INxbdgeyylCdo+s=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3f56:b0:6c5:d55d:c096 with SMTP id
 ada2fe7eead31-7475367f1a5mr5667713137.16.1784578091050; Mon, 20 Jul 2026
 13:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260719190358.438699-1-michail.tatas@gmail.com>
 <20260719190358.438699-2-michail.tatas@gmail.com>
In-Reply-To: <20260719190358.438699-2-michail.tatas@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 20 Jul 2026 13:07:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XaLNRfgi-SR=+O2HPHEj9oZ7U=ZqbUMX6y+W-7hjj+iA@mail.gmail.com>
X-Gm-Features: AUfX_mzUZa-ii0h7Gki1poMuutlaV4wP4tRYvA2tsh9ShW9JxW2Dtj3jpHmM8OE
Message-ID: <CAD=FV=XaLNRfgi-SR=+O2HPHEj9oZ7U=ZqbUMX6y+W-7hjj+iA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/panel: ilitek-ili9805: Use _multi variants
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

On Sun, Jul 19, 2026 at 12:04=E2=80=AFPM Michail Tatas <michail.tatas@gmail=
.com> wrote:
>
> Convert functions mipi_dsi_* to mipi_dsi_*_multi as per the
> gpu/todo file.
> The multi variant of these functions include improved error
> handling.
>
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 51 +++++---------------
>  1 file changed, 13 insertions(+), 38 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
