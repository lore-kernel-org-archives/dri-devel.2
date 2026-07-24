Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D6FC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EF510F414;
	Fri, 24 Jul 2026 15:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ldq0MjO0";
	dkim-atps=neutral
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC9110F414
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 15:24:57 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-5c11362f67eso349754e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784906696; x=1785511496;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WxrbqTrV+sM8YYm6HDZyNJX/3RwO4LJuOffyvuKgA28=;
 b=ldq0MjO08qkEEB5zoUZPeWOJwLwwTMRZMheaQmeyxCYsAaFzIjNt9Y+O3sfP4QMBxN
 XKnG4apzxDCudWECocB7r8Y2PHZ2pCXoAbDZ1JPzKrPKZTzOqtiLN+0+2Jmr+WpL8l/K
 IJjU749WTG9gLe7LAm1gaTm1i9KYmuKGY3DBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784906696; x=1785511496;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WxrbqTrV+sM8YYm6HDZyNJX/3RwO4LJuOffyvuKgA28=;
 b=U7l4nWl8wJM1u4zJtKINKrk3JiRkHqNObsLizgFo5ApDDOUOVmgQeSgebR37WtlJUX
 s6d2DUys7MR/I5roFXEwlvK1vefvDI+onjm0HQO6fw4ypJcg/WoYZDOoNYWxt04WmrGO
 SMvgIF9no9VBqHPpTF5ku3XMftAoeBfM+uytciw0Usx4HEy2NlcMHcAQDk8QH1ruVqiR
 2dhP18POYLKISjiEcOVowEPYHJOHvDTqypvhpI7KWUS8jQRMbNXSHMr1kRobjWeaQ9W+
 s7ldJzz9tYdVbLmTHN0SIuQYUlQkQIgiuPvrHybeZPsDcwyf6MH9v246kuR4K/U/Soey
 Xs8A==
X-Gm-Message-State: AOJu0Yx+f8PmdpPV9lbLBSuYzv8wAJ73jRTwbbqujyGHtNxn8vKO9bek
 LuFBPg6+SVFLjuoRp2jImVqNpIBINvF0X6zgRYhiMqlNfY0R4EXOieiQHPWWi0ayLWUEir1NebM
 NkLY=
X-Gm-Gg: AR+sD133eMDXa7663bcdWYZwrHhXxu0hESi4baEtWCtw3yWGUQATvTGQI9/tudH6HQ0
 n+gmIfyhpvYLOr1eclBsT7aQ5smyGV7m1pyzyNtmEsO3PHbTiJqTCnJlwbobofzvxP7cUV7uhzK
 /kZyP08CunEvKovJh3WHw/ArAJvlxOMo2nY2Rmo1vgQxv2oeB8z9/2SQ0jGe2jGsYNzS2e60RZa
 /wEy57/kYuffWHfU7rg+e2t1A/ORuz2d+1hNaOgzgwhBA6Z99UrBZWKFPV22LevF+8P/nvEMlZq
 rWuYjSWZiwfQ+ThrmT8+DwYc6WnQTb7Nbp/+3GjT9CTjwlMzIj7vcZt3ZeQYy2QGwGm7Zk/wD58
 K5RFUVXTiZl0kRrLjVll1nX9QaxME8o/72f2oWH4ethvGZ3zMoAbhe67t9iOxzlqudIf9UAq3vE
 oqk9KAQjf+UWdAvdkKnaaXhNpWo7DecDVGI3H3slaPbsH/64XxGBTiKm4=
X-Received: by 2002:a05:6122:c9f:b0:5bd:9c71:11e with SMTP id
 71dfb90a1353d-5c2d9ffb5cemr3962744e0c.4.1784906696401; 
 Fri, 24 Jul 2026 08:24:56 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com.
 [209.85.221.180]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c2c648704dsm8917491e0c.12.2026.07.24.08.24.55
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 08:24:55 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-5bfb5e20a90so336229e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:24:55 -0700 (PDT)
X-Received: by 2002:a05:6122:3a12:b0:5bf:bc5e:e24 with SMTP id
 71dfb90a1353d-5c2da190750mr4006714e0c.12.1784906694203; Fri, 24 Jul 2026
 08:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <697e79c2-98a9-4bb3-b5fb-db327cbe1bce@gmail.com>
In-Reply-To: <697e79c2-98a9-4bb3-b5fb-db327cbe1bce@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Jul 2026 08:24:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UmtBnHuOc6oFeKAPrZSeAcx1EcjMdfm+FDV7uZgxa=zw@mail.gmail.com>
X-Gm-Features: AUfX_mwN1qlPszmdoOZKZ_iKUWcywWzYc6MnS8AZono-54q-rdyQmdbfp4qlkP8
Message-ID: <CAD=FV=UmtBnHuOc6oFeKAPrZSeAcx1EcjMdfm+FDV7uZgxa=zw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add BOE NE140QDM-NX2
To: Weiji Wang <nebclllo0444@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Jul 24, 2026 at 4:55=E2=80=AFAM Weiji Wang <nebclllo0444@gmail.com>=
 wrote:
>
> Add timing for BOE NE140QDM-NX2.
>
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 09 e5 f2 0a 00 00 00 00
> 20 1f 01 04 a5 1e 13 78 03 ee 96 a3 54 4c 99 26
> 0f 4e 51 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 60 d2 00 a0 a0 40 32 60 30 20
> 35 00 2e bd 10 00 00 18 c8 9d 00 a0 a0 40 32 60
> 30 20 35 00 2e bd 10 00 00 18 00 00 00 fd 00 30
> 78 c6 c6 36 01 0a 20 20 20 20 20 20 00 00 00 fe
> 00 4e 45 31 34 30 51 44 4d 2d 4e 58 32 20 01 f8
>
> 70 13 79 00 00 03 01 14 30 69 00 05 ff 09 9f 00
> 2f 00 1f 00 3f 06 31 00 02 00 04 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 4d 90
>
> Signed-off-by: Weiji Wang <nebclllo0444@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-edp.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c
> b/drivers/gpu/drm/panel/panel-edp.c
> index df7286679446..9e0981ecbc1c 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2031,6 +2031,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ae8, &delay_200_500_e50_p2e80,
> "NV140WUM-N41"),
>       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b09, &delay_200_500_e50_po2e200,
> "NV140FHM-NZ"),
>       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b1e, &delay_200_500_e80,
> "NE140QDM-N6A"),
> +    EDP_PANEL_ENTRY('B', 'O', 'E', 0x0af2, &delay_200_500_e80,
> "NE140QDM-NX2"),
>       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80_d50,
> "NV122WUM-N41"),

This is not sorted properly. 0x0af2 does not belong between 0x0b1e and 0x0b=
34.

...I could fix that when applying, but I also have a question: do you
have access to the datasheet of this panel, or are you just guessing
the right timing by looking at the nearby panels? I assume you have
this panel yourself for testing and confirm it seems to work OK.

It's fine if you don't have the datasheet and are making guesses,
since acquiring the datasheet is really hard for end-users. ...but in
that case, I like to at least document that fact in the commit message
so if someone later comes along and proposes different timings (and
they have the datasheet) then we can figure out how to proceed. :-)

-Doug
