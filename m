Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E73C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB37610E57E;
	Tue, 28 Jul 2026 11:09:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8nD3wLX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a4G3EL0S";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55EF10E57E
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:09:40 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SAgbN52043720
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qdty0teDUjB0kKLUtuopZ2iQJL6GNrf6xRC6X0ENeCU=; b=h8nD3wLXi/Qq+Cx0
 CzkJL7n50Hk856KMJwvsuEBIdFmMLkmq3XvhOabt3ZJknNZuFJb43cSKevDYYfD5
 cvRdUXr3O7GQaU/pogA4NPJuBob2X4sE1ccOf5ZN7XngDEerbtYLJpMBzA5KZCrq
 ouXIKXpy9xoU7ZGEr+Se2OuIsG0wskZPxsuePGb6nMeMXhW13TX+iyL9yZqXY/PM
 8Xz391EGSdlUuhcxWFyz19gC0p12Q7HuHxGFat2hM6SIRXd1olj+QMlmf28vjZFP
 VEVMFCNTxw/iOFdLpCidu3/+35DJL2nzWQCQGhSbIoSvpQfYWwOfJSFwDecVkfAw
 UJQJUg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpptts87k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:09:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cceabd70f5so104768545ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785236980; x=1785841780;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qdty0teDUjB0kKLUtuopZ2iQJL6GNrf6xRC6X0ENeCU=;
 b=a4G3EL0S0gF2SD4qEDoYhcTadSd8HB3g51iR43BUx/1K53DAh4zamdxhhE6fzFiktB
 TxLP3lTJPPT7iiLCq5mipwUXEJyRZ7dq6X0vMzQIKCh/IJikGIXYxlKD1OpDPTKUzGyU
 q3J+1jT7DmBOudz/XNAZZ73prJ8Yjy+rqnMr/a3IQZWcqNWPSameVR5eDhg14yXxv/p4
 EUMjMuCVzvIfcnAZT+HtW+RqOvgS0L4TX5IetDlIejRVK8SF9nV1x7HrJFKGxie0q2Jx
 0kX7qdv74BgUPs5AQpDLeIBzjtlrgGNbIxW1r+3mRng5mc5MP+JM0+2Gimqgn5xBqM0/
 3RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785236980; x=1785841780;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qdty0teDUjB0kKLUtuopZ2iQJL6GNrf6xRC6X0ENeCU=;
 b=ggjp34MTNv4w5hnlhBT4uqsLpQCFa3Imeb9EDaOry67kvVnsM3Qzq8pPpZegcftc1U
 Iua1d9PQVRKbUucwT8vmIVceJsl8JHKF2TPvYfIBL8/uhYRu/u2yaogHUF9F3ymXaCMW
 PVEoF3XvSRRhIbso8Oh4Ye6/Y2bI926TkmvnQp9k511YozoDFfUOQmNBHAXjxr8pSUVA
 c+216cNu4YGi+UOXXTWfEJrAf5qcjRA0oZStZe6ZFfCce6UtoSzYVUXAEdBrhemnSdGd
 cNGM4DqlRNxByAbUIbSNICthSUZ+LsblP0nCqTB2HMtoabtSVF2wzWNW8CUgCE4BbB0L
 kzmg==
X-Gm-Message-State: AOJu0Yy8o61LsMWlrjxUDWTx/HUI3lOLoRWjIpqYSx5l+kSjlNlsVc9B
 h7lNN/Z8QE3lGPxDsOIGzvWmJDVQDBlAULydmhk8ug/y+QY5ZlxI8a29wiJjzKzTTYiHDygF69n
 RNGxOEoXjp4HXIKRl50OQuZMXDZ/WBlFyHSg95ED07TsZej/nJMqUZPg3kwbZyp8ihL9RyTA=
X-Gm-Gg: AR+sD11RV6FgjIxKs9fLLtfVM+4vLlNCJ66xz59MKbxlYHImUUeaUOccCRqBrGQbXdE
 ZzNRzJ7HKm6X34BgXj0TnaZA+B5seZKw0UfwIUv+6kHUl1VH12WWJjC1/jkcZtkbm/KuaCaYyuU
 JROiudxIZP4Ydiymh9BmwGwIdkwLzVX8Mqi41kNYjdSECru28GyRXBd3RFqofGnVgof3fffBtyW
 NPEgogSP32PFm+vvS7UMqbz8UaclpIapg8HRzi4/vaLbjNBbbkWXi+ZzZWwmGMAZ5dRTbMEyVEw
 Vt3ojqe1YrGlQKS1cI2sX5ZWAPib0FzbQnC8aJyNBn2SYlxOZyW/uYz1HXdpIkkSmrB+m6hqOyH
 AmRV1xzXMhDVk25+KZL06el/4fQ==
X-Received: by 2002:a17:902:f705:b0:2c8:1c05:16bb with SMTP id
 d9443c01a7336-2d015f01a51mr20354565ad.24.1785236979602; 
 Tue, 28 Jul 2026 04:09:39 -0700 (PDT)
X-Received: by 2002:a17:902:f705:b0:2c8:1c05:16bb with SMTP id
 d9443c01a7336-2d015f01a51mr20354335ad.24.1785236979254; 
 Tue, 28 Jul 2026 04:09:39 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde7bc4f4sm50292145ad.39.2026.07.28.04.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 04:09:38 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Tue, 28 Jul 2026 16:39:18 +0530
Subject: [PATCH v8 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260728-lt9611c-v7-v8-1-bda216bfaf37@oss.qualcomm.com>
References: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
In-Reply-To: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
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
 Mohit Dsor <mdsor@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5OCBTYWx0ZWRfX57qDqQjHuj3W
 SID2T52ek8I/aDoGlfyaF6+nA4q66O1BD+EcIL9aJ+Rf5gkMZtvJBA/0vuc6ZyObguwxiCvjA02
 ysAq3WOUQlr8enX0XZYO/H5pMtSaXBA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5OCBTYWx0ZWRfX5QDByaG4/3lR
 EB1uPA4xerQqWzbCTWtJiydYKZxM+oaGeQJbvFsQpmVmF1MSv/4oMIQHVgt+W8RatjeuxCMCa4g
 53QpWGXY4Kp8Vx32uxC/T3mIxCU1LrY4lBChbTtNL2CrbNwGReF3m+12b1GI+SQ87m99kp4PEPK
 q2d9L3KLPcOjT7GsZW4KqH9FQQ0/o60WrIN2X9+JkNt8fIYB9hSowkGVDB28Smy4pe0yI5LUlv/
 iHLKz1u82z0SIRbapqTZnYhjYMDlfeerRjH1wvSx9DVPnyd2RQtxUdW9quYJyPEFB2PlIitT+v8
 J8D8juF45Wmkbm6uF+IA5s4cBDwSzwcXk3Y0fgBTxsr+aikUc3pl+MosrXew+4DHJysGxMjLAOT
 Ic6PaAN5CnbinW0Z0iHaY8kfJw6w1bNw7x0ePnMhCJljNPXog2sa3wgdJD6ze+51TfF4W9EH24Y
 NQ9OASdV0hYJQMqo/Fw==
X-Authority-Analysis: v=2.4 cv=aa1RWxot c=1 sm=1 tr=0 ts=6a688df4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=gEfo2CItAAAA:8 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=dvh2RpXz9-UaKh2pYLIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: -d9R8FRDJcDGLd5EkXNUlUOoV2OoU7YQ
X-Proofpoint-ORIG-GUID: -d9R8FRDJcDGLd5EkXNUlUOoV2OoU7YQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280098
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

Signed-off-by: Sunyun Yang <syyang@lontium.com>
Signed-off-by: Mohit Dsor <mdsor@oss.qualcomm.com>
---
 .../devicetree/bindings/display/bridge/lontium,lt9611.yaml        | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
index 429a06057ae8..e0821a63d9d7 100644
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
+  The LT9611、LT9611UXC、LT9611C、LT9611EX and LT9611UXD
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

-- 
2.34.1

