Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB3DC44529
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F9010E1A4;
	Mon, 20 Jul 2026 19:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BYlG1GdN";
	dkim-atps=neutral
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01ECF10E1B0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 19:55:21 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-5bfb5e20a90so4469325e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784577321; x=1785182121;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JoPFWF+KnPKGg3Z19AiTc20idN61CkzTdQo930Ovmlw=;
 b=BYlG1GdNwkcrvD/62D1jV2/hf0nkPpXJjQssb90riCUIBsS7e9vRpvA7r4zAPXFtyc
 QZmXa+NB6wqiZG7zW1PFmhvcvdP1ttqFiBa0o0wHipZuyaxZnGBy2pQR0aJIz3W2hLD6
 ANMwqtd5RVSsnRVoZQVrNgZeRKDBAxSWzYwuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784577321; x=1785182121;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JoPFWF+KnPKGg3Z19AiTc20idN61CkzTdQo930Ovmlw=;
 b=h8770kzWYXiHVBDmdU905ffSr9BL5mXce/QDS12CZiYZ/QvK8zW6jXWrSIDGm0QNmF
 n/8sb0wgJ17UAf8SSBrcp3VqD4Od+THGkCk4eioEMjB6cePAOo+lURaD5EH1ALVYe88H
 zWXtYdW0zeWqClEMs9QH9l2dWUVzGVlYpOlYfCGIHnnxHJRNmgvp+/pKLru0zkgqTxKc
 YucmxeHk2G0JbcHMtcsimnx26bPzmsIR/TqEeBreJ80SNo/t7HvHBYO2COx+qyQVU/W4
 /bLC84ZJs70/8V9z9QHXzyOGWac+xrz/DjCsK3Sb3wuLWMgkUg0JSPWT6JcyY30am/H6
 3Jmw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOjHDkHFNivJbclcYdvhKegSqYHpuJpQLPW+kTjFzAyfE2fbiJfVNlhc+WdqMXySQ21krQ438po0E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXrkmv2ZA5GVjk3OiEwLt3VnYkAqJVywzKvwVInsXu8qGt9UWI
 E9iRe7ntLMV1dSxRh888x7qju8d3JLQoVG+2x8aOvzgiA1ptUs9m0lyk95b8t4wHPur4+j2JPIk
 cLAA=
X-Gm-Gg: AfdE7clDpOpZS4jd2qKitDP1tPKXtboTuWv7jjqav8Kjz5+QX1POdxHLapR6lj9FBoV
 heowgnTpnglz7LfZfOAmLJHC3CxwTdjHwLZYDTSifg3YIjkt3BVGmYFHVixpWOIhXXUrZFGDsUs
 jcMGWHJgOnUQejB0WMxVtkRQxOUJ7fo0440lxoJmimFPW+LGYZzlmMXzJfkGncnJ7vBTCVlHUfe
 xmApzppxP1DAEvyXKdoVey79yG45SpdK7/tSTaC/+57JqZhB6HOO0/Zo6V8VA+rvHnsIoMwhXUW
 wDIG6kLv0k8U4ascF/L7rw87bOx9j83Z5kn8nNWbRjDzFMi02xjCzyE7iiUFVnsSXDqHuWT0DAi
 fTh1lrS+p/RuADZRoKahI1jx7nHC3Snbu/AZ3qIfKFf4STGnd+QnHjkbjkKiYMhonmbh236GP8y
 iqXh6hbxmEquyZHhbXDygcGr4YIctaguQuroi2MxU7hCkSNth75sj2Djg=
X-Received: by 2002:a05:6122:1993:b0:5bf:bc5e:e24 with SMTP id
 71dfb90a1353d-5c1bf918022mr4007931e0c.12.1784577320697; 
 Mon, 20 Jul 2026 12:55:20 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com.
 [209.85.221.169]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c1f6b2a078sm10646209e0c.13.2026.07.20.12.55.19
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 12:55:20 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-5c276bd3692so1666380e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:55:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrSOOAXeqQU6xRm4fGStKIid+OGxZ8/NM95wiSKMKkWBiDah9p6iP82fxfPtnQqcEcrIaZTDp+YQMM=@lists.freedesktop.org
X-Received: by 2002:a05:6122:4f9c:b0:5bd:a5e1:c7c7 with SMTP id
 71dfb90a1353d-5c1b64a87b5mr4780104e0c.1.1784577318372; Mon, 20 Jul 2026
 12:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260720025358.2781136-1-dioyc_zhang@compal.corp-partner.google.com>
In-Reply-To: <20260720025358.2781136-1-dioyc_zhang@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 20 Jul 2026 12:55:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UEvKP1+EVtBgoGCDkTD9H+78yVT=1MR3LTFLqC4PaSxQ@mail.gmail.com>
X-Gm-Features: AUfX_mx_HrIcu8EeHasS6hDPycucVl01bGGpAeK3IaljELwaNd5jbW0V_tTnQgY
Message-ID: <CAD=FV=UEvKP1+EVtBgoGCDkTD9H+78yVT=1MR3LTFLqC4PaSxQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: panel-edp: Adjust T8 timing for AUO
 B116XAK01.6
To: dioyc_zhang <dioyc_zhang@compal.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, airlied@gmail.com, daniel@ffwll.ch, 
 sam@ravnborg.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, aj_cheng@compal.corp-partner.google.com, 
 ajye_huang@compal.corp-partner.google.com
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

On Sun, Jul 19, 2026 at 7:54=E2=80=AFPM dioyc_zhang
<dioyc_zhang@compal.corp-partner.google.com> wrote:
>
> From: Dio Zhang <dioyc_zhang@compal.corp-partner.google.com>
>
> Screen garbage or flickering can be observed during mode changes(such
> as VT switches) on systems using the AUO B116XAK01.6 and B140XTK02.4
> panels.
>
> This occurs because the backlight is enabled before the video signal
> stabilizes. Waveform measurements show that the panel signal takes
> around 140ms to stabilize after a mode change, meaning the previous 50ms =
T8
> timing was insufficient.
>
> To resolve this issue, adjust the eDP panel delay entry from
> delay_200_500_e50 to delay_200_500_e200 (increasing T8 from 50ms to 200ms=
).
> This matches the updated panel specifications from AUO, which now formall=
y
> define T8 as 200ms to mask any display abnormalities during mode changes.
>
> Signed-off-by: Dio Zhang <dioyc_zhang@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

A few notes:

* Your email client is still slightly misconfigured in regards to real
name. As you can see, when I quoted your message above it still says
"On Sun, Jul 19, 2026 at 7:54=E2=80=AFPM dioyc_zhang <..." instead of "On S=
un,
Jul 19, 2026 at 7:54=E2=80=AFPM Dio Zhang <...". In any case, at least the
patch authorship and Signed-off-by look fine. Just something to try to
improve for the next patch. ;-)

* The patch doesn't apply cleanly to drm-misc-next. Presumbly you sent
it based on an older tree. Ideally, send patches against drm-misc-next
for panel-edp. I've fixed it up this time, but it's an extra step for
me.

* Subject line only referenced one of the two panels. I've fixed this
up for you.


Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel: panel-edp: Adjust T8 timing for AUO B116XAK01.6 and B140XT=
K02.4
      commit: 0d40cab39158704e372240ed9821a00bfe117125

-Doug
