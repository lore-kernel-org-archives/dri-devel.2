Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E457C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 00:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D78F610E513;
	Mon, 13 Jul 2026 00:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xj9uErt8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HA4ppbju";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8093D10E513
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:54:30 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D0k8Xt3923536
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FTjuGasG6jAcdaV46NtQY/aS
 JFb1KEyP6aKUqNcdxjY=; b=Xj9uErt8D4XDuHRxNnex3DEaJEdeEQwGpCaqISxr
 HkOkLZ86FshUWhoe31J/byzmb7o/M5Ps1ueOqaQut0mmmwDUP36HsSBvQheU11Pz
 KeSkz96mqHddIUIF5LG7Dj/Fx6cBOpztgmf4ePrh/Ts0Yvu+73P3x7/p/+7T8Luk
 qUNfUcIikitt0mEI1FGs+ZZAB0rfh+MlI7gPAGTGMlEDrqFOXuDqcaQ90K4REgsb
 sh+Wimhgpv9JarRu+n7jh+mdzroet3qB1wEvVefeUdEMItfEH3IlN9ZwwIEgPHAf
 1kFMrWoLRvNcDUBN3jMY8C+3Pz0mTVHGCVLh0Yl1r0Suwg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf483q5a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:54:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92d1cae5740so367924085a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 17:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783904069; x=1784508869;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FTjuGasG6jAcdaV46NtQY/aSJFb1KEyP6aKUqNcdxjY=;
 b=HA4ppbjux/5BN+69BJaJhrtXBfVFEY93R9KQ9AFS9xA61sSjFunWMl0zDUPJPFS1vl
 H0g3DNh+aK47CpOJkaI6Q+jZ7oMmT7fHbt6DbO7sYluW7r6jHTe5lq8ZYDunj5yC1z2A
 grcK5djnGeoNn6pECiBhjqb52IHpMslbX6Yi67tEvzV2rfdnhV+CbX/3R6p+kwzq7E/P
 XMb9n8Fd1/QSsqGcClXzmM/Owb7cbNkXmVjsmKh8ItLMgkVA8Xh4ecwjnfHZrthkG+Xx
 RfDpDTXqdaPP0DpgYSAtLSw1i3MM8kcgWTNUVvNamX7QtKehJgaoTm2yTgoEvMFsCWAC
 IhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783904069; x=1784508869;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FTjuGasG6jAcdaV46NtQY/aSJFb1KEyP6aKUqNcdxjY=;
 b=bXyIY8fQn/Xl3usP1hl/tHAcUpDfHkzYH6AHurCtZKYp6WN1a7U8gDAOp9RamUadVh
 EVLUsdE3uuNRnQeLcQehFZK8DQfXrdWzVqi5/fOmZqwPmB/l3LxWKJRj2jsZeKggqpap
 /tD7VVpolpPzJUjRbQHJLFOoVqy/pQbMNCQFGn5VX7BGE0JwEdWGMDI+SAmv3/l/1izW
 MLHj48U0Wct/O6Rb6V74niYq7JMoBR4q5PuvTmNp0/dmWAHb8A/HikdQYVKsRfyaTBZK
 +L9EfaHUj7kqsEOF2RPsqRp2A0OmWsADXHhiHq7cfVJEBFKMMJgyOY+CjheUjq8c1rYN
 uMdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqL9LBXJ3+xjDhcNAOPRN/VpprMQic+fCmMcqRQm1lnpeNwRyalAAY2ZqgJb5qtWhNBnRCYEAxHkV4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1mOfpnymBkvM4suQhLP/ZLtqoN6+QSc1ZXpGIAc9pcN+d1K65
 HmJhmZweWoelOfHzhy2fSUUCnEqu3tTCF2mirvMlcz8UwyWcnswU9VM2Q0ael2ls4opR4DhtPAN
 s/CymK5zIMoHq7QnYffZ6AlWkOu/Wq5aTJ8dsMrMG2MClaoLV9ZmoeOahBsFBh7oaaf4cbK0=
X-Gm-Gg: AfdE7cnmYGe283iIp5KInPf0FegVfCvlxiNRfpfjH300DAX5gQMEEjp/rwaNtpEUkbG
 qcr+FBu5s29OCVWiEVtfhsPJEtBGQCXZHUO4RvmmDDgEdbB8Bqr2KTTg9GtqOWt4uQVjLY2cdXH
 U9ZLK1J32eo4Mqu6hGcvJqSeWZ4gCGvjSA6yll34d8o5ZskRaYHZBBXsQG9J+Ry1zOPaFq9w0sM
 wWRT+CZEIISV/1i9QJfcYg4bwvKdbJI0eLIIJs231QioZFyp7G6XlcDUCrryi+9ja8/zMMlvAxm
 hRvDKN89duf7ZV4TC+owHlxIFAnqDf4PGkB60tJipAEVXKsr5mG2hYmyWKotV3vZdFEakMWZNkd
 1mLkxD7zK7gzUYY53A0oc+aUUhxeSleL/arOBmdj6VOm2LHjQV7YfrEIty76xJaUqYzu/o2yGKW
 DtLQ4sMNZH4zzr6aQlGYuR8jZP
X-Received: by 2002:ac8:5d4f:0:b0:51c:164b:b241 with SMTP id
 d75a77b69052e-51cbf05b77cmr75713861cf.13.1783904068734; 
 Sun, 12 Jul 2026 17:54:28 -0700 (PDT)
X-Received: by 2002:ac8:5d4f:0:b0:51c:164b:b241 with SMTP id
 d75a77b69052e-51cbf05b77cmr75713591cf.13.1783904068275; 
 Sun, 12 Jul 2026 17:54:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01ca55043sm2439852e87.32.2026.07.12.17.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 17:54:25 -0700 (PDT)
Date: Mon, 13 Jul 2026 03:54:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH RESEND v5 25/25] drm/msm/dp: add HPD callback for dp MST
Message-ID: <remaj6npgiv2hakdeevj5mp76c46xupoa64dqbp7x37wlzgrca@66ooracpci4x>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-25-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-25-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAwNiBTYWx0ZWRfX+gYRI9ZsStF6
 I/ISh4FwULsmt1im9tXA+RaS/yfTkUr1JnehNVrr3BjXtnjpRFpZ9ULhaoLkfcmxaa+/qBeb6BP
 G/bQ6Ft3P8+6H1uMSMwTnSqJCUGqOWc=
X-Authority-Analysis: v=2.4 cv=OsJ/DS/t c=1 sm=1 tr=0 ts=6a543745 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=_nuYtHmMXLcvbywb5U4A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAwNiBTYWx0ZWRfX0E413YuF0JQL
 LOavdUnDv8an38xBB0vQgucmXff6F1m7ersSwrwQfyM1JE7hk58JHZPHa6rszmp+pk/NrLqbEbD
 HwVnP+sDD2B3srb8Da7mNqaOn7T0fkIUkr8pO2T6FOs2XlpRwxL0oo3Vn/62LUP0TsDCs/tyjEa
 sXt3E48hw7xo/qYlBfYe2aZ3LEA/bVrY27EZIkPXvAZGVsPO+cMYRFZ0Uqrg0kwsn6VqdYzE4dM
 NdmQ4NtmqYS/OidgxBTryN4LuxMUdNSKV7DqZwBWgUm7AugW1me4y/7HUXBi25v8N3SIvlCgklY
 j9MhGhV3Z9naCBCRXngHRLRTgYcY59YtMYbUI6ZOFNhcnBtR39F/hxyfmPX3tCEjhIMgkP1jDye
 nfwZWjK8G25HczoXSz++nkOTBJsba3k+Mt7E77vv8XJ7pRbujijB6tDwmQrZwuYOXHdj5/SOpCx
 JqDfTuZjALP002e+Fyw==
X-Proofpoint-GUID: bKmmoGhnabAXPGSRS5XynCmlvPADf1ox
X-Proofpoint-ORIG-GUID: bKmmoGhnabAXPGSRS5XynCmlvPADf1ox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130006
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

On Mon, Jun 29, 2026 at 10:14:46PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Add HPD callback for the MST module which shall be invoked from the
> dp_display's HPD handler to perform MST specific operations in case
> of HPD. In MST case, route the HPD messages to MST module.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 22 ++++++++++++++----
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c | 46 +++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
>  3 files changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 6eac390af2e0..49a7bc5e031e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -455,6 +455,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
>  			dp->msm_dp_display.connector_type,
>  			dp->link->sink_count);
>  
> +	if (dp->plugged && dp->msm_dp_display.mst_active)
> +		return 0;

Why?

> +
>  	guard(mutex)(&dp->plugged_lock);
>  
>  	ret = pm_runtime_resume_and_get(&pdev->dev);
> @@ -550,12 +553,18 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
>  {
>  	u32 sink_request;
>  	int rc = 0;
> +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>  
>  	/* irq_hpd can happen at either connected or disconnected state */
>  	drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
>  			dp->msm_dp_display.connector_type,
>  			dp->link->sink_count);
>  
> +	if (msm_dp_display->mst_active) {
> +		msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);

This should be routed through the HPD / notifications API so that there
is always a single path for handling the IRQ_HPD interrupts.

> +		return 0;
> +	}
> +
>  	/* check for any test request issued by sink */
>  	rc = msm_dp_link_process_request(dp->link);
>  	if (!rc) {
> @@ -1111,9 +1120,13 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
>  				      connector_status_connected);
>  
>  	/* Send HPD as connected and distinguish it in the notifier */
> -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
> -		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
> -				      connector_status_connected);
> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
> +		if (dp->msm_dp_display.mst_active)

Locking? What if MST is being enabled or disabled on the other core?

> +			msm_dp_irq_hpd_handle(dp);
> +		else
> +			drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
> +					      connector_status_connected);
> +	}
>  
>  	ret = IRQ_HANDLED;
>  

-- 
With best wishes
Dmitry
