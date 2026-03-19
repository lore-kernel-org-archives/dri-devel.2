Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CCC108E1DD
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF1110E964;
	Thu, 19 Mar 2026 10:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k0zXsckJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cnHHFpg1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A682310E89A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:28:39 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J73u941770603
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wdLyDXI27K7D8gFcDd/WiAUwtco8d/k78JRULpZmNxo=; b=k0zXsckJWZ5odq07
 X5Qzyf2cQT8gE2Dp4sqUwEwChjJozO/Ybvp9LflQgYkpyCVAtebwF2MPAG+pQEic
 iRAm9BohHAQBL1hLh4BSUpBrvK82Rq0Zc/VlORshGoK7L5NMLqGJ2T36xWy6Npka
 Ftd1Z6kep6bpTdCq9a77l5QER2wuV2RXomfzXffDDafU7/6UiMVNuO++VNLTzsNh
 YM8CZZsM/HAORDkNz7vLMANE7Q0Vl9ZboJ08fWNhuz/qwwFg/xDYroNT6SfTiaZD
 7p2m1FgxjOF5QUmFy9XWF2d8bjrYtN5NS36D0ype7XJF9PJyyPcVAA1jRR+0C8TI
 lj4L2g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyy75u3qq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:28:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b33a19837so385471cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773916118; x=1774520918;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wdLyDXI27K7D8gFcDd/WiAUwtco8d/k78JRULpZmNxo=;
 b=cnHHFpg1GpUWOQxRvAqohWNJuwZnihB5Jke511TVDmOQgPf1SfA+8JdjA9/zJCscc+
 hSTh0mkGgSmlGkwZzzZ8mfrHGD7e3p+G+/W50NWKMaBuKDW5+fbLmvs0qW4d0skqjm7T
 1eap828ZoAwO9+mDznWKSgZ8Xnzh75SU1R4sj0purw4Vq5MjuQEBUZxe4F0vD/hfkYrw
 zWmbCtlwHgcfecuzc1SZwx7sCxK7Jt591Nc89YwaNnoJW6JNu46ELRHaf5+ezzNuDf+u
 WvbWlee+wUh1doK6XEgP3KPkTaz2NSk/uvqyVdSRgpND2tnCbSFKt1x5K/ALQBASktYn
 AEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773916118; x=1774520918;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wdLyDXI27K7D8gFcDd/WiAUwtco8d/k78JRULpZmNxo=;
 b=GajZ5hrk2jCRcuXrRg87FJfAyBUSL0kmg/nz4oGtzpHL/oyDdYimNhtj40MZhcXCR3
 g1JlMZjgXaxgvl6+nHXl4yN2w12AlZF5vauvxeF+Z+NZCUv9gIMRyEITXWlgZOMbI61t
 LWpKw0FES5d0q7bpQ1CbwYdDiGXE5cHi6Sw8vajZVwUzNo11bFzfiLrUYYHgtFlB6LQB
 tAqdcxkiFv+4sujhrU2ZBLnjGccV8e439yYwOjgORzPSJOcetM527IBAbqOLZIXFN+FS
 zDVcKte55ou+gXCN5ZDZnd0F26WfaODcOXvmhEuPQ8+b9Sq6pdPVwQogAPd1aOGLdaV9
 1Juw==
X-Gm-Message-State: AOJu0Yy951vti1jD6w3ow+puzI6SC0ksK8FJ3IHH2RTgBk+nb6VrE1XH
 y1NWFKTuy2ldKBZOGwxL0fPuXrlSNI7iRnh+OYF/H21uMnpIDV9QQxuFUUR2ALMwvr3Qm55JeNr
 CwSqLoRCwIJKEeRQll2zaVh//BazVBgNDE+V2zX3cXlrF/S69ttHUhCsy4cA0Tby/vkpKp4w=
X-Gm-Gg: ATEYQzzxhhCXxIGgzg50Bylo/Zt2x8x6g21+R6rkkc4XLRyT5cWarz4qKxHk5EuzHjd
 2VTe3P0738sShhKKpANeZaQTawGxizP4P4CFE2Xj9pa0P6MdOKpS9gj1BCo4rVW+7WR6Lf17InK
 1ZiNGgLBAloDtbuop3SOxRilMKN/z6ncVHGh2VGDUbQV6e8LqqW2VAW9rYaL0DcTMnQ1O3Rra7P
 HaACK/KgE4G/0pgpC0g8bDgjmF10v+0hA+M9K8X6UpCTRe19jPhtzGMxoQK9x3FBtwvYiQZD0RX
 mriR3+Q+bt9r6w3RXCswmtwGG52OA+eHO+iEFVgqcPhhrzq8FdLUuVjaAFY+Ie6fJPe5D5PxJMz
 +R35RQyfFEAua0JgvB0puWj3zBDK5wAuCarGMq9FSrhHomwCCLjdT/eHxML4ZlvFRMiMi5ZCQNH
 x18CU=
X-Received: by 2002:a05:622a:610:b0:509:47e2:9dfd with SMTP id
 d75a77b69052e-50b14949a02mr66570311cf.9.1773916117841; 
 Thu, 19 Mar 2026 03:28:37 -0700 (PDT)
X-Received: by 2002:a05:622a:610:b0:509:47e2:9dfd with SMTP id
 d75a77b69052e-50b14949a02mr66569791cf.9.1773916117066; 
 Thu, 19 Mar 2026 03:28:37 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-667b0eb9affsm3448046a12.18.2026.03.19.03.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 03:28:36 -0700 (PDT)
Message-ID: <393a9fed-4d21-482d-a211-8808e2f79eea@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 11:28:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jonathan Marek <jonathan@marek.ca>
References: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
 <20260318-dsi-dsc-slice-per-pkt-v2-2-0a1b316f8250@pm.me>
 <b56abd7c-1fc0-4627-aae5-06ec8c47ff15@gmail.com>
Content-Language: en-US
In-Reply-To: <b56abd7c-1fc0-4627-aae5-06ec8c47ff15@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA4MyBTYWx0ZWRfXyMvQ11IGrNAa
 aanW1XIbf/mUPBNSIW3VbYf34sLUv5Iy6DF7cNhyq0ZGcO321g8w3b5uwk/X19sa8wFhugwbPDd
 qyLFuT+nj5owlVLStzmku4Da+h+IZGFKVeFIUb1BkLGsxaQl3n6wcgiJTp4k+PNd2KjpoAxg6cZ
 tZebsBGHb4dGyZXqNab4ifjH0Sk3UlzEeeol0xKbJecmC4cbqH2XvMZ9Yr8q8FwgTiuskRtVnBg
 0pAULmQ9u4yLcb8fK1adjxVWR5lHyt6bUx4j8dyDmTY7F9NqxPnOGxh4tbKF9RtGkBtEi3VX87D
 0J8W8S4L5tLPDT7SIKqY/Hy1RsbOClUFwDHBhKaAB0skYCmwA0GiaYHoqtPxE7Y5oq5pX/d6nMD
 P3BB1okJvHYsl028oLvGrOcRE2JsCH9Y2VITdnGy0mdFyv17HHu/s7XFg0QvGVSwsjDx/Nosvnc
 5yUfsGAaz9Oi3TB0NXQ==
X-Proofpoint-ORIG-GUID: H9YSb5M_dFAK8ZwvCLBkIAqIIue_aAmB
X-Authority-Analysis: v=2.4 cv=A7hh/qWG c=1 sm=1 tr=0 ts=69bbcfd7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=RAbU-raeAAAA:8 a=EUspDBNiAAAA:8 a=YgiteBLtTPqnhqBJ560A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=JiizpSU_mAIq9zsZDqn2:22
X-Proofpoint-GUID: H9YSb5M_dFAK8ZwvCLBkIAqIIue_aAmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190083
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

On 3/19/26 11:26 AM, Konrad Dybcio wrote:
> On 3/18/26 10:54 AM, Alexander Koskovich wrote:
>> From: Jonathan Marek <jonathan@marek.ca>
>>
>> Some panels support multiple slice to be sent in a single DSC packet and
>> this feature is a must for specific panels, such as the JDI LPM026M648C.
>>
>> Use the MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag to derive slice_per_pkt
>> from slice_count, note that most panels are expected to just work with
>> just one slice per packet.
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>> ---
> 
> Matches various formulas in the docs
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Sorry for a sloppy trailer, let me try again with the right From:..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
