Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBF2C44529
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D937C10E178;
	Mon, 20 Jul 2026 20:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PQ4AMqVp";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0195410E178
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 20:08:24 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-59b074ec7ceso3897317e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784578104; x=1785182904;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iFzejZ2ypE5waA9MMcITXEgimyfo81y8HvT6rxfu8Yg=;
 b=PQ4AMqVpxfgD24hetjW5TNqMP18CPe3DuBbhwjbS1hFzkgPjO7C+2JA7j8/q/jmHtv
 aIWxQ1vN45xzPtEhM82HIato72/U+7Kb06Cng5jSb8SPBSEvheskFLQLGL9miNQMXQUf
 OEKODCv7GqlTwHXtsVSE+rB0fznkty4mMp+bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784578104; x=1785182904;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iFzejZ2ypE5waA9MMcITXEgimyfo81y8HvT6rxfu8Yg=;
 b=X10dj8XQSa44ZI2aYyuLFOmwdsrZcEyYtxmjPJ3R5v0M63OrmHQE5CZF85JYKWEKVE
 K6BtKAD9tuUfKMoJmRZwJIXuEJ9Tkj/Q3a3Iqzb0Y5T36rT8GCKTmC+BYTkHbZR0PwEM
 O5QmWlPgzCDnxdhOv6kTYQbmQUvq3vntR4N1U8N8fz90fjH7w2+UCKluUf5v+bCd/Xhq
 2r67u0arLdeT2HbzMi3AjE+AMQD6L9Gc3z7S64C70xLF1TDDMrvaKLKe3Pc+4K8t+Xws
 uCVoXyaqVN1SjW6uKHnoTbGxsGV5uYrY75JG9MEYPM7kPN5QtSWIjw0PaADvG5FSn7MX
 A0Zw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXY8imVD/nPwBc8lM31YNu7iCf2rdaK3HxtGZUuPEGin9iAtyEZK3a+4sgfjdTCa7as/EJXGKY2ug=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhAb4w+Q/m/1ttxRVik5QrguobBA/OeBmWT6qs/5Qus50fjWyV
 pgfeYxq+2PLQIxYht8pTwwb4vZjWcoC6tH+7KKI7tLWMD+c1Nt/TvlX67Xt4UiRNl29nJsPfu+W
 xEM8=
X-Gm-Gg: AfdE7ckqAPv1RXMrU836doOgSrNyLFb8MetDhW0cQsdUqhl/tYQceBmaVFuCUvcKPrp
 2ZUBAzDtvU5kgSfVWlUQg0xmWRrIZoDAVV4suPcLyMcWuQYkY9HRfEvlTxY6tKQjfvVZ6nNJP4B
 iKD2KhLck/4O9mKVBPBvX1qejAReyagq2PB7D9OX2V1LmotSLILm1YJigPwfnKBC0KfYBNjO0xL
 uKvn7eMRKBFoWL41KOdWICKeWNLvYQ7y2Z8YsKVwodoX5zBc/8jiac6h6UXVdvajgHpDgPRQ6Wu
 J4P/+FJHwwCRWi0QUMqVnYZdvYol7vELLCMIs4TzZHrRLHG2Nyccg++cAv5bx1fAI7uKuN/nn0P
 k+w2QTxdc3iBK1WEYZFLN9d3mSMtPIpV4d2uMcBpUzs4fQ5O/CTRPsRW5g8F/biS2Dh9i11PTIN
 DlJmC3woUb4yAujhisPm6UO4DcC9hjqbS6XtsNxlK9OeLe
X-Received: by 2002:a05:6122:8b10:b0:5bd:aba5:3830 with SMTP id
 71dfb90a1353d-5c1b64b6898mr3354219e0c.0.1784578103791; 
 Mon, 20 Jul 2026 13:08:23 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com.
 [209.85.221.177]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c1eefe4543sm10602930e0c.11.2026.07.20.13.08.21
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 13:08:21 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-5bfdbc68bbeso3290836e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:08:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rogs5yhhJTje671aOxMIRN7xtii36Kzu7V8F/whjDLX79fvpm1dUUmfuSTWb3g79Dmdhx/F+RMQK+c=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3fa6:b0:737:9edc:36f8 with SMTP id
 ada2fe7eead31-7475344549emr4012508137.1.1784578100701; Mon, 20 Jul 2026
 13:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260719190358.438699-1-michail.tatas@gmail.com>
 <20260719190358.438699-3-michail.tatas@gmail.com>
In-Reply-To: <20260719190358.438699-3-michail.tatas@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 20 Jul 2026 13:08:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wqo8Y=NCH0HVn8diQ2q1qxh0tcYLTKNKxGL2e-He_mNg@mail.gmail.com>
X-Gm-Features: AUfX_mwihhuMmlmMz-XnCtVH05KhY2i6jzh5jkmahlFo6a8baZ85WeYb_l6nNTU
Message-ID: <CAD=FV=Wqo8Y=NCH0HVn8diQ2q1qxh0tcYLTKNKxGL2e-He_mNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/panel: ilitek-ili9805: Use dsi_multi in init
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
> Drop the struct ili9805_instr and the init table
> and use init functions.
>
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 156 +++++++++----------
>  1 file changed, 73 insertions(+), 83 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/d=
rm/panel/panel-ilitek-ili9805.c
> index 7e9587afebbe..a70b9512746a 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> @@ -25,22 +25,9 @@
>  #define ILI9805_SETEXTC_PARAMETER2             (0x98)
>  #define ILI9805_SETEXTC_PARAMETER3             (0x05)
>
> -#define ILI9805_INSTR(_delay, ...) { \
> -               .delay =3D (_delay), \
> -               .len =3D sizeof((u8[]) {__VA_ARGS__}), \
> -               .data =3D (u8[]){__VA_ARGS__} \
> -       }
> -
> -struct ili9805_instr {
> -       size_t len;
> -       const u8 *data;
> -       u32 delay;
> -};
> -
>  struct ili9805_desc {
>         const char *name;
> -       const struct ili9805_instr *init;
> -       const size_t init_length;
> +       void (*init)(struct mipi_dsi_multi_context *ctx);
>         const struct drm_display_mode *mode;
>         u32 width_mm;
>         u32 height_mm;
> @@ -56,65 +43,78 @@ struct ili9805 {
>         struct gpio_desc        *reset_gpio;
>  };
>
> -static const struct ili9805_instr gpm1780a0_init[] =3D {
> -       ILI9805_INSTR(100, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SET=
EXTC_PARAMETER1,
> -                     ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMET=
ER3),
> -       ILI9805_INSTR(100, 0xFD, 0x0F, 0x10, 0x44, 0x00),
> -       ILI9805_INSTR(0, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, =
0x00,
> -                     0x00, 0x30, 0x00, 0x00, 0x30, 0x00, 0x00),
> -       ILI9805_INSTR(0, 0xB8, 0x62),
> -       ILI9805_INSTR(0, 0xF1, 0x00),
> -       ILI9805_INSTR(0, 0xF2, 0x00, 0x58, 0x40),
> -       ILI9805_INSTR(0, 0xF3, 0x60, 0x83, 0x04),
> -       ILI9805_INSTR(0, 0xFC, 0x04, 0x0F, 0x01),
> -       ILI9805_INSTR(0, 0xEB, 0x08, 0x0F),
> -       ILI9805_INSTR(0, 0xe0, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, =
0x08, 0x04,
> -                     0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a),
> -       ILI9805_INSTR(0, 0xe1, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, =
0x08, 0x04,
> -                     0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a),
> -       ILI9805_INSTR(10, 0xc1, 0x13, 0x39, 0x19, 0x06),
> -       ILI9805_INSTR(10, 0xc7, 0xe5),
> -       ILI9805_INSTR(10, 0xB1, 0x00, 0x12, 0x14),
> -       ILI9805_INSTR(10, 0xB4, 0x02),
> -       ILI9805_INSTR(0, 0xBB, 0x14, 0x55),
> -       ILI9805_INSTR(0, MIPI_DCS_SET_ADDRESS_MODE, 0x08),
> -       ILI9805_INSTR(0, MIPI_DCS_SET_PIXEL_FORMAT, 0x77),
> -       ILI9805_INSTR(0, 0x20),
> -       ILI9805_INSTR(0, 0xB0, 0x01),
> -       ILI9805_INSTR(0, 0xB6, 0x31, 0x00, 0xef),
> -       ILI9805_INSTR(0, 0xDF, 0x23),
> -       ILI9805_INSTR(0, 0xB9, 0x02, 0x00),
> -};
> +static void gpm1780a0_init(struct mipi_dsi_multi_context *ctx)
> +{
> +       mipi_dsi_dcs_write_seq_multi(ctx, ILI9805_EXTCMD_CMD_SET_ENABLE_R=
EG, ILI9805_SETEXTC_PARAMETER1,
> +                                                       ILI9805_SETEXTC_P=
ARAMETER2, ILI9805_SETEXTC_PARAMETER3);

nit: the indentation of the 2nd line of your two-line
mipi_dsi_dcs_write_seq_multi() seems off. checkpatch.sh --strict
yells:

CHECK: Alignment should match open parenthesis

Strict mode also yells about a few lines that are over 100 characters.
I'm not quite as picky about that, but it would be nic eto fix too...

> +       mipi_dsi_msleep(ctx, 100);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xFD, 0x0F, 0x10, 0x44, 0x00);
> +       mipi_dsi_msleep(ctx, 100);
> +       mipi_dsi_dcs_write_seq_multi(ctx, 0xf8, 0x18, 0x02, 0x02, 0x18, 0=
x02, 0x02, 0x30, 0x00,
> +                                                       0x00, 0x30, 0x00,=
 0x00, 0x30, 0x00, 0x00);

Since you're touching these lines anyway, can you also fix these
functions to consistently use lower case hex instead of (mostly)
uppercase hex? AKA 0xfd rather than 0xFD.


Other than above nits, this looks great to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
