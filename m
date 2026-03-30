Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CE31061B1F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D180410E7FA;
	Mon, 30 Mar 2026 20:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TdIo0hFl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VN0u5JTa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EFB410E7F4
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:36:29 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UFsEbG2724837
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8DdCjqkFX6DAQ5T7tG9aGJIphu8jVEoKOAglgAot+pA=; b=TdIo0hFljGYZLFzL
 I8ekSn8VQTdIDt1StcIv6vEgMNF/Zhzo+uqG8Oi/9UbDlvKbZ0buWWYtD2Wl7afr
 g+E4JV9PRvVKAp+4xSXdk7YQ3Sp1IXMsG6OMldHVn5QKhYyZeZq4XnnWsEZIEB5w
 Y7zScZnFLg0ZIWMeWXZSsWgGYnlmjTGSoChFU5iMplTYfCkJibz/UMOAmhpMrjDX
 KRUxvSAhTqu8dghmktUFRnwUGD7ZbNs1J1acG6cOSeSCpPkBB3FXKLmqg3CTvOFR
 06XTNO9UdLIfmbB2sD/EnLT+CheYziNIAOeXfteQSqzbY11IjyTiYvvdl80K9y4W
 UWWkmg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7qt0j9ec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:36:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c70f19f0f37so3052948a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774902987; x=1775507787;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8DdCjqkFX6DAQ5T7tG9aGJIphu8jVEoKOAglgAot+pA=;
 b=VN0u5JTaKWBB/slF4GKqUWyuALsfqTydbEBBiUARhSaPTQEtMIxJMsXP6L5x4KbXPG
 i65K9/D/dYIMIYcOYpW6/SsQdpWCBJSZQqkhE92FlWRCp1T8mpOphz12X9Rx6eoH5yyM
 mCusqOwcDlfBfQI0TaTOZt/iDlWl3LIpPxLDGiLNQAo39ddbkJtgjWb1U66z5Ny3/FG/
 JywsK6xWawPtji/LYdogaAhQdRwgMfftmJUtN1bpsP4HsD/eXwsItHb5F8DbVhoawjzR
 giqQ31DTrVfHOXEdEHoTjnnr6731e2wNDoyvr7FHZsWSWKLDoRGUtPvMcB8Cfv+1OYsJ
 chww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774902987; x=1775507787;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8DdCjqkFX6DAQ5T7tG9aGJIphu8jVEoKOAglgAot+pA=;
 b=A9pzckjdR/RvddYPOXfFQ3EE+vby4GfUL6LZpke7+bYPJ01ar939I8qtB8WoxIbp/a
 aEcqjIHRoBGS0fcT4e6egsegLRLHYN1GYvQSQcQF+Vivkr2F+aETaPMEW6/rx9aMxSJ+
 3Strt4si/YmalLsjw2gBsCZ9UIfQWtJf8gJ6tkbfn6z9VbZ8zXVBC+94jni8enTlDm02
 2tpDyl/rd6JKnUT9CondRT3V1U6BXGPCss8Ltph5j+6w3ltedlwaWk07XIXadxcNSNPr
 AUdNQ1A0kZUYRux7rxkYyjR+NokNuiEPtdv0JAs2RyzX6C4oVgGyLaNJUB6ZoFyfxebN
 44mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOwOeEZGTnER/+0qU2SeaVHXROCkipvT4gDCsVwuuXvYG/Nf75vDQo59d5iN/dtEfrITQvvk/EFW4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4GPIeGwc+cROey61ph+RkSXlMFgYD78V+M4BC3/kMqpzWWOww
 CFe0uQ9CQkqwpk3q+oqVjwNpHOJ5J4TEuO+z/88lGSetyKFMzLFlbotSmUYLN2IY78xhcbZLJZZ
 hSj66Khno3JhosvfeK1rHxym1ibdYxQ4xofD/QsMXVV/YAqIJ9x2yjRg1OaogliOW1ZzQP00=
X-Gm-Gg: ATEYQzzc1krWssTaYVWDehOUYbWQ7JYfRePSAZpkvSjg0TpSXhMi3CFEpM6Hh4NSIcC
 lqY+zQtsQ4B4+B5mR+ouE6VtktOtGKiACk+vRTPbltqXJJZTQxnjpz90DHlEaS6SaW5T2rH8Bx6
 5BPyPM/WkIWIBvtxFIpqQ0sxFDp5Fu4pQjhQ2Fy7CHsBJf2e71Mr38DWy+6lV3zJD8Uwnmwu+4U
 gBkI3+IF+VwTsLtYGGJ9ciNHVPjRqzgl3bCczLvd4aznltd6i4sNso/kHLL9+cm4uTS6GDPpvTJ
 Pqoi/fqESMFNnUjyqWbAJ86+vlBKCh8kUX6AnJD4zSUxgUuPu0Geyx97Xnv3xn0pHZ3vjv7qOI6
 PBwgX9jfus2f+YDPubecaUryqMAYt8H7xJiNjFvFXTSmb
X-Received: by 2002:a05:6a00:3906:b0:827:32dd:59c5 with SMTP id
 d2e1a72fcca58-82cd6652d45mr752599b3a.28.1774902987285; 
 Mon, 30 Mar 2026 13:36:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:3906:b0:827:32dd:59c5 with SMTP id
 d2e1a72fcca58-82cd6652d45mr752566b3a.28.1774902986739; 
 Mon, 30 Mar 2026 13:36:26 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8436f19sm8173031b3a.9.2026.03.30.13.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 13:36:26 -0700 (PDT)
Message-ID: <8acb72cc-f82a-469e-9683-0d2200071662@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:06:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/17] drm/msm/a6xx: Add soft fuse detection support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-12-2b53c38d2101@oss.qualcomm.com>
 <f7412989-5454-4877-836b-268ca27c5731@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f7412989-5454-4877-836b-268ca27c5731@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XN09iAhE c=1 sm=1 tr=0 ts=69cadecc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FwsNaeLtNlZf7HSmVAIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: ck1l9Xl-TUYaXfo9_H-ExKKd8OmG2LkB
X-Proofpoint-ORIG-GUID: ck1l9Xl-TUYaXfo9_H-ExKKd8OmG2LkB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3NCBTYWx0ZWRfX/hr6STzqCf3H
 lfisXm0xEk31w9iWVZtVbKK2GVEw4ATidAwXQOZqSX+xhEwJ2cHh8oBplXgG83gouiFhTRZdTa+
 232fzwmbMP/65zFovxLMLt6Fqb2X7ITiEdbBZRkV3pgeg4oghGeOZIoY42bhHHxViXvqDLyyBEh
 hj+v+KyEFcdl2sv6LwhyX/gEJ5yxvNw/SxVmkkrJUwElT00POykF5b0o0hcrwN+vGekQ+hruaAd
 WPUBGujmx7hwXw7eMShFHHDxV0NyIjx3W6IikxigjAQGQ01BsvjPozQHG4gD+L0RWdoXiiMV72u
 iMkQKoJj8S1h0QXnVpxO22pVua5r8TdqUnBMud9RREOHme9o+5V9rj5flK6Hqki4EoYlS2spkyL
 UUSNfICyECdNMICI9Rvfjt1mCxn6vdhbt7IrAihxsmJYAX3UY4hVR9BFKO6GcacLfkiuYi4vF2B
 qk79Hz5QiztPbMV/Z9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300174
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

On 3/27/2026 4:46 PM, Konrad Dybcio wrote:
> On 3/27/26 1:14 AM, Akhil P Oommen wrote:
>> Recent chipsets like Glymur supports a new mechanism for SKU detection.
>> A new CX_MISC register exposes the combined (or final) speedbin value
>> from both HW fuse register and the Soft Fuse register. Implement this new
>> SKU detection along with a new quirk to identify the GPUs that has soft
>> fuse support.
>>
>> There is a side effect of this patch on A4x and older series. The
>> speedbin field in the MSM_PARAM_CHIPID will be 0 instead of 0xffff. This
>> should be okay as Mesa correctly handles it. Speedbin was not even a
>> thing when those GPUs' support were added.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> My comments here remain
> 
> https://lore.kernel.org/linux-arm-msm/20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com/T/#mc97f65496ba60ecfc977bce1b5bb6d3922711ae3
> 

We can ignore the SOFTSKUDISABLED bit in the driver.

-Akhil.

> Konrad

