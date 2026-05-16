Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A845CD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 15:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E4CA10E4BE;
	Sat, 16 May 2026 15:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Usf4EMwG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NX7vfQVw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D21210E4BD
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:23 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64GF2KXr1254481
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LRYRE7MmsWLhtA5XL0Zaq4CcIUGaTOA18JqmZtzcf4k=; b=Usf4EMwG7057hmYI
 Ph/izuCPLTMwNIksn7gwAZvjdDO6U9ppAk8udBtX2D3bdWeqgOFZM+KMwW5UabN/
 n6UxX3D7ottD6Q0UD5y4nlVFtqr6Uz/HFO0cV0nJsiVUJ0oOB2QcgG3OMcNwEygO
 YlUKhGi+jmU0hi9MORN+z5woL61t2rHbwiOw5Wsvt4//8YaRtRl2dOtFEcnR0NFG
 sZURjIjXm944en4Nc+nbYEsHdeofJFWtFLejuf06BhXAdKcTiTXYRaPmbX+uPBKL
 8Mj8KBq34NKYNhq7kioiFWA5Ki0nHgErJh0CIq+8/cELphFhp991kXIjhhunku0i
 8mmYKw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6tvcg159-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d6bf346adso23077691cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778945122; x=1779549922;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRYRE7MmsWLhtA5XL0Zaq4CcIUGaTOA18JqmZtzcf4k=;
 b=NX7vfQVwmV3IC/tLjnAZhTiqxU8RCrrA4GigAr0YkoD+s3cNzqH1bvSWCK0To5Qvr+
 SBm8FDERmobOS//0+/NkWonJyOcTwHAXARzaz9LYIyOVeUrg4FtSJrvfTWz7yzO+kZEz
 dYuQk7Yf86z3ZbLIjvrrqsU6H4Ogxonz3A4gRgKovGkSb2pQ8KLu+XVr1EYCA8KN4hKC
 3kpr3yH7aB6/Sa3MDmWhWQRbB42/13mBdNynmDKOwM+K6OyFnG/Al5ARNl6zFYNpBQZi
 2vKOkNUwykR6Uknp3brWaBjpbwS3lCK3pBuZWFuIzboCdCAICaJto80gH3sI+myCeysE
 5qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778945122; x=1779549922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LRYRE7MmsWLhtA5XL0Zaq4CcIUGaTOA18JqmZtzcf4k=;
 b=qZHx47NffWPIlCcW4GRdnzlGYxivsmXCY07h5KKGYkWyjObUXdS4R5xVf6aP9ISRgH
 bB1sXBtoOoqp+oRv+0z6fPXKjFCUbEAR3/aJk05MCeNU62eGG3HhwwvURdTIkV0jn5Q+
 4lkdbCRCGYVKOI5/dpbO+2Rok5dIhIvBQqe0PpEeVy5DlGC7RSGXq7khed8V99r3XJw1
 L6PMQ7wmpwHWKosQqy/kXYV2AdJWvo5RlGBekN3I8SBt/3lJSfxO8i1/Bv2JkuMaz6/m
 Smz9Wyg6e4kUcEDOqYp0nPn1flucOg8pVz8az0sbk69S3MdR08GQ/sZRlcHNQRFcApEs
 5DEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qwDf8LL2hAf8oTOTWZgF0mVnZk4AmWSf/WxEUgmkAcL8fGYOx1HhK2J0hg50FPzVYqPHTzN7M8PM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw36OxGbhjhfIP1lsLvd5TaWjcxZAefFTHdYSIAgYYORyLJAz+n
 gAY3jF+ZiUPxYsw6jj2CjbmHSAtaei0sXdLNy8mJcD6ilRZxKnJQlcUhIAz617B9xElojsNdHQc
 F0OFi+DTYpbzqdy12ElKY9yqkO5mSC9zqkLdAQpxc2exfthHAv/KxftkLwV/CNWTG4ikzsrQ=
X-Gm-Gg: Acq92OHk0nDdYRvsK2fssD9s9N3DDipwqGDl2wsJK1ehtmxsVoBtJT23k3upq3fKJ/x
 sEETNSjlrOfNFVP0HO+BvByFofoQXae+Vt6PDIUG05Oy3/uh5CYIi7WMsDkbpcDpTdMYI3vWkzG
 o2Ypr2TSIff/4d1a3ZNPomoA0F6o6vyo0VNer668plnGn+Z79LtBAQ8/ALzBwBRTzRJKF3blpvs
 MTJkUxY+7IKanHMWkcBg58A30ty0TIIqf6STItmgLwaOhdtAyTLJjgwkupxvngjLv7IIaRM2a0p
 yHyvmY57GaeDQ89089j++SLaqykfyYjIS7whq7SrazeWMDDgxbXFwo7wppGGs4xAAvKL9P0ZRnu
 qdCB7pzbAyykppZnxsofPdnhU6EZSBQeHEP6cd0V5Ae2HTZa5OBDjX1pP0IQZuvz7kNQvEPxwfR
 /+ed4kB1yyICmo11qxRYdzoAWnw9OO02C3LbE=
X-Received: by 2002:ac8:5c92:0:b0:50f:783d:8cb1 with SMTP id
 d75a77b69052e-5165a29619bmr129086861cf.58.1778945121739; 
 Sat, 16 May 2026 08:25:21 -0700 (PDT)
X-Received: by 2002:ac8:5c92:0:b0:50f:783d:8cb1 with SMTP id
 d75a77b69052e-5165a29619bmr129086171cf.58.1778945121210; 
 Sat, 16 May 2026 08:25:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164cd939sm2057972e87.70.2026.05.16.08.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 08:25:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 0/8] qcom: display / dts: Few corrections of address
 spaces.
Date: Sat, 16 May 2026 18:25:15 +0300
Message-ID: <177894506983.2448625.13587872132931108802.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
References: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5lizgrx6FHWst9WIGParTHcvHmmXfRap
X-Authority-Analysis: v=2.4 cv=UIDt2ify c=1 sm=1 tr=0 ts=6a088c62 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8 a=n4T_STkPxQ6NuhZPjVgA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 5lizgrx6FHWst9WIGParTHcvHmmXfRap
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE1MiBTYWx0ZWRfX6txcTXhXV+Mi
 bvSIpc8VajMUxxwCaB3BZGc88AYlfIAjAeEBrCjXMWVVbvVkZfIeaZB62+hr9tMZeGAo5zF/BWN
 qIGUGFGBu1RlND6pwdyVGGDpD5SzOGyV5RlCPhJSKTG2qzuL8N3F3mlMgDy7DrJP7e7QjuT4nqw
 1S/6tLTAiGYGHytTaL3RAUIPjDBsKzVgutXXfHzNLcmao9/8F0jj70JTjfJkfww8t+hvx/Ljwyr
 YB0RSnEer2zb79+leavIaFnFmRa92HfzBdYHnsFwyRaMnL4750l8Z6a4mv0qSt+q4eftDOgS8SI
 6tLIaSiWN+3yQ1TRikBK5pNFH52BEyV6jDDiVNcePvPQc4AhMcmsZRUGf2EuMNPjNhkaXwkXCis
 OMaj1cZq4rdqAWM/y8exUOKnhcdV5m/ErAJ4FGDNNM+OhbGEjW8aMxu/F46KeRduJxo8I/M8HQD
 i+p7kwTHvME3z23yHUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605160152
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

On Sun, 05 Apr 2026 16:33:56 +0200, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Patch #2: Add dai-common.yaml reference (Dmitry)
> - Correct subject
> - Rb tags
> - Re-order Eliza bindings patch
> - Link to v1: https://patch.msgid.link/20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com
> 
> [...]

Applied to msm-fixes, thanks!

[1/8] dt-bindings: display/msm: dp-controller: Correct SM8650 IO range
      https://gitlab.freedesktop.org/lumag/msm/-/commit/cb6f19552b49
[2/8] dt-bindings: display/msm: dp-controller: Allow DAI on SM8650 and others
      https://gitlab.freedesktop.org/lumag/msm/-/commit/557226acef41
[3/8] dt-bindings: display/msm: sm8650: Correct VBIF range in example
      https://gitlab.freedesktop.org/lumag/msm/-/commit/bef8a15a6ee2
[4/8] dt-bindings: display/msm: sm8750-mdss: Correct DPU and DP ranges in example
      https://gitlab.freedesktop.org/lumag/msm/-/commit/399f7748789c
[5/8] dt-bindings: display/msm: qcom,eliza-mdss: Correct DPU and DP ranges in example
      https://gitlab.freedesktop.org/lumag/msm/-/commit/795b19cbcf43

Best regards,
-- 
With best wishes
Dmitry


