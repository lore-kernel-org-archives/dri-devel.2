Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE8606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=D7Udc3oE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43FAD112611;
	Fri, 30 Oct 2026 02:10:16 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27329112611
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 02:10:04 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c49b431f022so22135766b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793326202; x=1793931002;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=14ffGPbU3aLe9ZJ2h5R7RySjBO+SGB32Q5Hzs1k/SkM=;
 b=D7Udc3oEjo1upmHLAvWtwf6Xb/HTH/nUYqKIvO0KhiSYIN66If1Xu1F7NGb4ZlreML
 FBt0uaQZhtPraPPgyIArbARJ9wPnlX6lLhzwedXVleg/3OMPO+Tz6rFQ2EIDdvldzlCv
 d9gEEtIUgSIrrgcr13rdQNCjq0bFoxaYjSlr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793326202; x=1793931002;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=14ffGPbU3aLe9ZJ2h5R7RySjBO+SGB32Q5Hzs1k/SkM=;
 b=EXiW1I4gzNNuiEb1x52Q3gzBwAhFSZvUbgdOC2Rm1o+R9b7VOVpUzCziyZkRQ4G/bd
 VaUae44StEPuU92/Zj6aFOsfMCRa80S2/G+BfPwSToaR4a80NKjZIaL6TCsvLXc1TlIT
 DxNrjKKhoCsiKEH0IXuL9u8hyhZCKxzY2iSyvuaXHgi0/XgQZUj+FKrLw/HJDhDb7G29
 EzI5B9Fhtask1fLHLMGMqRMw9DzygYJcUdJBT9LDiawwa+Y87Kxdvi8ucXeGTFRh+svP
 i0NlAugaB1dgwcFU9g+O1WHbyVmpr0/wT6u/NRFcaWxgFeDfTaIPtdAT2yFQfZYzXlBx
 4/Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwV5uavQaZfFdfk8AWbUhuzGbTO20yl8brTkk0xFYtiEcCyytTNXUganyW+mvirZLFRdZ66TXLGwFA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLcpij/oKvwfpwspAjYtHyBtNJyXhYzKsvqTDgnEwgcNSllwDIK
 h4dVCzmjFujSWc1ECBy+c4eJzV6xWlCmn3uzXHpO8EIxMHcYWbduBjtxomgYQhhK5pQmM5WTJ//
 ewMG9fe3D
X-Gm-Gg: AYBFou2UNswoNmcFaoK9JM3OgdeCcaLcmZXn6uVsUTqQ0H1c+GHgFObM+cb8VFV2u8Y
 L0YlRGEhg+3owvv6p/OomkFZGxx9tUXZ6F1hajdbur1u6mxzZsn/30DSGizur0Nno3c/GH/YmZq
 SWbwbxrGK6SfPd5AUvB3qE+6o+hyDG+tWkpM/XFEuIZ3tlJZh50LAqfpBdvo78/Mz7sTCs051Pt
 40ipASJ9JD1qWN83iAVgirOrQytlUl3nlf6zTvQy/hFejE31n/poz9j7Tn6U16zykpWf4pTZw/t
 Xs4d4BJot9qCVw9/JvSC5yDeVuCqOdXVLX1BuQeoC1FF63UxvnDPlt3/T+UgYGJHaluAk6lQTRM
 ocTCFvps7iAREAwGacOI8F0GffsBWdmB01QZN1KCnmQAVDsWwrLS6N3mgQyutJInVWTyP/3vtue
 62J/STkMZMpKKuTDiyH37JiFuVzAMUJGYt9+tIw5AgCU+LX3xA1aozfkYz2kXOeW9ozyA3e1KgH
 bO0pbuQNEpmAovfgeiver5eAW4nSUev4tdVBukgrBav3q4JFzEC11Xh8WFVPgYygmdGYLE39tHV
 JYIjEy5HwW1kAtmu0r4s/hjiMalBVFzl4mWbC3fvwhpds9PB0sbmcuPmzyV4/ZVGcvhM
X-Received: by 2002:a17:907:3e8c:b0:c31:8984:7fad with SMTP id
 a640c23a62f3a-c4ca7a4bdd3mr68512866b.15.1793326202555; 
 Thu, 29 Oct 2026 19:10:02 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com.
 [209.85.128.49]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabecd226sm8038666b.74.2026.10.29.19.10.00
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 19:10:01 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so1375445e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:10:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBz43mahofiw0UFKg5IwtWBEMPhJLxZBpI/uXVrGuFKpfyGCb/8Q1SJdKSZMrAbmJ/TVKFKtGcDFY+o=@lists.freedesktop.org
X-Received: by 2002:a05:600c:4e49:b0:4a4:6fdb:cc42 with SMTP id
 5b1f17b1804b1-4ac17b2c38bmr15532625e9.11.1793326199695; Thu, 29 Oct 2026
 19:09:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
 <20261012-mipi-multi-series-v1-4-6a29add1ec92@gmail.com>
In-Reply-To: <20261012-mipi-multi-series-v1-4-6a29add1ec92@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Oct 2026 19:09:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WyhMTW-sAWPsmNSBSY760kYMQpcG7EnMX-B=RvCxj3SA@mail.gmail.com>
X-Gm-Features: AclHuK9MBVy1HRjgbqH_Cj8X-k4-4JomWpdaaPip0nkkrwu-aj4_DTTxONWYllw
Message-ID: <CAD=FV=WyhMTW-sAWPsmNSBSY760kYMQpcG7EnMX-B=RvCxj3SA@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/panel: newvision-nv3051d: Use mipi_dsi_*_multi(); 
 fix minor bugs
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Chris Morgan <macromorgan@hotmail.com>
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

On Mon, Oct 12, 2026 at 9:36=E2=80=AFPM Akash Sukhavasi
<akash.sukhavasi@gmail.com> wrote:
>
> @@ -274,6 +269,7 @@ static int panel_nv3051d_prepare(struct drm_panel *pa=
nel)
>  {
>         struct panel_nv3051d *ctx =3D panel_to_panelnv3051d(panel);
>         struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>         int ret;
>
>         dev_dbg(ctx->dev, "Resetting the panel\n");
> @@ -295,22 +291,16 @@ static int panel_nv3051d_prepare(struct drm_panel *=
panel)
>                 goto disable_vdd;
>         }
>
> -       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> -       if (ret < 0) {
> -               dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret)=
;
> -               goto disable_vdd;
> -       }

Similar to patch #3, I would have passed the ctx to the init function.
That would have also fixed the pre-existing bug that Sashiko found. I
guess it's OK to fix it in a follow-up patch, though.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
