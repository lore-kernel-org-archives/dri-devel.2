Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0FFFF4958
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 07:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3512710E4F6;
	Mon, 30 Mar 2026 07:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FJLP8uhU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RLfqh9+9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FFD510E4F6
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:51:44 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U78UZf4162016
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bMiUe9iN06BRdJhoHLMir2LU+GzeH6cFH1Hb19BsFhA=; b=FJLP8uhUBXQdg1zp
 exyv/CzkrEPMgAoYTZs2W41+N+Z3yk1Dv5UnZ3l0wYe4U+LqKWn1KcKmKxE5g4H/
 pCjUFrCR3kLfroOV45hYQCvVEAVMgM/0wa4w7PqOlnAwXGaTpGGiLet2x3KhJVpu
 Qjt3g/sLnZfjsT99OdQD2xYfmuJ5LCCeya6VXQpn0FYIH22nBj/1urwXAzxG6t21
 ObHbzwLd1RoJNFnLwrfL3oOpbJZwiKw/BSeizypyH311fAalSUHooHuDGEpe/kdj
 IDVMEo8IXt4qTzvcEFaWJDJwNv6II4qpYvp81zaCILgLc/swZz/NbWRcqhEEJz/b
 tSeksQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7mhar4uf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:51:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2adc527eaf5so36534575ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 00:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774857103; x=1775461903;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bMiUe9iN06BRdJhoHLMir2LU+GzeH6cFH1Hb19BsFhA=;
 b=RLfqh9+9TLydXsDc6La9JQYC2LljrtONv1/LdvuYMy1eVh4CzitH3rgqxhKd2h7U65
 61Sg/3j2T2sz6cAHR+SJhQuT/GFLbGegN95gyEKcixZhcOTihcUdZoAspS5V7tjFH3sy
 aR3tzqQYbl2ugDCGhTYnOHtc0j2YeFD/fKPxTr/DAO17cSp8d8Nv0UTszYGascNMgLcL
 poRzTQ8rv44TxtCqg2368M7YSVgKfOtDXp9b8x6CPrd+oUkyo9NbIihgw6v0Pw2cXIXM
 FRIhcstbuiYu/DZb62N1n73aYK/aFMEKkNPaN1kFqi2KLUVlenPxGzX1bwQWiTwcuntW
 2nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774857103; x=1775461903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bMiUe9iN06BRdJhoHLMir2LU+GzeH6cFH1Hb19BsFhA=;
 b=DRq49BTKawjmHODOy5wO3dc2TThuwUW+KaqPZcoKT19NX1MUe6ljFaym1iVxSmiU0f
 oIGy/Q3DUqlXyNs53rOEwv6wM7L2F+1HghxWEB1obiiy5/sDm25Cgc5umkdhNYucvsyf
 Z7oVxIA4mFq4Fyb0pmHe8h/k5fKZmNB62PKLA4PnkUUVUNn6b6nFF4H8In+QHWkBf7xB
 fog7xVZ6jkFdFE0bQ91POuRlIiL+unU1wmqsP+TqcymS3kcb7Xff2f4S0qxJwIqH+qKY
 C5cQT1Zo17VMKrzPHXwVIUMQpfh63gjkeSM2RRYY08CSqiVnzUmVNFETlQ5Lo5b04VvO
 n9xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXajQ4jyujWMQC3dpb8PN5QAwoT7YIPj9qslgQcXAFdr87Rm1Mgw64uajMIL8Te2U+QCHEGT+sgavo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiuEHHSAfPyxs+pw2gySn/7aNdL6ckZxWTjVzzkqppqRFpUiq8
 p99wLn2kjWVml9WacdbphqAQrW58AM9jY+ZKfyTWKg+lRR/B436BKn4TNoWil81KbUaWFbeMnWm
 85vriK0u8nSuYcVgGc707fMHwB6JXpvxfV9/BEbIQufkHAX0I4n6LFtJfAM5TAU+ENTiMAlY=
X-Gm-Gg: ATEYQzwXOBQQV2cV3EUOvVR0RyxhkLJ/oCdsISCYjte82D13xDCNR/NC00EXLQ3aSQx
 vHPaIdc45bIXXX617rAb25Z/o2/5KOeg6hgrdkgakV8YuUdo/CZa23/TB80q4ZCWTuqKIRljlpb
 SQc/Uc/zXenTCqnAPiEuAIxL6ps9O5WOZZdiy+/v9QUztShR8oY8JZrnqKFrL5oneEX1uKpLWHZ
 agFXYx3sePg1x2IEvd+aHexB1xLKIA2YTckqSO2lQ1yxyIp8MzS+YkHSPEpuCSMfqffRqR+4Oss
 0SqsglPx4VqYwCV/hGj2O0tSM59z9ac+aYFAm1U/XT0KMuCp8SctkZQfiNFi+/Oe45135Y0mviv
 7u+l7QL9wkhtmgSm4ItziX7aVbWbnn/UwiLnU4krp1YFPgqIP
X-Received: by 2002:a17:903:2f82:b0:2b2:497e:3f6d with SMTP id
 d9443c01a7336-2b2497e4b68mr59145485ad.8.1774857102824; 
 Mon, 30 Mar 2026 00:51:42 -0700 (PDT)
X-Received: by 2002:a17:903:2f82:b0:2b2:497e:3f6d with SMTP id
 d9443c01a7336-2b2497e4b68mr59145235ad.8.1774857102341; 
 Mon, 30 Mar 2026 00:51:42 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b24277e8d3sm69819085ad.55.2026.03.30.00.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 00:51:41 -0700 (PDT)
Message-ID: <1a45815d-1354-43f2-abb4-438e55e2cf44@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 15:51:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/38] drm/msm/dp: remove dp_display's dp_mode and use
 dp_panel's instead
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
 <20250825-msm-dp-mst-v3-2-01faacfcdedd@oss.qualcomm.com>
 <aa35nnvo4mugk363rwa3cndjwj5sukfchdxv65yob2uf5ugskz@gus3l4d6vccc>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <aa35nnvo4mugk363rwa3cndjwj5sukfchdxv65yob2uf5ugskz@gus3l4d6vccc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2MCBTYWx0ZWRfX9PDZrcFIEWFd
 1YkZ9YRZETGbvYtg+940gGpSOwWrSmpDb1X5LAbMDag5BIyPCbxebX940bXvB2Mxbqxd7Q9JMnZ
 ZzNsTHPR9w5pKch8TmVggR58MfPBm7DNok1MN3RUt0pus0sz7j1ZMDEcW5b2jlXN2gbNIU3VPA4
 3SVm+a3+xNmKJmhfU1xodZ0WJ8kWo40Vv+rT3qJzdwzmnpqCFbg11u0wFZ6wriiD4XjBeftJsOg
 ZsPnTaHLlKEFjAUHalHbq9PjUVz6baRf5r0IAY3g1nHve/E1TIYdYs3rfDo/BulNTED4ZL8GFPV
 N8vrYElzfWSjwbVi4sUdhnLGXw4D61x46Ojv2RIy8xfKih8yVNcy6qLxWB2rlLxTOJZ11ivlkVn
 zLXZeZDy+mvb9ut8fGGrq3TisTf/0ywQWo0W0ySuTru9zBVAMeunucxtfXKVR8arfok9f//ThYa
 qVo49qcP1vgJo2lYJDw==
X-Authority-Analysis: v=2.4 cv=Fbw6BZ+6 c=1 sm=1 tr=0 ts=69ca2b8f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=BixJ-8ITQ80jKJ6xuOMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: S7F40L3eycFXRqVlkXOJRv3rZzn9nMb6
X-Proofpoint-GUID: S7F40L3eycFXRqVlkXOJRv3rZzn9nMb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300060
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



On 8/26/2025 12:50 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:15:48PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> dp_display caches the current display mode and then passes it onto
>> the panel to be used for programming the panel params. Remove this
>> two level passing and directly populate the panel's dp_display_mode
>> instead.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 66 ++++++++++++++-----------------------
>>   1 file changed, 24 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index dadf31bc37763c4f07f68b76fbbe33fb77b20850..632a1191e4e48fecd7dbda2f6ec6b8ed0aeebc93 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -60,7 +60,6 @@ struct msm_dp_display_private {
>>   	struct msm_dp_panel   *panel;
>>   	struct msm_dp_ctrl    *ctrl;
>>   
>> -	struct msm_dp_display_mode msm_dp_mode;
>>   	struct msm_dp msm_dp_display;
>>   
>>   	/* wait for audio signaling */
>> @@ -649,16 +648,29 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>>   }
>>   
>>   static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
>> -			       struct msm_dp_display_mode *mode)
>> +				   const struct drm_display_mode *adjusted_mode,
>> +				   struct msm_dp_panel *msm_dp_panel)
>>   {
>> -	struct msm_dp_display_private *dp;
>> +	u32 bpp;
>>   
>> -	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>> +	drm_mode_copy(&msm_dp_panel->msm_dp_mode.drm_mode, adjusted_mode);
>> +
>> +	if (msm_dp_display_check_video_test(msm_dp_display))
>> +		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
>> +	else
>> +		bpp = msm_dp_panel->connector->display_info.bpc * 3;
>> +
>> +	msm_dp_panel->msm_dp_mode.bpp = bpp ? bpp : 24; /* Default bpp */
>>   
>> -	drm_mode_copy(&dp->panel->msm_dp_mode.drm_mode, &mode->drm_mode);
>> -	dp->panel->msm_dp_mode.bpp = mode->bpp;
>> -	dp->panel->msm_dp_mode.out_fmt_is_yuv_420 = mode->out_fmt_is_yuv_420;
>> -	msm_dp_panel_init_panel_info(dp->panel);
>> +	msm_dp_panel->msm_dp_mode.v_active_low =
>> +		!!(adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC);
>> +	msm_dp_panel->msm_dp_mode.h_active_low =
>> +		!!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
>> +	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
>> +		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode) &&
>> +		msm_dp_panel->vsc_sdp_supported;
>> +
>> +	msm_dp_panel_init_panel_info(msm_dp_panel);
>>   	return 0;
>>   }
>>   
>> @@ -1328,7 +1340,7 @@ bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
>>   
>>   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> -	if (dp->msm_dp_mode.out_fmt_is_yuv_420)
>> +	if (dp->panel->msm_dp_mode.out_fmt_is_yuv_420)
>>   		return false;
>>   
>>   	return dp->wide_bus_supported;
>> @@ -1389,10 +1401,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>>   	bool force_link_train = false;
>>   
>>   	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>> -	if (!msm_dp_display->msm_dp_mode.drm_mode.clock) {
>> -		DRM_ERROR("invalid params\n");
>> -		return;
>> -	}
>>   
>>   	if (dp->is_edp)
>>   		msm_dp_hpd_plug_handle(msm_dp_display, 0);
>> @@ -1405,12 +1413,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>>   	if (msm_dp_display->link->sink_count == 0)
>>   		return;
>>   
>> -	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
> 
> Why is it being moved from atomic_enable? You can access crtc_state here
> and thus the adjusted_mode. The mode_set is clearly declared as
> deprecated. We should move moving code from that function rather than
> adding code to it.
> 
Got it. Next version wil drop .mode_set() and move it to 
msm_dp_bridge_atomic_enable.
>> -	if (rc) {
>> -		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
>> -		return;
>> -	}
>> -
>>   	if (dp->link_ready && !dp->power_on) {
>>   		msm_dp_display_host_phy_init(msm_dp_display);
>>   		force_link_train = true;
>> @@ -1479,31 +1481,11 @@ void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
>>   	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>>   	msm_dp_panel = msm_dp_display->panel;
>>   
>> -	memset(&msm_dp_display->msm_dp_mode, 0x0, sizeof(struct msm_dp_display_mode));
>> -
>> -	if (msm_dp_display_check_video_test(dp))
>> -		msm_dp_display->msm_dp_mode.bpp = msm_dp_display_get_test_bpp(dp);
>> -	else /* Default num_components per pixel = 3 */
>> -		msm_dp_display->msm_dp_mode.bpp = dp->connector->display_info.bpc * 3;
>> -
>> -	if (!msm_dp_display->msm_dp_mode.bpp)
>> -		msm_dp_display->msm_dp_mode.bpp = 24; /* Default bpp */
>> -
>> -	drm_mode_copy(&msm_dp_display->msm_dp_mode.drm_mode, adjusted_mode);
>> -
>> -	msm_dp_display->msm_dp_mode.v_active_low =
>> -		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NVSYNC);
>> -
>> -	msm_dp_display->msm_dp_mode.h_active_low =
>> -		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
>> -
>> -	msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 =
>> -		drm_mode_is_420_only(&dp->connector->display_info, adjusted_mode) &&
>> -		msm_dp_panel->vsc_sdp_supported;
>> +	msm_dp_display_set_mode(dp, adjusted_mode, msm_dp_panel);
>>   
>>   	/* populate wide_bus_support to different layers */
>> -	msm_dp_display->ctrl->wide_bus_en =
>> -		msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
>> +	msm_dp_display->ctrl->wide_bus_en = msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ?
>> +		false : msm_dp_display->wide_bus_supported;
>>   }
>>   
>>   void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)
>>
>> -- 
>> 2.34.1
>>
> 

