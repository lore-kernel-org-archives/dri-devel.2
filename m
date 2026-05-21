Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DBCCD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 11:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EB210E1A0;
	Thu, 21 May 2026 11:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gcHfgysV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZuQzA2da";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A286E10E19D
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:34:40 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L9AMXl3555993
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hdNGl96a1LRZ4HsRLvAttgH7mqHz0ODVIhshUZSEX4M=; b=gcHfgysV16q12LbB
 9wVRB+KEWB1Kde20SRh+pTWIwHS0bvR1Ylq1J4SLdR65wKgY6y6DYM+P8bfjZx6o
 ZGL66cb4Wb0BXLjDlPCeEeoJWAgBdDcN7on31h7o9AWEkg77kj0I5/OaJTJ8Emc1
 TC9QHms5iQeASI6QbB8vun+vD2L+woUuP7MRuCMcmlGp3eK/PHnsptirgee7CMex
 Dq/yzpCU6QejBJA/iaTZRHpKucj6UWKms5ICm9sxoci8ght3WwwhPmD6VKeueNlA
 LqKeKBX2FZPWUglXAKLWBX184xZwg65BT10rwslMgF+LkRrIbvxPv95rOHj4sSTR
 GYFTsA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6m9dx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:34:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bd1dbcccf6so98900315ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 04:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779363279; x=1779968079;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hdNGl96a1LRZ4HsRLvAttgH7mqHz0ODVIhshUZSEX4M=;
 b=ZuQzA2da8UHPmxyc9uHN9dwQu9akzCjRVX1T9H0M79Zl+Bf37pgYIpfxZ0jQX0l/II
 AMMx2tpPHs5MVw2LlgR0r/xyaA9Z77YqZ7l97zz+BL/Md4yjcR+s/QcthBP9Wbe5nHsn
 9YF06mZ3jx329K97XQSlcmJ3cuL+Hlc0E9rvg3Mm4NcKMxe9Tw1SFWrTncCRUm9PBAMr
 R9TjL2zOBJNF/dxQUYgalYYEmyFYWztFCzhuox3oJbpnNskJJhTIE9qtU25JymSlIwL2
 s+PSj3E60lSLwkS+D7f4ny/ytdRk0CbrH6/iDiKOmlitF8QizSKW+0bNrLEPHCgfP9UV
 Nlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779363279; x=1779968079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hdNGl96a1LRZ4HsRLvAttgH7mqHz0ODVIhshUZSEX4M=;
 b=pZC8e8k/TO/FCf5vCPzdNahv8BNlk7FNiJ0NX9DeQ6STxxIQoMp1Ff0CUsVR6xZMkf
 jSWtcA9uVl2DijArJTZMr3PdQ51+A9erFb2FTzYAen+Rki22O/uTcDDEjH//B1z/ItaG
 kh1RB6cK11ZsBqmjWp2sXCKE5uQByMqQu8qSl6fv8ZPbCd6jcXzLb8bbjizoIwLUKg0o
 zVTOW5m+gnfeWBb0aqI611JK/izwOXIKZN9SedCuDKfEON0GoRsb28t5+lx5YgGGaU2Z
 3gqmr5x9GaUD9TstdaGqYBMA5/bDh4qQlU2dtZeo3DSxVLF+/kDn3ZRMIaACDuyeUPjw
 uXZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mkH5Ny+WhkVeaIA4W5RR2uruxTDuAdtyuuiqwMt878p+v6ByV+A+tJWwkbCdFfQ7n7Qyb4qd5WY8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtJRxLnEBjpgYMbD61M9ZQAsSSThP2tGK+d+4covFf/pSdOgbN
 2Bl/P5OXIOfx4Ifj+hvxvNxArvG+d5T7ixXZbnc9zqui3gWyFX2i4g10RU5rVHwUIDtKNxZGCh4
 hmrq+qVGv/l9L0v5qap6YWb9BoiksEFiNmnrQbX465PkjdpgF7PcaSN8OGS+PLde0mLhbWLg=
X-Gm-Gg: Acq92OEheIg1oKWotTtBGF/kdmHLurESDDcCxd78zWbJnpJkJeReSzmk11XTebn1yPu
 2uOncabxH3VnhAYHMMWz7jjmHQxxiYx98Ly+tmySK1U6zKTfMKPH/MM4y6RLwYtxcmtt7cvM2ER
 eA1Ay9NO3K/xeS2KAJ18mWNQuMv1aQaOO8xjaXptmVzwBV/8c0FRk8Tx8yR1ktf/d81GbGbpJ5Q
 AUrzeAEO7vghohXDe6BMnsMKIdAb8T/Z3Y5xd8Xl3S5q/bYRC81DWSRPaayvpJnsC4ohoSxVt6u
 kgEaIXJJtHmFjvE2lApuPXcSaIU/rKh0eL2jueiM5RG1in+ibHPtV4zX4Cp4E0fWj+E+FuH162u
 ID9YNGS+nTxxrmhTvUCTmg/c+1NObHkezCvFTxgX1CZw5QkOe1kM12Ji+xeI8GtqQllkXGqIUNU
 rbGgc1YU8hu6DS9bNboQ==
X-Received: by 2002:a17:903:22cb:b0:2b2:4bf9:1766 with SMTP id
 d9443c01a7336-2bea33e3948mr28017905ad.33.1779363279471; 
 Thu, 21 May 2026 04:34:39 -0700 (PDT)
X-Received: by 2002:a17:903:22cb:b0:2b2:4bf9:1766 with SMTP id
 d9443c01a7336-2bea33e3948mr28017515ad.33.1779363278953; 
 Thu, 21 May 2026 04:34:38 -0700 (PDT)
Received: from [10.133.33.148] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea98ecbb2sm7832445ad.45.2026.05.21.04.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 04:34:38 -0700 (PDT)
Message-ID: <0e39dd9f-9858-49cb-a052-7d0791b694af@oss.qualcomm.com>
Date: Thu, 21 May 2026 19:34:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/39] drm/msm/dp: introduce max_streams for DP
 controller MST support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-14-b20518dea8de@oss.qualcomm.com>
 <s32w4u44y4jhuk4c4qxsytat2pdiskzuvbozklhofpjh54r7pc@2i6vvbaen2ur>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <s32w4u44y4jhuk4c4qxsytat2pdiskzuvbozklhofpjh54r7pc@2i6vvbaen2ur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0eedd0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=WZztYMh3yrmu__bEN2gA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mb4V9Bs5f3Siq9q4Ii2bP65jQIUk-kHc
X-Proofpoint-GUID: mb4V9Bs5f3Siq9q4Ii2bP65jQIUk-kHc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDExNSBTYWx0ZWRfXweCfYr0Kd10v
 03USB0yvrN16NmpJDIcOrrS9HrdK3MbfYwEChH+6v6NxopNYdpH0ndrHNKsboZvR4NJetQyzPa+
 WBkKeGYq6Z4F/eLemNxXVHZguOmYQPrbd6mltk9qeSdFJWsB150pylpksg5WyUXj5cZzPDG/9QO
 oPmZDh4ZJat4rGb6ccZXkFyL6cY/ZB91CsNWSH9TjHapZsh6n4TkwOGae4hmJhVsHpbSeVO2wsM
 Gju6g36osG6bkaA7hdfaJcmhuU8KYi4AXE2CFeTL57NUz2fBl4xmNzciwqV6C4J/BKbrdHIeDWM
 DgkRrl3MCkJLDPherP+577wtwHK5yaHM23d9dLRNEtGz6LPYky2oiokwcZnO4U0Hpj/71bsIefG
 UpkxCELC1kJ7mQJjgS4754PTYVMumk/xH97JHDhK7RUIucfkmU/yXw/Ws0/7kuLEWW8wvCCMw1M
 sJ9HKVgmb55W+rPiFEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210115
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



On 4/12/2026 1:59 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:33:49PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Introduce the `mst_streams` field in each DP controller descriptor to
>> specify the number of supported MST streams. Most platforms support 2 or
>> 4 MST streams, while platforms without MST support default to a single
>> stream (`DEFAULT_STREAM_COUNT = 1`).
> 
> There is no such const anymore.
> 
>>
>> Also accounts for platforms with asymmetric stream support, e.g., DP0
>> supporting 4 streams and DP1 supporting 2.
> 
> There is no need to mention it.
> 
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 20 +++++++++++++++++---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 ++
>>   drivers/gpu/drm/msm/dp/dp_display.c | 20 +++++++++++++++++++-
>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>   4 files changed, 39 insertions(+), 4 deletions(-)
>>
>> @@ -2740,7 +2741,8 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>>   	if (rc)
>>   		return rc;
>>   
>> -	for (i = DP_STREAM_0; i < DP_STREAM_MAX; i++) {
>> +	ctrl->num_pixel_clks = 0;
>> +	for (i = DP_STREAM_0; i < max_stream; i++) {
> 
> Why? I think the code was fine with getting up to DP_STREAM_MAX clocks.
Sure.. will change max_stream -> DP_STREAM_MAX next version.
> In fact, I'd rather use that instead of the hardcoded value for
> determining how many streams can be there. Think of the old DTs which
> didn't have extra stream clocks. We still need to support those.
> 
The current logic only assigns num streams to dp->max_stream when 
desc->mst_streams == num_pixel_clks, otherwise set to 1 which mean sst.
I would like to introduce a switch in the driver to control the number 
of streams, rather than having it fully determined by the DTs.
Do you think it would be acceptable to use:
dp->max_stream = min(num_pixel_clks, desc->mst_streams)?

>>   		ctrl->pixel_clk[i] = devm_clk_get(dev, pixel_clks[i]);
>>   
>>   		if (i == 0 && IS_ERR(ctrl->pixel_clk[i]))
>> @@ -2750,14 +2752,26 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>>   			DRM_DEBUG_DP("stream %d pixel clock not exist", i);
>>   			break;
>>   		}
>> +
>> +		ctrl->num_pixel_clks++;
>>   	}
>>   
>>   	return 0;
>>   }
>>   
>> @@ -1234,6 +1248,10 @@ static int msm_dp_display_probe(struct platform_device *pdev)
>>   	dp->msm_dp_display.is_edp =
>>   		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
>>   	dp->hpd_isr_status = 0;
>> +	dp->max_stream = 1;
>> +
>> +	if (desc->mst_streams > 1)
>> +		dp->max_stream = desc->mst_streams;
> 
> Here you can assign it from the DT resources.
> 
>>   
>>   	mutex_init(&dp->plugged_lock);
>>   
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index a5c6ed5b18e4..b0cfdf215970 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -26,6 +26,7 @@ struct msm_dp {
>>   	bool psr_supported;
>>   };
>>   
>> +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
>>   int msm_dp_display_get_modes(struct msm_dp *msm_dp_display);
>>   bool msm_dp_display_check_video_test(struct msm_dp *msm_dp_display);
>>   int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);
>>
>> -- 
>> 2.43.0
>>
> 

