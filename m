Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD98EDB7FC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D946010E3E7;
	Tue,  7 Apr 2026 10:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DuNfqLdL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B8QokTCj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF4210E3E7
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 10:58:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376hNUj2580434
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 10:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sCqoU7bXs+Nx06yOgLyROTLNdQZVS+xm+B7KV7N4LaA=; b=DuNfqLdLPfpY9fuI
 IaW6JM0lfNzRIBGXtDbl3ClI8f8VPe1vhrEd48ub2yIQzfE1zpySKJDUaZDe8vJ4
 v3X04CVzc5/ch07d5Ztp4tyGgN+o6UABKXDkjI+akYJgAAlIhRj7LSJcQ7BKbQUy
 sf9O1gz+ODmSWi2eT26hub6Jjm03lR/iyiuAFXk829LWp9LCd7r4PUO5WxexCqQq
 gacStpQSt3lN9C0pF6geRBqWwH4SaiId+LZetqf0gNc7sYrTKaWr1VpzPCMkOKKb
 RgnuUaKY6NskRp4tNpqEVYe5oEsl7ozZoRCDp9v5mNXkr+s1xrKRkeZovCFrtkHf
 gUqnmQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmsf2d7m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 10:58:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b9074bd42so15800131cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 03:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775559530; x=1776164330;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sCqoU7bXs+Nx06yOgLyROTLNdQZVS+xm+B7KV7N4LaA=;
 b=B8QokTCjfTM2oGL4rK4RLitN/rrmMzHJ34pWdOsa0K694juOjg5yVpI92l9PPVvedz
 U6nwAcxxpb2XwUhE7yIf/4bPb6zHhekqAWzoLJDtEYEenK9sggCs33vlYLFYpHBP1uw8
 HpLQ5/xibHpWD1pHL6dwGSx6+OqJFjuskuvmF2Iy0skb2YU67zOw9fs2b0iS+loNF4LZ
 tDv5xjIYuE0px5OuxSS/lMHLM+9EbVq/wGOD2GQNekqBQnfwi6olVGeb1WbCMLM11bEE
 bb8w8SJPpwzZ9Trtf3uymWZ4R95GAuvQcLbebLNLpucgkt1mZzBDXNYha/W9gufkxZdx
 HVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775559530; x=1776164330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sCqoU7bXs+Nx06yOgLyROTLNdQZVS+xm+B7KV7N4LaA=;
 b=ottntrWrTpoimJMYEv8KJlbqoT0a+bqJr3HndY//UTg6bvBtZRKD/nZPEyYeUGr7Vx
 haLc98iO+I0lICwPcqr8wm7M4qHa3fIfZ200n4R/0uHK/c87hTyYdsRy6T0jvBiPUWJs
 7ZuzSE3Z8Qjw817ChFwqhSZVPmGR19fK64uulp+O+6lTtFPQ1y2EER9uh1fo1oQDPM6Q
 CpuhvboyXInoUF2s4bDV/D42jWSrkyeCmd8ZN4+3xTX7uwo2FBj+p7yfclarCgCpqON4
 14nsbX0S2qz4320DtE11KZ0oL5SkH9n5uTfX4RluszCnF2mc8/QmQkckcgdrVJwDlMFv
 fWag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnmGVlbUITwJSCiW2Aedy2+nbCtgH8stqcdJYxw3sT3qF1MtmGt2kT42Sdv4KFGsjtXNhJAhKLkDI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJKnx3cHj1mZkWVOp8xbIDT7JwXWb8JKd2vMBd4NrcNiWYyh2b
 NGeSkCsMkcSMP7ei1vEqSYIUspcRW7NZF0kb8GFC4qBi58tPOYTnfu9zp5sh5mVVQMVS9xC0DUf
 7UJKZX3iWEZSxjnEcOvTJGc82jD9MR3emhdf5UcComdLtQnZ7dLVMm1/KOrn6c2QZ3kyiHgg=
X-Gm-Gg: AeBDietKT1o4/ghnqjyRqEmQkeY3X0HnFqXRhfkGpzrihykCIc3KZS88dvgZuKhDYJF
 eDIKEEZfKhC7CWv11AF/usp8KONwzBSsv11C3rgsu0wVC6BQuOP5RlVx5nHPXl0i+BVqRPMU5/b
 kHw47qD4jJBcw1r3nDB6e6l4CgviiJ5eu9tlMPyUGBpop/LIW3R7vASQhOKVmbYqTCYhL4vdYSk
 63muz1kb9L3DyMmAF99es0gIfiY9Xr5fApUHhKYWP3x03soeoykGwAa2GM9izgv3c1EWKNB50Vg
 26noqLWtjZnPbMsBxajPs5AgMm9d1qiteXFewZKA0xjZSUJf1tMiHN/gm8n+Qpik0o9VWiwGBaW
 0a+hTglUrYYXCdOdVultPtSMtfIVV1Ta3/hGXIqpza/QmVkWa2IfifFJKHICF9y3Xou/bIsCG1B
 dJ1lk=
X-Received: by 2002:a05:622a:2b06:b0:50b:6b21:2a7f with SMTP id
 d75a77b69052e-50d62b13243mr181987051cf.2.1775559529867; 
 Tue, 07 Apr 2026 03:58:49 -0700 (PDT)
X-Received: by 2002:a05:622a:2b06:b0:50b:6b21:2a7f with SMTP id
 d75a77b69052e-50d62b13243mr181986691cf.2.1775559529370; 
 Tue, 07 Apr 2026 03:58:49 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3cec58f1sm552059566b.33.2026.04.07.03.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 03:58:48 -0700 (PDT)
Message-ID: <c72e02c7-57d8-4353-a6d8-9dbf4f7a7e37@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 12:58:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] clk: qcom: common: ensure runtime PM suspend
 completes on probe
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
 <20260407-gfx-clk-fixes-v1-3-4bb5583a5054@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260407-gfx-clk-fixes-v1-3-4bb5583a5054@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwMiBTYWx0ZWRfX8KkdzyJhSDNj
 N8w8EbZ7jrt+nuRiOkBh/BnwjaZAML/sBl2aDe50tfzajya4u4+nlwfuQiC3fefS2mo6UyJ34hx
 Uaui+htbVRW+bi1PPT9cd6MH5sXT+YuXOZpQwv+Q0Mn+7HoRPnNb7kAvRu8cx40kVwy1vY5DhQV
 Gb008pdvlMG63wrbIxu1w0K13LJ4ZzHrzfF6ncWraEH/AWB2Y2f0q4oMwfV9m45e4PMAAsaqm71
 k2iLgoJsew2rCd7PtkDA1YDk+7khb20kZ0XUlt+iFdp+7qRX3xxAWtaibepiKqL46cmQiU24pcA
 j2eGdiCQQMjSGXMV4RsVAbKePxOo9FLPpZLZAks6veUBFKIXu5DqumcyYqJZFlmOhZ2ijxprUMV
 XUnUguoS6PQjBtk9hOa5iaTTJM8yZsqdeBI+58UU1933Wxjzs3Z6N/mIbblWjEKCeiYjSetyjNG
 xGrPfFzAUZvISJ0T32Q==
X-Proofpoint-ORIG-GUID: OUA2AoUJhNeWRz9i0ZZ_LCt_p8RTOMVc
X-Proofpoint-GUID: OUA2AoUJhNeWRz9i0ZZ_LCt_p8RTOMVc
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=69d4e36a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=B7wDQo7gvYI_MMBIZEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070102
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
> When the clock controller is probed with 'use_rpm' enabled, the
> runtime PM reference is currently released using pm_runtime_put(),
> which may return before the runtime suspend has completed. This
> can leave the power domain transition in progress while the probe
> path continues or returns.
> 
> Use pm_runtime_put_sync() instead to ensure the runtime PM “put”
> completes synchronously during probe, guaranteeing the device is
> fully runtime‑suspended before returning.

It's not immediately obvious why that's an issue, is there an
observable problem when the transition doesn't complete in time?

Konrad
