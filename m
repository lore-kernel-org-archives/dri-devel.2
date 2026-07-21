Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423BFC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE1210E3C0;
	Tue, 21 Jul 2026 19:44:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GeuKFjwH";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C65A10E3C0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 19:44:28 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5c27e38ee18so1507077e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784663067; x=1785267867;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=peXYBmUmPf4ccVAD39jgFso+IzH3zKbnCN6+sTxaNBQ=;
 b=GeuKFjwHMHCZGR92T6I5Yi5WdiwRAT6rOjHZFUS6EyKTr/0LEk3kcpnQcTKtXZPCrJ
 CsDg/W0AtnJWje483X/sd4nm3CTqUDbbZCGa7ZJ7i8K6Fw0hSMXYR6c1aL6h5/LpLjT1
 jqxAX+AIFvi/MYZkKbZFvmpZ64xD0mihbPD6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784663067; x=1785267867;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=peXYBmUmPf4ccVAD39jgFso+IzH3zKbnCN6+sTxaNBQ=;
 b=fxVv2ibAhtkPVSpwwLE+oQXtcw/aOPUluYEhGVZlUsxh42kmHORKWJKLEGO7p0TK87
 aP2+etKM5E9dqIDQP+lc061iNzQJZaZnANPnxie86GsOYNSdSdA8XlcSUKDCkw8QNb6x
 vGaJ0cbCW7xtrCKJRBxmRCecP65kUFCa5ReL0w8mQaG8rmYkJTIqIPSQCc6njbSLMrzd
 GHhy2DQIeNq8neAjDvp0vDjHyNQ+IcpNCbIuNjJUfeMY0sCjaqo9CVSMR0XFGfoguqqu
 A05NVJTM2TzZNRciO7ELqsMsuyU60pjGlZlNH610BJAPntgq/ohTjZ1mcROouqRORx0Z
 hGSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoO6tUDAX+mazQPP9UcdQ+/ayrLIfqlMmldTrFVoF8PvRjMm75StzVysgAbPwWafOfJ6QKq1c+jg8g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9AFkeXP+CtxuHlwO2uhZbJqhF3oWm5n7SbjmTzpBht+NxRPlQ
 fCMZK9zOwXGbJD2pXD+FWnCgor4XJNlyvJZ482dFlH/hP7TDjl/ZZ1wkpJCUqaXw1rhUFYjNXLo
 5kpM=
X-Gm-Gg: AR+sD13grZ/NCkczNmZqNi3g/GgtB/SR5//QGoMFJ8WMwS9EjB3LHkW+Q71KYbfwfO0
 pKUNil5JYt6p17+NB6BjGQta8aqo+5FIGoZpeF9laR44QutUWgLSWLy85oI/oiGY0jzW5zHvqps
 +TVWKg7FIMe0n18ZVpE/+elU0Xi3XYlfrF2QjcVssd0BXGeoXLTu5dm6pycPquFfNZnygkz4LyC
 3VuhfUTJw+Y0Dakds7/Y4unJXq/WpR1oRLrOOTWDGTYoODfYfyhdxJvENFht1UmjZWHIWU9FBmU
 Emcb304zOZY0mViXn/MTQWAjSB4VcGf6HocqA6QT7vbloXjNTqNsD2Uxw3ng24U7DjyCwSEr8lr
 gAQHHl94XAZw0Rk/A3yuUxl05Fli5hTpwYOfg4rS4XVq1fQIPOHeQbVnNJEBPSBIPEY5ExWviFk
 m94NdjTprlcumDeFoWUnezeTljuniByPUJkVO4gS13
X-Received: by 2002:a05:6122:d90:b0:5c1:31ed:157 with SMTP id
 71dfb90a1353d-5c1bfa5cc5emr6765617e0c.13.1784663067300; 
 Tue, 21 Jul 2026 12:44:27 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com.
 [209.85.222.51]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c2c62b63cfsm490234e0c.5.2026.07.21.12.44.25
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:44:25 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-96935063700so2132703241.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:44:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqWNFkAVH385fJyr2bE6dYfzPPtTFeR9+hXhrSYVnJzmaaWoY4GiLHfptlmSJo74ZbsWC5TFtscIK4=@lists.freedesktop.org
X-Received: by 2002:a05:6102:689c:b0:738:133f:8d5e with SMTP id
 ada2fe7eead31-74753529dccmr6785664137.12.1784663064703; Tue, 21 Jul 2026
 12:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260721172715.602196-1-michail.tatas@gmail.com>
In-Reply-To: <20260721172715.602196-1-michail.tatas@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 21 Jul 2026 12:44:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsKrjivcg1s-YgD7Bd3Mw34O0sXfFCYRLO8r+9kENRPQ@mail.gmail.com>
X-Gm-Features: AUfX_mwyv4GYZICbf75vOtPfc7qWJSDRm4f5SevXnN_dF6FQfMGB5bFFwj4Rt88
Message-ID: <CAD=FV=VsKrjivcg1s-YgD7Bd3Mw34O0sXfFCYRLO8r+9kENRPQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/panel: ilitek-ili9805: convert to *_multi API
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

On Tue, Jul 21, 2026 at 10:27=E2=80=AFAM Michail Tatas <michail.tatas@gmail=
.com> wrote:
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
>  drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 211 ++++++++-----------
>  1 file changed, 87 insertions(+), 124 deletions(-)

This looks great now, thanks! Unless there is more feedback on the
lists, I'll plan to apply to drm-misc-next in ~1 week.

-Doug
