Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22F610D14A2
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2038810E59D;
	Mon, 30 Mar 2026 11:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l589NskL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SMDM6/4f";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A925B10E59D
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:36:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UBZi2x4013755
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fo0OT+HyA+6L1ky9fqEb2u6sfpQ65BpxR4Jv/TYfgSE=; b=l589NskLS03uixVI
 gFC8zcAqnYZn4y2qEsrABivhkH9p/5cZdWQfBfETVhCcper3Ayt7fUScuPvScYPG
 oEw+0vyLZdnsZ5wHFCCmXYYbQUO6kIUMFIvRq4rl4TR/+06+sRP3lXbMWp66WPuS
 irxDFHpkpxKjAtTNivHLyExg92oz1FlO2UltRHQzC8dRt6QeKAkYzPpJL9WjH15E
 HtWfSfwqyTHYF7HSdKt2vdv7pV9mf6HHSkoaXsS6Fk4j8GO+W003pfzQR29oPleC
 kXdXpNjTy6MgEM7SmaK+FkD5hNoYm+FoEbgcPnYZdX97JqGlT7ePny7Xq6Sl5qYq
 SJecdg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7regr037-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:36:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c4cfe08c9dso9745583eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 04:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774870595; x=1775475395;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fo0OT+HyA+6L1ky9fqEb2u6sfpQ65BpxR4Jv/TYfgSE=;
 b=SMDM6/4fJ8hTTkHYuaPDng5P8mxjpNMQ4GjoGqrHKDdVl5xw8/9YqZUQCNadL8kdeO
 fzVjuuDSyJ8PFRE9grKLAy2SEr78aWkh2jK8YPoSoxbBOgpLSQ53sOHl5IwVTYIuE3Zy
 DSBDabQHLhQKozM8z+/0L4IoMnHRAxREEPZuy/MSGJFmD8qvpR3Po9oanGWKezsRO9LN
 mFN5Nkjw23JEvU9DSIXXUf3fyfpnw0Qcm14v5n1LFAevnRBkpptg7rfYR9zONOVV90Nl
 77fqnR3g/SJnWGgLkPbhqZeUhcRUX83iZOjeZYggnNKhSWEETxfMLEXU+Xu+s94cQs4b
 Sqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774870595; x=1775475395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fo0OT+HyA+6L1ky9fqEb2u6sfpQ65BpxR4Jv/TYfgSE=;
 b=eoZ4FKU8TqqzuliiZMZxw3KR5daAMVa82m8So9Ka9hq/12u0LGj6gr3W2lA0b26Mrg
 eKnuaHtN8RmZfS/UgPzzCNK6j0NohRlEzNmNYCP91U+U/Eva5egUuewD3ed22jwyqxd/
 MwJKUwClPPid/ObOH0rYr1C+viZJdLFiJiytYvbRMQlPt1pfLD6P8Cf3C56qGKu1XetM
 oTJ4hnpNO3VFyCf0MwCeIsmXWDLKmkhNtEBJuY+T3xUh+WQbAHAGAKd6q/8p4IluN5bi
 w6wPR9KXv+KlhxQKyG9+70ceSCYBGEbF4WW4y4XwfxuAywWa6J8uSHFoYv8NbXk2Px3/
 Mk1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH0Bv5nZdtg2R2VKBWK0ezXXwLSY0Ke/FJ8Lni+674okl0i2vbXYAFhzPrfIlj8qlIQeFkQhjLltk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZs1mD4c4FnPpdeODGMCP5WtJz8z+cUHHzQaQMPQVz78TG/wAW
 O90yTGu/2WRz3WYAIFs1nQo/RXwqCpV7KhA+kV+5EMG9ak9Oc6ZkDY+8ZtZmUbvGdi5+hcQre0Z
 IR7UqWBxgUrp5bX0EH3I/RMD/9hqkEKcfzH/cAIhQEMKNtmMRT6cHMod6BcueCbiy6od8Noo=
X-Gm-Gg: ATEYQzw8TNJfQPEBxK2CtweS3ud3aRaF2DEiU9i6pq5g+yVU2urbEX1qvZCH+FUQbEI
 J87pKeFAsjpYQq8TZquXqQttGKgFO95OY4ksttweznloqCTjaJ0z44mApnjQtqrtQkUyPy5czvI
 jirGT4px4qk3kSzveqEtKKpGtEriA0jPMgge8D+j0L8q5+MeEACZFAeFzGw1PVgiMoIV4dwbzUO
 zQmeHLka0SL1WGdhxaSQ5rFuHQ2w+q5MLvLs4b/OrRXl98t48Rt353XZO00wBMe4xcZ8gDfiyx1
 aFNk/FVLCco/K+0DwzbNx4X6pvPgTI3OUrZZUpx3oY/rtlYVDYdRC0dtZ7ezvN1JrNM752g77R1
 yO3/IzU3mcsyRAliEtG2WIBJzXm852DfHtOIDiembpFkhrJgUE+DpPF90R/MZA2XTfoAXgupB9J
 qdjZY=
X-Received: by 2002:a05:7301:d0b:b0:2b8:64ad:ad4d with SMTP id
 5a478bee46e88-2c185e2fa35mr6011209eec.26.1774870595426; 
 Mon, 30 Mar 2026 04:36:35 -0700 (PDT)
X-Received: by 2002:a05:7301:d0b:b0:2b8:64ad:ad4d with SMTP id
 5a478bee46e88-2c185e2fa35mr6011183eec.26.1774870594891; 
 Mon, 30 Mar 2026 04:36:34 -0700 (PDT)
Received: from [10.110.38.145] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c7971d97sm7213453eec.30.2026.03.30.04.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 04:36:32 -0700 (PDT)
Message-ID: <c0e8500d-84f3-4d0f-a1d6-8eef20ef2bfc@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 19:36:27 +0800
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
 <7e6a7bdd-a94c-418e-92e6-524a58cdca46@oss.qualcomm.com>
 <iscoaaduakkhs4rpbut6alybigt23vxzezl6o5iemrelkrksad@6fmew7afqogi>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <iscoaaduakkhs4rpbut6alybigt23vxzezl6o5iemrelkrksad@6fmew7afqogi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G6wR0tk5 c=1 sm=1 tr=0 ts=69ca6044 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=-cZVJRYi88NJjIhXCX0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA5MSBTYWx0ZWRfX+U27TO8LYFl6
 YJlf4C6JGNaOWNuGhHb1/lzlUkz/aPVHEg7qtn9UCBnHdXUyyckJ4Y/hh4qzJ+ItRE2b8Vx4Inx
 ZXHfEpgHhXwii4tAISXGtDF3qrvpX5PwuICviLt0xO5YOwrc9RBcemObAi5TjB5TYY3a1IesCHJ
 acSfU1YJ5uhIlTjAlIuuygAvs+ndJjJIF7WIS+U4Dj3cufxH26r8sAgBMAHcWtReOR9krGAMbuk
 h9Z6yL85C6WNyLIdv1w8Oz9X1Gcnou8lLMOKuehAVfkODlqLrkJZqE3PzRQxVn0LYzh58+mv2Bw
 BqUBGBsotQtav15pJAyVjyfuDktJKczEyP8SMhDomJNhUQyDr2Z7fIxxo2RNZcf3UFberqHLo8r
 iiNIg0UxHX2depl4tWXGsD9/CC99a9JfGa6z1Vbdet1sRyGVT65TAvYRuGWiyc41HhoTTFxBm/L
 0KJslglmkwWFwmFem8A==
X-Proofpoint-ORIG-GUID: XDRIJzeOknpjICWvNOAf4UjT29T8HKbV
X-Proofpoint-GUID: XDRIJzeOknpjICWvNOAf4UjT29T8HKbV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300091
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



On 3/30/2026 6:36 PM, Dmitry Baryshkov wrote:
> On Mon, Mar 30, 2026 at 05:59:28PM +0800, Yongxing Mou wrote:
>>
>>
>> On 9/2/2025 5:41 PM, Dmitry Baryshkov wrote:
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
>>>>    	struct drm_device *drm_dev;
>>>> @@ -84,12 +86,15 @@ struct msm_dp_display_private {
>>>>    	void __iomem *p0_base;
>>>>    	size_t p0_len;
>>>> +
>>>> +	int max_stream;
>>>>    };
>>>>    struct msm_dp_desc {
>>>>    	phys_addr_t io_start;
>>>>    	unsigned int id;
>>>>    	bool wide_bus_supported;
>>>> +	int mst_streams;
>>>>    };
>>>>    static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
>>>> @@ -1213,6 +1218,15 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>>>>    	return 0;
>>>>    }
>>>> +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display)
>>>> +{
>>>> +	struct msm_dp_display_private *dp;
>>>> +
>>>> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>>> +
>>>> +	return dp->max_stream;
>>>> +}
>>>> +
>>>>    static int msm_dp_display_probe(struct platform_device *pdev)
>>>>    {
>>>>    	int rc = 0;
>>>> @@ -1239,6 +1253,13 @@ static int msm_dp_display_probe(struct platform_device *pdev)
>>>>    	dp->msm_dp_display.is_edp =
>>>>    		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
>>>>    	dp->hpd_isr_status = 0;
>>>> +	dp->max_stream = DEFAULT_STREAM_COUNT;
>>>> +	dp->mst_supported = FALSE;
>>>> +
>>>> +	if (desc->mst_streams > DEFAULT_STREAM_COUNT) {
>>>> +		dp->max_stream = desc->mst_streams;
>>>
>>> We should keep compatibility with earlier DT files which didn't define
>>> enough stream clocks for DP MST case. Please check how many stream
>>> clocks are actually present in the DT and set max_stream accordingly.
>>>
>> Now these DTs should already have the MST clocks added.
> 
> I wrote a different phrase: we need to keep compatibility with _earlier_
> DTs. It's called an ABI.
> 
Ohh, i think now got it, will fix it.
>>>> +		dp->mst_supported = TRUE;
>>>> +	}
>>>>    	rc = msm_dp_display_get_io(dp);
>>>>    	if (rc)
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>>>> index 37c6e87db90ce951274cdae61f26d76dc9ef3840..7727cf325a89b4892d2370a5616c4fa76fc88485 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>>>> @@ -29,6 +29,7 @@ struct msm_dp {
>>>>    	bool psr_supported;
>>>>    };
>>>> +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
>>>>    int msm_dp_display_get_modes(struct msm_dp *msm_dp_display);
>>>>    bool msm_dp_display_check_video_test(struct msm_dp *msm_dp_display);
>>>>    int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>
> 

