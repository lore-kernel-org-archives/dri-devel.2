Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA93BCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0994710E41A;
	Fri, 22 May 2026 11:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ELr8j3nF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UVXRehNN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E57510E41A
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:33:12 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MA49xa3947400
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gW8frZZ8Fde1HC+RzR+WMWPFCf5xWqdVBkT+AH22Cr0=; b=ELr8j3nFK7SWU342
 WKeO/0WJnKRJ+BrSmgT1N/7BFttmEH4vUwJVkS0Pfj23OC8ixVonLXJIAudwVoZt
 1bcsdFv5xhEVFhBk2EEKVwZ0y8tXwhsaFqrmc0YutDA469E3Dk+j1ybhppUGU4OJ
 veYKLKaTBEGIQpeNZxrAyeiZeY1pBLxqeQCjPmUDXRWCZR/WA+cSKWK0/jpBrY7W
 BvkwUtCy+l/trEPGBor/yFjX1sBWR7eyTKd/OrCER07Lsp97vVCE+ok7KLhs1jvl
 hlJR3JTMQTjyH32k8JqRleFLI8qoolSnD88mJ5dHMfCvtiMDiunCyQsz18MOhAqb
 MsLlzQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean2ng99c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:33:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d9f1bccd7so17706371cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779449591; x=1780054391;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gW8frZZ8Fde1HC+RzR+WMWPFCf5xWqdVBkT+AH22Cr0=;
 b=UVXRehNNNgRGLIVJKFpfZJ1NFJacnQrycmEs6cOjTRcgddPPoE1AytAlf8BaEMX/uX
 sDpN+T7yDReOL5Suwj/QzkUzSGh12yNI74nFknLh87U1/arrLw9eOsbRChnpbNE6WJY+
 aw/sFNHdiPHICWe0+T9g0asLw/TX33UbKdTxFPElUCJg4JmU40QGuc4rHCAmP8oOX6q2
 QyON83BHQaDM4vudaEfA5cOx0diipoxcyhvdWgvXMKgo2ww/j/BqFYydpxgzGlebI+g4
 P0ABbbvPTM4tFt5Z5ulRxlRq1USgz3JafwEqAyJe91VrrRPMnRAlxcD88SSDSEGfjURZ
 TnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779449591; x=1780054391;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gW8frZZ8Fde1HC+RzR+WMWPFCf5xWqdVBkT+AH22Cr0=;
 b=QH+JBpKTNwkLAVCPiMxw0M44NSg/LnFgos4oVx3a4bGElL06RPLnbzawgaTTC7fuPk
 3cxFGmOUPEw87FLmH8xX9xC1BYMi8KeGX1+kQrl66boxEQU8kpWCeLaTQker7LY/KrGF
 JIAyMnHS2bqhAwU1cHXX73Fy1fadlLQkXFGkfrB4hyoA7IxOXptOrdWRLppxT1Vk8gfz
 I5cksENah3owCnFWQyWCMHYXA9pLEyXhUWhjwA+Ra+atjXLHQSQKwbQPfdFLtax7Bg+3
 rmZorMGRT7I6W/veis+G9GiiAeI7+JTYXXl4usyD/sQ6eTVzVcgpC9AchfCOh1NTrhI7
 kg0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BWDppL1+oKSOT1mfbbvNmEyxeW3IxRZkKJOrtQbXenNJy/vHyNAKtVwdvZ68zH9ULmW0cW79E/UY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXGhnzALSRU7iryXRZ3uJEdpWsq9D2BWNgCOjyOijPrc8kVMYS
 3toYQWvBjjCAdZh7v9wOu3oDU1MGZkDdcFNrByutWF+ZD6ZQcrobrEWB1jqMmHsvbdx4e6wTIMn
 aIrWHpQqOoGbqoDmpZQ0Yf0NvatFX8nSiI6BE9Ux5MI4gvZpqn69aTVFO7ioBPj5TNqcS1mI=
X-Gm-Gg: Acq92OGF/rFDuPLj+eJBlrXz5BHrYjjcX1rwTzh9f3Y5WMJwGYKFAgkeF87fvqoMrgU
 L1w4UxnpmmHL5UdF8ZldjSW5sKBVghKT9unaObd0Bwi0gykzAfJCIJer6jhoFcnhI/i/A5y2pm5
 K5THnVKRfJ//caPyO/c5vf/OlOSu0UeSsRF5w6VRful0+WpBaDmugOiCiT8wW7bDgcppFMSQrfU
 q2hp44hwwFStw9GadvH2pP4hg2CajLveE9vnNtbacprGEYez9FqoNuvvyDSePJkGAzHSKxPL8TJ
 bwddHpW2905rtQfbR2qAwgejIRZ5gXHNyIvVL/0u9iEJaWPIikNJphbWO32G4eEEm2cPhslyHCf
 kSj3i9Nr6J8W/Qc45YqZSuUuNna881DVXWGyyJ3Uckx9UMw==
X-Received: by 2002:ac8:5916:0:b0:516:cae0:c6e9 with SMTP id
 d75a77b69052e-516d419f0e0mr36225911cf.0.1779449591123; 
 Fri, 22 May 2026 04:33:11 -0700 (PDT)
X-Received: by 2002:ac8:5916:0:b0:516:cae0:c6e9 with SMTP id
 d75a77b69052e-516d419f0e0mr36225491cf.0.1779449590594; 
 Fri, 22 May 2026 04:33:10 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc62d5d0csm45618666b.43.2026.05.22.04.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 04:33:09 -0700 (PDT)
Message-ID: <7bfcdf7c-f114-4f4f-9ca7-6a0d31c856d5@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:33:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] drm/msm/dp: Move link training to atomic_enable()
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
 <20260314-hpd-refactor-v5-4-0c8450737d64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-4-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XvDK/1F9 c=1 sm=1 tr=0 ts=6a103ef8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=DFjhG9jlQqNoXxgc5tgA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Ee5IX8d7R9t2iRMyBMWI8lwOfCEkYGjh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNSBTYWx0ZWRfX9xHHDarlSI7u
 T89pn/Q3AArAFRVOBZmPdzwdr672Vlo49s2LBPCCtR8JcWsCLHidBooQbxQ6jP3stX1Dzgu32jF
 4G5CJbm0+ehkHlvZxPP4lQNZQsG+3qE+un4WO6cj5oPvWwRJV8/o/mTOJb3YQMQr+wplijGDBla
 NnSEPFParuz7YHiEzpkgnQBk9B2d1abuVZKgxzG2pR8NPb4tiOeQ8It0OG/OHuXZuCdJvl5Evzy
 FkxFxbKKSpmS4H74iJx3O2LcIYzlPpOWhvPl4Ye8SPkd64Zzt4bVdJQ9Q3HHF/GE4NPB459pCit
 TaoE5aQUdx5TaOvLwuX+c459TphSjuvYG6rtjQ0iCspP38xdIzyTo8tZll9YNZMPr8zXGQ0aijL
 WeUiYh1mSLVB9ePP9DDuNgUKhjiem3MyNPwX2p7afmxPfN/OzOpr1lwfV1E39wwdKXBuqykYsaS
 /zGa23Lf2uwMK6qSo5g==
X-Proofpoint-ORIG-GUID: Ee5IX8d7R9t2iRMyBMWI8lwOfCEkYGjh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220115
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
> From: Jessica Zhang <jesszhan0024@gmail.com>
> 
> Currently, the DP link training is being done during HPD. Move
> link training to atomic_enable() in accordance with the atomic_enable()
> documentation.
> 
> Link disabling is already done in atomic_post_disable() (as part of the
> dp_ctrl_off_link_stream() helper).
> 
> Finally, call the plug/unplug handlers directly in hpd_notify() instead
> of queueing them in the event thread so that they aren't preempted by
> other events.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index a05144de3b93..e7b1ed5491c4 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -436,11 +436,6 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>  
>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
> -	rc = msm_dp_ctrl_on_link(dp->ctrl);
> -	if (rc) {
> -		DRM_ERROR("failed to complete DP link training\n");
> -		goto end;
> -	}
>  
>  	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
>  
> @@ -1695,6 +1690,11 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>  		force_link_train = true;
>  	}
>  
> +	rc = msm_dp_ctrl_on_link(msm_dp_display->ctrl);
> +	if (rc)
> +		DRM_ERROR("Failed link training (rc=%d)\n", rc);

So this will still crash the device if the above fails - there's some
return statements in this function, should we bail out if that happens?

Konrad
