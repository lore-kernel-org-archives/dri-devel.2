Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BD5C44521
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72BE610E05C;
	Sun, 19 Jul 2026 16:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZFq78QpF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eBJtHyBU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CBE510E05C
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 16:08:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JDwDer3543377
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 16:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=b9HBBlmunR9lfyZiinpzds
 QJIbq3Fu17PZFWAaYhEwk=; b=ZFq78QpFXh8cPiLzhvbxPg6xaa3vFngtNhtmp/
 Dez4dNkNui34P7VwJkl6OQa7lUxxX5owhK7jYVJ8ZZ3xqpKCY+5D5tvxqRwEUxY5
 7mnEsYxlMW/bW25OgQWwz7NX46mfDwCUnfpw5YD/FDa+LVjVyFPumezT4ab+ahU0
 oAde67m6dbS9HE2okHwAHMn4xAYPX0Kt7TTBq5UxXa57COb7OZKmqNykyP1RW0GN
 XzQU35nsP7Uaotm3wf60j8jhndkKyQbcexaWeWCan2roU2lWfs5TMHHd4QZZ6eF0
 cBXcaqFCqUu+SRiZxhabFbWK/4rnk2dV/gtfDuVy6+inLe6g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7tyha-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 16:08:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cf2308ef97so8223005ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784477325; x=1785082125;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b9HBBlmunR9lfyZiinpzdsQJIbq3Fu17PZFWAaYhEwk=;
 b=eBJtHyBUYGgeyE0iBl+k6vEGXzyzPNaXg3TbNvsz8P8pu8uXqSlLmlch0TtgFYElwa
 eCZZaFMfugS6bd49PYfNqVukudgmOm9s0I9evTRqWLAWbiZuZ/ZtiS4/rZSGLlYG+SS0
 TcMTf9x2IvmsRCx/432jgOv2wtDUAtHWKXE6royE9l0qYq56yHEB2Kj53Pn6G6pkrCsi
 hmKR/t8qjPdkaWDoQeQkEv8wZk3WT00en5uJ0yFYgYDF8VUyXr/sc9O6ym0Gz8sIpfjp
 ViVa4iyx0kD3GCZru1ekPyMTccvGQ/Lp8F7/KMnsLZ+XROHG3deGNEypql8WkAOz8+BZ
 NxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784477325; x=1785082125;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b9HBBlmunR9lfyZiinpzdsQJIbq3Fu17PZFWAaYhEwk=;
 b=sTCd7DkTFcDfKz0s86wlC/wLcjNOXSK7N6CW5spVq3IaplZzOw90ImUdUUU0elLXoX
 TIIC7FSnkvwl6LBJr78rRjNW+GZbZoi1K1sv50O1PyGKhmnveb0st5fFvDnpC2IReM2n
 5HLjw1hdRHSe/dWixU9RfLAQPZPw4O/7N+JP2O7dHyeQ1YfqzGcP3JMfYws4shCIpVrF
 5JqTkPi9OxFJ+I46H5gKe3MLZQojj70Y3uZOeqgenCAIbKuIZQjyIlYN2VI91g7pCX0b
 6ZtFyyGDF8rhRSo/ImHblRu2jNAZyrT4fekb3FwkNN+9ZWEhhbBpb4tEDQ0g6e6s/foB
 D0Mw==
X-Gm-Message-State: AOJu0YzveYYB5bs7Ylcdz3mCyRKYaPR4NbbZoy7+wd7ZveYu9YNsGSzL
 nnV+Z0t4a8kfkib32QmQZjpgzEm6Vf1bMoSNJkVZ3YqQX3PwDutpDDLbZbIClSscEmCf+w/Z2HK
 n6YGe/PBoRALLMnyl4yQEmCih7IiO8Pd59hEUo1qkMpAsepEl4Hap4QX3Gg23kss4y5dqPIg=
X-Gm-Gg: AfdE7cmGwcltXhN1aYxKPUp/1ICoZquQeFkNV8MVjnK8U3uBrwC/oFYOmuxJ0ezUnxD
 1/cLFg5DASvQ4QDjOch03RwsrT+xgxi7l7lFTJ3p6wA3z/cY5djKBAENKHkexp8+tNfraYOJXB8
 Fx9NxYid8vE4wZN8sCjske9vaTMM/Fn2xhrFQxTCR+kLtEBCi2umlrhj7NoKyvg7Czk9HHT59PK
 Tt33IjKDOQZFI870cbOhbcUDwngyTn3MJrpuQpJCautmdok7vsyhHwjzImXUHMMss+m0WngR1CG
 9fK0cO4JQd6c0e21RVJppZsqCjGNuf1V3+LoPc/1WE01X34D2OtQWUx6fHrePcX2j+7xl/ENlVL
 KN/qjtbzsK+e14XiV55bLxyz/JyeTbagjf/CSza5mtBe4rs9/ejeVdBlvHwuHfxZDV8zxDj4No+
 NWuRRx22ny2H41VPaDhdBA
X-Received: by 2002:a17:903:1a84:b0:2cc:e648:7e0c with SMTP id
 d9443c01a7336-2cf34a310a0mr93399235ad.7.1784477324811; 
 Sun, 19 Jul 2026 09:08:44 -0700 (PDT)
X-Received: by 2002:a17:903:1a84:b0:2cc:e648:7e0c with SMTP id
 d9443c01a7336-2cf34a310a0mr93398925ad.7.1784477324306; 
 Sun, 19 Jul 2026 09:08:44 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2900a37sm22285199c88.0.2026.07.19.09.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 09:08:43 -0700 (PDT)
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Date: Sun, 19 Jul 2026 21:38:36 +0530
Subject: [PATCH] dt-bindings: display: panel-lvds: Add boe,dv215fhm-r01
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-b4-lvds-panel-doc-v1-1-6a18c213c2f6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIP2XGoC/x3MywqAIBBA0V+JWTdg9qJ+JVr4mGogVBQkCP89a
 XkW976QKDIlWJsXImVO7F1F1zZgLuVOQrbVIIWcxNwtqAe8s00YlKMbrTdo9Ch6M2glNUHtQqS
 Dn/+57aV84eEEeGMAAAA=
X-Change-ID: 20260719-b4-lvds-panel-doc-cb503c4ba2be
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784477318; l=1994;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=bp5/WqpWPLQgy2pXRRsH7ccX72vtmxF9z0GVNhvfBrA=;
 b=3bMWpFZrQHB5QjA+biDYkLxUYMywl4LFwZz2AC+u/HTPjis87uhxze2KQt7PLBQrx0erTFGgU
 G8tqMl04kGLANzjHUfJ4eYPOk+KwEAekTmTy4WBoz91JsLCOjWHG1IS
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDE3OCBTYWx0ZWRfX9Be59bvX/bNh
 zyFMbwl94rOL68Ei6zpF6FqtKgn6x9xK29hyWhwcOe2fpXu+tJSWIoVlNSNezHV7iFwPHTZ72qN
 92UvcmNhGmrUPsvBYhLjp/B8G4xfSFo11xNLdKMwbHMCwzKXq+av7x4PfQ00T8AjM258UOU6uuc
 1JGs9dbBG45Gtgauxy5Op4T128f9sr1SXyb5LdWhrHbSyt2lVmqttOx9qwpJd4SFeqyEVdjDjBL
 WGr0tvF251UVs3F5XD2FuRXTrfmG0laDxpdtIUT68WUmenxt1/cS0bEGKQ/fjZXHiOp+HNMwGT1
 NQTh/HUM9/tP3KegHIOmKsDN8mCEeNfT2mZsxekNHWtbWk27yfYJ8HBMMkLjRBJG4/x3kfVIebC
 paqo4wE0dzn9KJTEWebD9cE7bSHuAbLR2Jv1ADMExNkwqbEv2LOE7PiPtLBkIZ35GwvtojzHyni
 VRWZges4UPj9oGvfgVA==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5cf68d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=mkfg1YK7THWIfyNcHdIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: PZ0WJdOVf_VWGRrJDfNe7kGIH2b_mU3L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDE3OCBTYWx0ZWRfX4TSAWiK51yWi
 dwdFxUf7G47jIqSh+av+e4w/X1jmjY99a6fwWmZANPfh7d+9gYZo21ddnx7T9HgwXAs1WZcqgsN
 lMiNgjYjSd6ycsFW3JWU55/cN3DKb7w=
X-Proofpoint-GUID: PZ0WJdOVf_VWGRrJDfNe7kGIH2b_mU3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190178
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

Add BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
compatible string to the panel-lvds binding.

Also remove the 'port' requirement from the required list to allow
dual-channel LVDS panels to use the 'ports' graph topology with
separate port@0 (odd pixels) and port@1 (even pixels) nodes, as
required by the dual-LVDS binding.

Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
 .../devicetree/bindings/display/panel/panel-lvds.yaml          | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index b89f86bc0683..584818b2df6e 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -58,6 +58,8 @@ properties:
           - hydis,hv070wx2-1e0
           # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT LCD LVDS panel
           - jenson,bl-jt60050-01a
+          # BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
+          - boe,dv215fhm-r01
           # Riverdi RVT101HVLNWC00 10.1" WXGA (1280x800) TFT LCD LVDS panel
           - riverdi,rvt101hvlnwc00
           # Riverdi RVT70HSLNWCA0 7.0" WSVGA (1024x600) TFT LCD LVDS panel
@@ -72,6 +74,12 @@ properties:
 
       - const: panel-lvds
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description:
+      For dual-channel LVDS panels, use 'ports' with port@0 for odd pixels
+      and port@1 for even pixels instead of the single 'port' property.
+
 unevaluatedProperties: false
 
 required:
@@ -80,6 +88,4 @@ required:
   - width-mm
   - height-mm
   - panel-timing
-  - port
-
 ...

---
base-commit: 104c00917264c5b9571072471e3a8689cd1a2c4d
change-id: 20260719-b4-lvds-panel-doc-cb503c4ba2be

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

