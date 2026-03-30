Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A06FF4958
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 07:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC1D10E503;
	Mon, 30 Mar 2026 07:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XpMTcLAK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eheCyEef";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D604E10E4F3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:53:52 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U7XH2t3164030
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rpOSRoW2BeG5b+IvWAJcqnNsVMW6l5tpe0p8bVysWio=; b=XpMTcLAKjaXwY9Y+
 JnVklt40a6+Wl0+MVgX8XaR56OYUwtEshab0E9+Og37KB5i59zOZaxxStnLEzNX0
 BFHZdX1GcpG7F0xsXmxPvHsNItP9sbcR7euGJ2yRX2hYnH3qyq6aiG2yNuyScBfT
 mGk2UYucFnfBT3aOuOCmQsCdvaOn5zYA4JwGLC+lTuZv1PO1KTfDdBomEzauQkQ+
 4u9VYsWR6JPS4eiBnZYr4Zydk2///D6tPyoOFmb/O+zMv8JKQ4GUMF6fuwywJdmd
 PG1Zvp/q623QOCgVCgLZ04LTxXnn6otGbEDXvPZouBhMb8CuD3vP7cbzEibOM+2M
 KsjI1w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6ufmk55c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:53:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35d9e67f6dcso3935160a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774857231; x=1775462031;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rpOSRoW2BeG5b+IvWAJcqnNsVMW6l5tpe0p8bVysWio=;
 b=eheCyEef/0Q8aENArsT9SalWa5gKmN+c8RDizp+FWJK+G/KjNxrZoXnayL/uWdLmar
 xZXyBAvV943QEcJAD62pCmijE1JC+JFFcHe6Angv93PmMs5cC/HIZmm0f9t93rV4GKlj
 rfrzvA1qylJFvTI79EY6gHTIxzpG2AwbDDQNddzayY0uNQeoV5Uy9ABr5/W++/dP2Sh3
 tr2WlECp3QWFuRDs+Ta0v7z070K/YuzhhYQ/AEq+ptGxkaBWRqZBGYK0v1YhXB8YC5LB
 D8Fa63t7fOwec4WzwEB5vtM2Pys+0NoCaSjY/gebLYzGFtaUNrP4JNy3nr6G2Ffeus8b
 NPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774857231; x=1775462031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rpOSRoW2BeG5b+IvWAJcqnNsVMW6l5tpe0p8bVysWio=;
 b=fIEJhLj/svHp14lG0Yr5kQkjOzYk/kDg2REcNH3D7VlNwPFQHPqNTKzY/iNShuz0rH
 GnwVd9drQlyOmZHhu3/Yvb3HNHrzAbtXnt18NmPqI0wuDDQ+XPwypG72FvyEni3WWCfB
 D+FJRYuWDzzpgiV3sQbnO45yn7FTzsaswu1TuQB5D8Z6WnDJd9+zz/JJMEX/BD7eIexp
 yh+eZBUMBhPZ463NPNrDthfbvyiqhDJAyXEu7piYwZXjWHn8lSGMUQRqxgmnunNyvdqc
 FoqSbFUMYDquvk3hKvTIjlAqG75kQPBpepKLMOoev1BNMYmnGfEic9/a8L3HEMlQAlh+
 X3pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfvkH3F5o6XG8rWlAxk1+NVkfeUT8bKFb891umz9wD5Eor31EeyGP4F1JhKXQnuyQLcj9ih9TUrCU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnzZnkQjRUJUqHqi4qEWUQiMrT9RppxTxHqp7lGGg0Y0yvVNqJ
 potiJPrP+YGFe1kF0CWO6GtPVStD+90tL2w1WT8MYGDVF3b9v/JqMU5alRhmB8JeedKjlrjPqMD
 27IIc8GSEtJ4YAc+HJJueCzCyWPoXus/8J7kyJ4bU0NbZRaREnvumvzHBTY4Q3LpTqNoSDvg=
X-Gm-Gg: ATEYQzz0kgmJ3Lqmqtg9CE3Yq2j9txRWLxmwJGxUZ/Y4YjmPrK9HFdtecuPpvCUEBHp
 L8PR42Cw3607VlVdtoNBKe21zioxCbUCRhNfrNeO0jCGHMQ1HJM6QhZ17FdHnt66RQSSdHELpmB
 ZwOOuH7PJtWEUKAknqEB6R4UfurrpU0lQ/WM7YrHLOa6bFLcLCzxAJdtjKkWu9mwzoKYJiHOGY6
 EeO/MzF2QTL1V4NTOElrme7k/RylNyC2Z+cD2ClPWijl39i43rHUOdjVHYr0d/xnobRaJc3NpGi
 +Vllbj/PUqc/GTXE0TmkdJ/noYl7nqLL0LXgbCVcMGSM4ozm95dkfsrrwpYrIEgchTwoxlKCFiK
 UqsHjtgt1Qh1GTLxbMhnlcx4OB8b7hLcZfEe0Fk2TQt74CbTs
X-Received: by 2002:a17:90b:380d:b0:359:f3b1:6811 with SMTP id
 98e67ed59e1d1-35c2ff08081mr10329008a91.1.1774857231616; 
 Mon, 30 Mar 2026 00:53:51 -0700 (PDT)
X-Received: by 2002:a17:90b:380d:b0:359:f3b1:6811 with SMTP id
 98e67ed59e1d1-35c2ff08081mr10328989a91.1.1774857231193; 
 Mon, 30 Mar 2026 00:53:51 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22a54fd5sm15147371a91.2.2026.03.30.00.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 00:53:50 -0700 (PDT)
Message-ID: <9d65427c-f192-451e-9e67-c1a068aec2d9@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 15:53:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/38] drm/msm/dp: break up dp_display_enable into two
 parts
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
 <20250825-msm-dp-mst-v3-3-01faacfcdedd@oss.qualcomm.com>
 <xwvuajrm76flwhnciclz3bxzj6vmvladm4t73mr2pyrblczi6e@wbyq3x2yabrk>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <xwvuajrm76flwhnciclz3bxzj6vmvladm4t73mr2pyrblczi6e@wbyq3x2yabrk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2MCBTYWx0ZWRfX5Y99Ct3qh/bW
 Vv1lODtOdUWd5IekFUIH2+265O1v2XjL0D73aDB+lfR9WvlPFXxoqWJ3XmJOcIX2lv8iu+i2qp7
 b7mol55UsTrWnyO0wa1sYec0dxsR2TuMf+3yWa6EAluUyI5VcpIavu5Fb0P/ul0ytr0uYC51++G
 pEby3IOVbVXCgFsoGMzH/gBHqYgJoeb9TeSqFqFQkoOg5BGsXs4mK8Z6Zi70qW+FvVVxpCLJFC1
 0rgEv4UM3EAd+S1uxPDpcCI3thxfZ+XFRFbpAZ+acS4qMgvAeL8xjCtu3Xic5fMAfh4H4HvaA+V
 7qTIJHT4dGTQc+O76r0kSaBMPZAmPpafV811KfV/iJ2ncWLjc45h2TmSJBf88YtXhCMKNkjD2+/
 qtJ3UVsnqpABfAXPN1XUSCZPI1JVy2dE8hqvM+Pz92BeLIwlPDf10fDW/8THGUMwBmVn3Vv2lpB
 wyTqdRfz9Iex2I6+22A==
X-Authority-Analysis: v=2.4 cv=aOT9aL9m c=1 sm=1 tr=0 ts=69ca2c10 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=1ibuz8dZZ3-44BQBXskA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: F4jCO7nIdWc0Xlj1NA_mh2tcr1K0dx-W
X-Proofpoint-GUID: F4jCO7nIdWc0Xlj1NA_mh2tcr1K0dx-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300060
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



On 8/26/2025 1:13 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:15:49PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> dp_display_enable() currently re-trains the link if needed and then
>> enables the pixel clock, programs the controller to start sending the
>> pixel stream. Split these two parts into prepare/enable APIs, to support
>> MST bridges_enable insert the MST payloads funcs between enable
>> stream_clks and program register.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    |  51 ++++++++++------
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |   3 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c | 113 ++++++++++++++++++++++++------------
>>   drivers/gpu/drm/msm/dp/dp_display.h |   1 +
>>   4 files changed, 113 insertions(+), 55 deletions(-)
>>
>>   void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index 60094061c1029bc7a06ffaa80d9403b40aa07eb1..2fbf16f27842bb7639efaa2baecac7bdf8908432 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -20,6 +20,7 @@ struct msm_dp {
>>   	bool link_ready;
>>   	bool audio_enabled;
>>   	bool power_on;
>> +	bool prepared;
> 
> Why do you need this? The msm_dp_display_prepare() function can only be
> called from within the atomic_enable() callback, which is not supposed
> to fail and which is always called in pairs with the atomic_disable()
> callback.
> 
Sure . Will move to the appropriate patch.
>>   	unsigned int connector_type;
>>   	bool is_edp;
>>   	bool internal_hpd;
>>
>> -- 
>> 2.34.1
>>
> 

