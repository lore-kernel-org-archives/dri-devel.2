Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE53C44512
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 02:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4A710E3F5;
	Fri, 17 Jul 2026 02:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ikpj56d1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nq1NEbhZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B40610E3F5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:41:24 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GNJHsW4180343
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xz4xt+e8dWjfcT2i2h4KEU0Pe4rwhXpno+W3ucpoTgI=; b=ikpj56d10f6FlWcj
 YQsrwb0GQxiYg+shzziyF6rXV8VZ5FqT4oK2cSOpCP6UrXbeoUQCT66OWDDmvvpv
 SnNh5LiDblL6vA8VyS337AOL0cXqw3EK2KeY4AFTE2mxsE/HLuKfxIi05k0NHluL
 +MfEkRXy2vqMmBeTyYp8VyBV7XvwdyoVis36/NVRymVXI9XeUIQkvHyfPcjf8ymD
 5DfOa1DAvDKVGMEKI+lBS3Fs3tHawbrBkZer0ymYkkI2nwvPCLdd9HotEZECXU/H
 icZMlVjrBLs6IWC5MZfOWybv51NIL1PFPMTSsnsL7rlgFJ5hvU9e7nBnqhPMVz20
 JssdLg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff2f2t52a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:41:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so20190905ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 19:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784256082; x=1784860882;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xz4xt+e8dWjfcT2i2h4KEU0Pe4rwhXpno+W3ucpoTgI=;
 b=Nq1NEbhZChqtTv3i5XOG06DJ3/jm5/08QImNktJK7nS5H61UYxJUfuIb7Zd+CWrmZM
 UtZdCnXVxKP+f5eHzW44SHtZbAZFywPiOPYsxVM6AAeRiBLCWbKyma4Q+DaLJ74M3G8Y
 //tuNfa6nZjUy1SfvINTH83BBciwVmbvrmsW0OVA81mnIJYcKI8/8A/G1xq4W+J71mXE
 2xsIFCE12F3Ot7sPtOK5bXagKnY1X0uefAfUn2yllwXsCElTixJKzhIhQGLfn8imb8Mp
 HR0SJxhZpV0sRHFSOYyDBsfdRlY/jofKXRYAv/lXINm4nhsuap6Sv1yP9QGFHrnzHQsR
 i40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784256082; x=1784860882;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xz4xt+e8dWjfcT2i2h4KEU0Pe4rwhXpno+W3ucpoTgI=;
 b=OjE/R1yPeXnZ7ImgthmKEV8GuFx0f/1valsoESy1zN3UKBLPeEqVJAYnfXpAuRuSuq
 XHVxXFLRYruHaVWO0V7T+B2G1IT3KjFCv7OTbFZEYCyTN0BlBp2FBpBH3R1bXWl7oXdL
 4tHdof8sN7rs20l9gk/Gni+VN3kqEFFgYq0DoAA7+V0UGrCk1p2oy+o2kDwntpzIuxkd
 EBM+jnvPxRsa17hbwLDC5dHZoRjCx9Sy1xiYpZhaALW7HPanTrHEoggZ+vEAoNVbaVwW
 6nIvyB6UIFqZhYmlW47KBVt+vCWWbayNS5Xy/mdmzIj/cqYtIoR/FOrX9olSvafkiAk3
 e8yg==
X-Gm-Message-State: AOJu0Yw2kNz0hqABxhn3Ml8tmhphfOeCYK56hx+CqNMge9ZzOQv33235
 MpjQNXqs1zsAwIB0Cby7MlHN0axyQ0iQqB5d/xQ+fStCpIQSnrPljNTMd4eEH6oxXDF8xy/Kr56
 NRl18rpKeaYvGqab6HhwNuA+SH9jE3xEAMGoT9y7P16EkVlx8F+2vGdnCP61iiWruQW5XSoc=
X-Gm-Gg: AfdE7cn8XudFMFqLX3qyIQqtdA7i0zB/F4or+HMHtWyPdU8yyB79/TvebVtLOZo6g1R
 dffzFqx8e7cNFTwd7wA2G6wxEX2DisgMifnNXcp6r+OMiXD1NXgZAzA+AERdPGzJYCgtV+x97+p
 I00SWNQTPpni9JviQkT3TbBwDi3ugvNKLD8TbkkIIui+2c+jUq/mUH/RtJywelWX5OaXtEB12CC
 4woBL/6GMY8BEnq+pre8brf6iYfM4Zqh3HOU+fGLlCSKBmyFoBGq8kz/ZJqQhmkaXoRCq4kBuRg
 HWJJ+KSKkvPhSBYqbA17rxz8Kjan0YdvUUGa/UxjalDfrhA4tjuP+0KPR+YuhojkZ4OpFoXI2d5
 Gk8JJrlOnsXHg/Y3F7tlYEcLd1SyBbAPSYhXpkM+NOcJRI4uq4w+gfkxUebwOAUNC0g70cn2A
X-Received: by 2002:a17:903:26c7:b0:2cc:92ae:b36 with SMTP id
 d9443c01a7336-2cf1f5495a3mr51951805ad.24.1784256081807; 
 Thu, 16 Jul 2026 19:41:21 -0700 (PDT)
X-Received: by 2002:a17:903:26c7:b0:2cc:92ae:b36 with SMTP id
 d9443c01a7336-2cf1f5495a3mr51951605ad.24.1784256081309; 
 Thu, 16 Jul 2026 19:41:21 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf344cf96bsm2363225ad.28.2026.07.16.19.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 19:41:21 -0700 (PDT)
Message-ID: <406d1c3b-cf7f-44e9-8de5-7e397ff4cf84@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 10:41:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: Re: [PATCH v7 07/15] drm/msm/dp: move the pixel clock control to its
 own API
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260609-dp_mstclean-v7-7-ea04113e8233@oss.qualcomm.com>
 <20260609100437.758151F00899@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260609100437.758151F00899@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6-wwljSiFqbDgucdZR3RguAyJ36PGRJN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfX67ia/N2YYmFv
 EoceqLJMVmrokFfWHT8rahkSV9D23paQ7sZaj/a3vKQKQ7QZmqOvBu6NdPExCOg8qxMUhEhi5FE
 xc5HLTZDUev+DD5SWkgecMCxWN903+8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfX4auRMa85iuNi
 O1BlKXrVcEjvuYHbGbpfHAdUKOFAn2zg3iSn1vuRSvX/9NFBsR3sjiCbOzhGOLKt/fQ1Rcq17+N
 NTMIkWdJUE/sqJEHjbufnwrDXCT8HxegCuc7hF6Seufw+JOSWUs9rNNPU2jqy1HYftTb6ZJm8k6
 olYMdPwW0Gj42PaOWjAeAz2dxcOHg+8vCgutln17KFP3O/tux4RHuLw/NbkigtgtEICA+Snw+z/
 APnvJj4gEVTCuHpG4wn2jVEHEHGLVlZnvZUxIYoSsCt6G3SFOwBit+n3iqF+bEeuSKBE7PyP0Lc
 pnvbEHTF9LLcG6AqnpTrUVPt5ydvfEtSL8MV38/aX/9yEEpgFernjRTTI3YxOdVRtGEI+4oEqZT
 3ACqp+uVT2VHq568g7WHlayz1eIgCScCDZwkFlHAl02uO25dlM9PWDwuq24otR+cX4dj37Mk6Bc
 Hhi+Cejulrh4i4xNADg==
X-Authority-Analysis: v=2.4 cv=NcTWEWD4 c=1 sm=1 tr=0 ts=6a599652 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tIJq6jK7UZ6rIIlOuEwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 6-wwljSiFqbDgucdZR3RguAyJ36PGRJN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170023
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



On 6/9/2026 6:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Unhandled error return from `msm_dp_ctrl_on_pixel_clk()` causing potential system crash.
> - [High] Invalid `WARN_ON_ONCE` escalation leading to potential Denial of Service (DoS) on hardware timeouts.
> 
> Pre-existing issues:
> - [High] Lockless concurrent access to `ctrl->stream_clks_on` between DRM atomic commit and HPD IRQ threads.
> --
> 
> commit 4ab86d41ec16eead989a4b3a8579ccd95556770a
> Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 
> drm/msm/dp: move the pixel clock control to its own API
> 
> Enable/Disable of DP pixel clock happens in multiple code paths
> leading to code duplication. Move it into individual helpers so that
> the helpers can be called wherever necessary.
> 
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 1c2eccec6ec6d..a2c44088e6a68 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -2171,6 +2171,41 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
>>   	return success;
>>   }
>>   
>> +static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
>> +{
>> +	int ret;
>> +
>> +	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
>> +	if (ret) {
>> +		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (WARN_ON_ONCE(ctrl->stream_clks_on))
>> +		return 0;
> 
> [Severity: High]
> Does this WARN_ON_ONCE() introduce a potential system crash with panic_on_warn
> enabled?
> 
> If msm_dp_ctrl_wait4video_ready() in msm_dp_ctrl_on_stream() times out, the
> function returns an error but leaves ctrl->stream_clks_on as true. This causes
> the caller, msm_dp_display_enable(), to refuse setting
> msm_dp_display->power_on = true.
> 
> Later, on teardown, msm_dp_display_disable() bails out early because power_on
> is false, skipping msm_dp_ctrl_off_pixel_clk() and leaving
> ctrl->stream_clks_on as true.
> 
> On the next modeset or hotplug attempt, when msm_dp_ctrl_on_pixel_clk() is
> called again, it will trigger this newly added warning. Since external
> display hardware timeouts can be triggered by a faulty sink, is it safe to
> escalate this from the previous debug print to a warning?
> 
No, it is okay, printing the call stack can help identify the issue.
> [Severity: High]
> This is a pre-existing issue, but does lockless concurrent access to
> ctrl->stream_clks_on between DRM atomic commit and HPD IRQ threads risk a NoC
> error?
> 
> The boolean flag ctrl->stream_clks_on and the pixel clock are accessed and
> modified in msm_dp_ctrl_on_pixel_clk() and msm_dp_ctrl_off_pixel_clk()
> without any synchronization primitives.
> 
> msm_dp_ctrl_on_pixel_clk() can be executed by the DRM atomic commit thread
> while the asynchronous HPD IRQ worker thread simultaneously handles a PHY test
> request via msm_dp_ctrl_process_phy_test_request(). If Thread 1 evaluates
> ctrl->stream_clks_on as true to disable the clock concurrently with Thread 2
> accessing DP PHY registers, can it lead to a synchronous external abort when
> accessing unclocked DP registers?
> 
>> +
>> +	ret = clk_prepare_enable(ctrl->pixel_clk);
>> +	if (ret) {
>> +		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +	ctrl->stream_clks_on = true;
>> +
>> +	return ret;
>> +}
>> +
>> +static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
>> +{
> 
> [ ... ]
> 
>> @@ -2196,22 +2231,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>>   	}
>>   
>>   	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
>> -	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
>> -	if (ret) {
>> -		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	if (ctrl->stream_clks_on) {
>> -		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
>> -	} else {
>> -		ret = clk_prepare_enable(ctrl->pixel_clk);
>> -		if (ret) {
>> -			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
>> -			return ret;
>> -		}
>> -		ctrl->stream_clks_on = true;
>> -	}
>> +	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
>>   
>>   	msm_dp_ctrl_send_phy_test_pattern(ctrl);
> 
> [Severity: High]
> Does this code ignore the return value of msm_dp_ctrl_on_pixel_clk()?
> 
> In msm_dp_ctrl_process_phy_test_request(), ret is assigned from
> msm_dp_ctrl_on_pixel_clk(), but it isn't checked before calling
> msm_dp_ctrl_send_phy_test_pattern().
> 
> If clock enablement fails (e.g., due to an unsupported clock rate requested by
> a malicious DP sink), the function unconditionally proceeds to send the PHY
> test pattern. Will accessing DP PHY and mainlink hardware registers without
> the required clock running trigger a synchronous external abort and panic the
> kernel?
> 
will fix next patch.
