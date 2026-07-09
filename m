Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643A1C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 22:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662C110E0DC;
	Thu,  9 Jul 2026 22:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gcZ8GdQB";
	dkim-atps=neutral
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36BEC10E0DC
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 22:42:40 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-5bdad7c16a6so175480e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 15:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783636959; x=1784241759;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CeOJLK+6gg6W80KstDMXPV+EfHFpx8XOXBNEzAqMiTc=;
 b=gcZ8GdQB4KQdOln/JjPU4PnuufdzZGWM2j1CzLu207/WMidQlQ+KzGMSvN6PeEvPxe
 yJOrArQnRgPGu15Hlt6fMvYz9ne7Px1GIo92uFVUvy1zbn/LwtiocTJY//qm/I3j3ifH
 QicjUJdqQIavbXYxwQe+Rcr8iK9NR20rxP+6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783636959; x=1784241759;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CeOJLK+6gg6W80KstDMXPV+EfHFpx8XOXBNEzAqMiTc=;
 b=GUHhqC1IO2oFPeM6e/kY34M3x+K5Ogi5I4lKTfTCOR6Azv3KF1mG3Kz7NrQaO+bIkS
 J/IOtW4+iYliP2yTot15fGvOrAtPXC9TaGSXSk+bdP1k9BhonPLC/O8tyGD/ZnIWAGfw
 D8PMjYEueyA5HarhOJVVqsTvJZQkAQic5mjBXI3jKx0oWWHYEVBmF/gNaH/CiLQX5VlR
 l6RCxbEhSVZvvOK5GQlTfUowhfsRTOD50eC/HUzV6aic1gVd2C+TAzD5yh7iisQF4Juj
 QxzBxEmz4SnxmnbpORyKJ9Bag2uw9/XvKqJ9IVqt+sp72qCxhJCnJcLGWFCftMpNahzI
 g1sA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTC9QVlO5VVoQekArUV0ZQLNHNA+v+tDtS0lS/Ncddd7X9AcfR701W1hPwUbrOw4RSd3SseYCRKmk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTgtEwPY0KvA2tRuPTPV0GuiR8Yf1bd0N1UgnrU+mOQ/6mkOre
 UmNR+xx0AmUfjIGcOIoGn3b8IdpMA5h+6K4TogJfEX6wP7fhjoEityUpMTWXa1eNvzBnwaBh0t5
 Otds=
X-Gm-Gg: AfdE7cnRiJ5Tq69G63IY4kWp8n9e4vxGsLpxPsSgeaD7QU2mLHdkz6xeA8ZGt0no+4f
 2ZseQdW8DWT6odoNn/EKO27Bt8S0k1j7fTKxKwxJlZQEMUE1ZQe49C7K4ev8kZS6X6SuuqmCmD2
 vlzPwFHJ2uUdtTJHf4+3nYx/lIM1+bQbz4qLZHv8felzj+DVLnuE5x9dnKO0FwZqAWFQ8UCwuXN
 V8PMNjsfebbjQMm78oWYqz8Y2qzW7I0reThs2Ae7ChmiGrOAj/V73PSSICT/r9dHzkYueMZB3mi
 FyI9Hah9VNfHGXS8JfJwKS5eqqqdaT9zYB+a5MNGX/qBVKhKHVlCP18XI3dIGeoHAL7ZbqPEnBi
 On8jZrnvMWmg3ktVmfOrNCkEjyOf94HNBvqJvfp05MbMF4IhWToboX9aZhoQn1+AiX+09y+Lu7R
 8kVatrk20I9CYykEP/PhCCFruKd4iR3Ev/1vFoV+CuSGHRx0XTfqc7hq8=
X-Received: by 2002:a05:6122:3d04:b0:5bf:5c31:fe85 with SMTP id
 71dfb90a1353d-5bf75a96041mr5271581e0c.0.1783636958659; 
 Thu, 09 Jul 2026 15:42:38 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com.
 [209.85.221.178]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bfa62d4575sm383050e0c.18.2026.07.09.15.42.36
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 15:42:38 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-5bdcbb1f3f2so151527e0c.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 15:42:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rrh1XdG4QeS53dHNhEDS6J6tUXUGR7+OeP25FvcMKPyg8BG5phE2sXjun+IBHSUbrdIsFs4Evk/EwA=@lists.freedesktop.org
X-Received: by 2002:a05:6122:7d3:b0:5a3:3153:21c9 with SMTP id
 71dfb90a1353d-5bf75ec13e3mr5358775e0c.11.1783636955671; Thu, 09 Jul 2026
 15:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260701064440.1541418-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260701064440.1541418-1-maoyixie.tju@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 9 Jul 2026 15:42:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQwqoUyzWLBEYgXErwtAy8MRVX97yj1_nfiWptg0rCrg@mail.gmail.com>
X-Gm-Features: AUfX_mxCfh24Ix2kaGRPSkRFOK4IFmv_3yrGcW2wqASQqlLt9wvjnwPFIBm0AVY
Message-ID: <CAD=FV=UQwqoUyzWLBEYgXErwtAy8MRVX97yj1_nfiWptg0rCrg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: tc358767: clamp the reported AUX read size to
 the request
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Kaixuan Li <kaixuan.li@ntu.edu.sg>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org, 
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

On Tue, Jun 30, 2026 at 11:44=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> tc_aux_transfer() clamps an AUX read to the payload limit:
>
>         size_t size =3D min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg->=
size);
>
> After the transfer it replaces size with the byte count the controller
> reports in AUX_BYTES:
>
>         if (size)
>                 size =3D FIELD_GET(AUX_BYTES, auxstatus);
>
> AUX_BYTES is GENMASK(15, 8), so it can be up to 255. Nothing clamps it
> back to the request. tc_aux_read_data() reads that many bytes into the
> 16-byte auxrdata stack buffer, then copies them into the caller buffer. A
> reported count of 255 makes the read run to 256 bytes and overruns both.
>
> The controller should never report more than it was asked to transfer, so
> this is defense in depth rather than a live hole. The reported count is
> only lightly trusted, and the check is cheap. Clamp it back to the reques=
t,
> the same way ti-sn65dsi86 does in commit aca58eac52b8 ("drm/bridge:
> ti-sn65dsi86: Never store more than msg->size bytes in AUX xfer").
>
> Fixes: 12dfe7c4d9c5 ("drm/bridge: tc358767: Use reported AUX transfer siz=
e")
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/t=
c358767.c
> index 4097fef4b8..26ba5a6c1b 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -527,7 +527,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux=
,
>          * address-only transfer
>          */
>         if (size)
> -               size =3D FIELD_GET(AUX_BYTES, auxstatus);
> +               size =3D min_t(size_t, size, FIELD_GET(AUX_BYTES, auxstat=
us));

Being super nitty: we don't technically need the "if (size)" above
anymore since it will be handled by the "min". Then again, if we
remove it then we also ahve to rework the comment about the "if"
test... :-P

...so I'm going to say this is fine the way it is.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll try to land next week unless someone else objects. Another
committer is free to land before that if they feel like it.

-Doug
