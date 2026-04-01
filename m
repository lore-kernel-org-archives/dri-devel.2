Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726C0D35163
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD42610F063;
	Wed,  1 Apr 2026 09:43:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Itml+h1i";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HhvxZs4w";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D2710EA53
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 09:43:56 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6317jtT61004266
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 09:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q5zEIap66Dc7OLWAsu4xghw/A+bEZV1aEWioMMAJ35c=; b=Itml+h1iZo/qp9DQ
 VIUN62PT66x3t2V79LOG0TzdAQZM9qTbcUimbLPA9Jz8t2XIvdxO1B7B6FrQ6cz2
 KeYOCCVk3+0gVxD7Gp8aYOPC0YB55Q9+wXWPjKftxtDeht7qjFhsAbVQ9u5wf2VC
 6tp1ykNSzDRBx6KNFWqvd6K2v9J3BG9aYSm5EHjEpM+TqHX7kbmOzfXSNoPgqLhg
 g1U0xR9NK/GKYKTGvBvAak+iBIG5HXu0J9Wf4RDJ08n9Tvs17itmWge58zU4fMXF
 zlfTrRe8UFhzxd72V6XTJBJYV61PIbaRSzP2uG9WrIJuNJ3Dd6mzVBYNfDwqIPQ5
 wZGNtQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8tfjhp4n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 09:43:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c70f19f0f37so512006a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775036635; x=1775641435;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q5zEIap66Dc7OLWAsu4xghw/A+bEZV1aEWioMMAJ35c=;
 b=HhvxZs4wLJZIIDe6n7ayIxl/aSgf7Cd1fECFW0ReH/zjXFXmdNb6eNQ45R1m2OLsHB
 /2gzwiKJo98iTeBnGrDQKOrdT2339pPe7/wQQFResh7RFO+u1LE6dqxKpf0IghuSDs76
 C0KbjQI9gN+y756ycRBWUfIfkFip7mytwkiBa/b4/0dTabL8dlkcuxAHkkK6TIIln/HV
 vP8/lntLJ5EekIQlRcgJn3ebfcTz5WwEpaQhs6pCZEGjBzUOXNAPXpZV2LSb5nJqRHub
 kG+8Seg+fYmmpiY2lBe1LqN0Is5/6JnZ+lZAFp2sWa7BGGhnXe1AY7JieSPhwxyO4Gp4
 oDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036635; x=1775641435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q5zEIap66Dc7OLWAsu4xghw/A+bEZV1aEWioMMAJ35c=;
 b=B0Mpshu60yGusTAU4ZrQF/R0G39aUrPzpLniew68nbtAIvzaT5PiWCfDTMvtvYJaX8
 INDMdkF/k5NcYeU1pzTjubHd8FE68Kcr4nRbVLIEawnkEg84qF9Y4CZg7e2hBhSa8Luc
 XVR2RZynv4Okr/NSwyCmQoDIUwgpi7fuiqwoladJ+mwNZkiSxuW/Ker5u/iqhBArw/Dc
 BMKCJFuIAJ3oP3U/A4nRpn5bSbySJQSK5KByCiRTGKeRrdLDM/m4IJNttYGpzlpZevNo
 upA2SNYGpqnKHD+vH1NbzzUyf0hpi1C26FkJnb8FVaRcUbz1T69iEIG7E16GB4sS7UnU
 jWfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVpqPnQTX6S1kn+JmZiMRPTyDTZXAN3kMgc51tq42HKP9LP7woq82F0a6D3198hVZtECjmMURq2tc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOiQdOdkESbpkkuPhDZ06LcRam+NNPK1em8Lmg0uIN/Lt6qSVM
 pwzkZv5dS2HKRxWFzCZubql41bSEbmVODlvYlKj2Cze8mxo6JfGJkdfQn6A+DT7XPpHXGs/qapX
 0vu8x9l36TDUIXXmPHW05SkurXQMwE7SlUdi8AeyV1N5Sx1zaSpbo33aoRy7inCbBlO3tz9E=
X-Gm-Gg: ATEYQzx2yUdx9tX0GmK6pohDskgX9UDb2Icm44NvyNnpnQ6FiKjuhB+D6ghXvISfKHi
 3WHsqooCBQKXnJ5HdayTYp4eKVHLwzfxquEmPFXB7o38nlfsUAUpbuKYxu6YbBJhGR7dCb3W3Zd
 OTYVCASjZTek5bRgNX8LrEHV1WpulOM/jBbSfVBrqdRhGLqLCfs7W+mQQxcYLvS6P2tcU4tpvf1
 /pfmf/ggy4sUabSvbsPd0quC3mNLoJnJvrrhj6Q138vzTy0gCJSFbGwdSOTwSoIlD7ni8u75QRo
 z1KdpQ9sr3VETq1yzGCCQl9C3F38oSsbkHd5GqkupjvhHe9rRAsQUNEiqFhIvbYFqE+adWi35QR
 giaD1+lrygioJWvSbM/lVXX3FBtUQFlBDphd3C3Keq3i4AsBzKjyc74pYu+OPPWckL8g3U5M2bS
 6V65NrLFY1KbsSeh5g1g==
X-Received: by 2002:a05:6a20:9329:b0:39b:84c9:3861 with SMTP id
 adf61e73a8af0-39ef6d8e95dmr2018585637.14.1775036635141; 
 Wed, 01 Apr 2026 02:43:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:9329:b0:39b:84c9:3861 with SMTP id
 adf61e73a8af0-39ef6d8e95dmr2018549637.14.1775036634466; 
 Wed, 01 Apr 2026 02:43:54 -0700 (PDT)
Received: from [10.133.33.140] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76916baa53sm11599580a12.5.2026.04.01.02.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:43:54 -0700 (PDT)
Message-ID: <1698c35d-cefd-48b8-8776-c7deee000afc@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 17:43:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/38] drm/msm/dp: add dp_display_get_panel() to
 initialize DP panel
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
 <20250825-msm-dp-mst-v3-27-01faacfcdedd@oss.qualcomm.com>
 <smvfckejheyi7oehubdkhnh6pxokn7yugvlrynraypsu6kssj3@6vinswn4yku4>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <smvfckejheyi7oehubdkhnh6pxokn7yugvlrynraypsu6kssj3@6vinswn4yku4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: K0cmL4_MW-lG_mLvtCRpzQzn2zlQ5qSC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4NyBTYWx0ZWRfX9JExluBrrfEr
 wQvFcvMDASF7Km6KYqRM3sKbObxgaGXt2XNtMYUbRbdMXj/pVwdbia7s1yx7KON4BIZeg2abc/a
 INtzfTFfHJY3i8wbokP7ONVgHP/VuJAuduFVR9O6f6uvUNcSlTrkpqo9xyFkoWydiPl1lXC++gp
 xSzlqG7Si9T51kY6SmGk2ZP0iotXQ0ZE3UU5BQbSA4l2Tw0jrMvQiF+C1cFGTcFteApY9NtGx3W
 Cl59/caxfrQoEgDO388v2CWk7FEiJc4HMRz4t8T9X9Ghj/lJbmv6zSC/EA7IuczPMKaxJ/5nmu+
 SK8B0lsDdbaBUu3sjTa+cfWxz29ypEeZIgoI4ITDKQNiUS7G0umMIazNSqDyP7pX7/3QXCQQpaY
 TOz/Pf3IY9bjY8a5CCqBeW0IKO7ypHfm0EOmgwcTnEnZ2oC/hVDhfkcexyffAiHmW58nV4jSJZb
 tjBQat2Iq2AWAWzcV7w==
X-Authority-Analysis: v=2.4 cv=fJc0HJae c=1 sm=1 tr=0 ts=69cce8db cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=hAwsQ9a-qRDmXk3_GycA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: K0cmL4_MW-lG_mLvtCRpzQzn2zlQ5qSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010087
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



On 8/27/2025 12:33 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:13PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Add an API dp_display_get_panel() to initialize and return a DP
>> panel to be used by DP MST module. Since some of the fields of
>> DP panel are private, dp_display module needs to initialize these
>> parts and return the panel back.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 84df34306fb557341bea288ea8c13b0c81b11919..abcab3ed43b6da5ef898355cf9b7561cd9fe0404 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -632,6 +632,29 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
>>   	return 0;
>>   }
>>   
>> +struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display)
>> +{
>> +	struct msm_dp_display_private *dp;
>> +	struct msm_dp_panel *dp_panel;
>> +
>> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>> +
>> +	dp_panel = msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, dp->link,
>> +			       dp->link_base, dp->mst2link_base, dp->mst3link_base,
>> +			       dp->pixel_base);
>> +
>> +	if (IS_ERR(dp->panel)) {
>> +		DRM_ERROR("failed to initialize panel\n");
>> +		return NULL;
>> +	}
>> +
>> +	memcpy(dp_panel->dpcd, dp->panel->dpcd, DP_RECEIVER_CAP_SIZE);
>> +	memcpy(&dp_panel->link_info, &dp->panel->link_info,
>> +	       sizeof(dp->panel->link_info));
> 
> Both these lines show that link_info and dpcd belong to msm_dp_display
> rather than the panel. The panel should only be describing properties of
> the particular sink.
> 
I agree with your point.

This would require a larger cleanup of the panel abstraction, which
seems out of scope for this series. Could we address it in a separate 
refactoring series?

>> +
>> +	return dp_panel;
>> +}
>> +
>>   static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
>>   {
>>   	msm_dp_audio_put(dp->audio);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index b1ea027438d952c94f3ae80725c92e46c631bdb2..d5889b801d190b6f33b180ead898c1e4ebcbf8f3 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -65,4 +65,6 @@ void msm_dp_display_unprepare(struct msm_dp *dp);
>>   
>>   int msm_dp_display_get_active_stream_cnt(struct msm_dp *msm_dp_display);
>>   
>> +struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display);
>> +
>>   #endif /* _DP_DISPLAY_H_ */
>>
>> -- 
>> 2.34.1
>>
> 

