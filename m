Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ED2FB3CE5
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3198210E558;
	Mon, 30 Mar 2026 09:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pSwlnorm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I7aAqWif";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D962110E557
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:57:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U9nHpm3722183
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U+q+5RHoG05AQakEjF3RsKZ6QTb82SYW8BIOn7cpF4Q=; b=pSwlnormFTICBJC1
 YN17+71CfmPcq9N6kqRvKF9dcIJ9K3K/SJb4UCVH8BT6X3M/crTNdLyaCLayPNE/
 5tuyTF6yVJCX51sRLMk+PKRTRqJGr8rjpxgDOJyu8hvWMiyq2qhzKtgQ7lvAWhq4
 2ZQTti2UWrX5YJFoqtkHmAxJbpSB1NuHICBTYgkeowWx/1ATG3r83TDJNnyo+Ntm
 FrupbIVi5GQLwABPhsReaQlI+WIyDZRPG0IdrItSVgSQ726s2JV3X3mGaqkZnckJ
 h/yX63q/trLJThX4QT70pCAj1bKPaFEFtelF1OLZ2DtohMacD4BYiRx5sgzgT/0S
 uGGpuQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7pvmr0yu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:57:20 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82c38b85c25so8082136b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774864640; x=1775469440;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U+q+5RHoG05AQakEjF3RsKZ6QTb82SYW8BIOn7cpF4Q=;
 b=I7aAqWif1umNh0es4ZD53T8B9U8cWMGgo9ZJwSeksyCc7TQquFO4LjOH5NKk3Qy/kT
 ZiNQBGq52nvHmo244A7qLByF65mao5CH9GRQy5shcg0nD6AM4nHXtUspJf+IPnvbRXhe
 LgfV1eO2VIEOLk++Wvr2IgA4bZ7klCUFPwo7v1Jo6bZzjjahhTRWms6nqvFubPPvhOwV
 4lIfhjdTGipnmtUw1iMfkQngKuH4LGREE9+OSdNU4anvZjU4YkOtD1xqJKo0MmDkaWK6
 WtXx2Q4T+BFJRntLorWLhE+e2O1KQR+yIJHF7H7a9GZulXvM4RBVD4ou+DRAJz4cvS0p
 b9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774864640; x=1775469440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U+q+5RHoG05AQakEjF3RsKZ6QTb82SYW8BIOn7cpF4Q=;
 b=C6/q4/RFHxXeSxTRQzxxo4814cC+FoLOje613d6PFqONmfsYA6Gf9SeEFwIkIzkZbV
 jHsS1Ar4FJ3df3fBAPswqfA335BgB8uUp48oSlLgjfJdizw+ZNWBg3KM2KC0lqAn2Qta
 Xz56BzlbFxGpHC2FvJnGiH59XJ2T0uY7Jrp54jZn9xA/5W/OgHyLbIf/230gi8P/P42y
 VYnl6Xu1CeiWEvJENX6BgAhwrEi0hXjeoVcECBEQznS+mlCmMcLaaE93R1HaV+Z8J3rB
 rLC4f+3eV0wUm3x3EEcuNyns9L/747Tri3Lnwpgi72Ou9BIOnhQVzgqt6JDHl0aHXWoM
 X7BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9NwsITOTLBv/SYKDAYu5s/tG1+xefP2Jv4PNYWZg34aYRSqGU3nCxINUk9va/V5P74RhWpcJAn04=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxq4V0Mb2WF08LZAhUoB++153GUNyMjPUQbvEdY/ktnxLvYV+xe
 ZT7BOKd6OM8ubW0plbF4WqGiFleW/+m4UgrBJh2X8yh8pxwYWCoj+BmCbFk+6We++BOve9LqJg0
 HO6QIz+nWXIlkNUnkNPmPEpQqJ/fpqaU0MgYcDVYvYbato2kIXMBGRDpTEsWEyqO3HDZpMRg=
X-Gm-Gg: ATEYQzzY/wkPUzpNe5+fItDHhMSAGAmDLQPKCaDZa2L8gU93E0CburBcOuOHhvARxoL
 5SeDP4q/qrimhq+BGiMrDD646l/yLbRl08m5OqIXo2mqLEM10/5ZXFFqzteTi4V+X9pAwt6V4k0
 kEpsQYFRBcCcJYr1rxfJRPKh2cuksK1A35S4ZPClQUsWTB9HDFCTrIi8MoZ2l6Dkr/rmU3H4DsT
 pjPll3+HA+f5vA3CSsv17O/lFGF93RzH5+BtEOhRFJgeZQBqb20Upb4YORRx3qqfbhP7jxsaWUN
 4ekLiIKhZ/eF5hBSBLg+XPpDD9D1qzDGziaKLaspi+QCzt9j9vLpjQff5a42FYU9lsBHzmfQVbX
 XvPEqsC6DsmsZ0UV05B+QbTq9Tu9g3VuX9BmGsvxK4FsG8rN7
X-Received: by 2002:a05:6a00:f8a:b0:81f:43fe:988c with SMTP id
 d2e1a72fcca58-82c959d4bb4mr10970705b3a.6.1774864640006; 
 Mon, 30 Mar 2026 02:57:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:f8a:b0:81f:43fe:988c with SMTP id
 d2e1a72fcca58-82c959d4bb4mr10970675b3a.6.1774864639520; 
 Mon, 30 Mar 2026 02:57:19 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca85fc756sm6320616b3a.47.2026.03.30.02.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 02:57:19 -0700 (PDT)
Message-ID: <c71ea478-ed93-4f10-aba2-023180c2ed42@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 17:57:13 +0800
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
 <ltlmp5ytl2f7no7aqq7sl54pwd4f53fuema23xnuwu5uthhbg3@7wamwvv22nle>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <ltlmp5ytl2f7no7aqq7sl54pwd4f53fuema23xnuwu5uthhbg3@7wamwvv22nle>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0gYl1W0n3UqlvNKqJjBC04LnWDBIqMDS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA3NiBTYWx0ZWRfXzRuuy78xlb4H
 ZHUEKY//8HvxNyvHY3yVkMFEjH+rXVVznevBVZqXECSEgLhQkrSBkDRNMAwiJwEXe8n+Yig4bFB
 EeMtlazpXs1aFaQdhOGYnlUapJfcp3VsdL0WcPI3o4ay050x2LuTh3tpaHW5oO1m0JRFGERYb9v
 dUjZH2PWiKUVCCLoFtrNQ3sUwo2vjbczXZqU1KzVxTQVnVA+13ibk7Q2U3yaW/7lAaSDBCXiluD
 3KmnVRvtdkytA86nnfyoO7lI2ubekV5UnQ5mbq/d6Ex/e15T2VxtwUWrdKGzqvNrqg4TzMtrQWG
 3TjLCkum+BpSN2qnRYkO0RzXIdtIWRiNOYuKSo5E01yPuMiKi9jHEDIy++MPQBZn5ov+ohXj2s5
 zMCkl6EpE5vjgmcyTCBrtOjAHfKhVQefvaVDF2T3Zd7PP3gog/E+J97x/dgNFaOexFPr2HVa9iv
 W9Ik0iYEwaZ9Dns2o4A==
X-Proofpoint-ORIG-GUID: 0gYl1W0n3UqlvNKqJjBC04LnWDBIqMDS
X-Authority-Analysis: v=2.4 cv=S9rUAYsP c=1 sm=1 tr=0 ts=69ca4900 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=_fflomLE3yKvlCkzeqkA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300076
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



On 8/26/2025 1:42 AM, Dmitry Baryshkov wrote:
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
> 
> How?
> 
Each DP controller have it own msm_dp_desc ...
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
> 
> Why do we need the separate boot field here? Isn't it enough to check the max_stream?
> 
If remove mst_supported, condition "mst_streams > 1" will appear in 
multiple places.
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
> 
> Just use 1 it's not that magic to define it.
> 
Will fix it.
>> +	dp->mst_supported = FALSE;
>> +
>> +	if (desc->mst_streams > DEFAULT_STREAM_COUNT) {
>> +		dp->max_stream = desc->mst_streams;
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

