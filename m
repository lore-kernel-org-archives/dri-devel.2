Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A168E9A74D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 042AC10E52F;
	Tue, 24 Mar 2026 09:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GWzCjR/O";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iMeNcf6p";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6722910E52F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:42:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O3e4bJ3634275
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5RZ4GYuvh+6bLS2CH+VBbgVN7UFKGCV6+Omn03Ufz8U=; b=GWzCjR/OrbINmbZJ
 6MOknPUvnd1eshXqPPUnmcBfnG2WVZmSf7KcqyL/OX9L6HBJopkJKyox037aSvHT
 qKDp7TdaQ0yrC4hQnr+ok3/lFlWQlmcppcj2qMCqTbEakWkNWce8trglYrzAAJmJ
 MxZ4UvXAIWvw3AM6yRe7jkzYXJbpJNfWrENT4iM2ViwH6XAO4yoXyrqqh8Lo8XWU
 GFV4PlCvbFlodCFMUlGoDFbnOw1dzmVgvZxbNO9ANzme/OaBhFI4Ju5VIhFFOv0x
 NR59P3A9dwhAcRGJjGL+IPNF22Ac8qK+UJ+fsuc4x0QeLB7HXOqLWXbimmzqlys6
 36yyYA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34k4mdsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:42:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b2955cc1eso31499551cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 02:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774345323; x=1774950123;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5RZ4GYuvh+6bLS2CH+VBbgVN7UFKGCV6+Omn03Ufz8U=;
 b=iMeNcf6pLxuM250LvHOmKuWcYGVgcNX/Zkn2Atoa5K2tc/o4LjafSdGaWMS9gVj7Hm
 fmB7hsFaRl+Ddhbw+1D/7L5Wr/MJWhvrkv6gjLPOnZ9jVeeq3+eXifCOH0+69SjNToMG
 KOP8L14mmTR2o19A8XTAgKmk1TkbjVPQbKec5z7m8lvy5YycxAQZDJg89MbuEvfsPenc
 LmHm5gRIzm4DWEmjnMhylxj/NynXD0O+z2Rf0wwCCU6oljAR3pJZniLrjA/Be1fO168j
 dlHI3LkVNBWI7MU33IvhSXpOFd56rJn4hI+PaFqDFgjz6ub89u5+fdhjc5QX557IX2mP
 8l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774345323; x=1774950123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5RZ4GYuvh+6bLS2CH+VBbgVN7UFKGCV6+Omn03Ufz8U=;
 b=T0d6YvLZWb5NuutOsvGpqnTGXYWLUx8uA7ULG7558+mAhpFsRSyuMSfNlScyka/1Dd
 lK1CU0JyLMZJZA/cUTNQIsPP9E61nNN6L7sVSbP8P+czZDsgO1VWLHfOT7r7ZKwMhdHS
 csea1+wJICQkzGuXosmdQFKK8tI7o8lUeJermpY/yYP9J05uoVTzNa7u0+8cwzplqaR0
 JuZ19hZEBajx+EF8ig3OawWgJJ+M6mw1GMN5D9EM+0ISi6K+q74PO3CRHLcqi05693Qj
 MRrAQWg9H0Um45ovlwz/SacKLV3viuYlWlWRITaYZXJfR8wRW26H4fHtlJ9zX5sG9t0G
 8AUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbX3dmh2thFAnecBQYiZKy9osTGwsdD6QEFE5i95y9/+BsdpUqUENy1vEsziR7Jez+1bPqSi9llZY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBPhTwuEDkEMOb0Mf2A0Rd8/TD1FXA1ZNcuXDTPZmPvWik7nI9
 D1PyH5fn+JpnVSn7H2+ICzer3nwX8kRXVyqVvwR/V3JlcAVoWU9W18lGqOrrvUTg+hET7UANtxW
 Kx4htlzyyGC0UcsAQRZ8CufVEYE4yStb2/WCz5HrIfW3Gg984B8l6Wj/Ms72el02FoWzF2MU=
X-Gm-Gg: ATEYQzwLsf0vi6/e/rSkm1VJaPq4oFZbQ1cav52GVU4yh5alStB9v9w+PSb7UQDt47K
 FbceqSyf7l8LkdaaPsYu3PLTJOpolTtrCb+I4f8CpV4I9L1Z1vBH4vWlsEu3WT7UJX5JgTArQfi
 yxeMo5Ttjqp6mHpVyFw8XeEYpZqtpCzsDC+se3NHlXdPkrf4CVEpIkahykKywlYgeyCwfpZG0UP
 DWPBj0XK2CRU59yR4IM25U7vwnWI3N/r9RiM/Ekg9uUPX6G40HlUARQkfK9TgaCj7/7x1nNs0Vc
 XJJuCn3yVKqe+Rqfxcaax0t7bIEv3j+gU0MJIp7WMxRu46O49xiNeLPzibQnN6EOL3HVmVNkZpd
 A4Ph1rPxu0klj6YwSSIt/gxp9nH/mIs27JPetGNhZsnOWm4TcLKmK6bw+RuAJCHBEmTM/glZ7jW
 1EYbM=
X-Received: by 2002:ac8:7fc4:0:b0:509:1057:4a67 with SMTP id
 d75a77b69052e-50b37425de9mr176705441cf.2.1774345322795; 
 Tue, 24 Mar 2026 02:42:02 -0700 (PDT)
X-Received: by 2002:ac8:7fc4:0:b0:509:1057:4a67 with SMTP id
 d75a77b69052e-50b37425de9mr176705261cf.2.1774345322306; 
 Tue, 24 Mar 2026 02:42:02 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f43ae8sm616743066b.6.2026.03.24.02.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 02:41:59 -0700 (PDT)
Message-ID: <3df24e4f-afba-49c4-b9ff-62db725ff0a3@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 10:41:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: keep copied arguments inside the invoke
 buffer
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, srini@kernel.org,
 amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260324014459.93364-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324014459.93364-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XRLynwLp5UIVVzPdQ76P5Iyzqx3Se81_
X-Proofpoint-ORIG-GUID: XRLynwLp5UIVVzPdQ76P5Iyzqx3Se81_
X-Authority-Analysis: v=2.4 cv=c+imgB9l c=1 sm=1 tr=0 ts=69c25c6b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=H0nZvlvcKp4VijHwmHEA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3NiBTYWx0ZWRfX4kaI2tYWIUQ1
 0UN0D2Gs71uBU7Gci+t6bj8sV3XmZFoaykT8cBX1H2+Fq9V6wHJcG/DwJ66kvCgbr2G57zsl/gU
 RGpnKhle8p2SzXbnNDoV5nJG3SfF49Nwk+r3sWgz4tjGL4VEakP7oegCTmmXZKxYo8cvS5Cx/gD
 jPOwG1onkw/mEnDzMersXJEt1alrOviP9hPuyvwX2a9NZ6qOiFH9K4Z3IkSKEfMlUIuKCkepocs
 CHRHU3rZOFvo4sjP/qyRaMPGkemk5rsR8Njo9TOC/tZPEPF2NrULPnVyjMXcf5qQpgm2YzD3Do1
 pAcVH9UJ+9uC5F5crRn68hpB/OZIm7Tq/vdeS7NoEGV3x34BvBWjRB7owwCvBR8gcIzdXS0CH63
 Q9lSXVOoBVaRjbP8vr9iAOkrzxeWDR2cZD0kaO7K+x7w37BUf/NDzhL3cqgBjuBWtdPLOHzErt3
 JB3j0Q5ZyCOxcsmA6UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240076
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

On 3/24/26 2:44 AM, Pengpeng Hou wrote:
> fastrpc_get_args() derives rpra[i].buf.pv from the overlap offset that
> was computed from user-controlled argument pointers and lengths. The
> resulting destination pointer is then used for copy_from_user() without
> first checking that it still falls inside the allocated invoke buffer.
> 
> Validate the overlap-derived destination range before storing it in
> rpra[i].buf.pv and before copying inline arguments into the invoke
> buffer.
> ---

Your contribution lacks a DCO:

https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

without which we can't accept it.

Please run ./scripts/checkpatch.pl on the patch file

Konrad
