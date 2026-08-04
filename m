Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F95C55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D761810EA1A;
	Tue,  4 Aug 2026 12:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JsDfSfMA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HKDc/W8S";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEBFD10EA2A
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:40:45 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674CXdOA3830683
 for <dri-devel@lists.freedesktop.org>; Tue, 4 Aug 2026 12:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O3sv1TXFds3gvAa+8gtPweNejRKPUVQ/df8YKZPqTho=; b=JsDfSfMAKusW8G+z
 K7FyPWTzZjc5xhF4Y5ShLPRxMNmyHzANfmHwc/ZDMlS4faoN576WSt8rNHPVyM4i
 SXmp2aUsJ2QNH20wdrOZIQfG92RkUlr4GfxL4tgRGKvvzL7kOyKdNyVCyduZYmpY
 KyyU8T38DZOxdGHOYpQsEs8eCNFLREtj8Fvee1hagcK6GM77cb+u/qs1QkGjCSB0
 PFBt9ZyfArLPEihGnDjLMpK9TmVmLjhvRVitpmVecboV8kTKHfcNVaKKJLB7Mt3W
 0W0+O9MkbYCcavp7xFSRSWjnQWGW9LIAS8i2lEUd1wYXhCyRzc1DeYRn8ON+aEIh
 yHfYjA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty5sc6t7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 12:40:44 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4a45997664aso6149461b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785847244; x=1786452044;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O3sv1TXFds3gvAa+8gtPweNejRKPUVQ/df8YKZPqTho=;
 b=HKDc/W8Sfz4gij6621xNuLKHcewgmBq0vttfkkYBQGWMVY9YAOQ8g94/fCYAsi6nIQ
 AjLmGhre5ozSo2WzqOGaW9e6UONSotfAGJGAt/b058CgjzORoWHkvbSw+lzduwASEzw6
 G85TBcVMcW0kyRAC4WlGGce9BlsEfPu0pA27ljo9idrtM9erMWrcsQZ86RlcgEthGvrn
 hrlvtB5YaqNzhnCZIva657KcpoABJNX+ae7dQXq5bgRIooWR6SPxrqWqdHcTs0T5NUVZ
 xLwJ2TqxETdpQ83okyoUFj0Hs8D/2TY5aO8sJS1SqTbxnPuBF5y/kQpfA2Sga5E4aglA
 sKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785847244; x=1786452044;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O3sv1TXFds3gvAa+8gtPweNejRKPUVQ/df8YKZPqTho=;
 b=jm1e9HKt/15ACIRjef0PhJCiCM+6BajJ78VILJWZv3lgAgK0nMFlQJzYOIodWlHW24
 LUMY3zh1x8TgxSOILuqWOdQtpM7RnyUzUti3kJ5dfPayYKD/sOiXGW73MDdvCKh34S77
 uAUBxpNsAHMKmreYQRVZF4OS9BYE56Dh0JaL3spW9ZSzOP2gqZynzJgUZDNDrcDMOR6t
 9MXnk+sfoCiqIH6rPVSsHPISj0ba8pf/mTSbPfANXFfhqgNBDW81Hy9chgf3jkZcG544
 9el5Ag6jvyHdM060HBgHKXViFMHVj0fTTJKC/fPxe1O5C4K0+A/Dnmns2JZvqan3lAcu
 CmJA==
X-Gm-Message-State: AOJu0YxCf9SKLt74SnOzR6sYnb5KxVKF4fkgXr3gJFdFuu0uTN13cZ/4
 IsDApWBXxgI4iW9hXqjeYgqJEYffMgldTNcxiKjrqETcwnQXw92AXHtvCIOITHtHAtD1AmUmqxD
 sl83/HwkE9dQeZbt8PT9e0JVnElZM3ivO1EVCKceRBI4wAJE5gtvKZ7u4Jeq8HaDaFfOp09U=
X-Gm-Gg: AR+sD11AfjZrXnKIAAxtfBvTWLmK2nEs2A7j/FGPhAmQBcm3ciw+SQKImVxMyV6aDpv
 bEqRY+CUu6rNI2CU8m7dsallXAAtW+s0+E2eSXoDHLG2cu9CA+nmboKR+PgPAbSR0moPwy6xdvW
 UFiYHbZhFsreYMzd3vW6DJEQaYZ7XHAb6rFE6+eOOHSd55qBn7E3IQwWEOglFSAihVC5YMWY3cp
 z8clSEjAJFYDJK7sCkhb1AsARROWTJ2j5VT4sDajjaegceVCb+jxt1+JAl85YNdc5EbMPCVJf7Y
 0pqiJK9FBAAYG9S+ZBSbfOnZ16xa1aeOTYyJVpQQrQWlinqt6IAxjhDA8J7qOgZut0/0w24DQ0W
 Ty5V9b6Bhb13MiZTrYsFX8ymBUw==
X-Received: by 2002:a05:6808:1795:b0:495:c607:b13d with SMTP id
 5614622812f47-4af5dfd1567mr18513449b6e.2.1785847243965; 
 Tue, 04 Aug 2026 05:40:43 -0700 (PDT)
X-Received: by 2002:a05:6808:1795:b0:495:c607:b13d with SMTP id
 5614622812f47-4af5dfd1567mr18513183b6e.2.1785847238702; 
 Tue, 04 Aug 2026 05:40:38 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58f7238bsm8204962b6e.18.2026.08.04.05.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 05:40:38 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Tue, 04 Aug 2026 18:10:14 +0530
Subject: [PATCH v9 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-lt9611c-v7-v9-1-3423a76856d3@oss.qualcomm.com>
References: <20260804-lt9611c-v7-v9-0-3423a76856d3@oss.qualcomm.com>
In-Reply-To: <20260804-lt9611c-v7-v9-0-3423a76856d3@oss.qualcomm.com>
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
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=SPJykuvH c=1 sm=1 tr=0 ts=6a71ddcc cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=A7cOQzBelK9jzjY8NncA:9 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: c7gst4xS-GXAQNXc14NUsbEDK0Qh3CGi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEwMCBTYWx0ZWRfX+9tLIVEU9+uU
 cUS5LRlvRRp6v8VgPJlo9lDL+iBIiETHJFvsMO9zhYD1674SPd2SeqbobydJiIvsPOfZJi79Brg
 80ax/jUo3c+rv3n8Lw8Kx94TMvvkzJmfJU9RFnSsHPQ0GW54UEeKwl/EtZg9bcDPg3bjXvRdrUh
 LBRSO/txzV1ip+XWTLojm/2X5b71obhfRgPPAncMUmnISth3c8vAaZP+Uinh5GKAEeIRlLvXru9
 4w8pp08IJ2L/OextvqEGbhO2LPEQlwjbVpy9I9NXBupq1PDMMuaJ9QV7S6d779MDieY88iHPLbC
 Crj1+4tM3I0PrrH84bHXjgmW+W9mdgzOzWLjY0u8YbMEnZsdlxOv0KGyegddVFhNMaraWlk/5qH
 GvZOPOyYygJxJ/QywlvYXUQwjeXikMdmq0nkYjp/UpVnQGpcFj22kuhA0JjGEF2irx+YflL7lti
 OjqXh7y+i3zwEuPbhWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEwMCBTYWx0ZWRfX6RcPQXHWRxmF
 yjBHpmZlVh5K3pxtOjFeMNo9oA3mJwPG+yKHu2pUhOCrss55AFJHoV4w+cESWqjBr3xwt5G6oRu
 B6JrzQyKSt2OjybDJI6z8wB+kZAMlpA=
X-Proofpoint-GUID: c7gst4xS-GXAQNXc14NUsbEDK0Qh3CGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040100
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

