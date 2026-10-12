Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0390BCA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C7F10F2BA;
	Mon, 12 Oct 2026 18:13:33 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 461B610F2BE
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:13:22 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CHvFTY2879224
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1u7vtvJ1VscGBojbDlDxNg96L1K6AUN+XvvnqPqIY6Q=; b=HoUKmF5TNsCizT74
 MN6lBM/b1ykF01Z9zn/fMWiulyFoFLAi4UmrpjsNVa8Fb4FlsNT1Vcm2yRWsjJlZ
 eukT/RXErwjzbSVX9wh9ODVz9PKuT/NzEBxywGZn55tNeQY4Y6qIJu4BXm3dOhh4
 BbeS2RPiWS6+hjfdYmZ3Nvy2T7Wu+SciOqjBiARd07hf26cDd/bTgAYDwX8YoDEI
 BLZWE2vE5uFYX4Zkfmf9/DG2SItCk+OebZIv0Mf5tWQqbBn/HrZ89IzJx9l9WNHu
 7V3CxDMrIRvHh0495j1T3leSQFYKc2RmgaI8HyI+eTJdJCatC4nt29lAGht6GG60
 gIk5qg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sgu3bpn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:13:21 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14373747468so407296c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791828800; x=1792433600;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1u7vtvJ1VscGBojbDlDxNg96L1K6AUN+XvvnqPqIY6Q=;
 b=YI1L5nz7M0aAgYOqjrqm2eb4b3BkdytUrWmMUUqBpsJqGKo9uHKy0Knq6hJv5bWqmH
 wulyavYBKjBFWaq+CHgJdKxhqun+zrx2l7D0c2owmCQOw8HfvLb2903tflROtxh0q2KX
 Bxi3yn4v85lMOp/d4gEX/xVG1FohigGaZj/trk4F4qvHdxwyTGp7+c8v4nCEbCz2+bgT
 GMxOvYcPsMjGTYaGwsFNw0ViOFQ+jkkFglizoHhEhidsIkCitfNiEw7C3obR4xSk6PK1
 FPze5NhJsdsVoHxZ2E5D73ttMcNyDBd4ZDwXebaBZOxi4rG6sMlBHTjTIeneGzDJMftm
 Jsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791828800; x=1792433600;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1u7vtvJ1VscGBojbDlDxNg96L1K6AUN+XvvnqPqIY6Q=;
 b=ZY8dc6UBEbQK1l0+yd4ozyAHYgIW1tuI5DLiO+MlAWZAsoDZIwWIvOH0pKDZ68Q5r+
 zzFIweHkZPpncwRwenJfQRpH24InugzQXPPE0HVvBFW+U+x9Qq/tgAmJ7XsXFdzV1PNR
 b4mo4Sc3HdGpEggm6wCE60T/BsRHQyvp4CRM7tB3SgLOyJL2pGL3/1TyFqnFDjONg6fE
 QqqGwMPO3KTy0qJjpBYrN4YnOf5rV9e7sZdLELgaI91c42ZkBU12ov6JKXsR/Z0AN6g+
 +6ra+Z81CZhXRRLKcnzDdO54RkgzJzXMKGBYCqZo7vJY5ZRlGuAQCSzCi56nqajrxMWg
 SkNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6tk2h/Iq05rOAJQyyutGOqjB3Gjb8kuhRJYTKd7gtfHdRh92l4bSwBIT5Bop5+ugXa3zEJQoWfY8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJo1QWt5PgSlZ9PkKJR+a74j1Lha/YCTnIbMmGlaGRsJBvSzkkh
 hyr+aQ4G2HA39mThVr5JVG+VH8A4xYRN7Wc3v4chZnscajqaYO0a0jAchXfse0zafBwLa8eGr9k
 yixILJwVfna8BedeJ47mxyIkPeAdzsi+BNGoz1LaZHQ85JaPvnEozG92o4ZbJrWEONsJXV5k=
X-Gm-Gg: AYBFou2lvQDonA16BuOOSTdt6my0qfKzz0wcBm2QCAx00CI10nYFQ7IOcNfN0CqvOGe
 NUgsq1FfQadyBQkjFqrDlNre2DGD9eOzoOgBuktxXOEJ/jPUehu6xPgYejFOxLf/nZXpUGtvIbF
 HhaLZz8AhDHQbctAXzI8OxTrKx2N6DiHr+GEcS4CVrww3l4Y0vqULvzN0KSpD04XFnAZv5PtTTt
 3UW5R9bzliLGfZezUtRTxqFx94OIv1IYTjenzNHsObuhgvueM/yeVwC4B0EB0veOneEc/pD/7Bj
 W/DLZQB71fsmWPh7tny29dgCg2rQmlP/Hln1LiumkqanE9YdT/wN+m3fBsH8XUFdED35lPtZDr2
 TaKEvx18UgU9XWcPz+XquMkSVsURNDVs=
X-Received: by 2002:a05:701b:2509:b0:16e:7155:98cb with SMTP id
 a92af1059eb24-16e71559b6fmr10328673c88.15.1791828799950; 
 Mon, 12 Oct 2026 11:13:19 -0700 (PDT)
X-Received: by 2002:a05:701b:2509:b0:16e:7155:98cb with SMTP id
 a92af1059eb24-16e71559b6fmr10328643c88.15.1791828799374; 
 Mon, 12 Oct 2026 11:13:19 -0700 (PDT)
Received: from [192.168.29.225] ([49.37.144.177])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a42407e7sm32160285c88.15.2026.10.12.11.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 11:13:18 -0700 (PDT)
Message-ID: <b876df89-6be1-4b06-bc62-df9b7153e77a@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 23:43:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] drm/msm/dpu: do not assume a merged datapath when
 validating mode clock
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
 <20261008-lm_fixes_final-v4-2-fa986071c3c1@oss.qualcomm.com>
 <iqkzz4wnfeeul4nkkemhcvjluucot5ia7pfin5ghu3tkwkjfso@raqzz43t7lxz>
Content-Language: en-US
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
In-Reply-To: <iqkzz4wnfeeul4nkkemhcvjluucot5ia7pfin5ghu3tkwkjfso@raqzz43t7lxz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QdzzLcbv c=1 sm=1 tr=0 ts=6acd2341 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=20alU+YIu2uqf8Hyrg49Cw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=mpA_8Fus6RAmO9hGp9MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfX6Ut0IPE2Lc3C
 VeqYKgi2dc1OpEcGfzpuomyOx/JsPAhcvQrEolXpTKh1yr3zrIyDr7jy45xVRunQNSV1TLi0Hlg
 xB//wuEg/iGbjVFITEG4wzjAmx64A8rJgq+OsaznN1pSOD6e7SIp/mAcVykkwIc6L+4E6hWmY66
 O4KqwLRwAhaw/PpphxTjhuPAJLmX2a9jLmdARZuSe+elfUnwjqKueJ3X6VEOttJPM1g6XS0PYPv
 b9WjatHtABZR21aV4UbIoTfdzKs3sqPaT38Dgz3p7YnFmn/gm8U1Pkdx85Bl4Tm0ZIUegZd71gq
 Ggt+MwiM6Ushkv7CrZ4m+wM5mzOZg975b6PyNXdDbZDUUjgDn3du4eGpp/AJeCP5DAAFB0nx0uj
 bG+ROiQx9n1vUQlF9CKzy1nEEZoGGCVYJVMmuIedj6Zg88CsceTtstHiZbeblx/FIdbsYEVbHvN
 MWDPe5Vdb+AF+EIlskQ==
X-Proofpoint-ORIG-GUID: xSX2ofe-dLqg6fPGKtxUVDpYdiSBhDZK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfXw2FlibnVKY+5
 IBABLmsavE3MsoakSuZGKljjtJFrmo5EeFFZUHkyUJFePNEcEvTovZTs3PWUndhrjyiIOQiWpoV
 EijJiaB0Q0Yz/m3GuYUyH5OYRtG0tug=
X-Proofpoint-GUID: xSX2ofe-dLqg6fPGKtxUVDpYdiSBhDZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120072
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


On 10/12/2026 5:39 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 08, 2026 at 10:53:48PM +0530, Mahadevan P wrote:
>> dpu_crtc_mode_valid() halves the adjusted mode clock whenever the
>> hardware has a 3d_mux block, assuming the mode will be driven by two
>> layer mixers. Modes no wider than MAX_HDISPLAY_SPLIT are driven by a
>> single mixer, so for those the check permits twice the pixel rate the
>> datapath can sustain.
>>
>> Divide by the mixer count the mode will really be driven by, as reported
>> by dpu_crtc_num_lm_for_mode(). Split modes still get the halved rate,
>> single mixer modes are held to what one mixer sustains, and parts
>> without a 3d_mux divide by one.
>>
>> Assisted-by: LLM
>> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> index 0b51a4c5db57..209b25dbeb6c 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> @@ -1631,8 +1631,7 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
>>   	adjusted_mode_clk = dpu_core_perf_adjusted_mode_clk(mode->clock,
>>   							    dpu_kms->perf.perf_cfg);
>>   
>> -	if (dpu_kms->catalog->caps->has_3d_merge)
>> -		adjusted_mode_clk /= 2;
>> +	adjusted_mode_clk /= dpu_crtc_num_lm_for_mode(dpu_kms, mode);
> With the 64-bit division fixed, LGTM. When submitting patches to these
> drivers please make sure to build for armhf as well as for the arm64.
Thanks for reviewing. I’ll replace the division with div_u64() and 
build-test both armhf and arm64 before sending the next revision.

Thanks,
Mahadevan
>
>>   
>>   	/*
>>   	 * The given mode, adjusted for the perf clock factor, should not exceed
>>
>> -- 
>> 2.34.1
>>
