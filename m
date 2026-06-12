Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F50CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6D710F2AD;
	Fri, 12 Jun 2026 07:23:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hwKrzARM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dny47B7L";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D8210E2CC
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 07:23:15 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C3CAR12534828
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 07:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Oi02IyzSr2sjg28TGbtMd8Pl
 3gIGWlHwztSqBTj9Kew=; b=hwKrzARMcTQhsrFdvIsZn/qzAlg7kEDPSZhEWjt7
 Z2byHXJe0EU9fhILDX6Y7/KJxV9io9bDE+aN3kY7JxgMRKhxHNVOipJ86zpR/4ER
 pYj3yvVpGw2OLYu3cdD0cNxJYWM/w6oDVH4k7/TyJO82o3YL+iMag6BIZpb9k/I8
 XSftKm1s771YfesjyHfyJaceyuL/EBm4tEXNEwqUFLeNNK5KDoULunbyVYHZgkDm
 /MEdAE5bCvZakblrN7mYe6H2jOpJcuJud6EFC5DzU1oxK8HAQ+LS1NxtN1uW+Bmo
 JjeKJkR+IU7fBg5D7EitRiZ1radArMrND+lLo5pFNpfvqA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er76eh1su-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 07:23:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5178aed25baso11839021cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781248994; x=1781853794;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Oi02IyzSr2sjg28TGbtMd8Pl3gIGWlHwztSqBTj9Kew=;
 b=Dny47B7LhbLf9+b1grJ7DmaLXx/9uuDO5qerSLJ+XXPHkJ5NFhXzvGh4GADK5I3zVq
 czLBiMinvSK5jUULRmsCRUAWWm/RNidQK//VxRmDds1hKXtTVgja2PzPXSyhBxdDfxgw
 9obY/0xJZi3hCqF7ZXF9EdcXb3kDam37aaywgb3xZGEBdCHKDPQzgMKbu+BraUhpqqT+
 cLJ0KKZkAeYxSOZKypmSOd+5L74QBrdpXizLg0nLO9VCU9bKw5mkhWMedkUnTg3emPkG
 BLcNkLEWouKfWIDpR7f9TsNrUBOVyyH4uWVz/keSGvxSb6nf9ML5IZizeBQxn2Z+Kzac
 b6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781248994; x=1781853794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oi02IyzSr2sjg28TGbtMd8Pl3gIGWlHwztSqBTj9Kew=;
 b=gXusCQYkMcgceHfj2GJSvV9kLEAFWcDxi62+1dNBpMCx1JK+WtAieNN+zhgAaLYw/h
 /hrOehXYHzHVKaFgWADPlFLEWa8utGobazHj0p7viGPiri50qtFaIsNPs9SOebKoHbsg
 0B4mF1OjAOUviWBvOvmrYURQ/erGmJZjcRka+4JGZNJuZIaE1Bj6PcZKixY/gZtH1LxL
 hMlRyal3gUQ/NIzs1/TBPdnFWUCNXpMVLYXhN1FFeFiWt2bGvtwdyXvDlYkzymUAx84M
 +E2XqqlAuE2RGUMCbFpHG6xUDtJ6SHLSLjLdvbzR5PeKW9+zI7ObeBFdPRAP1Ig3gzAW
 mjMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ejhuLWMgayu0WjoVlTfFHzBnRwgtmAPCgZHMmd+9080SvSKYhgpxeVrUv0YeHe6Lz8MhD3b9u9KM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzU8Dnb3zFw1yROog23IutN+dA7S/MOfnUo0tyHwxDE8pSMHyfe
 Hfg45ugqi1eiNxMv/powvyFArkHjjWf3BlICSsqoyfUSu/I+bWKeOBoZkrnKYGUKo4cZbznFPMA
 L+pfz1yGf8u+Lc07tGaXTY/X6V9zHY5Ff9hK31PP42I9YkYLXi7oz+OgchEaXM30yeNQiOxo=
X-Gm-Gg: Acq92OFY8yks5w+oEiSIrTgZA4Cp7n4OUd1RPQthzBzyO0zYCwRnfHZAXgLu8pmuiRL
 youlvtcMkO4gjo6501u85rvYhhvaKwhzwcmWrJcbIF2DDEvki+IdKth8zVtFDRWzvofrDWDnFJe
 AtE2e+iX6YWMcUHJDODC7Os/McPfTApouZUJKpR5wde872EfvX/hDW1JdYkZw3TCOAxV0uiqcSt
 trnsu2QBM3KYFIIDJMiYSipR9VaCJPuNxM+RERMim5cJJL3WrjK8+PIrGfc1boDX0rrJvwmuEA6
 AUa8pu8+1b1FNjqY6+2d5iZG43cn1nAPOCQTPsZ9aYtgs2vDmVBrD7qrx9QQnwkiNeOb6s2m4dc
 srTOkuXYEZmkHVmPxtSQN4de2fVpJJup+LUFF/JvDVskn9FmL+7JvcPBI3nKCwKL4oQd0B5YLs/
 X7O4Q5TvhapXIZK0NKgz2V0AXLpu6drS+NbUY=
X-Received: by 2002:ac8:7c4f:0:b0:517:71ac:83f5 with SMTP id
 d75a77b69052e-517fe1aa0fcmr22361271cf.3.1781248994292; 
 Fri, 12 Jun 2026 00:23:14 -0700 (PDT)
X-Received: by 2002:ac8:7c4f:0:b0:517:71ac:83f5 with SMTP id
 d75a77b69052e-517fe1aa0fcmr22361041cf.3.1781248993841; 
 Fri, 12 Jun 2026 00:23:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161ee7sm297670e87.13.2026.06.12.00.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 00:23:11 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:23:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: contact@alex-min.fr
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/msm/mdp4: keep the bus clock enabled while a
 CRTC is active
Message-ID: <eopgalgvpit2o633qqma26nailhgmktuhdwhrthh3qgkyg7f45@qjcxwiw2x4yk>
References: <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-0-22925600e4f2@alex-min.fr>
 <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-1-22925600e4f2@alex-min.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-1-22925600e4f2@alex-min.fr>
X-Authority-Analysis: v=2.4 cv=O94Jeh9W c=1 sm=1 tr=0 ts=6a2bb3e2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=DVHo1nXE2ezVO6JEMkYA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: vJ7K66_ulSZsdEnS9y_SkM5VkFxi2F1K
X-Proofpoint-GUID: vJ7K66_ulSZsdEnS9y_SkM5VkFxi2F1K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2NSBTYWx0ZWRfX7LuduxlhfmcJ
 Ja2qLQDUXfnIOhPFyehPgTXcL5qzj5d3yFcPYA0XW1IREAtbc5Eoo8Ve5zvCn5nb1QWQupj3+8O
 FL0EoItm5jloTVrALgGDf2H+94k3nbQgczj6BYGJ8C0NukjIEkkQdR6bqvDKDszRE0kv5cseh/N
 grUDGzayVZWLeJKnCiV3OloI32goQChuuv/KB9RSyRt8QQD5WmZvc/cwXrEL0miwWZj19152JDi
 JEW4UvtXW91Pp9/ZSb6n2EHiGqslbFDoyRiI7+usP2LLN2hThoSLpKBaDm8NpKERt8cX1e1KaOZ
 VCCgH21zC7OJC01SaSiyy587OBsccZwMQJ1TefADDe5091QABLkik0HyS+pod9vxOhpJVDkseUG
 iTL43SpspsNXkl1iajfU10wCLoJNAARIw8NHAqzxCO95cJqJQGGc1Vn17i6iMo5IC5rDmTEVI2c
 +75+Txs+J2tQ1FGUYDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2NSBTYWx0ZWRfX1GD/IBKWp3OI
 HVIxcuLZMwTkdCfUq4dr3LHA6e0MGI/r+shIveK3JTThR8HODgnK+phwv1s815B7vUkTQdK5cjV
 FLnP3rPsZ9bHnTk8QyGvkYXjzqIVi3o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120065
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

On Thu, Jun 11, 2026 at 08:07:46AM +0200, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> MDP4 scanout continues to fetch framebuffer data while the CRTC is
> active. Keep the AXI/bus clock enabled for the lifetime of each active
> CRTC so that temporary MDP4 disable paths do not gate the bus clock
> while scanout is still running.
> 
> This avoids display corruption seen on the Samsung Galaxy S4 when the
> display pipeline is active.

Please describe, when do you observe a corruption?

> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c |  2 ++
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c  | 42 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h  |  6 +++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> index e8066f9fd534..9e53c9d956ca 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> @@ -271,6 +271,7 @@ static void mdp4_crtc_atomic_disable(struct drm_crtc *crtc,
>  
>  	mdp_irq_unregister(&mdp4_kms->base, &mdp4_crtc->err);
>  	mdp4_disable(mdp4_kms);
> +	mdp4_crtc_bus_put(mdp4_kms);
>  
>  	if (crtc->state->event && !crtc->state->active) {
>  		WARN_ON(mdp4_crtc->event);
> @@ -295,6 +296,7 @@ static void mdp4_crtc_atomic_enable(struct drm_crtc *crtc,
>  		return;
>  
>  	mdp4_enable(mdp4_kms);
> +	mdp4_crtc_bus_get(mdp4_kms);

This is a bit suspicious. mdp4_enable() already votes on the AXI clock.
As the CCF has enable count for each clock, it should be enough to keep
the vote for as long as the CRTC is active.

My only assumption would be that the CRTC scanout happens for some time
even after the atomic_disable(), but without a description of the issue
it's hard to determine the cause.

>  
>  	/* Restore vblank irq handling after power is enabled */
>  	drm_crtc_vblank_on(crtc);
> @@ -137,6 +170,13 @@ static void mdp4_destroy(struct msm_kms *kms)
>  	if (mdp4_kms->rpm_enabled)
>  		pm_runtime_disable(dev);
>  
> +	mutex_lock(&mdp4_kms->clock_lock);
> +	if (mdp4_kms->crtc_bus_count) {
> +		clk_disable_unprepare(mdp4_kms->axi_clk);
> +		mdp4_kms->crtc_bus_count = 0;
> +	}

Is it not taken care by drm_atomic_helper_shutdown()?

> +	mutex_unlock(&mdp4_kms->clock_lock);
> +
>  	mdp_kms_destroy(&mdp4_kms->base);
>  }
>  

-- 
With best wishes
Dmitry
