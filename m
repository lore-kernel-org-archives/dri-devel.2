Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B69D1061B1F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DCE10E7F4;
	Mon, 30 Mar 2026 20:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8pH9ESR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LS6LleHo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E298510E7F4
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:37:26 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UIWNKD703510
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yImGOfkvrPNf4nn8Y5ji+vWnvutW5wQn5OLphXqepxc=; b=h8pH9ESRUw8OQd9Z
 DrbVOl1897hzpjGCSTkjgIQIX/iyKB10CU9rXzUk6wgkjDEnQetMvn2414lyBQ16
 x0oOLPeLLjwm6qntOVXWRYeaa0bOz5uZ096ZGbGTKrXqfZZmBEmdwULiVW9MtIXB
 XsMxa5l3NEwPAzHabr1E1AFVu+1M0bZ1tKhv/IKShJAjdb5/sg1zM+dU8esdTP/1
 joCL7CpfzeRug30gUSM4xqUQzZcd3ypYTANGs8qvOIJx3bk9VT8qylq38BFvd5UW
 UTOmN2TstX9hplzwqSFZgFGD/nes2n8I3C/qX2GLzPx/Qz3XzYOlSsgz8AEyfesJ
 vUO0OA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7sansv2q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:37:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c7422397574so9142289a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774903045; x=1775507845;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yImGOfkvrPNf4nn8Y5ji+vWnvutW5wQn5OLphXqepxc=;
 b=LS6LleHo3hBSoOSLNNhw1oxY9IsPo6+ZVC6xROJ+a62ITYxVSJEPpNx4YJe5qTdX0L
 ZV+a4gSYsRSBTWin0I+vzfUAgrNTmWKbzC+MV5rdBeQDjVhki1tUuYjUBLwhrOswj+ik
 FO/+SIJRkr3ECEVEEQLL+8wtB0CeXHh3k3cgC/hTebVjwF2CSPZJw4bGbocErIRfnSrr
 /BqdOoWKaMGzGcBmj3VIck/9WwAjahaKkHLvM2Bn34qAABs4+UPOLxE+TrQQeW9tSnqG
 rxsFKVdFnVfXT8pJfnVf5rWRBnDEl/xliXQzR4kiNKbLXy02ouy2VMbN76P3NE/9CWnk
 vIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774903045; x=1775507845;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yImGOfkvrPNf4nn8Y5ji+vWnvutW5wQn5OLphXqepxc=;
 b=GNbIQuFvGaG4UHVV19NQVaL1asNBVJQ1D092GiL1wdHzVD4jEpupMgiAsCMOhdXeX3
 iuA5PwL1UxaS9DcYuk6Ta86DSUkWAXKhviM5S1B8zoHT48P6DQucQopDzVtq1e54nCtn
 NRgBtZi8IPLez4U7WKAPlcQdmdyRKOXmYAE8pYg/shtvZE5sQUnwiVUs6pHY4U+vwRHy
 0gbtFRN+z0pGLEKmyfWFxiGE4FWJ17GDACBUs4QylALChUdPGVWAyn27dXzCue2AAYEZ
 i9oTDlOrz9c/qwZ2MsJHu5T8zWqyqzeFAVXx8DydEAiaxjPLzMkOLOkeB4avtm/14pO7
 wtww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkPS08sg9Kd94BLR3K45aVotrSZF43ejOHbOWfONO7Zfit3HKM2WJbp5Uu+JgPvudIwt0eH+cv1p0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmwKUey8TcIDpm1QIE6DWPSOFoU6E2wpKgpj9S3Q7/T7jSdOkI
 g4H6axbCuZQfop0Wk3bmK6J0839mWd9kaUasgtaMralMkZ9lt6LdiyMt0P5yBjyqXl51xdMjO1T
 M/V56FIJ428xflAWux0mpsG6E2m454++QAPmjJZ3PBO1MSaH+nrI3jmAxUrcSGyNNP/D6gow=
X-Gm-Gg: ATEYQzwz49sseBQyie/7DItPe++IVFxxSfrwVHmbfCBcUkXr9MM3mgo7ynYI1xBz08M
 f5Ykzacwiq2X75QR2pXmQsvx8v94lAB6KnQj/5n73lasn8Wqz+pacK8VNKGfcr/ZdpKVo0pnYEM
 wDc1Vm6LvjnQrQ8Tc4liDP3SbNnxNf2SDkj1d2/oBWvNaJIkPMM8gtnjhXA23iKwi3OykLBCf8e
 QNM34UypFb42Aob1TZcM8hybyieT67H6aPYbfmZYKhdm0qBBdg9gfgGCmMPMspi0y6zmFmzD6Bk
 RGkfedArQ+8DzjOgAhe+k4GRQdFwNa7M/uj64Ggb3SrFQN/42ZhG/+UnnAybZovZv44EcTZ0R7F
 jGfvF3t9TwyPZZHspdNQ5ME437SlXhvFLH1Ihwq6ntTQX
X-Received: by 2002:a05:6a00:1488:b0:82c:247b:ffdc with SMTP id
 d2e1a72fcca58-82c95ee518bmr13677904b3a.29.1774903045015; 
 Mon, 30 Mar 2026 13:37:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:1488:b0:82c:247b:ffdc with SMTP id
 d2e1a72fcca58-82c95ee518bmr13677865b3a.29.1774903044509; 
 Mon, 30 Mar 2026 13:37:24 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca86247c9sm8270549b3a.54.2026.03.30.13.37.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 13:37:24 -0700 (PDT)
Message-ID: <8cc91ff8-55a4-4662-bea5-355524490591@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:07:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] drm/msm/a6xx: Fix gpu init from secure world
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
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-10-fc95b8d9c017@oss.qualcomm.com>
 <e44e776c-df8f-4555-a487-9a7a6fe032dd@oss.qualcomm.com>
 <7d223573-438c-4e93-b4b4-64975c4da93f@oss.qualcomm.com>
 <4522e20c-70ab-48ef-8b0b-59f2548ebe64@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4522e20c-70ab-48ef-8b0b-59f2548ebe64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 131YjPEUnPxLJUuMsuDbeQsNXGzvSrKI
X-Proofpoint-ORIG-GUID: 131YjPEUnPxLJUuMsuDbeQsNXGzvSrKI
X-Authority-Analysis: v=2.4 cv=NofcssdJ c=1 sm=1 tr=0 ts=69cadf06 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0_mfmPpWdV7espOYW9wA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3NCBTYWx0ZWRfX+LztwaOKW18+
 Baqs/EjhBlZk58iRwV7eo+mNxXZmDS0tLmQvR348Wkepa9r8GIdQk6V8Lb8bpy9v5N39kO1wP2w
 Qeja4JWTs2lTVz2wJInQa3yB1umun5gIIsLmm6ouuno1Abv73HPHlq9FHQOZCxqy1c7x5YZMBCT
 oIzhhmeokYM+VTO2XhiKzQO6/EnTjJqAzZ0OJnDcHpW9vTaDZk2/qrNCc3mP446pr+jgnSJ9QmJ
 p+qOsEZksPSoo8oOHQEd61voXSXlOH92GXwY5CAywVuWZG+0MBZKV7FcSnetee8sNEPuI2aCTNv
 bUv7kFYXFemc4RJele6Zeg8lkEvVrS5fFd8cxPa5ruzi6MZZB8L6sX/AF80E3SgQqb7fJ73rhNT
 VjvX0g7r3saUlS9dtdREC8FF1cWmrDQMYdfeuga+IWBqJhkKTN9W+39jfeVym7yUS3tkhfsF+oL
 JtR6AySAA2sufbGV8ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300174
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

On 3/27/2026 4:53 PM, Konrad Dybcio wrote:
> On 3/26/26 9:12 PM, Akhil P Oommen wrote:
>> On 3/24/2026 3:37 PM, Konrad Dybcio wrote:
>>> On 3/23/26 9:12 PM, Akhil P Oommen wrote:
>>>> A7XX_GEN2 and newer GPUs requires initialization of few configurations
>>>> related to features/power from secure world. The SCM call to do this
>>>> should be triggered after GDSC and clocks are enabled. So, keep this
>>>> sequence to a6xx_gmu_resume instead of the probe.
>>>>
>>>> Fixes: 14b27d5df3ea ("drm/msm/a7xx: Initialize a750 "software fuse"")
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>
>>> This now makes this happen on *every GMU resume*, which sounds
>>> undesirable (kgsl does this in gen7_gmu_first_boot)
>>
>> I had this in my TODO list, but forgot to update. Will fix.
>>
>>>
>>> Similarly, we call a8xx_gpu_get_slice_info() on *every resume*
>>
>> No. We check then slice_mask and return early.
> 
> Right, but we still branch into it
> 
> I think the best solution would be to add something like
> gmu_first_boot_setup() which would be tracked by something like that
> bit you added in v2, where similar things could be moved
> 
> That said, this is just an optimization

Perhaps, a micro-optimization. ;)

-Akhil

> 
> Konrad

