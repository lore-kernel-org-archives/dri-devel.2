Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6490AF4198F
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D29810E19A;
	Wed, 15 Apr 2026 10:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VNSkvZfN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JKNCu2lR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7358310E162
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 10:32:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63F8a9r62005577
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 10:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p9jj7L8wvKQnNDkm+0wvgGPXEISw7cX3mQx1BrSdKfw=; b=VNSkvZfN5GzDa+ie
 /29MhpRMW8KOOCoAPd0Bbj640OBWloKVIYprqLzAP+rgAqOxKl9F0TvVtqIzrP4C
 LEuVsqBRW4b2aHsZcSQx3/Lmnct3hV9qpxMdft/9S7XwooE9MsJr+HsXwSTTMFf+
 vXiiJIqkuhOdVrYnE2bdmoxgySsH0qpQIh7eUK19jfKPcb8embP0YY5P7qAEZnRl
 Xr/yiC2bO48gjfv4zW9oDKQQoFwcBTh16DCODK1qXBNyHtXEJC9Z4rzoqEKvXKv1
 4MYpLF6BGIr/1ENkJpypfcod1U8+RDnysSJmH9mBAy5pPU4VmBfWobNdoWXFqyXk
 YaA16Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrsjuaer-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 10:32:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35e5791871fso7639777a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776249156; x=1776853956;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p9jj7L8wvKQnNDkm+0wvgGPXEISw7cX3mQx1BrSdKfw=;
 b=JKNCu2lRl6ET8K5MJm67v4e/bhKHjRCHj15Tla38HXNqRMDOiiDv6JBu0GdqYUnxFD
 W0bZLum7DUsw8MiZdj5LFuWujIg22gN/lsquFfL0jYj1EBIfBjHF+AGYY6YVbr2312H2
 CLeRUBbilcdy98WMnbckzTxCpVcLrJsgyAzkEZgULRvWJXv8wrO5h6IvhjBrqUn4GSDd
 W6fOL0qC4jNd+GYXbhHCVFbgDwLqYE0/mKedE/rqep2myS2Avbq9wubq/siyh6gwhZ1Z
 +wubPH5WDzL+je+SLmokc+OqqSpXHIkJN2snAJqJcyto7aPGEXayDNZZYk6cvJbNuCpc
 175w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776249156; x=1776853956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p9jj7L8wvKQnNDkm+0wvgGPXEISw7cX3mQx1BrSdKfw=;
 b=bghmJwhTVZVsRkhVEJuqbupxIeUk0D0PVIYFYnvkjCLLFliWlW2k5NJQOd6QvAgoXK
 C4uESHay6VpWM++GOcVcfrQhWXYRt0N1sejpUv/TAyHwLbdEPfMjfyF518UDcRRpxW9g
 MUrmGAK1JQi8wmmYDCiYy/Pfj/8YQCREUfefy4p/JM243KcSR2Okf6b9Hl1z7kbFKuBD
 +s7TtOxxTZVGyBevv4/sJBf1K0bKQMTBWyozNxn0RkdOk/3o1icuijLXAmKIp00SaEZ+
 3ngi021oYdShhcOqG9EM5CgnOancFk1bDfzBze01rdvKWt29Cb7Gq3R8ps0rA2lWVhs+
 osNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+H2ur2dD6jop4w3Qa/DdS/w9iPdnhd1c2HZJdfX6KhiRxwhUgrMqp6iLhwLV4kSfW/hbC1f5N2Jrg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQUTUGL3zyW1F88AgRSDyDtff7xpHl64QKomcNg+bIfdB6hcr4
 E7g381V04HK221sbo4X0ONPKf6bcugoICGd77fjKXLWutwNpbOf16Wp7BbZru8mtPoVUEPywBoF
 MGr9ufiIH8UEAR9Vyw2gPtIB6o1YM+o2aRZB0+c3mXoolAh8YVDyAeeXkiB1IioxGioIgb5zlFe
 x23CrK1Q==
X-Gm-Gg: AeBDietGVKRyAgvQNPJjjQB0Q8EzYNg/rqWlA6cjQxrQhPWpwPB4aUu7ryVD5AtMwF8
 2CR+zcxGMU2aLrhRhpgXXGP3GlAqVxkUaG8iVH7gcGi0qLxZRDpAk2QrX1e8D6wWkfbuG9KMVzE
 RZiuRP1X+fl8eqvzPd6zCUQtZZ/m6W5YvHWfzI3vPy7xyUb2tPGi+9spni/DdDmc0IPATm5gW7b
 37hniVZvEIyEvl+XhZW/VWNChu/BYqSDyrecydBBQnLiqlOXIcrCrYUOjY44prFhgGvCsptI5Ed
 5bW4GZ8nUWYmHIa5PxEJHsMh5xRxo37vyomukbF+yuTIkqFo6+f9R7yASxia+FHehjQ+d+Arka6
 Aj7hWs741DQDIbSbBq1SCH6OMa4rDXmxTeT6wA8zpqpa6RnggaKMCxGqxfFtPuQF2k/5u24uEHo
 BZZJdUUykLVxORnd6wEuwKywai63Ig
X-Received: by 2002:a05:6a20:7345:b0:39f:ebf7:5ba6 with SMTP id
 adf61e73a8af0-39febf768e8mr22537040637.25.1776249155851; 
 Wed, 15 Apr 2026 03:32:35 -0700 (PDT)
X-Received: by 2002:a05:6a20:7345:b0:39f:ebf7:5ba6 with SMTP id
 adf61e73a8af0-39febf768e8mr22537004637.25.1776249155405; 
 Wed, 15 Apr 2026 03:32:35 -0700 (PDT)
Received: from [10.133.33.152] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7957efce3asm1399524a12.14.2026.04.15.03.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 03:32:35 -0700 (PDT)
Message-ID: <4b18f14f-d485-4b9c-a75c-ead6f7c80f95@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 18:32:29 +0800
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
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <vdjgzhx4xkvid2ukp7j3yir3n4tr423riyzvyzkrh2ssiub5at@pj6wfcy4jz5q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WKhPmHsR c=1 sm=1 tr=0 ts=69df6945 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=lshNY4iLFTa4dCOtUIEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 6KOEPxr5PY_9oOjInzE2ukjG4Kb4rzmq
X-Proofpoint-GUID: 6KOEPxr5PY_9oOjInzE2ukjG4Kb4rzmq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA5NiBTYWx0ZWRfX027v1f5PY54j
 5qbjApVEGz5YHu3pT44vQ2IecBQdyhlbogGGUj9uUuI59fnSwm8M0zHR/wmomUHPlncbAh7nZBB
 g8fT8S7oXm+KW66CxA9Sg79cp2bBUl0L4+2yU0r/7/azuouUx8hw61cXKTokF3Oqa27WD1jaw7a
 Mk1/GmeU/MNLgppBFurvlgrNz8iNrIknkoUMFG+mB7XVPCE6zF0H4YnkUP0PuT3oZ3y1eX79EK1
 YstiVortvPdzcGsC97Kvl9KN+xN01p4RMz4KFLB+n64EaKTIQZ/oX/HuXGhftDMyWj4V4FiN9vG
 ehsX97FiJcPLIX72KLa19SZTkv3PS2+VcEc/8+jcVCatm2m6zpaVXxrwoHfb8/aUFEew+++mn4Q
 joq29CnbY6/uLiiY7XLBgYrum8ShNdB0eptArPtrB4NSXvZe4oiq/TfQzD0Ytsqhu4V24On1+d/
 Dj+Xrs0eviz+CTPvtRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150096
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



On 4/15/2026 2:43 AM, Dmitry Baryshkov wrote:
> On Tue, Apr 14, 2026 at 05:51:51PM +0800, Yongxing Mou wrote:
>>
>>
>> On 3/25/2026 3:30 AM, Dmitry Baryshkov wrote:
>>> On Tue, Mar 24, 2026 at 09:04:24PM +0800, Yongxing Mou wrote:
>>>>
>>>>
>>>> On 8/27/2025 2:40 AM, Dmitry Baryshkov wrote:
>>>>> On Mon, Aug 25, 2025 at 10:16:17PM +0800, Yongxing Mou wrote:
>>>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>>
>>>>>> Add HPD callback for the MST module which shall be invoked from the
>>>>>> dp_display's HPD handler to perform MST specific operations in case
>>>>>> of HPD. In MST case, route the HPD messages to MST module.
>>>>>>
>>>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++++++---
>>>>>>     drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
>>>>>>     drivers/gpu/drm/msm/dp/dp_mst_drm.h |  2 ++
>>>>>>     3 files changed, 48 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>> index abcab3ed43b6da5ef898355cf9b7561cd9fe0404..59720e1ad4b1193e33a4fc6aad0c401eaf9cbec8 100644
>>>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>> @@ -500,9 +500,16 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
>>>>>>     static int msm_dp_display_usbpd_attention_cb(struct device *dev)
>>>>>>     {
>>>>>> -	int rc = 0;
>>>>>> -	u32 sink_request;
>>>>>>     	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
>>>>>> +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>>>>>> +	u32 sink_request;
>>>>>> +	int rc = 0;
>>>>>> +
>>>>>> +	if (msm_dp_display->mst_active) {
>>>>>> +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
>>>>>> +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
>>>>>> +		return 0;
>>>>>> +	}
>>>>>>     	/* check for any test request issued by sink */
>>>>>>     	rc = msm_dp_link_process_request(dp->link);
>>>>>> @@ -1129,8 +1136,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
>>>>>>     	if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
>>>>>>     		msm_dp_display_send_hpd_notification(dp, false);
>>>>>> -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
>>>>>> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
>>>>>>     		msm_dp_display_send_hpd_notification(dp, true);
>>>>>> +		msm_dp_irq_hpd_handle(dp, 0);
>>>>>
>>>>> Why is it a part of this patch?? It has nothing to do with MST.
>>>>>
>>>> Emm ... maybe here we can directly call msm_dp_mst_display_hpd_irq..
>>>> I tried an alternative approach by calling the MST IRQ handler from
>>>> msm_dp_bridge_hpd_notify(). I expected that when hpd_isr_status ==
>>>> DP_DP_IRQ_HPD_INT_MASK, the hpd_link_status read in
>>>> msm_dp_bridge_hpd_notify() would be ISR_IRQ_HPD_PULSE_COUNT. That way, we
>>>> could handle both SST and MST interrupt paths in msm_dp_irq_hpd_handle().
>>>> However, hpd_link_status only reports ISR_CONNECTED. So I had to move the
>>>> MST IRQ handling into the IRQ thread. Do you have any suggestions on this?
>>>
>>> When are the link status bits updated? Please remember, we need to
>>> support all three cases:
>>>
>>> - Native DP, native DP HPD pin handling
>>> - Native DP, DP HPD pin not handled by the controller
>>> - DP AltMode, DP HPD pin not used at all
>>>
>>> In the second and the third cases we will not be getting the IRQs.
>>> Instead one of the next bridges (connector, EC, AltMode, etc.) will send
>>> the HPD event, which lands in the .hpd_notify() callback.
>>>
>> I added some logs and did some testing. I think
>> msm_dp_aux_is_link_connected() only shows the current HPD state. Since IRQ
>> HPD Pulse Count is very short, by the time we read REG_DP_DP_HPD_INT_STATUS
>> in the IRQ flow, the HPD state machine has usually already finished pulse
>> classification and returned to Connected.
> 
> But the IRQ should be sticky and it should be readable from the status
> bits.
> 
Yes... I’m not sure how this is handled on other platforms, but on 
LeMans can not get IRQ status from msm_dp_aux_is_link_connected().
> Note, in the USB-C AltMode case the HPD machine is not used at all.
> 
>>
>> Because of that, the condition hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT
>> will usually not be hit.
>>
>> do you have any suggestion that in how to distinguish between an IRQ event
>> and a plug event in .hpd_notify() better? We probably don’t want to
>> introduce another state machine.
> 
> Then, I assume, currently there is no way to actually distinguish those.
> The easiest way to handle the replug would be to store the current
> "connected" status and verify if we are receiving "connected" while
> being connected or if it is a disconnected -> connected change.
> 
Emm.. Currently, regardless of whether it is the native DP HPD (on 
LeMans) or DP over Type‑C Alt Mode(test on Hamoa), a single plug event 
always results in two or more identical .hpd_notify() callbacks.
In other words, after the transition from disconnected → connected is 
completed, there is still one more .hpd_notify() with connected → 
connected. So it still can store "connected" to distinguish between an 
IRQ event and a plug event from .hpd_notify()?
This is my current understanding. If this is incorrect, please feel free 
to correct me. Thanks.
As an additional note, msm_dp_hpd_plug_handle runs through its full flow 
twice for a single plug event. Also, the behavior I described above does 
not include any MST-specific filtering codes.
> For a longer term (and granted that HDMI also has a notion of HPD pulse
> events) we might want to extend the DRM HPD API to pass through the "IRQ
> pulse" events as is (instead of converting those to
> connected-whilec-connected events).
> 
> Let me sketch a draft for that.
> 

