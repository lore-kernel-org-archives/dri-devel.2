Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3241ECD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 07:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ABEE10E392;
	Thu, 14 May 2026 07:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="diIkAXFG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hd0Wdn85";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99E910E38D
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 07:12:26 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E68ZCZ1965366
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 07:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4A/3dwK+XbYKnmvRsDst5JWcZQlTSj0jgLv8jjjFtiU=; b=diIkAXFGS8Y+PwsG
 tMGNjPAZyVomq2b1ZvyCnzXS68XC4dHor+TW2lOxYv9ltLFdnJtiK3vQWAAnLd/R
 3RFJVz1GV0WihPFYXIWVcUVCVNGWSMsJ2n4PMFdNoRddIGhOVdeOssBQJYQH9hoX
 May/4GyRftzXpT7pWiSj6UTmaVXUMx9xwa3iIDzVuGH2hUDw64xr4/F3RjO3KJU/
 iHoKc1zqY4oSH27Z36aHB8pzYCvhgDqe/fE7ZvcmuKwkavze1K/ocfFWwaW20Bf4
 2SIYIOF7w5Y9necSC8F1JEbbetvNVxV0OtrhnKRSUWGNfFUhrUxB+4c2J5ffE7KR
 s5NpUA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e58v886s7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 07:12:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-366ded5ab5fso11409643a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 00:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778742744; x=1779347544;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4A/3dwK+XbYKnmvRsDst5JWcZQlTSj0jgLv8jjjFtiU=;
 b=hd0Wdn85mHIj8U4nvYK9VrUcbsXTA0puqCjUpX4mf/wtpGpW5WH0wp2rUUj4pWBx8M
 5YqLTq1N8soCfBNj9a8jxYbxxgo/ui1QPakc8133h8fOz6IiHvb8z31yu7m0iPB/z+jJ
 sFwqrl87khCt3yQ8X+iI8mgxCNUnS3sI9VpipKzm0UWhz9kYCMzaNm3H4yt/VpZSpo4T
 Cd79kRWWVKO0jcGbLtNvxgGESGksxLLwsDP6vypGxJPLqLnQ1C+u6DzujVctAzGYwlf2
 DlwWgE/qidJbx6kKxIQv6I46K7u9KhHFwPoTZxXwIuhTwDqvC2t3R/uS1Pg22X2ALLo3
 PhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778742744; x=1779347544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4A/3dwK+XbYKnmvRsDst5JWcZQlTSj0jgLv8jjjFtiU=;
 b=tCX434ua5Jp1DuTBd9fXbCBTmb+CaZvaPhDM1mKsOCgi40fNJ+LADPfHY6eWw54TL+
 EYvKfGVhnfSBJE1i3Q9qBuz6I01OXV/78Y6Mp7u3+KdyBZbqgfN6PkqgaTElk85FGgYK
 hLN5u0y13g9uv2S7As5fMzKpbSQigjf6g4JLeQupgTa38FlJwYC5KJFiyZewB9t1AgiI
 HGTLALF7FY+WkkjKrXg8yWo8YS5fZHTmDgKR8NrAS4D/ggpuYw5fFeYmdlTFzptESYCT
 EgPWlrbrEKB6V4/iH8c/gJIqaSroxvlcITFLq+mRzuf0L9BTLwjqB1k735iejR0y9cSV
 3qYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/g/buFU/OEEU4Sq4w53Z44Be4NYj46EgaxeLE9h2HfcOwIzc7s7ZJCoHbL/ePl0dmujBS6jsebeDA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVFpq011YY0ARzQRW3d5gFrfqNGvovMeOsM9c3euu+zZ88uzUf
 j/9RhRwO0W3OR9l+w0fUw2t9dprX1K4V16uVCgyqDEWG+sYeG1iJFiM5Vcu0D3cD51+Wsf2CRDX
 hAXyjyyzQtC1G2BHboW6wJsBcgS0lVkb7WZxI3lesb3NOmSuTF3YbSRcB90lDDGSRyXQ1qjI=
X-Gm-Gg: Acq92OFqJj/TZhvz75OvTL6lzfYHg/gY8Wvozweb9Z37YELmhxgcJEw3CxYOe6YHaPO
 Opcw42jA6wlyOvZkGclL8fXBKNryVjn01v1bDGPFcCSIAXmqKBUHkOsmKh0FeKF1zhhQZaYT3Kw
 ix6H0H1nmcAz4KCLf/9fgodKlwk3nt8Uc+wNfnGWAQe4IBkWPsYsWidcSFVpRhI9jCo+XE9GWte
 VjxczHZFFNy8S1uV+QtaQ6y2bgdTH327OT45JOqEGgcl+CcriZ2p52gzNYyqRq320hjkzG2kWZO
 v7/IuRQ5GZFK3NjJAnpwf2G7gr9MwhDIJeYIP7KQQ72qQC1a+8m1Xr+40JTm0c1MGgx6QE6sU2m
 T92PD5ts7tG8SYTYMHap1J2gl1WV9+q+RWlH43D/5VAYbSC5kZrAy5oVv4ph7ItPfoxLppacmRV
 YQ4JbjwXZjEkVXOE6DREMfB4VgU2zh
X-Received: by 2002:a17:90a:dfc4:b0:366:5c38:fd61 with SMTP id
 98e67ed59e1d1-368f3ac4a7fmr7446788a91.12.1778742744202; 
 Thu, 14 May 2026 00:12:24 -0700 (PDT)
X-Received: by 2002:a17:90a:dfc4:b0:366:5c38:fd61 with SMTP id
 98e67ed59e1d1-368f3ac4a7fmr7446731a91.12.1778742743390; 
 Thu, 14 May 2026 00:12:23 -0700 (PDT)
Received: from [10.133.33.246] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05fcb3sm14931795ad.26.2026.05.14.00.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 00:12:22 -0700 (PDT)
Message-ID: <d4c5d26c-47f1-4e42-9852-d407982cb4f6@oss.qualcomm.com>
Date: Thu, 14 May 2026 15:12:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/38] drm/msm/dp: add HPD callback for dp MST
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
 <20250825-msm-dp-mst-v3-31-01faacfcdedd@oss.qualcomm.com>
 <pc4brjias4ixewzlsvnlhqhlz774z4p6aq7j4kldu5ze2e35sh@tsm2mtrkk3zi>
 <b5b3b1b8-ed48-429c-a87f-0278a6632313@oss.qualcomm.com>
 <tlt2ffn2xz3mpeoojcciieh35zc6pyowlkcjtxkkrnaj32enne@mbcrdrnkmaoz>
 <07ff4730-2efd-4e9d-b632-9fbb517179f9@oss.qualcomm.com>
 <vdjgzhx4xkvid2ukp7j3yir3n4tr423riyzvyzkrh2ssiub5at@pj6wfcy4jz5q>
 <4b18f14f-d485-4b9c-a75c-ead6f7c80f95@oss.qualcomm.com>
 <k6y3e4fqfwkevvvv3zmzmovsrz4i6qkxs3duhz7khsggxwwa77@uogtrpuaxhnc>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <k6y3e4fqfwkevvvv3zmzmovsrz4i6qkxs3duhz7khsggxwwa77@uogtrpuaxhnc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2OSBTYWx0ZWRfXzonVcXHu3mw5
 cat1hgmxXCkp1i22AovVxsWlBhUnHbr9F4a4DjxIGRbhzBxstNxGUddZraXwZvripjdwzH9nraK
 Owwm5icGbg2WWdaBZ2n8R46BcTDLxLPkpqYBBJm1tuXI9Q2gzwOEyoZh8qCnU1Xeg3QOdlmyz3C
 3i1eCvxhXCfXwrS3ZhvNEQdEHW0K6GjUEpgvCaA0Km6aOPo3qJ4i/FEDcoB1TjM2UdPdN5RYEhT
 puelbKkwNarpUBPh6ybdO707VN8W/PCs/q4FlzqM4cB4wIBzs5PG9ZJCiM9pcLJG9IvjX7nuSzz
 z9quCS3zBgfeurSCUqhnVzbFHrdhxL6YgD4A0SD5ndCdZ+6LI9bzamvBN1AidtxfhzKoLYoJjLT
 ZiI6YcZusGLJXksRiZDphCn2chtN7ZNqm1+VI44wamKw0kU468mawYFgPunI8jpbgsI8vR405u2
 AKAiswE75soWtU9mTXQ==
X-Proofpoint-GUID: IJAkRyBQjpvvILD05LTa0AIkTqJ71z9l
X-Authority-Analysis: v=2.4 cv=YZSNIQRf c=1 sm=1 tr=0 ts=6a0575d9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=TETkF4qc1S3FjmaiS5QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: IJAkRyBQjpvvILD05LTa0AIkTqJ71z9l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140069
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



On 4/19/2026 8:29 AM, Dmitry Baryshkov wrote:
> On Wed, Apr 15, 2026 at 06:32:29PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/15/2026 2:43 AM, Dmitry Baryshkov wrote:
>>> On Tue, Apr 14, 2026 at 05:51:51PM +0800, Yongxing Mou wrote:
>>>>
>>>>
>>>> On 3/25/2026 3:30 AM, Dmitry Baryshkov wrote:
>>>>> On Tue, Mar 24, 2026 at 09:04:24PM +0800, Yongxing Mou wrote:
>>>>>>
>>>>>>
>>>>>> On 8/27/2025 2:40 AM, Dmitry Baryshkov wrote:
>>>>>>> On Mon, Aug 25, 2025 at 10:16:17PM +0800, Yongxing Mou wrote:
>>>>>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>>>>
>>>>>>>> Add HPD callback for the MST module which shall be invoked from the
>>>>>>>> dp_display's HPD handler to perform MST specific operations in case
>>>>>>>> of HPD. In MST case, route the HPD messages to MST module.
>>>>>>>>
>>>>>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++++++---
>>>>>>>>      drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
>>>>>>>>      drivers/gpu/drm/msm/dp/dp_mst_drm.h |  2 ++
>>>>>>>>      3 files changed, 48 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>>>> index abcab3ed43b6da5ef898355cf9b7561cd9fe0404..59720e1ad4b1193e33a4fc6aad0c401eaf9cbec8 100644
>>>>>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>>>> @@ -500,9 +500,16 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
>>>>>>>>      static int msm_dp_display_usbpd_attention_cb(struct device *dev)
>>>>>>>>      {
>>>>>>>> -	int rc = 0;
>>>>>>>> -	u32 sink_request;
>>>>>>>>      	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
>>>>>>>> +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>>>>>>>> +	u32 sink_request;
>>>>>>>> +	int rc = 0;
>>>>>>>> +
>>>>>>>> +	if (msm_dp_display->mst_active) {
>>>>>>>> +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
>>>>>>>> +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
>>>>>>>> +		return 0;
>>>>>>>> +	}
>>>>>>>>      	/* check for any test request issued by sink */
>>>>>>>>      	rc = msm_dp_link_process_request(dp->link);
>>>>>>>> @@ -1129,8 +1136,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
>>>>>>>>      	if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
>>>>>>>>      		msm_dp_display_send_hpd_notification(dp, false);
>>>>>>>> -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
>>>>>>>> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
>>>>>>>>      		msm_dp_display_send_hpd_notification(dp, true);
>>>>>>>> +		msm_dp_irq_hpd_handle(dp, 0);
>>>>>>>
>>>>>>> Why is it a part of this patch?? It has nothing to do with MST.
>>>>>>>
>>>>>> Emm ... maybe here we can directly call msm_dp_mst_display_hpd_irq..
>>>>>> I tried an alternative approach by calling the MST IRQ handler from
>>>>>> msm_dp_bridge_hpd_notify(). I expected that when hpd_isr_status ==
>>>>>> DP_DP_IRQ_HPD_INT_MASK, the hpd_link_status read in
>>>>>> msm_dp_bridge_hpd_notify() would be ISR_IRQ_HPD_PULSE_COUNT. That way, we
>>>>>> could handle both SST and MST interrupt paths in msm_dp_irq_hpd_handle().
>>>>>> However, hpd_link_status only reports ISR_CONNECTED. So I had to move the
>>>>>> MST IRQ handling into the IRQ thread. Do you have any suggestions on this?
>>>>>
>>>>> When are the link status bits updated? Please remember, we need to
>>>>> support all three cases:
>>>>>
>>>>> - Native DP, native DP HPD pin handling
>>>>> - Native DP, DP HPD pin not handled by the controller
>>>>> - DP AltMode, DP HPD pin not used at all
>>>>>
>>>>> In the second and the third cases we will not be getting the IRQs.
>>>>> Instead one of the next bridges (connector, EC, AltMode, etc.) will send
>>>>> the HPD event, which lands in the .hpd_notify() callback.
>>>>>
>>>> I added some logs and did some testing. I think
>>>> msm_dp_aux_is_link_connected() only shows the current HPD state. Since IRQ
>>>> HPD Pulse Count is very short, by the time we read REG_DP_DP_HPD_INT_STATUS
>>>> in the IRQ flow, the HPD state machine has usually already finished pulse
>>>> classification and returned to Connected.
>>>
>>> But the IRQ should be sticky and it should be readable from the status
>>> bits.
>>>
>> Yes... I’m not sure how this is handled on other platforms, but on LeMans
>> can not get IRQ status from msm_dp_aux_is_link_connected().
> 
> Can we clarify that somehow? Maybe with the hardware team if it is
> uncear from the HPG?
> 
>>> Note, in the USB-C AltMode case the HPD machine is not used at all.
>>>
>>>>
>>>> Because of that, the condition hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT
>>>> will usually not be hit.
>>>>
>>>> do you have any suggestion that in how to distinguish between an IRQ event
>>>> and a plug event in .hpd_notify() better? We probably don’t want to
>>>> introduce another state machine.
>>>
>>> Then, I assume, currently there is no way to actually distinguish those.
>>> The easiest way to handle the replug would be to store the current
>>> "connected" status and verify if we are receiving "connected" while
>>> being connected or if it is a disconnected -> connected change.
>>>
>> Emm.. Currently, regardless of whether it is the native DP HPD (on LeMans)
>> or DP over Type‑C Alt Mode(test on Hamoa), a single plug event always
>> results in two or more identical .hpd_notify() callbacks.
> 
> Could you please check, why? On Hamoa it might be because of the LTTPRs.
> 
>> In other words, after the transition from disconnected → connected is
>> completed, there is still one more .hpd_notify() with connected → connected.
>> So it still can store "connected" to distinguish between an IRQ event and a
>> plug event from .hpd_notify()?
> 
> I've sent a series, which explicitly tracks the IRQ events. Hope that
> helps.
> 
Very thanks for sending the HPD IRQ series 
https://patchwork.freedesktop.org/series/151522/. it very helpful for 
TYPE-C MST.

I’ve been testing it locally based on HPD refator series, and TYPE-C 
basic plug case works on my side (although with some local modify, maybe 
now it is workaround). At least the IRQ is being delivered correctly now 
and the simplest case works. It still need to do some additional testing.

There is a small question:
When do you plan to merge the HPD refactor series? and could you please 
rebase the irq series patch to HPD refactor series ? so that i can keep 
MST  depend on those 2 series.
> Thoug storing of the "connected" state should help us to identify the
> long HPD pulse (wich should be treated as unplug & replug).
> 
>> This is my current understanding. If this is incorrect, please feel free to
>> correct me. Thanks.
>> As an additional note, msm_dp_hpd_plug_handle runs through its full flow
>> twice for a single plug event. Also, the behavior I described above does not
>> include any MST-specific filtering codes.
>>> For a longer term (and granted that HDMI also has a notion of HPD pulse
>>> events) we might want to extend the DRM HPD API to pass through the "IRQ
>>> pulse" events as is (instead of converting those to
>>> connected-whilec-connected events).
>>>
>>> Let me sketch a draft for that.
>>>
>>
> 

