Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A1AFA1FEB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F6410EA62;
	Wed, 22 Apr 2026 19:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UEkReE3c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TkoZdMtj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7267710EA62
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:35:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MG4kBb1587779
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O8xV/e4E7hprQ04fsi19fLI2fVcl7PPwdDGjlz7kw5c=; b=UEkReE3c1W8A9wPk
 QXEiIfIKai9HlqHiNmz4bkp+n+SL7wUmHTQ2s0aMJL3o/Xk8+eboWhSKUXrYT2AB
 UbwgAiLlbb5z0S47TcbW4IpbhjsW6Za4//RL7I5GrpAVBs6IvsKKoP8NFwpkFCQi
 WJAsUeQHoLEPnWHPEpv/Vu0Eme8PQnZ1C9XMvdR6BzuUgVR29/Ypan1zmOkIgdnL
 5f5dhWOKvL20qlSidh2I5ELRQR76A2tvlagQzqxhvLN2Y9QOrth+aG2oQVSB2N9j
 /FuoYSD73/NRnBlHDOuSnkeISzGACBRiwd4CL3AAEBJ0yqNbeZ6k2+B59ZIkjKAc
 GkVY/g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1hq0r41-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:35:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d8dac6233so96921311cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776886555; x=1777491355;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8xV/e4E7hprQ04fsi19fLI2fVcl7PPwdDGjlz7kw5c=;
 b=TkoZdMtjlD7+k6B93Tt0OYk4me7AwABSCaZTEYhWbyXVutnhMERGa+ZJBHfOMQFp6Y
 62vgQKa748+IDophEF3GVhc+vjgVRFghTvuqYlPqRFIa1rmE2igEAkmRoBWESGkCCt+l
 ahkRn64rc6MCeT3tfgAoHyDGLd4JmVM7tNfiJoB+erNBNGyJ4d2WM47yEHN92IVgL1qL
 sYq9EFy4Pr5xoc2yCSFKCcbxhTKzodnKohO+W/PDlA2p+D0PBSH3sNKKcuR2FdODRbQF
 OLnUF1yU7QQm1PHTgdXasXNVk2hqf70TW3z3N1uyYtyDJKC/M/yjMsbu4Mn7PpUBoeT8
 JEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776886555; x=1777491355;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O8xV/e4E7hprQ04fsi19fLI2fVcl7PPwdDGjlz7kw5c=;
 b=pXHjkFBPLLAmc66w83ZiNMmVW6rNavfRg12ADRl9GIia7zsKFLGzdMWwuGvHq8rJ7L
 HUUurx8rGifpd/zK3t9EdnynRGEreZvQadTB8F8XS6E46dbk7YdLOAQk64cmIIfb+noq
 HJk4/XKRcnhb2g1JefUyO9K+GYA0Bx+VgXrGo95EZitRY3UtPyrf6bvNROMFOAzS3sSL
 BWPdCmLJZAUxP0K4NHWNy0loWYebwbCIz8YCorKEM1Xw8Kb0LfK9uCtjm2ZdLmvyKt1v
 TNFbUfhcNvX2YAI+8Br5q8UlLLvxus9e9CucB0qr0DrZaji25vH+r+jH1M5CA36Bo4NI
 OIVg==
X-Gm-Message-State: AOJu0YwwUW0IF5wGjeon59bafyz3j8GpFRMb47UJpwt99fyBZ2bYfvLs
 wtPWn+RVUpUNDRXG9ySOKc2U/1f6AxVKgAwQi9jW8rdEsWJYGlzmEZHq4AYRU/HBYjWOfdtOBv0
 8yGqEh/Uyc+dQMC3DFzxv99LjHnmDpglNmxoLLaFBQ6XT2ZR9Y5p34RcfVHuDNFU8+WQFQciz70
 XCDz4=
X-Gm-Gg: AeBDiesNk6uwz+Y11BnKmYQgb2/oBAi1lClyW1nCUkczLsW8bY0FrP3hwZiSty8TDrQ
 uXBqaSsQJ0kYso/G8N3jw+8uXDt5s9lLft2/dVUG+mjwulh8uTSDA4pVoTAKFf1ipKGugcurymz
 ri+28sBAM9bY77Ir8jGzpOwxHp3O0mi03CBWI6MuCAcY/3mo6p0bTYzRU/4wYdw1GKOH3cHvZm4
 V1asTOg3WjX8DvYotFM89NVGFI9fNBU9MXIYKoovR+E8SrVgOQPu+zD5XNiN7zJa8Pf+zdWcL7E
 +TrIgdaDoyVJkwRveoYX24RngeAfc6UU6O5vDn8m/BW/iJYJpfGNF9l8bocFizavrHJ2F8AK+sS
 NJWjyLlLUrQlX7MJe5lhXEJXNd87pFX0k7o0H7cazm8CIqeCE207+yFelNjaD9rfpT2PMvC+vNy
 oE25rTa+vkTXgnRvNlgrN4anqJDVYwPbvBzMv3M2XwhgrCLw==
X-Received: by 2002:a05:622a:1148:b0:50d:89f0:9a00 with SMTP id
 d75a77b69052e-50e36c768famr341145241cf.42.1776886555558; 
 Wed, 22 Apr 2026 12:35:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1148:b0:50d:89f0:9a00 with SMTP id
 d75a77b69052e-50e36c768famr341144561cf.42.1776886555058; 
 Wed, 22 Apr 2026 12:35:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185c8a33sm4723395e87.36.2026.04.22.12.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:35:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260417064953.20511-1-clamor95@gmail.com>
References: <20260417064953.20511-1-clamor95@gmail.com>
Subject: Re: [PATCH v4 0/3 RESEND] drm: bridge: add support for Triple 10-BIT
Message-Id: <177688655365.759482.16461367874412895316.b4-ty@b4>
Date: Wed, 22 Apr 2026 22:35:53 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4OSBTYWx0ZWRfXySUEvFqNRAbn
 14fIHIxVDLdmfrpPeVW4lIOZVqiQi+ziEHhVoUudcYuRWLxKoiogOVtjZlPSrCxZ/Kn+SGIM98d
 rZu4R5SPLnkcxntacTzp14MZvqWkqPpmwYWEBa4vRo8DqJgi5vFoVxNwqqEOirelJIHTW12Y0g5
 iqSfUuIEhTMMlea5Osw+blfeQ91+matqL1r7/Ef4+JYF2lXGbYwOKdYWtTtd7MjxCmRPLlNUCNp
 2gX1Nu/BdU1anqdALySWl3D1y46eLM5bAPdmrGgk0iCj2kHKqST/fQak+Mklixu7W+/xvVQKAQy
 2AXub0qvTa9F78btZraTievG/JOklscMTmPOztpD2RVZG6bOQVGcv+aFZCppynR9QYbyADr4myt
 oQE1key62AmgvK+Ynv4wBLloMGEDFfXk/WDk4L4J2XQa3C4HkztaddWmdLImPmDOI7HfsIOIa1w
 TYg70gmfjXMY2gyk7Uw==
X-Proofpoint-ORIG-GUID: r0UcuPo2Wig4mCTxWe5ucrf4rlR3We6Z
X-Proofpoint-GUID: r0UcuPo2Wig4mCTxWe5ucrf4rlR3We6Z
X-Authority-Analysis: v=2.4 cv=TJt1jVla c=1 sm=1 tr=0 ts=69e9231c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=4sy6PxXrs5WGamlIgqkA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220189
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

On Fri, 17 Apr 2026 09:49:50 +0300, Svyatoslav Ryhel wrote:
> Triple 10-BIT LVDS Transmitter is used in Microsoft Surface RT and
> MStar TSUMU88ADT3-LF-1 HDMI bridge is used in ASUS Transformer AiO
> P1801-T.
> 
> Link to v3: https://lore.kernel.org/lkml/20250824092728.105643-1-clamor95@gmail.com/

Applied to drm-misc-next, thanks!

[1/3] dt-bindigs: display: extend the LVDS codec with Triple 10-BIT LVDS Transmitter
      commit: f7e677a23701a95e71569be88759bf195fd9a42d
[2/3] dt-bindigs: display: extend the simple bridge with MStar TSUMU88ADT3-LF-1 bridge
      commit: 147782489b48e7bda472151cee48985d6704a919
[3/3] drm/bridge: simple-bridge: Add support for MStar TSUMU88ADT3-LF-1
      commit: 7dbca56a79fedf40106baffbc8b0e15f1e54098b

Best regards,
-- 
With best wishes
Dmitry


