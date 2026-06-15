Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD5FCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C7A10E2A0;
	Mon, 15 Jun 2026 08:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aRvS9J3o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TavVSgF5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAA7710E2A5
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:21:23 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6Lr0M3853904
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jh9qQ64vhdd+i5nKcCF5rY6x3m4t/2guKy8l59qHNtM=; b=aRvS9J3odn3Uqoyc
 kyPG9BbDc+rWDyNv8m3MxrYFLafuxqnDoVo2HQ9eEshNwO5ukk8O9kWJuV/P6YMt
 5tGf+Tg7HsI4LkIZU1eN7O4PiKFKrl1tfC157CMtW6voxPaYB4aQKlKZ/WcQZw0T
 nfYMbQTM3xJXHba3/adpXUkAbzrT1VO8icnoH8y/0di6u3AV5S1r+YzPvN3hCMlH
 5QGrcxI+Hq8OaVbuqwddCqsbLw897jjYU4XW+AngBHbfD0BdeFWHtna9Tt33rrwT
 zTHT5Bo66I7JusHqLUF1OU81ikxdXAlat6nomjfJ6CB1X61eCCsG8vLCF7ORMDIm
 I2jeCw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7gxerw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:21:22 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8423970cb30so2162713b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781511682; x=1782116482;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jh9qQ64vhdd+i5nKcCF5rY6x3m4t/2guKy8l59qHNtM=;
 b=TavVSgF5sbE3w6zxhzAMeUDfYFCVlqK7oitganUbpckJgFnaY7aqAk680/7zxNKCfZ
 11JnSztr0jL6SJS0qbYos6RRQQagfdcXwfRVrb2L99ebyMbh+yMCp3gyEqoFievkkNx0
 3KNjvhDdCN9TuBsU7Z4vSEhancscXcj0sCXhO69YPCSRyvLMfXO190YEmioTvOgT5+21
 aC6i42AgfIbSlbuWXK+cH3/cBebDzGt/4aa2u0u7fd/8rhGC5M3+0Ppv3gXuzxr4wqsQ
 acpMkg9uQTkfS61aC8pSbsIee7vxESzQbwqc0LZjTAB6kfI47MaaPwjOQFp356krHj2x
 HtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781511682; x=1782116482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jh9qQ64vhdd+i5nKcCF5rY6x3m4t/2guKy8l59qHNtM=;
 b=XYeqP/rr5uiUO/vVaponmw548WPJaRx7+CwBGhIR151reeqkoE6BECecrtQ3Yllas8
 eX96AwFwJPBdEHRCrGhJhma2mc0tLzAjxLfj/kMI0u41VTMT07qvEq1Fz+dptDwGt2+C
 0D88Fd/RA3R/s5YfGYU9cqnclWqH/ws6oql21wfWDojtWSMMW/rnlnEMpqnvxGSsKcZQ
 fs40pEDUVyfhf+A/pxFTGmmgvnKFUqrELcw0j78He0PkLFqYyjI6uSZhyZ4GgJWCsHVH
 O/Gf4AzwNCdfkeDNr6oLGXO3VNeC7ObjS5DQFES9QGYH0fLEhR6zvOeDBy4F33IzkWt5
 YakQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oM+kpeka1u4sJSplIMM5yMRkEKKE1b/PJpnDbuKeCfQPE+pQNpla3Ig5wIlqCRDoGBBYd2C34y48=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyb7GYrQux542LlUTaznGEaZCt7WBD0c1USPbtAnHHf+gDr+03C
 vbf5WYcm/oHNtWrfqe5+IXDDpnHcFCIwLrM8r1H4mUqgbmBrtdpRNj4lXbfSD6rxwCAe38GWWTX
 JRYk67tQs/dnvkCY9Go6mmGRRY9BaQZ67ybdqIebkQV9DVhjSX+tzJ3xORgcCBPZCgs3XJJ8=
X-Gm-Gg: Acq92OFgha6Y9eoxw82JS4ovu6MYuac5hOIoTOJU8x1n91PotfhPeaoQtQS7bDxiidG
 WAj5PVNpC2wdVuIyulthVCP5qkUyaSg7XwDXWOpCSsbDGOhAbjzPiHqeD/XUDAShJC8zywH+wZI
 2jUerWuNCA6zfUGcqvw6qX9cClvjMRwKN+ftlfJswyscjyaqjXXwcsnNObHqrEk9vnNrELnezwf
 Fn37VtCgYGDs8sRFm04NwofzvXkSE5eL3XSO3xx381+M6uiSbbd3uo8a1epkJcRcNwfV85DoKIv
 nfN0Ghxg772xQZ94wDLKVGWNT8/Ey9AQoRZ9cnP64P9VzlQ8a0q3Kw5x9QS6L+iPL2bLGxBUXVP
 dGQCk1pQCbjZFdFdaLmsvgiecG68NC9l/LnhfmsP4uM4N2B6p/HhFcyZiRIdXnLtUemHIZ1l0TV
 92aG2c2Eu637Qugvj+gA==
X-Received: by 2002:a05:6a00:3e0b:b0:842:6849:2180 with SMTP id
 d2e1a72fcca58-844e1a7f928mr10159628b3a.37.1781511681652; 
 Mon, 15 Jun 2026 01:21:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e0b:b0:842:6849:2180 with SMTP id
 d2e1a72fcca58-844e1a7f928mr10159587b3a.37.1781511681154; 
 Mon, 15 Jun 2026 01:21:21 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434acf4b5csm11376122b3a.23.2026.06.15.01.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 01:21:20 -0700 (PDT)
Message-ID: <49131a73-f60e-4296-a6d4-5ff59331a9dd@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 16:21:14 +0800
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
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <6jkqen322yklhb4zzoj2kcgwayhcqm3mhnbrkgimr7zubwewao@gmuopu6uxakq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA4NiBTYWx0ZWRfX4AT+/wwwlgQb
 9OsViKnjUfm4oCeMzMqpHkGKVbChaKEdzWvg8uGjDYL0wqsWbyONJLN+xj4zb44pNb5Y0Hux+o5
 l2/rsjCQXHPlchZBmPHvJIayYKlYU6k=
X-Authority-Analysis: v=2.4 cv=fLYJG5ae c=1 sm=1 tr=0 ts=6a2fb602 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=aNidHKw51tL1cJfPzJcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA4NiBTYWx0ZWRfX0kI1MYMmM984
 qzbuztLEfjw0NLy/GSUAidfhwZAmswmnV4R82WTQjDaS4DLT9BMzIGlPyMdmTLh7sI8xfj944JP
 t5/1tJYgvXuet38m+v9meFEDK/w+ffqkNo8QrBv0XaNxcD2gJ4lYtQtuXYh/T9d78Y7rbmLVMXB
 WFhYK7cYuojD2Cop61xPBtFbMzpUlmCNQf0oz0OYI+T0iPTkQzJ44rVN1pPZH32spXq6Y7CVuQG
 FPfxq+O93bTk1lYFquGUL6GSvMLKwwRMrbFWPEn+4UoOGz/wCVSDs5NBke7gjOzI7wJnU2VVpmz
 Xs3dmdi2xZSXKsQX0FlfY3uUTjMddOugxWHjLAOKuR052xAq/pqjff0piZX5ZDo9pWPtYRHVQP+
 e5dX2EywRF9ynsA24fQBUekc245665KOBmU7w0L2ugbA0JEH1eljRS8c70hVfJTn8iAceolwVSG
 4zxhRYGt2HEVXJWmBHQ==
X-Proofpoint-GUID: nQXyNTDMzfkTNEoHK5MMp_HVWrC3RW_3
X-Proofpoint-ORIG-GUID: nQXyNTDMzfkTNEoHK5MMp_HVWrC3RW_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150086
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



On 4/12/2026 2:57 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:33:53PM +0800, Yongxing Mou wrote:
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
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 43 +++++++++++++++++++++++++++++++++++--
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 ++-
>>   drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>   drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
>>   5 files changed, 48 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 1109b2df21be..6f25145ef214 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -143,6 +143,7 @@ struct msm_dp_ctrl_private {
>>   	bool core_clks_on;
>>   	bool link_clks_on;
>>   	bool stream_clks_on[DP_STREAM_MAX];
>> +	bool mst_active;
>>   };
>>   
>>   static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
>> @@ -228,6 +229,32 @@ static int msm_dp_aux_link_configure(struct drm_dp_aux *aux,
>>   	return err;
>>   }
>>   
>> +int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
>> +{
>> +	struct msm_dp_ctrl_private *ctrl;
>> +	bool act_complete;
>> +
>> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>> +
>> +	if (!ctrl->mst_active)
>> +		return 0;
>> +
>> +	msm_dp_write_link(ctrl, 0, REG_DP_MST_ACT, 0x1);
>> +	/* make sure ACT signal is performed */
>> +	wmb();
>> +
>> +	msleep(20); /* needs 1 frame time */
> 
> 20 ms is 50fps. What if we have 30 or 25 fps?
> 
This hasn’t been considered yet. Do we need to change this to wait based 
on the per-frame duration of the mode?
>> +
>> +	act_complete = msm_dp_read_link(ctrl, 0, REG_DP_MST_ACT);
>> +
> 
> Nit: drop empty line.
> 
Got it.
>> +	if (!act_complete) {
>> +		drm_dbg_dp(ctrl->drm_dev, "MST ACT trigger complete failed\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * NOTE: resetting DP controller will also clear any pending HPD related interrupts
>>    */
>> @@ -2081,6 +2108,10 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
>>   
>>   	msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>>   
>> +	ret = msm_dp_ctrl_mst_send_act(&ctrl->msm_dp_ctrl);
>> +	if (ret)
>> +		return ret;
>> +
>>   	ret = msm_dp_ctrl_wait4video_ready(ctrl);
>>   end:
>>   	return ret;
>> @@ -2277,7 +2308,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>>   	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, ctrl->panel->stream_id);
>>   	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl);
>>   
>> -	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl);
>> +	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, false);
>>   	if (ret) {
>>   		DRM_ERROR("failed to enable DP link controller\n");
>>   		return ret;
>> @@ -2357,7 +2388,7 @@ static bool msm_dp_ctrl_channel_eq_ok(struct msm_dp_ctrl_private *ctrl)
>>   	return drm_dp_channel_eq_ok(link_status, num_lanes);
>>   }
>>   
>> -int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
>> +int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active)
>>   {
>>   	int rc = 0;
>>   	struct msm_dp_ctrl_private *ctrl;
>> @@ -2375,6 +2406,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
>>   
>>   	rate = ctrl->panel->link_info.rate;
>>   	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
>> +	ctrl->mst_active = mst_active;
> 
> Should it be set to active only when you actually activate the MST?
> 
This can be moved into on_stream.
>>   
>>   	msm_dp_ctrl_core_clk_enable(&ctrl->msm_dp_ctrl);
>>   
>> @@ -2654,6 +2686,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>>   
>>   	msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>>   
> 
> I'd rather have the `if mst_active` here rather than in the function.
> 
Got it.
>> +	ret = msm_dp_ctrl_mst_send_act(msm_dp_ctrl);
>> +	if (ret)
>> +		return ret;
>> +
>>   	ret = msm_dp_ctrl_wait4video_ready(ctrl);
>>   	if (ret)
>>   		return ret;
>> @@ -2693,6 +2729,8 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
>>   
>>   	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
>>   
>> +	ctrl->mst_active = false;
>> +
>>   	dev_pm_opp_set_rate(ctrl->dev, 0);
>>   	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
>>   
>> @@ -2876,6 +2914,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
>>   	ctrl->link_base = link_base;
>>   	ctrl->mst2link_base = mst2link_base;
>>   	ctrl->mst3link_base = mst3link_base;
>> +	ctrl->mst_active = false;
>>   
>>   	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl, max_stream);
>>   	if (ret) {
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> index e72d501ac1ce..f82fd96e412a 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> @@ -16,7 +16,7 @@ struct msm_dp_ctrl {
>>   
>>   struct phy;
>>   
>> -int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
>> +int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active);
>>   int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
>>   int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
>>   void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
>> @@ -51,4 +51,5 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>>   
>>   void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
>>   int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
>> +int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl);
>>   #endif /* _DP_CTRL_H_ */
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index a924fbd825f7..80bb5fc4003f 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -660,7 +660,7 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
>>   		force_link_train = true;
>>   	}
>>   
>> -	rc = msm_dp_ctrl_on_link(dp->ctrl);
>> +	rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
>>   	if (rc)
>>   		DRM_ERROR("Failed link training (rc=%d)\n", rc);
>>   	// TODO: schedule drm_connector_set_link_status_property()
>> @@ -1547,6 +1547,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
>>   	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>>   
>>   	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
>> +	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl);
>>   }
>>   
>>   static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index b0cfdf215970..fdbe6e4871d9 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -19,6 +19,7 @@ struct msm_dp {
>>   	struct drm_bridge *bridge;
>>   	bool audio_enabled;
>>   	bool power_on;
>> +	bool mst_active;
>>   	unsigned int connector_type;
>>   	bool is_edp;
>>   
>> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
>> index 1c2d3d8d029d..237325d52dbd 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
>> @@ -156,6 +156,8 @@
>>   #define DP_CONFIGURATION_CTRL_BPC_SHIFT		(0x08)
>>   #define DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT	(0x0D)
>>   
>> +#define REG_DP_MST_ACT				(0x00000500)
>> +
>>   #define REG_DP_SOFTWARE_MVID			(0x00000010)
>>   #define REG_DP_SOFTWARE_NVID			(0x00000018)
>>   #define REG_DP_TOTAL_HOR_VER			(0x0000001C)
>>
>> -- 
>> 2.43.0
>>
> 

