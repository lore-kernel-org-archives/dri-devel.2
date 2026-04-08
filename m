Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89B8FD5F87
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193B910E546;
	Wed,  8 Apr 2026 07:26:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ao2psTjY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Na/U8eDZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4CD910E523
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 07:26:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63839prH2412018
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Apr 2026 07:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2H3ndmymhmzrh7O0zHIVLNuQNg52ggIc09GsHqPIwgE=; b=ao2psTjYeuWNlIks
 B5Ha/DIf2FQdzBeLJtw1QsyMDquC/j2XyIYVbKXYIN7mh7YzY/zMCUHE3P8DfwW8
 2HKO31tRLLktwRrB3QMXuVigxSLZz2xGIiLiHUbLbHVyPSO+LufMCmTF6yVbf/FR
 Y2Z4cNxCZ0URB1s9Fb8fKC8GJ39wMPx6xyNi3L4YY3CDU3bpzhayeZq0jE4a6V0a
 fY7TIbaNxj1OSLpxLJZvgUjQSik99Lt7Q0NRagJDESD/pJ3NFRwGwdDo5SOPjKFe
 ML+jYsg4QS9kVVGllbGekzJfgPtOYgPCKcfh5kgLPIDUOYCvtQFbjbxOukpAeqNj
 iIweUA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd61vaj6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 07:26:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82cd9fa608bso10052792b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 00:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775633184; x=1776237984;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2H3ndmymhmzrh7O0zHIVLNuQNg52ggIc09GsHqPIwgE=;
 b=Na/U8eDZ26XI8zEC3vEkRLS9R/6lRFg1vn3xjd1tZ9fgV8ORfgZfTS37jlDrxpSznn
 k/fL+rjQ5afKIDOjzV54TCU4L4brNp/mFgr5LEnWyrqRRF/bc/A9kgnvhXAx8Lf7c1KM
 SmYy3ZFUstpQyQKunpZvbWbj5IlOWB2/WhqUA6sNoYiatnqM/ryDzbUqFUwgHum3xkaj
 RwZA2vIyyyVGFtXZa6am7WDUXQ5l4p5k7Kk3qe8uwuVjwo3/NVR4wpbgsEYQ1moRg+Ou
 +p5ojIoiL+WBRs3ho1zJDt7xnxI2Trmxci/d0suw46tbuxQaobto1aTzAQqlDzn2jzsk
 kLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775633184; x=1776237984;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2H3ndmymhmzrh7O0zHIVLNuQNg52ggIc09GsHqPIwgE=;
 b=cC2o5Nnfp5td94tv84JhSWeikL6SxzwDpznx+76UHV608mQxv6uXEr6+eiyeUpS5I/
 kDAvCRVeemMbyszkTij/4Gs7Mgu7E4CKRrDJr3FoLvemNIKzBRO4STthfTPPoQs9jQIk
 V8RcN/TivKamDundB2tIe8zEyC8z+ySKPBg8rIo89ZuSblK4oisNhNZsPelMftbXZ4TQ
 o+wvS3vx5quLVOUwVO9BPLvpjBwTx5uO91t7tCu3JPjSkIwptRTISb9EI6UsVjzIt7VY
 7t1LClKyAh8S3XmvmFDmtA/9ce1jMz+adzy2RqRsxiW4aKj+DeWRvJwAfKdwtIafvklE
 fRIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3h7nS2hPZSPSMtvjxRuUZseA7AI9pXTBEaGCKqCGk/+Fy7E0FXvy3NpIpcXi599jvq2Wt3imYDrc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMvGiqL+bXSOGHD52ZWX1OLQ+ywhEYxYd6M53r4UoJllQRJ9+3
 95rYVmwP9ddHK9acksOiZKU8dOid+mjOgcq3QGC4YLMnLuaJB8mPPirC8CSQeo8i4nPC++GZfV4
 BxjfvIRNfdasxs6GrnLoE0LOUJui/bykFKQE8NuaHhvy66vasV0VTJ7OlGeMGBLgOjmw9Ads=
X-Gm-Gg: AeBDiesgN0+/bbGk7trFggQVEHdhJv/2LNiEFccqzTDmindGSPskV0ElsVKbHh8MfXB
 fPvqaYg4necTs7x3P5ERryNmYbVTDxeO1hvdejMWwFXHbahmccEpcxYQlZDyxc4afXadAF7P1XC
 BHiSG/lJmZ0bPodVdA+SdkmBnmq1k1bh5qPS3mo6QTEsjKhQTZDccCgSlzdA7gG28Ll531MU1or
 BVYcPe5+5Pnvkn0HV1M64hHuC7z2DTPPSm33fpxjIm/3R4TO4+fgoyqSkCopLSrGry/+qX1yDkz
 wVrQu/8Blzc//kg8j8iug0ia6JOeIZoykKDhz5B3D4J4pLJN/bsGisfs/ulhbgFoxmm9lznU1R7
 8Mi3JGAEkF4SsnjoEolXgLGtihuM8xVbpYA1Z4Hvcr7ZOIZ6cyw==
X-Received: by 2002:a05:6a00:800a:b0:82a:6d9d:3f85 with SMTP id
 d2e1a72fcca58-82d0dbbca07mr20585726b3a.48.1775633183761; 
 Wed, 08 Apr 2026 00:26:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:800a:b0:82a:6d9d:3f85 with SMTP id
 d2e1a72fcca58-82d0dbbca07mr20585685b3a.48.1775633183348; 
 Wed, 08 Apr 2026 00:26:23 -0700 (PDT)
Received: from [10.217.217.198] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c68273sm24431255b3a.41.2026.04.08.00.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 00:26:23 -0700 (PDT)
Message-ID: <38aa8c0b-fb29-44c9-a346-363220264c7c@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 12:56:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] clk: qcom: common: ensure runtime PM suspend
 completes on probe
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
 <20260407-gfx-clk-fixes-v1-3-4bb5583a5054@oss.qualcomm.com>
 <c72e02c7-57d8-4353-a6d8-9dbf4f7a7e37@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <c72e02c7-57d8-4353-a6d8-9dbf4f7a7e37@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA2NiBTYWx0ZWRfX7rQv57b+7Hp2
 c+n4zb2i4vVltQzKPqZC2yoKlQqAT6VHwVQOZMnvhqoF89jxq5QWU5/aP3PDuV/RqJyggnjokh1
 7xNyxdv/seXTTGqsC+D63jGRCYkiigcTf0EJ6e211FW57vabVqAZym5Cj84I0ROM4GrAQkqBjf7
 PbsSrw7JnguEJU/wDGPJFvmZ/0+p3Dyk12B/J/NLee4IZN44YlA6P8T9aVgYJZ5sKSLCpu0GZIC
 CXQzXav5Mv0WIN/JgnDbx3cQldohhN/ARc7FBSJ0nc8XwM6PoKDWfjEjvrjXQbW1D8OAoAwhMdd
 2B0q3LsGBFsIJxwg5daHwDMQUPMDPr/YULse7SHYGveEF3MMRrW6i0E0x/1KNXexH8tbfbRPEy2
 V1w2v8S3E2JLsPYLHww9gtoq/2jpU2Xqxt2bix3I48eWhStkP0pZ08J4W1xfozFNA0JGcsMeR1m
 +K7XhlNqgUhLzgvLYgg==
X-Authority-Analysis: v=2.4 cv=FecHAp+6 c=1 sm=1 tr=0 ts=69d60320 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Ej0lypjitWEjAblOXOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: QU73LF04o8DG1nBjSHKgS_1lbUDP70ql
X-Proofpoint-GUID: QU73LF04o8DG1nBjSHKgS_1lbUDP70ql
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080066
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



On 4/7/2026 4:28 PM, Konrad Dybcio wrote:
> On 4/7/26 11:30 AM, Taniya Das wrote:
>> When the clock controller is probed with 'use_rpm' enabled, the
>> runtime PM reference is currently released using pm_runtime_put(),
>> which may return before the runtime suspend has completed. This
>> can leave the power domain transition in progress while the probe
>> path continues or returns.
>>
>> Use pm_runtime_put_sync() instead to ensure the runtime PM “put”
>> completes synchronously during probe, guaranteeing the device is
>> fully runtime‑suspended before returning.
> 
> It's not immediately obvious why that's an issue, is there an
> observable problem when the transition doesn't complete in time?
> 
> Konrad


Calling pm_runtime_disable() immediately after pm_runtime_put() prevents
the runtime suspend from completing, leaving the clock controller active
and the HW rails in the ON state.


-- 
Thanks,
Taniya Das

