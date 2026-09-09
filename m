Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C31C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF23B10F06D;
	Wed,  9 Sep 2026 09:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8u6g5Fn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L0XRYDz9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A54710F06D
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:40:55 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6896BLk81274463
 for <dri-devel@lists.freedesktop.org>; Wed, 9 Sep 2026 09:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=; b=P8u6g5Fna+xdaoG1
 1zetweKKwfz/m9PXotDa1trmaHCdi1jp6rEljhmnjS3qi8HFZmsbHLL61QmSg6SU
 QFl5NaGoJzyREUuHrq98XI3tS3OMyPuf5LrFCZ5PHKGperRoXIJ1YYfKSmrhkr1B
 xTzTqPr7GUTJP0hxj5j+RKTFtjPnyHggJCHdgUNshqOQHz6abDqle5Liej1qCC1z
 WQoFPHstQo16cXozehVj3evMrE2qlOHBPuQn8n7gC8qzWNpWN42zIdeQ/JaL+Ecw
 8GxCp9kbyLnOuFjxcZ0eFkEAtxQEnMNO1LpO6e7ry6/NVa5Z6I6B31kL303w52Oz
 9YlFfQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqdw3e8u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 09:40:54 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc435388657so4036483a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788946854; x=1789551654;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=L0XRYDz9ajWhHLnmVJZ1Y7NHZW+Yhh1XeruWqB0fCUD+CtYIvF7tPXGjoirbiEnSwj
 rQG4Yz+MzjApS8rFdxKWpwmBRV5Eg04bEgiDUICN3UaHv73hdJ86b01Lq6JhyqlQG2R0
 TmxaWI6zqwh0+7VKCyCgvNvclluYKeBXqime06k828eQ4gFxxQrhjAmCTrzbb4XjT0IA
 x43kpk7BCU41NKQyQX4U/YOXa4zku4cHxaPdYOAXxh+ccCMHay+tte2c8G/vmCd/2u8L
 whRHr3YG5m0XheBro27amlCgQ+X2FLq4XMu9XbY6zLrKOBXIQvDt+TV/iI8koNYMUDhP
 J8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788946854; x=1789551654;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=I8iA/NIE/Le+RTxLbp3p15k635JjlEX290DAhmHDMT94HtMsrcRPvjHjnlZvbgz7sj
 0yKElt7iFZfI/VzjxSmf2ZRkIDEQ4fAOn+nAZwHz1TaeyOBWO3XkGwBlcVaF4G0naP3l
 SgQ38aaWy3FbV6kTyiI6SwmEPZeMat30b3SOvAmmjMjSK0r10/9isMqWDS5r5p5VNNrn
 hzRuy/lCJ2XkhiaJtldPxmktv/+KtW7JUKBQ2hx3RgSG0lXGSgbtE2ln+VWcCHQeYST9
 nXqWJejoyXvzr96tfK4kSTGFjyCPkSra/P7QgfT9iiYNXFLKY5lp5d+W3PdVX6fqEjsA
 Z2pQ==
X-Gm-Message-State: AFuF++lGTQVT6qHxIYW1Kx2Cw2129KsbvUMfetfzSk8vi30QgPi8zlMx
 qzSmOwdtTXXyex1TG4PswZx2r7DD4eR84kbsxgMGq/GjzKrUWhPfLKmEVQHKLBcAhU+968G2QXZ
 2jHxJ1hlYeVQp0ffcKMiR/U5IgWG05VhsW/M4D/vKEJmnlEzA+PugBGUzvx9DyTfddETXQcQ=
X-Gm-Gg: AYBFou1NW8fvOb+51Df3zzJPBMts/ydOPQX9gcoa8TPSlyk8S+kJun/5VHKEI3Ccjm7
 QoU21vZPOIzzGRqTa2Q3WLc2V6tY8udvyFQWqJrIuP+rg9yaYIMuG/+ofbdmmIExwpndYh0I5oA
 nIspXAquBId65PQ8UZuBXFfyqOuUXolkwlVrXlW6L+irKjeO7fNhdtYzEUMFquC01OrPEYz4o+D
 M6zi7XWtdGZ2Tz2Incgnjs5rVYvF57rNwGa/b8fcDY8gYpz9f38AuAStTGgxC7SsAqIDJHm/Uq+
 i8b7lO+iXudkK7pdvkvLOmvt8e3QPGWwGEO7LkzaFxn5YsAo46UZkrA9jVmgixCwkCXupQjV4pL
 3B+aSp2PDH1az0WV2BFwgUJD9HA==
X-Received: by 2002:a17:90b:2e0c:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-39b26169b1fmr51191011a91.11.1788946854011; 
 Wed, 09 Sep 2026 02:40:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2e0c:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-39b26169b1fmr51190960a91.11.1788946853579; 
 Wed, 09 Sep 2026 02:40:53 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3342af0bc08sm42929198eec.17.2026.09.09.02.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 02:40:52 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Wed, 09 Sep 2026 15:10:32 +0530
Subject: [PATCH v13 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-lt9611c-v7-v13-1-aec234483725@oss.qualcomm.com>
References: <20260909-lt9611c-v7-v13-0-aec234483725@oss.qualcomm.com>
In-Reply-To: <20260909-lt9611c-v7-v13-0-aec234483725@oss.qualcomm.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788946835; l=2049;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=ut+CndQz/jrWa/IvwRM0rWOCvN47R5Wgsw+GSTdue28=;
 b=1Zrm1DWc9VDm4EiTRoPkODjI+IN+ghKTwjeCXg9g5LbLQ6g4pHs6BACxqX5PTZXz1RuR1CItp
 7UF5lIJV6uKC8ckskVI0aBQBp0KanSM6SdRVh+n1d6MbRfufVYmXbU+
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Proofpoint-ORIG-GUID: zJEr9xKoF-8OFa-pbWeycB2Vl9Ohtyu3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwNyBTYWx0ZWRfX3bcn1HkUuBAk
 kBvL7fLHz1/EeACNvmH+7QQjyi3vVP36T4biBmwJ4ALsxNgTnjQpDCkPFfILkFicDU7+HS/ZRX8
 949+415R0lC9RQWSmuE47BNXFajtCwc=
X-Proofpoint-GUID: zJEr9xKoF-8OFa-pbWeycB2Vl9Ohtyu3
X-Authority-Analysis: v=2.4 cv=Bo2tB4X5 c=1 sm=1 tr=0 ts=6aa129a6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=gEfo2CItAAAA:8 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=SdC2vBNBQt3qShdCGKMA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwNyBTYWx0ZWRfX/UA/cX9uNC7d
 p6csEHzjYh1fXrKI1NS8ZtzOM7Z0iTZiQ1qQkMBSnOMoWMu4+FD+Zr013w/GbhRGheLiAhVVrjT
 YhBQnD1oOL0Xyn7gtIPnmop61yJH64+Tzw641RbcLdTCN5EugPI8SHDc0swDFoKm2G+MJNpgX5R
 lhGym+49h4l4dDvoWzLTEOo9zsfpRjeQkKevavqkzw11TPIK0FeQeGdWbgBdn26yxnnkkg1l5CE
 mEzrjuZn05Vosg9/mhSqMcaBWGRmfrvSOYMbMg+0SdEK50+i3on88dIpCDcUi2bd3XWtRsBZHti
 ZdRUwv2CIBUOnZ9ZCB7IeaFfcuqPnvnL7+UiInwes+q5i65cGrHLboO6o+d0T/pSZO4afqLxpVe
 gJfZbF1lOHc9XxULndJsBiXGAACNpLgl3PICN/mrqJJLZIHsH5LdPKfw7kvrtWKI91rwXOy9liE
 dB4mBsURQ/FQ0V6fMlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090107
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

