Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B49F106FD9E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CA710EB2D;
	Fri, 13 Mar 2026 08:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="QN8XO9Ct";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DAD10EB30
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:33:20 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6642a16be1cso248824a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773390799; x=1773995599; darn=lists.freedesktop.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/of78zuCI1x5T6ZYrwM97n73xB/ugxAeVuA7riCgkNo=;
 b=QN8XO9Ctz1xbzw1u6tUJnuvL55djyYK5aBGGGsruF+nYTJu2xDOYMDdN1woZZKbPoJ
 /HaMhXRyIk7nIDoWSiCHjSW35j+SCarN16NQYVEGIqw+CnbYohB/eXWA2qEXAJZUpZJ8
 Cx05hVgiOw174E2nhO6+03woTl10S77oaso41WmfDiL0nrl1TTyUNNuLysRM7/Yl/+8/
 EsosWbNVhL5wd0JwY3grzhuiLl8z9cdHDYlBxuQG7YoFkMzYDv+EeyrZO/VFh64R9hGm
 Jub+v4z5E6IyUAjq6qKwwvJP0CdOkJFmfoFpfk1IyBkHaT4hmn2XyDzd44YKYYpDXMXs
 KiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773390799; x=1773995599;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/of78zuCI1x5T6ZYrwM97n73xB/ugxAeVuA7riCgkNo=;
 b=m9lElwAmFe1Mdnf5sCGFRq3RAiw71KI5EP7mTeN9N2dtRuRyQIy+PIY1JgKFDQzzIT
 FKREDi0Ndu9Asm/lMEYrEuMiyo0yKL9AGeQKMO861T37FOho9TZ4pc++/lHpuniSJacW
 DCyt1w8MGYWnXixmgBRKCupKuIRMsc03YWM4ZDUXk7GUKSkV0C3gMr1X2u1eHt2eDIKn
 khx7cnO56msVkuWpVBqPcMLph0l8f00BLFdaDfSyguAVgenGhpa+V+I2YY/+l7sAn+/S
 6r+YzkgA1GKs4f+OiIU9KvkY8vWCkaL/UUoMZCRFqh53skiwqgI+YHD3bofsy9Vb6qA3
 /GuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlHDOxRiVHUml1JzDRlo3LduuZzJHFWwjdVHfkuBPVruNow228stg2b+7SLJhnxS7mm9XrvlA5C74=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqKminJoK40Mxfb3tvWBKOo1YkBBDGrtsD+nTN6zSLxiYdbDng
 O0TPYV5lSjT+WrqybgHsWHfEBkBhDUBnPOysvmVpnT0BMyFCmpF1j0AgPvidU9YSmAo=
X-Gm-Gg: ATEYQzwK1Z8AsZgDKbXP2EliYyKivh9bCM1TtmWIQa/3vcEAKMEsE9OJkuqP51vy2B+
 Jw++9J35OO4P0uy2sgO0S+7LOSnD4aBkFZKX/ssr/IqXwcCxAn5MtDSYLCVbVlhmezIm9KUHVX/
 VXAXoFAXiafBxgsTqJButqoXl3lxqCyQDhXRe5fuARB/zhAHbKaTJDcitBs+7Y2YF8gR3dpFptX
 z1HdHvDVLdntyVnRaTaMFgxAmMtuG6tUGRhS7hqfo93Rta/66LgKqt5BCjh6GLrFTq76DtZIMJ3
 xK15j7AeW3P1zHsGUqzja8pKRPulE7dYZgRrxv7ENJ5L1fPXhWCuImHcxSmF+SHrM70eNYZU8ie
 dwa50vBAD6ifMqH5if+ldSQMM0SHO0vL942/C4bFRojgVm8t9AzMKDX+yza9S4OXBSSTmgKWatD
 yVJHnHIm0Y7kTj/ARnBXtmZ+3aAk1TXN9DHNgAJfKvyigtab0Qw1cd13JozTziktbkyFSQ
X-Received: by 2002:a17:906:4a9a:b0:b97:f3:1231 with SMTP id
 a640c23a62f3a-b97653525a2mr101020566b.57.1773390799228; 
 Fri, 13 Mar 2026 01:33:19 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976cc1c154sm28620666b.27.2026.03.13.01.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 01:33:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 09:33:18 +0100
Message-Id: <DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.com>
Subject: Re: [PATCH v2] drm/msm/disp/dpu: add merge3d support for sc7280
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Mahadevan P" <mahadevan.p@oss.qualcomm.com>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Krishna Manikandan"
 <quic_mkrishn@quicinc.com>
Cc: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <regressions@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260101-4k-v2-1-712ae3c1f816@oss.qualcomm.com>
In-Reply-To: <20260101-4k-v2-1-712ae3c1f816@oss.qualcomm.com>
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

Hi Mahadevan,

On Thu Jan 1, 2026 at 6:04 AM CET, Mahadevan P wrote:
> On SC7280 targets, display modes with a width greater than the
> max_mixer_width (2400) are rejected during mode validation when
> merge3d is disabled. This limitation exists because, without a
> 3D merge block, two layer mixers cannot be combined(non-DSC interface),
> preventing large layers from being split across mixers. As a result,
> higher resolution modes cannot be supported.
>
> Enable merge3d support on SC7280 to allow combining streams from
> two layer mixers into a single non-DSC interface. This capability
> removes the width restriction and enables buffer sizes beyond the
> 2400-pixel limit.
>
> Fixes: 591e34a091d1 ("drm/msm/disp/dpu1: add support for display for SC72=
80 target")
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>

This patch is causing display regression on QCM6490 fairphone-fp5.

With this patch in 7.0-rc3 (or 6.18.16) there's just pink noise on the
screen. When reverting this patch everything becomes working again.

See also https://salsa.debian.org/Mobian-team/devices/kernels/qcom-linux/-/=
issues/41

@Dmitry: Can we revert this for later 7.0-rc, in case it's not fixed
quickly?

Regards
Luca

#regzbot introduced: 2892de3f4f985fa779c330468e2f341fdb762ccd

> ---
> Changes in v2:
>   - Updated commit message for clarity (Dmitry).
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h | 14 ++++++++++++=
--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/dri=
vers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> index 8f978b9c3452..2f8688224f34 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> @@ -13,6 +13,7 @@ static const struct dpu_caps sc7280_dpu_caps =3D {
>  	.has_dim_layer =3D true,
>  	.has_idle_pc =3D true,
>  	.max_linewidth =3D 2400,
> +	.has_3d_merge =3D true,
>  	.pixel_ram_size =3D DEFAULT_PIXEL_RAM_SIZE,
>  };
> =20
> @@ -134,17 +135,24 @@ static const struct dpu_pingpong_cfg sc7280_pp[] =
=3D {
>  		.name =3D "pingpong_2", .id =3D PINGPONG_2,
>  		.base =3D 0x6b000, .len =3D 0,
>  		.sblk =3D &sc7280_pp_sblk,
> -		.merge_3d =3D 0,
> +		.merge_3d =3D MERGE_3D_1,
>  		.intr_done =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>  	}, {
>  		.name =3D "pingpong_3", .id =3D PINGPONG_3,
>  		.base =3D 0x6c000, .len =3D 0,
>  		.sblk =3D &sc7280_pp_sblk,
> -		.merge_3d =3D 0,
> +		.merge_3d =3D MERGE_3D_1,
>  		.intr_done =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>  	},
>  };
> =20
> +static const struct dpu_merge_3d_cfg sc7280_merge_3d[] =3D {
> +	{
> +		.name =3D "merge_3d_1", .id =3D MERGE_3D_1,
> +		.base =3D 0x4f000, .len =3D 0x8,
> +	},
> +};
> +
>  /* NOTE: sc7280 only has one DSC hard slice encoder */
>  static const struct dpu_dsc_cfg sc7280_dsc[] =3D {
>  	{
> @@ -247,6 +255,8 @@ const struct dpu_mdss_cfg dpu_sc7280_cfg =3D {
>  	.mixer =3D sc7280_lm,
>  	.pingpong_count =3D ARRAY_SIZE(sc7280_pp),
>  	.pingpong =3D sc7280_pp,
> +	.merge_3d_count =3D ARRAY_SIZE(sc7280_merge_3d),
> +	.merge_3d =3D sc7280_merge_3d,
>  	.dsc_count =3D ARRAY_SIZE(sc7280_dsc),
>  	.dsc =3D sc7280_dsc,
>  	.wb_count =3D ARRAY_SIZE(sc7280_wb),
>
> ---
> base-commit: efb26a23ed5f5dc3554886ab398f559dcb1de96b
> change-id: 20251231-4k-969b53d2ea4c
>
> Best regards,

