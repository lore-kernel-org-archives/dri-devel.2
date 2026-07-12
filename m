Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F98DC44501
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 21:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C5910E29A;
	Sun, 12 Jul 2026 21:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oUmATThT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gC6zxhX+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509ED10E09A
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 21:00:21 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CK8OVj3574788
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 21:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=771zBeqFjnXgCoTcPt0jsf+d
 nZGlHkLp9A+5v2Ou9MU=; b=oUmATThTxuz1OFem1e6V81I60i0POdk1N6LdHzQ0
 Ih53lq4Lv5zLYj8WxaQT/OsNfnodxpdsbfpMBu+CqavhIjkBzagsKtGPUTPPeA1J
 42bma2lZzE6n7DQlm8VU8PbFeoA2TZMDH9+tGg29GTqIjmmd02yOGL9L01xgwIR9
 zdZQbud8/f2Ggply9Dkdx0JRCXEUlVjyUA2O8aHDA7q8jdrShll0lY+lqGWNhegr
 E10Kr/1cHal4GCrHSS0vth90TTSNOo6FjSbAjyQwiQmaQ1KEogWW115K+nA0Al5i
 y1PXwE/2qbt2vgcyQQ4z1c+QZ8jSJp+oy+cQhqGkYJhKgA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe9hkj3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 21:00:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0d6a2f4cso33040231cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783890019; x=1784494819;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=771zBeqFjnXgCoTcPt0jsf+dnZGlHkLp9A+5v2Ou9MU=;
 b=gC6zxhX+1rbVpReZxyFisLtRcu5sKi/k9M2uGnJOU6PCKY+Dv6Y50uCusB5+kQ8T82
 ZAVC6sO14EAdB6SnPk9oJEmYBgeH2MtEAjatccfk4NtneDITUHVQcCA1csIaMn0NUloB
 3JagCUwm1xlo1K4V8BZmdo2Vs8fb3JUiYCBIkDBiRker3pvJ9LBZsFSSS/pmkIzsZnMi
 +YasC2EZ8+66zoSGjEodXFdsUidUOGyyktoHt0cLdiqpdRF6lZu762Z0g9foMowbmxBr
 ZSZSOcRhBcbdYMB+j6mEwYRc8CbmE/jFFLvQps0mCwMWu1vKp93lQN3EcgK96oLWPTYF
 HDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783890019; x=1784494819;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=771zBeqFjnXgCoTcPt0jsf+dnZGlHkLp9A+5v2Ou9MU=;
 b=M+XNUVZxZ9LLG7g3n/HFuaHps0MEfrLWwhF+/06ifpNfzp2864EG+40VDvYEfJ/NJi
 W/DTWOnnr7ANFf39plk4yRI8eMtwnQXG3PtOTuMB2zLJ1n6aZNZaaDQYSmdkbJdslvch
 U8UFkh7XxtU5fku9nKKPa0zj4HzMuxGYBpAAGu4ib3nb6Ct88iVlwY/39zqaUmiX9L45
 0PEzGGuma0GIuSTit/3Qri0GiBMXLbOchEWmCii/UboihE4riqmbmcdNtPNby/5amXE0
 dgwvUwqsWvu19iGeXNBTD9WNoIGt++IxrGJfWZNkcoAKloQEwg5n8Mplvai+075nXArJ
 Bx1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNhw7qCitLUqDvsQ6O55O2sUTS4NonH0qO1nImB9JR0yzTnFJTn1LHk8CQ+SBZLvMdNVKzljc+D40=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQrtFeSnh+X6ojvE4bmKvd+qh37aDcAALNU+liGlb8PqWvsEqY
 fVuuH16uxXvSKcntLcsIAJYmcbbZnLgmQbok66aqawE5xykVv6q9ONvkxen2rCxPNQvX/JSX+cb
 z2JtqKkcLnD3ME9SYg0vXXzSXKuYzYS6i7lhuYazLH2aTBQlQc1CnmgDrqgfKT2mT7Jm4uRw=
X-Gm-Gg: AfdE7cnLqH9dN7mp4m3ioYewarjIAXSBFSebiHE9MROh+uqIIMIzoIuBgA6fu6hdEy7
 Mrk6cBRup1B9IUYFlikQHabKBEvv6rCYS4apArsOIDF9WfrIGPw8qeuYbRyyNiABuKlr1nO/b3B
 0MIpKEVmPVSLZWCZIIcFAWVgKtOGrPXFnHfWfGrlUTIHEC9mMMlj0gzgiB1xSBuzz72NuQUhPfW
 PCkfzSLai5BsCZ2flu8b3efNDhU5u7iIYIeHHczDNZEIYh8dKffiCAmn1bJn36Shku+UjkdEsGV
 VhKhvnhVKpXnERogfOzGZTvkezxXoay5Qc14X1gQm1J+YuBa+67RDEzlLMAbnkR/Y/pQ9TqdTlM
 mvvEP7eCDTqnISHgKl2UDPsUFPxeeLozsnn2sLe1paSHWA95gfh8LarR48xIfnJ5WIRschMUg20
 47DUWewIhAh/J/Gt+RdM2sm+/i
X-Received: by 2002:a05:622a:43:b0:51a:86a2:7048 with SMTP id
 d75a77b69052e-51cbf213efbmr72564421cf.43.1783890018590; 
 Sun, 12 Jul 2026 14:00:18 -0700 (PDT)
X-Received: by 2002:a05:622a:43:b0:51a:86a2:7048 with SMTP id
 d75a77b69052e-51cbf213efbmr72563631cf.43.1783890018006; 
 Sun, 12 Jul 2026 14:00:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01ca4a297sm2363302e87.7.2026.07.12.14.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 14:00:15 -0700 (PDT)
Date: Mon, 13 Jul 2026 00:00:13 +0300
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
Subject: Re: [PATCH RESEND v5 14/25] drm/msm/dp: Mark the SST bridge
 disconnected when mst is active
Message-ID: <g2irqebm46aiuyp344wg3zjdzn2qn7q74bvppcgmveaoj2ndtn@mng6dqinykmm>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-14-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-14-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-GUID: 38_JkHlymT8mW_uBua6hah06YD8WGSgJ
X-Authority-Analysis: v=2.4 cv=SajHsPRu c=1 sm=1 tr=0 ts=6a540063 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=aQLTzbDcWNn4qkm-jroA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 38_JkHlymT8mW_uBua6hah06YD8WGSgJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDIyNiBTYWx0ZWRfX7v1E3mZvuXS0
 DcWZSn2zoE6PpEmRU5yv8mieRHK7+pHY+QUBdq4NtgBd7Fbw8vT5O+RNwqfHlZHkrwvcuF43D8L
 incuqnorzWUG72O0s5p/j2QSZgjavAymGINWIsimlTKPYZ2eqy0qT1lqr3QKF7wP3cpBLclQtHQ
 UetRRB/ii0q8IdVBOHpWizXG75RPKWbFB1nzsABYueZBwODoNmZSgYXQWK6kEyCRfppNZeQPgG8
 61xq8QxllWio/0YYtZg9l8hrssZ2xvW63QcEekJYsyjmXDyWJ7a/vm5UbIsB/+Kt1DJnMeYGGw6
 SJz4mIBjOa6JnFa2BiDRLIm1R0JAtdzyUGEiRzpL4ujeDoNxbqp0lymH4RcnryU0V1+8ZdaA7JH
 LoALVE9QkHg8fGX7XHz/7JiZGTbOaF0tU1zhqxm94jv1h76AqIivP6rUqMm4q5jtm0zOLp6xxXf
 7PgXuZOJKZcZZmEmygw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDIyNiBTYWx0ZWRfX2HNu4mYvCy5o
 Nej4cDvoYIn36DvDGxXrmCzC0IRE9y36e52tIRyrP5jH5Qq2U5MApTDgKssUOmEkNR7xR/HP1Y/
 EIIPIqcYZBOYLNDcCWN3o5zZH0z0H5k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_07,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120226
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

On Mon, Jun 29, 2026 at 10:14:35PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> The bridge detect function is only applicable for SST. In MST mode,
> connector detection is handled by MST bridges. Skips detection for the
> SST bridge when MST is active.

Please mention that it matches the state of other platforms.

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index d0081ea9f5cd..5786e598a406 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -910,6 +910,9 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
>  
>  	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>  
> +	if (dp->mst_active)
> +		return status;
> +
>  	guard(mutex)(&priv->plugged_lock);
>  	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
>  	if (ret) {
> @@ -955,6 +958,10 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
>  			status = connector_status_disconnected;
>  	}
>  
> +	/* skip for MST */
> +	if (priv->max_stream > 1 && drm_dp_read_mst_cap(priv->aux, dpcd))
> +		status = connector_status_disconnected;

Hmm, should it only be marked as disconnected after we switch to the MST
mode? When is the switch happening?

> +
>  end:
>  	/*
>  	 * If we detected the DPRX, leave the controller on so that it doesn't
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
