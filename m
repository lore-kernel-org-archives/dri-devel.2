Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C076BC5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13A9F10E277;
	Fri, 21 Aug 2026 09:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mEPiNhXG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NzdGuB3R";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3813010E277
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:26:55 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9Ljrv1983091
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y9FPPE5oV3345poAfpF+CAauvyxVxyljY3apmDwlfD4=; b=mEPiNhXGzw0ysy7k
 +JGVQ32GD8hEYY4EwMIzEh51h2pfifIrHMoDwRar33RCURAgNkY5pO5X2F2xeziC
 U3dBNJ2zngOPQ/ZOA14nYetNuAZz44Al5duIEEGMa1/hSyBJVoM5RLxLlBJeyYMI
 ba/K6+MbIxZyJ2ze9UrPPiu3LckHNstNKzYe4+5uQNbpRFNwTSa0nOZWM52JWEEw
 IX82CatVWc21pq8y2rE1g1Dmfvq9mL/7ikacboz6qC4Lgo+aIxN+MBG55001VE6z
 vuaOxOx0TztdYBhzniNVMfzn7TU9pNebY3lceLPYRGuKVQLql3EnxYcV3jhjfSQZ
 krhvaw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6cdshn7w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:26:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so1163598a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787304414; x=1787909214;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y9FPPE5oV3345poAfpF+CAauvyxVxyljY3apmDwlfD4=;
 b=NzdGuB3RIfIfMEF1CvyVD3xVUJx/3C/Xt0tzvP7RkRoREVua7oCjNqrSrsdQuQ7ii7
 7Hc8IfhnQMyVduTt4bIWaq8Ww1Zn/SBwk/U9zPBOrpIywqKqLReiIS4K4gZlyaeavARo
 vMr5cAfo8+6AyoQA2SJI/aR4js6EfriEXEM2hEcNRHbHnhP9p3eToFLWb7GG7Jf3pbCt
 oR+BiCrdeArvvjF/YTmRvF/VcLMj9nJ95zjY8tDcfWnvfS6A0JF8HagI/hUltK+k9mV6
 xQoXB+uABBIwNQlEPTBqR+tzW9QpXa/X9knEQnq4qgyflQfnHjaLbIzvEHrm9Se1gG/x
 fzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787304414; x=1787909214;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y9FPPE5oV3345poAfpF+CAauvyxVxyljY3apmDwlfD4=;
 b=DFc1Rne1zaLXi01gVOohE3LjycTJgztEyGAClYB1Bp82vQCZTaurL/gI4I0tlDpPG1
 o8N1mHDv4XCoshzGJ+S1Fi8R4GZeGLfSroaJmmo/g56yMcwLL6eQISB/3m33ZgHRY/En
 9+0gbPpi7bt1j7VbzRrnlZEqctu09MAMqqV2ktjPhq0AAlyL1TRxOH5mIl1L0cFAvFNJ
 HjUJMSZD8WkwIXJmM7SsQcqQCpFqDXjjaBgOaNhn9gn6FgEKkFlQheJqOTNoBJbhpXOR
 ZEqxuMPyFzXnmRlqqYb1HbCNcd5IUhjsob3U+2JtuIbbvuT+2LpjhPEHbtw3q0iMqksM
 CzBA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6tTd+sFSym72zxhN65dyGHxtS/i89AiGWn9dsGgH0PNMydqcJx4rGiANmYCZrBpfD/M8nFvu7WOY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kJ1dbwxHMMWsgOuOmZKmwQSWYSCMZAlktbJvV6X1PM/j8Kmnyh
 wYyYCPaXGcs/HUjzaHr0mojVypjg1P3ovDL2bFSoqQH4w7UeHRbYvyC8qMzxxf/MKVSRzY85hL7
 xtbCqsPT9yVp88wx0JzLD8OwsPVl8scYhMtObCDcLVSVSAdvhJZcC5ZE65deSni89zJInwEI=
X-Gm-Gg: AR+sD13bsuC9rO8W+XIIOCGzMaMUUrDif0z/4VL5+gupGMuGKzK6FJMn3d84F0hYG1e
 +w529Fwa5Uxr48aGpU+Hrisg4MO3xJUEn1MiOvpgfUVDRoQ3pdGjzamqZKROLAZaeWYc9NChi23
 IMVnvrvJnjN97T8pkDc0aot3M1fJhEVTHBQSViFtxbbeU2qGas+TMcf4ywPjtQoPiOtdNh6Cqw1
 kAoSNHLGsU3k70wkdHiGqlI0dBh40blKlnFtffOY3HjfwY2/RFkaACteP69idPkDVLL6ug1p1cT
 CrhaFQOfNaAD2H8Si97iLA74WGQG65uK/Ay/F6XacXQSqatkJiL4qCliDK2/xNZVuXC7JJxFZgf
 BXImosp7nMsJvTT04nuXnzt2iBr0FcpMiAJDR5frqAi0xDSPOOD1yTFnxYFQNE5wTrXjzbXo=
X-Received: by 2002:a17:90b:3912:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-395c3738b35mr8102083a91.13.1787304414051; 
 Fri, 21 Aug 2026 02:26:54 -0700 (PDT)
X-Received: by 2002:a17:90b:3912:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-395c3738b35mr8102020a91.13.1787304413572; 
 Fri, 21 Aug 2026 02:26:53 -0700 (PDT)
Received: from [10.133.33.40] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c37996sm2309454a91.16.2026.08.21.02.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 02:26:52 -0700 (PDT)
Message-ID: <7db3d44a-7efa-4eb8-a80b-d3b23850063b@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 17:26:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 01/25] drm/msm/dp: introduce stream_id for each
 DP panel
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
 <20260629-msm-dp-mst-v5-1-2ed6aee1867a@oss.qualcomm.com>
 <7fjeip5h4jzvsuowvfgmnm6krh7tvulrv3l3laa65quscq2jzp@lor2elvhmhia>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <7fjeip5h4jzvsuowvfgmnm6krh7tvulrv3l3laa65quscq2jzp@lor2elvhmhia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aviEJFPxlHRFnaegauW1XG-5Cu599iHq
X-Proofpoint-GUID: aviEJFPxlHRFnaegauW1XG-5Cu599iHq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2OSBTYWx0ZWRfXwc4Xw3xN4Tfp
 yPchZOC74CEYcPhK+jAbHdwLY9aoSd+q+EpYH5aeoJLZWiu9KLPBCk02yn/WldWjLLaG0VQoEWw
 o/5nH94jVHYqKye5IoR6hZg7EQ0MJm8=
X-Authority-Analysis: v=2.4 cv=RN2D2Yi+ c=1 sm=1 tr=0 ts=6a8819de cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=lU6QALhYSBwYHZQzA1gA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2OSBTYWx0ZWRfXzfv2AqafqK9U
 9Q2TsWafYZd75eGbwpDEmkBnPHOW4iZHnyB9gBc/94EDz2AzdYw+9y6I1SlJO9SQRPmmWY/2pta
 zkuR0cpnR4x8OcYJoqTXlgBx8j0IGdH4y+rTAbOL/gnvNFSnZGlbme/mMo2vlXrAQRZ2Mhgq7kz
 P65hrP5VU1CKd/XXbZZdr/GsW5DTLKsZzthL4EupgQQ8ifY0KtDHDP11sqhiopgADKoxxCOMNNc
 LTWf2Y/LtJLNOLgnZsswoMAaK0gYAiPLeUYQXIODB/+J46Z3Bj0Kce9YIPy7Xe2PHvcOyP4xE/J
 l6ekuvzFLWNvCz5jSFotGF3ZlpJvV1NX114Ko9guE9tlR+bApK/dmPEJo9gljQTA0uj7hGhGfw8
 uP4VgMP9Q18Jq3TV3sEwfKXEnUnt7c81ZSUAE6YyIR1+d2H3IIyg2Y9w4G+r5jdo4XfHI0nnIqN
 XVVhhawoc6pUMdTRifw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210069
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



On 7/12/2026 7:11 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:22PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> With MST, each DP controller can handle multiple streams. There shall be
>> one dp_panel for each stream but the dp_display object shall be shared
>> among them. To represent this abstraction, create a stream_id for each DP
> 
> You are not creating IDs.
> 
Got it. Will modify it next patchset.
>> panel which shall be dynamically assigned to actual stream IDs by the MST
>> path. For SST, default this to stream 0.
>>
>> In the MST path, panels are dynamically assigned to actual stream IDs at
>> stream enable time by the MST layer.
>>
>> Use the stream ID to control the pixel clock of that respective stream by
>> extending the clock handles and state tracking of the DP pixel clock to
>> an array of max supported streams. The maximum streams currently is 4.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 67 +++++++++++++++++++++++--------------
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
>>   drivers/gpu/drm/msm/dp/dp_panel.c   |  1 +
>>   drivers/gpu/drm/msm/dp/dp_panel.h   | 11 ++++++
>>   5 files changed, 55 insertions(+), 28 deletions(-)
>>
>> @@ -2188,38 +2188,39 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
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
>> -	if (WARN_ON_ONCE(ctrl->stream_clks_on))
>> +	if (WARN_ON_ONCE(ctrl->stream_clks_on[stream_id]))
>>   		return 0;
> 
> Is it an error, defensive coding, DT mismatch or something else? Why are
> we warning the users _and_ returning success here?
> 
This is primarily defensive code. The normal execution flow is not 
expected to reach this path, so we only print a warning here.
>>   
>> -	ret = clk_prepare_enable(ctrl->pixel_clk);
>> +	ret = clk_prepare_enable(ctrl->pixel_clk[stream_id]);
>>   	if (ret) {
>>   		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
>>   		return ret;
>>   	}
>> -	ctrl->stream_clks_on = true;
>> +	ctrl->stream_clks_on[stream_id] = true;
>>   
>>   	return ret;
>>   }
>>   
> 

