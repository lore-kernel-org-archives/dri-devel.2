Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9ECCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A9A10EF84;
	Thu, 28 May 2026 10:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WUETkDiH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D/UYfeRL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF9310EF84
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:13:13 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vcXE566574
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tw9BCq69+vPICTaEPFF13m6QUIzPyxrc7hFFrxx7Wfk=; b=WUETkDiHdPqIxrha
 Bj+BG/eb1EQsF8AVbKSyChhywX+y9FhIinp8B1Pcq3eS9+wb1NzQIA3v3DQE34pX
 IG/Q4RFInaqDfwleMWDFrU7qQ9ZqGTZnwK9qEHs+EdMmwsCM/VNdNpYpjn8fn9Fi
 AGpJs0INzoYxSdYPtCL9wHp62mAiiEtqvUT+pIWFSXIeTp0nQF7rU7/SN4OxMm1y
 NeGyvKWaNsjcFtiuqdfDI40PrMuIHWy+m6WOxFNsUaggK1s5Cov4JqdRW5Qkrnsz
 j6sr1abSMYCACx3U/SeUOmWe94EO7/DwkPllUdm5NbSDAggELQ2OqLvWXzFL8hL3
 oGdqOw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynjan4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:13:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-516d38bfe83so138553311cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779963192; x=1780567992;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tw9BCq69+vPICTaEPFF13m6QUIzPyxrc7hFFrxx7Wfk=;
 b=D/UYfeRLOGfUy2jz04MWn81T8+UEMGjr100lS/xM4dkq8PAK98zt4/PWgOEfvuStzO
 chO4m/zDxZgF6qqYIXKgchbxR+qFTZVtTCLVz2+vBYSAPsg3ZFGy7gIU8P/pZLTOK+7Z
 cmkkkcDo17AcdUjqnxychfNBY1Gpyl1/ClAeQWoghGX+omzbKWY1YYfGfrBp27JOx4q/
 t9LYcxoayxf2a2G7+afYz9vvrDYshQTJtZj5L1GZTdZzzw33DkxQwg2JZiwnmMK1deOp
 VN+90JPn6ELSo6IToq7nZzeAOOtEeRUb+PtP7nbb8jTVfNWSdVPjkBNCb9NZ9oQBDtNQ
 INug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779963192; x=1780567992;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tw9BCq69+vPICTaEPFF13m6QUIzPyxrc7hFFrxx7Wfk=;
 b=mmiwcyiZlo7dE8WInNnGM28kjN2ro8jX7Le58053XvQkj2amcO0mvgmLg5XU/vIVen
 IGgK2DaDWxxo/Y5eM/XSsiH3vtDltuFE1AbTIvoOmzuJsn18LxBu6j5RSnSm7VsnmPJo
 AEF30rxGhWdsC6igDYPYxf6mELdM28HkLqNxI+YsZIKUthPr32Hv5kEQmmaa2RHjmt4Y
 THa+tosb25YwoetfDRoH7UP4/zAgWKRy7e0LPYKbKGJNBesFdWQGo3aGEa+z37S0V+UK
 DSAWfxPjjUgyFP7C0wmKvX7q9oy56lqts7Bkv7pNFVGmzFyoGzMo3XyUqEO01FeVhfY3
 4IrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9C3ky/Hf56G2BRi6/02Eo8rRu7o3kuOSwSFGBNK9RScy5BBJP4YN6Dn927eM9oH47POo2oNl12jA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvWSG2fWIK5kAzrt2cfLEFDhkQ0MF1Es+4jBgPwQDilp0wfQf5
 KaFN9CzP383QvKCUdJGnWb0UCgxf4KIGBDYQx+SBJnN230YkwCGcvNF/xyQCSgJaJNq3Z39cy0l
 +vCZUzFPk6l0b3hL+EvLytyT5zqe4hwnpAlxtjv8pKtojed9ievydBm35S7U00QEhZlMbj2Q=
X-Gm-Gg: Acq92OE75MSLa3axhXNnRmZzQvlUJ4WYaS39Qh9N2XTziVwaC0x63Pohx9LSSkL4Ekt
 2BFm2+vPR3j5Zl+4MymyJhk9EMqd8t156JF+LjQKzCjEd3hwbrdK7NA3jFEUxDmxlBkmsR9N8LZ
 RT78RN74eVUnZj5rLUOsDgmxnwOdmOa/vOYDTDPHT6Sx7ZSAKGSfGBvaiMqrGLLfnbmf4ixVDW3
 COjyRY0X+swul+zc5iOqxZilVjSyCvvGrE0E6p2J9MiCZN8I9wxgE8E1nQxDYnkri9PfLaGqUJT
 cMJ9TcTZrVLlVp9hODCApOKJo2k/QpFnlDsaZoD2tb7gqO2EWY/FSdcZ+v9MgMtC0Uc/rpItW+x
 lk06/qajCFWZnoV39ujMJCBDLd4ciDXgcCTs72JCQ4jlUb1BYr+2ouXpxWM7Ak9sizn5ni/dGSI
 m6yeauXje30F6VZFUUq3XGNQ==
X-Received: by 2002:a05:622a:d0e:b0:516:e96b:2356 with SMTP id
 d75a77b69052e-516e96b277fmr252286931cf.24.1779963192096; 
 Thu, 28 May 2026 03:13:12 -0700 (PDT)
X-Received: by 2002:a05:622a:d0e:b0:516:e96b:2356 with SMTP id
 d75a77b69052e-516e96b277fmr252286591cf.24.1779963191696; 
 Thu, 28 May 2026 03:13:11 -0700 (PDT)
Received: from [10.111.173.202] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc80ded529sm195589336d6.16.2026.05.28.03.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 03:13:11 -0700 (PDT)
Message-ID: <057742e8-9de9-4aa0-ac5d-8ddf44cf467d@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:13:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/39] drm/msm/dp: pass panel to display enable/disable
 helpers
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
 <20260410-msm-dp-mst-v4-25-b20518dea8de@oss.qualcomm.com>
 <7dxlzm5hm2uq7ai56lmvzyjntn4kprdg5bp6qr77cqetku4hgu@iom7kqnfn4eo>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <7dxlzm5hm2uq7ai56lmvzyjntn4kprdg5bp6qr77cqetku4hgu@iom7kqnfn4eo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8AtwaIx4BijORgpxkwW_-hEjYA5_47HN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwMyBTYWx0ZWRfX1ONyANFBXqUM
 lyBjnN9a8EKw4MfQRwX4RaZ8qU8P1SDB/pqXwPXoLevkcIEWJgFS4WQJYD5DDLg3hwxI9vZCsDF
 DBTMyc2+uNx/HQSyxW1+NAhDpLOUkFs2IcQ0/9WY7+mb3sk2TYLGuZ0BmyHFRGCL5hbMEUa4ZZ8
 QfcATOAMvOKsFLAHuklT2a9m13EPkoxe2hqVkZwVOhEyi9tfV8X+UShqxPw8NO55kzKukodUVvp
 Z85+5XLMHRMN1LgjauVOseCvjzNvhhcLagAEbqZI3tzrO6yOlyScjGOu16YMLXZItaCyLgVYtXC
 Bpfbt9mHnT3g/lePjy1yv2DPPqwutKsZ5PDj5W9BP4r+wkjY11wW5+8D5J7c2gG7lWGOa7Bj//J
 UwAQ6P4ij0xhNqNJr1SDgwEKp5sI1vRF9f2GmlK2pVuV1TaAIq0418pO9fumEFJP8n6muCKneSa
 6NF+y0ei7Bomin1B3bA==
X-Proofpoint-ORIG-GUID: 8AtwaIx4BijORgpxkwW_-hEjYA5_47HN
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a181539 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=keVsun0R0cJNlHGda80A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280103
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



On 4/12/2026 8:05 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:34:00PM +0800, Yongxing Mou wrote:
>> Pass struct msm_dp_panel to the display enable/disable helpers to make
>> them easier to reuse for MST stream handling.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 18 ++++++++++--------
>>   1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 7b3b9160e005..88a078e53dc1 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -668,7 +668,8 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
>>   	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
>>   }
>>   
>> -static int msm_dp_display_enable(struct msm_dp_display_private *dp)
>> +static int msm_dp_display_enable(struct msm_dp_display_private *dp,
>> +				 struct msm_dp_panel *msm_dp_panel)
> 
> Where is it being used?
> 
Got it..That was my mistake — I’ll pass it inside the function.
>>   {
>>   	int rc = 0;
>>   	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>> @@ -725,20 +726,21 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
>>   	msm_dp_display->audio_enabled = false;
>>   }
>>   
>> -static int msm_dp_display_disable(struct msm_dp_display_private *dp)
>> +static int msm_dp_display_disable(struct msm_dp_display_private *dp,
>> +				  struct msm_dp_panel *msm_dp_panel)
>>   {
>>   	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>>   
>>   	if (!msm_dp_display->power_on)
>>   		return 0;
>>   
>> -	msm_dp_panel_disable_vsc_sdp(dp->panel);
>> +	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
>>   
>> -	msm_dp_ctrl_off_pixel_clk(dp->ctrl, dp->panel->stream_id);
>> +	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
>>   
>>   	/* dongle is still connected but sinks are disconnected */
>>   	if (dp->link->sink_count == 0)
>> -		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
>> +		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
>>   
>>   	msm_dp_ctrl_off_link(dp->ctrl);
>>   
>> @@ -1529,14 +1531,14 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>>   
>>   	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0, 0);
>>   
>> -	rc = msm_dp_display_enable(dp);
>> +	rc = msm_dp_display_enable(dp, dp->panel);
>>   	if (rc)
>>   		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
>>   
>>   	rc = msm_dp_display_post_enable(msm_dp_display);
>>   	if (rc) {
>>   		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
>> -		msm_dp_display_disable(dp);
>> +		msm_dp_display_disable(dp, dp->panel);
>>   	}
>>   
>>   	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
>> @@ -1573,7 +1575,7 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
>>   
>>   	msm_dp_display_audio_notify_disable(msm_dp_display);
>>   
>> -	msm_dp_display_disable(msm_dp_display);
>> +	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
>>   
>>   	msm_dp_display_unprepare(msm_dp_display);
>>   }
>>
>> -- 
>> 2.43.0
>>
> 

