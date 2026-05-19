Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC21CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1591310EB31;
	Tue, 19 May 2026 08:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zzohe6gS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="beKKth4B";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680D910EB31
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:26:29 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J5WGrx4130974
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Mgh8JuVhRr3riiz8W4XnG4JVay72UklEOMvws9zH60=; b=Zzohe6gS8o3RKQV8
 c+/cOjOCfz5t5l6tEtQYizNMOdG35s/HpU76+dG7tf/nqIbUTEhYr1MY28O41wBi
 hbDBzb4barIfE51g1VCc7F5Fc8ntwdTiKRo1u+MXOcnaRdozULG7BZR9Ib1r/iBE
 xHHCp4bC9EWF1xIwzxcoMtYdl4bk6Qe0yBVkfWl9xFQPDV9Dbja+JTG8h7QgCt91
 Vh1nG0qUlN5WBs+QN0XNQu8afqSmJ6D1kr7+Rk8tEXOUqEgvNUJrCKKS/EMP+qiN
 ZzWAHrELpw6xG8xwMc3SzNY04ss7xPOmLNFkJL29r3qSCbyeRUb/+K8Hp2MuMBfh
 keGcaQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ht1gpwp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:26:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8354503d9acso4536564b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779179188; x=1779783988;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Mgh8JuVhRr3riiz8W4XnG4JVay72UklEOMvws9zH60=;
 b=beKKth4B09BYmE19FaBqMpHKrQnamLUgin5J7DlNStJM7suroX2JxgRILSr3vrG8Ud
 8XeKZNbNafvKm+VGkBlKKpvyUzgvNjFrBghgsTqL1uAQOTcqvwKH43a3V2RIo7sZvOZ2
 M348kAc4wNkbWC9LiJa2EbicG9DUzmTfNwCmps5JKYxRqWQhCWQBLNRbq1ps+IbM9TZr
 RczVm4SgL1xU8ghd29Wn0DQDxrMIzZMLyhL7jAjckpbTivqXE9/YVBTCew1lRx4NrBC0
 l3GbfN0OoXR2bVknqNWbzV81lTk4U9JicCmZHymHQWu+deLFmdYKcLCDX1frjZUsMz1r
 OAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779179188; x=1779783988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Mgh8JuVhRr3riiz8W4XnG4JVay72UklEOMvws9zH60=;
 b=mI5GvB0X9cq1nCJ5VW8d1sWX4oHnLYjtKEocEJrsbdxV9aKmlvuwDVE2Up8dV5dVLL
 ImU4jhTHaqPYjPSi1UfZv9SirLvzRtwkbc5kLwH+vjJ1dkO1S0F4vZ0TGqmGb3ewYoSG
 fWLY9PKd2cn0SfEyEZYeo3fvtIvD4DbdJ470iFRk0LE4xjox+OkctI38EtYbYXykOhP4
 r21ak5aQJexs8fYRhU9TQTIM8zpWP5kjCacQa/GNuBj90CLk4jciNVIYK+Ae836nK7OQ
 bsjiSkINpzgiMr7xTxZDuoMaBX/cA3frh9a6NYQ0UlnA7IIBLppYl/VLVFwygMD5ttil
 Macg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8164KuPVcoVYDH99orjj4clRocMfPBY0OdheZxxi9cVLikv84H/xCQhZDCtoog9oMCvHckjKjveA8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiAmG/gzn472qhKAR1QPT5MAn9+MyQF/noUuUA6uaZCwnXJx/u
 PTOMfwFo7bN2e798QnTUlw6GtShFKVaBiKy471xLQcukbxCSFIC+BWheJPG6jUO2BX+S4c+bGOy
 QhJc6+JIXQlBAMFVsFHsbtSgK+Ux9h5S9UFwVOal5WXhJm8DAxjtigt/U2EDAIafrKbQ2s7Y=
X-Gm-Gg: Acq92OGNIzSTKtTTS14kOBAvN92cOiwaQVci/2HAOBmDMLM4qV+A7CRHRO8G9LX8IJf
 6OxikkPlkQaGyvPmYwahdsujWEoW1B7VBuuawGbof6c15m6ZmD48xIr58lZgnX7QBXIdikp6T+K
 vf9JvqyrTGCpJIDmskd5VCcxbUCCgQfkhORMlNCYrP4Ex1kSZWovjCmNTL8uBp+R3ePXhXtaWOx
 0nJnJSZwi9Gb+ZD2jp+IDS91QEmfR1AbkyI7BPBhJZJ507B3LQsJIp0VO4Z7cXRzRTFBjSHjzSr
 CNQUDVPlRiMOAJeVeaFbhiGWDcOw2viFE07Kc0VgRYR4c5WM/Fx3jplRAayKN2nchOwP/Vu18hx
 hlOC2If1Cez/N/2J+NQB0DVzyhIdusbQURJ+klf4k7lGnPcDsPUpoVv2ASbS5f8QQ/Vr9LZUh2t
 ppZpF7Y3gD/MQuxK58XA==
X-Received: by 2002:a05:6a00:2d19:b0:82f:a89e:e16f with SMTP id
 d2e1a72fcca58-83f33b2f58fmr19216058b3a.14.1779179188120; 
 Tue, 19 May 2026 01:26:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d19:b0:82f:a89e:e16f with SMTP id
 d2e1a72fcca58-83f33b2f58fmr19216012b3a.14.1779179187505; 
 Tue, 19 May 2026 01:26:27 -0700 (PDT)
Received: from [10.133.33.114] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f1966471dsm17467943b3a.6.2026.05.19.01.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 01:26:27 -0700 (PDT)
Message-ID: <a018705f-13c9-4e96-995e-b358778b0996@oss.qualcomm.com>
Date: Tue, 19 May 2026 16:26:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/39] drm/msm/dp: introduce stream_id for each DP panel
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
 <20260410-msm-dp-mst-v4-13-b20518dea8de@oss.qualcomm.com>
 <nzouhzeoimf32nwbm2qjecopildvmlay4t4xxshufsjaydmwlc@bnfom377r5b2>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <nzouhzeoimf32nwbm2qjecopildvmlay4t4xxshufsjaydmwlc@bnfom377r5b2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JKULdcKb c=1 sm=1 tr=0 ts=6a0c1eb4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5QDKDTwAGq_DmF9AEKQA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3DWbkRk9wzyIy2kpY5-CtOYwmovtP4is
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4MyBTYWx0ZWRfX8L70xCxkpVU0
 Sz6AoGdrsUm8r+UaxPcSMTGYEPIfiIkNcDLRkGoA4BwSr5h7JK1VahpFvg1+tdX9JNADIQA9+qg
 mg8JRmHr4R19AXr5n6ao+kb5CFEVb6d5BdaWngmQEUd+Z3qABm7Sz7dAq0oQQq18Iyt3Uf8RIuo
 TTvBWl/nnSXKYAycDbgBZshrkMrW/jQunYFSiHq79pTn7RQwKhDaA/nOaFzW4i8IxeqpIExzRDy
 Jpmap1chT8Tf0xT38r6/o0K+ulIimg+cqV36m5Twmc6pSo2Do0dYu8eIq6kcAp2QnYOix+n8hna
 1/mNqtFcC4qqL9TzPFMzgvgQAtT/8uYRBvcFAl9KKZL01xvLjowaHIWCqRXkleOLJ2ic71k5Rfi
 RLnaIQOeiaUnKLsDeSDxM+ovLSe5/0naL80jl8uLm1cXP+gitvaOCHgktx7gy8gdpq4A6IYMBFY
 mPx950cvExC8aul1XNQ==
X-Proofpoint-ORIG-GUID: 3DWbkRk9wzyIy2kpY5-CtOYwmovtP4is
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190083
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



On 4/12/2026 1:55 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:33:48PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> With MST, each DP controller can handle multiple streams.
>> There shall be one dp_panel for each stream but the dp_display
>> object shall be shared among them. To represent this abstraction,
>> create a stream_id for each DP panel which shall be set by the
>> MST stream. For SST, default this to stream 0.
>>
>> Use the stream ID to control the pixel clock of that respective
>> stream by extending the clock handles and state tracking of the
>> DP pixel clock to an array of max supported streams. The maximum
>> streams currently is 4.
> 
> Please mention that panels are going to be dynamically assigned to
> actual stream IDs.
> 
Got it. will update next patch.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 57 +++++++++++++++++++++++--------------
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++++--
>>   drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
>>   drivers/gpu/drm/msm/dp/dp_panel.h   | 11 +++++++
>>   5 files changed, 71 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 120ec00884e5..fb6396727628 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -127,7 +127,7 @@ struct msm_dp_ctrl_private {
>>   	unsigned int num_link_clks;
>>   	struct clk_bulk_data *link_clks;
>>   
>> -	struct clk *pixel_clk;
>> +	struct clk *pixel_clk[DP_STREAM_MAX];
>>   
>>   	union phy_configure_opts phy_opts;
>>   
>> @@ -139,7 +139,7 @@ struct msm_dp_ctrl_private {
>>   
>>   	bool core_clks_on;
>>   	bool link_clks_on;
>> -	bool stream_clks_on;
>> +	bool stream_clks_on[DP_STREAM_MAX];
>>   };
>>   
>>   static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
>> @@ -2176,39 +2176,40 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
>>   	return success;
>>   }
>>   
>> -static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
>> +static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate,
>> +				    enum msm_dp_stream_id stream_id)
>>   {
>>   	int ret;
>>   
>> -	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
>> +	ret = clk_set_rate(ctrl->pixel_clk[stream_id], pixel_rate * 1000);
>>   	if (ret) {
>>   		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
>>   		return ret;
>>   	}
>>   
>> -	if (ctrl->stream_clks_on) {
>> +	if (ctrl->stream_clks_on[stream_id]) {
>>   		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
>>   	} else {
>> -		ret = clk_prepare_enable(ctrl->pixel_clk);
>> +		ret = clk_prepare_enable(ctrl->pixel_clk[stream_id]);
>>   		if (ret) {
>>   			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
>>   			return ret;
>>   		}
>> -		ctrl->stream_clks_on = true;
>> +		ctrl->stream_clks_on[stream_id] = true;
>>   	}
>>   
>>   	return ret;
>>   }
>>   
>> -void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
>> +void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id)
>>   {
>>   	struct msm_dp_ctrl_private *ctrl;
>>   
>>   	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>>   
>> -	if (ctrl->stream_clks_on) {
>> -		clk_disable_unprepare(ctrl->pixel_clk);
>> -		ctrl->stream_clks_on = false;
>> +	if (ctrl->stream_clks_on[stream_id]) {
>> +		clk_disable_unprepare(ctrl->pixel_clk[stream_id]);
>> +		ctrl->stream_clks_on[stream_id] = false;
>>   	}
>>   }
>>   
>> @@ -2228,7 +2229,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>>   	 * running. Add the global reset just before disabling the
>>   	 * link clocks and core clocks.
>>   	 */
>> -	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
>> +	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, ctrl->panel->stream_id);
> 
> Why are we using ctrl->panel again here for the stream-related
> functions? Didn't you got rid of its usage few patches ago?
> 
For MST path, we pass panel to the func. For SST case, we still need to 
pass the sst panel to func, in here it is ctrl->panel.. in dp_display, 
it is dp_display->panel.
>>   	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl);
>>   
>>   	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl);
>> @@ -2238,7 +2239,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>>   	}
>>   
>>   	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
>> -	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
>> +	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate, ctrl->panel->stream_id);
> 
> And here...
> 
>>   
>>   	msm_dp_ctrl_send_phy_test_pattern(ctrl);
>>   
>> @@ -1451,6 +1469,8 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>>   
>>   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> +	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0);
> 
> DP_STREAM_0
> 
>> +
>>   	rc = msm_dp_display_enable(dp);
>>   	if (rc)
>>   		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
> 

