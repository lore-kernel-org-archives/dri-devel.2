Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ADCFF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B7A10E74C;
	Mon, 27 Apr 2026 13:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eafwYqJ7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YSRof1XK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D4410E749
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:17:17 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8TEks2913944
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zQ20hVfh6ChaIxk/xrbKz90SjTLBFn05mgb1/z9GS18=; b=eafwYqJ7X+N7+uxR
 HIqdnIywU9Y2UwhDLXF8PCr3AOiJXIfLy0uDSBMROxVHG0DnMbw4j764Pt9eOTbm
 JlQZnUAY1gkwk4wjkg5BSMxqwVm8+5L4gk0QENcKBpaLFvVATEqYqAh3ts8kp0Oj
 bXQupf3B6rIsQiqWWzYqPc4RSt9GtazgYXWZeUjkDEZDrLvW9GTkuklA2jLgHVWX
 gJxT+lmJJUiE0InATBCObRul3i2pR717KX853O6BVR6NoM1MhOx06svUHkChnSL7
 LltYM9YiRWxF9MtgyurJ8QbR005kJLcRHocip+GGcAilGK3sClsiBd//vE0opSoi
 MEK3TQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt26xhkx7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:17:16 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9568c79b893so603179241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777295836; x=1777900636;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zQ20hVfh6ChaIxk/xrbKz90SjTLBFn05mgb1/z9GS18=;
 b=YSRof1XKogDDybMfXgp7urtzyTxdc0TCzmw9GLZltk3O6+CSW0iiyeTtwCbC99GAzZ
 1BoCzl+4BGsjuWpiApUMh7FMb8FMs3slXijKGg+1RPflMrjJx/WZL3pxnWBFYkT4cltH
 WZ+EWR4ifH3BeXlpBuZ6BFeIDVsQ3nBxiUiZYQZtXs9pqj+W7dlMqeuKgp3gwBcvFDgK
 s3peFDqq1XKcBx9ft/qLIS810Xpuo++NFFsCT4Xocvl/zcYHkLtjUK6y5DIn/lnQm1mn
 z/L5M1ibXdhmkZ3Eys/cdCVMM8Q5uoG1PXUCCqunLJh2D8XYszWAMu4U/vIpaqnxiCVJ
 ZwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777295836; x=1777900636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zQ20hVfh6ChaIxk/xrbKz90SjTLBFn05mgb1/z9GS18=;
 b=BqAWW2PHTEpP0AZZDBg81x0wtKtse/2v8OJ/kUnAPv9Qqiqjx/W2KNYvQToJ/FXn0K
 5L19lcrvS9bzhAq4or5lDAicT/H2wiWFDDBzrkFYemV03G/NYn3p9O8WuY6wUTqCjyRQ
 nQnj10bFovjkZ5Vwe9nGg3R3+/Cd0l95NSj7X5e4yPtccKscK1jYgz+P7M2SezFZt4My
 9WmP50XyuLnVMJdE+MQkd4UISC8+dhRkpsndgkAVO4Q2FhNZ082tMo/FKVE3d41mnMKT
 IEqLSEM0NnsX33v/B2rvBpF/XnuGEK8k4vU7smAINZF4TYvTbPXzeXm+dDsAFSm/oIrV
 +gTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7v91+ZJW+T4B5e76DyktPffvSIkkPVBJP1s7anBPWvSWfeGplXKsUKceV0GO+e5Areh/1zjRqelk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkB7LPk165wqozxzJHRLVDabV9Q0MoiF/wKSM5pBvXkv9y6jVv
 K/YMVSjE4iPjHwvfp6GmHsS4KajW+cljSD5RMR8kJioSLxyL8pHzWxj99Gh8H1EWbocFiY3WNxF
 60oOyezT1LE/SCBncyRQThmGfC9Bpj9BDULJIcacRlI/vO5HIBZOu9ajFo5+bn6tqdPxe0VY=
X-Gm-Gg: AeBDievPSEqU4elVINuD7ijiBMlKX09xWf9UIQAsuVNzf+T5KwFT/roviuThemApi2g
 PIrshNnrEmBM6n4XzKuE+UjgNKc5U8PcQTi14pWPjNsesuBsA8ILkTiyBkXkw3p40/ZrajgRi0W
 dKRpS4h6xfNxHsiygFyE7I8ASTHCCIKCwfcmapVfDCgftwspmCsfSrnWarTz39vHo7IGqItedDH
 MfZzQIf87fGjDtrkNEFaL7SsIZOGb1+PyAWELigA/MCaGG64pcNbmUBPxjbqebnuymrMj1waypw
 kLPVWtTBAcW3ttY5URySY1cooyK2M5GNPNYu6MU9eK+SgXL/ZnvpZelOpHcvuUwYmmgGBOmJFhN
 5e6VT7wDcWGsOe5FMyVR9V9eNo2ZYD71NqAHio1DhhSL/Q2gfe5SY87TE6EYZR7svBZSPqi2utZ
 qnijC5tVwdaaCuwQ==
X-Received: by 2002:a05:6122:83c3:b0:56f:6edd:77ae with SMTP id
 71dfb90a1353d-56fa55ed7b5mr8965583e0c.0.1777295836242; 
 Mon, 27 Apr 2026 06:17:16 -0700 (PDT)
X-Received: by 2002:a05:6122:83c3:b0:56f:6edd:77ae with SMTP id
 71dfb90a1353d-56fa55ed7b5mr8965532e0c.0.1777295835721; 
 Mon, 27 Apr 2026 06:17:15 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-678974e23adsm3156526a12.13.2026.04.27.06.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 06:17:14 -0700 (PDT)
Message-ID: <4e454c14-92f2-4929-a058-3f128c901a00@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 15:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] drm/msm/a6xx: Limit GXPD votes to recovery in A8x
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
References: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
 <20260427-gfx-clk-fixes-v2-6-797e54b3d464@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260427-gfx-clk-fixes-v2-6-797e54b3d464@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oJv1kQCnlPiABuLKlkF8rWf8EkEX_82X
X-Proofpoint-ORIG-GUID: oJv1kQCnlPiABuLKlkF8rWf8EkEX_82X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0MSBTYWx0ZWRfX+n41M+Oa9p0F
 LVQyVISx3bDuZIFXoumGpniAr+r3fHJstEIT2Uoa9bXkxH65zAXNuy1xm5bR5LB7XRkrXe29Hpo
 Xnm+iFaf1IaMsDNcmPGypsya3JG3x1EIq+O3WdilAccI1imUU5+n+549iNeuxg+z1nDZt73F2Ys
 3jRlK3Oanaw3QgRof0/S93x99mABcGjaqx6XfbcjgwGHlpGm/OCnKL7RCORpwHkJNNWV4oO2V4m
 N/i6szaLeigTb/RnwO0ZSGdJZ2+a+atelzuU4i+PrF6esMLUsn4RAW1gmQUatIB2MdcK/SSoSt3
 0BC0oY5oyVPQIigVZ8G5OqwmjynN3T3FFPI7Oxvqp7hBoSsKE+JJgoV9okSMOKk2zAX6kAyAbGB
 k0if3sn/K4kG5vWIsVkeNM9g0gzhReCCj2Kn7D3BRRvkPBNnSI0wVumoZ4FDOpZEO+Rm9e5oq1j
 gmpOGfEL9IlvohJzSeg==
X-Authority-Analysis: v=2.4 cv=FM8rAeos c=1 sm=1 tr=0 ts=69ef61dd cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=eR-y9ft8gFT6PtJfczAA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270141
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

On 4/27/26 8:39 AM, Taniya Das wrote:
> From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> 
> In A8x GPUs, the GX GDSC is moved to a separate block called GXCLKCTL
> which is under the GX power domain. Due to the way the support for this
> block is implemented in its driver, pm_runtime votes result in a vote on
> GX/GMxC/MxC rails from the APPS RSC. This is against the Adreno
> architecture which require GMU to be the sole voter of these collapsible
> rails on behalf of GPU, except during the GPU/GMU recovery.
> 
> To align with this architectural requirement and to realize the power
> benefits of the IFPC feature, remove the GXPD votes during gmu resume
> and suspend. And during the recovery sequence, enable/disable the GXPD
> along with the 'synced_poweroff' genpd hint to force collapse this GDSC.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
