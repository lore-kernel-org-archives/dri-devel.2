Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F65CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1950210E2E2;
	Mon, 15 Jun 2026 09:02:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6cHb2o2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UsSmWc66";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A77710E300
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 09:02:35 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F8r1Dr2211373
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 09:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8Cc4D/6k3H0E0CITsdFqF/FNnfsipdjLFJuu35eAJpM=; b=Y6cHb2o2fCuKJbl+
 axs0yLnX/NWVtHNyvAsyxF8I5rEGDvtdg4ZYezbKpX06xQdrJg6EqUjLCr7rKu6R
 nuk/erGsQWK5GDT0WEz21aMKGzUiC1lIhHO6JqnCXW5hKhTJJ4qE8LlbdE5GsxBY
 iDW9od0ChadxO1uORdCjkjBb/nnPfQ+54xd2Pp1dOo2UYoQKbA9irTDrCJYWy/+6
 t8jJkGZtqWtasvXBUAqoI7P/TA11Kgj9YpUkoRPHI/P1x3/0/frUgeRNZmPrbGwB
 UG9mPHOVXMN8B0fdGZDIhFsVIRDmwnbZW6QPP9pi2FiQzds+8zixrw5l+fvBhhqw
 qpGQxg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete98019n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 09:02:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36bbdcf36f0so2508850a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781514154; x=1782118954;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Cc4D/6k3H0E0CITsdFqF/FNnfsipdjLFJuu35eAJpM=;
 b=UsSmWc66cKPwq5kX3VwOfaL7yHLoB4gInXI0cqd+NPH9kvVSDIYBUlLRdZViDgwZtC
 jyfTm8TuOEA5AgU0lMHNfZvHPPSp9PESGDt20PXDP8+kn07E7woF/R1muM8m5l+i6rjO
 liCGyenAMgD4KGESeMBK4sKfuKVpsxqF/alAcw5f5qC2tyJm0QHel6WuEfLGuwgz3Yg/
 Q1akCTFYBc2oRb9gbMRLaWeVGMxiZuJgiT1eyDYezCIsUfTgYBTs5mn2IbSp2YsJdTvV
 ny67y99A3rgd6ypxkYd3BmxJjBdwpNLBqkGpvtpUmAntOcRLnkGn1M8OAyriLfGIfjTM
 z/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781514154; x=1782118954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Cc4D/6k3H0E0CITsdFqF/FNnfsipdjLFJuu35eAJpM=;
 b=XQ4LIV0DdfTgEGhIuKIa8opvOC8z+CeGROLJ0uT6kXEyxopJLVTtmwwvd+R0/lSjup
 ADYT2LmZdhXTaiVtsrteYQX71GIyzYFWBfyiKmOQOvIwEADFnE9i0OpYlhXyqhiexS9d
 1joCBBdRksbw+GUV5j3HIORpnuZ0+YaBvRpengEHMrI2PW2mrqKp5n2aiZYdsWNXSr6A
 idE+KQRSD1y4wRSt0Jd+RHSvv+CLgOG91tlrw+qgHTeU3+g4ZjsjskQ3LmRG2oaWWaeR
 fNlqubrlNk+vuZu2Nh+OOnrSPKn8fueZskz4O/1JegVdU06JFHd9NwJAQkpZ3AXGBeHD
 rpSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8F/RvOdFDYW/Y3JUX51KDfiQL/A6liwKwKMbu1gZSZZIvJ9x0mf2kWHi3/gOSP4JdKTHaowRbyn0A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6Z7xSM2J4q1qCv0ghwnj+BVzcR2A+Zk5ghIZ9kgsYKccE2iTg
 KsaYbiKlnap4ozkjKj5lW8jx9YMllpWkdBxblhKFwKPkC/6cwRR5P/6AA6XZJabKNufwPB5BJf1
 UMjZrKBBeick2axaPk67cVGpvpnIzRCMMZDP4xRgg+AaLcqcbER6y9zz7NRRLl0DJBjfuW54=
X-Gm-Gg: Acq92OFLTe6+axqXM1TkKS5jzbWjsBnYclXiCU9RB45givueuBm1f6PcTX8JFti0jYi
 PbKPJ3H49e47X0ZdL+usYiyV9/SAmojDboQwTVYmyJh+Dp6E5mGWRpKns5Q/pqnVnAWN/AxtCn4
 TXSAaVj+V3pOByt0UbkP3qsJX68SwjK0I5G6ITluhQH9BJr58iUGSgWRta67EcucNOtGUuI+9eA
 0HnRWE6drJI2TuboukslZvwseQwEJVxTDJF3Jyef9NLvF3ZiY1tlkG/eceRMJKLHI3eMykhbNxU
 jNeLJQP6Kv1HtLZ0cIlczmBNrL1h4spb+HdWAY+KN1zsVSTWqM6zGh2d6KR9KB8rfJ7THBCEoTN
 bqoefjKsTlvWeIDJ1gk802cc1BerS12nfOrAe1fT4u6K2OCvaXs6pDe9AmuyMS5Utux+r/AM42Q
 GPTxExs7XZYUSavByjZw==
X-Received: by 2002:a17:90b:3c90:b0:36d:633a:c7fc with SMTP id
 98e67ed59e1d1-37a1fc2a147mr9020643a91.10.1781514153612; 
 Mon, 15 Jun 2026 02:02:33 -0700 (PDT)
X-Received: by 2002:a17:90b:3c90:b0:36d:633a:c7fc with SMTP id
 98e67ed59e1d1-37a1fc2a147mr9020553a91.10.1781514153018; 
 Mon, 15 Jun 2026 02:02:33 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37a2678375fsm11760041a91.17.2026.06.15.02.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 02:02:32 -0700 (PDT)
Message-ID: <1fe8d286-7182-49ed-b6fc-dfa3766f851a@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 17:02:27 +0800
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
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <32jtwnkusxultvsgvnalrvccfkcyk7744yf4d42pqm7wudysvt@l4pnrzfxh2f4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a2fbfaa cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=tepjUtBTXmVVZiRr_ggA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: gK7eqSTFqUIWIbsdLSTpHY25CqKbu_JO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5NCBTYWx0ZWRfX+2h0+K6pnGO4
 UyYB+5rO+yLVmr2NLH7LDa6Gy+qyaneElchOu0wPQ8TGd25EZFmtBnKgY5njkX0MIAZL16RHb6v
 IeX6J6HrlLTcu6p7oS15kwNFu09mV9k=
X-Proofpoint-ORIG-GUID: gK7eqSTFqUIWIbsdLSTpHY25CqKbu_JO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5NCBTYWx0ZWRfXxbUnuE1a1B5k
 z9VISpJtPinLyN7VJmyCCFzL4AjOIATpobSYbRsTgF/mqAnCi9RtS1Q1sGHrPVU8Y4KxKtxETtg
 cw/7VfKhG6J5p1QzounjWrN6MkErWv+yaHfjx6qer+pgUjVG3nOmllP3KgZg+NO5Pm9VtMnG1vF
 GO5Lg2gU1O5NJUU4k8t/X+ghnKcKaWMgrGNz4KkKhR25iSnm1y20l1+EksN7hDlz7iqbZximtK6
 BBwWo50qW41mFfcBWoTuZWymkjaJhVV/vV+WjyN6cxUfzBy6jnhKpWAU0S21sD8fJLvVxbhQoUk
 2hhRBAyDyFnVN0/LIYgtA8vxl26fElMYPCP+Gp3w3wVmqI6VL9ykfJTDuzOOZk+4BhvRo9Dm9Cs
 /xIRN6OsnXDo4onSiAKwql5fDdmNwAE0Nz4GytDI66r0u/ODMoL2RGvEGucXvkZsSI8oWfNyoOZ
 Lw14kSyb7Z4lScHDuHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150094
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



On 4/12/2026 8:15 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:34:04PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> If the DP controller is capable of supporting multiple streams
>> then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
>> DPCD register to enable MST mode.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 57 ++++++++++++++++++++++++++++++++-----
>>   1 file changed, 50 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 8ae690ce2b9f..abf26951819a 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/string_choices.h>
>>   #include <drm/display/drm_dp_aux_bus.h>
>>   #include <drm/display/drm_hdmi_audio_helper.h>
>> +#include <drm/display/drm_dp_mst_helper.h>
>>   #include <drm/drm_edid.h>
>>   
>>   #include "msm_drv.h"
>> @@ -270,6 +271,40 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
>>   	return lttpr_count;
>>   }
>>   
>> +static void msm_dp_display_mst_init(struct msm_dp_display_private *dp)
>> +{
>> +	const unsigned long clear_mstm_ctrl_timeout_us = 100000;
>> +	u8 old_mstm_ctrl;
>> +	struct msm_dp *msm_dp = &dp->msm_dp_display;
>> +	int ret;
>> +
>> +	/* clear sink MST state */
>> +	drm_dp_dpcd_read_byte(dp->aux, DP_MSTM_CTRL, &old_mstm_ctrl);
>> +
>> +	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL, 0);
>> +	if (ret < 0) {
>> +		DRM_ERROR("failed to clear DP_MSTM_CTRL, ret=%d\n", ret);
>> +		return;
>> +	}
>> +
>> +	/* add extra delay if MST old state is on*/
>> +	if (old_mstm_ctrl) {
>> +		drm_dbg_dp(dp->drm_dev, "wait %luus to set DP_MSTM_CTRL set 0\n",
>> +			   clear_mstm_ctrl_timeout_us);
>> +		usleep_range(clear_mstm_ctrl_timeout_us,
>> +			     clear_mstm_ctrl_timeout_us + 1000);
> 
> For 100 ms you should be using msleep() instead. But where is that
> timeout coming from?
> 
Will switch to msleep(100).

The 100 ms is an empirical workaround carried over from downstream — 
some sinks don't exit MST immediately after writing DP_MSTM_CTRL = 0, 
and re-enabling MST too quickly broke topology probe. It's not a DP spec 
requirement, and other drivers (drm_dp_mst core, i915, amdgpu, nouveau) 
don't have an equivalent delay.

>> +	}
>> +
>> +	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL,
>> +				     DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
> 
> Isn't it too early to enable MST? (I don't remember this part of the
> standard).
> 
No, this follows the DP 1.4a MST spec. DP_MSTM_CTRL must be set before 
topology discovery. Topology discovery uses AUX sideband messages, which 
don’t require link training.
So we enable MST first, then discover topology, and only do link 
training and payload allocation later in atomic_enable().
>> +	if (ret < 0) {
>> +		DRM_ERROR("sink MST enablement failed\n");
>> +		return;
>> +	}
>> +
>> +	msm_dp->mst_active = true;
>> +}
>> +
>>   static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>   {
>>   	struct drm_connector *connector = dp->msm_dp_display.connector;
>> @@ -288,14 +323,19 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>   	if (rc)
>>   		goto end;
>>   
>> -	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
>> -	drm_edid_connector_update(connector, drm_edid);
>> +	if (!(dp->max_stream > 1) || !drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd)) {
>> +		drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
>> +		drm_edid_connector_update(connector, drm_edid);
>>   
>> -	if (!drm_edid) {
>> -		DRM_ERROR("panel edid read failed\n");
>> -		/* check edid read fail is due to unplug */
>> -		if (!msm_dp_aux_is_link_connected(dp->aux))
>> -			return -ETIMEDOUT;
>> +		if (!drm_edid) {
>> +			DRM_ERROR("panel edid read failed\n");
>> +			/* check edid read fail is due to unplug */
>> +			if (!msm_dp_aux_is_link_connected(dp->aux))
>> +				return -ETIMEDOUT;
>> +		}
>> +
>> +		if (rc)
>> +			goto end;
>>   	}
>>   
>>   	msm_dp_link_process_request(dp->link);
>> @@ -317,6 +357,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>   	 */
>>   	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>>   
>> +	if (dp->max_stream > 1 && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
>> +		msm_dp_display_mst_init(dp);
>> +
>>   	msm_dp_link_reset_phy_params_vx_px(dp->link);
>>   
>>   end:
>>
>> -- 
>> 2.43.0
>>
> 

