Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0A1F4613F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D51D110E445;
	Mon, 23 Mar 2026 22:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SG9o6oOP";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF6B10E375
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:54:33 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-35448ca4689so434950a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774306473; cv=none;
 d=google.com; s=arc-20240605;
 b=H0HQYcn/Zg8yr04bomCjr+2uen/leku2jpsNnK7iThI66jPM7pASs1pzdo3hizkWVH
 hAWheDOMK3uGsWwG/z+kwccn2PAlYyHTPu4Ksn2gOP/Q3+YRjlMnCqNosHEyMyOAEZAt
 5ZEQy6yCnh9w21e8RGO1gDKw9Dwt9dSvqdGy5eXpXTq9qhrrLz1wtKaV78o7SXbRKw84
 5SG2V/WrDksfJBdz8X0s3BdRvhMCZwJRMQJoXnwsvxTVguBIo03KKuVCq7ddmg9n09y1
 ds3eby0fRsSZdaP2GRvKHbleRKtNqwjYFSqwoCUwLVk1b7bEDp0YIDN7SR7HNwymHOca
 Fhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aLfrCEkXhRllBwye3r7LV622d9pqnMxcK044kOIY8FU=;
 fh=U0h0024g2FYSpo4/ocEHBcfA3DQrzlcgEVXHzohDS6s=;
 b=K/vSTKKa71aFC0tPen42Z7dr/5DX4vS1eHg2ESONG1N9Y5hDL5Gztg6bXmBrKZGsEb
 hBM4D41+X3inbIngnVEsqsFyUrumzH4uPJXkEiGRVPGJBURoW6ZiPys/AKO60CVWBMq1
 dv/6059A4911i+L9um3G0Yp8cwPosY3hNi7WBq839Hc+hMshJ3qNwkDEB4OksdefSnWP
 RBR2Vvh2RyRTVsG/4X6WaTp5+XihCDA0RKlMWTLlaLhDmqc4NcaVHAulxRL4TQvd4dgz
 Hng1wTJ38J1FzHEQpzXij5qudpDrrnwktjCPyHsIJ6tqPB9YDADNYLZIo8L3jrERyXEd
 LPsg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774306473; x=1774911273; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aLfrCEkXhRllBwye3r7LV622d9pqnMxcK044kOIY8FU=;
 b=SG9o6oOPzCVpzzrgC920s5ZsZL3v/fo+zXgxOxzY4guS7Me0OKuQ6pUaQJ+876YF6h
 /WjsQ/apLy3XHh4JgWan91bPVzf9Q94+5zWT//Mn7LCgK75gw4k356cr0Ns/9IiREH5X
 LlRJpRYA8RYaaVH8OeU3+3NWksLQ/hThPyvTGVStenMw0Dqps3vZH8l2SseWVgPultoU
 LHt5+Aa5TWUPmLE89/JtO/3xi/Ks12erV359V0roolBkLS3hF5iYOOGmM92L57Rzu+Ki
 E0JYwrqpbpDI24Ro9cG4Uy4XwgwFnI2Mh+Wdj7TZjeA4Ld9dqL8eLbQVHjTH4YbdUeHJ
 v64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774306473; x=1774911273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aLfrCEkXhRllBwye3r7LV622d9pqnMxcK044kOIY8FU=;
 b=BUMjGKsUVGRftjDVEabnAxwPzpKRisBfNRLJQGj1V7oHRPOzyFif/gXnTZJAiswV2G
 w6/evqCJ6DNkhnLSbaNi/ShKALNcNu2e/bIhrt9OTkHXEp96VfplbUX+PvcHJm+d7Eoe
 Ys6aUbRyHcmtgmuCe2MqW0Sc6tcvXhX0HzerciQmNyGLyYM7Xkghg4Ji3G0XpDGsE39b
 S5c3Ybi2ix/4J2KOsi/hoefYJQanWh3Uk/HXYMSm1MkMKvzZDWkFvBsCkQz44nE9aAMG
 53QAq+QD1XM5HK3UkWKUXJ3DxhqXYr7At4s+sHCwms0+c+TK6jCLEZe0Qz/FD7JSFR95
 qRmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2MgUHFTi1q92gj/RBNOcLFW1zH9wVfE7W9TBkXqC3YCbQFbgwkrFrEOe0MPAXWCJXU2VduHBq98I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9cLjBSkQizCG/IJsjIZ5k/7EriVIGetgcsGsh8AjQMIRbb79k
 Rctap8lkEqHx2pcdmjTDMCnzgjCVIhjpD4zBiLRrnfNrn4YMHaR4sox4IElsGSos/hy+PCmircI
 kXlBPSkgyjBeZfqQNuUtkKtVN/NrsMb8=
X-Gm-Gg: ATEYQzwhgW8ec+BU9NphURmZ8VSuek85HKVI9Bmcq96AxrnDPKUDTJm/8889dSlcUFO
 nBR2PeZhaGD+kkDsMT3vXoqJYhvDZl1XXWHMXzsY0ZumtsdwErPnOWQ6thKHgsoRMeLvTaEja6u
 AZOS644WX1NS8/S3ajMDRe90Jdmf3V37ZdtrPnm6Kd5TtTRXlFF2sSXrMn6hmEYJEm+J0BsaSuQ
 KHJsBYMjG5qSlNSfGMVldQTt70+tB5wb9fEuLW7ZcTzYZnsNVhewLWAWxpQqPWiXDsftKz4acEa
 xx1n4+k=
X-Received: by 2002:a17:90b:50d0:b0:359:8e93:4fd6 with SMTP id
 98e67ed59e1d1-35bd2cb346fmr8560500a91.4.1774306472800; Mon, 23 Mar 2026
 15:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-16-fc95b8d9c017@oss.qualcomm.com>
 <4cj3yheakuxh75hf4r33ukokswa7fbr4cetezrj7mujb5mcxjl@fqoek3yfi6ep>
In-Reply-To: <4cj3yheakuxh75hf4r33ukokswa7fbr4cetezrj7mujb5mcxjl@fqoek3yfi6ep>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Mon, 23 Mar 2026 18:54:21 -0400
X-Gm-Features: AaiRm53hFiG8c1KgnSj9JcdEvJhhSQ0Ko88DFgY_jlrVuts--4wM3FRhLLDQCpI
Message-ID: <CACu1E7EkjbUs9bc3BD69AaAo4B0t3si-8U-VfCYvi4KVk=Utkw@mail.gmail.com>
Subject: Re: [PATCH 16/16] drm/msm/adreno: Expose a PARAM to check AQE support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Antonino Maniscalco <antomani103@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
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

On Mon, Mar 23, 2026 at 5:36=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Mar 24, 2026 at 01:42:28AM +0530, Akhil P Oommen wrote:
> > AQE (Applicaton Qrisc Engine) is required to support VK ray-pipeline. T=
wo
> > conditions should be met to use this HW:
> >   1. AQE firmware should be loaded and programmed
> >   2. Preemption support
> >
> > Expose a new MSM_PARAM to allow userspace to query its support.
> >
> > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 13 +++++++++++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 ++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
> >  include/uapi/drm/msm_drm.h              |  1 +
> >  4 files changed, 19 insertions(+)
> >
> > diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
> > index 5c67294edc95..b99098792371 100644
> > --- a/include/uapi/drm/msm_drm.h
> > +++ b/include/uapi/drm/msm_drm.h
> > @@ -117,6 +117,7 @@ struct drm_msm_timespec {
> >   * ioctl will throw -EPIPE.
> >   */
> >  #define MSM_PARAM_EN_VM_BIND 0x16  /* WO, once */
> > +#define MSM_PARAM_AQE             0x17  /* RO */
> >
> >  /* For backwards compat.  The original support for preemption was base=
d on
> >   * a single ring per priority level so # of priority levels equals the=
 #
> >
>
> I think this also requires a version bump in msm_drv.c

Not really. We can just assume it's not there if the ioctl returns
-EINVAL, like the other queries we've added recently.

Connor

>
>
> --
> With best wishes
> Dmitry
