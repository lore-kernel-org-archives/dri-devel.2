Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C21DCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8B010F574;
	Fri, 22 May 2026 11:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IzzeeHSC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VgwlWkc4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1A910F574
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:47:10 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M9uUsK312917
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9Vtic2scv0lNArrUhQhjpK+aneD52xMJ//xMO3IOSEU=; b=IzzeeHSC4ZyDPsaj
 v9yxiHOQXtKDaeU8EEnfLF1qlMN6hs2RK/7Fq8z0WhxYLDqKbGXd2UOmlmdwQat0
 Cl08ME+g17i5H7r4oemJsDm4MCtBQ0/IIFL9556mbLb9HuZD6B8LGUIX6CuNGel8
 Fpp/PBp0YeRKPBNeeMxKMaP1VpAfMUwRkoI18OcHFCTP8fM0Rq9O0cGOtvRMCzCh
 9B5NtATkkxxzhQgr3QD2dFSgcB75ttmSRyMKM9mo10G7GpcBQ21l9ratiBcEzYY8
 EDirxcr7zzYC5NSlOUsU3yca0zWcYzD+tn+7sljQ0v/qqh5LjwzbLDKr0jJzEhxs
 f00pjw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea8833mky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:47:09 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b49bb5a914so19144946d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779450428; x=1780055228;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Vtic2scv0lNArrUhQhjpK+aneD52xMJ//xMO3IOSEU=;
 b=VgwlWkc4FjkPfc72td5VkiZx7zXFyYmY3RliVn13YL75nob0c80Nje9JmDT6ib9Ljk
 7pqf7FYum+QZB3E8TdMax+2AhH+YYC350IVPOgP81mxzUG6caVKfHeAHzV5EVYJ+pYYN
 rAnq4U7VvMHkooGmLwo7McurCoMnQxHMZ4JKUXqb4+rHND73D0Bwtu+T2Cw+jWXrGjvu
 qq3Qb0l6wh/UQ4FdeaVmgdbjrsf9vWNm6PHCpnaqPFvnv9BvaZDp3mqiMgx8hfay/3ru
 UfmbJ8TC4upjJXmQwaFP+2F859P3Uc+5TEh14OAkC9qSLzSUFANNbJOeYIoMIRz5wCjt
 2ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779450428; x=1780055228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Vtic2scv0lNArrUhQhjpK+aneD52xMJ//xMO3IOSEU=;
 b=J/Z9YUBo9ZMUByGtKko/Ppiy6vz2/wgOm5WH7h4VREWb8+nUNgSQd0GGfJCBepvAOg
 hzLD35Y6Xsx1GBlHc4JTjlys8oRsQxoUH5da+CaRy5jykpHReaNzNXwFpjyq7z7K4ofs
 1BBslyWLALel6KHR38UbYvrEWiNxcg5SsTYsYh1ST2cdrgE6qppY6BiFvWX0lEmIxuzo
 4qd5apUa8YL5V13J49wo+QhcUKr2SiobvoJZO+EY47DGaon0vUq2v4bsfFG6qV0cq9uR
 d/LROoajZPwW/Ay0Jqfa/txlao18SW4xex87sHQwLYOqmpGbuXolxmcG7syrDpyDXgXt
 y0SA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EQGytfM2vDsVNQx1Q2iyBqw+rWgJMRTc0hnW6/+tDtSBtVfYMHfDG2m5QkcGUDyxYGxsbfiwMEDE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyaOsrRYygRUe6jGZuGSPICmeUH3kYaf0esQ1QcDYJYMs9awQQo
 7zDROC6N141VOGUGElzf5ABGCei0ICUXhGXmq9nhzqGD7WHXKRU0ixotK/1Hx0LLn8Yn61lrRdd
 KTPlDvA7SbBzl6QZ5P8TENHZkT2SIq64v4w2RdqGV0GLt7+vhXoSRQsJSON1ipMbBe1IKmnbAdN
 ooU6w=
X-Gm-Gg: Acq92OGq/iNY2qQz80qX7Bm4OMZIVFNM94UE/jvl003ypKL910ZWNbBrMNSic/cuxZA
 bYxS+MlMAKSPjo899ofxHuvhZwatBakKyX36EWa7NaYP2rdo4mXxB+3yX5+UxEL9OAeenSdG7P/
 L/ZCLeg88x8b06JJ4Bc35QZvVHytraIGQJ2FHPwENzeaHfR56fX/WmavmQ4zFbHj+oNZ1IsUrsy
 QCa4xVC94Xw58OORmfaUv/Ls3Fv0dDOa6UZmGiZbwpT+qeXpXUYaBFcxO3LM9bnFO4uQzPFIaoO
 nLnqiwbDNeUM0Yhh0L5kX7CI/RDXsfQLULpep5EBYEUw3iCAag/o2acYiW3snYof4bCWusiG19S
 k0GnMHRP1GvDNGVwLjD/NVkdgpG3cT+0RX3JjIKFAkzkVkw==
X-Received: by 2002:a05:622a:8313:b0:509:d76:fe73 with SMTP id
 d75a77b69052e-516d436867emr24779081cf.3.1779450428488; 
 Fri, 22 May 2026 04:47:08 -0700 (PDT)
X-Received: by 2002:a05:622a:8313:b0:509:d76:fe73 with SMTP id
 d75a77b69052e-516d436867emr24778751cf.3.1779450428043; 
 Fri, 22 May 2026 04:47:08 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc30528a7sm47004366b.21.2026.05.22.04.47.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 04:47:07 -0700 (PDT)
Message-ID: <7a74f989-1235-41b4-90b7-aad1c68e9b37@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:47:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] drm/msm/dp: turn link_ready into plugged
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-9-0c8450737d64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-9-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNyBTYWx0ZWRfXwWa+ZXv1Gsup
 SjJ1aFv5vKVGZ3VoulR8HjyaHOGI9h28MxeOuVXy8Ol1dtwnlgk396Y81Y/91CoizU6l9BB81lR
 yO5RBKeBiwsvZE/d+YUV2MynHaQB/cQEm2DtWibit4F83Xgeb8ofILFSZUDxtORDSZ9EDKK/+D9
 hEdKxgL8+ZklFECUU+jpsqUu6a/65/l5YW3lvjKI8l+aZpGOIIDc+vPkYd1DArzqlZ/CVmXsHzZ
 LM2JQybvVmOWCp/7VhY251ImDYvPddYGaz8489O1DfJ23Vgcs9Y5DoEAaHpkIyZjnUUZWM2Umay
 01YbxoEEU7Odxbt77fdCypWZ1EX1zHkJoCWzi7WmC9cNf2gsZDQAKOZeS+d5YJCj1IFPtiPU7/M
 i9G5sSW/FI6OQFvwZLVzYgLMSo7Dv8AFMl5AkjabLp4SEF/mtTgjh1HzdaEkqfBWrZc7ulE/hEA
 69uRFyu5DqQfnqrEQvg==
X-Proofpoint-GUID: clD6ILbk6dzlMe-n_AtdzhnCyff4JnF7
X-Proofpoint-ORIG-GUID: clD6ILbk6dzlMe-n_AtdzhnCyff4JnF7
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=6a10423d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=pcg_VVX8d75-tFNqbqgA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220117
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

On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> Tracking when the DP link is ready isn't that useful from the driver
> point of view. It doesn't provide a direct information if the device
> should be suspended, etc. Replace it with the 'plugged' boolean, which
> is set when the driver knows that there is DPRX plugged.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> -static void msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
> +static bool msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
>  {
>  	drm_dbg_dp(dp->drm_dev, "type=%d core_init=%d phy_init=%d\n",
>  		dp->msm_dp_display.connector_type, dp->core_initialized,
> @@ -312,7 +313,10 @@ static void msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
>  	if (!dp->phy_initialized) {
>  		msm_dp_ctrl_phy_init(dp->ctrl);
>  		dp->phy_initialized = true;
> +		return true;
>  	}
> +
> +	return false;
>  }

Please either rename this function or add kerneldoc - it's not obvious
what "msm_dp_display_host_phy_init() == true" is supposed to mean


>  
>  static void msm_dp_display_host_phy_exit(struct msm_dp_display_private *dp)
> @@ -366,14 +370,6 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
>  	u32 sink_request = dp->link->sink_request;
>  
>  	drm_dbg_dp(dp->drm_dev, "%d\n", sink_request);
> -	if (!dp->msm_dp_display.link_ready) {
> -		if (sink_request & DP_LINK_STATUS_UPDATED) {
> -			drm_dbg_dp(dp->drm_dev, "Disconnected sink_request: %d\n",
> -							sink_request);
> -			DRM_ERROR("Disconnected, no DP_LINK_STATUS_UPDATED\n");
> -			return -EINVAL;
> -		}
> -	}
>  
>  	msm_dp_ctrl_handle_sink_request(dp->ctrl);
>  
> @@ -392,11 +388,11 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
>  			dp->msm_dp_display.connector_type,
>  			dp->link->sink_count);
>  
> -	if (dp->msm_dp_display.link_ready)
> -		return 0;
> +	mutex_lock(&dp->plugged_lock);

guard(mutex)(&dp->plugged_lock)

[...]

>  static void msm_dp_display_handle_plugged_change(struct msm_dp *msm_dp_display,
> @@ -446,8 +440,12 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
>  			dp->msm_dp_display.connector_type,
>  			dp->link->sink_count);
>  
> -	if (!dp->msm_dp_display.link_ready)
> +	mutex_lock(&dp->plugged_lock);

likewise

[...]

>  end:
> -	pm_runtime_put_sync(&dp->pdev->dev);
> +	/*
> +	 * If we detected the DPRX, leave the controller on so that it doesn't
> +	 * loose the state.

loose -> lose

> +	 */
> +	if (!priv->plugged) {
> +		if (phy_deinit) {
> +			msm_dp_aux_enable_xfers(priv->aux, false);
> +			msm_dp_display_host_phy_exit(priv);

Should msm_dp_aux_enable_xfers() logically be called anywhere outside
phy_init/exit()?

> +		}
> +
> +		pm_runtime_put_sync(&dp->pdev->dev);
> +	}
> +
> +	mutex_unlock(&priv->plugged_lock);
> +
>  	return status;
>  }
>  
> @@ -1123,6 +1145,8 @@ static int msm_dp_display_probe(struct platform_device *pdev)
>  		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
>  	dp->hpd_isr_status = 0;
>  
> +	mutex_init(&dp->plugged_lock);

devm/drmm?

Konrad
