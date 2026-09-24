Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F190C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8262610F7A5;
	Thu, 24 Sep 2026 21:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m84GtUdN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ji/mFo2c";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD6210F7A5
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:19 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdlFm3462615
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JGkBawBsWkDYfJFvup28CeJU80F1RrPvHMm0I/iA3OE=; b=m84GtUdNnS3RSDz/
 2LcMPv/qnjHMd6nCe0Plp7P940I5ry01S6tnXMgIIZ4JgijUaB/F9l51/yvhErmL
 6jhZ6DvMjzIPuynDPZzho6V0mFZHBxQpeE93Kc7VqcxQhlyiIoyvQRi972OYZDcK
 VJJYrvTqULfeZB1kkJDlZXcVxgh4v/tQynmIq0hCMrqzY/LXXADTNJ5Fk/ofg6X1
 x5CRNCKDYbgnyhH84AwZPVpa3T7v1glpL2QDk7UtFrq0q9CXcUhewX3O1visyfMf
 A0MRxn2Wlv3wnnHkdGv2/dz/q3vwLF49FCE3uIrR6hQcwuj98I0I9ymPjcSrIAxW
 VV2Tmw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjjpkx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:17 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so974858c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790284517; x=1790889317;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JGkBawBsWkDYfJFvup28CeJU80F1RrPvHMm0I/iA3OE=;
 b=ji/mFo2c7nwyIC1AG7HKJpOJOYGbbyyC6AjPAQw7h3TLSZvdh7vY5BXus90PsPglBL
 0SI1HQxT7q7hVvv6N4CEk+40xmYI7jNEwEk4YQ7t0SKAeWeAmK7X5XpJsn8i/I3tsoFq
 u0H8d+5Ccn3ERi6YeoDhIXapR8duo2oCRwaYAMPliY2pjtzWfky3kFTKuils5feEhTcP
 rA2P44phAaIkNts58KId4pXJad9ia0RWQd25AemmYKue3RJCQ9ufLLcYXlynL08zNqTc
 2W1pCX/6kw0bTCXyONpCLvHHpGliNcFJnobaTKN0YEBBwWqb74sOjShHRb/28uvm5Q4q
 xmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790284517; x=1790889317;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JGkBawBsWkDYfJFvup28CeJU80F1RrPvHMm0I/iA3OE=;
 b=st5DVcQhu1LnxvK70t024Q3w1fE67UbMWlJGJHfWJhFv5psIkoGfW6NzonQix24gNO
 4W7eP7EpTNwwnn7ytlpxRslKtxQzbARDswIk12pDmKcuFVZxW1N7NUOm5dEpHcyXVQae
 98VwUDEOuC5EqGmrzwmPBWQ3+gYt553hCFBYTKAHzuEdJWaDgbATJJFLrSids6tJtgFd
 UQZYMcO3NMgvzEo8BpcnKhKH5nbF/wjd4hSat1Pc1WWEErVtE8hoBCbi3fykmc68wkRW
 w/L1g389eEWvsvPGj3MaIyTog/RwNBlN36m6YM66FoHxvKB12baz1CUmlcjY8US1sQiO
 CWSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2KGea0ICB5sozUwZFvO4Ry9LpQyH1RmH8QKlpiHs62kshFukTY9OOvVGXOttgBTZBmJbncaAGQmA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++khnGknwzX2X4IX3YvD8uE7vM5SgDLc3+k+pktmKidDuqWoylBn
 a3/71JLQHpDJIya2QrspGpGMnJfQ+hy/UA2ZSvT1PGhGYPAmjlnO4byscoLENK+3tFiuNLZz9E9
 6kHrm0SiGR/HLh1FAy0h04eDGMLnqKBbivh0/OEJkUbZ9pxRhYYeqgJylYtrZnSZcp6NIZNc=
X-Gm-Gg: AYBFou3MrwLi3p4bADjPl77MtF2JQTny1z5ye4YcEeBjHGV2S8hVOVuJeDJusBivO/Q
 b8RTNKzV/xZeDf+bLNuhpvlmlIoqxAe1vuiEqNxEX18+lvPVz/R7HNOYDnlMbV9CAwwHExhF/oF
 5T3D4o1076GdwgkKeDVT2G3kg2Op/1HMF9mNDt1vRv3NH5nfTvlWo50Jm4oODp5sTZOuWSGfRnD
 dAnUy75+z/y2tEfHDq2z8pcLb5UoLo/b3EUwwg5OzCBqDCL+6yKSTS0W9YpTCiu4nvc6f+lDqV6
 is4M6gdXj6BUpqbmpI/apF8sLE5r1zseqog2IfHQIX9CUANKpX2KKXVOJDOIjEs80xSwV9wVTrL
 xd6sKzm69apcXG/KmYYETsDg=
X-Received: by 2002:a05:701b:280f:b0:143:7330:7fbc with SMTP id
 a92af1059eb24-14503fb7d58mr2637782c88.21.1790284516742; 
 Thu, 24 Sep 2026 14:15:16 -0700 (PDT)
X-Received: by 2002:a05:701b:280f:b0:143:7330:7fbc with SMTP id
 a92af1059eb24-14503fb7d58mr2637727c88.21.1790284515607; 
 Thu, 24 Sep 2026 14:15:15 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acc47ab8sm1323776c88.6.2026.09.24.14.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:15:15 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 02:44:33 +0530
Subject: [PATCH 2/5] arm64: dts: qcom: glymur: fix Adreno X2-90 GMU compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-mahua-gpu-v1-2-0fa0bfd8d315@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
In-Reply-To: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790284491; l=927;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=dqFAneSd4zL7363Qe2/8VcryWwTx+SO9Kj4pOL4oJBY=;
 b=Vebdhc0T+mrn5mzFGJiB8rbqLfgC1XngpTlhfJp4Xocf8bgEq3CCYSI3kLNcd7cYnxbcdvSi0
 6T9GY23MvQZBL0DnKWA447FGx116TyNTUJWbfajiYPcvipqc2JR7efQ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 8ZXwliG6x9LApSsdJXAN1ZUKxWl7KYLS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfX8vwgnARWCzis
 KntMfY/W6lc2WOsCRCKHsFG0pYfJirN1EQDA1l+Sld/I8JqLCkkZHnN/71laO5kehow/L4c9meK
 9UFmBSbGU8zCdK57q+C+auJYA2UJuLpyKiVk6IBO+8j0aIVwVmkJ1UsweoWXVluwM4QUxGChOZ+
 doiYQ4GUP6RPEdN6dFJma9ky23LexCXVGXlOfMfe6CH0lnJCxvQxAdf7HDqU9N35EeB/8Vbvkc8
 YxSxdHfhkfa8Ws7F1g/IzICLy7aNixNf3dhOFOJafgjYoC3RBdi3WCeX7haW3skTMysUNbclRBH
 mNkLHXSJPxR9O9FRVZ1/1GatJhFvz9jcDoPh+Y5/3QX5nrbBukTe+Rrg2DeW4xcRcH7KpEwAkPH
 YDQ6ufwWzNyh0OmDVM9stRqF4Req7jo4mdxBAjfl7/+3kZ83ZIUUvr0OPazmUHUQqyackNi4qlb
 ByE1kxzCEkViJTTUgPg==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab592e5 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: 8ZXwliG6x9LApSsdJXAN1ZUKxWl7KYLS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfX2UJfci0KeqLD
 kOtNA0NnoFzD93sXJ7Ae0hIqvxWgCZUTIZcm1tgzZdFLqtAKUfYHYnrRsHLhTclNcpQq3FXfidP
 LN3W8xCxN6JpxY6Yf02xDKxdAEqJYYU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240086
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

The Glymur's GMU compatible was set to the wrong string
qcom,adreno-gmu-x285.1. Correct it to qcom,adreno-gmu-x290.1.

Fixes: b6ff8cec8aaa ("arm64: dts: qcom: Add GPU support for Glymur")
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index de7c395d9c35..29c62118cec5 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -4286,7 +4286,7 @@ gxclkctl: clock-controller@3d64000 {
 		};
 
 		gmu: gmu@3d6c000 {
-			compatible = "qcom,adreno-gmu-x285.1", "qcom,adreno-gmu";
+			compatible = "qcom,adreno-gmu-x290.1", "qcom,adreno-gmu";
 
 			reg = <0x0 0x03d6c000 0x0 0x32000>;
 			reg-names = "gmu";

-- 
2.55.0

