Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3860FFED9E4
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9992010E6DE;
	Tue, 17 Mar 2026 15:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="U347w8j1";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBFEC10E6DC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:55:54 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso923814566b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773762953; x=1774367753; darn=lists.freedesktop.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWDB8KL3PBcEqK0ozqAtIpGnPn1jWzWERBO0Z7aA2SA=;
 b=U347w8j1xX0UvAbLoqE5EKvuv/VRoHrEhhX/+gxffKQk8KboqaLqcuXZ+WD2YkFgfe
 XryGe6BwI1yy2QRTPNJYGT1pa+U0g2pJAd/UedhT3LlNf4V2AL3aUNsnfvIRc8/qeN0f
 yCnx5QQlUPRAaZ68LFV+20+h2Cm/WkhEcvFFPNW9L+DOF7QL3grJtYwrSu4SKRCu0oXV
 7t/p5hfSStlUXaPiK+Mq95wuL1Lyye9Hi8596OuKgXJ8NAZQiWPuDydJQ/6aOaDfb+Xi
 Z5fGBhpXpIfGkxcS/MGyOcVHYV5LVh1vaIHuPQWzXyer3uKHPTiNHknFrljrBFHug9G6
 l6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773762953; x=1774367753;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IWDB8KL3PBcEqK0ozqAtIpGnPn1jWzWERBO0Z7aA2SA=;
 b=bJkoMMqViH8838T4Z9z0bAnTIH4y5W/GuETrrByhPTw/qx2ci2MLXkfa2VbSZG8CwH
 s6AoaDveqj3gw58zujlDKsXwPJinMbsCJHUav1DzENSdfVidwJG60VZXoHX84VdHYmQ9
 KKQT8e5Mju6SlfRgrad5XJ3uPlQhRdfXgjjVJVNwJuZDRkFHxY12C5j6TuoAsr4lVNZy
 AbC0oFxg3Yj8u6ZsRq4iAtW/fpmNKqz2nAuNXOqPZQJJy0jMNnqsqnxJgS1YoAkZXgIP
 YXXyKd8Z1EQNiAEOiOKNuzIeD1hOyO23pIyatZQn2oshaEM4DYClAQ4ZpETt/p8ULXY9
 8CGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKXlVly/kDB+aNz9DtzCXPKdNNTLF+5nI69rV4TI/lUiyTPlWnKlbWHZmoOpVWbS/digbLZ5KjJ4c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2MUwxRv+hKfKxshpEDzkAr50NK8tL6DxQS/xJAUGdZcKwy6XR
 E+UNfUNhiAKRsGmHhgfd9XKCS+hzNTXZqyT2RazFJ03VOTriab+k3uadUz+kHTjUL/o=
X-Gm-Gg: ATEYQzx70ZJsGr4AteeRt7G1Of4jd5/5o6As7NpsgZ3YNEiL2//LmFUxfosSPsPE9SE
 PpJtzi0R7yDeJk6j7Bojfrzr9Wsp8WEDc281j8k8kWQJS5iotC6E3aWZ6ZQTJcJeNSnVLoOgnxa
 2YDKR6eHWq28SJJiWqNjADrit5kJ35D0S3APS4Kr7Iulr+3SWUSe2XCunkdH5MytH02+rnytqlF
 hgCcBtkiiSDD1pPybx5qS7rVaboekIgBgNMQhdSyXZPmH/yLewW51sb6zu2yTWH8quCVuDVqeBS
 LQk3FyGs/Pi4DZenBkqoQ/ZLQizY7XWxseupxsY+DnEtW4XkoY+vnLcX/98CZTboucm7zx7rG+s
 nrZyLLcqV++VrwNG7cjZElhtBfPG9U5Zo1IdAJwvRsNWAJ5ZAKVDKhFfo/Gpytx5uqUOOSZe9ZX
 oX6XZGlVnMlrVizigEHA81v14mra5NKOUfDkn60f8xE/gS8Pj1vbrFV8vM467mEYuAxeFh
X-Received: by 2002:a17:906:209c:b0:b97:3376:7ce with SMTP id
 a640c23a62f3a-b9765153c1fmr602242366b.26.1773762952679; 
 Tue, 17 Mar 2026 08:55:52 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f13ee5c0sm15707366b.5.2026.03.17.08.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 08:55:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 16:55:51 +0100
Message-Id: <DH56HMTRUY0M.VHEHW4AHW1XH@fairphone.com>
Subject: Re: [PATCH] drm/msm/dpu: don't try using 2 LMs if only one DSC is
 available
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>
Cc: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Luca
 Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317-fix-3d-dsc-v1-1-88b54f62f659@oss.qualcomm.com>
In-Reply-To: <20260317-fix-3d-dsc-v1-1-88b54f62f659@oss.qualcomm.com>
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

On Tue Mar 17, 2026 at 4:30 PM CET, Dmitry Baryshkov wrote:
> Current topology code will try using 2 LMs with just one DSC, which
> breaks cases like SC7280 / Fairphone5. Forbid using 2 LMs split in such
> a case.
>
> Fixes: 1ce69c265a53 ("drm/msm/dpu: move resource allocation to CRTC")
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Closes: https://lore.kernel.org/r/DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.co=
m/
> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # qcm6490-fairphone-fp5

Thanks for fixing, Dmitry!

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index 6bf7c46379ae..96b67ea3fb4c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1410,7 +1410,8 @@ static struct msm_display_topology dpu_crtc_get_top=
ology(
>  		topology.num_lm =3D 2;
>  	else if (topology.num_dsc =3D=3D 2)
>  		topology.num_lm =3D 2;
> -	else if (dpu_kms->catalog->caps->has_3d_merge)
> +	else if (dpu_kms->catalog->caps->has_3d_merge &&
> +		 topology.num_dsc =3D=3D 0)
>  		topology.num_lm =3D (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
>  	else
>  		topology.num_lm =3D 1;
>
> ---
> base-commit: 50c4a49f7292b33b454ea1a16c4f77d6965405dc
> change-id: 20260317-fix-3d-dsc-4b073977ea19
>
> Best regards,

