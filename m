Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E3FEDB7F6
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367B610E3E2;
	Tue,  7 Apr 2026 10:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nRY18Sgd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qr5mqKy1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAEFC10E3DE
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 10:56:57 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376TbI33537314
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 10:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6o+78GtA5SeBZnyBVOyCgJsy+RDbc81lZyqFwDAmIGg=; b=nRY18SgdId3HLTAp
 6dfTnPPIA8vS9qd20lg0qPf0MoGEqTj3EBuvAzrI4XnBYz0XjnG2eR1sV1FIwc2Y
 shE30s/qdRQDr53UN75hIpWzjRYQKtTgK14NwrLj5ZwdWOX6LnEQqGOb6Q30rpzB
 qlplYezgSZ/EmrPoTNw94a7NSeLydHn0FhjezIpokQQEjtUiLVo9xv1v3PRVUG2i
 izA4KUUVswDIQgQa1EbQ7nhf5yD1wN7lemQ0Vq85kwxnXCH9QrbfL21k41zqadn4
 uYD8jjqQoWPZDnCCWLBqI/BoYfO6o0Y1b0jZiU7jVBaURJOSIfWkGT35xeqz6wUs
 eTra3A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra2cww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 10:56:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d8c183c2eso18655391cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775559416; x=1776164216;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6o+78GtA5SeBZnyBVOyCgJsy+RDbc81lZyqFwDAmIGg=;
 b=Qr5mqKy1NAeTbHkdCpE26f1bWGoCqUFQNkdrPoCxJPWLZeNzUbYEsp9TMK1vkYPLx8
 Fvd5bBVPcWcAi6OREoK4g63HobvUi94N+AWha4GuZB3RfJdta2SJCQRb2L7eAjBXc7u1
 5iUhh4X/BdfSD4XBVy0ro0P5drkSODRB1LXF2RwCcm18iZ0TgVGL27wPibQC/mWv56qp
 uG0C/VO21n/FuH6SC/T7xBmD9xsAWVDrpynFGYhplGDdG516tGspZAJUllG2AXH9tqlz
 R1qg1RWsCEyFDbAgLpgG7BDLPf+aWYOIn9uuqrockEdFhrikeW1Af57kGkI3UGHOk02A
 9OhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775559416; x=1776164216;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6o+78GtA5SeBZnyBVOyCgJsy+RDbc81lZyqFwDAmIGg=;
 b=keQEXtR/aV5fMrG1viU7lfHh40qglVmqlKFGnu99eQ57iB8c4uO/djIcmBH+wyMUCz
 vIp9ZRLNnUedI/hnZ9YRYKbORg1U6+9qeztH6Pl7cK/E+6Ad7URv8cK3JSmnAqQrkPvN
 HgzK3prmHW0qz3C0kWwLwPCMn1GVjgVdzcilY+1BIJWem/oan1X/7L6ZkatDVPwGlKFr
 V45H38Vfsm2/YdvVvV3MF7N8gUeiqg60Ndwt6AyLNBhuHuaEXVWP8oYOCs810152wZCU
 I/3VWS0y8Bkp8zLxjaU7WBszuEBhA4fMYK9PORV+NkDig0ixIr48HvbPe+cM5EGasWI+
 +Miw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4twslJhABR14DYqG8c4L4jn/ShLm7OqqJFA41qT5S/rouePm18hbrCAxcSvg2o5T0QRkSWL+yW60=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqpxkS2Us+3hOCPJ1xB+SK8kG2+OF7GhJRIm6nqeRJB0j6l+xU
 eezCCnTXkfeCOJnyM8c7kjIOVs9JvCP7ERG/VoLVa6lYsPvz/e4YR1VLMY4yYC20/38uwBwFunb
 2YPRazwXuMzQfvpwi1pe87OZmy3ZkSzswr51HpMqoIg8O3F6Oh/oFNFV1UAzvWas5ULvI4Mk=
X-Gm-Gg: AeBDieufGlCDJYSaHjChtca8et1lgf368hUWyZ3ANKgx22o7aKQPhDyY2uYMWksFVM/
 EJap4eVg8dSQE6kSwZ5bYLn/3RNKZqx3zxsL884BU+ASr9n/83oM42jH3Av1lw95LV017AGbsy2
 Hj5tbTf/Kq/oj6l7sWhcIYUQVGQUKuT9nUZQxpPdSU6bBh67BiI/RIXuu9zn9CUc56AHoJhGG/E
 i62v2Yo57AkxB57cNZOupk7g9pYwoxXSUshKQ32R1vESPQGHhnTJVVolHK1aMNS38KLaLdJWNy3
 8V2A7ZuQyeULorNdaBViBOPLexHv2ryieA+3ZEgPjhhbM6dZGGzJSTS8uj+L0Wzop/E0HpVkZoC
 z3OdTu7mtYh21qddernjS0p4gkPMxrW6t2wVWTUCzWrc+wKe++7thWm7/lFsoDt8+2XbrGLQZPU
 HX3wQ=
X-Received: by 2002:ac8:584c:0:b0:509:2b5a:808 with SMTP id
 d75a77b69052e-50d62af94f2mr177225891cf.2.1775559416048; 
 Tue, 07 Apr 2026 03:56:56 -0700 (PDT)
X-Received: by 2002:ac8:584c:0:b0:509:2b5a:808 with SMTP id
 d75a77b69052e-50d62af94f2mr177225461cf.2.1775559415594; 
 Tue, 07 Apr 2026 03:56:55 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3cff1c3dsm540271466b.49.2026.04.07.03.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 03:56:54 -0700 (PDT)
Message-ID: <22afd2ae-c5ef-421c-9a9c-dc1073aaaff4@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 12:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] clk: qcom: gxclkctl: Use custom disable callback for
 gx_gdsc
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
 freedreno@lists.freedesktop.org, Pengyu Luo <mitltlatltl@gmail.com>,
 Alexander Koskovich <akoskovich@pm.me>
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
 <20260407-gfx-clk-fixes-v1-2-4bb5583a5054@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260407-gfx-clk-fixes-v1-2-4bb5583a5054@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0CGgyKYtm953YyIwh2GqbI3Q2WoDpcYs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwMiBTYWx0ZWRfXy2zKdM3HduhX
 JPaUlNcO0WiT7R7ZsHa+r2IbiVq5pN5XWXR4+La0RvE/8RK7ssH5LsI6/QO7IB2HUP5Q78DjGgI
 bIZDARTe0PnLdSiykb9rFGDE+Qhz7wzyUXnvNmMxeJ8gs5n72jboHnLL1un4dGleNiYRNiFbfLA
 knW433KEVKNDl3FR8vXrImL8td9WLvDa5tNbmIQNeCWHSmZUdHFZyfoWupSvMx4TNG+y/XZq7uU
 4dW+IgRZoPqw4COmejBsNxePXI2BnKHb6YBiIuYhZwvUI1jx3vhYwSV3xlw5mGQZEXHsq0hfnLl
 tpiv41i4EMSjdpTarggaHqcQJEMmSXI7nO/wBgNPG590qN1cK+aCeNMiDlRiRxBOyVJ49OJtWi+
 dzHqfktEsKDTW9NTZddeQvnuHd/rQ0z+Hu3nQnXhw0kVZ8P7ix9PaCZlAaurEO9ty2aobOk5xVU
 x5zvI6YJPRza54YuWww==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d4e2f9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4w9pqFYAhlswuzcMsVcA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 0CGgyKYtm953YyIwh2GqbI3Q2WoDpcYs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
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
> The GX GDSC represents a special GPU power domain that must not be
> disabled during normal runtime PM flows. As per the GMU architecture,
> GX GDSC should only be force-disabled during GMU/GPU recovery, where the
> OS explicitly resets the GX power domain.
> 
> However, when managed by the generic GDSC runtime PM path, GX GDSC may be
> disabled during GMU runtime suspend, resulting in warnings such as:
> 
>   gx_clkctl_gx_gdsc status stuck at 'on'
> 
> and failures in gdsc_toggle_logic() during rpm suspend.
> 
> Use the newly added custom disable callback for gx_gdsc to ensure the
> GDSC is toggled only in recovery scenarios, while preventing unintended
> disable attempts during normal GMU runtime PM operations.
> 
> Reported-by: Pengyu Luo <mitltlatltl@gmail.com>
> Closes: https://lore.kernel.org/all/CAH2e8h4Vp9fJYAUUbOmoHSKB25wakPBvmpwa62BTRqgRQbMWuw@mail.gmail.com/
> Reported-by: Alexander Koskovich <akoskovich@pm.me>
> Closes: https://lore.kernel.org/all/gwVAH2mJerU4dBInw8pKmOs5aQK55Q7W6q_UQAlLFCsEgX6eyvSgXAWbNNMqAX4WmPlYCKUSMhfkr5Jry4Ps5EqnxYZqEEDd3Whwv7ZXGlc=@pm.me/
> Fixes: 5af11acae660 ("clk: qcom: Add a driver for SM8750 GPU clocks")
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
