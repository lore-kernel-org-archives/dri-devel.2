Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AACC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CAC10E790;
	Mon, 17 Aug 2026 12:01:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b0a+x88Z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/oPd0Qo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2849E10E776
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:01:06 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9ddJ81533495
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TRqInRFjr4g8d6uI8kZ2yR16BwVUWq21eU3sFx6HoE8=; b=b0a+x88ZPlyvILLS
 wFJN4nZcNgJzO1ST9v40H5+jEHsMLNdebbtbPsUN7Ek1XXdCuuEAQrWLgsd95KsX
 6pYCAEo0wu4JYU4mFLLwOh077ITqlGvtq1ROxAA27VW+D2YYNbuktZQn+lyerUwK
 CrCaV1D2+sGWcYx/TxOeTgjIkTIlsIBDG33tQkFxKS8LjiOYXYx+V+L5YBFHdNMo
 Ew9T2erte0SO2GUSj0d8ZXOqHGaCnSWdSQTBmwDOAYSqG6B0YkDJxzP7IXFvg9jt
 M9IimyrQNCJEk8rJFnxgjjARGsLlJdD6b/4truxQBWX25lEbzaHIC1ggMA+vH/vM
 vuy0fw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xb1gvt8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:01:05 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7386e55c63cso46799137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786968064; x=1787572864;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TRqInRFjr4g8d6uI8kZ2yR16BwVUWq21eU3sFx6HoE8=;
 b=W/oPd0QoKJg2jpyXSprHy2C4VD7Vtashi5vtmNa0fXnK6CpVrCTPR7LF1GwsiK56Gj
 wjLlOX8+2umB7/AJZPvYPH6FtvpL2CGDRsFdi5E7y4HDSl8xgzThSJ1VeEnvZaA53Pw3
 LiKgmBhQwHhB5V8Ao8mnvOYSgVVXZ+B0Y9UAsZkIi7gj9/qxu89bgiR8xyPu2CdeyKbA
 2ZyOfU7uFs7yNeVWs5mJirFfcFXP/xLVnz/mJzTym5ZHaMa5BdXAJsuUkON4YwNqadUR
 UywaLu+0I6iQXXHTer8GcgtaIhC+w6AYSu/xbEPtJ801SawUt419mD7ESopsuqKKKvM1
 pOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968064; x=1787572864;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TRqInRFjr4g8d6uI8kZ2yR16BwVUWq21eU3sFx6HoE8=;
 b=N3/4gYiRx0GYUTfQCkrqwP5ZT7iv1M8iupL9FCTj9ZZp+2UEMEtckqaIiwB7/f+4Jf
 ZFSKGPOHT4dkbODnSTFK+eArwXJpKkGPviVEUPbhAdEGQ6aOkfIMTNkPbWzSXc7zPuaQ
 HgosY3qKx9PlLNfBSwgA5o1ZO3CpnOB5Bwu3VDr0puRi3pUCdhps0F04tctkhVjN0Ypt
 /8wuaAOCuAXEbiIsbyPjGc5Ylhz+KM9BipUb3qUXhLor0MV02otODxLfBifcybVKHjhC
 7ps2WxHAzoHeRYPBhGU+avXaSk3es19NOKqmHyjTc3Slvm7bAFEU0BuHW+pt6R7nbIv8
 xQ3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpB+jJToaa+v03dsZQL8rFxerDBOnfapnwkZU9TWIevAWWF46Z3ONpPCh0jro13LuxDNwc/yq0ibY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywqh4arbLT71FIC4fxw3BzdUwz5cCdb3Deo32NBYz7dBllESAaI
 6gExJdvj4TS313CPqNoHiOzclAGg6wlIXQzXCTLyt51q7PcmoNlDOc1H/aSbAWyXxgPoFyA+ga4
 +5S586M0DoEgehvpTIqGa9FaFzkfO6RJtjCR1EQQivyN2VBj3N+frEZdYb3mh8UxT6B25v/g=
X-Gm-Gg: AR+sD121wV9g2huoRfHsTRPT1YOerll0vAETPAzcltXgzniiSZXRzfVoZQAykcCd8/q
 QoMON5AYNR48JLzmLp514xHrGjPho/WG7Iuos1zjjSxWjuy7l522/GMMfiXEiKrYDDQRH1Is0xF
 ZKIjE4J5wyCvZ4IeuuH+KeUWj4P1FPtqwILM9QCUyS0GoSXLoWjNy/HKFt3kOwgO6U+a4HGoyxi
 s8J+pY8iMi11Yl3KXZW98igKAhnLBsBqv696yGFJdZnDL6W0lbH94axTQDKhWBByvZp8N0+TCcW
 ctgqS5CZjfZyZ9RaUFydqzsY5jyaVQHjaJj01RNIG5pgzmRDc14MtrU8yWi7JMBXEyUY0nKgH76
 o4zuJU7TzoM7VmUbNyN2Qu6Is
X-Received: by 2002:a05:6102:3354:b0:74a:b1ee:e21b with SMTP id
 ada2fe7eead31-76f2afe54edmr1670695137.1.1786968064463; 
 Mon, 17 Aug 2026 05:01:04 -0700 (PDT)
X-Received: by 2002:a05:6102:3354:b0:74a:b1ee:e21b with SMTP id
 ada2fe7eead31-76f2afe54edmr1670628137.1.1786968063786; 
 Mon, 17 Aug 2026 05:01:03 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2185bc66bdsm12587866b.58.2026.08.17.05.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 05:01:03 -0700 (PDT)
Message-ID: <072b5f27-0f6e-438d-9097-40a5685cc4d4@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 14:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sm8750-qrd: Enable Adreno 830 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
 <20260809-pakala-gpu-v1-6-207ad1fac1c7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-pakala-gpu-v1-6-207ad1fac1c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ua9hjqSN c=1 sm=1 tr=0 ts=6a82f801 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: zz7gh7ix9-yf3ro_8ZerCuiUe9VZO1Qy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA5MCBTYWx0ZWRfXze+J0Sfcl2yh
 gheuQKM6NriF08f9Vmyan8beVvSX0ijpb361MkmSw8guEJKaFboSuXhiw7dxslKgGIsLb8tC29c
 UdyM7tLJofQGOgKI1pjCzmhHoxShY1/Sbr/B1Col/uuwzqLwaW92Nb6XpSth8hwWAJf57Ty3HzR
 8xTqFnKGJy3Q1TS+TkmYzLyav7Ut/B7ormbh8xOc4hzsiiVtkrjBvONP497R218Wmd3NwOUlsHL
 OMBKxB4qqFYq/fLQoPx7pBNihTcn0T6F5hNYgyXb1jqCc9Ug5z5QS3cvm0+QJM1we4iZjW3vX5q
 nWSVMzjH+y9GM0daTjiha8AFx1zQxnihWtIOHh+fkPCOWCyeSoYBTWHx6tPXROiu4b+KBAvM0rB
 Nh9iUxhrqYDzKXEY8r7zfaGO1Rt+9aNdvjShDSLI8UNpWzkxwEyv5ka3g9OwN3aBs5WUih0Vvdd
 aOl2MY5RTu7/1xQQa+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA5MCBTYWx0ZWRfXz7HvR8A6wYqa
 W981SmJiwnG83457sFQp5vumXbhPYJqyGHiw2sFcD5Ad1B1kjN9EFNM2g3QjpgtP1StjY9xF3AL
 25jUG1o/KwdiW3H5M+g1l4+uzyopjFQ=
X-Proofpoint-ORIG-GUID: zz7gh7ix9-yf3ro_8ZerCuiUe9VZO1Qy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170090
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

On 8/8/26 10:23 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Enable GPU for sm8750-qrd platform and provide path for zap
> shader.
> 
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
