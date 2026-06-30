Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81D0C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 16:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3367410ECDA;
	Tue, 30 Jun 2026 16:59:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ohvj0n3K";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B041510ECDA
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 16:58:59 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-92e50c5d14cso158736585a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782838738; x=1783443538;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Hla1N3iLWuVGDovRb/Td4EjEutJfNb9E/3Bx7pTshg=;
 b=Ohvj0n3KVEb8YTXJ0pZpGFXmrVDIcBPisLT5h65eVx0Gtkw2TwMAc99Y5V1lWma8pc
 rpm6iWivdDSMyK8Nildbo6dWQVVMS+kN+gU8L8FnkHgtdKWlTvGBQS16hJJgx1/Jwf7y
 hdwHuAsQuZb3ngw0hCE4toKq7ZNT6SYWV4HCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782838738; x=1783443538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Hla1N3iLWuVGDovRb/Td4EjEutJfNb9E/3Bx7pTshg=;
 b=d8vM0pRejTG4fM/YABeGcP/bT3GjbEz74lm48xAcrTqHBrnPE91O06hpgfpkq3oTMb
 rYOxDLLyJT+ivDRbNked1j2KeGB4MxcUBO0U19tjv/CsJoxFTxiUcz7B05DoWiMoWGlA
 WQQHa8qtPo6gNUFPzEQuG9hPlVgN9PIUuQC3C2zekYJR3lLPwmTVjwytiQkfc8iXx0TZ
 j5hr2sOVJcrZhtKCwZ798Fe1ov1j1UrcYnfR64YGHBFzWTRWS5ikULN9E8849DwiC3l1
 pI6CjFNeuKrqs+nZT9ijU9E3rwyZX6+VVKtzvCoxGcbWBLHNrmwc7zhlW27WHX2U7g9z
 I/cA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9omszQ6MiN9//t2dWNdQdcRlUnJnx1D1IhdZJ1mbQz/G3wpsbr9ZLe49fu/HLuFnUcPI+V9sHeF8M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqmI1+La/m/bwApcSULHq0srUGlbF8RYYgHe3dboj9Nv6W2HEc
 FNTi/dEHVxHcSBNsb7IkxDU205vj0jhvLWN82jJH8a1wJoOHoQaQBQEL3ws2lSlmmDrvAr/gypD
 4NiA=
X-Gm-Gg: AfdE7ckKrsOk7nFXmUZEB5wpz95fu1gKV+gvFEePoi1/PMteutTml9WXm8ZZGydYlXu
 4pwI2RoEGk6ZlHu5nggh+EEScfuJadifvqzh8E9E4ppBe1Ht0J/DNmfS/eIj7IXWtAC851cJgZa
 sbRSr5iNxPOWD60KTVi/zP2qZeLRzoiESHFPoMQ+egJSKoebd94PBlf1iJlslBOtolrEfQTENOP
 YPoDtVxzYYiaBtou3Tpzpe9UAKQ7vBxLVPkHtqvocmNSFdi1Q5mX9u+V2o9slBrnnzLvkfvPZOQ
 xo3xQ6UzcC3ep0kda1bcs2DATe3wgtaH8pbW9VUk0PPSn0D5kpP04YItlXmngI53O+i2DAozr+u
 9peJl4Jm7R9sgqQaNR5jIbllOtk0aZ09/OPlyHi0yRWRAxTRl5mLl8RYN1PDeDYtomR5Xp8W+wO
 QEf3ke3o19Ul/UxiVEUIUc81BMecZ8JaeDv3JZDO6xjPrQnaruJv0=
X-Received: by 2002:a05:620a:2904:b0:92b:6805:91a4 with SMTP id
 af79cd13be357-92e62a94b8bmr705467785a.60.1782838738488; 
 Tue, 30 Jun 2026 09:58:58 -0700 (PDT)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com.
 [209.85.219.42]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e622e87a7sm294565685a.28.2026.06.30.09.58.56
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 09:58:58 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8f0e5e36912so16867466d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:58:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrNyjDfnsYDz3WOmc5zY8JsNLtMKXf1TD9iDI4Y+zazbM1OCU00fI75rrs5hILjAL6zby6faO/+xEU=@lists.freedesktop.org
X-Received: by 2002:a05:6214:8097:b0:8ef:91c5:8edf with SMTP id
 6a1803df08f44-8f1ba59f354mr55990886d6.21.1782838735273; Tue, 30 Jun 2026
 09:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260625071916.744686-1-damon.ding@rock-chips.com>
In-Reply-To: <20260625071916.744686-1-damon.ding@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Jun 2026 09:58:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VFmSe8DcUYkxuvcs=OAHX34wSmWVSNcC36GSfeaPnzbA@mail.gmail.com>
X-Gm-Features: AVVi8CfI6AR_CrqOUzHEt_NUG1m_PuLe797jXm8_GYkF3H7SjTcNh9lhrISWZQA
Message-ID: <CAD=FV=VFmSe8DcUYkxuvcs=OAHX34wSmWVSNcC36GSfeaPnzbA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel-edp: Add BOE NE160QDM-NY1 panel
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Andy Yan <andy.yan@rock-chips.com>, 
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

On Thu, Jun 25, 2026 at 12:20=E2=80=AFAM Damon Ding <damon.ding@rock-chips.=
com> wrote:
>
> Add an entry for the BOE NE160QDM-NY1 eDP panel. The panel's AUX
> backlight functionality is verified and working on the RK3576 EVB1
> board.
>
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 09 e5 85 09 00 00 00 00
> 1c 1e 01 04 b5 22 15 78 03 7c e5 a4 55 4c 9f 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 6b 6e 00 a0 a0 40 84 60 30 20
> 36 00 58 d7 10 00 00 1a 00 00 00 fd 0c 3c a5 1f
> 1f 4e 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
> 4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fe
> 00 4e 45 31 36 30 51 44 4d 2d 4e 59 31 0a 01 ed
>
> 02 03 1d 00 e3 05 80 00 e6 06 05 01 6a 6a 24 6d
> 1a 00 00 02 03 3c a5 00 04 6a 24 6a 24 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add BOE NE160QDM-NY1 panel
      commit: be4f10d44757211fd656fa57f37034657f26c883
