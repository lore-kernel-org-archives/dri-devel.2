Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD81CD98CF
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB77F10E9AD;
	Tue, 16 Jun 2026 09:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q6nsevqV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kY6dr21g";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B7ED10E9AD
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:44:42 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G6PWDu2402291
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ts+qkX0CT/TNnoWo6imVaA144yQNGuUf5VYhOjXuCiU=; b=Q6nsevqVbhjF+QP8
 Zj24Owc8CMZmLnEnqXXutEvBGVA8odT/jIFrz+WzLJ+pSOso6i3dvCK6YfgHTiEA
 3i2IKolcGfg/EBOcr7ffhpUzkG/SIbLYPKHp36iDnDXo5mVvyuCPxsZuzwc/kA9y
 UI2g4Kfy6yPKkZIKVakoOpFjIgO7CCxjAF4uigw1qwaDhI7LJHLt52BaneavxjwB
 gdm63KK5SaujRmAZ9fw9Y7CWom+og6a6JaT3Vk26qGxVJIy8gPRCrUZOFJz+IUBq
 m/ZHjxWw4JKMHL2084cGf8+zRIJfodSA0QRaL5Eqt1K5YJ02O8Ld9Fe3fpdzCn7P
 9zWfdg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1760tqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:44:41 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84247fed609so2388020b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 02:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781603081; x=1782207881;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ts+qkX0CT/TNnoWo6imVaA144yQNGuUf5VYhOjXuCiU=;
 b=kY6dr21g+kP6/GgfVOQCyjLKBI6exL82XaBGvlmo/h808JTPKxhYIq0CU8xDoMHbvq
 zt8JDOhALLERxqsOmaJn+Rd6hg1ZHZ8up52SQNS7TghwpOIb51RvQKSK2bvD2m+EmjBU
 oWof+14ZjPf+ePqupREVLhasWSE+RLYRd09Z2nF2gJU3yOmt6NJquUTyAlDHWoSkk2Sb
 /jQVvbb7iA8HxFb9gUdI3tx9Pvf3ZbdrwVmyo0z2S/21muMwgs60XvDV6VEw7xEIuy9b
 7QZ+TtPa7F8TvIjN2prPOkzr78lz4W4WbCuM7fjtAwkT8wGt2uSyfQgVagx8Bby6/42V
 b29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781603081; x=1782207881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ts+qkX0CT/TNnoWo6imVaA144yQNGuUf5VYhOjXuCiU=;
 b=LZna/lbLGgSMKYU95/E0s/JxzsIstt2nRU6vv8nE3NFLBlCDcdCw0brbwUxT9e8CL7
 SttSENBHy7Ym1KBK3I13NqXIvF7NSPtUypyEx8ZvtldMtP0aLKdGEDrvMcEb2IzY7WHn
 4H8Sz1PVo0QPmPx+T8rJdVbEMJ4jZKfSPkLjo7ziujWf1j7LyOf0o5/BC+mMbe3T2HaA
 RZTm/vGiG03/UD1emc/mfAOF9l+fLzsfvSTR9ycRo9FTwxwGI6hxT28lyjPJiLve9t/Q
 UPI2hViumeVZmsnWa+tuBol3zCIpoGTbTMH1HF6/buasmXyktaZ/pblsna1fBOveZe7d
 0k4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sG2yV1EIugyxiujBesypmWM2bvyn9urLejARocajZdG3Cyc/F8SWGUlugDJRFftQysEYtWEp15og=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsJDLddHYbLPzfrcy9rAnDcsMxvMQA4/JbxI4TOSqnWOr69UFC
 Ru6yxmUoV7RYCMzmAzRYE0WVu27+DD0LyM+kvQL6TSLDTK92xbL8fK/W4Fy5joIJaXvNIWfJSOb
 aIZaSWbDH8BgbVsgsHWxE4iTdbzpFbwa0zyW4wsolC4sv4r58KAS1HLuT/rR/q71vPWwB+Wk=
X-Gm-Gg: Acq92OHDJMPVD90QIExhFPt4YeTMWo34gdP3AiM/b53MItPQUQWLTVmr3x3EMW+YoVA
 sKSVfGZY3yS9+9gea2BESU200S3Ggmq3Z2uP2UFB1Cr+Q+eCcJlCd3cfJWgelwUpEOemYLcshca
 1ehUiI/Y4oQQX1pmjzWmdZRSkaB61YuZcZ3gVyF+HUEyEIXSLldsgM4YvefrYUqUmiXbNsYbICO
 CsTzPJfYCajsEy/9kBB5ouuKQ0hnCW3B7ZCZjoNnNFBuLmNj0UndYP6TtHTkFp81TBmK8dIslbX
 T70sIZrWH7N3rrVXrgGeJ5LGlDVaOEk+zf2KE/YROpMwm9cusKcCzZOUrmVV1noqWuWe1dLnu9h
 imkgATLfsDSYuJgKHjg2SYxN5mH8NVfm7K/JHEgRGgsSIPnOUOVxIns7TZKkBN/LOt/Q1DRW/6C
 a8Nds9Ze95xIJy4cRt
X-Received: by 2002:a05:6a00:3a29:b0:842:5b63:6118 with SMTP id
 d2e1a72fcca58-8434cd0b6e4mr17240740b3a.3.1781603080727; 
 Tue, 16 Jun 2026 02:44:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a29:b0:842:5b63:6118 with SMTP id
 d2e1a72fcca58-8434cd0b6e4mr17240725b3a.3.1781603080221; 
 Tue, 16 Jun 2026 02:44:40 -0700 (PDT)
Received: from [10.133.33.98] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434accae18sm13133819b3a.17.2026.06.16.02.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 02:44:39 -0700 (PDT)
Message-ID: <521918c4-fea2-4fc3-bfc6-ab2abc275ec0@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 17:44:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/39] drm/msm/dp: add an API to initialize MST on sink
 side
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
 <20260410-msm-dp-mst-v4-29-b20518dea8de@oss.qualcomm.com>
 <32jtwnkusxultvsgvnalrvccfkcyk7744yf4d42pqm7wudysvt@l4pnrzfxh2f4>
 <1fe8d286-7182-49ed-b6fc-dfa3766f851a@oss.qualcomm.com>
 <kr6obgjfl3c6ggbzkb54pyb4zevcmjvhlq4xho2yej6kynj6t3@36kxpiliyt2u>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <kr6obgjfl3c6ggbzkb54pyb4zevcmjvhlq4xho2yej6kynj6t3@36kxpiliyt2u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qBUVkHN0zkj07AmFUfxRxn1ysWif7J66
X-Proofpoint-ORIG-GUID: qBUVkHN0zkj07AmFUfxRxn1ysWif7J66
X-Authority-Analysis: v=2.4 cv=I4RVgtgg c=1 sm=1 tr=0 ts=6a311b09 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=iQs2M_KxR2iUDnadKT8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA5OCBTYWx0ZWRfX08hoZogNW1l4
 X9MXT8R/1syHPFdSOsXVYiwQvliUNza+XVqG9/Xe1dzsUuWJjELTClCnoibx8HZzIg838mLrjpe
 xxsMcDIcfyJ6lleOMq0+cdGU77eDm9o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA5OCBTYWx0ZWRfX+j5Gs+LaIF7L
 Gvy5RDFRpNRGkQ6T7bs+x2cwR41UZxpOnY64zN0VNUH3Rtv7N/ExcJvHFKQdBWGvNH+7xCXmU7W
 dw/aBU3kvDLQWvEaYYXq9BZiKZojkbZ8t5iiQzY+yaH/xMBwYLMWnxQhw0htZPdyjNif8Jita9u
 y+5EPmOPZDO2UPvGC5jnTpuvWqfh1WsqaXCDzErrFvf3draQ0KnS01RUjlAujMGmFtU/ZE821b1
 2vPcpT0LwkL277m4HJpJXFF+dR7FXyra14AyG5SnmtNBlBwpbEC3eaO/5RDYTGeERbjU1Rym95p
 KgMtziqTmBwxHZ0KnaSelfGyshntDn8LqFnRRrahai9tFBZkY42gzI08m/TDiY1kZnZi0n/fxRI
 8i2laFaTuZBo6cXGHve2gWCSCcMWCavt1xu/hXc+AOOWA0R51LpkGK0Y7sgIPpjWBqLYVxL3ibh
 v8AG1un6QocqptSotXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160098
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



On 6/16/2026 8:45 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 15, 2026 at 05:02:27PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/12/2026 8:15 AM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 10, 2026 at 05:34:04PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> If the DP controller is capable of supporting multiple streams
>>>> then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
>>>> DPCD register to enable MST mode.
>>>>
>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_display.c | 57 ++++++++++++++++++++++++++++++++-----
>>>>    1 file changed, 50 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> index 8ae690ce2b9f..abf26951819a 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> @@ -14,6 +14,7 @@
>>>>    #include <linux/string_choices.h>
>>>>    #include <drm/display/drm_dp_aux_bus.h>
>>>>    #include <drm/display/drm_hdmi_audio_helper.h>
>>>> +#include <drm/display/drm_dp_mst_helper.h>
>>>>    #include <drm/drm_edid.h>
>>>>    #include "msm_drv.h"
>>>> @@ -270,6 +271,40 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
>>>>    	return lttpr_count;
>>>>    }
>>>> +static void msm_dp_display_mst_init(struct msm_dp_display_private *dp)
>>>> +{
>>>> +	const unsigned long clear_mstm_ctrl_timeout_us = 100000;
>>>> +	u8 old_mstm_ctrl;
>>>> +	struct msm_dp *msm_dp = &dp->msm_dp_display;
>>>> +	int ret;
>>>> +
>>>> +	/* clear sink MST state */
>>>> +	drm_dp_dpcd_read_byte(dp->aux, DP_MSTM_CTRL, &old_mstm_ctrl);
>>>> +
>>>> +	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL, 0);
>>>> +	if (ret < 0) {
>>>> +		DRM_ERROR("failed to clear DP_MSTM_CTRL, ret=%d\n", ret);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/* add extra delay if MST old state is on*/
>>>> +	if (old_mstm_ctrl) {
>>>> +		drm_dbg_dp(dp->drm_dev, "wait %luus to set DP_MSTM_CTRL set 0\n",
>>>> +			   clear_mstm_ctrl_timeout_us);
>>>> +		usleep_range(clear_mstm_ctrl_timeout_us,
>>>> +			     clear_mstm_ctrl_timeout_us + 1000);
>>>
>>> For 100 ms you should be using msleep() instead. But where is that
>>> timeout coming from?
>>>
>> Will switch to msleep(100).
>>
>> The 100 ms is an empirical workaround carried over from downstream — some
>> sinks don't exit MST immediately after writing DP_MSTM_CTRL = 0, and
>> re-enabling MST too quickly broke topology probe.
> 
> Comment.
> 
Got it.
>> It's not a DP spec
>> requirement, and other drivers (drm_dp_mst core, i915, amdgpu, nouveau)
>> don't have an equivalent delay.
> 
> Why?
> 
This comes from the downstream implementation and was added due to 
issues observed with some dongles, which reportedly required a ~100 ms 
delay. However, it’s unclear whether such a long delay is actually 
necessary (e.g. if a shorter delay would be sufficient).
Alternatively, we could follow nouveau and avoid adding the delay for 
now, and only introduce it if it turns out to be required.
>>
>>>> +	}
>>>> +
>>>> +	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL,
>>>> +				     DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
>>>
>>> Isn't it too early to enable MST? (I don't remember this part of the
>>> standard).
>>>
>> No, this follows the DP 1.4a MST spec. DP_MSTM_CTRL must be set before
>> topology discovery. Topology discovery uses AUX sideband messages, which
>> don’t require link training.
>> So we enable MST first, then discover topology, and only do link training
>> and payload allocation later in atomic_enable().
> 
> Ack, thanks.
> 
> 

