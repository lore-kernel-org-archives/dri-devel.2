Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FCFCD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 21:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9001410E130;
	Sun, 14 Jun 2026 21:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kZVvZP6V";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JNlIgw8N";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6AC10E12E
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:33:20 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ELF2FD2669390
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RJNbTAj+jMFVYX4XVSum5y6+uZsOGvYQPlgU5ZiXWP4=; b=kZVvZP6VJrKoSNV7
 LKhWeEnDvy8IowCzIt6/hmnwStxg4uCjdN1GlRDOcsPizXajLUvfCBEdbhYJR5ut
 bWBXM/xGfnVx8JP3CVlt48QKCcU0uI5nCar9ZL/AUh1ImXT6vzSZ1exCyc/gNLgA
 FaBJeKjOdHlqowWqZF03bGMYMziZmq7WqJ2bVZcE2L34vo+p4gJjRBFT94FtlxBu
 3QgMvuOhG61la6WPdSzn0KK3/7vM2sgfuBprK1zPpE+qZqNKAaZJOYRDqgEiyrZV
 Gxb/jUlrN7AlSEZjIQqv55kFWmJwHOOxQ405eb9mMaRSCr0p+skAWRSbClUnGwou
 9KtT7g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u4jth-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:33:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c0bf6904a6so46004035ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781472798; x=1782077598;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RJNbTAj+jMFVYX4XVSum5y6+uZsOGvYQPlgU5ZiXWP4=;
 b=JNlIgw8NI3eR9cpX41iqaxSWcbgDC6veesCgNU6pwCncNxG8vLLomBf4glCix/rBMV
 PVynwGTHj7KamQxqP7wD1kc3n/viZ2Glf9DhuK1cAtPFuNbYMNYAesOdUFUO3KGKvhcb
 ck5Bn/QskRuwVBAlukWddng0+MhjkKGTvtxjg/HgTvbOwzgcRecSqO4rRF5ahTR5FqSG
 66HHYGmF1uP61qRlUNj9wSkq8t5wVtgoMix0N77gxrOcz5jSRfFoVSdRBLCPPTTt67L9
 H/lku7iiMBn5NISz2PtGtgfNqW1wIXTCdVM031MDWHYP5gr//Q2QhD+vhcKHq8mOP9ak
 ouqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781472798; x=1782077598;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RJNbTAj+jMFVYX4XVSum5y6+uZsOGvYQPlgU5ZiXWP4=;
 b=bQ+jLl8KhcU3KQZbSxaMBzg+H3K1SP+3396RQ2MnScXO9hWxRaQUxSw1mMJosYIU0e
 u2BuFjUDU39OtgGqeFdr5Q5ASbIgOr/XR2mrlu0Shd8uqD535Vp3Jkru8DHZkOtTa60l
 MLZPUGJIhmXaBvGQrA/IwpGSELXdiXq2q7wk2DMPCh5SPOh1DdGReNv3ID+2GJhDSn8K
 vgl27XqahaMvwfeTzRU9ptw0tcSq1P47zaboi00OaRt+oDz0qqNapo152D1RWQMhwwpu
 94rd3pOkPC4Czh6nLelBLaQ4ET7xJMn/os3YcpJqBuJ9yLtnruSbHFs81sBLGLQ6H2jE
 zV3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VeZ9ZJRspJRAh93Ij5ObCWLLBPnR89TOnpj0TvqN5ZHaM+0zZfRobVxMDHoyHKEb0y1iBjp0eJPw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZ1eVH9lswAnNDj81ZR3Q0p7wHkxxg2U/5BfM1W0deL/6ZioBp
 vbyJ9xhzNUTrV1JZU8uGulzgO7xKRiUX7tTTojy29ZSZrCQVt1mIE9jnlUP4DKLe09xtcaEczF9
 IFoBKfyMQUVGn0csQAF0KIaddMQRaWKFp+1KXMvr3yxNmXcMDBtOKuuIWED6tRjZlYt73p/4Xhx
 tMBg4=
X-Gm-Gg: Acq92OEF1cgkmWLqmk8PYPakK2UK3AtDh8RVBLd7Is2ZWXLB5cWyX6IgGbDFZGLDBTC
 Zb20qD3WYzviF6aHkfnOOG8pnBu+WKSCymM5QlISX+xLEcEg9be7rB0+x25Oge3pMhpubJKuyoq
 gTNX3Fk4fNMc5JrESBdHcN+HLcNOeu0LWwf+E993YahZmJKo18CkwBr/stCbrk7nDzJVjW8YqAH
 YfYu8ekaQEEq6+ZZdYC96sI7paWObQoudYKUlFRsz/oo/5beBKNevpRV/VWp4qxqg6eBEOU9wDW
 SYlpi2ZEG6yxeesGME6Cg3lx+hK4BO3c3BDZwoR/qe62OZyD1L5LBtJLygZNnOORWOk96z91LrE
 XEnPPB2rUdRqhBVjq+vuaPTrmyvKwp686qk9Ac13A1N1sxw==
X-Received: by 2002:a17:902:e54b:b0:2c0:bb2d:a314 with SMTP id
 d9443c01a7336-2c4129391a8mr131369465ad.28.1781472798098; 
 Sun, 14 Jun 2026 14:33:18 -0700 (PDT)
X-Received: by 2002:a17:902:e54b:b0:2c0:bb2d:a314 with SMTP id
 d9443c01a7336-2c4129391a8mr131369115ad.28.1781472797754; 
 Sun, 14 Jun 2026 14:33:17 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f7c6c5dsm78385815ad.21.2026.06.14.14.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 14:33:17 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 03:02:57 +0530
Subject: [PATCH v2 1/3] dt-bindings: display/msm/gpu: Add support for A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-gpu-v2-1-2f2d1347c3fb@oss.qualcomm.com>
References: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
In-Reply-To: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781472781; l=919;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=JBJQ6bZjxqgxmRsc6EMGB+P+JygJ8pgGviEVLPjhEKI=;
 b=9c/Nh5M9LMZTEf7PKcK+5Hqv/dWjx+aNYHao+IXyE9Lpi8hX9zjkIPm1EMl/8kFjmr1IfHoDb
 QnNQYN//NpABbbG/pAJC2eLV4BL8orSO/XzLvu9r9mMxo4M1FCp7ipD
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2f1e1f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0BLMfrXV4dllX2mv9u4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: NIopDPrac5arxV43WF4sJrJD1PAtBvMh
X-Proofpoint-ORIG-GUID: NIopDPrac5arxV43WF4sJrJD1PAtBvMh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDIyOCBTYWx0ZWRfX4Be+uZgIEOcp
 BjkwhtXcYmJJSwkIyCkdBaXtKVWD8d+UG3/gGiZqLyyQMpa4QHcO/Uqg4splrvZqyY+jdclrvxi
 eHGu5sz8pi942ORv2ojuG7o8SSMAKBgDHqFoeraPQER7tINW/93L9p4ICzYnVXFTmcfrMpdTLxF
 L3GCqLbG4x8hk9D4A0NMkPozBeMKoAMJGiIzrlTp94PSjHFJ0+CZPTcxpCyD8DltPAbH5CBg98K
 9pcUE7wszXIQm7VsEJHW7Jfnq8++ctmBkub85U69Dyr5Jr3G/iBiL8uicEf4qo2/yFRTLZxxL/9
 HdQ9xv+nsX84QOHAzScSF+To4k4vNNQrUeVBbzHTgURiWMF03hIfzMdlLVGCtYuPhI4dueMup5w
 Q7Evc0ri4uVz+vmmtfPasqJfF5FkgGGV39MeMefQfzOtXxCvoJ9YISue/f4/EBt9UdZQJ4pFG6P
 tLVvQ1WmLYloPzsB2kQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDIyOCBTYWx0ZWRfX+oYGb7wOuRoy
 K4tSllyJ+oD5NYlI6EkLKb671KyipXdeJahTQ2li9QBH4YXrJus2VrSAMvTLUSk6ihvQu2VO1o6
 SXjKMd8CyMiyVw7aKKa0eFWCn03BRNU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_05,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140228
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found Shikra SoC is an IP reuse of A702 GPU with very
minimal changes.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..8e648bfb3b23 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -353,6 +353,7 @@ allOf:
               - qcom,adreno-610.0
               - qcom,adreno-619.1
               - qcom,adreno-07000200
+              - qcom,adreno-07000400
     then:
       properties:
         clocks:

-- 
2.51.0

