Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E249CD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78BC410E2B2;
	Mon, 15 Jun 2026 08:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aauS+tiF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ctn4volo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC20410E2B2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:35:13 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6IkaA1835718
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3Ee4YEbdewBGxjbW7ktSKrSgjE89dPV0voC5PowcYfE=; b=aauS+tiFOdXy7iKV
 8ruSMy2EGu0998PGpgkC1EIdzuGeW74jI8by3n04Gv1xeAEnYMQ8qlaN4i3X110g
 3VIgwyN5rKLj5Vg6rFno5fom3EwNLUBnMIXMNNjvTjRQaoxiaV/GmCR7gZafGmIp
 tnLEd+/jpV32mc79780nqUarf0Epb3n4WRaoWbKliFN7VuM4AiQClRGuuphlcnD6
 plFuew+KsocUx+bLI0sxD9Xe5XRraLbcEZXH8nOSoCQthfcmvhoSflXbTKdU43TN
 xRRQMyDvl9ck1W/Y0+to939Jx5j2hsuz37ECO7+usJM2BrYkpDPeMLjNiZojE7kr
 ggeQ7g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryffpdqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:35:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8423f24dcedso3996523b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781512512; x=1782117312;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Ee4YEbdewBGxjbW7ktSKrSgjE89dPV0voC5PowcYfE=;
 b=ctn4voloA3B6Pgh3Qs6/sIAvAL1Rx3ifJ/EpblE7S9cXBdBQHPzb3MUKAqEl0fAjO8
 sDPKRDAvjfVsZpkWZD6GHKFeFZWAPuE8yXw4aActjDm8OqlqGJQg2UIyIaMDYu8GcmeT
 7oHnqXvRHoOWxRWa+sI4LvV7uhxoCYLFDqIkQ3dt1X8dNkRJNQIiFh42CEzJF/6mzsdc
 Al+mNyLO1rxGYdyvwWF+SnchhDgN0GERim75O7SC009SKtuI7x9qY7WffsZSknwJib+a
 CFUy103lwXnr84wO5PyBBo+EA1ExyWjEVEKenDF3CwJrZnaTYnHGImgHzfGZHXwzu9/b
 5baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781512512; x=1782117312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Ee4YEbdewBGxjbW7ktSKrSgjE89dPV0voC5PowcYfE=;
 b=qO4nz2D5xHXNfldst335LE10oGKwZ+Xg+fXvyo8s14zaqC0OaxV9pA+Pi7mhFCBIbJ
 wiXAnxnII3HByCcx7pMeFqzN8K+dNFaMTjsPapC5s8nSDSP9eUZ4lYhCFJwKSay9qjPd
 h3QFfH5f1xM27jov9yKaebQxiQyXl2vsU+TIOabkciRSlaL++Smtej81C4XIhoUVxV2X
 KRElD0Af8PGPgZWxlREO7ROKTtwcVNO6pUwJwQUw4kXmMRdGUqs0gz14O4x0oBlHxbQF
 /FsJlUp1qTpqpo8XclPukbsxQEWVmtVrnm5RacO7lRdrCYtgBH8wzAmKX5FcMPtK2BuV
 vNTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uAZ0NKKERh1RWDyJELqFHW1V1UJX4rUoqWNvpvQ0vA4XzXLw/TxycLvUcCUPtC742q+1hmAcRTKE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIvgC+6uz+kV4tRCG6bxOaTflZRDX1nU5KZYAaVBX3xyeeCkcF
 ldyflBg3zLuyZi00X93PpPRxG5dnCyZqCR5mXews6sD5OW7GxbswFy+Fi7E3tXBhQ0dnag2K9ea
 Nm7Q0HuMHYAoGN2MsGbEfk9aj6Hthw+z3mj3KiY1FlBVThU+U51T6t9lfWF2cxCsfi6QnZ7I=
X-Gm-Gg: Acq92OFLpy/zD8GCb42P1FSCQhaznBh7bVlWUEuY57ozw0D0Y5tEKn/9cYRlA/6vVxa
 WaIt0IJ3GH6WmMVbQyJ6ETCAwgLNg2zz1LgsdRo6vuHzHZExHDnbBsTMOTlD8nbgUkxct/WJzn/
 DydtGlFzdUWgSBTunvsbD6HGcLwNO8Aa1aEkXWNK5lvKJf5DHufwnwq/3wJ7aWndzYyoq/cx4YD
 x2YXQTs4Oyzd+XmvBmeVxQMDWdFi0G6ni82WtiMOGD6SD+KjkU04ChlC/qXLKvl04OxC/BC+AhC
 aRW6si8gVGtYk62CuA3CXlepJrG6c3NTmTUir4dyM6Z+8/G7q98FCdDLyfcdx8+W69qsorQ6e7A
 m9mQK0WfrfQ7v+FqAxfGZQJLDMlSh/yoE6YbG7yuHeekgFXrVxWTy/jJE3hAmBatV2oSB4K5CTb
 pH0xZWhdC9Rn1ReaJaIQ==
X-Received: by 2002:a05:6a00:2308:b0:842:2ddb:e303 with SMTP id
 d2e1a72fcca58-8434cd497dfmr14833083b3a.12.1781512512326; 
 Mon, 15 Jun 2026 01:35:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:2308:b0:842:2ddb:e303 with SMTP id
 d2e1a72fcca58-8434cd497dfmr14833051b3a.12.1781512511797; 
 Mon, 15 Jun 2026 01:35:11 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434acf2ac9sm9279179b3a.21.2026.06.15.01.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 01:35:11 -0700 (PDT)
Message-ID: <d3689914-4afd-4bcb-8aad-380aefbf23d2@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 16:35:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/39] drm/msm/dp: Add support for sending VCPF packets
 in DP controller
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
 <20260410-msm-dp-mst-v4-22-b20518dea8de@oss.qualcomm.com>
 <i6x7675n4neufglcjwneds6nehetclystyg3abosbdjkh25ub5@psdjsrfl6wek>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <i6x7675n4neufglcjwneds6nehetclystyg3abosbdjkh25ub5@psdjsrfl6wek>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HuxG3UTS c=1 sm=1 tr=0 ts=6a2fb941 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=TIrvqbJ83FTEx13vzzgA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Oj5uvjwyPfrK7IK4-8k7EVGONGPMby80
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA4OSBTYWx0ZWRfXzA4yjXb5oKUZ
 ARLC+JFB+xM3iMLOUZBQ4VlCKpv7scql1cg4FxzGzyPThl6MWchYim09e8vZ//fenqmNtkgz951
 FV8E6BniORj9uTmRe1hCP5NAi8set4s=
X-Proofpoint-GUID: Oj5uvjwyPfrK7IK4-8k7EVGONGPMby80
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA4OSBTYWx0ZWRfX7JKyXq4JIpz6
 9vfltm7jnJU8cEliBrm3fzBW3ndnT2usVw0JOxviSRrHI2JHG63I4F/Qq7bquAv6Y1CKwJSN4//
 bvDQQkCewNVFEN1k3yAlIWJ1v0vaIk1Xw7Lmuy/hgreQ62Limk2PVd+YIHMVupcxJ0XBeRqiLe5
 QtMjW9hmpJ5Qk5byL3T1l52PT1vwSnK0l7EOH9r2uCIS43P9SVJaa5u7Q+aCiVx4EldzWToKhrZ
 e5AP2FLqZHME0gB+mSl/3YDHp8+GfGGhHouSXubvOADzORr6yN1+Q3B1YPHfATidT92pDSGEi5b
 bfdpCJzzqwk0F110L4rLLiMl1EDwqgB3dXxa0CM4oV4sflzEpRyqOV6lc8KbaYNMOMUi4FLAWfg
 EYvJK/jHG7FZDA/n+odQ9SsZ5iLfTMZ7uMmPve8yABtpStOsKMrFPDq+Sjj6nkbT9yOdELHt9JM
 2YMyqyrkQ2Lbo62aHew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150089
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



On 4/12/2026 3:24 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:33:57PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> The VC Payload Fill (VCPF) sequence is inserted by the DP controller
>> when stream symbols are absent, typically before a stream is disabled.
>> This patch adds support for triggering the VCPF sequence in the MSM DP
>> controller.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 55 ++++++++++++++++++++++++++++++++++---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
>>   drivers/gpu/drm/msm/dp/dp_reg.h     |  5 ++++
>>   4 files changed, 58 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index e64f81bc8c36..9907f2e56e65 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -65,9 +65,18 @@
>>   	(PSR_UPDATE_MASK | PSR_CAPTURE_MASK | PSR_EXIT_MASK | \
>>   	PSR_UPDATE_ERROR_MASK | PSR_WAKE_ERROR_MASK)
>>   
>> +#define DP_INTERRUPT_STATUS5 \
>> +	(DP_INTR_DP0_VCPF_SENT | DP_INTR_DP1_VCPF_SENT)
>> +#define DP_INTERRUPT_STATUS5_MASK \
>> +	(DP_INTERRUPT_STATUS5 << DP_INTERRUPT_STATUS_MASK_SHIFT)
>> +
>>   #define DP_CTRL_INTR_READY_FOR_VIDEO     BIT(0)
>>   #define DP_CTRL_INTR_IDLE_PATTERN_SENT  BIT(3)
>>   
>> +#define DP_DP0_PUSH_VCPF		BIT(12)
>> +#define DP_DP1_PUSH_VCPF		BIT(14)
>> +#define DP_MSTLINK_PUSH_VCPF		BIT(12)
> 
> dp_reg.h, under corresponding registers.
> 
Got it.
>> +
>>   #define MR_LINK_TRAINING1  0x8
>>   #define MR_LINK_SYMBOL_ERM 0x80
>>   #define MR_LINK_PRBS7 0x100
>> @@ -405,6 +414,8 @@ void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
>>   			DP_INTERRUPT_STATUS1_MASK);
>>   	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS2,
>>   			DP_INTERRUPT_STATUS2_MASK);
>> +	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5,
>> +			 DP_INTERRUPT_STATUS5_MASK);
>>   }
>>   
>>   void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
>> @@ -414,6 +425,7 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
>>   
>>   	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS, 0x00);
>>   	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS2, 0x00);
>> +	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5, 0x00);
>>   }
>>   
>>   static u32 msm_dp_ctrl_get_psr_interrupt(struct msm_dp_ctrl_private *ctrl)
>> @@ -433,6 +445,20 @@ static void msm_dp_ctrl_config_psr_interrupt(struct msm_dp_ctrl_private *ctrl)
>>   	msm_dp_write_ahb(ctrl, REG_DP_INTR_MASK4, DP_INTERRUPT_MASK4);
>>   }
>>   
>> +static u32 msm_dp_ctrl_get_mst_interrupt(struct msm_dp_ctrl_private *ctrl)
>> +{
>> +	u32 intr, intr_ack;
>> +
>> +	intr = msm_dp_read_ahb(ctrl, REG_DP_INTR_STATUS5);
>> +	intr &= ~DP_INTERRUPT_STATUS5_MASK;
>> +	intr_ack = (intr & DP_INTERRUPT_STATUS5)
>> +			<< DP_INTERRUPT_STATUS_ACK_SHIFT;
>> +	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5,
>> +			 intr_ack | DP_INTERRUPT_STATUS5_MASK);
>> +
>> +	return intr;
>> +}
>> +
>>   static void msm_dp_ctrl_psr_mainlink_enable(struct msm_dp_ctrl_private *ctrl)
>>   {
>>   	u32 val;
>> @@ -516,14 +542,28 @@ static bool msm_dp_ctrl_mainlink_ready(struct msm_dp_ctrl_private *ctrl)
>>   	return true;
>>   }
>>   
>> -void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
>> +void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
>>   {
>>   	struct msm_dp_ctrl_private *ctrl;
>> +	u32 state = 0x0;
>>   
>>   	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>>   
>> +	if (!ctrl->mst_active)
>> +		state |= DP_STATE_CTRL_PUSH_IDLE;
>> +	else if (msm_dp_panel->stream_id == DP_STREAM_0)
>> +		state |= DP_DP0_PUSH_VCPF;
>> +	else if (msm_dp_panel->stream_id == DP_STREAM_1)
>> +		state |= DP_DP1_PUSH_VCPF;
>> +	else
>> +		state |= DP_MSTLINK_PUSH_VCPF;
>> +
>>   	reinit_completion(&ctrl->idle_comp);
> 
> And there can't be two streams wanting to push idle at the same time?
> 
In MST, msm_dp_ctrl_push_idle() is only reached from 
msm_dp_display_disable_helper(), which is called from 
msm_dp_mst_stream_disable() / msm_dp_mst_stream_post_disable() in 
dp_mst_drm.c. Both of those
    callers hold mst->mst_lock for the duration of the disable sequence, 
which serializes push_idle (and the wait on idle_comp) across streams. 
So sharing a single idle_comp on the ctrl is safe.
>> -	msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, DP_STATE_CTRL_PUSH_IDLE);
>> +
>> +	msm_dp_write_link(ctrl, msm_dp_panel->stream_id,
>> +			  msm_dp_panel->stream_id > 1 ?
>> +			  REG_DP_MSTLINK_STATE_CTRL : REG_DP_STATE_CTRL,
>> +			  state);
>>   
>>   	if (!wait_for_completion_timeout(&ctrl->idle_comp,
>>   			IDLE_PATTERN_COMPLETION_TIMEOUT_JIFFIES))
>> @@ -2073,7 +2113,7 @@ void msm_dp_ctrl_set_psr(struct msm_dp_ctrl *msm_dp_ctrl, bool enter)
>>   			return;
>>   		}
>>   
>> -		msm_dp_ctrl_push_idle(msm_dp_ctrl);
>> +		msm_dp_ctrl_push_idle(msm_dp_ctrl, ctrl->panel);
>>   		msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, 0);
>>   
>>   		msm_dp_ctrl_psr_mainlink_disable(ctrl);
>> @@ -2183,7 +2223,7 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
>>   	int ret = 0;
>>   	int training_step = DP_TRAINING_NONE;
>>   
>> -	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl);
>> +	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl, ctrl->panel);
> 
> Which panel are we passing and why? It feels to me that we have two
> different cases, one for the MST stream and another one for the SST
> link. Can we handle them separately? (note: I might be wrong here,
> please correct me if I'm wrong).
> 
For SST, we push to bit 8 of MDSS_0_DPTX_0_STATE_CTRL.
For MST, stream0 and stream1 use bit 12 and bit 14 respectively.
For MST stream2 and stream3 use REG_DP_MSTLINK_STATE_CTRL.
Do we need to handle MST and SST separately here?
>>   
>>   	ctrl->link->phy_params.p_level = 0;
>>   	ctrl->link->phy_params.v_level = 0;
>> @@ -3005,6 +3045,13 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl)
>>   		ret = IRQ_HANDLED;
>>   	}
>>   
>> +	isr = msm_dp_ctrl_get_mst_interrupt(ctrl);
>> +	if (isr & (DP_INTR_DP0_VCPF_SENT | DP_INTR_DP1_VCPF_SENT)) {
>> +		drm_dbg_dp(ctrl->drm_dev, "vcpf sent\n");
>> +		complete(&ctrl->idle_comp);
>> +		ret = IRQ_HANDLED;
>> +	}
>> +
>>   	/* DP aux isr */
>>   	isr = msm_dp_ctrl_get_aux_interrupt(ctrl);
>>   	if (isr)
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> index c59338199399..cfe7e4496943 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> @@ -22,7 +22,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl,
>>   int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
>>   void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
>>   void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id);
>> -void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
>> +void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
>>   irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
>>   void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl);
>>   struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev,
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index e0bf4dffa6af..e8028402f748 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -1557,7 +1557,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *msm_dp_display)
>>   
>>   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> -	msm_dp_ctrl_push_idle(dp->ctrl);
>> +	msm_dp_ctrl_push_idle(dp->ctrl, dp->panel);
>>   	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
>>   	msm_dp_ctrl_mst_send_act(dp->ctrl);
>>   }
>> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
>> index 835a55446868..65695fcb48d0 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
>> @@ -42,9 +42,13 @@
>>   #define DP_INTR_FRAME_END		BIT(6)
>>   #define DP_INTR_CRC_UPDATED		BIT(9)
>>   
>> +#define DP_INTR_DP0_VCPF_SENT		BIT(0)
>> +#define DP_INTR_DP1_VCPF_SENT		BIT(3)
>> +
>>   #define REG_DP_INTR_STATUS3			(0x00000028)
>>   
>>   #define REG_DP_INTR_STATUS4			(0x0000002C)
>> +#define REG_DP_INTR_STATUS5			(0x00000034)
>>   #define PSR_UPDATE_INT				(0x00000001)
>>   #define PSR_CAPTURE_INT				(0x00000004)
>>   #define PSR_EXIT_INT				(0x00000010)
>> @@ -356,6 +360,7 @@
>>   #define REG_DP_DP0_RG				(0x000004F8)
>>   #define REG_DP_DP1_RG				(0x000004FC)
>>   
>> +#define REG_DP_MSTLINK_STATE_CTRL		(0x00000000)
>>   #define REG_DP_MSTLINK_CONFIGURATION_CTRL	(0x00000034)
>>   #define REG_DP_MSTLINK_TIMESLOT_1_32		(0x00000038)
>>   #define REG_DP_MSTLINK_TIMESLOT_33_63		(0x0000003C)
>>
>> -- 
>> 2.43.0
>>
> 

