Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC32C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6905210E772;
	Thu, 16 Jul 2026 11:31:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPQeft2n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H1dl+t5t";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E6E10E772
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:31:26 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G9rGLB2471859
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qdty0teDUjB0kKLUtuopZ2iQJL6GNrf6xRC6X0ENeCU=; b=hPQeft2nOTPnkp0b
 tWC45ca7/aFy/Dopm6euuaBmSvweITXvi00B8XDSZgpaOuKCr7vtY7itTRJjlkSJ
 bBsa4hL5BYF/+Ls3Y2P9/2lJD0uIliXYtq0F/NupYe1gTpe+gc+6ycABMgW6Z0IN
 xG+xKLbMHF6gqa9NW+diq4GsxxuCQY28OU17jntT9aa6jYtw5KAzQbHHnKyTjZdC
 Mr3V5Qn4Hz22XIBnHIy0GwJLltLf2TgRQT79gSQdKMsPXoGWoGxdKGT4RG/Ja0ES
 xpEOM0N1gqM/LgiDyQLydcN001Zvy9Pn0OjBU89P7EVQVTg2HnwBevZsFBtYPGsc
 qY02ZA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fen4wa6db-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:31:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so9101702a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 04:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784201486; x=1784806286;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qdty0teDUjB0kKLUtuopZ2iQJL6GNrf6xRC6X0ENeCU=;
 b=H1dl+t5thq+DHIh2dHH/HKJjw2ccv+jv4oBPI6GIa0zv/J+ES3F5QErTBSl+Ye/sQR
 ZoV8VUUkxsBVYW/gUfrn30HaRtuc4sgMva3Ic9ZXRG5bdkzA+vBq2Oe1wkIfEA0hS1II
 hkFS7szz0QQfFSzKzzmKSzgQdfAMa1lp7akjV3cHg+eIxqy8PlYqmZAdXf+m4CNGgTpp
 Gm0SE8T8OQ4v80FcZzEsy4wf5jzW6fzEfcJuUwmZvcToJ0/tHeq2St57Kw8gmfzFx3yK
 FvvXlQ3DDVJ/7s4CFmo2+ANbHq6fcPZ/mjCXy8kNeor8PsIUtUzLzO2UtlxrIBb2DP7M
 vBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784201486; x=1784806286;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qdty0teDUjB0kKLUtuopZ2iQJL6GNrf6xRC6X0ENeCU=;
 b=rJRxGqI8ANWL+F0wnspuzEMKHr69JJVk2xp/Cdos1yHYLN3+jNxphWFcJ5RY2V/AFo
 aqrE6/Gvse6PnnEglBnJbnRauZYvDq1/WiANyg7eM/HI92wrpJIqnqper85cbjFDdmsW
 s3Tes4n5h/EGKwvNC6RxNqnUzgC0QLnVaXPn0eh4epxDwCowWCaZcLgIf1ZPq1oMyQ8L
 fCm3rNPBnKogYQ2uC/qCby9e0jIJRwXf0yC+yBu/E3fhmOdlhkteLxHXdPMiHs4u6OwU
 O6ufBLrUTJP2qORBV8CoCQMX4KTKXrhqkgSQoQ6xZjyp2+ZE7Fo05rV06U019eoYzx+N
 oBHw==
X-Gm-Message-State: AOJu0YwsNMndbyVBeeya3zZzTN4PUUBMG8A13RGeAph7DGCn3e/Mz+fX
 QWMWcF0YCZaxXmI3XwAA3g40UtzzShxOdf0UNlV4JDAse0EKOLZeDNeSlp7WDJYMl50a56wgC/Y
 omUyu60+ISDsmIOjQBTf28ekzdetcwBnnX877WInylreKuS4SwBv798Fw6KWEmqMN2RwzWAg=
X-Gm-Gg: AfdE7ckqITKHmsZom7xXEe1XgOuoLzX/RouBrbBxzcY+qisD2NRU1cWqw5unUvbMfnv
 fdVtOOh7heM+381aHDDdnMwaDbvIPzC1WvQ87xPn4CxnCb90iQgB8dQNZt7tgHrTzt44TTi4wS+
 jqNNq/WNqyuU8xf6TdWFr/YbNnqgyG85s5Udto4T0f88jrmqQnelBC8SAyy8JnOFtclZnsLzLQj
 k+WvXFiJ64JQeiLlu23Qknk0ih9lyrmm8x7RGqh7QWPTKUNO2YfwKGh66aQeeDAzKqdML4ID6gf
 mpbhS0S/j3v5CjdBUrR4yF+WJKrrzf7YRmNmRqc4HSgWJb8MVQKKUR5Adod6twszHaDVyLxMu+E
 yetVzmdFe1hn5YBB9mTFOBuyANg==
X-Received: by 2002:a17:90b:2e0e:b0:38e:11ba:992e with SMTP id
 98e67ed59e1d1-38e2a06c078mr5841340a91.35.1784201485679; 
 Thu, 16 Jul 2026 04:31:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2e0e:b0:38e:11ba:992e with SMTP id
 98e67ed59e1d1-38e2a06c078mr5841285a91.35.1784201485145; 
 Thu, 16 Jul 2026 04:31:25 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6f0dcdsm9720262eec.31.2026.07.16.04.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 04:31:24 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Thu, 16 Jul 2026 17:01:09 +0530
Subject: [PATCH v7 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260716-lt9611c-v7-v7-1-7553a14735fc@oss.qualcomm.com>
References: <20260716-lt9611c-v7-v7-0-7553a14735fc@oss.qualcomm.com>
In-Reply-To: <20260716-lt9611c-v7-v7-0-7553a14735fc@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=PsejqQM3 c=1 sm=1 tr=0 ts=6a58c10e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=dvh2RpXz9-UaKh2pYLIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: _llyUF2k-zBNJ9IYy4Is5hctoYmn1T16
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDExOCBTYWx0ZWRfX3YbZcwE1oxW8
 IvPB5YojKX0L9WkW4UH09P7jQ6QLIkBU15WqdrJyEHMyady8Kj7UX0TEr4pZoWT5MrPxjZaRk8Z
 603jGQB8ctnYvbDHXxQtrgErRHUyj08=
X-Proofpoint-ORIG-GUID: _llyUF2k-zBNJ9IYy4Is5hctoYmn1T16
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDExOCBTYWx0ZWRfXxygV42TgP7Ei
 D2GXufUIVrU1NS/+GliklDdboM0XVDTTrXqeO6Xp+JmjSadyV4RFyyJ0t8bevpwDHiBb4x3tMQp
 6SA58/fvgcxQoMEhImgcaD49VCf5nLqDOBoWKDq4uHZH1utjEoRbDuYCfbYVJdBhNTd/y5H/c+a
 Pjop+Ohvauu37fMZzcx1MOhqnivPHeuyGIqUghatW8Sa4ktsszpr6YckvVWU74UOBwdArKS1h2r
 tlhlnbK9mGnNdRKJ/3GXwJCxJdptD5G3CI+dIBFaVcfd3uWPqUOrhRktTfzCUlj0Kkh+ePSWGa2
 jFJHgYz9tMIrgume9T590T69qUoWzVgbzCqAK3msnHUvirMTzo7M42efVDggZC6MmXxgdHOWsbZ
 OzO5IOS0BepVeLvB0fjsZ/kCcFUJqaY2Vri+w67BXXs7vxQK+BVjgIHvWo4FGkOBybav7BM+g1+
 3RjYLoQynSXFO8zJ1PA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160118
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

