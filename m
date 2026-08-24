Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EACBC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D2B10E562;
	Mon, 24 Aug 2026 14:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QkT5+lOA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hgzSCbDQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42A5A10E562
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:06:47 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OCv3uf2854928
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=; b=QkT5+lOA8FSLRxeB
 FdxM+927evVxTNxodgZXEuTq+mcLFY+awBZPbwTToS/GMv229y8AJEH7bwDJMpj7
 UM5dyk+y7ULRhS2TGKZlSGXMZfYxpqlz1xekBC9+egBo7mW4GrX847BD+1X1w8OL
 3ym0ZxgUM4jgRlKZCGZkiyfGVQXVsM0PUWx1qx/u27s3/qhObqEkd3UbFzAgNiZs
 aYTA59nDYuSNL/NLrFmRkJAHVtOI5Apn2crqVICrI9zzLWX36kc2L6f0VTH3Z6bF
 6xbB5v7NAXHkvVqtgFX4vFsfe3ahTaGvHk6mCaynA21/LyQaVUcjpEh8nw90kHza
 dh+JsA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gqn9uyb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:06:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84a67b16217so6027268b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787580405; x=1788185205;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=hgzSCbDQvlbVHXtlopja/0csUhbcPzTIwlp5WYwYSp2sEiyXeZHsPBqAgjpS2/UUTC
 ZdWXlu+XrZtrZVEeQ+OtYe9uPbzkOHjTttXeTTLY5bWL7pGKrnGq2p5cMCOPRRpGhDA8
 OOAxI3g9z1XTVtNxR6/as36gr7sxFvsNsvkiRrgC9g+dEOigi9se72DcMvRTvasMEFbb
 rFqpgY2+hJDAgZCr9uEla0y6iCpdIQNaHK4MP2na64OKyiHkwtc+sT0LrqwF2/BJgI2r
 D1wLb3rVfaoim2EYDV5W7A0C8+RITT/dnczUfhlseykigvLf8I4Ieflzjj3CUrHafYVM
 a87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787580405; x=1788185205;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=Vvtf/EdEtFqIk5vvecRnS3mKT8fBrnImXK5dI+MXpbVMQFLYBh+EDolEz6ndE8dtJ+
 WgDUzen0CGdCiRmxOwwo/k0KDF5AeJt/YD1uMXITPG85iCyy1Ad0uwWhBcu/+dq0rB1X
 OIMNAYxj+Ks7fwx/daEgJpySqqj8u46QSaNVc8Kn44dTC/ZZDauySWtWs/CFXfCnyxXC
 tAckAsRTNNSwj62nYiJ9MO/inPNUlh8X+tjyWoQEwUmwPbAgngCyvPGRbgu/knvEA3Qr
 KvCnhS0z4bAPv7ZJvjXUlcROzPrItu+Cq7N8Z3pWCXBPay9ZQB3R/zngjmy8FtuFcyOf
 M9CQ==
X-Gm-Message-State: AFuF++nakNvJ7Z0md00irWtpcX1DMX7xryCXRFHxWbGXvePuEgNxyTrw
 OTKXZeKYL588t6od+Ve3PA4BbNMmsfh3g6/WHcfTstageNaMGdX9fZ/z1qbM2txb4RH4ngw/jZk
 +YhnEM44u4hsyMoTWZ6vllF4VvCRoqx/cZz9MPLIaEbNi8QOD8lHMCyTpTG1zmIK0w6I5lCg=
X-Gm-Gg: AR+sD13fb3q5/7Gz3o1cgY/I1DjxXFhfYPARB4WUsysKpxDkcf6ZcDX5KEIn5QSUgsw
 WbSZgLcmdOOdrox3esEb17RodTmQRr+E3rYKDcr3eANXbYzHm3AssWMv5CkF1P8QM8WwMD5OjBu
 qyNRv/sV2jepd7aX4KdH23Jz1whEkR5qiXvAN31M97+fysqiLKG44l7LIYo2d3etfI2ZUjGDy40
 XtM4gaNiJIA2sGirisr8iOLtBOASEoet2vZA2B5budhTV4ZWO7ZAKtRkakUYVR2c+nAafATET5q
 XnUIfcUtc/MZWrwNHI3weP36Tf3A9dpji17k3BJvS/uYVb6UGmS/uiigr/F9yN1nBbXsl+bN3DB
 O8Jb6Rl0Fj52N8DcdvWvP7C3BQA==
X-Received: by 2002:a05:6a00:138c:b0:851:b007:2fe0 with SMTP id
 d2e1a72fcca58-8520b9c6d39mr29528169b3a.1.1787580404653; 
 Mon, 24 Aug 2026 07:06:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:138c:b0:851:b007:2fe0 with SMTP id
 d2e1a72fcca58-8520b9c6d39mr29527999b3a.1.1787580404037; 
 Mon, 24 Aug 2026 07:06:44 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520f17f7d6sm2146599b3a.61.2026.08.24.07.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 07:06:43 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Mon, 24 Aug 2026 19:36:27 +0530
Subject: [PATCH v11 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-lt9611c-v7-v11-1-eb4a79cb597c@oss.qualcomm.com>
References: <20260824-lt9611c-v7-v11-0-eb4a79cb597c@oss.qualcomm.com>
In-Reply-To: <20260824-lt9611c-v7-v11-0-eb4a79cb597c@oss.qualcomm.com>
To: Sunyun Yang <syyang@lontium.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfXwx9MpSqIiWtv
 Aff40OMGUm1mOCwEfNkxgrlRJfPlf9l0laRVtxTFQIR/SdcyCBAplrhHDkMNDiJfERyZcwEY8zq
 vnbEd/NTRh1zR3T4wJP3bxvugVM7Ip0=
X-Proofpoint-GUID: Rn9L77myYHiT4e8hyCtQxC9pBwtuFyua
X-Authority-Analysis: v=2.4 cv=fqXsol4f c=1 sm=1 tr=0 ts=6a8c4ff5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=SdC2vBNBQt3qShdCGKMA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX2Mq2ACijwHW0
 tvzEf1lLSHP9/zCxjsp3DxwPFSIMeCJ8YqdpLO7IwI8hZ2Md/D3ziA3k3pwnhLD9w72NwfAUpix
 GH++1LGICJI4AT5IGt4mtek38DzTaFOMlThtKdpaB98RTABEQxYAA8S/z15Q91r0iwUv/qbefmx
 9a/vP9QB1RFyMQWuObpoQCkdiZZhh7Dep75O32gNxQVmbPnB1/TRvnirJ7VOb6NCCg80N7RmfZi
 2v1GpnTgMXmrGehvIP3BTA5iflALqH79bv9k6msJbQe0qmdfZMd0nQL0WeDVBpDi9I/qRyjsqqv
 H7VA56sUpvNyKE5hKAGyEcf885ptncKxHxuhkJ5BQwhB1g0kFfZPXuSz681ocX5ihFkL4IAWugu
 xd2wiaW4ouwaltCvZ6dHKiKydGT+m6z8VUK4p2A9mxn8Zs07K4vOyAPrDLNUMrPYZeRY7YcqtSn
 YkfLVK8FBxIvFv5pNIQ==
X-Proofpoint-ORIG-GUID: Rn9L77myYHiT4e8hyCtQxC9pBwtuFyua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240118
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

From: Sunyun Yang <syyang@lontium.com>

LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
mipi dsi and output hdmi, differences in hardware features:
- LT9611C: supports 1-port mipi dsi to hdmi 1.4
- LT9611EX: supports 2-port mipi dsi to hdmi 1.4
- LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sunyun Yang <syyang@lontium.com>
Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 .../bindings/display/bridge/lontium,lt9611.yaml        | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
index 429a06057ae8..194aeaac601f 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
@@ -4,19 +4,23 @@
 $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
+title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
 description: |
-  The LT9611 and LT9611UXC are bridge devices which convert DSI to HDMI
+  The LT9611, LT9611UXC, LT9611C, LT9611EX, and LT9611UXD
+  are bridge devices which convert DSI to HDMI
 
 properties:
   compatible:
     enum:
       - lontium,lt9611
+      - lontium,lt9611c
+      - lontium,lt9611ex
       - lontium,lt9611uxc
+      - lontium,lt9611uxd
 
   reg:
     maxItems: 1
@@ -78,6 +82,16 @@ required:
 
 allOf:
   - $ref: /schemas/sound/dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: lontium,lt9611c
+    then:
+      properties:
+        ports:
+          properties:
+            port@1: false
 
 unevaluatedProperties: false
 

-- 
2.34.1

