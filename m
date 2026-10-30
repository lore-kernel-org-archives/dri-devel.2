Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16382606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=U14KhXNg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D177112631;
	Fri, 30 Oct 2026 03:28:08 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2FD112631
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 03:28:01 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6b4bd3d98bfso250956a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793330880; x=1793935680;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fN88yp49ogzmXbOIeRn5XeqkoPRjJDMkOosDgOcXdok=;
 b=U14KhXNgQ5KlXeJrzCO03S6FdbrYYagXJe9qe6szs2FcwkzLNqyTKf7Kmvr1EbHZjc
 MitddRpJuMXRFQpE2imcokX/7UEqGGzxpNps/CQV7rQvuMtbsjp3g8P2vNE1BX3nDj9z
 kR8miZzd8JmiQtW6f5Stw0JH/Ky2TTUiIcfv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793330880; x=1793935680;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fN88yp49ogzmXbOIeRn5XeqkoPRjJDMkOosDgOcXdok=;
 b=RTXIb+NaZ9jDkxMLPOMCJEo8cr9AeFEgVmK0E2ulVXGY2IuWZMiNg8vdkN2V8oHUCZ
 VJ3SDDA8T4CvLzaGrc48Rf/DmqUDBRYu1OYKPT1PDHci45rXiqId3ckMUUDuXuQ2A/Aj
 xTDFVzbBq16wZCB3xXp4jtUj9lINMhqmQx2c/z+TXryjMbdENfPU3wFeHSxrF7TqXPT8
 CxchooCttdZhvh93UJSoJ+Ysm/nHPqP5b4f4GvLyuAJ+VdnMtVUUhGXVwQa3EshPezTW
 xdRNxBC6cor+4SKjbbtqfM/AV2V0NXGtg8KI7wxoMqOlzj6+NOmmKpxvXfNBIugK8t+I
 jp7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/GLSeYLmL+Q+kH1kAcHFwo4XDpL4OfYNtV8jOgVfSjLzApPJeetbFoEawoDTR6PEn6gfeRAfTmUg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJkNMj2rPrbNnlU5oZlh/jXUZSAD4ySrmRfQVIjP/5ttH9UTeCm
 NKByzlry30ONx+1pv9JA7UmJ7V+4MYFgE7VuDhgmxgfE6w5CDlHnRaWaUFx+2Z9uOsjt5GjgWO4
 qui0Vn3Vp
X-Gm-Gg: AYBFou3u4GBY/M5MGdvZJiR/gvTx+3hdFUE0PrLyKxBELtYi/UNQaTR1xseL6Roz7i4
 2rdEncDlNlfKd0EV30Wrvi4WmGtSgbmcZidAp2wc/JEENtUouoY72X8Yy4CnbermXPjsKjXcJ6g
 dg1BU/Le5qOb2FJa2EfCBSQ220HzlgWoMvPXAi/pUXlZiFa5Uqns9l5QDUdmHwG3BA4ibIloaGH
 2/EgI+05QJP1qw27QfUKH+7kTVbsqTb8ZXPiuoqLR2O/KRU4ARRfLte2EkAEvds5CCG0xusIj5h
 k5Pf4oJuvAx0sa3VJbSNeY2gAZsf25Sfs79cDY36seAjvya2fpQQfgSJQJukg7b+2inNyRBqcPo
 sNiEfePGWma5ISECVqGk/lVqPOsb6qrwFdp7RK2itKC8fymGxN9cDOvfIzN6oOPbL4279W3OtAR
 2/Uii9BmgprdOWRiiM2/rTU+3Hc95KRnNnMMlbTnYsdKBxXVpQN3HrkIaVwcVinBOYUevnlf7KJ
 mpRLa6BwTwI7uzzXPCjL1g2aUdhMft0Son01VMBs8ZLZRkuqKSAi8tjyASCmEOpeiXCopCOoK0s
 8QmUDvHvUlpJTvZoYlAliCTGFo4HOv8PAsqAyS8ykQC6ML/jZSLZE7L16RuQUw/jTmSLXZdac+L
 oZxUx9wz09bvSY5o=
X-Received: by 2002:a17:906:ee8b:b0:c3e:f39b:2286 with SMTP id
 a640c23a62f3a-c4ca740be5fmr80938566b.0.1793330879935; 
 Thu, 29 Oct 2026 20:27:59 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com.
 [209.85.128.54]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabcfdc30sm14084066b.26.2026.10.29.20.27.57
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 20:27:57 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a218c463d1so1146065e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:27:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzlymyyr6RNxugeYkuKIkJ1P7wYSANxraf2hYffjgpotoAy+b+bI8N3Ara2JMMj6mFu22RMUznLFXo=@lists.freedesktop.org
X-Received: by 2002:a05:600c:8b47:b0:4a2:1a:a121 with SMTP id
 5b1f17b1804b1-4ac181e75cfmr18962635e9.18.1793330876564; Thu, 29 Oct 2026
 20:27:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014135028.1438841-1-hungen3108@gmail.com>
 <20261014135028.1438841-2-hungen3108@gmail.com>
In-Reply-To: <20261014135028.1438841-2-hungen3108@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Oct 2026 20:27:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xm48DUT==8HuuGCSFZtLTEk-W2Q6UTfqt-MnM4nULzTw@mail.gmail.com>
X-Gm-Features: AclHuK_Nd5U37dkvomrYO2ThLngy9YsYJCRU_Th0Mc6jwetgi-HY8bekgcsKOxM
Message-ID: <CAD=FV=Xm48DUT==8HuuGCSFZtLTEk-W2Q6UTfqt-MnM4nULzTw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/panel: feiyang-fy07024di26a30d: Use
 mipi_dsi_*_multi() functions
To: Hsieh Hung-En <hungen3108@gmail.com>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, 
 jagan@amarulasolutions.com, osama.abdelkader@gmail.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
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

On Wed, Oct 14, 2026 at 6:50=E2=80=AFAM Hsieh Hung-En <hungen3108@gmail.com=
> wrote:
>
> @@ -81,44 +81,51 @@ static int feiyang_prepare(struct drm_panel *panel)
>                 const struct feiyang_init_cmd *cmd =3D
>                                                 &feiyang_init_cmds[i];
>
> -               ret =3D mipi_dsi_dcs_write_buffer(dsi, cmd->data,
> +               mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, cmd->data,
>                                                 FEIYANG_INIT_CMD_LEN);
> -               if (ret < 0)
> -                       return ret;

I won't block landing the patch for it (though I woulnd't mind a v2
fixing it either), but we also should get rid of the
"feiyang_init_cmds" data structure. Instead, just hardcode 7 calls to
mipi_dsi_dcs_write_buffer_multi() with the 7 initialization commands.
If you search the past multi-conversion patches on the mailing lists
you can find some references for doing this on other panels. Let me
know if you can't find it.

This could land as-is, or I could re-review a v2 that inlines the 7
commands. Up to you.


>         }
>
> -       return 0;
> +       return dsi_ctx.accum_err;

There's a pre-existing issue here that I also won't block landing for,
but again I'd love to see it addressed in a v2. If we return an error
here, we should probably turn off the regulators and the GPIO. Many
other panels handle this correctly, so you can follow those examples.


Reviewed-by: Douglas Anderson <dianders@chromium.org>

If there are no additional comments, I'll probably land in ~1 week.
