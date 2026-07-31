Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82A4C55174
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD5010F382;
	Fri, 31 Jul 2026 18:08:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hslNiFFe";
	dkim-atps=neutral
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D3A810F380
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 18:05:54 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-5bfbbe5220dso626208e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785521153; x=1786125953;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bb4QvWwAHqFNCcNYWl9lwKw4nEkehtkN8nMlMTo3FmQ=;
 b=hslNiFFeaR5HwvkNkBXGQkBocJOUs60jcefrl0aj8e8OF3GwBT0ZTxQt/Vh/VyqbWe
 1yJWLqqCoToWROAWXUXFApqpahrAeCElyWKqajdJ41yd/LvtUEDz6N832NZIonm/NeTD
 OHIJ1B1Sp+arx+OsdRBQtWbYl0q0u99CiXT6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785521153; x=1786125953;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bb4QvWwAHqFNCcNYWl9lwKw4nEkehtkN8nMlMTo3FmQ=;
 b=MoV3YjSoxhcriSrjCwIP7mmpbcnQAvTl2P3RrXWoEwIzL77AYIRN+5q5kyl+9rr4Fd
 sF+/JEzuOuHfCZQp4zVg77WPDigsvaUlEKcyjEgnoCcqbgliH9EATf+S5orFyU/uIhCP
 YxwGfFvOsUg2RQd4CclFnjXkUQoMA5O/WAud7tQeNLq2yvKIF+1n6dtImT14G8ugRwzZ
 fnjJ8m94nbizlGTV5nriFuDvVI5y2fHDZb6TfrhIPRhrFkYHA7sSXfFO9RipDacDptYF
 FOOOp0vfHt1kpy818FOYmR3j/X7WCgU0iVDO0s9tdjCkf6LvnqpmqlrR0x7VvOEgxQw/
 DIZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqweSE368h8Ahz7vj6Q4BflbaroSk/BC+abX1qhdH1Ts7kyMQ6r2MgKm98X+4cuvU0kOFp/32q18FE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuFxmmkNbDY+eKszjFqN2TZbm4e/tCWxMtT9cH17CViGGWdeME
 B2T1Zp+D7bvHq87E9CnJx2DQlNTfkjRBStwRnOonbwg52zsrH/noU61/i1R8nwyA1j+/NUs78Kd
 TA4E=
X-Gm-Gg: AR+sD13NyK9YF+PWGiVgg7zbJyl3dxieaOQ+69toQt/ayMm597OiY5U2O8MHL1LR5xi
 eSHs5mSdYuMcALAvgjZRp8gB1OVwoNoiQF67uM6v0/mF+pPPdHzLwg8sM4e0SqQjU0jr7MLQLf6
 +PgGfh8sHNenJYrwBzsXw4t69KBn/w30A3j8YaxdG1QT6PWtGcLWwO9BAcm3xDmbGfH/J1UBAlU
 2J0OwtBbY/g1c6lA7kKuMXy8SXaQ5OLRZ3GT0Zi/A+TKilIM9HTe0y7kvYMOXrsWl9ZJUaXasgP
 gkT4S5iSRQk+sIR3Qp3qZlvlllCmkN+8w3Doo+TvSeN5HPH/TaaPMXSp0WBz+7eUKBJRiDrAfVF
 MkkcZZ1sfczSbeR6iGEFKsuzB2UKoCgYJb+1AmfftCrnJoY94Whv3NRhnMCsZfJ/+3iCenzhKsY
 1esle7jGEMh5Kyp+Q3VWBZ46NhRfEdEKxWDuJvuVx3+GNQF/HNMeYdwvVm7JDcIk0M6MKCu83c1
 4ODXhuCWaJXEAChX+lJf1dSMSc=
X-Received: by 2002:a05:6122:2092:b0:5bf:6734:ff8b with SMTP id
 71dfb90a1353d-5c388490dfcmr303297e0c.8.1785521152874; 
 Fri, 31 Jul 2026 11:05:52 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com.
 [209.85.217.41]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c37ee0fff7sm1751980e0c.17.2026.07.31.11.05.51
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 11:05:51 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-75609e844faso715855137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:05:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rohesr3KFnyEcQ2NHSMj0bsX/z9Whd5WTMbiVfqn8iZrhllcak00uV6vD43AvnYCzq3PvwHRUumz28=@lists.freedesktop.org
X-Received: by 2002:a67:ea41:0:b0:745:36ea:415b with SMTP id
 ada2fe7eead31-758f886967cmr765986137.5.1785521150066; Fri, 31 Jul 2026
 11:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-mipi-dsi-tl070wsh30-multi-v3-1-60592caef4f4@gmail.com>
In-Reply-To: <20260730-mipi-dsi-tl070wsh30-multi-v3-1-60592caef4f4@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 31 Jul 2026 11:05:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U-qLBzkPDGPQ6N1ADbnNSM=tDx9ktt2bxmmreZ12228w@mail.gmail.com>
X-Gm-Features: AUfX_mztVxJik4nrquKmyrCPQ9aDhUIhkj5yyNimsTJtkQgbOxe6pEpn-Wk9WEU
Message-ID: <CAD=FV=U-qLBzkPDGPQ6N1ADbnNSM=tDx9ktt2bxmmreZ12228w@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi(); fix
 minor bugs
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
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

Hi,

On Thu, Jul 30, 2026 at 5:11=E2=80=AFPM Akash Sukhavasi
<akash.sukhavasi@gmail.com> wrote:
>
> The mipi_dsi_dcs_*() functions used by this driver are deprecated in
> favor of their _multi() counterparts, as noted in
> Documentation/gpu/todo.rst. The _multi() variants record the first
> error in a context structure and skip every later call once an error
> is set, so the return value no longer has to be checked after each
> command. They also log their own failures, which makes the per-call
> dev_err() calls redundant.
>
> Convert prepare() and unprepare(). prepare() uses mipi_dsi_msleep()
> for the delays between DSI commands. unprepare() uses plain
> usleep_range() so the delays run unconditionally after the
> accumulated error is cleared. The delays in the GPIO reset sequence
> stay as plain msleep() and usleep_range(), since they run before any
> DSI transaction.
>
> unprepare() now disables the regulator unconditionally and returns 0.
> Previously a failure of set_display_off() was logged and the sequence
> continued, while a failure of enter_sleep_mode() returned early,
> leaving the regulator enabled and the panel unable to be brought back
> up, since drm_panel_unprepare() skips panel->prepared =3D false on
> error. The accumulated error from set_display_off() is cleared so
> that the delay and enter_sleep_mode() are still attempted, preserving
> the original fall-through behavior. Both drm_panel_prepare() and
> drm_panel_unprepare() return void, so the error was never propagated
> to a caller in any case.
>
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> ---
> Changes in v3:
> - Update subject line to reflect the minor bugfixes, per Doug's review.
> - Pack blank lines in both functions per Doug's review.
> - Preserve the original fall-through behavior in unprepare(): clear
>   accum_err after set_display_off() so the delay and enter_sleep_mode()
>   are still attempted even if display off fails.
> - Link to v2: https://lore.kernel.org/r/20260727-mipi-dsi-tl070wsh30-mult=
i-v2-1-f47b937631d3@gmail.com
>
> Compile tested only, no hardware available. checkpatch and a W=3D1 build
> are clean.
>
> Changes in v2:
> - unprepare() disables the regulator unconditionally and returns 0,
>   per Sashiko's review on v1. Returning an error left panel->prepared
>   set, so the panel could not be prepared again.
> - Link to v1: https://lore.kernel.org/r/20260725-mipi-dsi-tl070wsh30-mult=
i-v1-1-69160b83982e@gmail.com
> ---
>  drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 40 +++++++++-------------=
------
>  1 file changed, 12 insertions(+), 28 deletions(-)

Looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Even though it has some minor fixes, I'll still probably put it in
"drm-misc-next" rather than "drm-misc-fixes". That gives us extra bake
time, which is especially good since the fixes are all based on code
inspection.

I'll plan to apply in ~1 week unless something comes up.

-Doug
