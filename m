Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7CBFB3CF5
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D3610E59A;
	Mon, 30 Mar 2026 10:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zm/8akS+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AI6jfp4k";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2CD810E59A
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:00:30 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U9vLdC4088648
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JR6tXdbAULbez3ydP74JlxQJzcCNgilbHvA1DDCMvzE=; b=Zm/8akS+/M7jn33Y
 2B7vnKrJ09R8Lri90TLdTg8P/XkYMeNufulpr2RkYP3VG7xhYkCDH/TPLplf0+9i
 PK7BdK03ufSOl/cnlCd9KXsyg9nHSY7KKh9WUEhqlCJY12P53RBP6tbbdB8DhecS
 wjrFaxhThDDD1FayNcXqGPL8j509z+wqsmegqGj4mMRzCh40QwNRkvzOgHpDQj0K
 jBZR/5SvH4f+ElA9Bl8sNA3TvjCVb+gjvaFDSF1+cD90goneeD8GOAhjZjhqb5yF
 3kM+HUSOsxYUiJAm4UnuF7CXAaXneTWAt/sLHiRqCF2uVu69jgHxJd1Qxx9MvxsI
 T8gvdw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67715k60-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:00:29 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c741c4cebf3so2622756a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774864828; x=1775469628;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JR6tXdbAULbez3ydP74JlxQJzcCNgilbHvA1DDCMvzE=;
 b=AI6jfp4kVzbobv1wUDX9feZ680ED5WzaItMyR+3XOMDbGouhIDWxSqYgP1qvb3/oM8
 mHKG5vBUc6EtNuN5MDtqazCoyEZssyA1LLum8Oad4JFBwtEx6ZysMrmY6I7aDWqTs+zF
 i4G41ez1Dl1GSxHdG8+jyVtWCK/fv8rrk+wdrR+it76K3a0y886fzyqflU0bdNcH8ui9
 q2gH2sdsLND02WD1AVPlzsB1R7mZ/e2U7cspAmLyM06vdwMePUpFYfJNoPdoy+b2yIL+
 4EIgGLHTN/+B+NdKqcisuY/7uUvqxBuGamhUYiEIHxpt8sm1pm/UXZWlhwZv2eUZYjdT
 d9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774864828; x=1775469628;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JR6tXdbAULbez3ydP74JlxQJzcCNgilbHvA1DDCMvzE=;
 b=CvZE9kHgyUhYurfm52DmwZXA820fHPW+DH49wNWqxTpK9oYo63aeJHk+c+N5dOk/sV
 FDFK51Ohqh9HJgKP30wrQ+S3lqPoRIf/T/ZH9+hJZupj54+DwnEe9eOiO1n8S7FLl8Au
 fSw/W141aSWyrLaUZ7D2Ay+ie/uPeZFVS8WEyVKIb9E8e0MbCtR/m8u1ZwxldfTEqCUs
 Th/LC1nGNCnJCFh6j0JWDznLHL2KmdGE8Cs+SEemIaD735MjUoFlTXI5JBlovGRmXNoJ
 HkXEDmegFuppLdjqCXyMOJet+0b2cIYFkD5XGSRGQy5b4HxVv30BesxA1gbNtZ1S8cI+
 VnMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/ynL4HhPz9azO4dXVWbhzVyrNcjxNsEi6Tj3gcGQhUWYRs0IpQrImMLDJRuvw8QzHUROuXbPc/AA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxgt1TLoMP1/m8FcnByHFIN4vVqrnRg2Wn1yZ4IedEWn1y+LZ92
 +4lK+07v5qDsXZvsa7J+5QFsxRUqE/lOCmRpmYSwTc1mGj+LFoyhKvQsgHgx2/rOxzNyuF/83vD
 7NooJAwMMp2yNDPLzMzU7RxBggdLaaBLy7YtycA0FmmqUFcPq+PCSBbDpYgzBpVTd2ADDC0M=
X-Gm-Gg: ATEYQzyghd4GMBSJVbSk0BtWd8hi/I5xbiyu1YHWrJXiPbyO5YWIqIlQw1oDkmPffQZ
 FoVRXH/8EsuzWsxa6++h+3JsyTzNBjad8fcxSLCnY2ai0w7uhnpmG0KIJsuDxmHYuJV9+HN1hes
 9bUhCrcJPdRIge4zz460QnxE2STiBL60uWCliJbWoPqWTxPFRvPNAzMfgR9HZt+6zcVj5Q0jZET
 Y4yvZ3CwsjCU8YWt1INY3icK+cbkTIlXWiBPB4AgjIF/st67CuWm3PSjMAToXR1Eoz1PP1Dfhor
 0G7jrLwvrdyBv5xnQ9bm95UV4ZYNF5leWndnxoJ/Ddjej2MI45iYVstkCnPbu3uhqK73XjgWRf2
 gdxUDR7ngLdHgUEvMxebINb1qLReLM6IDeDR32PGnoiUo+Lyn
X-Received: by 2002:a05:6a00:2884:b0:823:9e5:855e with SMTP id
 d2e1a72fcca58-82c95691acfmr10648384b3a.0.1774864828195; 
 Mon, 30 Mar 2026 03:00:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:2884:b0:823:9e5:855e with SMTP id
 d2e1a72fcca58-82c95691acfmr10648319b3a.0.1774864827387; 
 Mon, 30 Mar 2026 03:00:27 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8466e01sm6900120b3a.20.2026.03.30.03.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 03:00:26 -0700 (PDT)
Message-ID: <b50e9474-4d80-437a-bc0c-0b37c2a04aa1@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 18:00:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/38] drm/msm/dp: introduce stream_id for each DP panel
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
 <20250825-msm-dp-mst-v3-13-01faacfcdedd@oss.qualcomm.com>
 <wvctskhoyphicaymbm5b6kermvubhrn5u6uzui3pqf7p3a7ia2@zirqohupflvp>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <wvctskhoyphicaymbm5b6kermvubhrn5u6uzui3pqf7p3a7ia2@zirqohupflvp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UgaSLrDBaEQUI-PBown93KEK9m0xGq4h
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69ca49bd cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=l0Ss5M_0uoGcHLo4SdsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UgaSLrDBaEQUI-PBown93KEK9m0xGq4h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA3NyBTYWx0ZWRfX5vBhVWhEWCZP
 QKHvHYL96i8axdSn0coA/luCA68culmkXk2COkjg8g6vKF49renqASj6O31s1StGza2u9V3qcG9
 naH8tyFft531fMjDaLHvc1IDiQCf5AzViLcNztohjlCs57PUfdtFfI4uPis6SGWP6MQNDhCQ4XC
 8ywU0wR5M9/+XU6RtC2ZoYCO+zgXXDGtiRgvSi4sigI7TrZlLl4Psu9nMVOFAlUr25nEF9lvKyO
 WyoUCBKnr1k3k6OA1ZdL5MQQwQkgkIDlY6GF8jYaYEJXqtLI5AOyMPfR/dlMDHSsmPDjRfwRApU
 aXh2npRBcomkyyHoeuJGq2VhH6bWDEpR1qA3QkrpFu7npVHj1y/Y3Tc5BCIDwL2OKnXq0CDoC4e
 p/VTgLBubShxx7AlnOKrAn/fqaDXXm+xKys/ksk9Xu9GJ3BYl98LKQNZrNX3aC7EJWkaQHF1VN6
 /SPqo7ZdigctlpBjBoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300077
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



On 8/26/2025 1:56 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:15:59PM +0800, Yongxing Mou wrote:
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
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 58 ++++++++++++++++++++++---------------
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++++++--
>>   drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
>>   drivers/gpu/drm/msm/dp/dp_panel.h   | 11 +++++++
>>   5 files changed, 73 insertions(+), 28 deletions(-)
> 
>> @@ -2677,10 +2675,11 @@ static const char *ctrl_clks[] = {
>>   	"ctrl_link_iface",
>>   };
>>   
>> -static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>> +static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl, int max_stream)
>>   {
>>   	struct msm_dp_ctrl_private *ctrl;
>>   	struct device *dev;
>> +	char stream_id_str[15];
> 
> A comment would be nice. Or better replace this with the array lookup,
> it's much easier than snprintf.
> 
Thanks, will replace this with the array lookup.
>>   	int i, rc;
>>   
>>   	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>> @@ -2710,9 +2709,19 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>>   	if (rc)
>>   		return rc;
>>   
>> -	ctrl->pixel_clk = devm_clk_get(dev, "stream_pixel");
>> -	if (IS_ERR(ctrl->pixel_clk))
>> -		return PTR_ERR(ctrl->pixel_clk);
>> +	ctrl->pixel_clk[DP_STREAM_0] = devm_clk_get(dev, "stream_pixel");
>> +	if (IS_ERR(ctrl->pixel_clk[DP_STREAM_0]))
>> +		return PTR_ERR(ctrl->pixel_clk[DP_STREAM_0]);
>> +
>> +	for (i = DP_STREAM_1; i < max_stream; i++) {
>> +		sprintf(stream_id_str, "stream_%d_pixel", i);
>> +		ctrl->pixel_clk[i] = devm_clk_get(dev, stream_id_str);
>> +
>> +		if (IS_ERR(ctrl->pixel_clk[i])) {
>> +			DRM_DEBUG_DP("failed to get stream %d pixel clock", i);
>> +			break;
>> +		}
>> +	}
>>   
>>   	return 0;
>>   }
> 

