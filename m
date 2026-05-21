Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3571CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 11:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0833F10E4A8;
	Thu, 21 May 2026 11:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="osFvy4Sw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H0no5q9g";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79D510E4A8
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:50:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L99j5k3527287
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kxy0JnT+XYA3BAOhh59TerxutRU2a8v3x/R3dSaa/UU=; b=osFvy4Sw0cC7VYci
 hR1cSkMt6V8W3035RqRYHak5h1MeUhHdIxcbKDDxHMXbkwCzZVBjElZEYP15DmS2
 lGaVkr9p7IfN4LJeYmipPqM0wzl5bOn1FJ2jbZm/jxj1eW/4azpCuZFelsh3KzhG
 z9Ig6wiRYQl7sLZ8cf8JmKPuXnwbhPBR4st93s9u3/AFvLs0pWF7djWGMCtqSqci
 H6CbSD1WUTEXP1M7FLAsbr0gJGpIVSIrL33pmpMfECFgje1BHAmFjkYxH/b5xaQM
 CnvbkBgKZXw3gAkvPGyf1IPe9Doqp7cTywGGfDwHvNN5i1wrdlzd5R43p2hKmwtl
 lp02/Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9vhbhdca-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:50:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36865d109dcso5681368a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779364237; x=1779969037;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kxy0JnT+XYA3BAOhh59TerxutRU2a8v3x/R3dSaa/UU=;
 b=H0no5q9gEb6/VC3GNSOGFmm9V0hnWgS4OvgtVukTz79BH3ZO5scMnpv5Blj1FgguJd
 1hTIOIZFEMrUzMCZ+tW3PImyeg6ZsmOAHeZas77+ORnZtsCrnloISp796CgIRc8972pc
 kqXMrOVgZrcOL5zjTTL4sOLdPUqN0/1kpCPQAdOvwB2DGjqxSD7CYwvJCqeaCAlvVVx8
 t/Swo0vBpL7Bzfy+pg4RS6CWC+cHAzosXz8ah6PaHHYX12ATUA/N3/Sen2J9jEz9gg4i
 B2Wzl40TtUrazdhHtz+beMfp4fwNqSkjs7w2MoPq50INCDaUZPn0N19b6orXFcMi/Obh
 FGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779364237; x=1779969037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kxy0JnT+XYA3BAOhh59TerxutRU2a8v3x/R3dSaa/UU=;
 b=U5hGzkDVlECNTfRb1mWVTK6FjA7yGerecwx4n324ipw62NRTTWL4aVe84zO6pc0gYc
 Pov9+7k7x61CI2BPtyi3766TpbAN6kLdNl8QWa9rfFXtp4PydXCojlDBrBvuHoR+yBh7
 IaoA/PpO6WgPNgZEA6Mst8O/oKhqXgTj0AjwMrhEW/6v58ysII2C4NC75oy3Gm5X7qma
 IOFLvTcG+gWLE90zdpFaefB4bCJmPJQs/QRQmQr9y/wcFktz8vv5vhbBHict2zp36ah7
 2syKiz9ZzEU9ULYekenBNtU3ci6MW7c+FLs2Mrfz2/peRjCwz/3J/4d5T3OeE8LDPuZt
 TnQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EaWOlPTARM+hRbghXdNeKB2xJ96EENRg0Qdph4siF5x6skOBIIFg71O7RLbe9ENNAkbRaKwHk0dY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuhvoIV+8q+igHdKVmJuIWIi+xCnIliA2fzEUtC0qs0uXAzQj6
 X7fN4g0ffFVLe0ABtMtZfuk/3/lLSQDA/iCLeNKwM7971vhhCitDN2Ke7gFt7CJg9oYu70HLw1r
 d4HjMJdZ9nVnTuv/Oc+Jk5ziKHNyHWi8FY59jF88Niybei4mS12mYhpqLM9TqjyBkP6aQzsM=
X-Gm-Gg: Acq92OGX+HyGweJ3cr5mphiURbc87ieGV1PbY/XOkAPC2RWaTqwHmznMLA1YTUspE8A
 xH4zg7WL2hPjJiKBWLaH8RJhgfi7gmUrZoeQQ1gB40/iQ+GLUUsi4ywQAdLCgycDh05iiWarQ20
 pkmTJQAqzubcycenPgPFTk4M2M1WNrzXQ/8rpkvqPysdrEA+y4eEiYu+2xq5oJOx5VXh8BZwXmN
 /hmwETM6e8eA0d/9BOsssd4iOVfEMWrD+NOZfeqNiXc3TuL7uwD32SBPl3wEgxzPTEVVBT1sMr5
 mrSvn1nCSDF0DCYSMyC2cV98y50RfBNrsZ2l6YXkc5zIadvQwwjmCNh2wrythztCv8I0BcCFMmq
 EkSiObbsyW+Gg/AaZhaVD7NpvnrETCRjmv4Qlr760DWwPTyFXkxBplEwrSUb8BYEAE3ikLXzq6c
 8fYLpqCwBXzKLRwpKhbQ==
X-Received: by 2002:a17:90b:5644:b0:36a:4074:9aa6 with SMTP id
 98e67ed59e1d1-36a44f17d22mr2822218a91.6.1779364236526; 
 Thu, 21 May 2026 04:50:36 -0700 (PDT)
X-Received: by 2002:a17:90b:5644:b0:36a:4074:9aa6 with SMTP id
 98e67ed59e1d1-36a44f17d22mr2822176a91.6.1779364236033; 
 Thu, 21 May 2026 04:50:36 -0700 (PDT)
Received: from [10.133.33.148] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a5b349d42sm533826a91.15.2026.05.21.04.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 04:50:35 -0700 (PDT)
Message-ID: <55081f4d-f1a9-42c7-a1cd-cdcefc008668@oss.qualcomm.com>
Date: Thu, 21 May 2026 19:50:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/39] drm/msm/dp: Add support for programming p1/p2/p3
 register blocks
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
 <20260410-msm-dp-mst-v4-15-b20518dea8de@oss.qualcomm.com>
 <zputabw52nsba4ddwg7gd22tyouobkmlpq6blos7w3kx457otx@gitmjwroo7ou>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <zputabw52nsba4ddwg7gd22tyouobkmlpq6blos7w3kx457otx@gitmjwroo7ou>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDExNyBTYWx0ZWRfX6eZkXpFLUeGg
 lJeOI1UWOFopx82BxKAHUnm+iaXA9IzZzaO+4Jfz/K4JHUamVb142EmY5wvo/bPOCzo9czqo5/x
 jJB8tNegkHnFC4Y/bapQb6DmSHCgPnHWR18tcQbn1/HEh5TLI3JDXVkKNlCytVqueMX+Hc1611g
 x1jIs4fAtNN6Dgbn9viS8H8OROuTacupR4EfnbC/DrldauGGZg/aX9bDR8EbL4y0l46rVnu/66D
 lNoJYBpf9olfvE9KlzZBgQ7hucLx8KHAWonEOvAcY+/U6UAHy4DqqlzuE4KSCOQpTyXanTqzT+u
 MYxUq1zLm9O0o5XjKz3GoBj9Uu4xETaLhC7qf5XmmVyxpZLITaeD0H8HcPyZsRLkvUNYk/coba0
 Yag5CF8bRupArW0yaG48WHVw7fbB3BXh7rmOzWshTif3BhTOsTBpYYSctdxq73IhDEfOSAToRMS
 yb99LMBSKmARmZMCHmQ==
X-Authority-Analysis: v=2.4 cv=GYAnWwXL c=1 sm=1 tr=0 ts=6a0ef18d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=AGOk3BmGE1vnVxrgsN4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: SQKfAWPnEm11bQ0kIFtjDQ9PZCWP5BAM
X-Proofpoint-ORIG-GUID: SQKfAWPnEm11bQ0kIFtjDQ9PZCWP5BAM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210117
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



On 4/12/2026 2:07 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:33:50PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Add support for additional pixel register blocks (p1, p2, p3) to enable
>> 4‑stream MST pixel clocks. Introduce the helper functions msm_dp_read_pn
>> and msm_dp_write_pn for pixel register programming. All pixel clocks
>> share the same register layout but use different base addresses.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 40 ++++++++++++-----
>>   drivers/gpu/drm/msm/dp/dp_panel.c   | 89 ++++++++++++++++++++-----------------
>>   drivers/gpu/drm/msm/dp/dp_panel.h   |  3 +-
>>   3 files changed, 79 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 7984a0f9e938..ff506064a3fa 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -85,8 +85,8 @@ struct msm_dp_display_private {
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
>> @@ -561,7 +561,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>>   		goto error_link;
>>   	}
>>   
>> -	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->p0_base);
>> +	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base[0]);
>>   	if (IS_ERR(dp->panel)) {
>>   		rc = PTR_ERR(dp->panel);
>>   		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
>> @@ -769,6 +769,7 @@ int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display,
>>   	}
>>   
>>   	panel->stream_id = stream_id;
>> +	msm_dp_panel_set_pixel_base(panel, dp->pixel_base[stream_id]);
> 
> Hmmm.... Would it be better to set it up differently? Allocate one panel
> per the stream from the beginning and then simply get the first
> available panel when required? This would require some minimal resource
> manager, but then we won't have to pass dummy register base to the panel
> code. Or actually allocate a panel when it is required? Do we need a
> panel before atomic_enable()?
> 
In this series, panel come with MST connectors, Because the connectors 
are dynamically assigned, we don’t know which connector corresponds to 
which stream, so there stream_id and pixel base address are dynamic.
we have 2 optionals here:
1.panel come with encoder (after bridge remvoed), like that:
struct msm_dp_mst_encoder {
	struct drm_encoder *enc;
	int stream_id;
	struct msm_dp_panel *dp_panel;
};
2. During enable and disable, allocate and release dynamically.
would you prefer which one?
>>   
>>   	return rc;
>>   }
>> @@ -882,8 +883,14 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>>   				    msm_dp_display->aux_base, "dp_aux");
>>   	msm_disp_snapshot_add_block(disp_state, msm_dp_display->link_len,
>>   				    msm_dp_display->link_base, "dp_link");
>> -	msm_disp_snapshot_add_block(disp_state, msm_dp_display->p0_len,
>> -				    msm_dp_display->p0_base, "dp_p0");
>> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
>> +				    msm_dp_display->pixel_base[0], "dp_p0");
>> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
>> +				    msm_dp_display->pixel_base[1], "dp_p1");
>> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
>> +				    msm_dp_display->pixel_base[2], "dp_p2");
>> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
>> +				    msm_dp_display->pixel_base[3], "dp_p3");
>>   }
>>   
>>   void msm_dp_display_set_psr(struct msm_dp *msm_dp_display, bool enter)
>> @@ -1163,6 +1170,7 @@ static void __iomem *msm_dp_ioremap(struct platform_device *pdev, int idx, size_
>>   static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>>   {
>>   	struct platform_device *pdev = display->msm_dp_display.pdev;
>> +	int i;
>>   
>>   	display->ahb_base = msm_dp_ioremap(pdev, 0, &display->ahb_len);
>>   	if (IS_ERR(display->ahb_base))
>> @@ -1192,8 +1200,8 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>>   		display->aux_len = DP_DEFAULT_AUX_SIZE;
>>   		display->link_base = display->ahb_base + DP_DEFAULT_LINK_OFFSET;
>>   		display->link_len = DP_DEFAULT_LINK_SIZE;
>> -		display->p0_base = display->ahb_base + DP_DEFAULT_P0_OFFSET;
>> -		display->p0_len = DP_DEFAULT_P0_SIZE;
>> +		display->pixel_base[0] = display->ahb_base + DP_DEFAULT_P0_OFFSET;
>> +		display->pixel_len = DP_DEFAULT_P0_SIZE;
>>   
>>   		return 0;
>>   	}
>> @@ -1204,10 +1212,20 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
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
>> +		if (IS_ERR(display->pixel_base[i])) {
>> +			DRM_DEBUG_DP("unable to remap p%d region: %pe\n", i,
>> +				     display->pixel_base[i]);
>> +			break;
> 
> No, return an error.
> 
Got it.
>> +		}
>>   	}
>>   
>>   	return 0;
> 

