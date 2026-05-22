Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5431CCD5BAF
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 00:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DEC310F496;
	Fri, 22 May 2026 00:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WrAhg8BY";
	dkim-atps=neutral
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C51510F496
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 00:37:53 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-5752b279662so2454996e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 17:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779410272; x=1780015072;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LUMpiHILSDr342cJwliQsBfCK3S53H08JsWrubXYcc=;
 b=WrAhg8BY1PMpZH5utbnVXuQpyqFs9WJiHRZCMUysgD8ZrAU59FTZ/8NQDnECtF5y4D
 jrqhwYrBB1vSWgr8s8ImFB4M445HkPdIVIcFOkHShGmWcXgQ1k1/wU5zEZQpHttPsoyO
 TqK1INho56Azbt0LI9wxC2et6JrpExYwCD3HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779410272; x=1780015072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5LUMpiHILSDr342cJwliQsBfCK3S53H08JsWrubXYcc=;
 b=OC7Qmo+qq/tZM+xoqaZRyEsFoEP3ZlrrRkK+trdZGezyqVwTiLYlzn1iVrgzFi3sDd
 9HZ36t2n/OgJ4cHhBVLPNQQkHVyxoxSCxnC5QYfvXqcDAn5B9RqL06nHa/ZVdu/91CBR
 scA0S/L5wOdXkL2wh7Rzs8f6BLO/0VKZ2mGfQ5e2/Zf0rLcNWqetU0rV650zTZCbjOET
 X0HD2VSZ51+WDJJ4lRm3CGMgpMyUWnGpKrGTntHO3dvSZbV4ezjlidqwTq080V8wHlSk
 SS4oWGnSb3YNLShH/+L83HYFaKfgKaN2cHvVVNmF3QvSFdgU3dPcPbJG1cOjWkE+udXr
 jTXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9gCKKq4ET/h+kw7YhCjYBoY7P2FKYnQP6Y+4ZA88xWunW2AUJxzH0iQU+UABGrYnaFoOF1Df9H3c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxamomMCYTmHAdgyDhcwaEO5i99q3a97GzlJ0Mer+8s9i7WYNp
 t3fKuC46assECam6E9gDLOLE+G1hAXUPeBiczDgUeRG6FxogIAHvOhEEjZgPA3QxsQaDqlUnoBn
 Bs3g=
X-Gm-Gg: Acq92OEumBcEmYzOY6A9x/RHBetldXXgn1b77RY1VqdMnlyaSSWo29NDHeqh6vnog/Z
 gnO1/CC6ldQqwQfwLjYilIZohP4DMrMXsMVnDlJpRf1HNcvUiewq8adZg3ayY+v8AuN/fJZ2P5b
 jLJ/hnGX6P6T5fmHhYe4zr9XMM3JUEX0CQ7XXIeNZwf+btQR7yLQEWQacjLVNoqZxiJvFLlb5/d
 o8mzdstSphQBnO2mORcX9YMCKqj8D9YfSECmXSCrp5AYNHicDb+HJz7+OqNDkjn3h4v0tKNlEs5
 /P62oA8HxD8FvUr6OwI/PdO+rFWveiik399CEgEguRJOVDaJeyhskPYv4ZZVfEWen7BhycRH3ZA
 rOpRGwHCjLuyvsX/1eCRf+5OKR0ldK5HVW+PnbbTTXgulAh1B6ByrrrN5/2I6rzwEgxq5+oFoWB
 MZaHmdmws9U1eanjfSsUcpT4qM/b4pb1flRK+Dm6rNN7fdGZEpozgj/hE7HnHnHzVGOV3Rw4sb
X-Received: by 2002:a05:6122:4581:b0:575:a5b5:3233 with SMTP id
 71dfb90a1353d-5865f154435mr868905e0c.4.1779410272193; 
 Thu, 21 May 2026 17:37:52 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com.
 [209.85.217.43]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-586f2f791d1sm381552e0c.5.2026.05.21.17.37.51
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 17:37:51 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-63270abd14fso2212383137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 17:37:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ++d1By8dR7ert9ISt4FZ1J7PeDKjalQPlkOg8oGYe/WSWLP7m8bMLMJHrWlYbLkNFk9Fcx7wVvgFA=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3f87:b0:635:1bc8:3563 with SMTP id
 ada2fe7eead31-67c82ffce43mr612153137.20.1779410270308; Thu, 21 May 2026
 17:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260518034252.16337-1-chintanlike@gmail.com>
In-Reply-To: <20260518034252.16337-1-chintanlike@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 21 May 2026 17:37:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X5rc3zponA7rOPyttv8U0JXadrkJ89S8O2M=ahGMinTw@mail.gmail.com>
X-Gm-Features: AVHnY4LF5tFChlHXSMKvBz2Dj0I0g_2G9EcxBaFz3gQTvzuur8gjxKwIgMxCkNg
Message-ID: <CAD=FV=X5rc3zponA7rOPyttv8U0JXadrkJ89S8O2M=ahGMinTw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: novatek-nt36672a: Inline panel init
 sequences
To: Chintan Patel <chintanlike@gmail.com>
Cc: sumit.semwal@linaro.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Sun, May 17, 2026 at 8:43=E2=80=AFPM Chintan Patel <chintanlike@gmail.co=
m> wrote:
>
> @@ -55,13 +51,9 @@ struct nt36672a_panel_desc {
>         enum mipi_dsi_pixel_format format;
>         unsigned int lanes;
>
> -       unsigned int num_on_cmds_1;
> -       const struct nt36672a_panel_cmd *on_cmds_1;
> -       unsigned int num_on_cmds_2;
> -       const struct nt36672a_panel_cmd *on_cmds_2;
> -
> -       unsigned int num_off_cmds;
> -       const struct nt36672a_panel_cmd *off_cmds;
> +       void (*on_init_1)(struct mipi_dsi_multi_context *dsi_ctx);
> +       void (*on_init_2)(struct mipi_dsi_multi_context *dsi_ctx);
> +       void (*off_init)(struct mipi_dsi_multi_context *dsi_ctx);

nit: The name "off_init" sounds a little strange to me. Maybe the
three functions could be:

send_init_cmds_1
send_init_cmds_2
send_deinit_cmds

...or something like that?

> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x22);

nit: I wouldn't block landing the patch for it, but since we're
touching all this code it would be nice to make things lowercase hex.
0xff instead of 0xFF. That's the kernel standard, even if there are
some drivers that violate it.


> +       for (reg =3D 0x02; reg <=3D 0x10; reg++)
> +               mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x40);

So I was curious about if the "for" loops helped out. They seem to.

Overall, your change increased the size of the driver by quite a bit,
but I guess that's the price we pay since (when we talked about this
in the past) people really didn't like the table-based approach. Old
driver vs. with your changes:

$ ./scripts/bloat-o-meter panel-novatek-nt36672a-old.ko
panel-novatek-nt36672a-new.ko
add/remove: 9/3 grow/shrink: 2/5 up/down: 10430/-1712 (8718)
Function                                     old     new   delta
.Ltmp1                                      1292    4652   +3360
$x                                          1392    4752   +3360
tianma_fhd_video_on_init_1                     -    3148   +3148
tianma_fhd_video_on_init_1.d                   -     252    +252
tianma_fhd_video_on_init_2                     -     144    +144
tianma_fhd_video_off_init                      -     124    +124
tianma_fhd_video_on_init_2.d                   -      10     +10
tianma_fhd_video_off_init.d                    -       8      +8
.Ltmp8                                         -       8      +8
.Ltmp7                                         -       8      +8
.Ltmp6                                         -       8      +8
tianma_fhd_video_off_cmds                      8       -      -8
tianma_fhd_video_on_cmds_2                    10       -     -10
tianma_fhd_video_panel_desc                   88      64     -24
nt36672a_panel_unprepare                     244     212     -32
nt36672a_panel_prepare                       340     284     -56
$d                                          3555    3331    -224
tianma_fhd_video_on_cmds_1                   562       -    -562
.Ltmp3                                       804       8    -796
Total: Before=3D11206, After=3D19924, chg +77.80%

...but if we hadn't done the "for" loops, it would have been much worse:

dianders@dianders:v6.6 ((8953acf077cf...))$ ./scripts/bloat-o-meter
panel-novatek-nt36672a-old.ko panel-novatek-nt36672a-new-noloops.ko
add/remove: 9/3 grow/shrink: 4/4 up/down: 18380/-1488 (16892)
Function                                     old     new   delta
.Ltmp1                                      1292    7164   +5872
$x                                          1392    7264   +5872
tianma_fhd_video_on_init_1                     -    5664   +5664
tianma_fhd_video_on_init_1.d                   -     562    +562
tianma_fhd_video_on_init_2                     -     144    +144
tianma_fhd_video_off_init                      -     124    +124
$d                                          3555    3649     +94
tianma_fhd_video_on_init_2.d                   -      10     +10
tianma_fhd_video_off_init.d                    -       8      +8
.Ltmp8                                         -       8      +8
.Ltmp7                                         -       8      +8
.Ltmp6                                         -       8      +8
__UNIQUE_ID_modinfo_411                       79      85      +6
tianma_fhd_video_off_cmds                      8       -      -8
tianma_fhd_video_on_cmds_2                    10       -     -10
tianma_fhd_video_panel_desc                   88      64     -24
nt36672a_panel_unprepare                     244     212     -32
nt36672a_panel_prepare                       340     284     -56
tianma_fhd_video_on_cmds_1                   562       -    -562
.Ltmp3                                       804       8    -796
Total: Before=3D11206, After=3D28098, chg +150.74%

...and even the shortest "for" loop you added made a difference. ;-)

So I'm good with it, though I'd prefer that you send a new version (if
possible) since the "off_init" really bothers me for some reason. ;-P

I'll also note that I did some hacky testing to confirm that your
"for" loops do indeed create the same set of commands as we had before
your patch.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
