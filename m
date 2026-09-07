Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C19C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A373B10E7FC;
	Mon,  7 Sep 2026 13:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JeyDuyqh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j9Ia0FK+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36FC610E7FF
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:00:51 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AnUEn4064632
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5Zxd143ASUomJNNgHPeOAeQIGghuC3wI/sji5Dtl2sM=; b=JeyDuyqhPyOJhQNo
 dwaVgIkG+yKlIXzw44icOX4UHs5HZFBeWgQVQ8b9S6rXB1dym/fL15+FLHl+hm+e
 Ch9MzwqSRQNVphWaHMvcHlaynYiW3wIPsMCtbMQcbmxP2aah+G2U41aAqxvOT/e7
 fVzOZ8RIFHpyL1o3FopcWrr70Szpg7np8EL9VE2w3zp24ZC7Vtgy+/iF2+QO8/9V
 9Z92mipyt65jv3eRdkbY84hQFN9mfZHPYaBcQAi4o9/Qishd2kdIjAwcvsWpjfc/
 PLVqCPtqGqo7amL5/WBHZjmBCS+D28FJiYMAlis2L9oIwk+3FqXEWtIlAsRJSyMU
 6AV9UA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86s9j4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:00:50 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97bf8f3a38bso198541241.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786049; x=1789390849;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Zxd143ASUomJNNgHPeOAeQIGghuC3wI/sji5Dtl2sM=;
 b=j9Ia0FK+A0A6lHMEd2wvaRcmok2uXL5uyOE5D4JMgQdQGK617PjtCErWWCP5VVfKO+
 Y4nTHQXwwNU8efRtixiSbhVoz82dQ95ingqZuPTUi5ce1uFBPXlG5P63GaLfbt9+G1cl
 tdMuBACRx0MIjSmUFvW6oaQpJ0zny/G3TpbYjitSXvDWxTxRfeyB5IO/JR29qnFP4yJ4
 pFinxRT9yeta+kKziQdTFMEvLkFViRl8E3bYkZbqjOnetsP3F6ODE4xBg4BfaxPqO24x
 OYHHfiTeGyLCStxbKsWG8EkW6ZrmqjfYeIK4qr2IIMkt16kP4cBwFVpk9HpweKqG0eoE
 Qe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786049; x=1789390849;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Zxd143ASUomJNNgHPeOAeQIGghuC3wI/sji5Dtl2sM=;
 b=Z4TNLfqsE8Zxl+t2/ErvG7ngQtAk+xUCi2oDKIwddw4S166XIBUQawi/DEY+5PX1W8
 WOCEBANgmQItYrCBJog2opReLfPKnX4Uotm/43aFOBS5FoM8N9uFQBCocGpUGCmD0Ror
 vrV9VA9YBVwMK++r/wN4n95CbCjZXUszYaPxTmYT3puT2oFBTJWlLRFAmr5bFy83KROe
 htcCCaJW60JlS75xbFq/gIWrYqSLLBaDf7yZwQ8AoFniwnP9+mOSPs4op+ufbvETFHw5
 d+utPV+d89nX/ulm1d3efUcwop7Ud8lil7u/Vza3KVBmeBgVlh2vy/0S5IsDhzaYfWq7
 P3jw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHj7Rj8DbLQ70jAj6wYTzPK5ugXM5X6RxOJUStGNTSOE5m3weJYyE981qusSOu6SFMZNVkPZKyPxc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k5+3zF7SWvWS4fYUvlmm/Bk4xTZG4+fcTnwTyjxRolqpnWLEzv
 6biSWEJcVatq9A5JklI6puopbP3qipm9A1VD5jkahIXGs2MimqeoxjdjPzEzanwHN/d5tsbb13g
 Faa/u77zurHtFgtHcxi/8VojPcI4tCvcyQcVnGEvkE6Ik5FTvCpRd5m1LvnMe0Z9MbVsOt1E=
X-Gm-Gg: AYBFou2oS3MP0gESJnYnH64c2Mx0OcWk3Sw+pFcjbH1iZh2VitDYyRDgr1NKxq9zsFc
 dZTlDdj9yWykdvnssRovHMt/NispF2CGBQx1w7bxAAIp0BQT0H2I6WoJkdYi0qEezqmOYn7wHCx
 gRDObUkqS65XOJOi8s7Dk0Olq7DoTDK8x8ZZ7/QHtjaj0sqC9u7IIhjcYm6FpbT1PLBUDmnv2GB
 MDN6s5WQst+qHBDuAoLREn6YMsKHWwqF9rSjPJ9GKFBbJKbI39vTyOoPwPwYasjPqgOq/UdrO/k
 pOtmMDgSUo/P4Ye1n/+4qB7P7n0ePhBJGF2/SBfeaNFAm9oE+bRmHenSz4q7h2uqkGHk8tOWmef
 CF1Xz8X9tbLZyaEAG/yu8E0c=
X-Received: by 2002:a05:6102:8099:b0:76f:eaa2:6fa7 with SMTP id
 ada2fe7eead31-78a4a6d4adfmr7328450137.2.1788786049316; 
 Mon, 07 Sep 2026 06:00:49 -0700 (PDT)
X-Received: by 2002:a05:6102:8099:b0:76f:eaa2:6fa7 with SMTP id
 ada2fe7eead31-78a4a6d4adfmr7328410137.2.1788786048792; 
 Mon, 07 Sep 2026 06:00:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff81c9b5sm198751205e9.4.2026.09.07.06.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:00:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 15:00:21 +0200
Subject: [PATCH v2 7/7] dt-bindings: display/msm: hdmi: Correct name of
 disallowed supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-7-b097cf1eac77@oss.qualcomm.com>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=dxt0nRLMlCSOHXCt5GgWA+SbZAKlsIeSxAesz/KABiI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqnrVp5cFMmNVGYy9ANhImIAHyKD5dGnRPUBeVP
 O1DuCsl5oaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap61aQAKCRDBN2bmhouD
 16++D/0bbkHFrM/DSB17DsFeQob3v757v8onIfgsK4xIpUIPtiULuD/AG8t0JcY8swQx5ckcrCm
 raqmFRD4zTdXnygkjlS+0MUr9+5zVTDvB1N58YdxWso47cdyTrA9XES4yWIHADmk4Yu/EobsWA8
 +Kg0jWeqjDVoifxxk2ra9XUq9p42HzDHADKOitroD3WMzx2hGpBsIpJdPWIWf66/k13GlWRCAhg
 eVThPzf9myJWdnmeODBJ+vJQrl4rpCMsKOBWcpa0HBQXCfw/hhRcIl7aayrAKJuefX01wDYuYvi
 ZbZxGOPIsbcoZKpgeLFOOtxOKal0cFCn+p+ikNF9GKmxjGENd6Q8MWgTaHVH+l6sMaq4FI/6FhT
 vpvhxZFAeE/sOAvCQnkJqHhCYtaF6fXFkuSRTO4eMyq1dMHWXxTQ9Lo1/UBINsi/YvHrniMsdv7
 fi3TFc/mxIm68i8ahUny1DvLamzdcNHpOUiCBpFVe50QKnT3nUEZt+Vwx6Qwsid+BfaSkY/X84e
 3s2cQSFrXlc5/sjrmlNb/vbnvS3JM06B6+6e5/Ac0Z8zQuTIXdjZO6wuodgUGzrrOAksYJIoATo
 Ea4/8xYhjDsnO1tUaqOt+DmnKYLA/MIwvBs/N2t+ybpJZM0ZHumq1j0MzkiIpDokDx5UdGWrxUS
 /1ynteKFLOmJsyQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 7sOMqB3-uxRTiteOnvmYNAdhnXsUePTt
X-Proofpoint-ORIG-GUID: 7sOMqB3-uxRTiteOnvmYNAdhnXsUePTt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX+ytG7qHQMErA
 xcE4zCSCL1OPk5UskHc3e4nnB+iehRZf5R7+OjZYvHKEOiY1oi99ba0mcmvOUwzCvi69bHT2+T4
 WwRD9ttfEb87lsGAKA0F0lUlxbGmk24=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9eb582 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=LSMMCDwwRte7x3nqQVUA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfXzhKAz8mRB6j/
 6nqKnMWyUg9zcsOvKyrfqHQ1KuCmOC733rLXFpnj+vot9SIY++ZcHJlMsODMa9kNcLdSkFUYGN+
 /gi3mXAd/Qsmkm/D5oYAMxe8tzKqMOPl0fTDUUXM5eADzBWEov9ArM3MJMqQDg9v327uK6xy3TU
 mh9qeWtHKSYLpRgDAF3x4jH5NqGek+/RYgHyOouHPDtr9KzMPSlaKKgY0BT7ra2uJvw57gIfxiA
 ojKsblvhPiUWlFBDGhwsprIQwuzmBeUJZCXg9HpDeJJ38YsLq6m14VAKHqwN9tvKv19pvz0E09b
 wAXXsOKW4BxYmT8IUnXVLsPY+m1nRVoc7snJaA2R2sIk3SHFSV2CPtlYUeU7NzOZt3Cilw30ObH
 ZYZMPcfq3exAZ44xhTAHvRQeuIrHVkq90AAiNPBVA6+wgBLxT5CHLD96mt1Wkd7nb4CG8Nr4pEM
 KBC8q50JOE0rYDk9QXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070143
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

There are no properties in DTS or Linux drivers called
"core-vcc-supplies" or "hdmi-mux-supplies", so the binding probably
wanted "-supply" properties instead.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/hdmi.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/hdmi.yaml b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
index dfec6c3480f3..02d27ccad024 100644
--- a/Documentation/devicetree/bindings/display/msm/hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
@@ -113,7 +113,7 @@ allOf:
             - const: core
             - const: master_iface
             - const: slave_iface
-        core-vcc-supplies: false
+        core-vcc-supply: false
 
   - if:
       properties:
@@ -136,7 +136,7 @@ allOf:
             - const: core
             - const: alt_iface
             - const: extp
-        hdmi-mux-supplies: false
+        hdmi-mux-supply: false
 
   - if:
       properties:

-- 
2.53.0

