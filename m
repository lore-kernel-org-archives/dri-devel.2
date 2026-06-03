Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279C5CD6E60
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 23:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B8BE112482;
	Wed,  3 Jun 2026 23:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OHI8Cmfy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f4qrhLc/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D45112481
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 23:08:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653L5muO1956497
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 23:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=03rptgprQ5ZgED7iO7IjtRFg
 pfYYqtbYZq3I8MdIhm8=; b=OHI8CmfynVWzzqxqL+5SSZMLwT0jlY38Fwr9GT35
 BuJqId4zl17zWmew6vwc4rVG6ZbUo8rMNlmNMOUsyNrpqC6DsV3q8b/6SaF1r5jF
 R3AImzs30KGY9dkdDnY3XNjsFlL2nxy98N+BIb2vOtRNC4YBzUj5CP3EVtHAul6/
 8RPh0EiC8DriiySDx/E6l7nuWB/z+ot4+jNJxXKzYhgODIX8ULfs4XsVKDjS+vb+
 rgQ+YOcOMeWd3/GS6+JZgWDuZp+bj0nyVYl+/mpnmhmUhXk4KCOAI0ngOVoUCbsa
 qMr5DIo+w+En1jPiAQ5ZO01Sg3YsqPIQ+8pWZpguO1mvbQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejfqc3sxs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 23:08:41 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-96396d1f745so136637241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 16:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780528121; x=1781132921;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=03rptgprQ5ZgED7iO7IjtRFgpfYYqtbYZq3I8MdIhm8=;
 b=f4qrhLc/CF6w0yV264ohh1GVid9iiiIwpbuFlymvVuWZV/fyNE589W5BOFBzB+J4+r
 LY6NjcoXTcSpPApwoFKs5XuzU1KG2UvG5ZPoHTXBrSkTq9Eu3qnbX6VeTixHkUDEVgQj
 +QHuYiZPX2hXHMP1mvqRj7GYKh2qR6SXmI6hintHLGjVPPA7OnZGrWE8wWg9MXnILn+8
 1PnF8Ry58sZqG0u/fPvXEwWO33m+5HPDefwl9xCNzwTWn3zqjumHvK/LY65pRPJJEsO1
 tEzelsICZ0YihdbgI+AiVqZUm7b91GmXjf6YU9YyeB/o5zfsAn1562gZxlJFFJ4l05CG
 McPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780528121; x=1781132921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03rptgprQ5ZgED7iO7IjtRFgpfYYqtbYZq3I8MdIhm8=;
 b=AUR0UJas00nY+9gU2h7m8GowSgtyQFwqfaJNGS1RrXie6SMaT0QajGayawoYgQ+5I3
 lHmUiwz3l+1jV9BgyAfEqwcaZNDlM2F9OcU9Z9CMp5/N/hknXdb2waDP1vAI2xJMj1j0
 1QTlCoGDSnKWA9VekgTf2YY5Nv6cAed7W1mO6h45blVRddnKlILTlHron/oz5IsM4acj
 kescCZ4Nw7LAX4NyJcte80GoxDDVb9rD7q3h3bBlwHf6XdZT7skyPX+TSiRpMuSy0g2U
 gw5GmOkkdlP/U/62aKMCngco5QjbSbyRCmFBpq4h9kaDqIS2J0sfiUmE6X2KbZS+Fdsl
 i2og==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DRxGkUFwutuxsdsmFYExNoTiyEUeLXwYqtA29eefTe9KWIydTjC4X7iHDEeJRfMBfjZuJoNStxmY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOUX956f0GDSx4MPQla8J+g+iFC1SAmq/h2jGnOEGUDaWUIr3L
 t/bYOrgnRjcGDAcSkSCbSIdEIMnAb1t5TGeP5aoF1ZIcI8tyruhwWSNDXWey3qCubGRNfL1NtyN
 dykKajWNDdi6+KPopihuw8z6iFqNQpUprvtGsnswIZ1tvDLmenSqBJbVXWc2Vv8GekB9a7pY=
X-Gm-Gg: Acq92OH8UvQUBhwsiKMHYTYmg7yIP8ElH+ClCyYVNvQuFMm3ydPhGK2DRcrHX7g/ly1
 bh/hgsC5bo9jcKEtSR40hga6tHk8CnHrtZOFWX9CXQ2rJ46elBtrJGGXg6wsRzxMcCkf9cWwcDT
 bxPClZYN3rYopu6muEwyn0Q0cMUzKjiLZ8ckE96LsZx8QQk82Oy/2sYCjPN8aJfG/mCT4UR9XRk
 BbWAzdIswUjGsuizzHOJ7unv8E02yNMTED7o4UGP4WoAH0GiDrGVe9dh+W90WE9gd9YsLbvWFus
 q9NxTiSCKhkngmpCKGX3mxG0XBaiQ8ad7uq6tCBfy50yzOyuo/ch+TbNQyn9OFmDYKC5fyO3lfp
 MoKgihUeaA4NzaWN/dZogBaJDN9FSGFz4PW30/IfxbqCj9ZmYIylmgKRE6Y6C5AwA3WxP8t4SNc
 UQITGJuONGJLFaTJo9MhoMn12uLdhGRt4nGZSxQKnqFZ6rKA==
X-Received: by 2002:a05:6102:6f0d:b0:6f0:3c5b:ce7a with SMTP id
 ada2fe7eead31-6f03c5be1bdmr2261994137.17.1780528120896; 
 Wed, 03 Jun 2026 16:08:40 -0700 (PDT)
X-Received: by 2002:a05:6102:6f0d:b0:6f0:3c5b:ce7a with SMTP id
 ada2fe7eead31-6f03c5be1bdmr2261971137.17.1780528120532; 
 Wed, 03 Jun 2026 16:08:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac07e243sm12553661fa.12.2026.06.03.16.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 16:08:39 -0700 (PDT)
Date: Thu, 4 Jun 2026 02:08:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
Message-ID: <4lozntipmx246uojyh5qso5kdplzyun4jzr6a6qdck7hfwoygh@tupqmauuswvg>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
 <20260603-shikra-display-v1-1-aeac1b94faa7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-shikra-display-v1-1-aeac1b94faa7@oss.qualcomm.com>
X-Proofpoint-GUID: 20mYRPrl8-RirQNabvYEXd4LBEg8RVAm
X-Proofpoint-ORIG-GUID: 20mYRPrl8-RirQNabvYEXd4LBEg8RVAm
X-Authority-Analysis: v=2.4 cv=e602j6p/ c=1 sm=1 tr=0 ts=6a20b3f9 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=irWgbQPqOsrm4l6MN8AA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyNiBTYWx0ZWRfX7Fv8WfPG9T4/
 Z0xRVS3LyAcLzvj4pOLQsbj9/pnTrgjeylqpHVCecAdqR0mJPAMT6c7aFMIbEPLUb4kge7XBuwQ
 ir7Ek1ZXKtA3GyNIc6MfGvNxSjqABa/9YfAIYVdsazToYUQWoIgmmXEuGOE+g5uF2m3SMWAhC1F
 WA9LNxnJNDZ63QeMeEeK39YF10hlIbVjHc99Zl9+90pL+Ai4B+YD4uKs73Zha/g+4SCnln+s+DK
 kKcf3OVQ9lW0UMJ2W56ebZVvEv4DO/kgBpHaD/fS69yreTE51gLdzs2DIIsagrvkqQzVu/qNLNk
 D+v2KKL7Ccgl6CZs28UFcES3reEqtsxEm5jDD4UbOLq45Eo6yuIgpDZ+3SWWg0D+BTWlW1XjeA/
 eNznq2MrSL2mGgN1fkgJnaw7qMJjaEmHFZ2FvQOSDmGiHSFFvqazQUHj+dRGLwPi2NUbrNTiZR1
 lOP+X643CKJhTnXitVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030226
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

On Wed, Jun 03, 2026 at 08:29:26PM +0530, Nabige Aala wrote:
> Shikra SoC uses the same MDSS/DPU/DSI hardware as QCM2290 (DPU 6.5),
> sharing the same register layout, DSI controller and 14nm DSI PHY.
> Add qcom,shikra-mdss to the qcm2290-mdss binding compatible enum
> rather than introducing a separate binding file.

Why are you introducing the sole compat string instead of using Agatti
one as a fallback?

> 
> Register qcom,shikra-dsi-ctrl in dsi-controller-main.yaml alongside
> qcom,qcm2290-dsi-ctrl, and update the qcm2290-mdss patternProperties
> to accept both SoC-specific DPU and DSI controller compatibles.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dsi-controller-main.yaml  |  1 +
>  .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  4 ++-
>  .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 34 +++++++++++++++++-----
>  3 files changed, 31 insertions(+), 8 deletions(-)
> 

-- 
With best wishes
Dmitry
