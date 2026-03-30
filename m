Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A85EFC981D
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBBE410E3EB;
	Mon, 30 Mar 2026 09:01:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gAUMXid8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YGNYDOgq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED9D10E530
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:01:06 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U4ME4f2196789
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GQXmel9kln/Jv9GA25WCyxahtbgW6KGTrH3uVBAsT2E=; b=gAUMXid8EA6mb1bW
 mC1EEgLZz6Kt7mZbkj9HDORTTKZuE+ykIqxS4JZL+Rb7DOwfGZlyqfbm2Ni6P/7H
 m/9pFuskeu3mEW+vbBKJNRxLcgoCswEvrp9nMdVyPv8XmiFONhmBU9YVcZ7f2d+P
 b5mg5Iqpt9TWNy+2mjDLIaNmzxNyjr6+PJUoHe+3mh2yEIcRL30yeWE/FNG8Eaok
 FjPkkIhR5ee33kwEP2Y9hWAjTm5urGU8IXWVCzViWHg46/9TAx4OEeWOb7qsJ4ve
 YgiWBaoohPX8UX/me4wBE88xJk9ITHSolJaIr/LyJkShStoz1ntu9CyIIDB0xxEo
 EWTIZA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6v9c39ye-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:01:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2523e0299so28374105ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 02:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774861264; x=1775466064;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GQXmel9kln/Jv9GA25WCyxahtbgW6KGTrH3uVBAsT2E=;
 b=YGNYDOgqwzuakpLSHz67+FO4DYkVrbbPOBMWRY4QFyD0me7ug41+3SWQNqQGZ1hbLo
 CBV5eSVhDZDYYOq4zRQ7CUad/uWNuoVTOLDTvzx8ceiKoK6viXkES0Ia0xnzJg3ec2y9
 wXIGO3nfCqaxiJCGdeKXZnFIWNcRfK1uVkMPLsTIDBAw4eRSf6ohxjs5yoBVjyFH9jw8
 n52alNo5qvFJ1pUor6d7S8SX5kAVcDSoy5GACLNiMQrK/RWhsYZWKUzBuyxcFMc2O7/0
 +DFgw11zR54SavtbOpcW3zeDEhE84iAenGq6ePYvPWMfoTosLEueXu5eGCRf+/R5dAbW
 ZIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774861264; x=1775466064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GQXmel9kln/Jv9GA25WCyxahtbgW6KGTrH3uVBAsT2E=;
 b=OkgxrylCbXU19MftEFkG9bfdpxgoXzq2IYEVSC/XJFO2/QxpfLe+Twokp5shaqvJMq
 EtyCToMnGjcACuP7s4mk079XXOGh2L8PY6t2ySKeS7ghELp3TQxh7UaZ1JXQ5LgzRXCG
 BXV0ol3b3clqvQC4AlTSVVmfgvCx5vALNfWzPjdI8/luw7HQAZ6YqMlQrT7WH20lZxKI
 0pXJdff/r2NcAZGQ3X4dDrPcJRvlT2UAqKOUU/fqtv4u1NpsgilQQmw5aBoLLtZpODB/
 eH7I7MoazXXhR7x17+FL/gVrPkpXaYsNfLHEh6vqSMbQ1BrvA/fSW6RoSIsgNoYw8ndq
 tjmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYKEJf0dhHwb6XJ1BQz788EPAwoohqOTx3dzLy9ZTQ5zvqCz2beTnguc+bBRx27r8HU7BGWNxFDi8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhFyts3M+BwTwNBQdso8mWw1OjeGb+bF9FOK3NZWsNrrCET9oX
 yhfC5kryhpPqCXVo5m6Bmjwr8qLLqGaSLH2Q6X4e1sN9MX11KR4kmFNl88802QTuDe9Of0FiBeu
 wZyP9/VzS77q+DlJBaAFHwjLx3IZCAqMFG7Pmee8V5r9f+RfRR0Aw2cU8nlxoTeiviBGINsQ=
X-Gm-Gg: ATEYQzwYjacQGBeEpaRVX+9ASK29waEA3Dx4HkFzwGYm2cDwSUrTj18cRKRYgyrxmpV
 PJ3ZP5cG2EBctiYxyzGi/zQ1pVcE+ksexsrAhH6hMIdUZkWsff6VAtYvepKy6hCeRiCFdOY2hy/
 259aZdjCvmnMbLZwNFzWkMywcxuPtaFP5pTwt3ZwfIoTTn3Scjt5F5W2CyaIUbe21s51VuEuCua
 FJk9ce+SQB4siw+iQlyXszZA0tGQonPYVwxS7Y3QLXgoHv6DU8ljghIQwb3+BzqrdkAFScZpsIc
 WYIhdLIrW4zD2rEcQ4Xyt3NhBGoXGW+kbO2gVfxNY4NnOv9we52Tb/TR6GrmvqX6C6Er7KhKFzx
 agiY2FOemqhzYVTVNE4C4m/U/ztAxcacShX4KBaJ5S8sBce1C
X-Received: by 2002:a17:903:1af0:b0:2ae:ce35:2686 with SMTP id
 d9443c01a7336-2b0cdbeb434mr136509445ad.5.1774861263916; 
 Mon, 30 Mar 2026 02:01:03 -0700 (PDT)
X-Received: by 2002:a17:903:1af0:b0:2ae:ce35:2686 with SMTP id
 d9443c01a7336-2b0cdbeb434mr136508645ad.5.1774861263321; 
 Mon, 30 Mar 2026 02:01:03 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2427658e4sm87552095ad.48.2026.03.30.02.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 02:01:02 -0700 (PDT)
Message-ID: <e9d15987-7c8a-4ec6-8c65-a882139ba0cb@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 17:00:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/38] drm/msm/dp: splite msm_dp_ctrl_config_ctrl()
 into link parts and stream parts
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-5-01faacfcdedd@oss.qualcomm.com>
 <vvemyg2t3ycjwb3uhwua7ow6yjvo2mnu5tdrqc3ed3iuj5ue3v@bfvgfhcxbgke>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <vvemyg2t3ycjwb3uhwua7ow6yjvo2mnu5tdrqc3ed3iuj5ue3v@bfvgfhcxbgke>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA3MCBTYWx0ZWRfX5A8t84EvbfvC
 xE28eCeUnk6l7KS1i2wXullSDxVN2LBaioyyktP4m3LAfOSFtrQlsLRZAotLzLXu2M/t7Q4Iz8o
 0hWzyuV0BL3l6Ft2hEWDINy6Ipb08geYrehC/AKHZBeAslxVesx4dmpAY1VnzQ2syIHUlymUjr7
 Oo/cYTxHBuRgQOz1ggt/NE0wDR8hJsKCo6gN1hfU4u7/yq6KqjoSYcUfZC5qC0buDv3onu2Mo4i
 saw7mlT9QBr97RVL1Mh0hoJRr5zEHL8gGzKtRNcR5IgnTFiLtClx3xMJ3V07t+OMnTkmi4tiLl5
 pxycrazG+4wga8qjS70eiMzfpRVD6EdKdYXSjqd0so+JIcZhufUVSz0p4yP6XKqBZxd1NfJpKXM
 O7IYeoI7h1KBPssNAjd1S4Gzm/yzU3Cl1MD+a/+Tz1SoIYxkp4bTI/YZALsvlTChNL1SqIPew14
 YqhelCy+KbzbWTn76Gg==
X-Authority-Analysis: v=2.4 cv=EIQLElZC c=1 sm=1 tr=0 ts=69ca3bd1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=e15bYA7AIXbTdG7xHUkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: tWTWIQ2Drs57q3bvEjn3LjLY8o9f-jJa
X-Proofpoint-ORIG-GUID: tWTWIQ2Drs57q3bvEjn3LjLY8o9f-jJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300070
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



On 8/26/2025 1:28 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:15:51PM +0800, Yongxing Mou wrote:
>> The DP_CONFIGURATION_CTRL register contains both link-level and
>> stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
>> all of them together, which makes it harder to support MST.
>>
>> This patch separates the configuration into two functions:
> 
> git grep "This patch" Documentation/process
> Got it. Will fix it next patch.
>> - msm_dp_ctrl_config_ctrl_link(): handles link-related fields
>> - msm_dp_ctrl_config_ctrl_streams(): handles stream-specific fields
>>
>> It also moves the link-related configuration out of
>> msm_dp_ctrl_configure_source_params().
> 
> Why? And it looks like a separate patch...
> 
Because the patches following msm_dp_ctrl_configure_source_params() will 
take a panel parameter, and lane_mapping and peripheral_flush seem to be 
more closely related to the link, they have been moved out.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 49 +++++++++++++++++++++++++---------------
>>   1 file changed, 31 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index e1ff4c6bb4f0eed2e1ff931f12ba891cf81feffb..45d6c9a7f7ddaa049443253cbf4c6fc5feda3177 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -380,26 +380,41 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
>>   	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
>>   }
>>   
>> -static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
>> +static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>> +					    struct msm_dp_panel *msm_dp_panel)
>>   {
>>   	u32 config = 0, tbd;
>> +
>> +	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
>> +
>> +	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>> +		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
>> +
>> +	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
>> +			msm_dp_panel->msm_dp_mode.bpp);
>> +
>> +	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
>> +
>> +	if (msm_dp_panel->psr_cap.version)
>> +		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
>> +
>> +	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
>> +
>> +	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
>> +}
>> +
>> +static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
>> +{
>> +	u32 config = 0;
>>   	const u8 *dpcd = ctrl->panel->dpcd;
>>   
>>   	/* Default-> LSCLK DIV: 1/4 LCLK  */
>>   	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
>>   
>> -	if (ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
>> -		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
>> -
>>   	/* Scrambler reset enable */
>>   	if (drm_dp_alternate_scrambler_reset_cap(dpcd))
>>   		config |= DP_CONFIGURATION_CTRL_ASSR;
>>   
>> -	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
>> -			ctrl->panel->msm_dp_mode.bpp);
>> -
>> -	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
>> -
>>   	/* Num of Lanes */
>>   	config |= ((ctrl->link->link_params.num_lanes - 1)
>>   			<< DP_CONFIGURATION_CTRL_NUM_OF_LANES_SHIFT);
>> @@ -413,10 +428,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
>>   	config |= DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN;
>>   	config |= DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK;
>>   
>> -	if (ctrl->panel->psr_cap.version)
>> -		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
>> -
>> -	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=0x%x\n", config);
>> +	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=0x%x\n", config);
>>   
>>   	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
>>   }
>> @@ -439,10 +451,7 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
>>   {
>>   	u32 colorimetry_cfg, test_bits_depth, misc_val;
>>   
>> -	msm_dp_ctrl_lane_mapping(ctrl);
>> -	msm_dp_setup_peripheral_flush(ctrl);
>> -
>> -	msm_dp_ctrl_config_ctrl(ctrl);
>> +	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
>>   
>>   	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
>>   	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
>> @@ -1614,7 +1623,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
>>   	u8 assr;
>>   	struct msm_dp_link_info link_info = {0};
>>   
>> -	msm_dp_ctrl_config_ctrl(ctrl);
>> +	msm_dp_ctrl_config_ctrl_link(ctrl);
>>   
>>   	link_info.num_lanes = ctrl->link->link_params.num_lanes;
>>   	link_info.rate = ctrl->link->link_params.rate;
>> @@ -2524,6 +2533,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
>>   	 */
>>   	reinit_completion(&ctrl->video_comp);
>>   
>> +	msm_dp_ctrl_lane_mapping(ctrl);
>> +	msm_dp_setup_peripheral_flush(ctrl);
>> +	msm_dp_ctrl_config_ctrl_link(ctrl);
>> +
>>   	msm_dp_ctrl_configure_source_params(ctrl);
>>   
>>   	msm_dp_ctrl_config_msa(ctrl,
>>
>> -- 
>> 2.34.1
>>
> 

