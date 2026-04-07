Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A38FFB5188
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 04:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5B510E324;
	Tue,  7 Apr 2026 04:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rs6D764q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XNnbc9cG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E731010E324
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 04:19:59 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LSBdB2327732
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 04:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lMjcYHeMWpehtP2XPeaMvXYC926mGw75Z/H7Po5iCfU=; b=Rs6D764q3zFbWC7O
 EeHPySPt+xmUInC60QL6vjdjyrF5Haccw7HX6A3NH85Sc9LHh4ARTlrpFRJPnBbV
 XoMXYdsCVkSBp/tzMU6gunt5d8xN4RcVQob7LXoGJ0UcdJ+aW4qi+DaXZOLgv6b9
 u7YOcE/DEmw+KnQtfCTDUA8qtc1Wm3JcuTmb5nIQoB77zY5CPOUeml9awuDurNZM
 7IaAeOP00ui9AoLqnYTn4TWg8ZmycZ+oA5jDGQzT1YLOSZDIfTCEzRNqLXsprk82
 CeVbkEGvt1iSOIAi7zj33h4e3tJEMbtXoRkqtopg546lvNCi9J7IaGqrWECH9gNY
 ii0qJg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcms4ryn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 04:19:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2471321dcso132647585ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 21:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775535598; x=1776140398;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lMjcYHeMWpehtP2XPeaMvXYC926mGw75Z/H7Po5iCfU=;
 b=XNnbc9cGb1nLdwVLVh2Ulxrdv1SVKT07gPPdmOhDYC2M6yTg2N/qXy7xhidtePYbXc
 BWtstYaMfIqLPBUiCgk9ZRfe7yEtw6OxoPs1Sp36EDzt4dry6In3f3WI/25Hth1jGT8Y
 VCW5Zx2bw9ekzBW2ieRrllRVZtqNDqdw4jVswjehIF+X1MmubFkCxSwXbHTJBKuJqk0t
 SCQXAkbCMpS5LkVwHKC4dJB9B7dca8GtvtSebIowiMKwwjx0Ia1c23L4qWh2nCf8QEIz
 NWH69+j09+uJwHSlL91mZB5kYTt0FNjj9lHxBoRbvD7jC82yiA8pI7bXSZWRd8hXt7O/
 o5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775535598; x=1776140398;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lMjcYHeMWpehtP2XPeaMvXYC926mGw75Z/H7Po5iCfU=;
 b=WmCxYWbqPe9j7kfiWW2aRZ1UsecMkVjDaDBQSReW6eUnCEJYKo78ROCvFHQrnbcypU
 E7yNPiE6erasw0jipbO4fov+DCIoaQT5zYfmb1/jygg9O9SsvCp7Hv8EJHnZK4a9qfmo
 i3zSHa813aI5CBHu7Z1CKaoNoFkoXWvURB+K42Zj5Tto2w7E3JmmD5mvK+IynCsYBYUG
 jYf6Bgtnx4RtzAXzqMwQeBMdoMgcZlNasE6tb80BbNPVzlq7rsEtI/D5ZCdXsiA+ZN+R
 gtPj0kxMT7YkMiFMAQGyPFMDCn6SW1pdHZ03z8BALOVBsrltwJXaw7wxmUPGGTMmId6N
 MSag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOtKO2UsyIWyYIIPWZOC4UIzCxvW2ATufzcwB9z5qD7HYu1hClBoOKUpJGbqxBWKBy8/Vo703TQT8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydsR7VsxLT/yfaUZiCIzVqnw9XiboqQrqcL5Unl54GfflOb/xI
 HEU8iYiaBWiu2sKdpS6bS2lO6YROq1odDGNegsrz6U2US7uKg3ZbrSkqdtVtGq3O30+OzHmqw4J
 qGU1bq+XGY98twL5zdvdYE2oQOoSr2Y1qIfJMLkKey4FMgiJfjH+Mrv5Ylw8KajiDku85X6g=
X-Gm-Gg: AeBDieuFoiRDPPWRWJNdsnu3+9OYw2adzDYH5dyNgmkQmm+Y/pZndJ/zrmHd259GAer
 4ASlNDzzzU9SDeHm5+7/FB3IzsisriigZ5ZmUU0Ub1RkEGkWN8Pd6vJs8nnvLnJDdVJT3dj8PWb
 Qr83Y/zO/RakdHc0ldfqTn3KkwG4EP6f8+ZtQN7+pdnORlI6sfmn2QjlsRP/GrpmEUvU/T8i17G
 1T3QDwaMNwzS9/qd4rDrnablK3+NvYEweq/52KvsLvc8JfAHgHionvHVopcCltqgkZCf9cBJr5s
 ruIOrfnFmzOc7gRTPimuTH7lqWZRa8Bz0T430OdxFdv1qALnJd4F9JANS7oIvf9DL0cgdu6V9mL
 Ubi8i9K8kbh6Cnpz4cFra82H+3/NILgs6lu92A6gIwDGm8HXGTlWwKrbdbe9KDo002o7heQPI+U
 olH3ZyttZAZvca0VRB4g==
X-Received: by 2002:a17:903:b0e:b0:2b2:52af:52b8 with SMTP id
 d9443c01a7336-2b28184a5cfmr157749145ad.11.1775535598484; 
 Mon, 06 Apr 2026 21:19:58 -0700 (PDT)
X-Received: by 2002:a17:903:b0e:b0:2b2:52af:52b8 with SMTP id
 d9443c01a7336-2b28184a5cfmr157747725ad.11.1775535595386; 
 Mon, 06 Apr 2026 21:19:55 -0700 (PDT)
Received: from [10.133.33.129] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbcafsm155569525ad.77.2026.04.06.21.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 21:19:55 -0700 (PDT)
Message-ID: <f08a3a89-4a02-44a8-a221-0d2d451d8536@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 12:19:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/38] drm/msm/dp: add an API to initialize MST on sink
 side
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
 <20250825-msm-dp-mst-v3-26-01faacfcdedd@oss.qualcomm.com>
 <4u5bt5y4suecanvxni2fnljdzrxnkjrg2dgkwzpj4pztvyoef3@nopu6m7w543n>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <4u5bt5y4suecanvxni2fnljdzrxnkjrg2dgkwzpj4pztvyoef3@nopu6m7w543n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAzNyBTYWx0ZWRfXzuTMo0dDqIKb
 jrcsiwoEaSdzZ7i3x9OGE0n77qDYqQI+02xXs1yhsQ3FGEm/bG1xgQuYVNoCWVz4A7TwuEXX4XA
 wRLr9VYqbDvP194xXUp+p74VqzxgsNquf4ZqvXR92CTeuEddqyN5CkCaA1n2SDeYNqSHhaAuhgZ
 HDzXE4Cw/nPXKJxiHFgiIxXDCrRUTZ+vGx/05QL3BMppUQN9nBZ+Fbqy4fwiz23owBIeSIr2ynt
 rkMnus7zEMjea5Sf9qjqjNdYwDmIHtM6FBxddaGxGAK35CA5Z1j1o47sl9AiOtiTmTc7opTZYee
 Bl0M2L44bapb2BeKae6khVBk/6GZCzv2aiwShoxI7XXhREOxYoNuF1nLfKk2UDsnsx8KMgg6YbT
 YYTNrqOCEUGT11c7Q6zFZoA2EIzf8wyQLzdhmyimi9m8nzDINXKNc6d3Az04HfyivOn+cWIZdct
 HTOG2X6uYcC9abl6avA==
X-Proofpoint-ORIG-GUID: tTjK3MKJHgkGnCVjKJReaWqnrk0oHKip
X-Authority-Analysis: v=2.4 cv=WNZPmHsR c=1 sm=1 tr=0 ts=69d485ef cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ZS1p3fY0zf-kPy3xB1AA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: tTjK3MKJHgkGnCVjKJReaWqnrk0oHKip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070037
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



On 8/26/2025 5:26 PM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:12PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> If the DP controller is capable of supporting multiple streams
>> then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
>> DPCD register to enable MST mode.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 55 ++++++++++++++++++++++++++++++-------
>>   1 file changed, 45 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index cb433103d439ac6b8089bdecf0ee6be35c914db1..84df34306fb557341bea288ea8c13b0c81b11919 100644
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
>> @@ -297,6 +298,35 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
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
>> +	/* clear sink mst state */
>> +	drm_dp_dpcd_readb(dp->aux, DP_MSTM_CTRL, &old_mstm_ctrl);
>> +	drm_dp_dpcd_writeb(dp->aux, DP_MSTM_CTRL, 0);
>> +
>> +	/* add extra delay if MST old state is on*/
>> +	if (old_mstm_ctrl) {
>> +		drm_dbg_dp(dp->drm_dev, "wait %luus to set DP_MSTM_CTRL set 0\n",
>> +			   clear_mstm_ctrl_timeout_us);
>> +		usleep_range(clear_mstm_ctrl_timeout_us,
>> +			     clear_mstm_ctrl_timeout_us + 1000);
>> +	}
>> +
>> +	ret = drm_dp_dpcd_writeb(dp->aux, DP_MSTM_CTRL,
>> +				 DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
>> +	if (ret < 0) {
> 
> I didn't catch this up in the previous patches. We have two sets of DPCD
> accessors: the older ones which can return error or the size of the data
> that was actually read / written (which might be less than the size of
> the buffer passed to the function) and newer ones, which return error or
> 0. drm_dp_dpcd_writeb() is from the first group, so if it was
> successful, it should be returning 1. It's all a pain to handle, so
> please start using newer accessors in your patches (the full conversion
> of the MSM driver is on my todo list, but it's intrusive, so was
> delaying it...).
> 
> TL;DR: inside your code please use drm_dp_dpcd_read_byte() /
> drm_dp_dpcd_write_byte() / drm_dp_dpcd_read_data() /
> drm_dp_dpcd_write_data().
> 
Thanks for point it. Will move to new APIs.
>> +		DRM_ERROR("sink mst enablement failed\n");
>> +		return;
>> +	}
>> +
>> +	msm_dp->mst_active = true;
>> +}
>> +
>>   static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>   {
>>   	struct drm_connector *connector = dp->msm_dp_display.connector;
>> @@ -315,18 +345,20 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>   	if (rc)
>>   		goto end;
>>   
>> -	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
>> -	drm_edid_connector_update(connector, drm_edid);
>> +	if (!dp->mst_supported || !drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd)) {
> 
> In several previous patches, the functions initializing MST can
> return an error, leaving the user with half-initialized MST. Are those
> errors a safety coding or do they have some real-use usecase? In the
> latter case, it would be nice to keep SST wokring if enabling MST fails.
> 
After plug in, MST will active when mst_active == true (DP_MST_EN 
programming succeeded). Before that point, any return will continue to 
keep the system in SST mode.
>> +		drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
>> +		drm_edid_connector_update(connector, drm_edid);
>>   
>> -	if (!drm_edid) {
>> -		DRM_ERROR("panel edid read failed\n");
>> -		/* check edid read fail is due to unplug */
>> -		if (!msm_dp_aux_is_link_connected(dp->aux))
>> -			return -ETIMEDOUT;
>> -	}
>> +		if (!drm_edid) {
>> +			DRM_ERROR("panel edid read failed\n");
>> +			/* check edid read fail is due to unplug */
>> +			if (!msm_dp_aux_is_link_connected(dp->aux))
>> +				return -ETIMEDOUT;
>> +		}
>>   
>> -	if (rc)
>> -		goto end;
>> +		if (rc)
>> +			goto end;
>> +	}
>>   
>>   	msm_dp_link_process_request(dp->link);
>>   
>> @@ -349,6 +381,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>   	 */
>>   	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>>   
>> +	if (dp->mst_supported && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
>> +		msm_dp_display_mst_init(dp);
>> +
>>   	msm_dp_link_reset_phy_params_vx_px(dp->link);
>>   
>>   	if (!dp->msm_dp_display.internal_hpd)
>>
>> -- 
>> 2.34.1
>>
> 

