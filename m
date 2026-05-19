Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DDACD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67BC10E388;
	Tue, 19 May 2026 07:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RvzUVnQQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ftyrj105";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC00D10E26E
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:46:44 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J4sZvU254356
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s3Ktydrxz2XY64OjZbaLiYF5XalxcbVEevSUnzyHj3c=; b=RvzUVnQQSENSFGGj
 Si3ojI0ppIXc7v9diNm4HpSes+8oXDv1hfEFv25MLDKFFSm8j9E3vXFjPHDpk0Ox
 tKUge0RcMXILXR3UhkByiPyiU+5aLQqhe3ITWdZIfQstkw9wlNF6akETOVQ5/vND
 sLhoF5C/BF0fnMNa9ALJmcTkaBJtoAyDYUfuL4oF8tDeyw6GFYJKuHlv2Xa56GxY
 2v7EnKeIH9bRMg+Uy1Pu7wkbhpyNdWxZ7X6za2lCPhKYP5FU/Qjv9AFjVwbBKpzH
 PItYx88ogM1w9BuhKz9BMm7yDi2okItYS5AeapfLQtJyD9jVhlgih+CxrSOqMxz9
 jqwVxQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8h87rpbs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:46:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2bc6899bfb1so32861805ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779176803; x=1779781603;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s3Ktydrxz2XY64OjZbaLiYF5XalxcbVEevSUnzyHj3c=;
 b=ftyrj105OxGDelcIitT7i5I9uuhVuQF//0Frl49yTVMH6iWVhTOIGeCzZTrmcHxrlN
 wsvh7JJHW4DRrQi0JCCHijukuaDHPk0uZOKmv9erFduU6OUMgAbti6WY5jCPmQ7F/b6j
 +vRWzMdqOupus2ClfjKP02l7Wb+MdPc+4KeawRdX+i5dJTaPdjlElwuVQT+kxcmzrOEc
 qHO5vKHy52K0d4q67cQGD8kWUa1W0aa64HfveXKeVzO3zu96Mm2btEZFo8okPoz024iF
 EEQ+S7vh74FG81Jsto6bNZOWX7lZC7Fn5hm77MFaTsNBdsX68kTzLYh9iW/F/dECanLO
 9BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779176803; x=1779781603;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s3Ktydrxz2XY64OjZbaLiYF5XalxcbVEevSUnzyHj3c=;
 b=mtanjcwF+7MJrNS5WippBwrZywyZsNeFyqFLTqPrPPuJnka6F/2RkbySwf4XZ3NaOx
 447NW/5gE2q8rPkUKAXcE3TktM7LyYG9ko62CRGKds3xBMPtZpEfjt886hhJ5n+lzTor
 9CWAPcNQdc6N7drkhsfSwLewVO9gBMZ/XENXpXA1v1+DEQ6zEDWL5bGFZ17+ipkoRV2n
 7JDFwmO3SA3ClBQK3uOqjGNIeDaP1WBDSfaJ5mKIIO6+iMMwi+DaOplWJ3Xg609xq4m2
 zMvFSzjGbsP9+uq+nBNg+Qr9lM15BIX+iJLhbXtLmGh5Ehrx7XZtmq03X8Ww4WnZ6GYr
 N2nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3mEd5QaLZnd8sgmT5LO8m1KC8tvoGxrbdq+dpTEA9snWGKaJDow6keQcE41is45+a6+MOKtReIfw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+RPsohFekS4lkWBZnrDS3VNx1LCSCxJqZirlAp002oNowmnZZ
 wbgJSKLJUWGX2fnhBv+MO/5ZKJuiCcQzVfysxhJAEAfE9jfD6DQJe0mYGoCv8IyPxrqGy0asM0s
 u0r+goUPBjyZUTExwi2nElOcCAE/Nz1guEjzUApbeARSy4WeLOrf2L2NQSB1WyUQeXBFXJGM=
X-Gm-Gg: Acq92OHLR7OKDZIks98jmTI+FQWuB7bXcsEHgmuPK+wb9wCoLcs0GBFdcjMosoWV99F
 mnftCjgx19hECgl2wGJdEjWB3toeEhIG4z8OgBm944/MzrWimqtAsMKucJ/SbxudkGQMIDf5/vC
 FdvLj7Zu1hhpRTAjyxVjpTnKLpbQOV85PzBxBL8bmrG4rpUcoimSx7uxYY/9AbiuNGjRQqFbUiZ
 /9E59ac1kM34vK0ty9KKJiZQR9Y57lYzOCBJy4NPcnn7iLdQbSnr/QyFV1j8G1lMGIvYB9TFYpr
 J+yAtvy91BRISU7eIKOEf4Y/xsK8pNBk9wLTEsQRBnPyPmdPf23ziTIg4QZvWNbkkTm8Db0mo0M
 RRc3wNnaxXIUy8mygcH1veOIrI9Tofwg5iXg3rCWjuQkf1GkP67x03Wn55BK7PrBPVM7Ewafzj5
 JgR0NkmFs0UEJUOi2LcQ==
X-Received: by 2002:a17:903:2410:b0:2ad:9b86:ddc2 with SMTP id
 d9443c01a7336-2bd7e88f047mr200097935ad.22.1779176802775; 
 Tue, 19 May 2026 00:46:42 -0700 (PDT)
X-Received: by 2002:a17:903:2410:b0:2ad:9b86:ddc2 with SMTP id
 d9443c01a7336-2bd7e88f047mr200097455ad.22.1779176802305; 
 Tue, 19 May 2026 00:46:42 -0700 (PDT)
Received: from [10.133.33.114] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0600a4sm164839885ad.30.2026.05.19.00.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:46:41 -0700 (PDT)
Message-ID: <57f574d3-7000-42c8-a5b7-88f1a73efd50@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:46:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/39] drm/msm/dp: splite msm_dp_ctrl_config_ctrl()
 into link parts and stream parts
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-5-b20518dea8de@oss.qualcomm.com>
 <omw63f7fbqiuw2t266dq5drk7rz2kohydpvbbhcrbfiehb7lzh@aucqhfaliams>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <omw63f7fbqiuw2t266dq5drk7rz2kohydpvbbhcrbfiehb7lzh@aucqhfaliams>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6OUWj-ImPmnIDrICJoi7NST94HAGgQTN
X-Proofpoint-ORIG-GUID: 6OUWj-ImPmnIDrICJoi7NST94HAGgQTN
X-Authority-Analysis: v=2.4 cv=a9sAM0SF c=1 sm=1 tr=0 ts=6a0c1563 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=POr7qE6iPcSwGRG4OQYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA3NiBTYWx0ZWRfX5lAPGUOhvuEk
 EkXCR7AooChdnmIC7h3+lmaJIdlwOY9J9hr1VvEuc4urSXBYvbTwZJFO+E5JtZ+/jNfUwSx1wGz
 NBOWO9ZfbihlOy+fRwJx2MrvNHwcXBg5V838qnFYyU42Anuk04QyXJuxNyQdHASMCSSw0BftFc/
 R9Nnheg5C6A85edPlG3TJgn5tS5O/35lBR9UmDDjhrpk/IwkCysVE+/f4Kz8zT8gDi36qDEjpm9
 HjCIgpcHxCgCjoPwGwGz2jPYogVRz3rrXCjpH3913gBm3kHtrgqbE4hmbXpiAwsVS3jxCuoEfg7
 qI5jhEupmNZLvfNZk1S80oMzlxF2vsQZoUJOiDPbdLqbfgzJnVMGzoUP/1TwgiPk2vSlOg2Js+6
 V7v2Dg9aWfNEW4DgV7obCtHK8BxOfkm0/g5kQbsChvgfUfkkjXyAO9QMwEMPJeaIH8kOJ61AbNe
 1qstvodBD2YjFZtF9Vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190076
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



On 4/12/2026 1:34 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:33:40PM +0800, Yongxing Mou wrote:
>> The DP_CONFIGURATION_CTRL register contains both link-level and
>> stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
>> all of them together. Separates the configuration into link parts and
>> streams part for support MST.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 43 ++++++++++++++++++++++++++--------------
>>   1 file changed, 28 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 476346e3ac19..85315467b5d0 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -388,26 +388,41 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
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
>> +					      msm_dp_panel->msm_dp_mode.bpp);
>> +
>> +	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
>> +
>> +	if (msm_dp_panel->psr_cap.version)
>> +		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
>> +
>> +	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
>> +
>> +	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
> 
> You have an RMW cycle here. Please document what prevents it from racing
> with the concurrent msm_dp_ctrl_config_ctrl_link().
> 
Here protected by mst_lock in MST case. Will add a comment.
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
>> @@ -421,10 +436,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
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
>> @@ -450,7 +462,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
>>   	msm_dp_ctrl_lane_mapping(ctrl);
>>   	msm_dp_setup_peripheral_flush(ctrl);
>>   
>> -	msm_dp_ctrl_config_ctrl(ctrl);
>> +	msm_dp_ctrl_config_ctrl_link(ctrl);
>> +	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
>>   
>>   	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
>>   	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
>> @@ -1628,7 +1641,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
>>   	u8 assr;
>>   	struct msm_dp_link_info link_info = {0};
>>   
>> -	msm_dp_ctrl_config_ctrl(ctrl);
>> +	msm_dp_ctrl_config_ctrl_link(ctrl);
>>   
>>   	link_info.num_lanes = ctrl->link->link_params.num_lanes;
>>   	link_info.rate = ctrl->link->link_params.rate;
>>
>> -- 
>> 2.43.0
>>
> 

