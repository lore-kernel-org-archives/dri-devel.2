Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3416ACD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1D510E381;
	Tue, 19 May 2026 07:52:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XYRkfMZW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X0JdIpHm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7303310E381
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:52:44 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J2RcTS2091010
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jTQX16W7swBYmu2gxJaUk7f96G0XRJAY6//6lEUd/fQ=; b=XYRkfMZWRIsACfhT
 7zqTRink+fcs/Tl1fUCenpF/DtM8aie54CVb5+XAvsE2KI94YNWamEeXnIxUSdrM
 vA975diV8dvAwFJTa3Xfy80C+k6tqeDtPSqADfG7UbnM22qpU0BkC8ocZZF6zRpa
 A4wVWYqURT2iC/6wMhXQf2b6jUZ0nDsn6h5T0loOHXzC7IAhRomzxoglqh7am8ci
 mxh/67+KB3c3+PPeWRd5fKz9fmtMkwkSw+kPjqP6hgJLoVnIW7fqek2TNKP7FQ3t
 VV1iazlxqZVyfM52+KZb3rVnz33ptz9mMhAHDGid5F6i0ialM+pdlBMAsCxLJjZv
 RG/I8g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e80rpme4s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:52:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-365fd467cf6so2707609a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779177162; x=1779781962;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jTQX16W7swBYmu2gxJaUk7f96G0XRJAY6//6lEUd/fQ=;
 b=X0JdIpHmlOCzcmMThgIHYhQFM+VUuPI4gQT/kLnJTlGA0V4llRJsidbfl3xn17zEQw
 DsBnL9giTAr1U7Mgt9gzQHdCOWZ+k6XN87VzVIulrTunsmJyZCgacLeO5X+u/wfAbliV
 t0qou2POnAtxHIX5Q+lY5+3aWbK4nDMDqh0iBH9q+iKSojSNGg53sFcgW+XMwF7E+92f
 ztVXoY9AIwqDhPpRGIQH08xFUr0/unr2v6VO+a84K5y6OpS5TXmXL1KswqtrO/59g6/n
 rlczJMRbgkIfari4qmRm7kfPLL9yCQXlIBJ0/5cGLFlw4Y7MJ8nXFLAcatQreCPzRhV7
 Ap7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779177162; x=1779781962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jTQX16W7swBYmu2gxJaUk7f96G0XRJAY6//6lEUd/fQ=;
 b=Zn6aCBUcAMUvRqwvc8NNMYXOpc370bTwpNjXxdTFYzD3qaA59Wtxtdq/+cZZWYTyZt
 UyEHLfvfClU/lhY2wt1vBGwrKqhuGupDaPFcMaEgjnfpNS2V8hoPl7RPTo9PtRI7kwLQ
 XYAl7ZBT/4/ocWdf3kXEPcMAOPXVL39AHIATKoqcXfo7P7NQr+5toiLSPi6scD+ffaSg
 R+9CFq21GLrAMDvdw+pNvmaASnon3B99NM0THTgAnCz3t0ItI0zOSI4YPBOVN1HCzmPg
 wBAo0bmB+IOGq0UFjF7R53Fo59zAlL1IW9KlELALKFv10uAolTpqF3fT6dWHsRGyKQwR
 Vnfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eWkgdNnXsaLqOqePQtBWkCIRFJraOkTelEocujwpzy5CSO0nUrzabefbQ9VviX3yQEMYRkSuyXxM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVo2beEcgxZ2XiOzFTgLDdMJKmklvRdusNXEd0Abl7OZogYBiS
 3yxp5OUNrljlUMAb3W388tNaaxImZi9KAASwdgIv6Nu6vq3cK2q6JOADYulVTzNyrJVr0oQGiAD
 5JgZMQ+MXu83LDpsf2A4Uujbwhqnv7yuax2UrP7UJAWBYdYTmoiuj/Qcba2E1jA3PLp+pgSs=
X-Gm-Gg: Acq92OG9lI4Ekjzi9saeQsXK7w9dgZrvxJgPLLrkSTlc1aFLlYppWixabSInP0qgXGb
 6WgBs4bFxScNIteSWG6qXbi8XAn32WiDC0DuYBxCdMg+N0xawoQI2RmdiwSNm4Und8y4qq4a3u1
 da7zJYiOg7WFreIEsMnvCiV8fR7atsoHn9sIhucYlbkLYNqJAKtkJ+PLMDJbjJRELo3aVFyLQGw
 5XHzEg5PATsDgRqRShE9/AzDHYlv8YY76jlTpCd/kWFKscmXbWdJk3+qKPfbZ3mipVDflTBE2sk
 KS9OoiMNHzk3uaz9HzSDaHOft3AohjJuoenxRFE4asMaEVe7v668zqURHdA+HuUqfoUqJXoTfho
 F3aBhlgCqxpdmFQUAolfc3xeDPtCVDWqDXbZk+cuRAIidrLOBxUN+UDbinliQ8YANOLsW+3UV/a
 353XldkWdxHOqo90LDIcmRDPn6BgLs
X-Received: by 2002:a17:90b:4b4d:b0:369:d704:d944 with SMTP id
 98e67ed59e1d1-369d704f684mr6129618a91.4.1779177162491; 
 Tue, 19 May 2026 00:52:42 -0700 (PDT)
X-Received: by 2002:a17:90b:4b4d:b0:369:d704:d944 with SMTP id
 98e67ed59e1d1-369d704f684mr6129597a91.4.1779177162012; 
 Tue, 19 May 2026 00:52:42 -0700 (PDT)
Received: from [10.133.33.114] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36956527f45sm8028741a91.0.2026.05.19.00.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:52:41 -0700 (PDT)
Message-ID: <09c14a80-d981-4584-b4bb-8fb2430d7a0a@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:52:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/39] drm/msm/dp: allow dp_ctrl stream APIs to use any
 panel passed to it
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
 <20260410-msm-dp-mst-v4-8-b20518dea8de@oss.qualcomm.com>
 <oughavmmvruhnehdpa4e3ptigcb4wndugxazhoeg2yed7ubvgi@aa7wtrz5s6mx>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <oughavmmvruhnehdpa4e3ptigcb4wndugxazhoeg2yed7ubvgi@aa7wtrz5s6mx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SQnpz1qOKHeupOkPO_UgE1pbVFikyIQW
X-Proofpoint-ORIG-GUID: SQnpz1qOKHeupOkPO_UgE1pbVFikyIQW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA3NiBTYWx0ZWRfX5NbdHx4A4Gkh
 WxxXNX6eskxU5Auaxo1KaasgxqMYuMtAfyBDc20xCvyI/Bs7pNUej5NtKm7eT9Ou+0tfrTnxflM
 24VczC01kg8b03vH3Xt8GlJmIzqp2Jtwlj75VvAKtVIniDwoJ33QIvf30cBnS+KvIT5JlunSozC
 riN/EIBuLyPZOrRfcXyOrNK8vpN4vPVffnP2S3r/L3RrBoKMR/chzW7dFHAhuAHTGkjQu7r99yA
 icknRdOLQQkZLbqjPZkE+UpJuW1KBAgMtQMgGEuTyZ+1UtkCuX2S1NOq/mDEQk6wJUJSGkLTUDD
 m/kkzP27AfLenj4IEQPo6YP6pKNYyR7aS0UgvUJhzUd5yyrkmnxR/oRcvtlhKxxT1OHOphbL0DE
 lhbr5Uf/SW3eXKmeBKR02mwACkvtls4RO8UumNz7dZO6rxAvDXdI3CMh00jXOmoioRfcKAlU9jz
 i6OsgOYzrxLNbvGyYFA==
X-Authority-Analysis: v=2.4 cv=ecMNubEH c=1 sm=1 tr=0 ts=6a0c16cb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=WzSTVGcSt2Wm9MDnWl0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190076
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



On 4/12/2026 1:38 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:33:43PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Currently, the dp_ctrl stream APIs operate on their own dp_panel
>> which is stored inside the dp_ctrl's private struct. However with MST,
>> the stored panel represents the fixed link and not the sinks which
>> are hotplugged. Allow the stream related APIs to work on the panel
>> which is passed to them rather than the stored one. For SST cases,
>> this shall continue to use the stored dp_panel.
> 
> Hmm. Why? Can't we get rid of it (in the followup patch)?
> 
In MST, the stream panel is bound to the connector, but in SST the panel 
is still stored in msm_dp_display_private and msm_dp_ctrl_private, so
   dropping it does not seem necessary at this point. The purpose of 
these changes is to allow the functions to operate on the MST panel data 
passed in per stream.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 21 +++++++++++----------
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
>>   3 files changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index cd58968d4e14..d0eed8c7df45 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -477,13 +477,14 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
>>   	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
>>   }
>>   
>> -static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
>> +static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl,
>> +						struct msm_dp_panel *msm_dp_panel)
>>   {
>> -	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
>> +	msm_dp_ctrl_config_ctrl_streams(ctrl, msm_dp_panel);
>>   
>> -	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
>> +	msm_dp_ctrl_config_misc1_misc0(ctrl, msm_dp_panel);
>>   
>> -	msm_dp_panel_timing_cfg(ctrl->panel, ctrl->msm_dp_ctrl.wide_bus_en);
>> +	msm_dp_panel_timing_cfg(msm_dp_panel, ctrl->msm_dp_ctrl.wide_bus_en);
>>   }
>>   
>>   /*
>> @@ -2523,7 +2524,7 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_li
>>   	return ret;
>>   }
>>   
>> -int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
>> +int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
>>   {
>>   	int ret = 0;
>>   	bool mainlink_ready = false;
>> @@ -2536,10 +2537,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
>>   
>>   	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>>   
>> -	pixel_rate_orig = ctrl->panel->msm_dp_mode.drm_mode.clock;
>> +	pixel_rate_orig = msm_dp_panel->msm_dp_mode.drm_mode.clock;
>>   	pixel_rate = pixel_rate_orig;
>>   
>> -	if (msm_dp_ctrl->wide_bus_en || ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
>> +	if (msm_dp_ctrl->wide_bus_en || msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>>   		pixel_rate >>= 1;
>>   
>>   	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
>> @@ -2571,14 +2572,14 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
>>   	msm_dp_setup_peripheral_flush(ctrl);
>>   	msm_dp_ctrl_config_ctrl_link(ctrl);
>>   
>> -	msm_dp_ctrl_configure_source_params(ctrl);
>> +	msm_dp_ctrl_configure_source_params(ctrl, msm_dp_panel);
>>   
>>   	msm_dp_ctrl_config_msa(ctrl,
>>   		ctrl->link->link_params.rate,
>>   		pixel_rate_orig,
>> -		ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420);
>> +		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420);
>>   
>> -	msm_dp_panel_clear_dsc_dto(ctrl->panel);
>> +	msm_dp_panel_clear_dsc_dto(msm_dp_panel);
>>   
>>   	msm_dp_ctrl_setup_tr_unit(ctrl);
>>   
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> index 5d615f50d13b..32196e97cbe9 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> @@ -17,7 +17,7 @@ struct msm_dp_ctrl {
>>   struct phy;
>>   
>>   int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
>> -int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl);
>> +int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
>>   int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
>>   void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
>>   void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 58c46d5ab4d8..1bf1335712bc 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -666,7 +666,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
>>   		return 0;
>>   	}
>>   
>> -	rc = msm_dp_ctrl_on_stream(dp->ctrl);
>> +	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
>>   	if (!rc)
>>   		msm_dp_display->power_on = true;
>>   
>>
>> -- 
>> 2.43.0
>>
> 

