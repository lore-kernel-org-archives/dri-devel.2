Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B357C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B76010EC3E;
	Wed, 26 Aug 2026 07:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ep9pSq1n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AxfJNTFU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D0CE10EC3E
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:47 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q7Mp2x1261122
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VmKwLbnsPZFlUAjDTujAFCfYSP2gE+15xnfduYdECbk=; b=ep9pSq1niM+HWzq0
 zbbLJxG7iOUTsPepj2rkGGTUBzPkdR3XT9/rHMHQmjip8/HLVAbTf1b6UH9Gm1n0
 wqCCjhzQYiCvq5bPx52MGVZKFl2eUcQlcRSlsyZLJbpxqN3yI/5o4Ame33nXUkW5
 RWP0Xi0o/xBIezcay2yT2n0MOrX2YKUa+VQbYZdYB3bhEVqPU5gwnY5fid8gyCLa
 5t0Q441+So7NUz58HaA5cJwi4SPTIrYwnFjnGfI6/14TffheP7BQouDRwJ1AFAGP
 K8662v+Z1kXdcuhxd4jTxFQh9UqqDuPxrul56YVuJeLYXy+fxJ6Vn/CQoB3rqQsM
 oz+43w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uq1r38g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so24449a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 00:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787730526; x=1788335326;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VmKwLbnsPZFlUAjDTujAFCfYSP2gE+15xnfduYdECbk=;
 b=AxfJNTFUd52Hm88hfC1kBPnTR6+cIBiDrYosbcVjU4T7ZGOGSsz8/LyJVIqJJ/A1jv
 81VMvV7c2F9mSs7xLBKNUicUdUD6pwVBiq5htEQurVLc2Kq4aoCo1OR2ahz4Yha/5uUO
 40DtBUxQd8AUbQke+L/k1UDObVkbu0phvH5LzoShFdIcmHGnablAt4j5Ze6lu4inbjkO
 U6b5n0KulR4rrXJXZrHxeTY9T9+K6xn/Sk7ZaVdgRVYcIRQnml3Thute9dt7RCxlY5OV
 XCmgGTZ9XiOu5oxsmmimZqx22tZ9HxxKALtYWw5q8StKZPhCj767f0/D2BEfyZ8VQ6U/
 fifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787730526; x=1788335326;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VmKwLbnsPZFlUAjDTujAFCfYSP2gE+15xnfduYdECbk=;
 b=PICe/qtWMHIc3/BMQIGL34VZzjMeZR1ENsCsSX6C/PMZz2mo2AsbBL/TI42KrErNYH
 1CxaZLwI2/YOjJdYjQL0w2eRDJ3SBu3fOL/e4I75adF54itXmG4qk+kFz8CSDYDhMSAg
 ZhZ/6IXuyOnXl4aGqbVkNuFaNmhI5ygfrpbhWOVI2L3/YQjx+a6T391Y3MzCPcqNXXwJ
 DSceBjvp9r44iVle9lPdKinRmhiKs9O+Ha6/dw8OJPidYE+UkwU6ZndOIEW8Rjwk0s8w
 /ZPHlp4HknPHjIf2tDI+wHyxlQlzc1PUabF/tI42FUIg3WcWipEA82eomnhynowhlkR8
 H/kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYoIJEtzYrk8TvfD+L1Ob1L5/LEEgeOGgRSusuoyR4LH+i+0o/qvj0vubv28B9P0tooH6Pf5ns5QA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mFdkhmgqPPcnHFdu0f74zR06roMqEFrCKsnmHr1ENfeigbejF3
 0wXQNKggv4hryPuL2G8TuenP+RvJXtpzJ4/NGdIwbm7YexqN9u0XUpxSgKQXDPVmhklGfJG9tkz
 kWtfc5Bul+cLxrlZMMrIn5cv3Y8Z+h58LfDa4FeiZ6xabvgENS1jrqN1EIlX6MsTivPazkqY=
X-Gm-Gg: AR+sD10L2Sadb67TVtXhZDqHruch1rBMWR3EQN+m8wnm6IWzIPYZ4txmcz6gprMPWZi
 K068BWDGVm00isvs1xttzFuSN182iJEjYyzuQ7YIoA5dyQpc9zW1G8i05EyxeGEr7E7TIsi5E0R
 /S955VMdzbh73tmflt21B7unonR6f3V/zCE40VgmgZFAt6qvsWekDZxmvkjcz/QMV2HQZ9Dcuas
 RBrOZI2qlvlx0gMuZYptoM9QWavZQ3GCAB3ucKdYegghL5PGhvDjAtvZfpDewdcwTpaeJfAcrvX
 CHjjQA1y9y5ge5fLyMqOiLkje/Fap1mssnPMVCakFVHwF0uEVGw3WGxh5B0VoR6C2tp/yyxvXq6
 +nTlkeeShhi8jjiWUsdT4wa06WvO//ZeQXslPy1lmcvaUqdHnn//FsxZiok3PyyPtoZb4vNEx
X-Received: by 2002:a17:90b:3ecd:b0:38f:efed:5448 with SMTP id
 98e67ed59e1d1-3966d21497amr8103131a91.8.1787730525684; 
 Wed, 26 Aug 2026 00:48:45 -0700 (PDT)
X-Received: by 2002:a17:90b:3ecd:b0:38f:efed:5448 with SMTP id
 98e67ed59e1d1-3966d21497amr8103047a91.8.1787730525193; 
 Wed, 26 Aug 2026 00:48:45 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a5832bsm3060969a91.15.2026.08.26.00.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 00:48:44 -0700 (PDT)
Message-ID: <96bc9f2d-a0a4-40f5-8281-55c6f9982559@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:48:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 15/25] drm/msm/dp: add an API to initialize MST
 on sink side
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
 <20260629-msm-dp-mst-v5-15-2ed6aee1867a@oss.qualcomm.com>
 <esaigelvp2o7hw3z32mmtlmy4jzvb6v2uofmsvububwbn5oybt@hymmfbamhlki>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <esaigelvp2o7hw3z32mmtlmy4jzvb6v2uofmsvububwbn5oybt@hymmfbamhlki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Dg2PjPQEwdz29nGdwfL6AJMfFmBgnQ2x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfXy3ZTEUMv1eIq
 8NqLnplq1uWaauY6aL0ySpSMLy+Ce51eGWYwCGY0TqZwFWQkj6ZpcgWDVHU5EBZPjwhXEBVdQ6S
 62yS49HyZhRD97fEOxgSM5wlxD4n+lRPSTYNqnpn9u+au236R4J7ZL9s3yyO3ELrCiqdLoxSvZn
 kseMRm/nwaVryAl/FCnc+JFWKfUQzk4wKb42LEe1iA23FevayQHBHBGyi2zqJA+bDMmiKaIljhr
 cxN05h+SwrMT10W7keDL3MYFhQ68WUCD2aVJa6kAIUtvlTTlsi6wm3aJD41nRI0b3+McgkHzJNh
 9W6bpcBAgNgSFRY02xvZNmSHyc5kTdivRguZwqFgLksiIdZ6GNQZsffQC1J7PdbxCcXaLKg2oiy
 4Gkfpjx44nB/ZGegBUoCEDVs6GFr0NMntwLwlj8lp8nxDZGQWDTaGNf5hTEPyIx5MXi+wx17v0S
 p34kapRf1XjTgB2rvLg==
X-Authority-Analysis: v=2.4 cv=Y77IdBeN c=1 sm=1 tr=0 ts=6a8e9a5e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=tepjUtBTXmVVZiRr_ggA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Dg2PjPQEwdz29nGdwfL6AJMfFmBgnQ2x
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfXyqv6thJAY//h
 F3SR/ET3khvThwlwVOZ3PLTi+8aCJfGlFCSw8ID1YGziZV6bhTcOOdthBAAiTKsM1jAjUxtHwKL
 N8tk6X5rrMlB/grf2I/HcKuz43Bi52g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
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



On 7/13/2026 5:35 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:36PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> If the DP controller is capable of supporting multiple streams
>> then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
>> DPCD register to enable MST mode.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 48 +++++++++++++++++++++++++++++++------
>>   1 file changed, 41 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 5786e598a406..c3be656f10ee 100644
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
>> @@ -270,6 +271,31 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
>>   	return lttpr_count;
>>   }
>>   
>> +static void msm_dp_display_mst_init(struct msm_dp_display_private *dp)
>> +{
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
> 
> Is it not enough to write the new value? Please add a small comment,
> why (reference DP standard in the commit message, please).
> 
Got it.
>> +
>> +	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL,
>> +				     DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
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
>> @@ -288,14 +314,19 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
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
> 
> This also is going to break DP. If you are using dp->max_streams as a
> determining factor, rearrange commits so that max_streams are parseed
> and set only after the rest of the commits are in place (and the driver
> is ready for DP MST).
> 
Sorry, that was an oversight. Those two lines shouldn't be there. The 
patch wasn't clean enough, and I'll remove them in the next revision.
>>   	}
>>   
>>   	msm_dp_link_process_request(dp->link);
>> @@ -317,6 +348,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
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

