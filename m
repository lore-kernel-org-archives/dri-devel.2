Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31343606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=R402cb1w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E91A11260A;
	Fri, 30 Oct 2026 02:09:39 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B3711260A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 02:09:33 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c445c95d553so20101166b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793326172; x=1793930972;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3f8Alqi33WDsSDA97+17FwHsG2CjFesCRiSUJANPSrA=;
 b=R402cb1wcWX0i5wXw8cVFg7HVZBO9ZnZDPsrfrgyPP6yqzjmY/A8p0pI6HzZ11m+lL
 wJy+epwfBBXN9oOI1mRQzTguY6mE6vPUqEk2lB9htrFxd5qDoZLRINQ25r3TGtSxibP/
 Iw2j7Msg+gDxC6HdmFmrUyi9s1QV4m9Z4YN54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793326172; x=1793930972;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3f8Alqi33WDsSDA97+17FwHsG2CjFesCRiSUJANPSrA=;
 b=cPla3V2apjT5BdsNMHrzeXrOxCkPfJ05CEU4eaCeKa6nUDDDY5hMjOBMcYjdrzI0en
 1H1fRP5Ld4I6kR/ukO3y1cW2WEhCaXFfzBKujeSjxU321nNw6fLFGun05qd/GXp1ZYS5
 sK/Ds5xJudKWDMRkdluDbrSz2/+uq9LO4sLhaeJyaPUJxoV2GHTeq/8A1SByxA7tQbFo
 r8UQwyZTuIb9vduDT4bZ6OY4xiTBDbKSS1XCAp7+ZT6QF1ntQYi0sSJMpLf0sabSssF5
 vHx1VHLZ4LQIUbTmxgb9nZfySCa/wZXi0UIxv4UskocfH80hX5DHMtqVLMsitBQ0w5Cd
 sZpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhMxKh0B/e2bRecLtveBJ5WBpyGeoedlWBx2NQIPHzobIB+sTzadZadLtyCMAnmG04gaIF5T7RVFY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJx2zLSNfMzItPzSeL1VTSmM1nFd+Tum4LCaPVbXSXScwgRiph7
 7tyRJiQ2H/+OfAhKvwAl+kS2L2fkFpl5THRNk5V6zN8mar08GlVfklFV5laVHBLZJp6L8UKX+Da
 SaVnNPevI
X-Gm-Gg: AYBFou1gPEa5jfiVMUTIze2wmLl+WNOv2sL6lhEPJwbVz8XwpMm3c65Lu7jWnR7mlno
 0ydKDxWdWLskpnpkt/0+G6o2BfuxfTp1ATxdu1j3wqoGsI0qBGDKbgDB4nH15S4q+xeuOtx2Gzl
 nP7fQuWIztOoIl67YaOjngQGslmgrNL0lesTyxzvy1w+2ZBc418uSzVnDQKKx6yWZnEDbN3mchn
 Lzmd2SExoaGdBi7SbCn6KggAvTgxjI/Ysp2yFvImzyTOxofn0lVGC3EVkN3OluBH2v4THcaAAl8
 ojig3T3bfZhnjruREWXU6FGimYR0aZJctg0nxjqfrujcPRoETGQo8amM8wAvIqEUiy0fHWb13Vd
 pBQ+/cQpVsW9UhuJdfRGVCweiWmXP6TbZEMUzjckkEm1XKw7NlKYQNsXLh5gT/Gru/F/VfNhylB
 4APx6q0tYLKhKO8Fkuh1/SDfOsi10wtMUNMyi9SYnouwqm8qewxmII/lgOW6lK4VAQpY4PEg8S7
 3j90xzrzWAZj3DnEq+6T1mBLuC29CnzbJh38ySE4Lzlw5SZ1U6/38hVgGfS5e/AsPsKP9gfZtXd
 7NDOiLRaWeEqKWoWydMt8U2FPuBwcueSXTr9m+AS5pur5M1VZsyqKJ2e9rivDwds7Usr
X-Received: by 2002:a17:907:1ca4:b0:c24:adf4:5c73 with SMTP id
 a640c23a62f3a-c4ca795d0cemr65224866b.1.1793326172287; 
 Thu, 29 Oct 2026 19:09:32 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com.
 [209.85.128.42]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4d7b1c592sm164368a12.25.2026.10.29.19.09.30
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 19:09:31 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso1424665e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:09:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwZ5iMx/DSDjWlubMi+zp3NrCZpzIBP7Cfa2PUqH/EHY/d/dVVqtx7nKikEyDKKtD+Mmv1WJR41HOU=@lists.freedesktop.org
X-Received: by 2002:a05:600c:811a:b0:4a8:c6a0:c08f with SMTP id
 5b1f17b1804b1-4ac18f529cdmr13893965e9.35.1793326169533; Thu, 29 Oct 2026
 19:09:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
 <20261012-mipi-multi-series-v1-1-6a29add1ec92@gmail.com>
In-Reply-To: <20261012-mipi-multi-series-v1-1-6a29add1ec92@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Oct 2026 19:09:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UT-8tXiJ6pCDb5rNqYtjjt8O9BXSnq5_2KdcexypdGfg@mail.gmail.com>
X-Gm-Features: AclHuK9Lk8qycxKtqnsrnc0uyYp-YXlQDmL0zIXeSRUqf8YmcBt7uHhJBX5-eAg
Message-ID: <CAD=FV=UT-8tXiJ6pCDb5rNqYtjjt8O9BXSnq5_2KdcexypdGfg@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/panel: leadtek-ltk500hd1829: Use
 mipi_dsi_*_multi()
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Mon, Oct 12, 2026 at 9:35=E2=80=AFPM Akash Sukhavasi
<akash.sukhavasi@gmail.com> wrote:
>
> @@ -535,27 +533,17 @@ static int ltk500hd1829_prepare(struct drm_panel *p=
anel)
>         /* tRT: >=3D 5ms */
>         usleep_range(5000, 6000);
>
> -       for (i =3D 0; i < ctx->panel_desc->num_init; i++) {
> -               ret =3D mipi_dsi_generic_write(dsi, &ctx->panel_desc->ini=
t[i],
> +       for (i =3D 0; i < ctx->panel_desc->num_init; i++)
> +               mipi_dsi_generic_write_multi(&dsi_ctx, &ctx->panel_desc->=
init[i],
>                                              sizeof(struct ltk500hd1829_c=
md));
> -               if (ret < 0) {
> -                       dev_err(panel->dev, "failed to write init cmds: %=
d\n", ret);
> -                       goto disable_iovcc;
> -               }
> -       }
> -
> -       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> -       if (ret < 0) {
> -               dev_err(panel->dev, "failed to exit sleep mode: %d\n", re=
t);
> -               goto disable_iovcc;
> -       }
>
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>         /* 120ms to exit sleep mode */
> -       msleep(120);
> +       mipi_dsi_msleep(&dsi_ctx, 120);
> +       mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>
> -       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> -       if (ret < 0) {
> -               dev_err(panel->dev, "failed to set display on: %d\n", ret=
);
> +       if (dsi_ctx.accum_err) {
> +               ret =3D dsi_ctx.accum_err;
>                 goto disable_iovcc;

nit: In the whole series, I probably would have removed the whole
"disable_iovcc" label and then changed the above to:

if (!dsi_ctx.accum_err)
  return 0;

That being said, it's a matter of style and what you have here is also fine=
.

The patch looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Everything being equal, I'd land it in ~1 week or so.
