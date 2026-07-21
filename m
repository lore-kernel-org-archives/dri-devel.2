Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53EEC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84C810E3B6;
	Tue, 21 Jul 2026 20:13:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SB2LNvyu";
	dkim-atps=neutral
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EEF810E3B6
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:13:35 +0000 (UTC)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-976ea28c65fso3103585241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784664814; x=1785269614;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nwBHgv9alzTg6KAwzQ08BZGkgaDGmBbYIWpWTOvVhl4=;
 b=SB2LNvyuxF7TuKLeeUnNh19V+Vz7xWIneyr6HZQ7IYFCzFSoMuxl2VogkMmhL/T1kC
 yc24asBR3evUyCr8K/tUFA9llmQr6jAOOJh1YmjSBD5iOr45t+bfotlelRJKfI5ZpNoS
 W3LGD6SCl5gBQDFIlTPRb5QOPCR4szowdz71g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784664814; x=1785269614;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nwBHgv9alzTg6KAwzQ08BZGkgaDGmBbYIWpWTOvVhl4=;
 b=hqRzZalt2VDOAqq+fKU5Uw/+EaWEWdFJeD9wZGtN33jgCpFZhRxgLxdIMtusKDh9M6
 84XdJWp4ahpC8J1MNGJFWC0qNXx3Fo6tMWb2tLMsIJZx/AJ43OhivV0mQZItmvVeCsmk
 eXPwhoSa0//HkkRp6udQu4qStHMpluKBsGoUqWd0yjmGjhcGXgyJVwPQuWeJ3wVajSrT
 ukOkYgRZ6vYKWPdvyYwZ2Yp+jC0oCWUFXuywPrNX2TLEGUXRgZfXMCP4sJ08ZSoAlFV0
 a3kDo5LqOqJKhkPl1N3RMhiWudLRmaXAJJ/LNXyHPC2E1+HHOIfmrkipcEAY/eGdMvVC
 iFcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvbItBOELrrsReQ9eSOaQNOcHlOVyGUwDyyX07R55tJv272b/fBZ48JmAUs1o9hocT8M6/yQl1kaY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywkvgx258vyV/dLYN60AD3xxQ3riVmrLyHF3MeS+YtWxDu9aCMf
 LNJZjm6V8KbAct6Wb1L12g3aj8nHRkmmUmJBqlJWmyH1YETNPPfRZT6pQZJD3jcV/Czbg5efqnw
 0a1g=
X-Gm-Gg: AR+sD13j3jCp4spb8r/vJIFLdbWfTMrHlyGh2/JAr/B0TCVSTxtGhiwtV7T/yB68LHP
 RNzW/tKsFkcUVdcHZ1AdH0vyq2xAGV1+L4M8J14YFaCA5EugdoBpQJNh4YQN+Im5lAwiuFGgscF
 Ee+AB9LWgeQoLvmaPAZXAMJN+/pN8s/1ssxg2idD59e5TVOxPe4ttuckZomV5I3F2eDeKaG1z8N
 jRsMqSj+/ly+f7GL2kKCl+ISlrW2VKWZiRbBKX6VI1cTnQgHRo6HbICpHqSEF1BoJ+wR7566F/r
 KD8lcZqxt7tAaA8fiso+epWVgkaaQ6FcYpl28FrAQxlknAOHTTUbGWh5i15sQVtayTRcNYiPbJr
 ahRIlHQLo/k1wXsDOK0S2mrERdFFHQ30d7+YhlyiFhbkMWcJW5Nvx/sv+naX5r8NRJYN9OkKFom
 8n7sVxmQ0j1tmCf1K3702Mt2+1Mo0J7hdp3FSdJVaD
X-Received: by 2002:a05:6102:41a1:b0:631:2624:e5e7 with SMTP id
 ada2fe7eead31-7475360e1c6mr7299091137.14.1784664813909; 
 Tue, 21 Jul 2026 13:13:33 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com.
 [209.85.222.48]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9774420f50bsm381916241.11.2026.07.21.13.13.32
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 13:13:32 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-976ea28c65fso3103573241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:13:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/Kut/puieVQiYurYw6oyerZp4kxQ1sckD/FCPLs+cxNLHPkcUw5c/B+96050XV94npVm/GOBR3Ks=@lists.freedesktop.org
X-Received: by 2002:a05:6102:5986:b0:71b:e02f:65e2 with SMTP id
 ada2fe7eead31-7475369ccacmr7078448137.20.1784664811749; Tue, 21 Jul 2026
 13:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260721172715.602196-1-michail.tatas@gmail.com>
 <20260721172715.602196-3-michail.tatas@gmail.com>
In-Reply-To: <20260721172715.602196-3-michail.tatas@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 21 Jul 2026 13:13:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XoyaqCwXCQagxmeSQKZi8nW2R-g8f8UpFFk-BHXq0OcA@mail.gmail.com>
X-Gm-Features: AUfX_mx0OAJtyUs6DGaJkb8l5g1SeAK3EXN3_l4TPrMtjSoYby2wHW8mshWHv_s
Message-ID: <CAD=FV=XoyaqCwXCQagxmeSQKZi8nW2R-g8f8UpFFk-BHXq0OcA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/panel: ilitek-ili9805: Use dsi_multi in init
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
> +static void gpm1780a0_init(struct mipi_dsi_multi_context *ctx)
> +{
> +       mipi_dsi_dcs_write_seq_multi(ctx, ILI9805_EXTCMD_CMD_SET_ENABLE_R=
EG,
> +                                    ILI9805_SETEXTC_PARAMETER1, ILI9805_=
SETEXTC_PARAMETER2,
> +                                    ILI9805_SETEXTC_PARAMETER3);
> +       mipi_dsi_msleep(ctx, 100);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xfd, 0x0f, 0x10, 0x44, 0x00);
> +       mipi_dsi_msleep(ctx, 100);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xf8, 0x18, 0x02, 0x02, 0x18, 0=
x02, 0x02, 0x30, 0x00,
> +                                    0x00, 0x30, 0x00, 0x00, 0x30, 0x00, =
0x00);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xb8, 0x62);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xf1, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xf2, 0x00, 0x58, 0x40);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xf3, 0x60, 0x83, 0x04);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0x04, 0x0f, 0x01);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xeb, 0x08, 0x0f);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xe0, 0x00, 0x08, 0x0d, 0x0e, 0=
x0e, 0x0d, 0x0a, 0x08,
> +                                    0x04, 0x08, 0x0d, 0x0f, 0x0b, 0x1c, =
0x14, 0x0a);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xe1, 0x00, 0x08, 0x0d, 0x0e, 0=
x0e, 0x0d, 0x0a, 0x08,
> +                                    0x04, 0x08, 0x0d, 0x0f, 0x0b, 0x1c, =
0x14, 0x0a);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xc1, 0x13, 0x39, 0x19, 0x06);
> +       mipi_dsi_msleep(ctx, 10);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xc7, 0xe5);
> +       mipi_dsi_msleep(ctx, 10);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xb1, 0x00, 0x12, 0x14);
> +       mipi_dsi_msleep(ctx, 10);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xb4, 0x02);
> +       mipi_dsi_msleep(ctx, 10);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xbb, 0x14, 0x55);
> +       mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x08=
);
> +       mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_PIXEL_FORMAT, 0x77=
);

You've already got my Reviewed-by tag, and I'm planning to merge this
patch as-is. ...but my AI happened to notice that the above line could
be:

mipi_dsi_dcs_set_pixel_format_multi(ctx, 0x77)

...so I figured I'd at least mention it. ;-)

My AI also noticed (yet another) pre-existing issue that the "name"
field of "struct ili9805_desc" isn't used in this driver...

-Doug
