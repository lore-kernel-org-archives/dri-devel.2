Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C817D10D14A3
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB2910E482;
	Mon, 30 Mar 2026 11:32:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jZMVkpCn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NDmr0ZNX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA54810E25A
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:32:48 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UBELUS1402826
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IVYNpilIftjXfqm8NGF87/3nEPjp9heJOVRVsPx0j7c=; b=jZMVkpCnWWiyCRha
 xbRzvFuv/ilFPlRd5QcmwcTlfe0DNibv+Ve9fcZ1YDf87NdyxrnDdKrHwzprFWzd
 Y5yoYx09b+4CksJJhbvVjCBwPN9UajoNbMC96ZhUiH/dkW+bGTFyzg11ZMC9Gd6D
 weHgdkiuefv4zhSStplBt8KlfsWHDVPrLrC4Da/5CdVrltXBnutgbqBsGKdT8uSn
 E3Q6KiznC7M5735wB2+xsGhlTZzzRQxzC33D6Q5m7cCeFeeJibNygkh8WgZ4C/fd
 7ycLPueLAB5dZ3HofL36JBWClx1hpx5O8ibH+yQaV7gvEjUxofzh+o+AULx5wo67
 UzZl4Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7r4h8238-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:32:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so3479163eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 04:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774870367; x=1775475167;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IVYNpilIftjXfqm8NGF87/3nEPjp9heJOVRVsPx0j7c=;
 b=NDmr0ZNXr+9UxvdUtOREP7WKjDMvsUgvIJc8K5aoG4WbnD/yB3kjTpp2BfD4psKQ0q
 S0ANU82BtTLKYPh8qIo80frOKBHdbGrX2Q8zKQg57XuMPJzcVmnh6SmWUslVrja0mDfw
 jV/knfcLaw3fgAmZDiUMGAEJiiXOMc9mfajXgOc/h0Y7BpqxsxMdPDaXUw8R2sunEyDd
 6ZrQDBl8mNE30UCce7BEB98KwieC716Rv3XnDfwbYgBo+ADmUFdRjnuECQIoUDxy5ock
 +vNEi7EO3fqw7l+bQ+9Kp5OnUDn1c9mifnlYcro7o+OnzyG8fAiT1A6MnOnLltmMLT+v
 SYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774870367; x=1775475167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IVYNpilIftjXfqm8NGF87/3nEPjp9heJOVRVsPx0j7c=;
 b=MJQyzp6m3i++isPEu3Dm6UerHeAlJZNsevso7jcs8Ib2ygdHuOfkqcXeoyo/aLG1OR
 DQOq5zCErpE8xzLe3rgyWziaPeF2mP0eLAb1U7z4jIIxzhZ6cbnh2ZcWG2MaozI99+2o
 KeCjq23GddeesFxr9oaBZyxp49jzmzGZPvhLGQ0N1jbj4XWhQEBjZUx9PtwHD6uo7DyO
 rPY6tU1YWDrAIt2k55Wzt29ir8DofSC/EAAqifhO7WaQXELy+JPycX/CtjrTI3fahHk5
 zhO4ktem+jJwSdikvvrtPTbHhAwlpgZ3057CcOVVlEQjXPKJa4VZgt/2aODM381BGTHo
 WH9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/3WVnAoHYh952Chy9I+/HuoiSSD6FMMJOh0nn7FMuF2sJpq/V/u8qe0yhUloXYLsGUAe0xYlCBW0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSqs2cJLwocczVOebQhuDLGEDNswXHO1Uki0IyPxpE3C3hpHNG
 iuCsU+xgVsG0NIe3BQjzxGvM+9Edam/IQARJYOsDV1Os0fXgPKvj8oTo5vS8eX7RBpnzJ8ugKiN
 s8pAmxo+IITE/C3V90CGGUwbAyXWL1NSkEDpGzFC8lQfeX9q7wtjcG9e7Ru8DgFX0QGxvc9o=
X-Gm-Gg: ATEYQzzh3GozkFMTACe5j+IFTvVR37ndfNK0vESqNOBUvdxWqIIADvTZ3YiPd6gneHN
 jxOPjkVBCOqAXATTbVxQY3AbqdOvhSNIXtQdof9dtVAnjZTzUzkn4I+BjKBvRSsuq43BCwrCQdB
 ubdYDAz7ZdpF+9hBAIAPV5WMEoLpnf0EiWHNiVznsNixea4dzIRswdySCckSUU+R+g08oEbyDQy
 msv1sISQDLfQSQZXd01aUNGl4vFi//dxqGifJidCwOfAal8+HL2s32pYdT0Rk6guBCDOPEmoNMT
 udhdF9UBJrO+Yjw/PekziDdta9Flarebc6JtZW9R07FnSnfk9L/NctisHjCVWA2rmJqdMpwmP9n
 RsfaBYmJOVVdVq7Xd611QgFd8w63ZmwDHvjREwtB7rZuE8vcUKCcqVQvgpUmi6G3mP1x0a6mrL0
 oz0r8=
X-Received: by 2002:a05:7301:100c:b0:2c1:558c:16f7 with SMTP id
 5a478bee46e88-2c185c9c5a8mr6082250eec.6.1774870366906; 
 Mon, 30 Mar 2026 04:32:46 -0700 (PDT)
X-Received: by 2002:a05:7301:100c:b0:2c1:558c:16f7 with SMTP id
 5a478bee46e88-2c185c9c5a8mr6082214eec.6.1774870366204; 
 Mon, 30 Mar 2026 04:32:46 -0700 (PDT)
Received: from [10.110.38.145] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c4aac86esm6776668eec.12.2026.03.30.04.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 04:32:43 -0700 (PDT)
Message-ID: <99d6795e-1cea-4e7f-b8b6-97f55af55d8d@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 19:32:38 +0800
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
 <c71ea478-ed93-4f10-aba2-023180c2ed42@oss.qualcomm.com>
 <ex5zvncmnt5pmb5j2utolgbw3yewj4x4e6nu7sdrgzm7ubasmi@2jdubbxuckwd>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <ex5zvncmnt5pmb5j2utolgbw3yewj4x4e6nu7sdrgzm7ubasmi@2jdubbxuckwd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA5MCBTYWx0ZWRfXyLBoO/LrYuYD
 BxFtuStAuENJL9EKFt+yrV7HEdrzsiJ1Y3R6xTRTStN90x3AjIyhES0sTiFaIaTf9zjR3bYtdkd
 ylGfIiKSbKFb8XCrzAsQLPJNIvGrEYV5dSVEwsZwKCUCNFFfAnwMna8eaFcT0wO/GBnGG/GCgaN
 PUJLGaQ2W8r94EPFAZLTq31V0y2Agh77mZ3AWBt1b9Pi4UbEDIvQWG+lZMcqFZrPqKt9ZD2je5r
 vAe+L9QLj7rM/tOwSWGnvik1+DPsaaboPP2+64bmRGhj8+uFinCOrSxm05nzXIwD8btZcnwpbHL
 snEdvZMVNKPuW0vtogvI1OTPa1+EbYdO3SlfpinNvcWjneNZ3yHOesa7ZR0c+Fisd1jLgDFVyXe
 BTolF+wc6rPPWQX7JSwuwaS5Zzh5ousaW8BKsySTwNf53nCucCyQaG6l9YOJ7FBFpsJtvLI22Cj
 Icrn7OAEbBMS3dF6Xmw==
X-Proofpoint-ORIG-GUID: MceyjoumL1vXrQaWEZlr4pyxk0VJGhQR
X-Authority-Analysis: v=2.4 cv=PI0COPqC c=1 sm=1 tr=0 ts=69ca5f5f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=zP8nz7a8HkQHIvqbjmkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: MceyjoumL1vXrQaWEZlr4pyxk0VJGhQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300090
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



On 3/30/2026 6:35 PM, Dmitry Baryshkov wrote:
> On Mon, Mar 30, 2026 at 05:57:13PM +0800, Yongxing Mou wrote:
>>
>>
>> On 8/26/2025 1:42 AM, Dmitry Baryshkov wrote:
>>> On Mon, Aug 25, 2025 at 10:15:58PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> Introduce the `mst_streams` field in each DP controller descriptor to
>>>> specify the number of supported MST streams. Most platforms support 2 or
>>>> 4 MST streams, while platforms without MST support default to a single
>>>> stream (`DEFAULT_STREAM_COUNT = 1`).
>>>>
>>>> This change also accounts for platforms with asymmetric stream support,
>>>> e.g., DP0 supporting 4 streams and DP1 supporting 2.
>>>
>>> How?
>>>
>> Each DP controller have it own msm_dp_desc ...
> 
> Why do you need to mention it?
> 
Sorry, I may have misunderstood your “How?”. Could you please clarify 
what aspect you are referring to (commit message wording vs. the actual 
implementation)?
>>>>
>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_display.c | 21 +++++++++++++++++++++
>>>>    drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>>>    2 files changed, 22 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> index 78d932bceb581ee54116926506b1025bd159108f..a8477a0a180137f15cbb1401c3964636aa32626c 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> @@ -33,6 +33,7 @@ module_param(psr_enabled, bool, 0);
>>>>    MODULE_PARM_DESC(psr_enabled, "enable PSR for eDP and DP displays");
>>>>    #define HPD_STRING_SIZE 30
>>>> +#define DEFAULT_STREAM_COUNT 1
>>>>    enum {
>>>>    	ISR_DISCONNECTED,
>>>> @@ -52,6 +53,7 @@ struct msm_dp_display_private {
>>>>    	bool core_initialized;
>>>>    	bool phy_initialized;
>>>>    	bool audio_supported;
>>>> +	bool mst_supported;
>>>
>>> Why do we need the separate boot field here? Isn't it enough to check the max_stream?
>>>
>> If remove mst_supported, condition "mst_streams > 1" will appear in multiple
>> places.
> 
> And so what? If you want, extract the function, but don't add
> duplicating data.
> 
Got it. will remove this "mst_supported".
>>>>    	struct drm_device *drm_dev;
> 

