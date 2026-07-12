Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4BFC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 21:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C2810E09A;
	Sun, 12 Jul 2026 21:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XLUIvL1i";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h33vU8Ei";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F8210E09A
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 21:03:32 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CK8dAR3402991
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 21:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=OwauCUMemFKV4pu5ansWi03l
 mH+jjZzuHrZDIv01P+s=; b=XLUIvL1iyJZI3OgIc9KprcqS6ntw/El2bjoYNo+c
 4VlPUU/4zA9Hmj3NULgAhoK/AD2RGwq+od4KMWdez1pFPodgLtVt6BbyfJcx0y15
 aCeVnSHJgwsgwLj23Kvs3KwFixLHLhhqvkEzrizSCW84oQEoGGNGoAgJuF4E1nQx
 zwPwiwgVPeooSoBQxUBFnUZxtRJONyHV2s6QGH8JHuWRDNThaEHvS8ltIpx65M0T
 5OXh3AXUP/kskFeEbayleuew4nnvKJIxPCYqt8vheZoRsqgD/AxRq2avT2wfr7We
 4OgO0fBI6DKwcu3NR4oeqxC1Atd5CrEHXQoEAuksNAlSRg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbekckftw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 21:03:31 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5bbd3241499so1297494e0c.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783890211; x=1784495011;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OwauCUMemFKV4pu5ansWi03lmH+jjZzuHrZDIv01P+s=;
 b=h33vU8EimT+Uspp14JieTVAnqlCh8k/4NTubw1+AgS/LWFrsFN29l6KCB7Ku+L1DjC
 KDm7jeE4Es5ARwF5GkW6i3J07EaBl8/de7OAGd0dFwkNQn3VIQO1mt9rYU/2CbFC+dVB
 5bwJ3VtKGnGPcQIIOVYs6E4gIfzWtnauvIubXTlFJPwIIbs47ABEL/1ehwpW1FVxrZ1i
 x59R9DW8I7Q7VZeW1pBUEPdbEBbUnkuBzO6atMnSIh9B6HQmhOxnVuGgHHD6u+hzRdEE
 cdcOT6MEsJplM4eXMRsZlZv5f9XCgda271VEcU7sbfRfLRSh7xzVhT6ot2FXRaNx0DTH
 IxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783890211; x=1784495011;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OwauCUMemFKV4pu5ansWi03lmH+jjZzuHrZDIv01P+s=;
 b=pRl5fiICRu4w3XCAfgqzpFkfWlG8SXZE8V7LbHeEhkMVGBmF0N0X41+LzbVgOWUKff
 EreLe3vs/sibx0s9QjfPJfrtLMkCx5FLHv+JWLoVVM62hiiUZWzDTuuQck0I9Fzspsmi
 o7R7041m0LRT4WTXTtyAjd1vsC2cZpZ1T6xYDT4dOJU0P+htKhj688FNDZZlTutb4/A7
 NtzfSzHEwJhne55UqQ2f1+S5kYI26WUNrq0JyvD9okg3Qy76NQxT5n00raXW33jQf0Pd
 mXMc96rRscjyun1Lb7t4jgzhIuczw9lsEg3IxFjqt+kPz//OE5Atl75jlxouSjNe/vqz
 vY4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqthucLrf+Pw8s/SpMbqHqcGKuAkDtOPn6ePtytncER4qi+6cWcFIBxWxNy7w1mYIAF42DexhrToa8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywb+q9Pyb8CxzM23L9p7SHZCKsFeYqMrjnKlqsf9PRtHkazD8S5
 Koga8vrTiqbhAJMBQ9b/vOZws/hETYIpKYhHCHxM288LErvRAzKiwd+cRDhHt9oOTAtjdF2MePk
 95mSVVPERqoE0rhcLHzCHRXTKeriBvunX0fGwtvIbX30p4yuPDcRYpWZnKhYHWpmJVLtTyEE=
X-Gm-Gg: AfdE7cna+LLePkGfeGmF8NxONQME2ptJYNXel54IDF5zp+C3OMGc+2X7MJ4eSzhgPmf
 h24VaKgHExe7KGwt9B1H49/yny50PA2COLIKLHHzGfUJsoT0xI8OBa6d1kkEkdkROlhywtSi8lk
 Mwh/XJ0mIcldVk9C3E8phRccv/R1a4raUfF6J52xAwcsg4lBUE+fWwMqViJDD8OxP9B2JczyXPV
 hG+yLB+DN3fEKuAL+YDAjLMT/iCeNrgryxxApifpCagDD+PoOXZDAcu3vGEzw+EQlCnj51hWqWQ
 Qy9iPBMYKFlklXKeiGNxC+3qbISJTOVEFXEaXSY/eEJca9dBIGBcsCwjr0TvJtRAx+/VxFbf+qd
 5yNhPcwrC8pl/vUDbqcEcLLNq0JjVZqq0M7GZCqTwH2sPGQOBFpZ16frofaFKrm7+XLAcPUO7qe
 j0yzOdF1QLpKaePWu3AmoFm2t+
X-Received: by 2002:a05:6122:4f93:b0:5bd:fc20:1fc3 with SMTP id
 71dfb90a1353d-5bfbf0f4baamr4898800e0c.4.1783890210868; 
 Sun, 12 Jul 2026 14:03:30 -0700 (PDT)
X-Received: by 2002:a05:6122:4f93:b0:5bd:fc20:1fc3 with SMTP id
 71dfb90a1353d-5bfbf0f4baamr4898782e0c.4.1783890210468; 
 Sun, 12 Jul 2026 14:03:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b1a164sm23251951fa.16.2026.07.12.14.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 14:03:28 -0700 (PDT)
Date: Mon, 13 Jul 2026 00:03:24 +0300
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
Message-ID: <zfu6ockf6amm6d27rb5gqqy4dvohestx4ewqlmd7liastbhlw7@jjvmq3mi2gtf>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-14-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-14-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDIyNiBTYWx0ZWRfX1DTyG4drhAQL
 8PB0e3k/WWOSePJ8159GelAjZfrY7rYjzxN0RDWJh4mOF8ny6CYVbhtLmtm7sTqV4E5+eN5MH3C
 4cLcwHaaJO3boYwlctZAB+wcEJaLHZ8GKMiAv1NY8CE8fxKai7dHAsYl5X9ImRPdoIpcaIvdclT
 hl53gNZUVpQiBug8hV78B5ldHSPORLqhu7fmyJZI68n9j90CvU7gBovtOVlNGh0VfCfxsyKF79v
 5DWHmI8QJCvV+hue673PyFiV7mCLR+25/0d+2HUs0KVhviCJO/xZfy9prT3rf7TUxCKcpzSXAwE
 AlmSe5rlpEboixH5HZCZrIrL5Ay9Zy0J2GhM8ogL6r/cA2+r66HEbGcJX8yBqs/rI/w6UAoV4gu
 02JwYGux3MDx4PhkgRRkTHAkPVSL8IMFpigX4Rz9S8pjVpEIXbO7r85wxyP2oPyFa4cmHMoxQw+
 Vtm4IqPVorGZt47Mg+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDIyNiBTYWx0ZWRfX3SmPiHrBBTkG
 j4O7biHjtNUHqIKRpMTkH7qjv9ZviRPa9WQviUz/CdGtNJaj+xMeJQq81DgjjV0kVzq7bFQ0Bsy
 d4wdBmIaaeZWWBs/lz5DOnPzk5fxYo4=
X-Proofpoint-GUID: -7xFyQsDgB27knOKLbBCEBVBKF5iuyIq
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a540123 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=aQLTzbDcWNn4qkm-jroA:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -7xFyQsDgB27knOKLbBCEBVBKF5iuyIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_07,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
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

Also, if this patch gets applied at this moment, it breaks DP support,
since the SST connector will report disconnected, but MST connectors are
not there yet.

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
