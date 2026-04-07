Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FCAFB5180
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13D110E315;
	Tue,  7 Apr 2026 02:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TLFHy3vF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZmPIWdZQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D8510E312
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 02:38:11 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQwZV494121
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 02:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jxY0yV5+oNV02QxbphI8pejM9GESpyjwddOZocNniT8=; b=TLFHy3vFsI8G2Wze
 sN3yd7eF66G2DcXNKF2blrtbxDw/IIuo0qMiRH5X0rY8WK7sARfDNjsOjYPCOkZX
 BuMGOLSAJRlBHIwjqz5vEZRcLConkn1en2xCjvxd2N0WSgi5T/T1MnXXJbR2adoq
 tK9iR4pYmiC4DY8kkqPLJzHiXwnoMgTq11VGwbYcBarPjjV7UQ+agXTYStjwa3wJ
 4fpYN8kOkHoqgc7hffSTw9jVw174fJde9znJ3BnTYvDXZgGgyN+pL86uMiSYALMg
 f2iPeCIGNXz+nBLsnz0YXYnd3XK3oTEeR1ZH+3mYqzPJH25wkF1pELHt06/Bb7NZ
 AYgXOQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8rp4u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:38:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b241be0126so126153395ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 19:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775529491; x=1776134291;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jxY0yV5+oNV02QxbphI8pejM9GESpyjwddOZocNniT8=;
 b=ZmPIWdZQ/dacyMhIqISOivFr1U5pFc/r3G2+jZpy2lYrDuM8fvuo7sDg8eP2Jqzigv
 8d5h8WaDIOtJXkvhcZpZCNN++hOxe7w0m/zSWfhjoHDozPyzRnR/hCt0LOxbepwbH3Wo
 d3LGzFZ69htb7aLMtwUNlxggIRV0myPnvo/o78fW27Z2u5xcPZYy+XBuAkrCsfTJuUKI
 HcNwY8qqNKuhLk7Mv1d0iUtf40tTxWldpa752s9fY1FWpxAbTyqRwBw7D4/iLD7HT7KW
 oq6P5UX0vHs9u8UqutYEwk6aZd3CxSI4FalTCrtCuteEJ8GXVxQOxeGsiOuP3hfkHRl2
 fQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775529491; x=1776134291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jxY0yV5+oNV02QxbphI8pejM9GESpyjwddOZocNniT8=;
 b=DH35LmPzqZFbqigWydP3f6DzgZpTg0ECtpGvdodrvztk1NjThyHvZmOlbV+LmZMgar
 ctCyuml6OZp6slS9CW0okb0paLhJwgrLwvWz/ezMmekCle7RqCTRmsFAmpQq2x1ETfhK
 k7ZEyq5zdGqM1/jWPd7uurHbgt4s70ywwx8mhzWR8TgEoKURuuL6qKd75qZYuwB8+Av5
 UaG4DzHXhKH5CcCCCXL0Cm2oVBID4u/G/zQepBHSDy1VoFWjwEA36SKTft516IsnAFfk
 zvWFVaNHS/g/z47J2CqytPXDM50A0JxkIhW/xnr5STuCJ0fUBEBZvKGG85iJEQyixnb+
 /CTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUazVZpYclXHGxTtrlP61+IiTsDImkTQfOxtoRK6ig1HliMsp+ygyE9gJ0XcU8aytTNncMVZfieIOw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbUogH7WfatkFbiE9av7HQ8xcmv3HYed6KquDJPlwO+Lq9t1VS
 douCbLo+KEcjLWRxSbHQMqtko3qWgap8VmBfY6e6PIbtbBntsmGAr6Lpb1Vjw9eETH+cV0f7BCP
 IERz9jOdku6bF9y2pWaY4fBeFIPaXT38a1xRoESLqiJev1UOJgRudvV5DXgLcyi5FXJ3L4tg=
X-Gm-Gg: AeBDieunDrJj1jrsJltS5TbFbMVmF46oPiurdwW4z3RsV7JzOFlrxPIPh7/ekQE0rXP
 IHaLXAaLMD9aMiHYApGzu5gaDgcRHRHh4lXSTfTe/BFl7BKsHkGcnaYy9jiFc72+uIMyucz/ydc
 s3U+FCpA04xhadh/e+a7Gua2zWxb1JRjix0yduMPjXMXwziiKJv8yK26MQWy8KDcwdLfEaglqjP
 JjCgl9GKTB9nqiqQzaS2BYGEuXtlngouy+HxiycHOd0lNhg3OmKIYZeM2dRe+h2I5vh5jbh0Wwt
 CeyHYW+KTirrRtaXTV5nhp/Rnr570V9uEF7FBV/WsyWBT9SFfVRKjxy6wTQNBzmJhLfLcyKPTBy
 FnqSMrRLYwiACmEtBArcCAfFf01RHRDXWJov88fB+/bZy+fwyqP6V0Si+fPPB7374Zl6K73j5Qw
 DP8v0imMSS3N0lfwUfEg==
X-Received: by 2002:a17:902:ef12:b0:2b2:4bf9:1766 with SMTP id
 d9443c01a7336-2b2817c061fmr164317425ad.33.1775529490784; 
 Mon, 06 Apr 2026 19:38:10 -0700 (PDT)
X-Received: by 2002:a17:902:ef12:b0:2b2:4bf9:1766 with SMTP id
 d9443c01a7336-2b2817c061fmr164317035ad.33.1775529490329; 
 Mon, 06 Apr 2026 19:38:10 -0700 (PDT)
Received: from [10.133.33.129] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27497c117sm148544335ad.40.2026.04.06.19.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 19:38:09 -0700 (PDT)
Message-ID: <64fdfd7d-4a10-4032-a5c6-35642957705e@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 10:38:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 32/38] drm/msm/dp: propagate MST state changes to dp
 mst module
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
 <20250825-msm-dp-mst-v3-32-01faacfcdedd@oss.qualcomm.com>
 <bmni5a57d5c6wu4zwlu3uokscnrmgsuvze254afwqcfdlqplzb@fss6ewfptdvv>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <bmni5a57d5c6wu4zwlu3uokscnrmgsuvze254afwqcfdlqplzb@fss6ewfptdvv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qr6fb1LICHXAoRiET0UnwO4b4TPtdDpi
X-Proofpoint-ORIG-GUID: qr6fb1LICHXAoRiET0UnwO4b4TPtdDpi
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d46e13 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=25Fo4dagkznjro4wADQA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAyMyBTYWx0ZWRfX4zyCqEa5ndca
 jdpOCWO+16Jht3cvggR3ChhtUYgbLQ9ks2Qmo/G3lNbNEcLs62ovMpD4oPA81/pHDLrFbTEz7ua
 b3M+1OzpW5iCHJKyiGGBrAfNLN6FofLM6Hr87DydBfA0bH926qOfTEPNulIq0b+szDwqromm/QN
 dlRba0EBdGOEsa/mLVZGXB348iH0SQ0TQmHGICO9uENCa9+nj9zVTbjuz5kb0Sj5m7ROtddwuWz
 r5HgEeI+cyeAyJldCVJAPMiyMRXfwp2XnW/so/3eMrqZZiiSAng/gsa4fQXZ+dcOvGQc8FW75nV
 vsriEpqx2jCnJFjvYXA29a5yOyLRrrX/3kzI8xCsuH9fGZneIOeEbhZPV2OfwrN9B+RVtutfT+T
 meI2HUiGQ9btaqSSiALI6wv4NcJQQWithcWt06HukZea8302OruyvQGuuvvXYB2lap6sE25rA/r
 J4Pu9k1ZImJyG8X3SHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070023
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



On 8/27/2025 2:43 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:18PM +0800, Yongxing Mou wrote:
>> Introduce APIs to update the MST state change to MST framework when
>> device is plugged/unplugged.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++++++-
>>   drivers/gpu/drm/msm/dp/dp_mst_drm.c | 15 +++++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
>>   3 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 59720e1ad4b1193e33a4fc6aad0c401eaf9cbec8..909c84a5c97f56138d0d62c5d856d2fd18d36b8c 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -28,6 +28,7 @@
>>   #include "dp_drm.h"
>>   #include "dp_audio.h"
>>   #include "dp_debug.h"
>> +#include "dp_mst_drm.h"
>>   
>>   static bool psr_enabled = false;
>>   module_param(psr_enabled, bool, 0);
>> @@ -269,7 +270,6 @@ static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *d
>>   		dp->panel->video_test = false;
>>   	}
>>   
>> -
> 
> Unrelated
> 
Will drop it.
>>   	drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
>>   			dp->msm_dp_display.connector_type, hpd);
>>   
>> @@ -386,6 +386,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>   
>>   	msm_dp_link_reset_phy_params_vx_px(dp->link);
>>   
>> +	if (dp->msm_dp_display.mst_active)
>> +		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, true);
> 
> I'd say, this should be a part of the previous patch.
> 
Will rework this chunk.
>> +
>>   	if (!dp->msm_dp_display.internal_hpd)
>>   		msm_dp_display_send_hpd_notification(dp, true);
>>   
>> @@ -608,6 +611,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
>>   	if (!dp->msm_dp_display.internal_hpd)
>>   		msm_dp_display_send_hpd_notification(dp, false);
>>   
>> +	if (dp->msm_dp_display.mst_active) {
>> +		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);
>> +		dp->msm_dp_display.mst_active = false;
>> +	}
>> +
>>   	/* signal the disconnect event early to ensure proper teardown */
>>   	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
>>   
>> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> index 331d08854049d9c74d49aa231f3507539986099e..ca654b1963467c8220dd7ee073f25216455d0490 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> @@ -924,6 +924,21 @@ msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
>>   	return connector;
>>   }
>>   
>> +int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
>> +{
>> +	int rc;
>> +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
> 
> Reverse X-mas
> 
Got it.
>> +
>> +	rc = drm_dp_mst_topology_mgr_set_mst(&mst->mst_mgr, state);
>> +	if (rc < 0) {
>> +		DRM_ERROR("failed to set topology mgr state to %d. rc %d\n",
>> +			  state, rc);
>> +	}
>> +
>> +	drm_dbg_dp(dp_display->drm_dev, "dp_mst_display_set_mgr_state state:%d\n", state);
>> +	return rc;
>> +}
>> +
>>   static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
>>   	.add_connector = msm_dp_mst_add_connector,
>>   };
>> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
>> index 5e1b4db8aea4506b0e1cc1cc68980dd617d3f72a..8fe6cbbe741da4abb232256b3a15ba6b16ca4f3e 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
>> @@ -87,5 +87,6 @@ int msm_dp_mst_drm_bridge_init(struct msm_dp *dp, struct drm_encoder *encoder);
>>   int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
>>   
>>   void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
>> +int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state);
>>   
>>   #endif /* _DP_MST_DRM_H_ */
>>
>> -- 
>> 2.34.1
>>
> 

