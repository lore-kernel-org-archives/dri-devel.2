Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A4EF3D5E1
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 11:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7D910E3EC;
	Tue,  7 Apr 2026 11:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o67dsR/h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6jNgYoK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC9610E3D8
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 11:00:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376qRN83816989
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 11:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fuV+iVO4z24c9uYmVpxN15rS9osl+Z617fWZV5thnxw=; b=o67dsR/h4UCPZhQO
 v/KIvttt9gLEQwppsfB4RueL+KBSPO72WkU77sphzTPlBRYWAdHE42Gm4/F0ppR7
 Ox94fVBZOE5Dt6lFD6alqy3PuCzXLQcr0F14l2G150/1iaSkbtcRVIY37xGOhLoz
 q3w/hBWTeNMhK9AKO4lp8Lk2ljDPYMnSmllyU+FBYPuQC9LlUG7KrvCKyi6PWNsJ
 ItxeU59Y8FMmEhO+mOMGSN8RfigJ5OuJ7rHgS17jV/YLhEzhuxez69tE+qTrKY22
 2aPSJcyixdUaNEovusfhCqlweB0JbJk6oiWX8fvSJV9jdt3NPNXRtgagd1iaiGKp
 i3AaJQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr4tdm8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 11:00:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d840206c3so2219541cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775559614; x=1776164414;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fuV+iVO4z24c9uYmVpxN15rS9osl+Z617fWZV5thnxw=;
 b=C6jNgYoK321GyDI7JAAL/sDIQSPx1Q9gNfBUWIK6ABo4ErVoN3YnXe4l+LoeFIX+8u
 2wZuQ+SNOZp4AudNoLFFlFUB3BvTWH8Ncry75q5MG5vllMwAPI/ir9+OkuS8Mv94vl2f
 7SzUose/k4OoeUAcrMPB9EHnh06YPneVszNZQUcI9pSVneGjeEOF+uasZmFKDPycNFd3
 X+PMgVuyqSCmijktEy9d6g9j2RiZgO/TojA1dgm/aLh3BgPlOBulETUG+2frYNW/w2PI
 h+E8Oun3+MZdDTVPLLcBConVsQez/ngA1MaVxwNuzCnv5S8ss0+CAXnEwKbSGzxuWVJo
 SvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775559614; x=1776164414;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fuV+iVO4z24c9uYmVpxN15rS9osl+Z617fWZV5thnxw=;
 b=O5s4xLVXEaGT16Z4gFq+jEtlUg/5evNClIL9XTokjJGlT2VL+2q0YBBAUoigIDpXaU
 F0nXUdu8rftGfTS9dYuvDkdJkzVNsa6EaW4z/h1oSMKvofBv3E/zuLfojHVAEEHuqvm7
 UdlxMdg82X0sUFdIfp6Ckw8xz/4eJ7VCfiQrrqh5MxbcIgZ3SIXm+fV6rD4tujU+lwDN
 z5jg5KXCanwxEtNZ3kTFwDPhy64amwEIJOG1mptVIpjQIUqiq4/asKaUfUMBqZb6fZ/h
 Ry8+Ljd28eTP4xvG5pJjFgPEY5q8kzGClSszLPgu4fkQgEC3NZ81ejzOI1ZMuPjVqsE0
 rdWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5GhlcPPLFp+0v69Jex1QdxGfKy8NoHKhryU/c+OHB+B0EYUSgw8aCFRe2naAUlvw3U3BOMp8r0YM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzpvGSwTG2FmCl0cQUbph2cnwxJMZSqqDoLsS5wHP7KDmUZ4te
 zerWkKusnSQxsxjg+9EJlJiqJyOtMQIT1/Y3SZMW14vsn1/47/OvwfBt8GCcCPUIABwBf5MXZOy
 W0Hyrp4dE9rnl6BMddb/K+DL6Y0FNvqQvIVGW+ChREXy4ymEC5mGzkxYZlN4PQLHB7JqzClU=
X-Gm-Gg: AeBDiescV3xpw6USNvv0ucy1rsw9UzHQtBkDdOYPk9JnGO/nZJHKRoqzxwK/nDcwbqC
 eGCSWFA8VJ4YosyyTv5tPewfJv6NenyPWd7E2U6kjfIoeQa1KbMAgGL0E4Sa+/h6sd83zCpXDqn
 p90azI/dNq2NXtnn3+3HJ7ICcY57T00Yr+gGqCjQAX26fA3zXzLBzYGZHPJ03/FOEwh+qE5ii3w
 WrrWGKAxTiQ3S+CdXm+kJt5f3i2BZjN00RJd7QTKcuU8IQWGVBxmvSu8GDAX7u0X4WRFdIQSg3n
 a4/VGKBpHAVSNqosHjPTkZpN/1vvYtu3P/gCTk6QG8VZHMAOYzys0y0eRk47H2Rm0HH4L39LTwS
 wWmsLraSwxhfNrY024r5Zz5qy26GrFYTG4bJFj41xoVtuzlHfkD9HDfWNNq5hzCql7wKw8Wmw2s
 KTIiI=
X-Received: by 2002:a05:622a:260f:b0:509:1057:4a67 with SMTP id
 d75a77b69052e-50d628aee82mr172729851cf.2.1775559613665; 
 Tue, 07 Apr 2026 04:00:13 -0700 (PDT)
X-Received: by 2002:a05:622a:260f:b0:509:1057:4a67 with SMTP id
 d75a77b69052e-50d628aee82mr172729571cf.2.1775559613244; 
 Tue, 07 Apr 2026 04:00:13 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3cff19c0sm541077466b.48.2026.04.07.04.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 04:00:12 -0700 (PDT)
Message-ID: <5ced60bc-e588-4bac-a6cf-3a0f97091993@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 13:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/msm/a8xx: Make a8xx_recover IFPC safe
To: Taniya Das <taniya.das@oss.qualcomm.com>,
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
 <20260407-gfx-clk-fixes-v1-5-4bb5583a5054@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260407-gfx-clk-fixes-v1-5-4bb5583a5054@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dO6WXuZb c=1 sm=1 tr=0 ts=69d4e3be cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=fzR4rbe9g08MilRDY0YA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: tHvKd9sceNvj7oDphpZy6RRTBPjpWnYo
X-Proofpoint-ORIG-GUID: tHvKd9sceNvj7oDphpZy6RRTBPjpWnYo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwMiBTYWx0ZWRfXzfyH9T3w9O65
 Psb66rGM/2iBEtzovqpvIzIH4bAGva0A88HHK7mkodkPFGULhPqVHBhr4Y4p+X6NNcrlo+V9wcV
 9voA+8dWPXmkjKG6ZdOuE/3wfyh/+f/HPZfHyL0F38v1fyU4O2xUTB+msNvkKtzDK1VcVROYEKF
 8HUT/8etizk3YfAuknS98mtRvtHDHeUTMFggTpN/QQmfG9rS3OE46v68ibCEcBwXD+BgZDkNdQD
 5y2+mebyhDvJ0aTXuGwl42ArHsTbUwNwrHn7oS3bOiisuvdqydmRYOaz1O4GQOdmB8IyoutDy7H
 jSCzc1Jy0BEsbLdEhcDeYDMH/9y0hG/BYRrl2o3ZGxAm8r051KisHEUxpAVXawiGDN03F0re/t+
 jxWqNXu3kNWgHdLJBwaj8wRKCKNleRWHpkU6AoJLernzOyKcriqfsrtNu3gr/oqtyp5zf68lo85
 Bk1q/ILZi2OhCxjqhuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070102
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

On 4/7/26 11:30 AM, Taniya Das wrote:
> From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> 
> Similar to a6xx_recover(), check the GX power domain status before
> accessing mmio in GX domain a8xx_recover().
> 
> Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
