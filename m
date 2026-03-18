Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03714103E183
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA0610E041;
	Wed, 18 Mar 2026 14:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l29KzxEm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/LX4zr8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDCD10E11C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 14:23:04 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62IBBATs320117
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 14:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TUh4I7sO2YLCMMOdv6qQad+D2pc7UYmsbiI2qmFYL4k=; b=l29KzxEmrTChTI6O
 ov7PDuAXbT5QdiXojpuSiRQYRshl0FFbwZZJrkIeDSoMRr7oNqvSHrzBYsOkhXJ1
 8qt/qLHouePy5Zf+v24I3Z7XMDthteZLqxtVYF+qfSFdU2iGjTD6+H4N77cBCdW0
 ZT+sqEkobUFiUaBsVYC21sQF0X/bv0ILCj09LjDN+UXNZm98n3omyO0rDPDUBTPU
 A4ukXrt/lYojsyeUxyjKh8L9cey+r6poD5JgknDaoGY/rwd30Ki85CkVVF70tiv4
 eMULGZtVHjHiXVmzNn65rJ0vki+R1j95elyuQYDh2BYJ/gsYYsVdvSb5caDWnBQv
 G5yAaQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cytxyrmhj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 14:23:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5093a985e21so541789441cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773843783; x=1774448583;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TUh4I7sO2YLCMMOdv6qQad+D2pc7UYmsbiI2qmFYL4k=;
 b=W/LX4zr8N9HEUdYOQ4I2PdktOnAA+cv+bCe5/OKYmmhdvEUh2niPexh7m4LOtXJFZf
 JlnOHZ578sCXwo0794HqdcLOXv1PBvfnJSb4sxDv3GDZEZh5V/Y84I/YL5vgSUF17QPE
 UhL0v4tuvuGXMvgMELqSEscR71OdQm9Ld0dgi/rX6rWHuz+fffhir3Q+6Fd1pvU4fKrH
 /RmV41spqXmrWg7p3ztq9/i+IvdobGaszby77sOvKfZLpWO5l9b0DdVgnD6feJeVVUna
 Da6st5NtvplV6D/PPZOJSpICH2qS1lhDdY32bXWEVuZmUVuzUG7jp5vjZpEikNcxjmEw
 5pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773843783; x=1774448583;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TUh4I7sO2YLCMMOdv6qQad+D2pc7UYmsbiI2qmFYL4k=;
 b=l2hrhqMAXCy5HegE4MQQgnGQ/NYCns7FscWRQ0+YiV0sC4S1isICaQWo7Nh95jthlb
 81N+ZcuhEFS4P3esf/V8p/0VnCv5LKICNI0IQprgttY+TA+zZ+vPv2V9S/z4G6iulEJJ
 ckDYNv5GlOhsBxCVY+IeOkprsw21SIIgE/NoU98UaKmz/Rm7DH1CBuLbbf6ZItwwUHc4
 SJ4vKbw6h7BlurOvqe33UbIhNd2Mycw5yUiZNjlyt+9K2vn2zDK4ifjuilgWIw64jwkC
 NmSkA7JLJHDPVrxdxrShFaYIrtlF2JdPCSSkugEyfsLGavaHYBI578xm6jyjkhZ8QPqz
 PUew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU9mMuBs/NvxtDtLgoubw70+A0kNCWTfC1zCres9vd6yu+SwIvkS2lTq4yfQSz5inQ1Oednd7BGHM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMHOGKe1ij5FbkE/ZoAGFD0PmqgqSIARXCeoYulOXGPMidDerw
 VWdEfKccdzQT2poYWu2hq4yoLom3Npv4rM7+xP+6IzC9rtdZgO1o1aYVf6Cvn66LCif2Z0WrHqP
 WU/W7nyeVw2Kh9KsRAejnl5gOtVgnJ/bBVXpxF7mKiLHnuv8wglmw7pfiWJeLo/Sjp7sn8jk=
X-Gm-Gg: ATEYQzxaeIP6/ZMv0P4yNdZoFrLi8xcfopEwL7/x09xC6mL5d5x1m9HQ0y0WxVlLrRK
 pSJ5i4PsJOQlU19hRLxgFNKkCxa5hJbgizrVMORaJq6OvKk98mte5IzlD72YndK/8afXGSp/SV/
 vgRkgVREQyowuvbs3Gs4hU0Ar0INYyPWaxZpLkPohOCH4DDMC55BC2vp+7FWLElaZMiL9j9DMKN
 ETBdeGT7Adc7TDk9GOk/eXDi4rscsh4u+F52Az5Eyr/NFQpWGrcKopmadpzua0cN53O1BLeCIbb
 jweASAv2Z1uQBvYOpfvbZd7SKuJEUNQlouY/vPaqoUcqGNc9d349QK6Y5z//1w9TtsT1w7rRy2S
 EmG68jt67CnPqQBuv1xkWEnBhic3dyfIhSyUJFXEWtOOsKuZ7kKReM1+0krWqqEolMofEseDn5f
 DluH/iMBYRy2+Ur4ALVNS8a0I9BPIBgp0XqqA=
X-Received: by 2002:a05:622a:110b:b0:501:3b93:bb37 with SMTP id
 d75a77b69052e-50b1487e881mr42201081cf.39.1773843782728; 
 Wed, 18 Mar 2026 07:23:02 -0700 (PDT)
X-Received: by 2002:a05:622a:110b:b0:501:3b93:bb37 with SMTP id
 d75a77b69052e-50b1487e881mr42200261cf.39.1773843781999; 
 Wed, 18 Mar 2026 07:23:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bd5156dedsm6176061fa.3.2026.03.18.07.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 07:23:00 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:22:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?Q?C=C3=A9dric?= Bellegarde <cedric.bellegarde@adishatz.org>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, antomani103@gmail.com,
 mitltlatltl@gmail.com, krzk@kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: fix vblank IRQ registration before
 atomic_mode_set
Message-ID: <ubxvfyx4tugfliwffrrlbe2oliep6nhp5dbpjry4vmamldz2ow@qncsubi7heex>
References: <20260318110126.274347-1-cedric.bellegarde@adishatz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318110126.274347-1-cedric.bellegarde@adishatz.org>
X-Proofpoint-GUID: yZodf-yYHXG0e1izoSt9c3u5PxB0fSRH
X-Authority-Analysis: v=2.4 cv=FKAWBuos c=1 sm=1 tr=0 ts=69bab548 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=LCWlJkpBAAAA:8
 a=h7vFti6rFQqOaJsGGxgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=dawVfQjAaf238kedN5IG:22 a=z1lahxahPt366DkPXCx7:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEyMiBTYWx0ZWRfX+z6hFZ7FxNtH
 bzYuGJQW9Is0YLUPep8L/Jjy21UKEEI3d7w+Cr3HNl+wHA7DlN9wLjgmmxgJXNVVANcDEjy972d
 1zOq/Qg70w6gVLtvZt8Y9w8p3zEB3VwYbel5tOvJSnKciizVTj5df+72t8P9PMaZk70PqiF4lZX
 7+/IWir4CMXcWhmV8kuOSPEVuarMD5QZT+cwW5RoKIoyUsVQazpNW0jPzcYe3bUX5uoHXuoVNcQ
 WFZLEnKUaRG8kPvJhrRiTw8rjjrTInKXwfhf1R0XjQ8iqyhKrtREiIfCNLkQO39ooS0uNh6oKUt
 FnT/H5kmWLJpzAFiM/1UsBDTYg0YzpOkZKZKIF0rd6Hb+4AIrSIGBQG+0n4htxiEWDBovrjUcni
 RJys9//GoUV5tcJkekcv7UZ2sbgMIels9BuDagZa9kvHSub/36M8CtEg313HzyfWXqHOYVUr8Pu
 keUeFpfeMahTA9Vb4/w==
X-Proofpoint-ORIG-GUID: yZodf-yYHXG0e1izoSt9c3u5PxB0fSRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180122
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

On Wed, Mar 18, 2026 at 12:01:26PM +0100, Cédric Bellegarde wrote:
> dpu_encoder_toggle_vblank_for_crtc() can call control_vblank_irq()
> at any time in response to a userspace vblank request, independently
> of the atomic commit sequence. If this happens before the encoder's
> first atomic_mode_set(), irq[INTR_IDX_RDPTR] is still zero.
> 
> Passing irq_idx=0 to dpu_core_irq_register_callback() is treated as
> invalid, and DPU_IRQ_REG(0) and DPU_IRQ_BIT(0) produce misleading
> values of 134217727 and 31 respectively due to unsigned wraparound
> in the (irq_idx - 1) macros, resulting in the confusing error:
> 
>   [dpu error]invalid IRQ=[134217727, 31]
> 
> Since irq[INTR_IDX_RDPTR] will be properly populated by
> atomic_mode_set() and registered by irq_enable() as part of the
> normal modeset sequence, silently skip the vblank IRQ registration
> when the index has not yet been initialized. This matches the
> existing pattern of the master encoder check above it.
> 
> Signed-off-by: Cédric Bellegarde <cedric.bellegarde@adishatz.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index 1aa74ecb08be..8a3e09d21c38 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> @@ -256,6 +256,10 @@ static int dpu_encoder_phys_cmd_control_vblank_irq(
>  	if (!dpu_encoder_phys_cmd_is_master(phys_enc))
>  		goto end;
>  
> +	/* IRQ not yet initialized */
> +	if (!phys_enc->irq[INTR_IDX_RDPTR])
> +		goto end;

No, it will return success, making the rest of the system wait for the
vblank. Instead the driver in such a case should return -EINVAL or
-ENOENT.

> +
>  	/* protect against negative */
>  	if (!enable && refcount == 0) {
>  		ret = -EINVAL;
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
