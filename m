Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E99CD98E6
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320FF10E996;
	Tue, 16 Jun 2026 09:23:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oyrXOda9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="crPsuLHJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2697D10E9B5
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:23:24 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G6fXR52901587
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Qq8vPHgKwH4q0SQ20diO3tSTvhdrp1Q/CuwfNHfduU=; b=oyrXOda9Vh6h4jKO
 qi2P0JZUYE1q88Me/6Zict/gF1BGdDMvwpZCszzVzE56B5j+/E+l03s9OH/jWhbv
 6rH98zRH05jD7YDd1q32s0tnQ5XkDLGKOe07F/zzVaXLq77n02Ur8KVhVGRbWJ4C
 ji8SFwTDYZ0vfTttDc9By5TyzAuU4EgO4zdQkJ7HPrTYwNMAyrAHpryX6zm419mp
 UdWEQMgcC7iyOaFhvzN7OkX6qfA46KYaevm+Vfmrbzu1521ys/1qk38qs5kCrvn0
 fC+rGdADW7S5Qe2ko3sGecSaKej0QqFrEVMFyNyuTv2tDaxQZmX//H0gC/zGV1DM
 o3eBXg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1ep8nr3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:23:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-842688fa7b8so4856128b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 02:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781601802; x=1782206602;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Qq8vPHgKwH4q0SQ20diO3tSTvhdrp1Q/CuwfNHfduU=;
 b=crPsuLHJyKbXLuL+eo+E3JtwOq5dy035r+c95Ks8QqL8ho7zXDcid22ra+b2jpwRV8
 IlWeEjBIewqmttpozmn+BmdIeC2rUwt1DPX4F5ro8eIUCwPR0nDOIONba6yvUB5C97FS
 BZhpKzrcgHbgjzN33QFnxahmsG6iRU5ssLZcrat+7PpxXiyY88S4mnxO4/Vjo2SVKvhp
 NWynWKwr/tkWAPRaPNOSgbsXjFkBy71yq/+3VU4mFj6IemFVZdVsDICxlVudSwxaziR4
 AhYRMMD0xKDLlmPC24uB+ZxLuqOSVS7JuGIXNLgkZ02w7DrqnOtPNgrzjaW2LnVeZh9q
 N0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601802; x=1782206602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Qq8vPHgKwH4q0SQ20diO3tSTvhdrp1Q/CuwfNHfduU=;
 b=KdWRWpcxhB5cz8AIcG1BIV6T1PStI11mOCac4YkV884azy5By4OGj9C4BFIgo5UlKh
 vO0tGVZv8tT24y30vffdx5kI+w8ScnvLz1h0XyqFNum0kIAr7GBvNuk3KrcbRcsRX21e
 dI28pE9dipmeDJ8zbE8MJ/nuEekS/0v/XLfR/W0YoTNUztlD7qMEtq1svEkjcamm7/Cr
 K2GQpqPsx2bWqY3u1nJDPTrSX6MtMNApR2vOt1zuNsOIuveLOgnHpU+GcRGLEpEzXmyT
 qCb2+tD8urrDpUQGKt392pIiZXlkEhgoGDhF1MGbNDgWuFD8aoQmpcDMMAxkCzhLuiu2
 qglg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qQbXF1e4tL+dGJ68xLZl3rDqnt1pbSgXvwhHJinL58BbDCztsV9HUL4Ys3WXUrlEuyHCZuJ0h+fQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAWu8OSFdRYhxbWRX7z33Jg8vyiwYYPYiUGm164cpxaBzlItz5
 95c79XEyWxVyeGLi1X30ZiWQx6/8LrZc8Z5DjRkXuBtBRVtbrZLlwhKuVbxCzccJjZxECHj9del
 nBOSEmFWtiGkplyUZ4NjGNTFDfqZ04YL3XGcIYcnBoptpI41eu2gotS1j5+jcBC5Pr8lZSDUMUL
 FZv2Ahzg==
X-Gm-Gg: Acq92OHeb6ycaEUAnm/yMFv9fRiknhn5XR+5iu+mB9cqIg8Y/jkcXUKtV2njdIybFzx
 DU/oO4Pfg4SyeYB2gOyIOvhEM7JIM9lFnGwQ6Md7PpHavi3+wcd5Bt6IwPZoZpeh8ysit81MjF6
 TLBIIgmVmwnpaydcFDPxVSRM2+TTTvBRkuVP6dUJZfPSYP5YO9LL2db56dzw7a/BGyFeeVN91fC
 0uChduPs0ZluiUUTSxoOed2Fubaf5v1NKKLKZi6aPQI1Jaw01YUxo18WFGyFHOqjlE1F1wxxqIH
 wSpr9YHl57XMsaPRQqk92kGNCsjhWg031ngOxCUXKwiZ6Npg6oHT/xuaJGCesQd1Zxy1v+gGxNY
 FDGM4GpUCgDZjwNFaipgqiCNTSoVjHaLiAVlE22B/g+LuKx2mbHPnOJywRKvsnF5iR74GqVDrQM
 I8UA0Ps94ilCu+PRtk
X-Received: by 2002:a05:6a00:1954:b0:82f:7888:e2fa with SMTP id
 d2e1a72fcca58-84513eb9e2dmr2530021b3a.17.1781601802055; 
 Tue, 16 Jun 2026 02:23:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:1954:b0:82f:7888:e2fa with SMTP id
 d2e1a72fcca58-84513eb9e2dmr2529994b3a.17.1781601801577; 
 Tue, 16 Jun 2026 02:23:21 -0700 (PDT)
Received: from [10.133.33.98] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434afd50f7sm12099158b3a.35.2026.06.16.02.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 02:23:20 -0700 (PDT)
Message-ID: <8c80a4e3-7c3d-4d0f-93e1-27f7f3fe6bf2@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 17:23:15 +0800
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
 <d3689914-4afd-4bcb-8aad-380aefbf23d2@oss.qualcomm.com>
 <n6qjiuouisangxtov7dd7au7wb5ubt4vouodhhziuq4fychkva@275qni5tykry>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <n6qjiuouisangxtov7dd7au7wb5ubt4vouodhhziuq4fychkva@275qni5tykry>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a31160b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=h4G6HOsH2xYsS-_yFfgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfXxT7Ma5vbS+O7
 33P81cmBqn0auTL/HXS9umH82D/4NjWwEKToeXqd5ksC6+pCouK8EvaL8CknPDGRnSvZgEQVTlX
 C37ZIj1+Syc1BIv6N3t+5Jht12rzvDA=
X-Proofpoint-ORIG-GUID: n4o3Rjp1_4S9ASmASIrF0ezyGzPyzpyx
X-Proofpoint-GUID: n4o3Rjp1_4S9ASmASIrF0ezyGzPyzpyx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfXxXU+mHiI8CVI
 DxfaaWQLSuSqgvuKEGAUsG3O4rPVYXAP4oUVxDcBDex2HLOeBlvsx+HwB44syN7/MvyGAtoZhXd
 TuRI5TWJuUHQYyWvn1A0srsYc452TxwJWUaubPPzq5IEEGcddfmD1IZeLGGkZyfPHhs49qITl/R
 5zHTpsDYuzOsRFayULzVGN1VUJT94sm/VC+ULy2SrWZf2Je5rxFh9ARreI8fi4AYqfQlB1QgO7u
 cTKg8yyG5THc5e8iZaxRRA084Or837CSUzVfKwkpQlhMBNZJyCQYESC47XYC9R8sBpzNJNh5Zfv
 BiHOKEGZpSOB97msHwqtsOOj99lqFpt2tDhMxNTFypUxuPR/mpD9u3b7fkJScyDqKtLaXpDYH6/
 dpE78T0qU7ZmQX4Zg2e+kL+KQEyHG3AikGQN/YHxoRkeUpgyYnFwX98KxurXspm2icQTGNQ35em
 3K3M5B2bsACexjykYFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160094
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



On 6/16/2026 8:44 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 15, 2026 at 04:35:06PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/12/2026 3:24 AM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 10, 2026 at 05:33:57PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> The VC Payload Fill (VCPF) sequence is inserted by the DP controller
>>>> when stream symbols are absent, typically before a stream is disabled.
>>>> This patch adds support for triggering the VCPF sequence in the MSM DP
>>>> controller.
>>>>
>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.c    | 55 ++++++++++++++++++++++++++++++++++---
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>>>>    drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
>>>>    drivers/gpu/drm/msm/dp/dp_reg.h     |  5 ++++
>>>>    4 files changed, 58 insertions(+), 6 deletions(-)
>>>>
>>>> @@ -516,14 +542,28 @@ static bool msm_dp_ctrl_mainlink_ready(struct msm_dp_ctrl_private *ctrl)
>>>>    	return true;
>>>>    }
>>>> -void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
>>>> +void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
>>>>    {
>>>>    	struct msm_dp_ctrl_private *ctrl;
>>>> +	u32 state = 0x0;
>>>>    	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>>>> +	if (!ctrl->mst_active)
>>>> +		state |= DP_STATE_CTRL_PUSH_IDLE;
>>>> +	else if (msm_dp_panel->stream_id == DP_STREAM_0)
>>>> +		state |= DP_DP0_PUSH_VCPF;
>>>> +	else if (msm_dp_panel->stream_id == DP_STREAM_1)
>>>> +		state |= DP_DP1_PUSH_VCPF;
>>>> +	else
>>>> +		state |= DP_MSTLINK_PUSH_VCPF;
>>>> +
>>>>    	reinit_completion(&ctrl->idle_comp);
>>>
>>> And there can't be two streams wanting to push idle at the same time?
>>>
>> In MST, msm_dp_ctrl_push_idle() is only reached from
>> msm_dp_display_disable_helper(), which is called from
>> msm_dp_mst_stream_disable() / msm_dp_mst_stream_post_disable() in
>> dp_mst_drm.c. Both of those
>>     callers hold mst->mst_lock for the duration of the disable sequence,
>> which serializes push_idle (and the wait on idle_comp) across streams. So
>> sharing a single idle_comp on the ctrl is safe.
> 
> Comment, protected by mst_lock in msm_dp_foo().
> 
Got it.
>>>> -	msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, DP_STATE_CTRL_PUSH_IDLE);
>>>> +
>>>> +	msm_dp_write_link(ctrl, msm_dp_panel->stream_id,
>>>> +			  msm_dp_panel->stream_id > 1 ?
>>>> +			  REG_DP_MSTLINK_STATE_CTRL : REG_DP_STATE_CTRL,
>>>> +			  state);
>>>>    	if (!wait_for_completion_timeout(&ctrl->idle_comp,
>>>>    			IDLE_PATTERN_COMPLETION_TIMEOUT_JIFFIES))
> 
>>>> @@ -2183,7 +2223,7 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
>>>>    	int ret = 0;
>>>>    	int training_step = DP_TRAINING_NONE;
>>>> -	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl);
>>>> +	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl, ctrl->panel);
>>>
>>> Which panel are we passing and why? It feels to me that we have two
>>> different cases, one for the MST stream and another one for the SST
>>> link. Can we handle them separately? (note: I might be wrong here,
>>> please correct me if I'm wrong).
>>>
>> For SST, we push to bit 8 of MDSS_0_DPTX_0_STATE_CTRL.
>> For MST, stream0 and stream1 use bit 12 and bit 14 respectively.
>> For MST stream2 and stream3 use REG_DP_MSTLINK_STATE_CTRL.
>> Do we need to handle MST and SST separately here?
> 
> Where is the MST panel coming from? You are pushing ctrl->panel, which
> is the SST one, if I'm not mistaken.
> 
This function is only used in the SST path, which is why ctrl->panel is 
passed in.
The only reason for the change here is the interface update of 
msm_dp_ctrl_push_idle().
If needed, we could keep msm_dp_ctrl_push_idle() for SST and introduce a 
new msm_dp_ctrl_push_vcpf() for MST. Since the SST behavior hasn’t 
changed, no modification is needed here.
>>>>    	ctrl->link->phy_params.p_level = 0;
>>>>    	ctrl->link->phy_params.v_level = 0;
> 

