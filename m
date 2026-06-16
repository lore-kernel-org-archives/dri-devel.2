Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FD0CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BABA110E7A6;
	Tue, 16 Jun 2026 09:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8WvfqAM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ioTadQXV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6747C10E997
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:36:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G65nHv2699856
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X0Sug0Tsqh/M5PwkF4UUdSLiPropy35fugIaYP0nYAs=; b=B8WvfqAMu/BZWyfs
 n9DKFIcgLbWEBgFb+7HuglD79j0x6B5Hzv9+cpsQ1M1kbpPP0CZRDySIN7Cgsaa+
 SaXGrvXRxGXxNydw4sR1hQPr+aFuUDABzAeNinak7zTn3xjZy6gesVO+u3t9dvMg
 m/C2Glc12GzijzVsCcUEvVYcgnJwo3fmCVhtZKWAZqYmKnmerg0Ybcqu8sm1qlDG
 GVm1Gx/0JK77JLq5K2jJqX+ZiOhpfzIGx3hzaQeBFIqEX1FF/81JquFTE4sAxDLo
 3yFmj4mwIfc3FoQAZoLCmlz/LleZHByDQZBwr+DOa4WplvxjbmhbVQjyAexB6IWs
 /9sLeA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09k92cd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:36:53 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8428419982eso4036905b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 02:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781602612; x=1782207412;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X0Sug0Tsqh/M5PwkF4UUdSLiPropy35fugIaYP0nYAs=;
 b=ioTadQXVSW0mT7hn7y8okoYq3li4U8jy90rte2FohLxvmlnqeufNRn4mRJfalWVhxI
 GNeIzpORSg8ZW/18Ent1eJoGRhmpAwclYqc/75qs/DMjniaBCTr/7eLf3pKY8mv9lnr8
 qbnqCSpttfLZBGOEvJfWySwlBRF7DBziEOZUDEKLTE2BQD3IFUynS1rx3Eny8biHb+Jj
 pAoiMspf0mTDScMtGSTzP3wQKTCWqf1EIrA+80i7caX5OJ0aiM2HvMx/hO0GKhG4N8qW
 +KQd38bSsU55frUGBPnfAf7SZMGbiAbFo9wGdkkZf14wVK9f20iLTE8HOxYbd7qSchdg
 FhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781602612; x=1782207412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X0Sug0Tsqh/M5PwkF4UUdSLiPropy35fugIaYP0nYAs=;
 b=qL125v2LQ/9Gewcd8ICtjRrtqLBzEU3kEAfHKTzGzX8JK5KibTMol9zUBbW+HSZalg
 9Ig0PPO2aaSYrW0qHyJUoyYajytfxrrOgyPrK17f5g064+7BXmjEyOAqQEVWMkWefXDI
 OpU/AJkUUVtN/nwXd3rJmPJrzL8zeSM0bYQ9QV5mUARPXqWIXbSVdQ/ZIptXt5TxMhPe
 Ag1V4jw16JgSrdc3apJCQ2Gn6lU/YNFTEgr1nJyCJwpvDCNd1G2xd0GX3amGRRBxuZ6c
 b7wftpSj51EYfDQ0LrigawUmuWb6O81EASpD0qPG9JphA6WPEqFbyduQU3xqu7UTR3En
 fQ/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DhzqfwNCtRDCmjXVougif9cDff98qinNUsy6Ys4w+PJfoNnJhFyMOdWFvWOGSoWzbdbW8AcEMGSI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzo27lw8kPatp5BKKdsPBV8RPwawFd9Yy/t3RVytrf3mFih6lhE
 GU1JMU3kUnigO4f7d+aJerqvdb+23wZt92CvKVx5Kg4XSH+mpBA30aYak2vta24D/cn2vrxOFVK
 s4mnmXL9q+yVyvpXzi9p6H9YRUITInQjCB2acIxGpCFNMyQHPzmHYYs4bk7zU9pTLVc2SHco=
X-Gm-Gg: Acq92OFMijXDIXBwZDv9zhQ8MVxjtKxfnKngQyugGMKm7uhySGmiZFZAhJDef0XHdy6
 62PtPT3Mn6oKvwzpJGCRV5onkWOVGvPh75F1yr3SItirpqueOb6fGjxu/NprYrVg6LDIg7rAgEe
 PYDeJI4S9DV9CLhELtKloFMSIfLF7kOMPyETotniaXCK7nfWF0nTBaaud9F6XatnRNX/BxQP56n
 Om7AZacaYkHtiWDDj+oJCqpDsW88v+s8k7xE7SIRIofQWjs4pG8zpmLwIyp+lbj+9IB0AnyXL/k
 C/WjRdp4hJswoYdfSNnN5mmcfEwdCAIKEjWxujqr3IQ5BXjSlJksCq7D/h0uRCD4YV2m/o0/8yw
 0ldq6uB72p6opd6B3fySxm481Nk0xEsfmidjutxR+d4TL7SbyZbRelAUBVROEGXk9sF7ow4q9Cv
 XjaCM5QTV4ghkoPc+R
X-Received: by 2002:a05:6a00:450c:b0:839:12a7:70f7 with SMTP id
 d2e1a72fcca58-844e1a59f93mr15471194b3a.31.1781602612036; 
 Tue, 16 Jun 2026 02:36:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:450c:b0:839:12a7:70f7 with SMTP id
 d2e1a72fcca58-844e1a59f93mr15471168b3a.31.1781602611570; 
 Tue, 16 Jun 2026 02:36:51 -0700 (PDT)
Received: from [10.133.33.98] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ad03fdcsm12300594b3a.24.2026.06.16.02.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 02:36:51 -0700 (PDT)
Message-ID: <8681a6e0-fa32-46c9-b28a-e5d569a87247@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 17:36:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/39] drm/msm/dp: add support to send ACT packets for
 MST
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
 <20260410-msm-dp-mst-v4-18-b20518dea8de@oss.qualcomm.com>
 <6jkqen322yklhb4zzoj2kcgwayhcqm3mhnbrkgimr7zubwewao@gmuopu6uxakq>
 <49131a73-f60e-4296-a6d4-5ff59331a9dd@oss.qualcomm.com>
 <hwomujvf4h6hmyk3bu2a26k4ck26aggxbkovf36hdilk72zfcs@c67fzpbpx56c>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <hwomujvf4h6hmyk3bu2a26k4ck26aggxbkovf36hdilk72zfcs@c67fzpbpx56c>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA5NiBTYWx0ZWRfXxIBrjJcpvaYj
 H3E5/SU623ildr9GMsD2M+ylInYnJE3vZbwO455qU0pOxfO6Ng3HXyoLvkzrawF4cEJZiN3hKMF
 c4W+uCI4qGonZ7x8xq4hUReL/a2QfKU=
X-Proofpoint-GUID: J8LWwFoh5wv4lNX1UvRNW_XyFCfaBZYL
X-Authority-Analysis: v=2.4 cv=DoZmPm/+ c=1 sm=1 tr=0 ts=6a311935 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=hoFbmsMDQYFultheuLUA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: J8LWwFoh5wv4lNX1UvRNW_XyFCfaBZYL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA5NiBTYWx0ZWRfX9PmjfzCKIBIx
 CbIBe0c7zWNdfbFMev/4HQOYK8Mz5ItJUqChifF7HjkEuQjkQtCqQHWj7nEEWcznYo/YPo4X8lx
 5Qabbc3w4KqVPYPnC5/NG17Rsrvt2ePKx/x0CSIeDGFQpHAhUKB6vlfFywbdA2LV8CQIxMwBkUw
 JhpxGsnydjjgdb5tQxrj8oV85YWahXxMiH9394XhWYAU/o2sEytBkabV7ZJLblUe3ZgWJqjYHs+
 xQIqaD6La+87dNbOYWbEMKQ5M6Mv2XkdR5/kHhKIlz9RebDpW8uxfpMcJql0LKooiGN61gLbUKj
 OEenutDdsgq11sInsiXwTBS/i0yJNP8dzHyftXHobPsIVUqblx2YtSDUbZ52KqkbzRdRfodFVIf
 UQPa1ilbpVPgRKSyd/EZMJznuMlceo6U6+D+vy7WJJSubdb5Gffe4l0s1ZMlLAMwV/m/BFhRdGp
 LvNXeJG81/7WFbJTZ7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160096
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



On 6/16/2026 8:41 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 15, 2026 at 04:21:14PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/12/2026 2:57 AM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 10, 2026 at 05:33:53PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> Whenever virtual channel slot allocation changes, the DP
>>>> source must send the action control trigger sequence to notify
>>>> the sink about the same. This would be applicable during the
>>>> start and stop of the pixel stream. Add the infrastructure
>>>> to be able to send ACT packets for the DP controller when
>>>> operating in MST mode.
>>>>
>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.c    | 43 +++++++++++++++++++++++++++++++++++--
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 ++-
>>>>    drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>>>>    drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>>>    drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
>>>>    5 files changed, 48 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> index 1109b2df21be..6f25145ef214 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> @@ -143,6 +143,7 @@ struct msm_dp_ctrl_private {
>>>>    	bool core_clks_on;
>>>>    	bool link_clks_on;
>>>>    	bool stream_clks_on[DP_STREAM_MAX];
>>>> +	bool mst_active;
>>>>    };
>>>>    static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
>>>> @@ -228,6 +229,32 @@ static int msm_dp_aux_link_configure(struct drm_dp_aux *aux,
>>>>    	return err;
>>>>    }
>>>> +int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
>>>> +{
>>>> +	struct msm_dp_ctrl_private *ctrl;
>>>> +	bool act_complete;
>>>> +
>>>> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>>>> +
>>>> +	if (!ctrl->mst_active)
>>>> +		return 0;
>>>> +
>>>> +	msm_dp_write_link(ctrl, 0, REG_DP_MST_ACT, 0x1);
>>>> +	/* make sure ACT signal is performed */
>>>> +	wmb();
>>>> +
>>>> +	msleep(20); /* needs 1 frame time */
>>>
>>> 20 ms is 50fps. What if we have 30 or 25 fps?
>>>
>> This hasn’t been considered yet. Do we need to change this to wait based on
>> the per-frame duration of the mode?
> 
> I don't know. You wrote that we wait for 1 frame here. Why?
> 
The one-frame delay here is inherited from the downstream code.
IPCAT describes it as: ‘When written to 1, a sequence of 4 ACT headers 
will be sent at the earliest possible time. The field will be cleared by 
HW after the 4 ACTs are sent, which then triggers the READY_FOR_VIDEO 
interrupt.’
So to cover the worst-case scenario, we chose one frame. Please correct 
me if i'm wrong.
> 

