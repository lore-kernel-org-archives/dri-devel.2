Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1248BCA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8164710E696;
	Wed,  7 Oct 2026 20:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="okbFaKgX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WEL9Kcn7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A5210E696
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 20:15:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697JNsc81650983
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 20:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=; b=okbFaKgXiY5tFYdV
 V5t5Zvwz9MMrzDnmoRjyuLQ44mbmeJZ82YdufuIJMYv4Traf1wQ/VhpUUhbi5LU/
 vbCkWQ4NDtMxk9dnq95ZE5LnL+E0VBVRTo/tlIWheaRXw741ad/7PjeuruP3rv+l
 e2UyEZidqMzfimkFbp6+r7exfItxXRK0kbivhvo7oMEbL+mQo/xc81A03I2QVOyn
 8RzArM/4iq4js3Hwc6NzzsN1MGLxlO5ZukhBsS2Tg9yPCU265KTFL2k0Bi2itZyo
 V3bVe3cpfAMDDCJ4VVrStGiXTAc7kpxPPMnXjkZ4zwdlOQeW3/QiIYZ/MWDb2hgk
 gfdU1A==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc5baau-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 20:15:58 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-151ba226e1bso6515268c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791404158; x=1792008958;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=WEL9Kcn7bs2EBHJofBYqGulFS5cXqFS5g9W4bnjTjv1iACATWv1kEviO9yOI5cp+8d
 q1HnhreQwZ9Ix8Yhr3yI+QXxXsADdpfso1lhDr8U5oi7sRN3opCGjVBOxWWGfxXa6l2/
 dZsEj4txgJ2NrJg6YvYfOYzQeB/0r6KSFsQFQWkRKCdRrhm34XzutXKh5R3v94WQN6TH
 at93I3MSL3eHzjACW+Gy0DfsXrdZyExMPpR6oBLB7H2q5KPNwOhUxEWxzAI6JPFo049/
 Sqe4BLVBeyfbTQUZB/R46vZyFZP8Lze4nlsgJUzdLLBH+rDvJwjFXYBrMLmZCFZv82QM
 QbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791404158; x=1792008958;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=P+sts9OzkS2Oc1gJr/rAl7y3r0eKcK6TujsQLiij9EuMNxQV+9+ltM8u36R2O93rks
 TgphtlQOAq4Cxm+HdGXs1dI+DCtbpD2YuXXbVwlXJ5X6A588ak+M6+mvQK2npaDy8C3Y
 guzePJrriwnMIYHxy+1Kg5JLRV32+mqxoN9ioME6uGh70/qecXLouI6fBiVunkgxhrhB
 r1BAn4ACdH2NTXIRRbNaEyU3bnD78NfjiaJU94fRXzoNFe1JFiicHNvigZf6vajkK4hY
 0RxYG44XHdHkgsH83oWxMOCVL+ujCxvlf8o8tlacoyKTxoSkloO4im579MfKU8rhlC1m
 LvLA==
X-Forwarded-Encrypted: i=1;
 AKwUvByRH7KKq3XsaFUCaLAJL7yMziMLoF+ounRmNVTLBDe2HUsHeIuMsQbOdZfnb3RaTBnkvwkHGScYpVc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kU51hQAq/6nXnvEheH9YNtZ8by2tK3VCIXOqR/K0c438cMmAJ5
 XHWsZVf8oLr8qs9Q2b4tucXuTqt/H0EJIw/zWXtclYoI+BB8vnjYHPOQJO6JFrxnss7WeYKFlSq
 tRcLAiB62yBQGE3tEktgBdjGMsiUOz1JQZzxW07BZ9bk/V6IX+WIrUueDo8vpuyelmD47WsM=
X-Gm-Gg: AYBFou0t9KblEKeJ8DprMWZPq7Q/z40t8SWUjEvyPnk+oEFT4yONbSzBuxBw6AE9562
 FoNyaR36LuOS8gzBobQ+FjrVwdHG5tEQ4DQETgdS9qYaM0Lzrxk4SRZ+w/8G/039w7ETUlOgaC1
 zqm1z8WqC6jLuceZbRmdHY/RaSpkDjaN1RnvC+JTIKokwyUe1RvmaHaqEEDnoSNK11JV+g6RZey
 /iVPDblyY9D6IJAiiuMjjljlFhEhGqnqNne95vvwhSsWzzUWJrGnnHgKGnBupu00LfUsVBY6MPM
 O+vWXUyUqt8LBxvQwrNTyyDMyiMM7M6NsXCS6L2EMYh668UJB701osi0SbTQNzNqm0rg6w0mUxs
 PC6slEJry/KIiADKdVaNc99Gb8A==
X-Received: by 2002:a05:701b:2312:b0:15c:20b8:796e with SMTP id
 a92af1059eb24-1620513f9afmr3182400c88.22.1791404157586; 
 Wed, 07 Oct 2026 13:15:57 -0700 (PDT)
X-Received: by 2002:a05:701b:2312:b0:15c:20b8:796e with SMTP id
 a92af1059eb24-1620513f9afmr3182324c88.22.1791404156209; 
 Wed, 07 Oct 2026 13:15:56 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16168f586f8sm10627380c88.13.2026.10.07.13.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 13:15:55 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Thu, 08 Oct 2026 01:45:17 +0530
Subject: [PATCH v17 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-lt9611c-v7-v17-1-1e8f5f2b2f19@oss.qualcomm.com>
References: <20261008-lt9611c-v7-v17-0-1e8f5f2b2f19@oss.qualcomm.com>
In-Reply-To: <20261008-lt9611c-v7-v17-0-1e8f5f2b2f19@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
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
Cc: Mohit Dsor <mohit.dsor@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Sunyun Yang <syyang@lontium.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791404141; l=2049;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=ut+CndQz/jrWa/IvwRM0rWOCvN47R5Wgsw+GSTdue28=;
 b=Xz3fTcEcug2JwD0kvv372xc3PpGQ6WmYvJi83xr9hB3oY1nVq4ZKJHXmkIiVmFch3uW2X5MmV
 i4XL2XhiBXnCmUSOuB1QFJNHpRZKU4VNRH64IBWZHKywbSFLyYdMchS
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4MCBTYWx0ZWRfX5MuMM4Z8oJyf
 Tn7wIB9C7JZWOBpm/+KMrj2Eb2J7hMT2gyUXlAMR2kTZe/G0em+txmNuadTMEvkHXX5lNvD+0c4
 8FkoHa2UHpbQe3C0VSfU7+K1t5J8nkU=
X-Proofpoint-GUID: qup3SzEHHwwDPFi8IfUbz8SAeHt7HlvV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4MCBTYWx0ZWRfXwimsrkwfZ6cV
 rMmQkP+nJNM6I++lZ6IramxRP6ZIrbIVRcZ9ukcB99aZxNWkWmwZ7nUvIPXrFUH8wZ9O6/JGUa2
 LuVyyBESqY6ecu23zZFeg3ap3mifgiz6YgJBfuqN07sYlWu5KUJvznmQ6f7WeRgNkZ/rbXz7S8n
 TQWl5EquDZssugn8A0P2nPzyx/A18QTmFF/ryGDPNnJeMwc4QI5v1am9OxWcxkPPuIFKiVlCoQW
 B70o5kYSzTZlcyKsOteTwoWBh9y9zFC9O1sgzgm6z6jPnyxPT4RxiEIEzIUbRHnv3AhgxK+a+Pv
 gWplLJ2X5DDgh16+lLxg2Q0oF47J9JO4hvbt0Am9GtmmgItTGFEwWW9AokuQukMAt/XixG6ok/g
 v/b/dx3cyPYrcawOVTjjM0ElJ6DFkse2DhA9OSZ15hwDVQBfpwpLLmw35Ww2LCZgRuPV5zY+Vt2
 z8lXFyy9LmIwnvnW77A==
X-Proofpoint-ORIG-GUID: qup3SzEHHwwDPFi8IfUbz8SAeHt7HlvV
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac6a87e cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=SdC2vBNBQt3qShdCGKMA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070080
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

