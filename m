Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2C9606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 05:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UDTuCscC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QzDcmeLa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6583D10E2E5;
	Fri, 13 Nov 2026 05:03:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8A910E165
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 05:03:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD2K9cY3826192
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 05:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4LzS+YwqaLQraW5nig2t+3o+xSFf0cUTjyJXReh6cLY=; b=UDTuCscCngJY3MLs
 CRPtcPVcxnzOlQogNMs08+nMF8l8kAieCNstwghs4wYc96xBzKYbRIXNTbu+LKw9
 zJ2IrqGXBkNxEK51C8qHgZmH9VvYgJYhv8LEC26IpY/bXilK4cw8glzimG3OxmRG
 wLslyyemyvWaRPfpYIAzCS9TM/3kS2uHdj4Uo5r3Xo58p31ZT663bt/1xaJFUKpu
 MA2MnmnS5NnSiHrgkkWxxqIuNBTWK+bxZ1dL8gs5qiVTs3Z/5A3buMaQ7iZgluI3
 tv2Du45ektPAFZ3aSjB9yCknMUf5NTgCytbSvBcLvDCdVFuXIxKR7xeF8MMBbnBi
 SndSMQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs03gmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 05:03:08 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8aa185840bdso421942b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 21:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794546188; x=1795150988;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4LzS+YwqaLQraW5nig2t+3o+xSFf0cUTjyJXReh6cLY=;
 b=QzDcmeLaE/X6YqyhOVZXNKAQqNhd6eo9PfnPJ8HuCkyYfP89nCpS8OUMI9sLDvlHe9
 B5MmVfJIuwxzNbg2tDrMwCzagjXOtjLxuQ2iCF9osmo3Z29lOlFcHhhi9c7KgDmbr0VE
 rIogAFcUQLlElC2ruFGDefMj5EEYcIjnKIrA+brMxCBebYt8QVg2d4wgvcIAT+rgKNBJ
 KIZkFhKK3YzfIDbjnHaWxYsINs3K7qZ/ajOXcDi+nE40+uYNtNiRZElet7a/iIiRutM9
 aZyKuYMgEb3tJQPNLOa1J6tUH1qH/k0Ayo3sHW1Rk5UQRSMPI4S+3xf+8x3WjwJ2PYu5
 D7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794546188; x=1795150988;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4LzS+YwqaLQraW5nig2t+3o+xSFf0cUTjyJXReh6cLY=;
 b=Z7zXKT/apAmCZwudwrdeVXClUa4+6kOen5F051+x6ON6iXXxlNrpuexXL8R9aWkojn
 opvOeRvb5jaDAiPgQfH1zoMN1NIN3Glx6jEer56JFNBKE5kLBWjs7rAyH7FBiGveW20Q
 1JUcwAGQeFuB49Mk+UuMn00X07XTLYSk0+nvKJg5QzuLziQj8Ol/UxOxHCwSeA/Ug7Dm
 pC2VodehyIUve7v7A3yfKa8NZwQA4+hNb23FBvsYrv60PGUyyWjZI+WFDTi6lZbdwROD
 iOLk+ms3dmhEbGy+zLLQ4d5VEp5Kg2+XnTaTCv1totkTAJxWqTi2oO5Vjk4yk75XyK0i
 NqUA==
X-Forwarded-Encrypted: i=1;
 AL+hErGee/T4NWrrOhkQI8Ejp5k8GEvg70mVy+dFfh2XxtK4MMUL2yaKcLdQE76m6kI0XxtGTeZqWgjlCvg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/co5cdh+EF0DB60ivKGTcnQXe5jg2le7OUuwaw45DaVnCidFJB
 4u5fysbo5YFbFYsHTeLF8v4EQTazhfi0/ucSI3k3xf+IJlJeyKDNq83pI4HegMM6Klgbz9O43Br
 c+Cxa+PyKWEvxn2C9JRY5uvr53RlAWzGwy/qR49IgWOcl+COr7eO3CUyjTvQDI9JT9Y0TqWRnl0
 2kJj8=
X-Gm-Gg: AYBFou3sIbNdvZ0vJ2E5/OmF38X9TMHITsy0Td13mnk1jyx3Va2h2+jBMaVJMSYYNDT
 JMZk1FNhrX8rTs9sI0b2aegN8UJWGr3lWfO+ZYOvhrwOGHejP6ncxdsUXtTFpVu0oyhNDx7luGC
 NtPj9RGhXomOVbmtlaln5WGt/p01tNQm1aVJI5/+Ij96EYPm/jX/8c3xvSYQPVKV2rWKajY2+NY
 rlmZ0dz6DobF+7sSq5q+dXtk1SCJ2dCgSRJecIv2Joco9wF7I6u9Fk1212ycwCewmQsEa9QCrwb
 hUj+9i3sWyEzPj7DDt2vFS2jArOCiGh+sWuk7xwJT6P9DRdvvFDcxzvn23o0aiFSiTdCeYg5qRh
 0c312CnReq8/QG1bk+KI3B7GjQNY8ShAX6WVijWeZScgKUXUBU08kVjLpOP2sHA==
X-Received: by 2002:a05:6a21:7993:b0:3e8:b7fd:6284 with SMTP id
 adf61e73a8af0-3f7a7ec35a7mr1136667637.43.1794546187526; 
 Thu, 12 Nov 2026 21:03:07 -0800 (PST)
X-Received: by 2002:a05:6a21:7993:b0:3e8:b7fd:6284 with SMTP id
 adf61e73a8af0-3f7a7ec35a7mr1136637637.43.1794546187010; 
 Thu, 12 Nov 2026 21:03:07 -0800 (PST)
Received: from [10.204.79.100] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc186f472sm610637a12.6.2026.11.12.21.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 21:03:06 -0800 (PST)
Message-ID: <fb8b5604-b115-417f-97ba-f0848b024fa3@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:32:59 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/msm/dp: continue link training downgrade when
 cable is still plugged
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, mani@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, irlied@gmail.com, simona@ffwll.ch,
 Saurabh Anand <saurabh.anand@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_riteshk@quicinc.com, quic_vproddut@quicinc.com,
 quic_mkuntuma@quicinc.com, mahadevan.p@oss.qualcomm.com
References: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
 <20261111104434.2222182-4-naidu.nama@oss.qualcomm.com>
 <x74bp2hkm4r2qz7oelhwpgexd3tslsxgc67pu22kmlo5yjy33z@v5ka23e5aqqi>
Content-Language: en-US
From: Naidu Nama <naidu.nama@oss.qualcomm.com>
In-Reply-To: <x74bp2hkm4r2qz7oelhwpgexd3tslsxgc67pu22kmlo5yjy33z@v5ka23e5aqqi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfXxkysKELFpvgV
 zmVlqQbPhm5g0U+fb6Xd963wxPM0A17yPEzsnWZSVYg6KditZHKk2Tnay0/p3/df/4dxUPtGEse
 ZT0m75yBNeXSp3OnT8n01ato0mVrnDTadLvkmlpKOlDcrc5AaVJrj3MsA4thqCTjXtZcOUpIG18
 wIv5gWtOs/Tk2uwOKJIQpA4Yl1dM3ibZsXJTZ7LOqDmtuwnirlEeCgIZiMsvaP7kZrv/oqDg5qk
 E2frbJh4gMHnOT1yIWvqsggYVfHF7AP/EGRnvPxnyfA00DQsevxPKQHqqTuNJad7c/hXXaPhpLm
 FTWMKnl1zTiFNCJLhW4z3CDdx1wRFh2BGO/C3B2mtEYhfYT0pAeVqrP6Exbh9/S59T4FhCPOlju
 fW6GNYAfEYdE6v3ZLeHZlUT4n2hdLIXWaopMFdboJbNP7YiGu8Bv8EK728x+uJ2fSMoNpHjZmLw
 9gWt+o+qd5RLHrlRGaQ==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af69a0c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=WWo1CF43h56B4pvcxosA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfX3P2JlgmLZsjP
 tewPtZqdzo/xgLbh1eeE4XQTYDlEBNR6AYGKaKzhDzlRH1ILwdiJqdFbD73RQjwAA4rDlFdwS1n
 5nvgadb1BYo+9qXczHTh6MhP72d4zro=
X-Proofpoint-GUID: -DMEjJBwJf4e4_HiXwwI6YOVviXJMXz0
X-Proofpoint-ORIG-GUID: -DMEjJBwJf4e4_HiXwwI6YOVviXJMXz0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130019
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11-11-2026 19:38, Dmitry Baryshkov wrote:
> On Wed, Nov 11, 2026 at 04:13:55PM +0530, naidu nama wrote:
>> From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
>>
>> During a Type-C reconnect the AUX channel may report link-disconnected
>> transiently while the physical cable is still present. The link training
>> retry loop in msm_dp_ctrl_on_link() was aborting immediately on any
>> msm_dp_aux_is_link_connected() failure, preventing the rate/lane downgrade
>> path from running.
>>
>> When the display is known to be plugged (msm_dp_ctrl->plugged), an AUX
>> link-disconnected status is likely a transient glitch rather than a true
>> unplug. Allow the downgrade loop to continue in that case by requiring both
>> conditions before breaking out of the retry loop: AUX reports disconnected
>> and the display is not plugged.
> Is there a reason to assume that DP is not plugged at this point? I
> guess not. But the other issue is: what if the DP gets unplugged in the
> middle of link training.


dp is plugged at this point, the issue we have is the 
msm_dp_aux_is_link_connected is giving the return status as 0 in 
sometimes , due to this the link training
retry loop in msm_dp_ctrl_on_link() was aborting immediately. To avoid 
this we are checking the plugged status as well.

Similar check  was made at dp_dispaly.c in function msm_dp_bridge_detect.

Here as well we are getting the ret as 0 ,as there is one more check 
plugged which is true , which is avoiding to go to if statement and 
continue further .
ret = msm_dp_aux_is_link_connected(priv->aux);
         DRM_DEBUG_DP("aux link status: %x\n", ret);
         if (!priv->plugged && !ret) {
                 DRM_DEBUG_DP("aux not connected\n");
                 priv->plugged = false;
                 goto end;
         }

if dp gets unplugged in the middle of link training,but the call started 
with plugged=true, that particular check won’t stop training 
immediately. It may continue retrying or fail later when AUX/link 
operations fail.
>
>> Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
> SoB


Sure, I will update in v3.
>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 15 ++++++++-------
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 ++--
>>   drivers/gpu/drm/msm/dp/dp_display.c |  7 +++----
>>   3 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 6b9d9a76ba05..f8a6bd7b0d10 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -2274,7 +2274,8 @@ void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stre
>>   }
>>   
>>   static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl,
>> -						struct msm_dp_panel *panel)
>> +						struct msm_dp_panel *panel,
>> +						bool plugged)
> Can it ever be false here with your patch in place?


it will be always true, this is set to true before the link training.
>
>>   {
>>   	int ret;
>>   	unsigned long pixel_rate;
>> @@ -2293,7 +2294,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>>   	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, panel->stream_id);
>>   	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl, panel);
>>   
>> -	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel);
>> +	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel, plugged);
>>   	if (ret) {
>>   		DRM_ERROR("failed to enable DP link controller\n");
>>   		return ret;
>> @@ -2310,7 +2311,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>>   }
>>   
>>   void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
>> -				     struct msm_dp_panel *panel)
>> +				     struct msm_dp_panel *panel, bool plugged)
>>   {
>>   	struct msm_dp_ctrl_private *ctrl;
>>   	u32 sink_request = 0x0;
>> @@ -2325,7 +2326,7 @@ void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
>>   
>>   	if (sink_request & DP_TEST_LINK_PHY_TEST_PATTERN) {
>>   		drm_dbg_dp(ctrl->drm_dev, "PHY_TEST_PATTERN request\n");
>> -		if (msm_dp_ctrl_process_phy_test_request(ctrl, panel)) {
>> +		if (msm_dp_ctrl_process_phy_test_request(ctrl, panel, plugged)) {
>>   			DRM_ERROR("process phy_test_req failed\n");
>>   			return;
>>   		}
>> @@ -2377,7 +2378,7 @@ static bool msm_dp_ctrl_channel_eq_ok(struct msm_dp_ctrl_private *ctrl)
>>   }
>>   
>>   int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
>> -			struct msm_dp_panel *panel)
>> +			struct msm_dp_panel *panel, bool plugged)
>>   {
>>   	int rc = 0;
>>   	struct msm_dp_ctrl_private *ctrl;
>> @@ -2427,7 +2428,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
>>   			break;
>>   		} else if (training_step == DP_TRAINING_1) {
>>   			/* link train_1 failed */
>> -			if (!msm_dp_aux_is_link_connected(ctrl->aux))
>> +			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !plugged)
>>   				break;
>>   
>>   			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
>> @@ -2452,7 +2453,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
>>   			}
>>   		} else if (training_step == DP_TRAINING_2) {
>>   			/* link train_2 failed */
>> -			if (!msm_dp_aux_is_link_connected(ctrl->aux))
>> +			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !plugged)
>>   				break;
>>   
>>   			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> index fc884038182f..3edf954cc805 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> @@ -17,7 +17,7 @@ struct msm_dp_ctrl {
>>   struct phy;
>>   
>>   int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
>> -			struct msm_dp_panel *panel);
>> +			struct msm_dp_panel *panel, bool plugged);
>>   int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel);
>>   int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
>>   				  struct msm_dp_panel *panel);
>> @@ -28,7 +28,7 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
>>   irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
>>   			    struct msm_dp_panel *panel);
>>   void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
>> -				     struct msm_dp_panel *panel);
>> +				     struct msm_dp_panel *panel, bool plugged);
>>   struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev,
>>   				    struct msm_dp_link *link,
>>   				    struct drm_dp_aux *aux,
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 169938ba515e..551d2c63ef8e 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -399,7 +399,7 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
>>   
>>   	drm_dbg_dp(dp->drm_dev, "%d\n", sink_request);
>>   
>> -	msm_dp_ctrl_handle_sink_request(dp->ctrl, dp->panel);
>> +	msm_dp_ctrl_handle_sink_request(dp->ctrl, dp->panel, dp->plugged);
>>   
>>   	if (sink_request & DP_TEST_LINK_VIDEO_PATTERN)
>>   		msm_dp_display_handle_video_request(dp);
>> @@ -648,11 +648,10 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
>>   	if (dp->link->sink_count == 0)
>>   		return -ENOTCONN;
>>   
>> -	if (!msm_dp_display->power_on) {
>> +	if (!msm_dp_display->power_on)
>>   		msm_dp_display_host_phy_init(dp);
>> -	}
>>   
>> -	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
>> +	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel, dp->plugged);
>>   	if (rc) {
>>   		DRM_ERROR("Failed link training (rc=%d)\n", rc);
>>   		// TODO: schedule drm_connector_set_link_status_property()
>> -- 
>> 2.43.0
>>
