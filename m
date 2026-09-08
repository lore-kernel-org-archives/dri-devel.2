Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1209FC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D2E10EB7D;
	Tue,  8 Sep 2026 11:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J8btow6Z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="by7cW3gM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F6210EB7D
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 11:45:06 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688BY9092874432
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 11:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0R6HxB4xS9P0kh2KTlln0CaPw4s9m8YTu+2xy9jIJP0=; b=J8btow6ZiPSUMTeN
 pH5cTdqQgZKjwde99Cx+EoaafbitcoLF6mH6IY0Au81AQJaHYkiBoOep8n8kJNXR
 yEnGxTlxfWs0h+PkmY8eVMrXg4f6z8Fyo2zE317iMDEey2EKq81fXMB5p4P+Ycf0
 3Z73DMWD9q3sNpcDynKiwOdfVJEBpp/j/OfL19M19bS8Y6uqNlrbrX+aiy8mP0xZ
 Arb9FgZxHm0dLrC56ArXCIhul7mXczfIIF9h25cPlbTpH/4sHMkV9Gs3Qb4R6Rua
 RzWgDvrfjkstrijxEjJP0DKuoPBeJ5rLqDRolzCm19NylJc1cL8qHir6WkRSnymh
 pbcpzw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjhkj017m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 11:45:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ffd22d2b1so10197931cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788867905; x=1789472705;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0R6HxB4xS9P0kh2KTlln0CaPw4s9m8YTu+2xy9jIJP0=;
 b=by7cW3gMT9AThABlCKXIkrU/yp8tzggrGrCJYEuooUpekodqc9PaG3m/SDeMNAhREW
 IoofH2UooBSWpFAKH7rUqWqAaGY7FGOvoNM80Mgpm0v+WRM20dNahU2cu2lr9dTK/X/E
 6di01CBwxjquma+LcHgvjzdL7FUjH/tBuxRNOh0mrMrMzZDf5w0XK0NT5kc+HIuvgY0I
 XRo28Mp288zHAfLL1CXz+PjzsKbOmHbBTiKOitWJ67ehylZQVlZvsqd3PLKwXL6jBwA3
 emn6Zw/DjbH7vpRQqk7OTFQqV8zE1uyr3nw4qTsJ/vnqqhsub2eN7V4N3RNVdsU4X8S7
 OJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788867905; x=1789472705;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0R6HxB4xS9P0kh2KTlln0CaPw4s9m8YTu+2xy9jIJP0=;
 b=Hq9OyQJqMh9KEtoWR/ZOPuSofUqockiurdVJARjAiFzZ3FfDfRwn3lTdjMM6uD2Wr5
 xO48tKQ3gL1mlpXb2w/oZdFzlYj3kfEP3bPRUCKP+0tBZsADfyvX1m4Sjk3eTSvLIQLu
 0L7vtJkL6XpQQI8Zw4rlNeyoFvGI4KYX4hlyOC2Q1KpzBRAM/eUCl+XrQHPVGMEkkqHw
 eW5tYaqJSEhrIVa8BJmsxnllspI4KQkpZKZgYBx1v5KoaYTQZbo9D5kE/oIwjVAyLgFP
 mtr+QN+occXcvNwQnrIQWxKZAsga+J5eW4OtJwqP9NS+PxCIcAFxvmRXKhl+sF514OWf
 RfoA==
X-Forwarded-Encrypted: i=1;
 AKwUvByDuyW/vCPagCr6pFnYfijgKjvqaDhbahE5dR3UIIitLP+gzk8gLdZrB80CGuJMXVmy6rsEjXIZ77g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lGbYzh/k1tiqEAmLAo0Vei30aRZER/mJQJNjsskvCkIK+tvxog
 1Rk5SLHoFhieL5ybk4IF/ap9tFiaDqXzKj5mm20GHO5VZEYq7eGF4FANKooiHTlbePcOFW942fp
 P7aZwIJnXi7v7JoXNSwGWsFlZLL/dyMafy7Cb0tNCbkZvtZGUVm+WeG5qhymv7SoApYe0ICc=
X-Gm-Gg: AYBFou00s+5hr44OkgUYRdytNv4sj33yMCiLVc1y5/MULEZey3HRpu/R1kRMCBRxkqk
 xqAuFj3Ry81o81nhTMzPYxfIUsvwZsTQPphO88HsSe8/dzz2Hy3EsJovWvWLjYU/vS6rBt/i+tn
 sP3iCBR8zFrSwlBfgL5NVTgt1KNUvmFw6FLE1tSOYujXC3pTLAar6saaI6HjkhSoOdsQf+3Vc+A
 mm4uqPYLCLllPkIUKEUYezo6NqrBk9yrszsLxllLI0MciW5pENREomfY3PU+Kn0e0Rb7QvMj/qy
 skhW0KGO7qH9D4B+LG8IQ7ZAW5M5zt7QuTYtZ2owR7QqfBZ2r9kG89YT5d9MSiIK/ON/fr+xl5g
 KjGt2128r97DHAH97ACpnhA==
X-Received: by 2002:a05:622a:609:b0:517:6162:daf5 with SMTP id
 d75a77b69052e-5306468ebaemr205196381cf.3.1788867905078; 
 Tue, 08 Sep 2026 04:45:05 -0700 (PDT)
X-Received: by 2002:a05:622a:609:b0:517:6162:daf5 with SMTP id
 d75a77b69052e-5306468ebaemr205195761cf.3.1788867904645; 
 Tue, 08 Sep 2026 04:45:04 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a7e68c3b2esm5717235a12.11.2026.09.08.04.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 04:45:03 -0700 (PDT)
Message-ID: <1f881a4e-3536-482c-8fa3-4e141f633a8c@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 13:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: keep the GPU timestamp monotonic across
 power collapse
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
 <80eb9f51-9cff-4c07-822a-759360617cbf@oss.qualcomm.com>
 <le7zslxe27qauz7duczbxl4rrd3kbekg5cwxzg5tmsy77r2t2z@7gdoif3yfkgg>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <le7zslxe27qauz7duczbxl4rrd3kbekg5cwxzg5tmsy77r2t2z@7gdoif3yfkgg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEyNSBTYWx0ZWRfX/mB5IGfioySf
 Ygfsg/bPHigOtQY1nNSlnDWVwOAvgjkNaDrmavZHAR2myVDwbttwCwmzXY6l7aHRPkYv2hj3YF3
 xZi6q3Dq0WkBQaeDZwM3xDXtilwyUtg=
X-Proofpoint-GUID: WEJw8B3u2QyqY8WSNsOljA89gFV4dYHT
X-Authority-Analysis: v=2.4 cv=VYjH+lp9 c=1 sm=1 tr=0 ts=6a9ff542 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=yFWfLQOVxOdxj_LqjH4A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: WEJw8B3u2QyqY8WSNsOljA89gFV4dYHT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEyNSBTYWx0ZWRfX3v1eyEsxjpr0
 FldjU+yEFB5GrmjBS7Hhx/m6ZY17wx5qvRVNKTx6ys7TVjnct+e5EHzCbK17Tg6jYgs2S3DaU4M
 WErFmzoiZcVJWR9yY464wd8qqiD96YMMZGX0Gwq3HjAPtoe24mBTHRsKULusgyAoMUk2EySPGK1
 yV9MJGkoJIoAd7SPJm9PdzRxr1GLHt/c+0svGcutMD1315t4Lq4BhOf5Y6acTh33MSiOruF5/cC
 igCHEEQYZ+GprMvtvKTesRe8leO1gqLN1CprRvEzmu8WQJ1AvIHZX7M2wjOO3YGZBBGR9AAjID5
 4uxfmDdmgq5RWG1Ssl+8b1/tJt6PJPuLz44Mbp+yc5sUyBECuAT+xx6JuiuYIdH/g5MSkGDC1j7
 CB8OTqBV2IS6GKQn2AjyXDaMjfNjAFZXW6qpFsu99gQj6A/gtj3iWitZE0uYFJJLsNQLd1qZr9c
 OyjAM7IuXzt5G0IrSLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080125
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

On 9/8/26 1:43 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 08, 2026 at 09:03:55AM +0200, Konrad Dybcio wrote:
>> On 8/28/26 1:13 AM, Dmitry Baryshkov wrote:
>>> The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
>>> domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from
>>> zero whenever the GPU is powered up again and the timestamp reported to
>>> userspace jumps backwards. On an a702 six reads three seconds apart all
>>> land in the 500..1200 tick range, stepping backwards twice, and on an
>>> a530 the OpenCL device timer conformance test fails because
>>> clGetDeviceAndHostTimer() returns an end time below the start time.
>>>
>>> Save the counter in the suspend path of the affected generations, while
>>> the GPU is still powered, and add the accumulated ticks to the value
>>> reported to userspace.
>>>
>>> Assisted-by: LLM
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>> The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
>>> domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from zero
>>> whenever the GPU is powered up again and the timestamp userspace reads
>>> jumps backwards.  Accumulate what the counter reached before each suspend
>>> and add it to what is reported afterwards.
>>
>> Could (some) a5xx parts use A5XX_GPMU_ALWAYS_ON_COUNTER/0xa879?
>> msm-3.x defines it as KGSL_PERFCOUNTER_NOT_USED fwiw..
> 
> It seems it also restarts on power collapse (so always on is not
> actually always). Also if it worked, it would have helped only a530 and
> a540 (MSM8996 and MSM8998), leaving SDM630/660 and all MSM8956/76/53/37
> without the fix.

Yeah, that's why I said "some". Is there a chance that's because we
mistreat the cx/gx split on a5xx?

Konrad
