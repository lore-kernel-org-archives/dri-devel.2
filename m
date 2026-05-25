Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F72ECD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0985B10E370;
	Mon, 25 May 2026 13:35:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ArMoF0E0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FUVKHnQJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D60110E122
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:35:28 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PAi3SN824507
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZNLxbtGJrP9x6ELJiMrV9m0Y5RYj50NF/BQj9YA7V10=; b=ArMoF0E0Zh4o/UjO
 yx+pVe07APozjE7Bu2qU7ZstTsKjacKHrR3r4anw3+137NN/5zxTJD8VoHvy+3nh
 dSXPZLcRoLu2s65JmVtseYDTrnFnhdFfKxR56n4RZn5vEnOCDE1zzcOrgDZHv+fq
 GK4NU8mXCl9U0MAdqYPLLFJ8pMWN6obtNkttEtaMyqHTs3UVru8gGOEyZOi48khI
 amPkpzTwsi+kRjrfL43j2NkMQCl3uH8NtvIPXArmLmgfgHadHOr7IbjPZvCRetBs
 B8q35YLL+0W7RTShImHf7NvChqS2wQIW99Jt/uvxwMk4CgVYozLotLooD3C/sljO
 bxfxrw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4m7ptfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:35:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50f13da9684so118121491cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779716127; x=1780320927;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZNLxbtGJrP9x6ELJiMrV9m0Y5RYj50NF/BQj9YA7V10=;
 b=FUVKHnQJcc49roHr7V+6B/+rv1zLxpm77doO602O6sU6XXyYaBYttgd5uwNbsMEaAF
 Bk9qyDR0cKHj0QJGZokA68fl+3pChC5GebrVgkjcRTLOn4KMt9dV3o2dZ441XpQoT2ka
 vyog/0KyZtWGtAbhlGitWpMzSPLEI//mvcTmkcbtpzCZMLdGyQQml1lnKHl3UmYFxQD6
 saQ3jW0N1AJnFG33otFqagVFPklATmbWGnJRPGtIsBTmLrZc8A+GXcl6h6gJ63OScOFp
 WmJzK7gPW41Tji8iMuvLNZ20CepIu+TqIeF0TGogygLgCAcDO4I7Z6xvlx6P7QrZvAOI
 qW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779716127; x=1780320927;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZNLxbtGJrP9x6ELJiMrV9m0Y5RYj50NF/BQj9YA7V10=;
 b=ox/FNJvfiCpPQ1w5eegLndTAuSaQbzyp+pnBKrALNsz8WDp64kRXBkFi0Awnm11lWW
 XrXruKGvZAyaDJ8GbrPULDXEdmnHXWy2ox9u8Pre2rWGMei0T07oZr1t3BatF2FmTovL
 jyGBuPOi8DETAO7tQGO8WklwoO7sLokYmCiYtYMdni0RrP2EnYBkUxzBE7OawbSLdOYd
 xoO7gAycdiH6LpGnglRqYHmXyP5Q2J8ZHyLuOXj/CiTtULHG5xgZpdUKghbrNcM/K6cw
 GuXMgsPFDH6//hd4kjz0RwASFVn34xEr7UZyHrqUVj7oP7ZbQMtDao1mldgcTLpR6hs8
 bQTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+52a3RQYhUWQUElauRQ9JXrOn0ataqSBus+Aj45DAUdP9qI5qdern8bI/gwys7S4xU6HDRJ40yVDA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZRbj/ZXYc4NBR9Zlg0v8rAa6+Nbr6a1px+ltZPjppNNfTs2pN
 Q+K1SwJ+OhhGJqNG94LUu4MUkyI0sEuDjbMg9y2PEovx0LAF8ahRSXBcyRFNFWIm1X89spx5r2+
 gvOXE36nbTIizl0I4wrKLfV9cIxhrOIk0ULYVuM8gff3EhJ2t+5qw436mISj5v3KHWIKEfQM=
X-Gm-Gg: Acq92OH2czp9fOWWvSh3fxH2Xk5X8SAYYbT6/F1z4hoxyndHSpJ0QtLKsiDyvJSAsvT
 pYULfGzaSmNYVnGUr/U8anaBauQWb8fGQBzWaW7WqzXEP16Wlc2WXfRjut8ME5StBCSlrlbwVsK
 cKQEERqTqshQmeN6m10r1Z1QLvcyDfesd0n83qKUHeCseGoAUQ6xWSlDtCSWAJFOAKjwfJNYE2b
 VgkC9NC2zQkFGoan45t8c735/Nv33K2qDZOPYH0suWHiCNtgVrDoUmvtd4aMbwCX12uSer8ue8D
 KfxMAI8aAfL0u184DLoD5y7zaaJpMnz9YgQuLYvZTttya0FNY0m0LG5TjwNcBCYDsveskTd+4wK
 3lkT8tqq2nHwI37emB4Z6dI25jfdyQHDuvlPHnlkuAjk=
X-Received: by 2002:ac8:7d45:0:b0:50d:cd5a:577b with SMTP id
 d75a77b69052e-516d436a31cmr178465551cf.35.1779716126589; 
 Mon, 25 May 2026 06:35:26 -0700 (PDT)
X-Received: by 2002:ac8:7d45:0:b0:50d:cd5a:577b with SMTP id
 d75a77b69052e-516d436a31cmr178465131cf.35.1779716126048; 
 Mon, 25 May 2026 06:35:26 -0700 (PDT)
Received: from [10.236.54.193] ([88.128.88.68])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cd151asm26639898f8f.13.2026.05.25.06.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 06:35:25 -0700 (PDT)
Message-ID: <4afff193-8d2d-45b3-b8b6-0334e1f8921a@oss.qualcomm.com>
Date: Mon, 25 May 2026 15:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/10] drm/msm/dp: Read DPCD and sink count in bridge
 detect()
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
 <20260524-hpd-refactor-v6-3-cf3ab488dd7b@oss.qualcomm.com>
 <00ee4b34-7f71-4448-806b-65bd62ebe574@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <00ee4b34-7f71-4448-806b-65bd62ebe574@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Nhi5PgKjrq2V9sVb1whx8wACNSq5kpTx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzOCBTYWx0ZWRfX1xazraCbhJM9
 kBYXLuYUG/e36Cb98F7s6NrPdeb4p6gplwwxHoZSMxl02mSrtvyI4s84yW2xx+sig6+y244iRCF
 mHIjUxROJwJF2FGkJIPuxl+YJMVNJJoLjnrZwHo2SLAnW1A7reSiwZaAlkrA+8kbmtSVjFdhRFJ
 ZKFDSZF/A6Vg0mBCAPhcv0KwZGWgUN73m+IsGFvmvym5/tSV19t++6BX2zDvjyJDTtVpgvwQr63
 kFsMhuFedI0hBK/mesSwVYkxSvxyMLr89FJAsXNoyX5IrZn3Wlrhcy/5VnsCJzJ2my3KdCh6iir
 nrhZ3WABB3/phub2FORB2JKSZ+/RAloGJ8TFk2+DZcqgz4NXxzyKZrVGaEfSTt3Zm3TKlzXsiBV
 zVyODTb3zU4ARJecUjPQgz0cp2CxSCrKUwNgP2q+rQ1kqdRmqfYZz/z2YUMDj+QVpTU5KBOZJGU
 9wYDhkjxKn6DBJ5k/Fw==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a14501f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=REkWmwYpG64U3YBEcLtx5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=fzl85mFQbXLh34uAWx0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Nhi5PgKjrq2V9sVb1whx8wACNSq5kpTx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250138
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

On 25/05/2026 15:32, Konrad Dybcio wrote:
> On 5/24/26 12:33 PM, Dmitry Baryshkov wrote:
>> From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>>
>> Instead of relying on the link_ready flag to specify if DP is connected,
>> read the DPCD bits and get the sink count to accurately detect if DP is
>> connected.
>>
>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>> Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
>> Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 63 +++++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_drm.c     | 20 ------------
>>   drivers/gpu/drm/msm/dp/dp_drm.h     |  2 ++
>>   3 files changed, 65 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 1dd168acbbc3..97c4752005c0 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -1152,6 +1152,69 @@ static int msm_dp_hpd_event_thread_start(struct msm_dp_display_private *msm_dp_p
>>   	return 0;
>>   }
>>   
>> +/**
>> + * msm_dp_bridge_detect - callback to determine if connector is connected
>> + *
>> + * @bridge: Pointer to drm bridge structure
>> + * @connector: Pointer to drm connector structure
>> + *
>> + * Returns: where there is a display connected to the DPTX (returning
> 
> 		whether?

yep

> 
> Otherwise, if keeping msm_dp_aux_enable_xfers(true) is intentional
> in bailout cases:

In the non-error bailouts, yes. I might want to change that later, but 
for now it's expected this way.

> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad


-- 
With best wishes
Dmitry
