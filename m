Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDF1D3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C6610EC72;
	Wed,  1 Apr 2026 06:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OGSgGsSa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xlqa2cjt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF49B10E3A9
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 06:49:26 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6314GajS1579367
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 06:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kaSZtLO1O6dHgdsj6HMqLMbEQ2wzIJZCOsaKSTu39v4=; b=OGSgGsSa9xKJAaOw
 eiGzLuUwYlHDPFurD2a5lT9AO5s54lv48gc+p0ws41/EQ868kUA1Y/I7RLjRvmlu
 WETWfxzzVmLo6w0u9zpUH1sfyJJN0g4iNSVcEdraJTZR9Xk4cdegViB9r+LcMmac
 FHj4Bc+WPKm0cjT/CjTeXYEXHwDV9/BwR3hXa5uz2x7DgSsotWrQhS5IPZhY9r6J
 yhraGtVek0HnC/Upb8cL0cfrzAfmeaPZXtgXZ04TACCgo0jZlUYKzLrfSD4oVLBP
 EyEK1DC0Y36YHrn/h6pRVCi3Ih7GmEVItr8j/j3p+vke8PkGfqkmOVkv4wjS/6QF
 FNSMgA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2t6m5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 06:49:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b2cbe7223so212435371cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 23:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775026165; x=1775630965;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kaSZtLO1O6dHgdsj6HMqLMbEQ2wzIJZCOsaKSTu39v4=;
 b=Xlqa2cjtUbAgdj40UXRl75CyfXhNwGF+we7xjasqu3bt3gVVSKxwmXxNbV/8RAl2qq
 3+c8HcBLXDR8s8Wsyi3OL7wS7aDYFnR08s7Vvv7sINw+S6orBLViHXZZDlm+p6MvkuRP
 FbuoBxQ0HR0RdMT/jm1Rnq+TCOR76E8+h0qQQxy6Rec6r/I5IgE+FplM+nMqYl2raHkl
 ldWXDEOQiHG/a45iYliQwNebwyTGh1OxybomjVXGgjqkgYuflgd+JPBK11GVJq++5hjs
 D/aJ08IfgEJuq+glv2I/R/0WH+QqVFLegW2OuEMg/YbuEo0A3pULhNcp/Jyx1tjRcMWE
 JzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775026165; x=1775630965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kaSZtLO1O6dHgdsj6HMqLMbEQ2wzIJZCOsaKSTu39v4=;
 b=DQxylrvwkvgG3ku1qJWM5DKoFH5OP6giX2/Bf+u77w6g0dWtnKG4HZOgh3zQps2hxX
 3HROddmnEdRsoYjqbBRqSOGxyLVm5m2vGJ8bi48PFSRC6r12WJhP/jlh88R0tPDZ+1E5
 5jfDukJuK23c/IeIa+PVgDZXEFUQS/31OKYjKEz/8Lnnd+9l0MRj4NKM526aCQdnmF6G
 nwTQSRVFxFrphSTx6T5AOQBhvO+swYpqh+eORRYn44J6T6LwBBS4fJ9OPhZQafqmhN5C
 vPShcGTPYigt1u5lGU8V3eQr3gDrRa4FvBridelPpt4sFjHkXinV8lo/3B3bOBDGlbK8
 S0tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlinF3LcaqF/MPUYI7zJCYtMHGE/J/VwF9SwYQy5fG/9XSizCtS6Bf9996NBAYocClaB3z6+9M48Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxiVPlQz4Now2h1J1EhvvSahUKhI9utk00Zmq5wu5gcrFzwVzj4
 Z+9KSKPVmQQVGhjv7tdALIZBKM24s8HzKixTwIeNNHab/htF9X3e7/HlW6yqScNp/kXW1hKBWus
 fQ85ixQ0zZ5X/TUzt/vc3loYhDmK7HLI/QkJaZqUiVJdU336K1cfK0FWcn0kKF3OMA8hsTFg=
X-Gm-Gg: ATEYQzwdGpbOXFDsNr3Iy/fhUiqqatZJZRp8h+u/eLJuHdCgyVPAKZpQkCdbH9HXePy
 S6T9usN/VEgg5PrXrm4ie3bvmHQHnSw+kCfjPrWbLKCPQHnaGNW3uZHooMfTd8JAaiSHDJfLAyu
 xXkK3x5M4nLnIF0okcrI5RrFgwglSJbYBB5LihfDNjzcyMqtWyWqPJg1Tx/da/AznR3IyW5rugs
 OHX2tRwArBwjSVi/MFMJU/7naEvB9gpXqAxV/CSCqFO9aZhuA7sEOoLjtxt1w/vwc2hVANxNsB4
 WQx+QBDn7gnbxWVCEda+avQLnTTJyHTrv1Ekqbr/DWJiVYAMAZpDshqUuBRIV629Y2stkPHjn01
 CP8eZa9WeK4M01evip29lKfcelmJrqJFrS6VlNkPW0EK5mKIE64VU+CozsFGlAQUmDOi+QyQlnq
 6Q0qvfROxKqZtaVyrV0J9CXrvk
X-Received: by 2002:a05:622a:488a:b0:50b:50f5:b8e0 with SMTP id
 d75a77b69052e-50d3bc3dfffmr36132011cf.28.1775026165029; 
 Tue, 31 Mar 2026 23:49:25 -0700 (PDT)
X-Received: by 2002:a05:622a:488a:b0:50b:50f5:b8e0 with SMTP id
 d75a77b69052e-50d3bc3dfffmr36131801cf.28.1775026164639; 
 Tue, 31 Mar 2026 23:49:24 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a073:af00::4c9?
 (2001-14ba-a073-af00--4c9.rev.dnainternet.fi. [2001:14ba:a073:af00::4c9])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b1403cb6sm3076261e87.27.2026.03.31.23.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 23:49:23 -0700 (PDT)
Message-ID: <b154111d-46b7-4bc8-abea-d133e929c6b4@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 09:49:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/38] drm/msm/dp: Add support to enable MST in
 mainlink control
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
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
 <20250825-msm-dp-mst-v3-18-01faacfcdedd@oss.qualcomm.com>
 <ahgabnh7e2zszqjakexr4755orihk6afvqlyw3lvcffyvr5muw@hmy6kf3ociku>
 <49dae108-ad9d-4931-a10e-810de5766790@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <49dae108-ad9d-4931-a10e-810de5766790@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69ccbff5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=lP0j4_6gZTFRyBZCz58A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: vvzVzayEMs93VqArAfdT9raWg86yerAk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA1OCBTYWx0ZWRfXw56TnfoHWRZd
 4Vg2FxzTPeTebnCgrqFAAA3m/tQ6dJSWSZkNjwsaUaVYFtKpxnbTGpcDgA6XZussJ/44TpB3+Fa
 B6WzRWBIn8syRofc//EENegP3LirpCRjGaKpP68tw9u/0eFDB69ZtKIIvw9wpdOvWYIUfVOSm8j
 QzZAH3GHj0dwu1y9MWbStHg22h7DZy7igZr4v9RSjWsGqkQU3U7eoAYz9cEsnqoALoqdqJR/8Hb
 8NdT1SCujTEicMrK6/VngZEy5r7E0ophY2SqM88ljf3ph8M7pGpagzhCUSS0VtmRVtf1c4lTwy0
 nZVLQyPPJ8aBktrt3c9Rm9mtccIk8kvwIlnW8/vgu7u/K3w+wqHllVhtM8IXsrjxYUrZATRqhz7
 0MedXaKYs5KMOZi7Uy5BWHzwhKKHEd43KUt3oa3M/nuZRmqqLeLCJALOfqk16iyGxOekzTsMLEe
 qMnaV6OVDH4v/kvUCLQ==
X-Proofpoint-GUID: vvzVzayEMs93VqArAfdT9raWg86yerAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010058
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

On 01/04/2026 09:46, Yongxing Mou wrote:
> 
> 
> On 8/26/2025 5:24 AM, Dmitry Baryshkov wrote:
>> On Mon, Aug 25, 2025 at 10:16:04PM +0800, Yongxing Mou wrote:
>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>
>>> Add support to program the MST enable bit in the mainlink control
>>> register when an MST session is active or being disabled.
>>>
>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>> ---
>>>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 17 +++++++++++++++++
>>>   drivers/gpu/drm/msm/dp/dp_reg.h  |  1 +
>>>   2 files changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/ 
>>> dp/dp_reg.h
>>> index 
>>> de3d0b8b52c269fd7575edf3f4096a4284ad0b8d..fda847b33f8d0d6ec4d2589586b5a3d6c9b1ccf3 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
>>> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
>>> @@ -128,6 +128,7 @@
>>>   #define DP_MAINLINK_FLUSH_MODE_UPDATE_SDP    
>>> FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 1)
>>>   #define DP_MAINLINK_FLUSH_MODE_SDE_PERIPH_UPDATE    
>>> FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 3)
>>>   #define DP_MAINLINK_FB_BOUNDARY_SEL        (0x02000000)
>>> +#define DP_MAINLINK_CTRL_MST_EN            (0x04000100)
>>
>> Why are there two bits?
>>
> Bit 8 enables MST, and bit 26 was set to select the required ECF 
> endianness.
> 
> 27:26    ECF_MODE        MST ECF Endianness
> 
>                                    0x0: [63:56], [55:48], ... [7:0]
> 
>                                    0x1: [7:0], [15:8], ... [63:56]
> 
>                                    0x2: [56:63], [48:55], ... [0:7]
> 
>                                    0x3: [0:7], [8:15], ... [56:63]
> 
> 8    MST_EN        Multi Stream Enable

You can guess, #define them separately (and the ECF should be the GENMASK).

>>>   #define REG_DP_STATE_CTRL            (0x00000004)
>>>   #define DP_STATE_CTRL_LINK_TRAINING_PATTERN1    (0x00000001)
>>>
>>> -- 
>>> 2.34.1
>>>
>>
> 


-- 
With best wishes
Dmitry
