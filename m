Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF32DC4450A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 02:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B02610E3A7;
	Fri, 17 Jul 2026 02:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J6jmmr8L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c7LRMQYN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E3710E3A7
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:40:56 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GNIhJH010543
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TZVeb1FG1OCtjsr9mqY6kcodNvD8xgUw/91muIII8Fk=; b=J6jmmr8LRoSk0uU8
 oA+FIgoUfE7Vo40VCu14xNBIqhiEZZZ5czkhoZG9UdctBdsvQ2wiuuQ/lAq+1kpH
 puWlcSyvAxUyOqiNn30v835tCbi1ov697dmeAR/onl5bZGl1Cg5+DxbYvzYZA+D6
 uDG+8JQLe+HFoYegL6Tpd5KGSPVbVMSbnJYGDispOoWQmXiQ97wMhdwamc8auaBD
 4nxk5fuLDwVpapKDnD/MZKqtOg85vpDESZkNN1cdtc6mxAOXclPtkotfc5aSo8YU
 fVuhVP/4qSY3fZHGcCITPy7/0YPa4HyTzSW+mJK2kOC3u0OR1RYre3QQswOjacWs
 rFz6GQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex47s7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:40:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8488ac68185so13110672b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 19:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784256054; x=1784860854;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TZVeb1FG1OCtjsr9mqY6kcodNvD8xgUw/91muIII8Fk=;
 b=c7LRMQYNdSz1VTr9DwzFBhYENtvEfDuRwj/YhzyRXKEKNfLr6zbf4PfXGQ2KDp2Eio
 szIMUS7gXsecrpdiQJWpmZQw3lhIRaoknW1Eg06nQCvfbELKoyB79JfEtWz//9bGX4EL
 6mL7S4/hNwgDm4HOaK/aF+04RuVQSVPJYEhfNioa/+79rZJj6DIyUtKN8euNKfhiGS6f
 /OpCZEtkdkGJ+JgOCWHskrzdreAOSt4aKye1JtA5U1Bhlx52zJh2CUhcELvhQmKK7c1G
 AJHnCo5atTePdJt9gHQsbSMSRQdd6JAS4yAAgFf43uMjYgbaFbfu3DeADsu/UCydmvY/
 VZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784256054; x=1784860854;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TZVeb1FG1OCtjsr9mqY6kcodNvD8xgUw/91muIII8Fk=;
 b=aU2HUJL0At724MAKKKR81oVJbnS2Biga7NofAOwOc0gf+5nCn4RhdHVZPpgdZyV2em
 NhZM3XosNeOHiq5cOzBbXj94Io39hyU+QS+LwxsS+teupN7YaEPD5ypGEJ8slONA/58i
 Sx6xLerlOXHxW/9s3x+FJuC1XVOgTvqhFXwAyYBu2staNY0LCrPV2OBt3SkGScS8xoxO
 o7O4tq8j3NGtSxBX1qH0CWRluKC6kb51bExmtt9odhxr4OijxeFtxNE8uYn6L0ZbZtcx
 fX7PSu2ni+TdUHoklYaymRM/jACnRKAVtRzNOn92gtECyjuwftDhRZiUlvNF3ABifPGl
 CUpA==
X-Gm-Message-State: AOJu0Yy+QAQPVjX2OxbtIk+BtGr4L1SL9TZyoI9lFjGd1nGG6E6Q6OzK
 zF/D0nAF+VXJ7yCASQKog4kH36KF33weuprcBnkxi/qZ+9uBufFdY1naCjcojhrV9D3z/8Q79uz
 0ZiVA687M1w6Yr++c1mFWfTdin0V+WspHjbu7atCiDSDejAZVBw+PULm+4cB3+cQMx6Yns54=
X-Gm-Gg: AfdE7ckoy8Vrf6msLyIiKXExV0Dh7euMLKnLpMIGmwoc8zC/7Q3gKUYEmhGxbjJ1SEG
 YoDAbhFWfSJKS6W8KeIMo6es/bfn2r+frudRilFzrr9fZp4/WoHC5G6oR4I4Vmgfdy8PCed8a+f
 VGzw2cC63cxL8de2Lv/lKSrCBYcftNf3HdcPa0KK77aPm2v2PEjPyPFeoqaf4EKWixvJKR8RcJk
 Cl8Z8usklNXzzkAG7F75hLeiQNpCLv+HqGXFDEdEK/d9ygHfv6eKvvn0lNPjDU1hWK+x9qVA2Kr
 GU4s3t2rnM2hTPpiy52DAbyVxGwxZV+QaLlWbEHVoX9z8NX0kE4g7JRdpLVT2lJhH4y9mmeC5c9
 ARqtT21hcsEGigx2Xr5k+PzOoadbE7E1gm9TA4TOpBcFlKrV2j6uuYj0Jhj5UxZ9y8rZ76CX3
X-Received: by 2002:a05:6a00:278a:b0:848:2f84:f42e with SMTP id
 d2e1a72fcca58-84c294d4dd5mr547733b3a.71.1784256053880; 
 Thu, 16 Jul 2026 19:40:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:278a:b0:848:2f84:f42e with SMTP id
 d2e1a72fcca58-84c294d4dd5mr547719b3a.71.1784256053348; 
 Thu, 16 Jul 2026 19:40:53 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb51a2c1b0dsm146689a12.30.2026.07.16.19.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 19:40:52 -0700 (PDT)
Message-ID: <ab9b496e-9329-480a-ac4a-46d468d4fe9b@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 10:40:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: Re: [PATCH v7 02/15] drm/msm/dp: drop deprecated .mode_set() and use
 .atomic_enable
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260609-dp_mstclean-v7-2-ea04113e8233@oss.qualcomm.com>
 <20260609100657.8935F1F00893@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260609100657.8935F1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a599637 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UyEoFrDdOu127hDhB3kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: SHSCIewzh_ZjDcO3IyHAsy_4xuQB5Yjt
X-Proofpoint-GUID: SHSCIewzh_ZjDcO3IyHAsy_4xuQB5Yjt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfX3qWP1H6XabeK
 O3p3aYxsnhErc08egMDE57O8TTyvJrlNCYKCAQgC5ZDNhBrIoKOvNuC8p34adDLGklEXW33+scY
 rKVocep3ddgdO9JFnKN/fkGRrSoKBJo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfXxkbdw03Lf3aa
 FQxQvRxHSJjnNoj+Mc8erBW6B1IUuFsVfBk2Qs4D0EV4nSthdTYcfahVsbXsjgkygDqg9500/TU
 KQwOhsbXM59rOSk3fa9Upjmxzl6y80Yt6PPphyP51/+W32roYukTQ02uMpVjiNr1x675DYVOy0A
 J+B9tAzAFdc//zKQ5l/4x6+/2TJTW7Gn6Whs5Sj8Tk4KuhA4dED6RlTtXz/ZpIGO3tGLFPsky01
 a0D7VoiThSww3FgSw3tN0IAE/SsjBmI6fkdCWeP6seq3Go4D2iQt7oUeksnXxGcR7iESLyhYH67
 Qk9opK2kMC/qlmHtEerum7vINA1Ob5ucEzbeZWgVU38rjgXsKh+4B5hU4cCqw01JWR0wsirBX5M
 gLG3XGmVPDNsR1K8gOuTza9sbCY77XFGF3GMrJKMU1QTVAIUWqhdtN0I6j5syKt4M4gXie7nY0Z
 A6eK5+SF6l0/BGQcp+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170023
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



On 6/9/2026 6:06 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Moving mode setup to `.atomic_enable` causes the upstream DPU encoder to read stale wide-bus configuration data during its own enablement.
> 
> Pre-existing issues:
> - [High] Mode validation callback incorrectly evaluates wide bus availability based on the state of the currently active mode rather than the candidate mode.
> --
> 
> commit 1b0de5b490fbc6b7e19b00f71948fa7d36954fe7
> Author: Yongxing Mou<yongxing.mou@oss.qualcomm.com>
> 
> drm/msm/dp: drop deprecated .mode_set() and use .atomic_enable
> 
> The bridge .mode_set() callback is deprecated. Remove it and move all
> mode setup logic to .atomic_enable(), where the adjusted_mode is
> available from the atomic CRTC state.
> 
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index bce165bac106b..57eafd4724627 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> [ ... ]
> 
>> @@ -1309,7 +1325,7 @@ bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
>>   
>>   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> -	if (dp->msm_dp_mode.out_fmt_is_yuv_420)
>> +	if (dp->panel->msm_dp_mode.out_fmt_is_yuv_420)
> [Severity: High]
> This isn't a bug introduced by this patch, but doesn't this function
> check the currently active mode's format rather than the candidate mode's
> format?
> 
> During mode validation in msm_dp_display_mode_valid(), the driver calls
> msm_dp_wide_bus_available() to adjust pixel clock limits. Since this reads
> the active mode's YUV420 state, wouldn't it incorrectly assume wide bus is
> unavailable for a candidate RGB mode if the currently active mode happens
> to be YUV420?
> 
> This might cause valid high-resolution RGB modes to be rejected because
> their clock exceeds DP_MAX_PIXEL_CLK_KHZ. Additionally, isn't this reading
> a state field that could be locklessly mutated by concurrent atomic commits?
> 
>>   		return false;
>>   
>>   	return dp->wide_bus_supported;
> [ ... ]
> 
>> @@ -1386,7 +1406,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>>   	if (msm_dp_display->link->sink_count == 0)
>>   		return;
>>   
>> -	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
>> +	rc = msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_display->panel);
> [Severity: High]
> By moving the mode setup here into the bridge's .atomic_enable callback,
> could this cause the upstream DPU encoder to read stale wide-bus
> configuration data?
> 
> The DRM atomic helper sequence executes the encoder's .atomic_enable hook
> before the bridge's .atomic_enable hook. In the encoder's enable sequence:
> 
> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:dpu_encoder_virt_atomic_enable()
>      dpu_enc->wide_bus_en = dpu_encoder_is_widebus_enabled(drm_enc);
> 
> This calls down to msm_dp_wide_bus_available(), which checks the
> out_fmt_is_yuv_420 flag.
> 
> Since the bridge hasn't updated its mode state yet via
> msm_dp_display_set_mode(), won't the encoder read the stale value from the
> previous modeset?
> 
> This seems like it could incorrectly enable or disable wide bus support
> when switching between RGB and YUV420 modes, potentially leading to a
> hardware configuration mismatch and display corruption.
> 
The two reported issues are essentially the same underlying issue. A 
proper fix would require moving the YUV420 format selection into 
.atomic_check(), similar to how other DRM drivers handle output format 
selection. However, the MSM DP bridge currently lacks an .atomic_check() 
implementation, and introducing one would be a larger change outside the 
scope of this series.

Furthermore, the affected scenario is limited to rare YUV420-only mode 
configurations, so I don't think it should block this patch series.
>>   	if (rc) {
>>   		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
>>   		return;
> -- Sashiko AI review · https://sashiko.dev/#/patchset/20260609- 
> dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com?part=2
> 

