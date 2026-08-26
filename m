Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80A9C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0DC10EC23;
	Wed, 26 Aug 2026 07:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RivCXYf2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MFMsDklH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9801110EC22
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:29 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6RbsK3794442
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V93Tb3TC/II41tzTbPKnZEi8d6oHgZX2OEMTVcMO7PE=; b=RivCXYf2qcaWO4BR
 3n+BTpZexef45EO2pi6Om5RPBPxHW8jUVvmKTClu0/zE77TkDt8USe1u94cSnAuY
 mY2PB/SgcYLTMadmv3PtQM8nR+F9I0ddlXmCoy8eA5E84VCFSPyZ6pdThDxXMShd
 x0XdJcCKkaaIsjDeIKPOLXfM5AHjP3jh4ehdEFX65tCW2ulqGf993txkzf9TtZrS
 xE4uue9ts/j9/INpNxMJqTVUS77LZ3I7vU8g3p9drPy1rpL/nsDiWCHNopKxvzzi
 4NRYKhW8cxKy9pngKZ2CV8IuI7fQ7bvYubbYuDq/Rudafm6dyZBviobf7gWoODzg
 Et1nwA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smx8n9t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38fa7b09921so803864a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 00:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787730508; x=1788335308;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V93Tb3TC/II41tzTbPKnZEi8d6oHgZX2OEMTVcMO7PE=;
 b=MFMsDklHDTIrdZrT6FuQozQ2SsTVFZEQWUk+uS1bHcZ+CGnJK66WXog+qa/N8Y8QNw
 1/kxsqhnoMiQGjXzsw4JZ06emT0ZG1MZgxdLY2sN3wv5QdlhC1RNpAekfcwiHvBrCxza
 WTbeGAKxy4YN6NMpnt2FVQgHYDn0WjcLlUcrDaN9bwZQe5ZHB9C2NAREWlrG5b4KspJB
 QPeMjxfk+OnfNi3QpM82syfj7/pV11wOCnaxmRtkb4p2WMDirMY8eMll2Pa+oguU+8PK
 aY5OPWGhMfeMcuAPoxkiCvJdvFMtym4Ph4tRDOk1ieOnFToEuEf21K/55c5fzMpkAEzS
 VCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787730508; x=1788335308;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V93Tb3TC/II41tzTbPKnZEi8d6oHgZX2OEMTVcMO7PE=;
 b=tBGoPM2CYXH9bR0rB4KA5UQ3MjBFfP/eZIY4bm+3nWCQAZhGFeeAao07vrAaMeUMeG
 GE5xnz1wGQAcgQWTeoq5xw1uuH5iIA+W7h0Bh05FlkXb5wk+wTi40LDfMnW+hp5r1Ay5
 AiIuh3U8CmLfno2F0odQ2GCjKxrGpkuBtH9d9jMD2DSmpwe9KMkxyvYIIjJ5duCbm+dB
 jX3xa6Yc0E6lAb83QTdNUvxZFOY9zT8MlRCbuEU5XuoiWa9EuVsbuo5stUUbVWMmMeRK
 eej4PBovu0Bl3/Jg4YKjuwGh8lAH8c13a1J/kg4w8Q4gF2XQjTbpqpRjW9L8TOPT/B5K
 571g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWk9myEqDYgsHoho+LQQ06YCiV16VdjzXJsGhsC9TIV0cWcfS0HuxnotKfeewAPnyNg+0/ICr2UT4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lijFdIw0iC6DTI2n8vlyv6A+jN4bdcjVwX+U23BXE3YFHfy02B
 muz2jwkwL3A0cgbye2ab0mJ5b0kq7yx8d9xrG6nW9ZEpn5O7cz4hSmco1SFLHzXESmYshKwvN8x
 pWXHT/tbr9CG6iJLPv4HRzwLFSIB7txVeKccg9YkWmm2lVzUmCuxIoBJaoaYi/EhsKrbhe2s=
X-Gm-Gg: AR+sD13xICthOtOWRCBua6ENq6o8j3dgxssXHtpiq7pNBRBZp3FkuSvI69tEcKA0RLV
 i9SOlcRQ8L0qqIbSgbORwPcdLecHQMSNvwH0t+NRvdUlRmxWfY1DQB5RKEXwjjcLyVYCRrTR8HI
 5nK/sK4NqFZrRLH9ZxBdncW60Ot/7P3XA3oXd01ptTSi4uObv0HTjKOP7lC0Kk+ZesGuZQfueGd
 lSgoPRm6xlt7kkk1vxLtGvIqFWlD+u0+7Cuva8jdJ1ozqLCI4LgKCDIRprYANiEiVoah/luxmte
 VTBMtctmoVuHCSLubsO40hQewqmi4doewgsGmvdliXir8OBqQpOeC+VlrjbJLBUSEAGv1n059Vm
 D56BuhhDDF7GUAYYbFmyzTz9/IJMHtLAIa/KctpRguOR+4pEzZ0Fadx8XqAQORQiM3FmWx05t
X-Received: by 2002:a17:90b:51d2:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-3966d21833dmr10633729a91.6.1787730508253; 
 Wed, 26 Aug 2026 00:48:28 -0700 (PDT)
X-Received: by 2002:a17:90b:51d2:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-3966d21833dmr10633651a91.6.1787730507803; 
 Wed, 26 Aug 2026 00:48:27 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a5832bsm3060969a91.15.2026.08.26.00.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 00:48:27 -0700 (PDT)
Message-ID: <1b671346-cfa3-4cd7-ba05-56fceb021d3e@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:48:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 05/25] drm/msm/dp: add support to send ACT
 packets for MST
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-5-2ed6aee1867a@oss.qualcomm.com>
 <is5m5apuf3mujjm7y2edxbjjygc4w4wpp4i33vj2cyh4lzte73@heinwvrqnaur>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <is5m5apuf3mujjm7y2edxbjjygc4w4wpp4i33vj2cyh4lzte73@heinwvrqnaur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8e9a4c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=2-Wp6Lh4Fygn7rjj7MsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: CxrFmhNLXDZFu6XkVX_1sq8ATX-L5Ckr
X-Proofpoint-ORIG-GUID: CxrFmhNLXDZFu6XkVX_1sq8ATX-L5Ckr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX2teJdlqgVlXI
 H96Xtm8cM8wkYyLVF0UNLrjiIeXFNeZ0zeATq3RXu0+j+gstPH10Kz8VFGPWjNziYWYhUUVzaWL
 I7YvI/oUQq7Et0YCGNkcA++YkzDEOT6CcWsm6gsiOK2k2/r0d4KX3UJ3+CZs9uXWpV1qs5/khfO
 5PKBLBavERtS4h26PQItzv0TEjd2Bzx9fLX2mfXpDAWyBOzQwcFcCdedDph3tS6S/vx5k2e/R/u
 rq343U+no7FFOOFCzRo6ruHwYDO2WuKgBOyMuOCgAXOP3h0x6iog/bttXbAKDu0dzglCrCBPLNC
 r1qve7GhaI7JRfOTfHbzc7lYg54BxQ1eDf1flGnzZsnaQDvvkBHU6Yv59lXZYHJ9dLGg+znXM9D
 jU185utoRQTGi6mNSNOGuq3l8GrTRcvwYo+YYI8zamZJ0IG7D9thHiLnrSXWoArHdzxM/oHBjcB
 idxU/+pY0OPs/60wZUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfXwOfPbl5RqZtX
 rUXTd72t3TAguLd8oRBs3YF7Lq3khkir8eBeRXKHPaAZ+tv8jS/ANbprKleazMNTofzFF5r0z6g
 f5yQVWnhFmYLArTF8tvy8KUuJop8Z7U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260063
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



On 7/12/2026 9:56 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:26PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Whenever virtual channel slot allocation changes, the DP
>> source must send the action control trigger sequence to notify
>> the sink about the same. This would be applicable during the
>> start and stop of the pixel stream. Add the infrastructure
>> to be able to send ACT packets for the DP controller when
>> operating in MST mode.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 44 ++++++++++++++++++++++++++++++++++++-
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 ++++-
>>   drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>   drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
>>   5 files changed, 52 insertions(+), 3 deletions(-)
>>
>> @@ -2623,6 +2656,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>>   
>>   	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>>   
>> +	ctrl->mst_active = mst_active;
>> +
>>   	pixel_rate_orig = panel->msm_dp_mode.drm_mode.clock;
>>   	pixel_rate = pixel_rate_orig;
>>   
>> @@ -2658,6 +2693,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>>   
>>   	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>>   
>> +	ret = msm_dp_ctrl_mst_send_act(msm_dp_ctrl, panel);
>> +	if (ret)
>> +		return ret;
> 
> Should not we mark mst_active only here?
> 
I'd prefer not to change it here. The flag is needed later in the flow, 
and I'd rather avoid passing it through multiple layers of function 
arguments.. If MST initialization actually fails, I think it's cleaner 
to handle the cleanup through the error path based on the return value.
>> +
>>   	ret = msm_dp_ctrl_wait4video_ready(ctrl);
>>   	if (ret)
>>   		return ret;
>> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
>> index 310e5a1cc934..6808965878d4 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
>> @@ -156,6 +156,8 @@
>>   #define DP_CONFIGURATION_CTRL_BPC_SHIFT		(0x08)
>>   #define DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT	(0x0D)
>>   
>> +#define REG_DP_MST_ACT				(0x00000500)
> 
> It's not that it is a register in its own register space.
> 
Got it. will move this.
>> +
>>   #define REG_DP_SOFTWARE_MVID			(0x00000010)
>>   #define REG_DP_SOFTWARE_NVID			(0x00000018)
>>   #define REG_DP_TOTAL_HOR_VER			(0x0000001C)
>>
>> -- 
>> 2.43.0
>>
> 

