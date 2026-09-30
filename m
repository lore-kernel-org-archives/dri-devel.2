Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB85CA5FBB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FA010F425;
	Wed, 30 Sep 2026 13:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JTI5pPOM";
	dkim-atps=neutral
Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com
 [74.125.224.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB98D10F427
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:53:00 +0000 (UTC)
Received: by mail-yx2-f38.google.com with SMTP id
 956f58d0204a3-675617094f5so1846051d50.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:53:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790776379; cv=none;
 d=google.com; s=arc-20260327;
 b=Ll0WhzykKhYBCUqCmrJn17Qwd0+p6D682SeOdq6og0DBe2O/xEIMF8v+bIHq6CGtN8
 L7akpV6tl85uRjMZ5Xh12WigjIyh5H6qkkULPzJP/3uZDfOFPK/WT9JINiPF2QYSCRPj
 hLCtPjlO/ESTxDpemoEU5J61OZq/5K36egPf4U8pKKS9U1qkJS96uLI+/vOsqQZVaabv
 cI9yKKErR1tcAcy9B9dMawbJhoSlfhv0zl5a2Z0NUbCwVYnNFdMaBq+durrprd6yMp03
 vnZjAO/LA+1WFdBr+wp3bsUDm7gA2TrH7Ukm7iG1f5esZZxQQ0/CD19c/b2Z9WfiDyHZ
 DlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RpNeLRajldsJyb03io5TqUKkBsu82dkOKDvxIHvX4/4=;
 fh=Z6YtaPgqzTg5JnSx+o8cBKqup38lyg6fWoVZW+qBgII=;
 b=bkjBBx4JmlWf4nWSt7Dn2oLmCdjWU73suLICXeYnmaotveknsEFK8BFqchoW1YsJd0
 99fBE5EPnFvDwuo2FRPQmxnD/SMazdXwSgrcVKfFD4KXeeTiGQUz77jiH+4WQYfLfhJb
 uxAIZWIVihrR8xArVIg8IZ8dfZHZ3uejoFCmn+62QB24WuziHZcSSe+vTCcvCiEpW285
 Da/XkGEy+kF9jdCDZV7eM1ka1fRtb2FCccac12zoMbsoGyZqpx2icHsaL5g7gaK0FGqz
 3TFxNCHbV8tkuQktlBIYHUVIzl5T8AkdWVpD5q9wkH2o7RhygfR5Anad/LoEqgibxgWt
 YJ3w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790776379; x=1791381179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RpNeLRajldsJyb03io5TqUKkBsu82dkOKDvxIHvX4/4=;
 b=JTI5pPOMQF6a/OURgtx3n6Y+SXpptfQdLTShbrz7OmSq/dSxb1hQA48m78DvHMKJCa
 hf8gg9pLbwMvWi/d7DS56cGJsTO72qhGmn5X57VHpDrp6br6hjV5osYsOchza1TwolXK
 0gLBjttXG2d9ecRoEKaoAeL9/gAf7Tc/qDnR19APP4CIK7blcG2ndD/SD25wnObJhDBM
 CQe3LuBik4o8bDTaKYBRZeupiNG1q5qZoU++BahI4vp6v79kEnh+C9yNVWlMxEdBPct8
 aD5IcpYksO4/j/+XyOy9eVeS3Q2vGLGEY+4c8dnxl04Rc1Tm2vr9zYmIqBhbHArscFWM
 fQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790776379; x=1791381179;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RpNeLRajldsJyb03io5TqUKkBsu82dkOKDvxIHvX4/4=;
 b=PTbxsUTZpULC0tFusgwOhSplQuddVjmESCqjbEEGrPu6OaSRVMKb+B43NWYUDu3tZl
 9Me2hI+8YCwzikOEGwV16ku9V4xsDr+vZb+xovMmc5NgC5DrVcI3n+HoZtqN3Uy5KRlN
 r0jalWKyY3UehXBY9GjmYSu8BxCZkyctxlNlfTHX/PmstYtGtZLXdDqaDo5x4elxwczs
 JCMS7YOqDoqi/C0m3xNrYpIauqfRgFUt9nqO1wcwyxqPZ7NkeFCNZcWiSZS6e6ASyogF
 aF0VJYUZvcRMXveUtcA2xnXNxvs1g5WLSzAjAvjLotxahZ9AveL2YVkWeOm/xHged3JN
 y+iA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgG+u1Z5gznlU34V0CB3T4GYcohyT+Umbq7IiAsaQPZmSbwS6dOCgqvK04SBu5uUEeQKWAO9o5WT0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK9dsMnzeW5LRZs/s+C/1QAQyPZnCToe1yuhk1DECcv/hjRIvUZ
 DBG9qc/b4SG8SuQAdgXuf4P0uphgugQL1daNLHhprVL/DJgf0FPqacojVfei6uICKQ7yKDITuSa
 lLnwV6HuUclFoO0wffREGHpDMLQgDfWHDgBPRFfsT/A==
X-Gm-Gg: AYBFou2bfF1jjsoaW9H7U9y9zoXhjE6YLw2lvqgf5JwvOJPoU4SrpZYY6UDj+BDPb7h
 m3tgWwgczKigbfitKwNiacJ8N34iCtCvOz2GP/KjI8VkwR+SgwfJ+JFJ8WY626WUVXk7T5hCkI7
 YeVRP8Gff3yb0tnhcqLOg+Mm69PKz5yHjBo18AiwWu2BpgL+LGWS2ZdpDBpIZ6dc3dmmy/LWcS+
 Ft4oRgzKUNv5h0uxtytegFzYeGCjTahSuDCsUHyGwcCCyEJsrGTHdJQmm6tWTPKPmEjQGJCDHOi
 O+HLc/OEIcAiECAF7H/MXrREoWrGb/QLUlEcHrNSJaeSl+7aPvnYHo2I9xzkMxN7
X-Received: by 2002:a53:bc0b:0:b0:676:24e2:c67e with SMTP id
 956f58d0204a3-6768351ba5fmr612451d50.89.1790776379376; Wed, 30 Sep 2026
 06:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-3-c042266b9eeb@linaro.org>
 <gu22hz3dnttzyu2eewpalgzxtocmlbfvnpwore36ufmyr3xtag@r5bbhafsn562>
In-Reply-To: <gu22hz3dnttzyu2eewpalgzxtocmlbfvnpwore36ufmyr3xtag@r5bbhafsn562>
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 30 Sep 2026 21:52:48 +0800
X-Gm-Features: AclHuK_VxnR8JOsc80IMzuEQ7RuAU15Ps6hnH2uLVe_uy8XWpyeHRK9yzrHieFo
Message-ID: <CABymUCNtcgbcRNXdMUjVdnH_ybOxjFB31gd6AW-0HCFDSn9w4g@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] drm/mipi-dsi: Add flag to support dual-panel
 configurations
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
9=E6=9C=8830=E6=97=A5=E5=91=A8=E4=B8=89 00:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 27, 2026 at 04:08:42PM +0800, Jun Nie wrote:
> > Some devices treat two independent physical DSI panels as a single
> > logical panel from the CRTC's perspective. However, two separate DSI
> > hosts are still required to drive the panels individually.
> >
> > Introduce a `dual_panel` flag to the `mipi_dsi_device` struct. This
> > allows a panel driver to inform the DSI host that it is part of a
> > dual-panel setup, enabling the host to coordinate both physical
> > displays as one.
> >
> > This change does not force individual panel driver to manage
> > system-level display topology if the driver does not intended to
> > support dual panel topology. Only the driver that set the flag to
> > true need to take care of panel topology.
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  include/drm/drm_mipi_dsi.h | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Do you have a single MIPI DSI device, or are there two independent MIPI
> DSI devices? In the latter case, the flag is wrongly placed.

Yes, there are 2 mipi devices, and 2 mipi hosts. This flag is used for
mipi device
to notify host they are one of dual panels, so that horizontal
configuration(width)
in mipi host can be handled correctly. Where do you suggest to put this fla=
g?
Thanks!

Jun
>
> >
> > diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> > index 2ab651a36115d..889ef1421207a 100644
> > --- a/include/drm/drm_mipi_dsi.h
> > +++ b/include/drm/drm_mipi_dsi.h
> > @@ -169,6 +169,7 @@ struct mipi_dsi_device_info {
> >   * @host: DSI host for this peripheral
> >   * @dev: driver model device node for this peripheral
> >   * @attached: the DSI device has been successfully attached
> > + * @dual_panel: the DSI device is one instance of dual panel
> >   * @name: DSI peripheral chip type
> >   * @channel: virtual channel assigned to the peripheral
> >   * @format: pixel format for video mode
> > @@ -186,6 +187,7 @@ struct mipi_dsi_device {
> >       struct mipi_dsi_host *host;
> >       struct device dev;
> >       bool attached;
> > +     bool dual_panel;
> >
> >       char name[DSI_DEV_NAME_SIZE];
> >       unsigned int channel;
> >
> > --
> > 2.43.0
> >
>
> --
> With best wishes
> Dmitry
