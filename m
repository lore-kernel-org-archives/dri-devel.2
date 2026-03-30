Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA515FB3CE5
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A3C10E48F;
	Mon, 30 Mar 2026 09:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A+cojxtX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dkhjG549";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 314E310E48F
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:59:37 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U8Pw4t2458323
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +oFEZzGALuVwvBpWKTSR8/70BuWj677y5wYf3rKFaL4=; b=A+cojxtXcurl7zMz
 jSQMAPvKDMu2n73fX2DoO0XHGQ4aR2WDpdvTtv+8qQpctDXjAy7HxU37IKCRy2AY
 AprqsptFy7B3km/iqS3Fdh2vQBYPY+CzjZvHPJuf5OrAHDiGT+LvBzsWEQhJqzCS
 qHritJ0Oxh4UXYo0gBzIUjWUw/caw+W65ynSL0FM8vjAdtQZLxGbwEZX3L+iGmuz
 DWyFwEmrnaoVbqOYjva0qvvQHt7ma8CJuEnra9QcDUtDcxKaFt1ELpWYS8IvlNij
 vo9HFq2erw95EgT21sMZ4usL6eBxwAKpv7Tpx8qFJbEXsg0M5MmZsJXcM7Ds3xXT
 KI74ig==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7nnmrct6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:59:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b24cd2e2b3so14762775ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774864776; x=1775469576;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+oFEZzGALuVwvBpWKTSR8/70BuWj677y5wYf3rKFaL4=;
 b=dkhjG549R8eG5d4nIhAVy5ZiOl4LQWBPyTyYM10W5OLZdO+TCDjfpk2JMLq1S7YGBT
 POqzQT55lgGvNcbWEAVWkg5v6o+C+B9sejW0LhMOtuPikw83uUGclkCnWqc7fwQh99EP
 Tuf82SrfUruBVgTmePGERj8J8ek2RjGUrC7nUxXK4pVrb7uki3Ji9sSocFFMbnSa7M/n
 9oj59xhtHUdXeIHHbMQiWGYJSp0+9SjWd0WGSHhofdVqDM/V/hr1Gpb40K7Pk0tA1fGe
 EXnwqYA77LPeqz5VP4L7Od2EogfueCI6+xRNqRb/3yGRdELxaXt6PE1CHaXdNNWYODmL
 c5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774864776; x=1775469576;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+oFEZzGALuVwvBpWKTSR8/70BuWj677y5wYf3rKFaL4=;
 b=drTS4YRmN5BrSnmxupsafMM1TeJe1Ob33V70OrcjksdRLEeQ7v8VSZw4uGyEuc1NYY
 jMCLZqtOvR5Z1ZwZhA4FKs2LV8NkAjF2yJKQTpl5VuiaCW4AJRc9HlDs47ULACGf/T7A
 FO8FZ2JLeF9IH261ja8ydEEwcUWjc0+R8RiVSlpgLjgtenI2Nvd+nMqcz8BIwsGPSyDR
 +40rbQRDU8AgflhO/B20PHu48dfo9iHAR9Q1NvW3gmcXuXconr6k/ejPMaqLbzJ1U2Wr
 WsEHrGRFc96i2RL7lwRB/M+MXkmXxbNihY9Fock9Oavli+S6OhFH6QQRf7tgwbXzDNZZ
 j4aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVldNQBkbsfoogjxxjmsEKERCJu2MmNiS3TXX7DnwhforvL4qUvIRH2a7aHQNTPrbPrzDafKS8arDg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdmNp0DT725rqf6ryJbVpS/a2m+660IFitravoszBtkh3t9231
 pA33fVWZVvqrGJnK12aOGPUCyvDc51+o25YAyw+lnk1LhrRCIyVtkG6Vnm8YcKWmltPrK7iE/8u
 A3IGBMOrFtheqfr/qfnR/8/JKJvT8PC71Hj3Vo0cDMTtWJLF921fFBE4vTynhMRQ242GjMIQ=
X-Gm-Gg: ATEYQzyc2fSB0l2aMvkDxv6DtDt/zIqtti/jCgX26fvqf0xlmwTYn5qUyBaBayzZlcs
 tb6y79JGQTpQVu+Yhn1hTLiiSV/5u8j28GezoyoqXFig/1QQ0mVh7JT237yxDkS3RRAAK/eYiiU
 0Uctzi80oDYgPenzQhwOoMHk3XCbnyFxwQ2UCV2PrwcnJ0TRt/c2FE3kC+ejnTywA6ZFA5qsWlZ
 HNDEXu5gas/K8DRY6m+ef/8rqYn/3+I7EbMQ7mJkEU5wxK8WG6uEPm+pmlT/C2QVW2buuTywtJz
 9zFX48HZXO7j1cgxz6R4rURv1SN+zekGVZi80v6C+w1vzOxtr9vjHzuiHNIylSypc1iRo2IMBxy
 /tM6vPUmuUAVXYaZpJyjIzsXxOmFKW4bys782pQr5LmKblCKy
X-Received: by 2002:a17:902:ce12:b0:2ae:54b2:27c7 with SMTP id
 d9443c01a7336-2b0cdcca420mr133928645ad.39.1774864775978; 
 Mon, 30 Mar 2026 02:59:35 -0700 (PDT)
X-Received: by 2002:a17:902:ce12:b0:2ae:54b2:27c7 with SMTP id
 d9443c01a7336-2b0cdcca420mr133928225ad.39.1774864775490; 
 Mon, 30 Mar 2026 02:59:35 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2427c4cafsm78786605ad.81.2026.03.30.02.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 02:59:35 -0700 (PDT)
Message-ID: <7e6a7bdd-a94c-418e-92e6-524a58cdca46@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 17:59:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/38] drm/msm/dp: introduce max_streams for DP
 controller MST support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-12-01faacfcdedd@oss.qualcomm.com>
 <lngtq2tw4qajgjk57un5xrveblkmtjkkz3yjgue53vp6wwmqmf@owderf4zerfq>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <lngtq2tw4qajgjk57un5xrveblkmtjkkz3yjgue53vp6wwmqmf@owderf4zerfq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA3NyBTYWx0ZWRfX4WQlCfeCFX15
 J9kUJwu/hQGj+xskCj0HoEjtuknfCZOrTdPrWMGjdQoALGIAGjGEBPa+Tc/X4sxrrOpSqnRlmpw
 7+cy1dF/rrXGqLr/0PvqO1DONSbOum20YG4mEzApBeEO3MvjkYupkFTY5X7B9sbfKP/0l2dW1Ni
 uWjn6VT1wMnHXkD5uTr1+XlcceOK2GhpDSoJlMH+br44nz4OTRShQ5wVEeom9LO83foi08fbKH+
 JhVo4yjXht/FdbGvbFV56Le2OLeELxR7O7/OudOk71kiN4bcrk03FvJtp+VvC0/15g2N452qRbI
 soRokO0UpONflu2a8eyZYadDwF7eWEOk4cOQbrcQWvtHNlF2kSzfalG/Zl9NSLPt0P2CJo+WpfM
 Srx8LJ9Gpyz3bMzva8R8s5z/gmDU9gmMPq9xfVTYsifxLaDKOxrMeDZKQ3efdvohEP+Va+GEHhd
 J5HxpHdkt+5VcWR3edg==
X-Authority-Analysis: v=2.4 cv=M4FA6iws c=1 sm=1 tr=0 ts=69ca4988 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=J4JoB0OTnpniNVX1FM8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rbjAiRc7Zy_Mdjdi62R0mYKqT0_uYrFd
X-Proofpoint-ORIG-GUID: rbjAiRc7Zy_Mdjdi62R0mYKqT0_uYrFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300077
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



On 9/2/2025 5:41 PM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:15:58PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Introduce the `mst_streams` field in each DP controller descriptor to
>> specify the number of supported MST streams. Most platforms support 2 or
>> 4 MST streams, while platforms without MST support default to a single
>> stream (`DEFAULT_STREAM_COUNT = 1`).
>>
>> This change also accounts for platforms with asymmetric stream support,
>> e.g., DP0 supporting 4 streams and DP1 supporting 2.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 21 +++++++++++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 78d932bceb581ee54116926506b1025bd159108f..a8477a0a180137f15cbb1401c3964636aa32626c 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -33,6 +33,7 @@ module_param(psr_enabled, bool, 0);
>>   MODULE_PARM_DESC(psr_enabled, "enable PSR for eDP and DP displays");
>>   
>>   #define HPD_STRING_SIZE 30
>> +#define DEFAULT_STREAM_COUNT 1
>>   
>>   enum {
>>   	ISR_DISCONNECTED,
>> @@ -52,6 +53,7 @@ struct msm_dp_display_private {
>>   	bool core_initialized;
>>   	bool phy_initialized;
>>   	bool audio_supported;
>> +	bool mst_supported;
>>   
>>   	struct drm_device *drm_dev;
>>   
>> @@ -84,12 +86,15 @@ struct msm_dp_display_private {
>>   
>>   	void __iomem *p0_base;
>>   	size_t p0_len;
>> +
>> +	int max_stream;
>>   };
>>   
>>   struct msm_dp_desc {
>>   	phys_addr_t io_start;
>>   	unsigned int id;
>>   	bool wide_bus_supported;
>> +	int mst_streams;
>>   };
>>   
>>   static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
>> @@ -1213,6 +1218,15 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>>   	return 0;
>>   }
>>   
>> +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display)
>> +{
>> +	struct msm_dp_display_private *dp;
>> +
>> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>> +
>> +	return dp->max_stream;
>> +}
>> +
>>   static int msm_dp_display_probe(struct platform_device *pdev)
>>   {
>>   	int rc = 0;
>> @@ -1239,6 +1253,13 @@ static int msm_dp_display_probe(struct platform_device *pdev)
>>   	dp->msm_dp_display.is_edp =
>>   		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
>>   	dp->hpd_isr_status = 0;
>> +	dp->max_stream = DEFAULT_STREAM_COUNT;
>> +	dp->mst_supported = FALSE;
>> +
>> +	if (desc->mst_streams > DEFAULT_STREAM_COUNT) {
>> +		dp->max_stream = desc->mst_streams;
> 
> We should keep compatibility with earlier DT files which didn't define
> enough stream clocks for DP MST case. Please check how many stream
> clocks are actually present in the DT and set max_stream accordingly.
> 
Now these DTs should already have the MST clocks added.
>> +		dp->mst_supported = TRUE;
>> +	}
>>   
>>   	rc = msm_dp_display_get_io(dp);
>>   	if (rc)
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index 37c6e87db90ce951274cdae61f26d76dc9ef3840..7727cf325a89b4892d2370a5616c4fa76fc88485 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -29,6 +29,7 @@ struct msm_dp {
>>   	bool psr_supported;
>>   };
>>   
>> +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
>>   int msm_dp_display_get_modes(struct msm_dp *msm_dp_display);
>>   bool msm_dp_display_check_video_test(struct msm_dp *msm_dp_display);
>>   int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);
>>
>> -- 
>> 2.34.1
>>
> 

