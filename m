Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC6C606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FXN96VbD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6BB112633;
	Fri, 30 Oct 2026 03:28:27 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BAF112633
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 03:28:20 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c4cac7a7d3cso7647366b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793330899; x=1793935699;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/IuBdm3v3+KNfZTmfbPur/zgtnwsutcegngLNEsBNYY=;
 b=FXN96VbDfOJidcYQqSHbrAO4mk/M82bBxeSSqF2DaDsLIombVQjtJpQ8gReDEeJ0/P
 jtCPZNki77AJp4GY1tvAHb3VtmcPhA8q7H85nw/2pzj1KB2vDHSvxaZeMQy89VdMBNDy
 YgJNi/HknAOh9px3Dh7TEtRqePIUi3j64incQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793330899; x=1793935699;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/IuBdm3v3+KNfZTmfbPur/zgtnwsutcegngLNEsBNYY=;
 b=YnDZLELahyn3gOPQb6qy25F2v9nrLlDxfQS6aGspcv9Gcw8TsUbyIyXg76elJfk/vw
 lBG/liiHkQHNELpKnUXSHEA9qMTOvSB9In6KtxRFT3Ffvdx8KvKVAZG9i8MK++kjjjcm
 RtvdtYY/fK45Tkc9kyqLQrMFtuHJT//xagwc3wx38truGOfimUfa1sQoHPyGrmgi6Az6
 IJt9d/RfOuGZOBa9i6POynzkr8K6F5SXO1gCYM4THupOtyjvuzqAKlPRg9V3GBZdPFU0
 uYALXluW5IvlnxvCn/MRTbTDzu+1is9rs/h4QnM+SgPH7m/4IetlfuCu1EulZJr1x+vD
 Ag2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhKpt9MDMnIWLKMoKJ3pZcxgWp0jPHRJhyljrfBuusdCmhIwAZX4K30xrYmF7WIoaGrqVm+0hqCYM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLNba//D7qWoWWgg1ig4JAYSh7A6m6WpiMH/jBDD7/bCPmDXOhM
 xri7rOC8w+Q6k+DeTjrWlB3Tm555qdUvxaNDfFJ2ArC72B4uGxfusDJpwiAU0K7QIC3fm/KAS4U
 UKnWCokXX
X-Gm-Gg: AYBFou1lEah9HcTC4Uw7WE7N72qNmY4aks49rrvBOsUy/InuDBeLD+fn/52tuocnT8L
 eG/qHRNe0sjRwOaMgFDA0YnBTcFxUxS38YcqF1+Ky8H14AIPG1msHemaQ/PXF8JPgLuYStTB9DO
 pGkauy0VNoOvday3Ouf9ojUvByjiUBwKoNriXky4CmxOLFNUdhhaVRfQKRgyRqdNBZIGAVeMiuu
 FQZPSV7UcLavYudSGubdQmSDKAQHplgG124r4uRQzcAKlKkjeKmZ8SyuxeHKxqPobG2bUjYcDTN
 D54hTr34wX5B1/sylT6lgUdMzyoVUOwP8z6HjUo3G48G6NkrNi+doKnP4apnvMpSbkaSbwTM1U8
 7+8600PCxuoNGgPr5ujgaS+8yubvyR+p2En9Ow5+CI1hAZNko58DeXF260PT7llNm1Ymydluvaq
 h1ruD9XjGPnPgh0YqI38KXLVL4Fv2xBNUQqLkQnfgdRC1m9L3l2JNgMB0mgVMR9qjQ7DTTRGz3x
 VKlqDdDfZIE41Oc8EQ1dPn4UekqKg9clJjsvYyWL8EIQ+TSwv1dQ968vIsrQV7DP7nlsCkHOIpF
 cj/Upg+Sa9sBInHz4VuRD02faUl27rYJhk/XHmi+KWnGsv+/3/Sf0I9eEkjz97ESO5xU
X-Received: by 2002:a17:907:9446:b0:c49:a571:c4f9 with SMTP id
 a640c23a62f3a-c4ca7a4205emr76842066b.13.1793330899112; 
 Thu, 29 Oct 2026 20:28:19 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com.
 [209.85.128.42]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe4a9a1sm13376666b.58.2026.10.29.20.28.16
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 20:28:17 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso2273835e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:28:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwP3obzoukPX5jfM8kUQ0g9CwS3GxaEiFwLSDKOzXWSuWVrMz2p7caZuf3yO6LYg81nVuT2+QJPCKw=@lists.freedesktop.org
X-Received: by 2002:a05:600c:46d2:b0:4a1:7ec7:a479 with SMTP id
 5b1f17b1804b1-4ac1980118cmr16667665e9.33.1793330895525; Thu, 29 Oct 2026
 20:28:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014135028.1438841-1-hungen3108@gmail.com>
 <20261014135028.1438841-3-hungen3108@gmail.com>
In-Reply-To: <20261014135028.1438841-3-hungen3108@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Oct 2026 20:28:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WssS-VkBDw5czaBe+pJ+etdWdaZ8ibWvnTKR9KS_Nr9Q@mail.gmail.com>
X-Gm-Features: AclHuK9Z0o5vk_K9aqpGm9Z8TVk34VAR5093mRxE_muaOzNOVbgbq77FDBzqnAY
Message-ID: <CAD=FV=WssS-VkBDw5czaBe+pJ+etdWdaZ8ibWvnTKR9KS_Nr9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/panel: raydium-rm68200: Use mipi_dsi_*_multi()
 functions
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed, Oct 14, 2026 at 6:50=E2=80=AFAM Hsieh Hung-En <hungen3108@gmail.com=
> wrote:
>
> @@ -258,6 +256,7 @@ static int rm68200_prepare(struct drm_panel *panel)
>  {
>         struct rm68200 *ctx =3D panel_to_rm68200(panel);
>         struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>         int ret;
>
>         ret =3D regulator_enable(ctx->supply);
> @@ -275,19 +274,15 @@ static int rm68200_prepare(struct drm_panel *panel)
>
>         rm68200_init_sequence(ctx);

I think you also want to pass the dsi_ctx to the
rm68200_init_sequence() and eventually use it to replace the
mipi_dsi_dcs_write_buffer() / mipi_dsi_dcs_write() with their multi
variants too, don't you?

Oh, I see. You did this in the next patch. I would have just mashed
them together into one...


> -       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> -       if (ret)
> -               return ret;
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>
> -       msleep(125);
> +       mipi_dsi_msleep(&dsi_ctx, 125);
>
> -       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> -       if (ret)
> -               return ret;
> +       mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>
> -       msleep(20);
> +       mipi_dsi_msleep(&dsi_ctx, 20);
>
> -       return 0;
> +       return dsi_ctx.accum_err;

Similar to patch #1 (and what Sashiko pointed out): we really should
be turning off regulators and deasserting GPIOs here.

There's a bunch of small things here, though everything is
preexisting. As I've said, I wouldn't mind a v2, but if a week passes
and I don't see anything, I'll probably apply.


-Doug
