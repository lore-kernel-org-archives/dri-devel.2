Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A09F36C49
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 07:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01C910E695;
	Mon, 20 Apr 2026 07:46:34 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D607510EC5F
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 07:46:33 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-6058a955e04so1859902137.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 00:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776671193; x=1777275993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vr9++th+piD84iSgm0F19Q87mZM1OH80P77AJIEKCDU=;
 b=BhsxoiqFy6BmjwhQGyqtLUkADW0Njy+buoAcAu9/6EX/KyLOZLydiSa/Vcya7c2Iwn
 Pk/e+fMcrfYc95Pj7JV8p/IhrcHMD4z4jjcI4uJ4SEOxyhnnCfN/jnrcDyRycFPOvkeO
 y0PQsxl6p6S5cXvkYkUElnB+8i3sPkGV3kKKHVPw2KA9CFeHHd338Lb856iMkqwfptyq
 OBQ1c1JBMN0dVgCiln+03+EEHa2jvSdV5C0SUkkA2BlUvHmKEeGYF2yb8JKivn+VEDOw
 wsMT1A0z0CUW9a9+kKUPY77FPS0l+Zx9Ik6h9RoMX7OijHElesYOaSH0KCnlAs3xo2N9
 fslQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qry7uohR+rV5mdIbvjyBQpJeFliKRmBXbgWEkUkGSuqrwa+hY6g32AiqIisjaWbdoCg5X4diTy2s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1EjXER2UESlMKKNbi9Txyowm8W0itcaSmvVCPotA10nCqPqbo
 OCYanGQ0jFuXbMmUYvdelB9z9A2m61nceX2rLYB3EpnQ1pvcngalbRAJL5viVQmm
X-Gm-Gg: AeBDievm6dMGt+cpcESOiQOp6aL4a1yhA7qS3UN99lUZYXOXsmmz7MkQ6c+TUjTbzHC
 cIXN7dXlllMFYvIgn/Bx8KHumiyLeT0tIbbj+tEoHNbQ9IVWwXqFvLdz3xiLC2OTJzctA0/s0XH
 MI+FL113SF6Z90d45Y+Zx1j2A46EmcOy68LoZgWbAC8oAMs8IHVX/D6G/Fnz+furyWHwghCjR1y
 DLvPyiqxfMwgr6wRNoETlZNf/HQh1KEK4jJwjgGYnb/71EKo1JyBdGc5B5sifnMESYyN2nhI4ee
 +OsMBkhjPcwUqY/Q1QQnxV0ZgLekueIwK1BjPD/+1ooQvC8HBqym59xTkfkcs4wSmM5r+DXzi55
 N5A8AS2xCE0TWivL9eyQlGdc82uy5dm82Grh9yXq992Tg62yG0bfs4WDNeRsBHxMNkrbW5bkgBr
 xzv6CzjaivVnLzevCURVio89EWi0WD2NbPN2IpTFOQZjqiSNI0tcV6maA0P6AKUq3jpNxoJaeCV
 to=
X-Received: by 2002:a05:6102:801e:b0:5ff:ea89:449a with SMTP id
 ada2fe7eead31-616fd91d990mr3706603137.13.1776671192629; 
 Mon, 20 Apr 2026 00:46:32 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com.
 [209.85.221.172]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95890c0a526sm4262470241.11.2026.04.20.00.46.30
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 00:46:31 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-56d8a5f0e44so3487681e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 00:46:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/p+rpxoozdCC7olrBgk2s+vztV1SaoIGKqRzp4YoqxKZy7aY7JoYlX13kSreCi8MYX4C63jN2Yn0s=@lists.freedesktop.org
X-Received: by 2002:a05:6122:289a:b0:56b:9534:c06f with SMTP id
 71dfb90a1353d-56fa6542098mr3883427e0c.3.1776671190654; Mon, 20 Apr 2026
 00:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260417140231.3972749-1-chris.brandt@renesas.com>
In-Reply-To: <20260417140231.3972749-1-chris.brandt@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2026 09:46:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVCtzxumM6yniuGTKfqG_z6BuySHNcZYE9UHP5AuDoLw@mail.gmail.com>
X-Gm-Features: AQROBzBuq_XRHepFNQh1JPCL5m8jICz5bAQa5xeGTgiQQMKwx8PdJeiPrEwUY60
Message-ID: <CAMuHMdUVCtzxumM6yniuGTKfqG_z6BuySHNcZYE9UHP5AuDoLw@mail.gmail.com>
Subject: Re: [PATCH] drm: renesas: rz-du: mipi_dsi: Fix return path on error
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Pavel Machek <pavel@nabladev.com>, Hugo Villeneuve <hugo@hugovil.com>,
 linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
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

Hi Chris,

On Sat, 18 Apr 2026 at 14:49, Chris Brandt <chris.brandt@renesas.com> wrote:
> In case of error, we should unwind correctly.
>
> Fixes: 6f392f371650 ("drm: renesas: rz-du: Implement MIPI DSI host transfers")
> Suggested-by: Pavel Machek <pavel@nabladev.com>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Thanks for your patch!

> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -1476,8 +1476,10 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
>
>         dsi->dcs_buf_virt = dma_alloc_coherent(dsi->host.dev, RZG2L_DCS_BUF_SIZE,
>                                                &dsi->dcs_buf_phys, GFP_KERNEL);
> -       if (!dsi->dcs_buf_virt)
> -               return -ENOMEM;
> +       if (!dsi->dcs_buf_virt) {
> +               ret = -ENOMEM;
> +               goto err_pm_disable;

Shouldn't you call mipi_dsi_host_unregister(&dsi->host) first?

> +       }
>
>         return 0;
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
