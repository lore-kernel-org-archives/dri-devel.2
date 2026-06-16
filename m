Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F055ECD98CF
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2F310E9C5;
	Tue, 16 Jun 2026 09:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JLASb6/a";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PRmpHl9z";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA7510E9C5
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:51:57 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G65MWb2849840
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sMOZTRu51g9pUPpWMnqPhEB0vPr07XkL6hULH16byek=; b=JLASb6/aL0EfAJIf
 BZD20bmA4208cHOjVVvPbO52FaL07bm2ihQ1TxZ/7kzzEYJMkBupZbIcrIb6WA2g
 QZzlbulVUOJOSVN3/LNkQ3YNzRtGX+s5V07pcX6h1QbQmUPewa/nTReetOqOYmQE
 b4FkcNv958bboc1V/EPIBnqNXSc9r6KQnn4R4/v+4F/D8SmhqCMFDTzRuIeWhDS6
 ruHpyPiQbhM3jce/Jus+H22ywzdpp+JbbL07F+G+88j/GkEOXo7CoCIwOeOGIfZS
 s7Et4KMid+YHNHrGxZnkqRJLeAAVBqjzw3WcN3Z84A9qlaeSae+vv6W6FWvXAQDA
 Rwg6nA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09g94d4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:51:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36d98b6f019so4792570a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 02:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781603515; x=1782208315;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sMOZTRu51g9pUPpWMnqPhEB0vPr07XkL6hULH16byek=;
 b=PRmpHl9zHUQ6x4+4ghn6GttEJ1epXfdbqRXHoV7olU+2+yZ/dpLKXJOG8cg4bXE+mG
 +Um93HAWNc8Xg0HBwQeHsW33reEQg/jWnyjPBUyeyxphenpCajL+s4lRiuQcq5sOan8F
 nosZH3yBe9S64ptyelBmsw73uSS3eVNMD+8PKtYrX8ntqNuEjrvHktRk0K92V8A9oYRp
 NP8++wHhn6csdvCL2akcF3+nu2trpS5XBajiow5WW7QkP30qCSi/3u1WaYUDyVPnQNw0
 FcB34brbDFaLcsaiVzJp+wVKYNP4aEkpsEQv0npse94LyLHUsYWaCTwBC9fbJyKdCHg6
 TIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781603515; x=1782208315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sMOZTRu51g9pUPpWMnqPhEB0vPr07XkL6hULH16byek=;
 b=gufj58kMjYT/TyQsXR9Fx+Ls2rLSekv0RmYQIgTLIZ4Q3Agc3+O/HE3hwDS65CuK3b
 0RvyR3aDm33NF8lrC+kONznsbBPzZzJrdM19HOo4lDE0QHFnZger+qQaXQ3QwrDYEmGl
 0L0jfCPnM7VytN1NJQHB7K6BRBGRh+udqUlY2DYnV4JEziRij0xRxQAiopL0+09gDX6E
 Xa+O6tY7QqFyFZetHds95KFC2LvRo66ZnXD5JOZhOBrWZGMQUgFq5HSwgdTgXAyVzf2Q
 NsQLzIR+R2v34lp0xIIJaA+y6IqNDsDpvA/3909/+WkA3nOK/SfEsFAwxzxgJ6mLFOBL
 XUxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uA1QQQ0MVuyCS3uJyZ/v24EWlgWdNVsEXdHcAdW3uWfdh8e68SciKMDgKTtZi4A3tYfejL5FEN4g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzhlrsPBC7eRyjU2mRaPoXeU6o+mbWyP58wfsrW7dDjw0lU9ES
 DtTwEzQS0tjoloCuMZGoA7FU7ORNy2T8NrbCH+9cEOJxOut+lCQgoMTzFC5x83zL/h46SUaA7S5
 isWdPBpVRA6EZykjc3eEwt4B5bkBVI21ytFAq62B5KjvfqZhXbWmVHiQGYcSaO/nOJRcud6M=
X-Gm-Gg: Acq92OHGvTwBvKJ1rmVeoo2H3Hu6GYR0S48KYWzSypL8Xdk65tin8qvKtFHEE470uOn
 oE3534/WDVRWjZFApzIKh3bQ15nhCjZE9LTrYb8Ls5FgwaeGo+pAVVvWgtPvLbyNeyj0XenEppp
 B8tXP/QIIcigZJLRtYEB2e+5WBBXC1TUHdobcBpOrURjBQeSFE4Hsr3DOm5jwQ1kFAuJygUE7z9
 qjiY0Ru3IdG4fjUq2cbiIuLjbeflE7RdmvEavOfePkFii59G/JnjN0sWVEnZxqhFuZ5GDQfMgd4
 xPjV60EEl38+HTX6iZy5PJNupVFy7VeOj9DB/szevI8gZO6F0unU4zJEbNCPl7H6C73YuN81ouc
 CrPppIvR8ZEJjm1JRvvc+RPAZoS+ptjK1iQTXDSJ0KVlU0c+Qfg7t0F3ke7jMOYIjZIFutrReIT
 lpmFYcnZ4Cj5kpkZTG
X-Received: by 2002:a17:90b:55c7:b0:35e:d015:d675 with SMTP id
 98e67ed59e1d1-37c5231731amr3218116a91.7.1781603515042; 
 Tue, 16 Jun 2026 02:51:55 -0700 (PDT)
X-Received: by 2002:a17:90b:55c7:b0:35e:d015:d675 with SMTP id
 98e67ed59e1d1-37c5231731amr3218075a91.7.1781603514551; 
 Tue, 16 Jun 2026 02:51:54 -0700 (PDT)
Received: from [10.133.33.98] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5208fd0fsm2258085a91.0.2026.06.16.02.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 02:51:54 -0700 (PDT)
Message-ID: <bcf6de3c-97cc-4f83-9450-fa4a64025243@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 17:51:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 37/39] drm/msm/dp: add HPD callback for dp MST
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
 <20260410-msm-dp-mst-v4-37-b20518dea8de@oss.qualcomm.com>
 <ml35zldwr6f7euzmw6noy7j5mufyhfhmwoigkwq5ykyyl3amgb@5eo63mfnd4tg>
 <42c2bbab-dd86-4ba8-94f6-a6f377425be9@oss.qualcomm.com>
 <t4ocbdrm4d3xlocycwnsgkcyyuaebfbkid73pxzel46nh724rs@wairidx7ct2x>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <t4ocbdrm4d3xlocycwnsgkcyyuaebfbkid73pxzel46nh724rs@wairidx7ct2x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA5OSBTYWx0ZWRfXy6jpXEQ4xGUU
 /I+zQvxMdYPNjQALeQlvoEosDnfZnjDpmU5PTlWLfnO8xN+oYocvizWOEkKtY6EuCuRXJMhon/t
 pOvmli49ael1YDOOnGLsZBDbwg5LkyS2xkTKN9VNFkBdEJPtH3v3STG2/u1UejtwajbAh9GjJgT
 llucfnnOV2YYLINGDht+SgzsTdZ9CBBUhTUlJhD+GS/VLccr6HM8yr8NdxjbcIDWQx6exJsE5Ap
 0u6Oi98UQythblUdXAPfkcg51OpajZ1/MjYiHSarin0OEy/1MtUyIzFzBFzGqNwdkCqW4Zr06cy
 B2SkXlpaE6OjMSVQ7XJUXgdQYhItdyqSaJRBNhQ1VFYIpvKyT9gaimLZZo+FpQly3rVoj7opHSP
 jwSWMURguj/CPXfz3qeAIQOSLSJyuRS3bn5B4Cs7uv6XTc3FxfUhobhKxoSO6qsmJEFpXg3Ja25
 I32OoMeO7Qhm1Kwtb1Q==
X-Proofpoint-ORIG-GUID: ok3zMpzFE2fZaAxtdRtIV8lcHVq0n1wc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA5OSBTYWx0ZWRfXwLMqCBrkJMXY
 4uocZsapwANdzDpZsOKBHPk552yyzF9MksC4S9HZ84U5hEmfNWJTQszXsjYYXNL2v9zWgn025cm
 hPLDP0URmOmNfI5MzQcrAq7zaF1+rAQ=
X-Authority-Analysis: v=2.4 cv=DLa/JSNb c=1 sm=1 tr=0 ts=6a311cbc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=btda8m9z8dVjgjKQGyEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ok3zMpzFE2fZaAxtdRtIV8lcHVq0n1wc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160099
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



On 6/16/2026 8:50 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 15, 2026 at 06:05:07PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/12/2026 6:00 AM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 10, 2026 at 05:34:12PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> Add HPD callback for the MST module which shall be invoked from the
>>>> dp_display's HPD handler to perform MST specific operations in case
>>>> of HPD. In MST case, route the HPD messages to MST module.
>>>>
>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++----
>>>>    drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
>>>>    drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
>>>>    3 files changed, 54 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> index 919767945ba5..ca89e20b7563 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> @@ -454,6 +454,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
>>>>    			dp->msm_dp_display.connector_type,
>>>>    			dp->link->sink_count);
>>>> +	if (dp->plugged)
>>>> +		return 0;
>>>> +
>>>>    	mutex_lock(&dp->plugged_lock);
>>>>    	ret = pm_runtime_resume_and_get(&pdev->dev);
>>>> @@ -556,12 +559,19 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
>>>>    {
>>>>    	u32 sink_request;
>>>>    	int rc = 0;
>>>> +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>>>>    	/* irq_hpd can happen at either connected or disconnected state */
>>>>    	drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
>>>>    			dp->msm_dp_display.connector_type,
>>>>    			dp->link->sink_count);
>>>> +	if (msm_dp_display->mst_active) {
>>>> +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
>>>
>>> Will this work for USB-C?
>>>
>> Hmm not work for USB-C. We can remove this check here, as the IRQ thread can
>> handle the disconnect case itself.
> 
> Please. Start testing with USB-C too.
> 
Yeah. will test USB-C also. Could you rebase this series on top of the 
HPD refactor series? Thanks.
>>>> +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
>>>> +		return 0;
>>>> +	}
>>>> +
>>>>    	/* check for any test request issued by sink */
>>>>    	rc = msm_dp_link_process_request(dp->link);
>>>>    	if (!rc) {
>>>> @@ -1125,9 +1135,13 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
>>>>    				      connector_status_connected);
>>>>    	/* Send HPD as connected and distinguish it in the notifier */
>>>> -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
>>>> -		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
>>>> -				      connector_status_connected);
>>>> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
>>>> +		if (dp->msm_dp_display.mst_active)
>>>> +			msm_dp_irq_hpd_handle(dp);
>>>
>>> No, don't touch this code. HPD notifications might be coming from the
>>> other entities. This IRQ thread can only send the HPD notification.
>>> There rest should be handled in the notifier.
>>>
>> Ok. From my understanding, after this series
>> (https://patchwork.freedesktop.org/series/164954/#rev5) is rebased, we
>> should use drm_aux_hpd_bridge_notify_extra() here to notify the IRQ?
> 
> No. There is no aux bridge here. But yes, I'd need to call a different
> function in that series.
> 
There is one concern here: if we use drm_aux_hpd_bridge_notify_*() to 
notify IRQ events, does that mean every IRQ notification would also 
trigger a hotplug event?
If so, this may not be necessary, since the MST core framework already 
notifies userspace/client on its own. Additional hotplug events could 
cause userspace to query connector status again, which in turn might 
trigger the bridge notification repeatedly.
Please correct me if my understanding is wrong.
>>>> +		else
>>>> +			drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
>>>> +					      connector_status_connected);
>>>> +	}
>>>>    	ret = IRQ_HANDLED;
>>>> @@ -1793,7 +1807,8 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>>>>    			msm_dp_hpd_plug_handle(dp);
>>>>    		}
>>>>    	} else {
>>>> -		msm_dp_hpd_unplug_handle(dp);
>>>> +		if (hpd_link_status == ISR_DISCONNECTED)
>>>
>>> Why?
>>>
>> Let me explain this in more detail here.
>> Currently, MST hotplug and IRQ events are handled through the SST bridge.
>> This guards against spurious unplug handling caused by
>> msm_dp_bridge_hpd_notify() being invoked from non-HPD contexts where status
>> == connector_status_disconnected does not actually mean the cable is gone.
>>
>> In addition to the real HPD IRQ path, drm_bridge_connector_detect() also
>> calls drm_bridge_connector_hpd_notify() to broadcast the detect result to
>> all bridges in the chain. So a single physical plug-in produces multiple
>> msm_dp_bridge_hpd_notify() calls — one from the real IRQ, then several more
>> from various probe/poll paths. Stack traces from a single insertion on
>> QCS8300:
>>
>>    1. msm_dp_display_irq_thread → real HPD plug, status=connected
>>    2. fbdev probe triggered by (1) → drm_bridge_connector_detect →
>> status=disconnected (link not ready yet)
> 
> This should not be happening. We don't use link status anymore to return
> connected status.
> 
Let me double-check this.
>>    3. output_poll_execute worker → same path → status=disconnected
>>    4. drm_dp_mst_link_probe_work → same path → status=disconnected
>>    5. output_poll_execute again → status=disconnected
>>
>> Here not work for USB-C case yet, I’d like to switch to using
>> drm_dp_read_sink_count to detect whether the sink is actually disconnected
>> or no sink devices.
> 
> drm_dp_read_sink_count() isn't enough here. See the plugged flag. Maybe
> we need more flags here.
> 
Got it. Let me see if there’s a better way to handle this.
>>
>>>> +			msm_dp_hpd_unplug_handle(dp);
>>>>    	}
>>>>    	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
> 

