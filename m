Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB0EFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC8610E746;
	Mon, 27 Apr 2026 13:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ocBGaHMS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VAiAbmrr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C975310E746
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:14:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RB7ZDi1238182
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6oTwfVDw7QNHQ4l4Eu3rLR/gbCz9lqfqUZ3HQYe/v6Y=; b=ocBGaHMS/3/QPLyg
 oEGnWfC5Vui0NY8YtJukeSHGWm0KRUnVp3x295q+rRZghnSznYG0larhcV1/9WBL
 phs1q9fhY3Clwg9rbpXXNnQSTGCc2hmzNUhTXtc2bwnJkTlR8zmrIngMSrieNMz3
 L88M1/nRcwpF6UtIRKGMM0R3t1fwfXg1uNLmjviuoSqKh5A2F5k1aj/0DIALGEdY
 Dp7WpzraIj77ecGonTKp9/kZk5cGPuaJ00vWZ/4WSckWBrljPKsJUQikMlZG8hTF
 VlV/4N1/r7nZOQtqbnD9gR/EWNcRqkiJXOF+ANQnbzfthr3SGaUrYfSwsfGA+Rzp
 DqVklw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt6n4gdm7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:14:35 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-605a884731dso626917137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777295675; x=1777900475;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6oTwfVDw7QNHQ4l4Eu3rLR/gbCz9lqfqUZ3HQYe/v6Y=;
 b=VAiAbmrrby0nBJjOY5Xaf/cKMN3Ew0o5VtorO96nbvu1guy8EgEnILdi0WwIL425BF
 pWiQYyMtqjWSFxIB/LUBPeyjM3VNHeRr3uqurlqrwgi9OkGR8CFtrZIcKH7Sod2rap/2
 P3ycW2uGIVjxFoK/nrhoq3Ef1YaqH+ECUJUEJBi6gW781yIrbIODHkqygubpmVY5jgfM
 S1uVAaHqf8f30G6w2hf0V4h2dQ5GJnFv3IpCmTQfqpnF2dDMbwVllfH1RCtU4nT5oyYQ
 k/xYUKg9e2apzG8tQTPXwn2bd2lV3tEjADcie8UMvuq40WlSN9UmKI2nmqC+A8lD/lC4
 2mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777295675; x=1777900475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6oTwfVDw7QNHQ4l4Eu3rLR/gbCz9lqfqUZ3HQYe/v6Y=;
 b=mz2ZRz+jUPupj+cS1+90k+ikf9/+JyNiU7/ed1xNeQY/HFt+g1VZd7CJXb7+nfk6mz
 FFhIBB9SbkBFtfh+u3s9Ao4TiRQuEBtIGpEZViQlP7R3fTWlaBvB8V6egFOEX2s4oEhz
 4u2Yb0Ivb94K/UNMQJojG+xucJgbKu/ML76ahj/bONnMK6XPTpzf6P6ajWvvF/fahzkn
 vv3wIjZV5qSJ2ilhpOPPFq7PBJIMN7un0GAtgJ2zmSnZhzSr3/KMM3WgMmLMfRfj1z5z
 Y7LM657Bsv2jri1mj5wrpBvqwWM6HTpUCSAIb2curgglshJPHbvLMnc0C0bywuY8n2sQ
 q5zQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wxHaIuUeR7wkWDBjnNB8yATseRGMBMpXpmTPugZSrE/YY6ET+ZhsLPEQS8oGD9fMF7gm8USGeJbw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRUyMrlzSsE3OwvHt8fEOF+R0PzWhw8Bt9nNOMsgBqZGwUAPdL
 Z8t9izDgulkzExy1rwRCf/fi9nqG4Qhohr3HuIf87QY6RWmpAM49Y8l3B73ZtHeiCxAhjytWQOn
 V7B5+rqGJam52Syv3/QqydR/VuAE3CndnNjhe6SsEXRCOv9OlxwiijBw9Z/6VsBPEkyWIcrY=
X-Gm-Gg: AeBDievWwp0vMfp6Wwa/u+Vp3QxP63rzepGCwjqw6F2NoMx1RdySoA/4+ITyPi4YSqn
 jgE7dH9M31JE/wH+mQOB9JnIWzanL6kmTHA4xbBHUrUf1E/s8NGiVmIBM7cOUD1/JwJWO0KXEC7
 +2Llu+NFefoJ3HCa7GTmPkIODkT0CEz4mrHpd3bxhZLEwyp4kXEcVktA7lLDq4zdmluH3dHM5bj
 Q3w5zMEE6qRSPYxtyHD/N/Dj2jo3bRP12zYg/nLIu61JCgLoYlVHwL1oy/PJ/63F2U9c+krpDV2
 QQ21KSj3Q3NFqB+oOh/1Y8LV65bCkc8Cyv8EZlYWA3qCCXfwyy51UBHOY9CxfbJZ0gomKPp+eXB
 7cmfUh13kzbwexAhAZGaTb01+BR/qZGs2uexqp5lsa03nwEfJVUf/YeI3J9itu1u/xi9E2w/W/S
 8FuNnokaZJjT/+9Q==
X-Received: by 2002:a05:6102:5c2:b0:612:13af:f5de with SMTP id
 ada2fe7eead31-616f6ef8614mr6569921137.3.1777295675209; 
 Mon, 27 Apr 2026 06:14:35 -0700 (PDT)
X-Received: by 2002:a05:6102:5c2:b0:612:13af:f5de with SMTP id
 ada2fe7eead31-616f6ef8614mr6569906137.3.1777295674654; 
 Mon, 27 Apr 2026 06:14:34 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-672c4d69708sm7043728a12.28.2026.04.27.06.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 06:14:33 -0700 (PDT)
Message-ID: <0314b78c-cd96-473e-aad8-6977b47cf1f0@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 15:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] clk: qcom: gxclkctl: Remove GX/GMxC rail votes to
 align with IFPC
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
 <20260427-gfx-clk-fixes-v2-4-797e54b3d464@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260427-gfx-clk-fixes-v2-4-797e54b3d464@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YVJNkao8pdlDbz8YXiBHD7WVCsCGlnFt
X-Authority-Analysis: v=2.4 cv=Xba5Co55 c=1 sm=1 tr=0 ts=69ef613b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=IGZpXzwkV2I0bIdW4VsA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: YVJNkao8pdlDbz8YXiBHD7WVCsCGlnFt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0MCBTYWx0ZWRfX4PZBFkmp5AmM
 4JtXqzLAHaF9k+SGELr0gIb1rKcylfGzNQx3y0ueP8Vd1vZGsa36uCJlwJ6jGtcLCn/cSczakUi
 jO6b3AaTyCWPPtm87mS2I9hRb4SyZHmWoOWKX7Ybtd2JfV6wPVrJbbmRMIoJr5Z8SwSNe+916b1
 Wo1f0jPEMXI82womD1AeCvaSgVYGYgg1wUEzKqH2gPv+okW6mmS5OX9fptxWto/cUNaPYc1OfnF
 PYg//nZ9q2rC7HEXGTdLMi8/9FyJMRXiLH8YtFC1Ducv3u6NixkVuHLjDdLPGQqqOl86dQkPwcw
 YDYOEtujCwdhxrMQ0xjgRyy53fstAFtRQK4zHYq1xnPkk4R6LxEnySvxT71P+smPrI7RG+BM0bb
 B1QghV9NIWjLG/pl1a25YuuBcmthL/PzQ55h9OZTZ+kf3zUbUWa7eDxxTpRqDu5ID6NWKNvNr0W
 7mXXko+7Pli0mSG62Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270140
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

On 4/27/26 8:38 AM, Taniya Das wrote:
> The GX GDSC control is handled through a dedicated clock controller,
> and the enable/disable sequencing depends on correct rail voting.
> The driver votes for the GX/GMxC rails and CX GDSC before toggling
> the GX GDSC. Currently, during GMU runtime PM resume, rails remain
> enabled due to upstream votes propagated via RPM-enabled devlinks
> and explicit pm_runtime votes on GX GDSC.
> 
> This is not an expected behaviour of IFPC(Inter Frame Power Collapse)
> requirements of GPU as GMU firmware is expected to control these rails,
> except during the GPU/GMU recovery via the OS and that is where the GX
> GDSC should be voting for the rails (GX/GMxC and CX GDSC) before
> toggling the GX GDSC.
> 
> Thus, disable runtime PM after successfully registering the clock
> controller.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
