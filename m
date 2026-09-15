Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58B4C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0242510F491;
	Tue, 15 Sep 2026 12:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DXR+c/Nk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UYqsRirj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6843710F491
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:34:15 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F9hPxA3742102
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=; b=DXR+c/NkTVTzGySv
 K85gvrkKea5T+0Rsz0qACMz0ple9+iYwbNAb0O/h+UnNmoUf0C3OSqyAxcMJYF1J
 L+hCZpJvC2Et8rdpSBm9zZ8/jVysadIv6pLi8vcEwqo+XBoSYmIq/ndoXVXngn1b
 ACh8rCD8r6dhkrI6vY2oLIDCJwhbuHnjxeSYTehmfsDMhdprvb/nNQndZvOYaUeD
 fUOmdXrYYQStdrs0S59cpereVClilrb3PzNzlrLH/n42SzlY+hSZs9FeYhdEmFFa
 8LRPQiPzANq9+XhnzomR9dQqOkzmtVfv8RJlnZ1YCy4PyxsZNlLw4QVGE1xXES/C
 Kz0SCA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyux1rcd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:34:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8710450f731so848426b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789475653; x=1790080453;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=UYqsRirjfacnmJFWJnZi2N9u1dcgcs6S8CTXK6wPV35aRcCmCwEKPjn0+27t/F0W2A
 MZ/tB9zU+TupS/fSQ7VGBgjhZwIYxIJSdOr9ieokGwvoGzdB1tg1bmy3hvi3cSrMdV8t
 DBQOy7sfiF+GhWvdQnvTQfQ9VW8Yf+O3Mjrc2eMsFtGCMHVkNXfJSQRrIgSYAajDG6+y
 Dh/XGhJQk1j7/DlrBu+s13CihPEVhkXYGmqh9tSnVxWNS7sjBp7lWLAFVVt8m7ZB4Qbr
 +DLL+0VGFD7NLBp+JNTzPc10eH51TmNG31emAE8/dTcYyYdNnOsnbPzse9dMgvXbAXcG
 Gofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789475653; x=1790080453;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=KBwGTxsLjeD/W6ODrLrGqnADYHW+Dse/pG/C88uh9hyOZVHdcuooddbXwTjvD4VG8T
 BPuc1AOq1yOUP1D3c5ll/40DXA+vUnWK/WU7zVutDhGnP+K0Q5ek5lYmHWZQtkfuFHpW
 OJhyDCLUx14ILuro9JdvCKPzdQoorh1sSlaGto0VhYcedAM1IR+Citw2fJg9o0ihBdYH
 zkfRtCcGczICGDaqBahSjglyLCyXPMBzsizZx7zmjPx35tIbDZ2fpjJVIXBbc/hf0v3l
 0z7iJYhnS0gxh2pubmhAY6Le/THxsTIrGi44e1W2MvBdv8xmucoLeKYScRH6e2A3g4G5
 GnxQ==
X-Gm-Message-State: AFuF++n+mWSTv3n4QAVk6E9J/Epuu6lYXvof9Dcivtnw6CV7GgDAYh+t
 Rzv1oUmwPAw7dEsLyrU4/oVh5Qgh76SlWoM/KCy5ucZVPx1UkIiEpXQeeVXbd3+9Cw6eYoFFo5c
 aAwZlHCLuvj5IYGsffy9+UQjhWQLG/mkxeZC+rzgVm54g/KIxGMedQt+hwMkWcFH+fRIG4dc=
X-Gm-Gg: AYBFou2lrVcgraQJleK1aqTzcvGceuz+6ec99vAWZHLdXHN3ayXWgl4tUtHGEKKOOTD
 Yj3xfN9IJreQQsyhjAaHcVsp6zKZ+Ty2ohWmEPN56x+9ZbzEq6GjiRocfWKxIaPKuzOgbKKgmDJ
 U8G5ddOPtM5WR4Zyf/sS3TKeFjTf6oOs0Xr6dnJu5LzzCIgHVGyGNrqERcimUXuKg8BVqITh/t9
 f3CXQFTBfdtHWlLShXF1lIYWeF9AVlcEOIKXz8P6kdUi4/AvWV18Y9keSy5XSdydzWf5k9TWeW5
 XF8FlhtblEDJjWtPlfpfI4LBrF4vHw9yho+cjkQVYDfTcck3RCh1X9MYNPmOdQHuIaIg+k97q4m
 MArQLBeov8hWV1wXtqtELpoF3Bw==
X-Received: by 2002:a05:6a00:2e9a:b0:857:727c:a1f1 with SMTP id
 d2e1a72fcca58-87180de6625mr1343353b3a.19.1789475653277; 
 Tue, 15 Sep 2026 05:34:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9a:b0:857:727c:a1f1 with SMTP id
 d2e1a72fcca58-87180de6625mr1343249b3a.19.1789475652642; 
 Tue, 15 Sep 2026 05:34:12 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b287c481asm6509975b3a.11.2026.09.15.05.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:34:12 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Tue, 15 Sep 2026 18:03:50 +0530
Subject: [PATCH v15 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-lt9611c-v7-v15-1-88f9e9387eab@oss.qualcomm.com>
References: <20260915-lt9611c-v7-v15-0-88f9e9387eab@oss.qualcomm.com>
In-Reply-To: <20260915-lt9611c-v7-v15-0-88f9e9387eab@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789475639; l=2049;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=ut+CndQz/jrWa/IvwRM0rWOCvN47R5Wgsw+GSTdue28=;
 b=IAPO8LsTqDXbz6623zZAU4eY+YP8m1qcI6DLsM0OMc2Fy0L17AW7/y2t6XnOGW6s1jOqrjQRE
 MQI6XXwG9DuC5xHPZi98Luh5eDhpPazd1zQVhr1qqaExOIWwOTGilKS
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE4MiBTYWx0ZWRfX2qHOwQLP4+ZH
 l+ywUGIxHq8QPoyzjeKCeDXl9mjxSLSEU8mkm4a6FGsbrSEsnxmL9fD9+YuS3J3OLyIeLtOx71M
 XkUxdUouUrG62QNGBcSoQQwiX3LYrFS3XFPtObXDVdCjdmDVCftPS60lnATRSQ8i2kfjcIJxcnl
 wW9G9jwCX3uFkRwEDrlAe3/xOzUvAfFhQzt8vkZEKi4rHuK+81BtfnMzHyxpzhJa4jRnW5bWtLP
 acQxMWnrC2WLlG/HnbaNEGJXaj3l+5UMdikbctylpZaI12agdmgI9xtHolRfUGkEjP+Y6xJryUB
 SNC3yKc3w5FupRvvNpLyCqTCdJhA9G1mRsfIpImKwzew5fvDnIjE/WR79uJGTs4Y4Hd/dhG0F2w
 AxDmvfgEzDWDSTHs6YK5K9PgcOt6oUzH9t/Goy4/IjGH9tKVcsegFiNjyvFjnH4irYjaXc6l2Av
 4LZHXt408c4Lk3d5OMg==
X-Proofpoint-ORIG-GUID: rS7eFUJv6kzJMvbQ8Wab7l_IatFX0fNO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE4MiBTYWx0ZWRfXxqaz607oPGYy
 pD90Xos9gDVHgBYFMALxImUWXdFGFvRvqExiWX5SC/3qd03u2Rwb9i/hQJbq//njEXBu8TCt8bw
 AJLsXTAUO11U1nJdikH2OOubUgEZrxM=
X-Proofpoint-GUID: rS7eFUJv6kzJMvbQ8Wab7l_IatFX0fNO
X-Authority-Analysis: v=2.4 cv=QYLzLcbv c=1 sm=1 tr=0 ts=6aa93b46 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=SdC2vBNBQt3qShdCGKMA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150182
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

