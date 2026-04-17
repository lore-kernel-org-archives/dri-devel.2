Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F789F8E499
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 02:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3905B10E26A;
	Fri, 17 Apr 2026 02:38:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aaE9SEYm";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862CD10E26A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 02:38:49 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b9c755b2cdeso35640166b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 19:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776393523; x=1776998323;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WakxEdRsodWxaOFMphLhoIZqY29N4gVBZoVqp2ZkCu8=;
 b=aaE9SEYmydOn93XnxJiBSTR5hRLkgSJrr84oNss3yZMDRjmJZmPxvnIkxk8RU9eQh6
 0GM65YCgK2la3ZWj0VT8HyPHVR9U2DN+rhyhSUfJWJLKeOs6/SOj15wXeQRH30jXuXaO
 WtO3tSiHL/PuCgS+d2btYIA/12kEp9QQZniAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776393523; x=1776998323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WakxEdRsodWxaOFMphLhoIZqY29N4gVBZoVqp2ZkCu8=;
 b=eSzIW4OphzLszMi+AVC4mYTTYMn+IlXKJFpJ2eJ3gaWt26RmSwSmhqDEWyLoGvF5at
 U+EieLhTMnWO9Fp1Cm/Ij6ZbYfUlk1wXCy5u3XrY7CHPHKTB9NGDzzREdiJmnKR2reSe
 kdpOrjZ7nUVfL5OSOcr4LNzFWRdaaYMhokQ9MErYGivFV0gzVAzbWoRxW3zSJfXlHdOi
 hU2VYduoe60Lok4AZFTNEwoPcpHcJOna33SaBpG8n8mXgc9L5sbpNoBA5W876AnY5nAt
 LQ0KXnnuK5fYwbtYlh+6sLHf6O51W/FEvjaMeE6qEZRWPq+hJnUVsozQ2AmVp7imMQtm
 V3wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eRRunJpjUK46pelMylpdm/L9I+T10Wi5MoXuImhhk0Gj37fdNEZ41Pjq6dQdA5YmElKziNXyvLF4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlMo8Ce89K6zDAJT9w7x2rnTQJUa8bxhz6Wzf9Io+ZPmeowMug
 8au1xQ0L87c1edrSvON/iz8oeVO4F1qws24p4/EqjIMIGJM5T1smsmBLTLnVOMNUoc2Jown9hs9
 /LSJUxQ==
X-Gm-Gg: AeBDieugkGarm5a4unR70pFaw5G9YDw8kIfIchvh3XTC975X2pXSAXFE6igRGqw/Bsw
 EsM2N/m+HT+91rye/5ub3OnFDf4GxhxPguCXkBlySfvw6HdNsF1/cSZqz3P3fP7Vzz5sO7TQgwu
 K9ye5TqRxuFHaK8q8UWlMgtF/bIda1FVs6DjA1FPaORGNaHTxaWff/pA6bmjmD5PtX1GX9SGvsA
 EF71+iLAx/5wtpvzRHNsbT+yEGQrMRufi5yopZp5wa5WQ5MQOJVl+31fZ6wdXesXQch45wKKsMP
 GnPhAhFr3WDVV2SM/Xh2tBVM1PhqADaQbRD5NXtOKdWCIzf92bmFRTFl76u8OzXIllhzpnOMK4j
 KxsOFYFoTHxc/lmqzXbp0XSQAGLrm47cKO/sNpGH1t8UAXzuxt00/lnsLpNzpwIjPAX1VaBgAj9
 5UTE+KB9meCPinyuVhnS8Mhyo3y3RJYXL+7jTiwKKvi2t4/U5ndEhk2IcAgB/Kd/6mdXv4QnYi
X-Received: by 2002:a17:907:934c:b0:b9c:1089:47b8 with SMTP id
 a640c23a62f3a-ba41b3e12e6mr44404666b.47.1776393523063; 
 Thu, 16 Apr 2026 19:38:43 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba451210e31sm7883666b.12.2026.04.16.19.38.41
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 19:38:41 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d572f7437so86993f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 19:38:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+bJKw/C144EG8PMguUrmJmn+h1ACiviBCF13xHb0bMpQNHBjAREyOwGviycM/mlR8/07l2kJlWoic=@lists.freedesktop.org
X-Received: by 2002:a05:6000:2508:b0:43d:71f4:7ecf with SMTP id
 ffacd0b85a97d-43fe3e1131cmr1197477f8f.38.1776393520334; Thu, 16 Apr 2026
 19:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260415-axolotl-display-v1-1-7abb2d248355@ixit.cz>
In-Reply-To: <20260415-axolotl-display-v1-1-7abb2d248355@ixit.cz>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 16 Apr 2026 19:38:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7LHNZGi9FU5dSj+OhbbfbVgZKwNh-Z4NKwi8CKsJkJA@mail.gmail.com>
X-Gm-Features: AQROBzDQabMFgLfZ9QgL6R4C4dIPXwo8GVWOgP73sg6lx2nRlWkT-3IW8H8ju2A
Message-ID: <CAD=FV=W7LHNZGi9FU5dSj+OhbbfbVgZKwNh-Z4NKwi8CKsJkJA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: visionox-rm69299: Make use of
 prepare_prev_first
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
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

On Wed, Apr 15, 2026 at 2:30=E2=80=AFPM David Heidelberg via B4 Relay
<devnull+david.ixit.cz@kernel.org> wrote:
>
> From: Guido G=C3=BCnther <agx@sigxcpu.org>
>
> The DSI link must be powered up to let panel driver to talk to the panel
> during prepare() callback execution. Set the prepare_prev_first flag to
> guarantee this.
>
> Fixes: 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI h=
osts at modeset")
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/gpu/drm/panel/panel-visionox-rm69299.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu=
/drm/panel/panel-visionox-rm69299.c
> index e5e688cf98fdc..0e33454650d13 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> @@ -387,6 +387,7 @@ static int visionox_rm69299_probe(struct mipi_dsi_dev=
ice *dsi)
>         dsi->format =3D MIPI_DSI_FMT_RGB888;
>         dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM |
>                           MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +       ctx->panel.prepare_prev_first =3D true;

Although it probably doesn't matter tons in practice, it seems like it
would be good form to set this _before_ you call drm_panel_add(). Is
there a reason you didn't do that?

-Doug
