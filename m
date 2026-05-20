Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E433ACD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B1B10EFB1;
	Wed, 20 May 2026 08:54:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFzYwxZl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SKMaqUh8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A68D10EF8D
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:54:46 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K7qkDW2064625
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /JjcwkslOcMmSQKpp5qTUuofPFeLxCYtN8XgHirflsY=; b=dFzYwxZlmhYIfXwW
 hJ31t9G40Xdhl+Z8NorAhDxeAA6qXhJQarZtIHQyUKxtV6oYtEf1MQ0ymTMKGdLP
 BLX+e//cECCHLFjNN82L7Xugcn7RKH7xtrWgjvWdBKm+PTbDAAk1/0+T9CAh6FB/
 /82TqvkudSjE+37Q4Pdhlb/rXusviqRkpaUTjXw9zWl4ZJXcbhaxf3cLEUbfN5vq
 listlmPxfKfQayqb+1A2uBI3ZykT69b0aX2HYseMxfg4vj4J+gKIGvF4lmVrSrye
 hp0ExjDneVLQvd/3QTPUEyGndDynErfjXqnkTRadLpxO/A9VphjGk0O9tjNqVnE1
 wV4fVA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t3ume-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:54:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-366122e01fcso4694516a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 01:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779267284; x=1779872084;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/JjcwkslOcMmSQKpp5qTUuofPFeLxCYtN8XgHirflsY=;
 b=SKMaqUh86D6M/Ey1Ws7q6OogDpTjP1NQOamuZfqmiNOKFDxz3gl/SIR7rZSCh150Jt
 gD6M+pgMp3owqttMqVIjQ08LZAUW6RR2+41D71UXKmzbndbgnoi41vNPfUROReJ8xeS9
 seO3GrItsB49ALxhDqOSDBdw7jmY4glA9nceUpB6QLGOP1Dj9d9MhzhmvBQQHyj3duYf
 mzxk+4VbUSCBeK8jcsoWQiLUKje9LSzhKV3JS9d7UPu+uIuAee4s9kpr4VBZ2gV8RMnt
 D1CJZu8f51THrAI2QXK5Bj2yrd0tIU+9Sic1OrVxnLVxzjTgCMGpooo7nkewl9aBNpH+
 Zx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779267284; x=1779872084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/JjcwkslOcMmSQKpp5qTUuofPFeLxCYtN8XgHirflsY=;
 b=JsR+tqAuz1UDkjHKGKXhqRx6Z7PGS9IO7PTy2urbSEh5feHqv+vskw1yIInKrurZtj
 R8xpbuoAcKwPxTXZ2ZQN0JQoRIi5mDPbm1XAwBkxxLyz7/QYGQlYHtApPEbhlBLx8Ela
 YTvTJchu/pVBHuGK5UUmdlRhwy5eV4imCHut1ZcZI1bhhBO6c5y8qjOEdLJsPC8uViqd
 gr2yf6G7GVdxF0SNWTi6hvlAi7EC+Xpb7oE/sC9wGjYSgySwGkqgH7lSoMNytkINz2yO
 3w0I1oDR3Ytd9oxcyfJPwoNSXWDN7blD1oDd6DFxQBOuOW+H18EAEBXu/izg5q33OdAB
 /PTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+svDpODlgSNuSIUEHU8671tpksJFtxiWiOSJqo8/1DGrmAMYuXOG7iKFFB9CyUDayJ7xBzOAx7QfM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDxWRQUYxr407Q6NKzW9Tn5NZQ1zPPtVvNzQAMtONPbWMBsLk1
 Vrt1GXX6wUo3FRKek2oNYQWrFocIkrUeO180dBSjAzehTaNPFxgNU33qXf753dTi+Tcc+G8gP4O
 ncQuKxLEcCq6WN5PYezAMhwG2IgT/8aLOhPjn81oXg9QRhqBkU4CnO5gKlJK3BGiDADvMMt0=
X-Gm-Gg: Acq92OE53w2RKLqUVQ4OOqAdvLbQEf+D7VbTKSsefv11hc+sl3CPM6UuX68yfDSJqA3
 yEcCZ6Dr8kM54CGsM/B0ZPSb79F870//6QcHknbgjJhtUs4vluZX9brnfVAOZzDSdkw/5b179oV
 Hj/209o3PM9jG7GxRcM7e/3lbABltcPQIpKf9VjVVglxvaFpz4b///DinWGAHS1ChpWjR/+Mg4M
 6y8J6LPO03SIasWssRpznbHaQbhCK8OO2RWvrM7WrYW3wGXpipMUPY5KNY84Az90rYoPGNBixbh
 u3pFTo3jxv1GBLWXQIYL/VW32uuqf7DetX2zOgwjuqpQ9Yaz89JNdekNW41fzfrshYanWYcXtGS
 su4z2Us2/Ww/S4fPAKKpIfQV7KmtD9gUlTvL064wt2vDvWmqJsuVpjxHRxO3e+7tCGXyPdiq796
 UNMRNI7ploWWBpNK6UTw==
X-Received: by 2002:a17:903:1b6e:b0:2ae:803e:6c12 with SMTP id
 d9443c01a7336-2bd7e8ae6f6mr267807455ad.6.1779267283896; 
 Wed, 20 May 2026 01:54:43 -0700 (PDT)
X-Received: by 2002:a17:903:1b6e:b0:2ae:803e:6c12 with SMTP id
 d9443c01a7336-2bd7e8ae6f6mr267807325ad.6.1779267283412; 
 Wed, 20 May 2026 01:54:43 -0700 (PDT)
Received: from [10.133.33.114] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d1062e9sm214505145ad.67.2026.05.20.01.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 01:54:43 -0700 (PDT)
Message-ID: <e85a29ef-34b8-41e3-8417-d73a8079a980@oss.qualcomm.com>
Date: Wed, 20 May 2026 16:54:38 +0800
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
 <mswfgwuu3x42s7edcyk2vunc2bsmqciam47nunwv3r4uylx57y@wwufxwng3v5d>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <mswfgwuu3x42s7edcyk2vunc2bsmqciam47nunwv3r4uylx57y@wwufxwng3v5d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KP3w800s7d8feamldSuwnotpk3RJyj4z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4NCBTYWx0ZWRfX3AMlYCq7CQhk
 mTaxJB/7DHucJ7XpfCBMhsoLWp+oZ3ovKFD6H7e4OJtq2yzruBOQN3f6e3yrvj1TrhvPE8EUZT+
 UVt4ahXJ8OVPPiUP2qBLnSdKX/SZ1Aa8EW6eZi0xq5W8zhSSLTeeVMezG63WK9SYKXS1chZNQWM
 pnGATePhGshGY8gq2XyaqBRPmndl5J/w1AyWR13j0gmG/A/go4gZMqeBS0UL3zhk3nWi5pIpIUB
 fNY5mg9Ky5HRF2lddjamGtTc1BfS/+UZhnnYNXSYNm8l+22ciihPH2fCHbV1jZj1ifts50RHpun
 FiWFWecf6RG4VBL79Oa6zbp9dT5YPG7onDfLKBfx1BIUchS2k1VLEtKk96ppwCPbhC8ebHFo/WA
 TxwP2Jkowov+K5cSo8jghrDw0WRJE5gcJgpiILFKOgm97OeKT0LQoD+SyfMQ1ZrRL/nGXyPUjHe
 +RVbC1h07j8eSFkMLuA==
X-Proofpoint-ORIG-GUID: KP3w800s7d8feamldSuwnotpk3RJyj4z
X-Authority-Analysis: v=2.4 cv=C4LZDwP+ c=1 sm=1 tr=0 ts=6a0d76d5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=8Wk7F6lNGgSB0avDr_YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200084
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



On 4/12/2026 8:04 AM, Dmitry Baryshkov wrote:
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
> 
> drivers/gpu/drm/msm/dp/dp_ctrl.c: In function ‘msm_dp_ctrl_core_clk_enable’:
> drivers/gpu/drm/msm/dp/dp_ctrl.c:1937:9: warning: the comparison will always evaluate as ‘true’ for the address of ‘stream_clks_on’ will never be NULL [-Waddress]
>   1937 |         drm_dbg_dp(ctrl->drm_dev, "stream_clks:%s link_clks:%s core_clks:%s\n",
>        |         ^~~~~~~~~~
> 
> 
Emm. thanks will fix this next vesion.

