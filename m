Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A4BC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D97CA10E03E;
	Tue,  8 Sep 2026 07:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mlzeTykR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K3SaNjDd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E80E10E03E
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:04:06 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886M2172712375
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 07:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rSgnM7WQLIr2JaQ5sXzvM8SpynBQx/3leL7JcFUsetI=; b=mlzeTykRkXaD+r/e
 qHrt6wRxHQgbe8cKzUm6jbUJKOKQowVaNY/rFVyO4EanxNfPn89LV+es3Txi7ePw
 XKI5EGhjsigTTh2QdUs66wrQjpoJEawOtPYWfB1EyW+ND2tUc97tuQCaqt2bSkqI
 7m0PQYt5aAwusVD9PK2kOAdbkf2dY66qEi/Ohdya4K9qBkyhQfLGC2BwSsdUBFPr
 UQCoBg/54M/JjcfHw9ngzrd0h5zCXmDeAoN02vAEI7mpg8g6FMRpum3yFZQl/gEs
 3ByD0RnGyZ4uYlEltGlPxoxudohx2XV0dxu58WvPFs5HaCWqFNa63r8VSLjTIgNL
 U68zzA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtdqkxdw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:04:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9310484c005so56216185a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788851040; x=1789455840;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rSgnM7WQLIr2JaQ5sXzvM8SpynBQx/3leL7JcFUsetI=;
 b=K3SaNjDdV7IoBFSMbxMhLa0Tyw/ZizRrMMC/QjSha9EWMRs3SyI8bYX/ZK1kM/au1u
 TeJcia7Z4BLchjGcIA2Myhr+ndNjCDK7awynlkjZc1ifyyp/ZlyR2icE92MhD1bz04U4
 gwPEZofl7zPRMi3JzVh3GZGmiR2V/OVa4lNncjSu8Jw5141pM9eL8Zu6Gk73pLMiRISK
 z6XBaCeBoI4eT8MtsY1yfEurqInR3U3yXHyKs+Q1HYH1mcCpGqj9Tvz93FLFyApEBXrI
 /cqnVluCD/+IPXN9yExLkX0wmFi5+wPUn+yGjIMuyWOoGFBl4xvBtcP64TJaT4/eWd47
 3nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851040; x=1789455840;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rSgnM7WQLIr2JaQ5sXzvM8SpynBQx/3leL7JcFUsetI=;
 b=IQHuw0UYy1yaTsWNGumd2PMV+IRRDkhIFqX6RRgG+OeG5H1REgnMSil/Qa7fhipJZ8
 59ADoR72pDYj9DtqIxKz3IUAOpOgY35hlSpbV/XIBN3viqHlac98gD2mHpY4P5J763mV
 SJFY2aZz/JQSl7U4wKPFmo74i7LTmaQfhIQsY4NdYBHw2vpFxy4q8Hpr1eB91WY8yXU7
 9qtxnsANGPiyLuIkGhxnICh3OHpMe4EaIln1cwTWJ7q5IoLmqo2EmjwLBQwzW5nBGCv6
 vVl+lIoA2vqr//P/JbJx8ABU1CSw2BQ7wia658FdwQOi8OQfUHNoLlkc2YP5uXDYoV1s
 U1TA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0Ioa5vVTsOskQQYXEm65LkjFkpXDJ0VC1Jq7RADZqcOUlHJ+mUiXQblN4jptD1WbLRRPR109DKl4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lubfSRR523Pq9izkS0okFNie0376Pp2G/y0TCV1EubnoMARUcr
 IwSGCwPx71kT2ndVoCGwF2nQPFcRbrTVmkUf/Yx46JR1sganOkxwaeb6enuS/+nEytE4KJWVIT3
 zRStEz2G/6tgtbyWGWWNjEPaXV1XRQ4zIHutFQKF4rKz57JqcsYUtvdLz/pNwbb75Wf5kJmg=
X-Gm-Gg: AYBFou0CjwiJhKbp/BWk+9Pg3/ZLV/XgrEkZgsgvnZ6ab0Ygx/FuyfZg4hRuYQcrxh/
 +cXhICyp0zSVSY3bmw6zB1AOipG9fMSH5RVHho1hOpQcDPMutY6Zovvkll2ImSDfBACDijB9chF
 HtW2mFoKiOp7NiOHziBVx7RzC+ViPjI5sdTtNjrnQi82HS/gESdJzw7N+QbzFGiIj5Sv+sIxciW
 tQl9NSrZmEChsDMXtM7dDspJBeENyxf8fiKJyRrm3TniR9e8FUWgacwFWvnUdglT9xXMayi4PW/
 nBW2Lvn3s55rO9Q0P7cp2SDvtHlNouf1DsQyH3qKzmllqPcwhCA6XcEmTRgK/4Ra8MfDeq2x3GS
 GZ7WRuYSM4NJ9rQNK8X+BcQ==
X-Received: by 2002:a05:620a:4623:b0:931:23a:83ca with SMTP id
 af79cd13be357-93980be17f4mr2342017385a.4.1788851040221; 
 Tue, 08 Sep 2026 00:04:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4623:b0:931:23a:83ca with SMTP id
 af79cd13be357-93980be17f4mr2342006485a.4.1788851038866; 
 Tue, 08 Sep 2026 00:03:58 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5497cbsm564096566b.34.2026.09.08.00.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 00:03:58 -0700 (PDT)
Message-ID: <80eb9f51-9cff-4c07-822a-759360617cbf@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 09:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: keep the GPU timestamp monotonic across
 power collapse
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MSBTYWx0ZWRfX5GLCq0tWd1Ho
 AiAUx0SDybbAlotQC1UqWArfO7BnrBcNgB15rUt6NpCUbJ9DsDb3fAlmuKYZw+LcwBHuuzz6prw
 CiTLqZl+OGkfL2oRI8dnR2wrEJyuTzGMGlIYfjH6VDVSu9ANjSah5WcL1OG1OB3XjT2awDGGmrt
 iXA602WCVMscYzOPn96hsxtjhmR5KYj/vZeRq/q2RyvifqrUSeMzG/SRPUdXhsvI6OCQ11QNa0J
 5oIDooo3qsHz9iFD/wmE1kpJ47ydW+vvdJ0/hQ7v7fbqZsAcDHNdF26x1wDoHfT6QATIzvDPmGr
 igYX3k0FecHJ17XgpoV8yYnZJf10odnmHBePcAsWmEfH1+KkmzErFCPSGztSZthNUT2L5ZEpWJu
 zpd5Q9K8dc0p5Lpiu+OtgPU4Uo6ObagJIT9o6yMVckntR5nWKF/xogQ73Wui7O8x3LCey4Pb8GX
 FskBRT/wpvx8CmgWaxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MSBTYWx0ZWRfX2WzEpNoo4rOz
 Bbb+Xm5/0ALNfisbsk3lba+3PENFT1IySz57BQdxl0iv8k+7MCtNVnUo5b86ZyH+WONn4QsGdg8
 ZPI6tg6W1hRd/BM9X0HavadJnf25c0o=
X-Proofpoint-ORIG-GUID: omfwTWs4qpqAglem9Dox4vvAJzv75DQY
X-Authority-Analysis: v=2.4 cv=U6aiy+ru c=1 sm=1 tr=0 ts=6a9fb365 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=xJso4tAO6kuAywU0jPoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: omfwTWs4qpqAglem9Dox4vvAJzv75DQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080071
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

On 8/28/26 1:13 AM, Dmitry Baryshkov wrote:
> The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
> domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from
> zero whenever the GPU is powered up again and the timestamp reported to
> userspace jumps backwards. On an a702 six reads three seconds apart all
> land in the 500..1200 tick range, stepping backwards twice, and on an
> a530 the OpenCL device timer conformance test fails because
> clGetDeviceAndHostTimer() returns an end time below the start time.
> 
> Save the counter in the suspend path of the affected generations, while
> the GPU is still powered, and add the accumulated ticks to the value
> reported to userspace.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
> domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from zero
> whenever the GPU is powered up again and the timestamp userspace reads
> jumps backwards.  Accumulate what the counter reached before each suspend
> and add it to what is reported afterwards.

Could (some) a5xx parts use A5XX_GPMU_ALWAYS_ON_COUNTER/0xa879?
msm-3.x defines it as KGSL_PERFCOUNTER_NOT_USED fwiw..

Konrad
