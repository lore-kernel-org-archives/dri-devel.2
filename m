Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF94CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 12:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D738F10E224;
	Mon, 25 May 2026 12:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i6wmD8ll";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V0Q+ROUk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93E0E10E224
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:13:42 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PBtX4X723934
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hGnlQ2jKtc9D3PI7eVoLHHW6xQCIYR/zEjXHMT+2Fvk=; b=i6wmD8ll0FDQBKuL
 YMZX0hnZSTu1zAG6ARTSmTYSR6/4EcpW2tY5pnqWxqdJNcWxhPeyxpyrxmVCGlaz
 8S2M3nvnyql4ijWnLuJjU+T4FElTwQ23Z62i8Ar3DXY9Ze9HdgV3uAv7vE3D9Rc+
 D7PDlENjf3avi8oCHJmH3c6TcEQ3I7sz9IQCtH51ydkj785B4EPVmuXB27kad5sh
 eH4TQqBwEfL+1z/rVdCUx6TM4/4kO/5Yrhi5C7r5L1x3Zgnmcfk7yQPQ3VntAN7O
 JhQRzoQ17WBKCqPTYSJUeXzFYw7VydfJtGzPELiQaqM/vEX2TEBh1Tx3hRHaHyLs
 MCrL+g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w619g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:13:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b99eb06178so218146265ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 05:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779711221; x=1780316021;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hGnlQ2jKtc9D3PI7eVoLHHW6xQCIYR/zEjXHMT+2Fvk=;
 b=V0Q+ROUkzHIsBXZoy2OwkKxbkOxNR+dOzqsuR99dcurTiMKY0C8wXkS0Nc9YMMG4u1
 +L4ROSxPAfQwidcB3Q7FEg5MQY9bspd6UD6Xx9zxVn0+Ykq1qmlrt3PSbnXoj8RViedA
 T5oNQOZpxx0ri4+1Mp0WhdCmoxFG46UiLt6AjImFO+/Zn35rf2GcAC5KhB8fovw8CyNZ
 w2Nt8lueEUfhEWIcdlo2plaIhvCTaJQZZSMScYqqJxR/aKjN3UJahLiuAfIQX70KG8qp
 AXM3nW6ZRd3qiUI6GD0Dq6MRg8FFCGnGwsJ1+6nih0S+Xw4hu2elaoNEDrEKt7uQ2uG3
 75Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779711221; x=1780316021;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hGnlQ2jKtc9D3PI7eVoLHHW6xQCIYR/zEjXHMT+2Fvk=;
 b=hmlceb917VCnsfuHQycA0Shj53UG3xClEmlfFK9fW/NP2Im0HZuU72pUjDhrL0I3vP
 aRU/LNAxH4UZ0lUqLrvCK8yybp2P9fZ4ysnFsh6C9euAUdM2E7a7BuscQBMMDrrTv4+S
 GECaf5wganAQ8Y36kqRDg4L4MuJqftyPaOwAbJp/BxW1apMAi0LzQxHlIVvesrDfK8xn
 rAWEDcBds+0uERgImD6vlEaftcUMTnLhlbKZ+763rjrLswxNrRUMGNQmgSZrkCJF9QoF
 47Xq5eJ6huPMbI+olZ8EIv634aWQzz0YWKUS6qNL6FrGPP5WuPiK1jrV5P5FK+Sob1NK
 yQ7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8chX1tIGyi+pgEa7ykNwaemb7vI7uh/lUtfxkqdBOh2SL4i1pZfd3+s0EB89vHS1xixpQTkj6PVus=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoVbF62GnOL+LM7MfI97mMcr/ZX1spN7YmG4TU5ZS9klRJBoS0
 IGBj87vL5PHJ7r5zu2XMNCmgDvEwXRZJahhfEm6GBUx9aiVHdvAX+bfyjXx9MBG0RZ833HlQp3Z
 LLmEWhKOF8AJVFaG7qkNlIKzSD2682IMQF0R+ySyOh2i7enQ1YoQSSwNieLW5oLAwTbWoTYg=
X-Gm-Gg: Acq92OE7d/joOFvxZ4z0+bE9dQ885bY6cY9a9OYQmZVS/WtmKVq+tdlRppzQB8cCoke
 /Vptnuzi9GF+2e7WuGUKad+8OY4Zw3CmL861seqVnxYwZNYvOqTrja57Giqzp2r5TJeexKutO+K
 PWkdov4E6SaxPp/PB5mfFZe3rMNfyM2fffULslBGz23H77jrNQvqS0DopcErzG0Xfnei5rmPvW9
 0maN+x9OquJeMi/wZsDWWb6LTb7ZnI/i2GZneBFjYvwc6gXBAe5ZoN2H9kJvvhtloGRVP0mKJEC
 hFRDcunwRAqYOJCCEWvwvhOMM4HW2mX5kpyuDGB7FzzC3umR3JXFwV+zg/zqk/PsK3M+vaqYa+P
 BrdJ+NwmSApv/0PyECJAsUl6XRObS2v7x+QO+DKDjZO99k/txwW0mW6+u3FjYyUprIjjuYJuYdj
 YhHy9sWT50o+qLexUb2qkBUskn0Xsr
X-Received: by 2002:a17:903:2f4c:b0:2bd:61e8:1ee with SMTP id
 d9443c01a7336-2beb05d9fa4mr169286105ad.21.1779711221319; 
 Mon, 25 May 2026 05:13:41 -0700 (PDT)
X-Received: by 2002:a17:903:2f4c:b0:2bd:61e8:1ee with SMTP id
 d9443c01a7336-2beb05d9fa4mr169285725ad.21.1779711220826; 
 Mon, 25 May 2026 05:13:40 -0700 (PDT)
Received: from [10.133.33.204] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beca535bc1sm48134085ad.56.2026.05.25.05.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 05:13:40 -0700 (PDT)
Message-ID: <db242035-8b03-48ad-b770-7c0d05480d6b@oss.qualcomm.com>
Date: Mon, 25 May 2026 20:13:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/39] drm/msm/dp: use stream_id to change offsets in
 dp_catalog
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-16-b20518dea8de@oss.qualcomm.com>
 <exhugtt2cf2zjvbing6p5q4ubyiealzj5ijcdrmmp2s45liz5q@7ccvl4euerkq>
 <753dde5f-9032-40ed-832b-0ecba7228d1a@oss.qualcomm.com>
 <zeuil2bs2qlqajen7edk5e5dveeyje3q7srxgfkkwrq6ylmzaf@smko5lyfrtnf>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <zeuil2bs2qlqajen7edk5e5dveeyje3q7srxgfkkwrq6ylmzaf@smko5lyfrtnf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a143cf6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6FVArigR0TE__iZ8T84A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEyNiBTYWx0ZWRfX5REGAxHUYvBx
 H1TtHglA49yMpeag8BHE4deplNEXhQ6kZx4sGbGin4HmYoLtwL7GkFfDQ0uuhsP5ObVMGSLxMjF
 +Yd2cM6ixrNpZlt85R+m9gtISM6YQAnogmLejnvflxgtn5nm6QLnTIACzwtIegXa9BUuIXq0Q72
 ccULUJgTGy4IVydgrtuN9Kbrn1WAnPddsT06DKiF3H8OSs+eQQUca2C7KIDLG9xl6/j3UzFLuv6
 Wr+rcCPMPpG176aTq5skQ03MzdDFpv//884uYW/oHeOdT86Yf6Fy2mMZN6g27uB1wRQl1Mf/Vik
 PkoSpvV4jQFrsytMLXiBdFcps0rTE86gCyBYcJtEo3UzmhSWC+0P054mVWvF5Y4bOViyYqF4L0G
 huyZxrb8gNhBZhdTJES0TjDSTw2Xus/GgVXzcdiqBHUFohasdBmG3ykrNQ1EWlU1J1JVr6tGKYZ
 chEvLSGkQaXEQgOa3wA==
X-Proofpoint-ORIG-GUID: 1gIZdAaANN-OY7LIoAQVXvl-txnA-WrY
X-Proofpoint-GUID: 1gIZdAaANN-OY7LIoAQVXvl-txnA-WrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250126
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



On 5/25/2026 4:21 PM, Dmitry Baryshkov wrote:
> On Mon, May 25, 2026 at 04:06:08PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/12/2026 2:12 AM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 10, 2026 at 05:33:51PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> Use the dp_panel's stream_id to adjust the offsets for stream 1 which will
>>>> be used for MST in the dp_catalog.
>>>
>>> Please start by describing the problem.
>>>
>> Got it, thanks.
>>>> Stream 1 share the same link clk with
>>>> stream 0 with different reg offset. Also add additional register defines
>>>> for stream 1.
>>>>
>>>> Streams 2 and 3 are not covered here, as they use separate link clocks and
>>>> require separate handling.
>>>>
>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.c  | 24 ++++++++++---
>>>>    drivers/gpu/drm/msm/dp/dp_panel.c | 72 +++++++++++++++++++++++++++------------
>>>>    drivers/gpu/drm/msm/dp/dp_reg.h   | 11 ++++++
>>>>    3 files changed, 81 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
>>>> index 3689642b7fc0..295c1161e6b7 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
>>>> @@ -332,6 +332,17 @@
>>>>    #define DP_TPG_VIDEO_CONFIG_BPP_8BIT		(0x00000001)
>>>>    #define DP_TPG_VIDEO_CONFIG_RGB			(0x00000004)
>>>> +/* DP MST registers */
>>>
>>> Which register spaces are they from?
>>>
>> Here also from DPTX_*, what about this? /* DP_TX MST registers */
> 
> Why? don't separate them from the registers from the same space. Also,
> please, name them uniformly. Why some of those are REG_DP1 and others
> are MMSS_DP1?
> 
Hmm. So should I just delete this comments and sort them in ascending 
address order? Regarding REG_DP1_ and MMSS_DP1_, this is a historical 
naming convention inherited from the existing code.
>>>> +#define REG_DP1_CONFIGURATION_CTRL		(0x00000400)
>>>> +#define REG_DP1_SOFTWARE_MVID			(0x00000414)
>>>> +#define REG_DP1_SOFTWARE_NVID			(0x00000418)
>>>> +#define REG_DP1_TOTAL_HOR_VER			(0x0000041C)
>>>> +#define REG_DP1_MISC1_MISC0			(0x0000042C)
>>>> +#define MMSS_DP1_GENERIC0_0			(0x00000490)
>>>> +#define MMSS_DP1_SDP_CFG			(0x000004E0)
>>>> +#define MMSS_DP1_SDP_CFG2			(0x000004E4)
>>>> +#define MMSS_DP1_SDP_CFG3			(0x000004E8)
>>>> +
>>>>    #define MMSS_DP_ASYNC_FIFO_CONFIG		(0x00000088)
>>>>    #define REG_DP_PHY_AUX_INTERRUPT_CLEAR          (0x0000004C)
>>>>
> 

