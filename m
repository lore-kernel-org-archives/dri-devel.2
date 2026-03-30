Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD09DFB3CFF
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE2B10E5E1;
	Mon, 30 Mar 2026 10:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Frx6HOcW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AvT/gMwc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C03D810E5E1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:28:02 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U7auTD364830
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Au0+UaYP+ntDqPVDj//xioTgR28L/odTVuFYIMKg21o=; b=Frx6HOcWxje+IL8O
 mZX8p9EwS0PsUO1y81CZn17WjfrG2q9BILudL0olOvL7VM8TF3oLSlJKIT396rzD
 pLs5e2iTgGFls2Oayy6fYVClNIlmweVsCvODkWIPoDcDqcbxqv/8dcElIf7eYDgR
 cJXNnnxUfOS3fEE6XygVg51kFnSCLMP93aPK8aMZNcoORHOW4WL3jTRvj4O1KKaw
 ybgoM9qAywDVJZZcqDvcbgkCUhjDYQRtLxav+Dw9GbjQJ2+HnSAii6Bg1AnqglSU
 KhnrSAhw2YYZCdfkAYFxtIvlE2OOzLx6AvFcC9c8YmNqVqxMLgbw+LOlPpN+bkIX
 eCCIgw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6wqekjhd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:28:02 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c741a9ef5f0so2884848a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774866481; x=1775471281;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Au0+UaYP+ntDqPVDj//xioTgR28L/odTVuFYIMKg21o=;
 b=AvT/gMwcoJOzNyvBKm0aeCd71+JncZc3GMcddxY3NsRKtSC+fSqW15OTlbhX16mL4i
 SSrUkDO7BwMwwuwI+yPjYJ77k4y5c4Qce5Ag8/tu+ViDJjWqX+VBKZC36R7x6VPAgjld
 TBocuuoE/l60alBsejg2tUVHRos+PTvOtZZdnpEDTp+N4BnAwFNd1KXShK+akhP4vnDC
 cmPhCzEYiFIeBqemgxQ/AJ8ZRkDxC7H2GQNKFTSYklHImLVeDnImsk9ljjOnCGPNqGao
 KLwKkeMCdA941Va0Bg2KqDWnh8jGly2kWy1pty6AQSir2cB+Wb3c86+aAVYIBtP7G1KG
 zdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774866481; x=1775471281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Au0+UaYP+ntDqPVDj//xioTgR28L/odTVuFYIMKg21o=;
 b=WZMFcm+XUuuPpFaxGEMq3YrVQ3tgcXOy1aLOntPQLFeuqhLXf7t9ETAIv43TlUHAtd
 DVTmCAYD/1uEjR0lOIbgVxtJOnMB0H2PBKTq5hYAWKtXdoXLegCfbYkJ2DYIJ+7VxAno
 uBsBw8wG6AaVwbts+rQgDWcRsG3MkCsUf8++TkuU1XmJWDW7EWzHQmaS+xkz5a6T0W9I
 oYWrFWgSN3Z6Uxn2eUnzxJUfZ/ijGhjoX/4ansxEAXc8wdKDv/89W+VNoDtJzjH7a2pB
 y2Qt8oOQYdgImlQqISqLzCD/sfU1y5NhrUG7SfX/wZOhWPHNjr52XCVa8taEc1yw/vfu
 wpWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo3T2lZCkdCtDqYuDdnP0czorrWBole/mNGrKuELURF3HhMWyqfqacSl/bxkAxtUsWhcTA9GrOrnI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtP3HXFvqm/TWDVu3uORGplJ0Mlo8FaG9xhUiCdg+87ak3N0VM
 qkcH7RtATvSKrDWH+JNI3WanhbtYqf6V7LqrfIMDgzUa/O9wfmun92SGD632HghXf6v7AM+aPp/
 BtYpnJHJbm8oSRSu19PmVRNVExbTvsDcbsgAs4cmhmJkWDSvHWwWs0nYeDlqWiDwoYTYBMTE=
X-Gm-Gg: ATEYQzwmgKmGoBjtJaP6k9IWr6dxsP+GnDluNlDi9YLu0G5iw10Mmhezq9hOQjm3Csp
 Uzj5OvkCuc5avOhY0+yZELyLTuLg5/8Q6cPbXrC3qH7C3RERk/CqpVFuQHBckgIyKcvcmBpA4rm
 Ox+UaDG6/niO1/C22uTRcV10q6EYgESahO6y/GBGcDGVLPRNxEOLXGUPcaA8z6jEzfr5tQNsTIk
 DN9RMfFE5ShSQFpgmNoCRSFRYHXXIGK2SbV7QbeKczOzU7PrRDw6TcwvUviVbNu2ZFj4zFOzROG
 +MZ5knpta9NdYx6CGT+nHOR7GTKpRjuQNPw+kY+EaTUdROFeOX4rg0UM8ulj1na97W106ztGvep
 UbLq8WXZNPVTYjzF2kU9AC4m8xfKSPdLdsesD+/mjjiny6DiO
X-Received: by 2002:a05:6a21:3086:b0:39c:3543:b8ca with SMTP id
 adf61e73a8af0-39c8abcccdamr11068009637.29.1774866481394; 
 Mon, 30 Mar 2026 03:28:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:3086:b0:39c:3543:b8ca with SMTP id
 adf61e73a8af0-39c8abcccdamr11067989637.29.1774866480862; 
 Mon, 30 Mar 2026 03:28:00 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76917ba961sm5599108a12.25.2026.03.30.03.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 03:28:00 -0700 (PDT)
Message-ID: <bd0fa742-fcba-47a8-81fa-aa43d9ff4edd@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 18:27:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/38] drm/msm/dp: Add support for programming p1/p2/p3
 register blocks
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
 <20250825-msm-dp-mst-v3-14-01faacfcdedd@oss.qualcomm.com>
 <34he7xawyuq5z4iiyq4y4ehkjhfalx2vxhtejgyxly4zgyqma7@4uqoas4sz3nl>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <34he7xawyuq5z4iiyq4y4ehkjhfalx2vxhtejgyxly4zgyqma7@4uqoas4sz3nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Jo78bc4C c=1 sm=1 tr=0 ts=69ca5032 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=OvTKcA9ML1xih0zlansA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DitduWLx0HA__DQXXp5Ns5DHDfHNKr7R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4MiBTYWx0ZWRfX3gm4XiyDl6pw
 PTOuFESd9GSFcqMTLUJPEueqdzmpVbn8WyMafXA8fbRn06KWAHtzKEQ2l+5V5p9QNCvjknr2O79
 vlGV5TULCu0RmuR1Gwc05MF3Edi37JNhaNqWyMXLHf/hpauqMKCUXNOm+OwKCESXS1snL660pU7
 usIL9mlrFeQEc4m3gjXi6beR1LiBTeg1EXQte8aL8kOREzNqeHfJutepbnyvxRlQeU+HL9KE19D
 twY/v/CDGuSQ06o+BjZjhVhVr5LXbO8gR+fmEd/fLQbyBhcxwxP3m/jGJPNrWr70pl/6M/65Khe
 RNNwdWGFznCAt1xoQhQ75PJ4QkN8G/ybF0PRNN1q0v2S1ECx605+7Iu+oBeJXZpg19Fgi80sV9z
 q96AeLRVOSqMXTu/7FvS1jpUmHpkI3zzLrcpq8G1lM7Y6DvyxakV7XgkgKpqW7TvFDsglYfRBFu
 2rRqcl+3VpW0hVRr0rA==
X-Proofpoint-ORIG-GUID: DitduWLx0HA__DQXXp5Ns5DHDfHNKr7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300082
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



On 8/26/2025 1:59 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:00PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> QCS8300 supports 4-stream MST. This patch adds support for the additional
>> pixel register blocks (p1, p2, p3), enabling multi-stream configurations.
>>
>> To reduce code duplication, introduce helper functions msm_dp_read_pn and
>> msm_dp_write_pn. All pixel clocks (PCLKs) share the same register layout,
>> but use different base addresses.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 39 +++++++++++++--------
>>   drivers/gpu/drm/msm/dp/dp_panel.c   | 68 ++++++++++++++++++-------------------
>>   2 files changed, 59 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 3422f18bdec71a99407edfe943d31957d0e8847a..935a0c57a928b15a1e9a6f1fab2576b7b09acb8e 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -84,8 +84,8 @@ struct msm_dp_display_private {
>>   	void __iomem *link_base;
>>   	size_t link_len;
>>   
>> -	void __iomem *p0_base;
>> -	size_t p0_len;
>> +	void __iomem *pixel_base[DP_STREAM_MAX];
>> +	size_t pixel_len;
>>   
>>   	int max_stream;
>>   };
>> @@ -619,7 +619,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>>   		goto error_link;
>>   	}
>>   
>> -	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->p0_base);
>> +	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base);
> 
> Why do we need to pass pixel base here? Shouldn't it be pixel_base[P0]?
> 
In the current implementation, dp->panel holds the full 
pixel_base[DP_STREAM_MAX] instead of just the pixel base corresponding 
to itself, so this likely needs to be revisited.

>>   	if (IS_ERR(dp->panel)) {
>>   		rc = PTR_ERR(dp->panel);
>>   		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
>> @@ -937,8 +937,8 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>>   				    msm_dp_display->aux_base, "dp_aux");
>>   	msm_disp_snapshot_add_block(disp_state, msm_dp_display->link_len,
>>   				    msm_dp_display->link_base, "dp_link");
>> -	msm_disp_snapshot_add_block(disp_state, msm_dp_display->p0_len,
>> -				    msm_dp_display->p0_base, "dp_p0");
>> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
>> +				    msm_dp_display->pixel_base[0], "dp_p0");
> 
> This should add all blocks used on this platform.
> 
Let mark to be done here. Since a helper function is required here to 
check whether the pixel clocks for stream 1/2/3 are really enabled.
>>   }
>>   
>>   void msm_dp_display_set_psr(struct msm_dp *msm_dp_display, bool enter)
>> @@ -1181,12 +1181,13 @@ static void __iomem *msm_dp_ioremap(struct platform_device *pdev, int idx, size_
>>   #define DP_DEFAULT_AUX_SIZE	0x0200
>>   #define DP_DEFAULT_LINK_OFFSET	0x0400
>>   #define DP_DEFAULT_LINK_SIZE	0x0C00
>> -#define DP_DEFAULT_P0_OFFSET	0x1000
>> -#define DP_DEFAULT_P0_SIZE	0x0400
>> +#define DP_DEFAULT_PIXEL_OFFSET	0x1000
>> +#define DP_DEFAULT_PIXEL_SIZE	0x0400
> 
> No need to touch this. It's only required for legacy bindings.
> 
Thanks, will fix it.
>>   
>>   static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>>   {
>>   	struct platform_device *pdev = display->msm_dp_display.pdev;
>> +	int i;
>>   
>>   	display->ahb_base = msm_dp_ioremap(pdev, 0, &display->ahb_len);
>>   	if (IS_ERR(display->ahb_base))
>> @@ -1206,7 +1207,7 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>>   		 * reg is specified, so fill in the sub-region offsets and
>>   		 * lengths based on this single region.
>>   		 */
>> -		if (display->ahb_len < DP_DEFAULT_P0_OFFSET + DP_DEFAULT_P0_SIZE) {
>> +		if (display->ahb_len < DP_DEFAULT_PIXEL_OFFSET + DP_DEFAULT_PIXEL_SIZE) {
>>   			DRM_ERROR("legacy memory region not large enough\n");
>>   			return -EINVAL;
>>   		}
>> @@ -1216,8 +1217,10 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>>   		display->aux_len = DP_DEFAULT_AUX_SIZE;
>>   		display->link_base = display->ahb_base + DP_DEFAULT_LINK_OFFSET;
>>   		display->link_len = DP_DEFAULT_LINK_SIZE;
>> -		display->p0_base = display->ahb_base + DP_DEFAULT_P0_OFFSET;
>> -		display->p0_len = DP_DEFAULT_P0_SIZE;
>> +		for (i = DP_STREAM_0; i < display->max_stream; i++)
>> +			display->pixel_base[i] = display->ahb_base +
>> +						 (i+1) * DP_DEFAULT_PIXEL_OFFSET;
>> +		display->pixel_len = DP_DEFAULT_PIXEL_SIZE;
>>   
>>   		return 0;
>>   	}
>> @@ -1228,10 +1231,18 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>>   		return PTR_ERR(display->link_base);
>>   	}
>>   
>> -	display->p0_base = msm_dp_ioremap(pdev, 3, &display->p0_len);
>> -	if (IS_ERR(display->p0_base)) {
>> -		DRM_ERROR("unable to remap p0 region: %pe\n", display->p0_base);
>> -		return PTR_ERR(display->p0_base);
>> +	display->pixel_base[0] = msm_dp_ioremap(pdev, 3, &display->pixel_len);
>> +	if (IS_ERR(display->pixel_base[0])) {
>> +		DRM_ERROR("unable to remap p0 region: %pe\n", display->pixel_base[0]);
>> +		return PTR_ERR(display->pixel_base[0]);
>> +	}
>> +
>> +	for (i = DP_STREAM_1; i < display->max_stream; i++) {
>> +		/* pixels clk reg index start from 3*/
>> +		display->pixel_base[i] = msm_dp_ioremap(pdev, i + 3, &display->pixel_len);
>> +		if (IS_ERR(display->pixel_base[i]))
>> +			DRM_DEBUG_DP("unable to remap p%d region: %pe\n", i,
>> +					      display->pixel_base[i]);
>>   	}
>>   
>>   	return 0;
>> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
>> index eae125972934bb2fb3b716dc47ae71cd0421bd1a..e8c1cf0c7dab7217b8bfe7ecd586af33d7547ca9 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
>> @@ -26,7 +26,7 @@ struct msm_dp_panel_private {
>>   	struct drm_dp_aux *aux;
>>   	struct msm_dp_link *link;
>>   	void __iomem *link_base;
>> -	void __iomem *p0_base;
>> +	void __iomem *pixel_base[DP_STREAM_MAX];
>>   	bool panel_on;
>>   };
>>   
>> @@ -45,24 +45,24 @@ static inline void msm_dp_write_link(struct msm_dp_panel_private *panel,
>>   	writel(data, panel->link_base + offset);
>>   }
>>   
>> -static inline void msm_dp_write_p0(struct msm_dp_panel_private *panel,
>> +static inline void msm_dp_write_pn(struct msm_dp_panel_private *panel,
>>   			       u32 offset, u32 data)
> 
> Is it really multiplexed on the panel level? I'd assume that each panel
> is connected to only one stream instance... If that's not the case, such
> details must be explained in the commit message.
> 
Yes, each panel is connected to only one stream instance. We just use 
**pixel_base + stream_id to determine which pixel block the request 
should be sent to. Just like your first comment, do you mean that the 
panel should only carry the pixel block address corresponding to itself, 
rather than the 4 blocks?
>>   {
>>   	/*
>>   	 * To make sure interface reg writes happens before any other operation,
>>   	 * this function uses writel() instread of writel_relaxed()
>>   	 */
>> -	writel(data, panel->p0_base + offset);
>> +	writel(data, panel->pixel_base[panel->msm_dp_panel.stream_id] + offset);
>>   }
>>   
>> -static inline u32 msm_dp_read_p0(struct msm_dp_panel_private *panel,
>> +static inline u32 msm_dp_read_pn(struct msm_dp_panel_private *panel,
>>   			       u32 offset)
>>   {
>>   	/*
>>   	 * To make sure interface reg writes happens before any other operation,
>>   	 * this function uses writel() instread of writel_relaxed()
>>   	 */
>> -	return readl_relaxed(panel->p0_base + offset);
>> +	return readl_relaxed(panel->pixel_base[panel->msm_dp_panel.stream_id] + offset);
>>   }
>>   
>>   static void msm_dp_panel_read_psr_cap(struct msm_dp_panel_private *panel)
>> @@ -297,33 +297,33 @@ static void msm_dp_panel_tpg_enable(struct msm_dp_panel *msm_dp_panel,
>>   	display_hctl = (hsync_end_x << 16) | hsync_start_x;
>>   
>>   
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_HSYNC_CTL, hsync_ctl);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_VSYNC_PERIOD_F0, vsync_period *
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_HSYNC_CTL, hsync_ctl);
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_VSYNC_PERIOD_F0, vsync_period *
>>   			hsync_period);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_VSYNC_PULSE_WIDTH_F0, v_sync_width *
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_VSYNC_PULSE_WIDTH_F0, v_sync_width *
>>   			hsync_period);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_VSYNC_PERIOD_F1, 0);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_VSYNC_PULSE_WIDTH_F1, 0);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_DISPLAY_HCTL, display_hctl);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_HCTL, 0);
>> -	msm_dp_write_p0(panel, MMSS_INTF_DISPLAY_V_START_F0, display_v_start);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_DISPLAY_V_END_F0, display_v_end);
>> -	msm_dp_write_p0(panel, MMSS_INTF_DISPLAY_V_START_F1, 0);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_DISPLAY_V_END_F1, 0);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_V_START_F0, 0);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_V_END_F0, 0);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_V_START_F1, 0);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_V_END_F1, 0);
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_POLARITY_CTL, 0);
>> -
>> -	msm_dp_write_p0(panel, MMSS_DP_TPG_MAIN_CONTROL,
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_VSYNC_PERIOD_F1, 0);
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_VSYNC_PULSE_WIDTH_F1, 0);
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_DISPLAY_HCTL, display_hctl);
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_HCTL, 0);
>> +	msm_dp_write_pn(panel, MMSS_INTF_DISPLAY_V_START_F0, display_v_start);
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_DISPLAY_V_END_F0, display_v_end);
>> +	msm_dp_write_pn(panel, MMSS_INTF_DISPLAY_V_START_F1, 0);
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_DISPLAY_V_END_F1, 0);
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_V_START_F0, 0);
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_V_END_F0, 0);
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_V_START_F1, 0);
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_V_END_F1, 0);
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_POLARITY_CTL, 0);
>> +
>> +	msm_dp_write_pn(panel, MMSS_DP_TPG_MAIN_CONTROL,
>>   				DP_TPG_CHECKERED_RECT_PATTERN);
>> -	msm_dp_write_p0(panel, MMSS_DP_TPG_VIDEO_CONFIG,
>> +	msm_dp_write_pn(panel, MMSS_DP_TPG_VIDEO_CONFIG,
>>   				DP_TPG_VIDEO_CONFIG_BPP_8BIT |
>>   				DP_TPG_VIDEO_CONFIG_RGB);
>> -	msm_dp_write_p0(panel, MMSS_DP_BIST_ENABLE,
>> +	msm_dp_write_pn(panel, MMSS_DP_BIST_ENABLE,
>>   				DP_BIST_ENABLE_DPBIST_EN);
>> -	msm_dp_write_p0(panel, MMSS_DP_TIMING_ENGINE_EN,
>> +	msm_dp_write_pn(panel, MMSS_DP_TIMING_ENGINE_EN,
>>   				DP_TIMING_ENGINE_EN_EN);
>>   	drm_dbg_dp(panel->drm_dev, "%s: enabled tpg\n", __func__);
>>   }
>> @@ -333,9 +333,9 @@ static void msm_dp_panel_tpg_disable(struct msm_dp_panel *msm_dp_panel)
>>   	struct msm_dp_panel_private *panel =
>>   		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
>>   
>> -	msm_dp_write_p0(panel, MMSS_DP_TPG_MAIN_CONTROL, 0x0);
>> -	msm_dp_write_p0(panel, MMSS_DP_BIST_ENABLE, 0x0);
>> -	msm_dp_write_p0(panel, MMSS_DP_TIMING_ENGINE_EN, 0x0);
>> +	msm_dp_write_pn(panel, MMSS_DP_TPG_MAIN_CONTROL, 0x0);
>> +	msm_dp_write_pn(panel, MMSS_DP_BIST_ENABLE, 0x0);
>> +	msm_dp_write_pn(panel, MMSS_DP_TIMING_ENGINE_EN, 0x0);
>>   }
>>   
>>   void msm_dp_panel_tpg_config(struct msm_dp_panel *msm_dp_panel, bool enable)
>> @@ -369,7 +369,7 @@ void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel)
>>   	struct msm_dp_panel_private *panel =
>>   		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
>>   
>> -	msm_dp_write_p0(panel, MMSS_DP_DSC_DTO, 0x0);
>> +	msm_dp_write_pn(panel, MMSS_DP_DSC_DTO, 0x0);
>>   }
>>   
>>   static void msm_dp_panel_send_vsc_sdp(struct msm_dp_panel_private *panel, struct dp_sdp *vsc_sdp)
>> @@ -559,7 +559,7 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
>>   	msm_dp_write_link(panel, REG_DP_HSYNC_VSYNC_WIDTH_POLARITY, width_blanking);
>>   	msm_dp_write_link(panel, REG_DP_ACTIVE_HOR_VER, msm_dp_active);
>>   
>> -	reg = msm_dp_read_p0(panel, MMSS_DP_INTF_CONFIG);
>> +	reg = msm_dp_read_pn(panel, MMSS_DP_INTF_CONFIG);
>>   	if (wide_bus_en)
>>   		reg |= DP_INTF_CONFIG_DATABUS_WIDEN;
>>   	else
>> @@ -567,7 +567,7 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
>>   
>>   	drm_dbg_dp(panel->drm_dev, "wide_bus_en=%d reg=%#x\n", wide_bus_en, reg);
>>   
>> -	msm_dp_write_p0(panel, MMSS_DP_INTF_CONFIG, reg);
>> +	msm_dp_write_pn(panel, MMSS_DP_INTF_CONFIG, reg);
>>   
>>   	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>>   		msm_dp_panel_setup_vsc_sdp_yuv_420(msm_dp_panel);
>> @@ -673,7 +673,7 @@ static int msm_dp_panel_parse_dt(struct msm_dp_panel *msm_dp_panel)
>>   struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux,
>>   			      struct msm_dp_link *link,
>>   			      void __iomem *link_base,
>> -			      void __iomem *p0_base)
>> +			      void __iomem *pixel_base[])
>>   {
>>   	struct msm_dp_panel_private *panel;
>>   	struct msm_dp_panel *msm_dp_panel;
>> @@ -692,7 +692,7 @@ struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux
>>   	panel->aux = aux;
>>   	panel->link = link;
>>   	panel->link_base = link_base;
>> -	panel->p0_base = p0_base;
>> +	memcpy(panel->pixel_base, pixel_base, sizeof(panel->pixel_base));
>>   
>>   	msm_dp_panel = &panel->msm_dp_panel;
>>   	msm_dp_panel->max_bw_code = DP_LINK_BW_8_1;
>>
>> -- 
>> 2.34.1
>>
> 

