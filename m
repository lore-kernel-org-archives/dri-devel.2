Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4111BC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7839F10F687;
	Thu, 24 Sep 2026 15:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L4Vx5238";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NIE7PafW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC0A10F68E
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:59:36 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OFegDn1907518
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nMeeDoM5kZU/bqV8HBx/kQzsngPCM+3poCWoyr7i+Wc=; b=L4Vx5238ZyCbLj0K
 QipZ+sAtiwv90BdLKTQ2HH92/VFEeZeLqYKpbMpwdGLYsesdymqXVGOTxBjFxdXJ
 ESrq8w1bEQ3C9+eR48MJtpXtRVEbv/EQSsc6kgBwoR24a1geVI/NN4u7PeFxegz5
 c+fM062PsFd1CfVP1gZsOkKvpW73dFbNNn5pu2VO7h1BB1EUlMSUAlnlcCl8dybK
 XlxVPjvMYtPdqPgvT+9c1VwJdcR0CURGCYc3J92fOBpK93IdLW1HSLX9xbyWgts1
 rEMRE6WrZ6KNSsRFWGz2a1KeZP9tUoFsSMaLu04IHz4COPtz8o26NhWAYfg7wUGO
 EOUYKA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1t7se79-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:59:34 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-67116384f6aso12519d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790265574; x=1790870374;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nMeeDoM5kZU/bqV8HBx/kQzsngPCM+3poCWoyr7i+Wc=;
 b=NIE7PafWN/6mxVoVsYVtmG2ggv8dKXTlvlXK3WZV4qGMfLVl6pcs7IXAiDVTed383p
 HaruF+uLf8shzTqC3xwZ2xWhZ4Zt5sIvM7m5Hh4HdGjhkTcK1tYk5xjS+trB30D2ktCI
 PA4ado9CPFQYkzzhpRFKOyWlWZNkttWwggHiJVEwGzNSUsf8v3XIO9j80Wy5UgPjhdo1
 4C+pIOtIMUCFB+JLytp1ekS6iWaU3l6/e1QqmnYQpj+dbbVaC8GUktTCtdMtXw/8ghQ7
 DK2Lj9h28WbhAgyXUHIgSYiJqZ0jhYiaLE0wJMkyjwnEekCtGpFG56OtsYkkGFjCm+gy
 eFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790265574; x=1790870374;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nMeeDoM5kZU/bqV8HBx/kQzsngPCM+3poCWoyr7i+Wc=;
 b=2UVyHsoSQS93wv7H2wHtdOp/AwOycKPw8f0JwOeWM0aZfSPp8nnM6tkg/GLv6G7hC0
 yGFeBmpp3YaadZXHkc/pQOxPaQ9TXjzyHkkFN2AkSUjI7svxSMsIdxgioTHtS13Zb+pC
 9PPGVSl/uFj5MB1dHu76qXNhfJ9KztmW4VHOMDdewsndE2mkYezPpd6ISEWLQLK4ElYP
 MLVjJqsKwBYfCYYBIuWz/SaHa6ViI1rYy7gb7thE1Gj6ih4ZpeDME6Ci4gJNdvwBSyBK
 l1V6SuzUpVOmQVdn6fvtwLLR7DA6rNU/Y0wTMjc0ZzlpgcVy5P4NFjzAYT0ZapAfpJVY
 m/Qw==
X-Gm-Message-State: AFuF++kKwnM/gJ9HmCuJJsqEcwenBJhOhnmi7b24n1zId+WEpmgzhg7i
 Mx40US3KD2+2tSuevHjwWIl9UclTWOPTVtaOsOzizqNC1MuCZ2CN5adk998uzsVapcmhYBH2KLZ
 sz6bW/lY4xvw2jU1Y0ShnbToHva4oihLTaHk7vSQx+3Z/DxApYlwps2Z0KRHfuMvPO8umvsw=
X-Gm-Gg: AYBFou0R9s3Vr2u1V7VdH15GywX2yzMKIobQ9O2PTi6R9Nq+oqXxIICZ+NrsHZW9y2n
 aTPAtvW3DiPQiNXPMXYop5xSxzpf+FRLik6CP2UjAym58C4tqflprylX5EcjAfgU//7uGYICg8h
 om//tFmtrbWm/uCNlTSR4fXEbzZmRQ4+fbnQMSGEPJE4z7FwKBYppGC2QId9763Y9rdhPPD56zo
 znDbwe/NkyJW4cSYooRcYxRtsZvraZPm6eaAmZQPdkoOJYvbViXRc1bBCd5WYBlLl5za6Ok5S41
 Fw0Xfk/T3tUffzPul/b/c52Do3F3WXHlizgwqpBfdca0638bUIHm3nqHfnRGZOtycUNpLmTOEH7
 d7Hz9th48UClByhWF+CTRwO9DiRD/JvcrlXzxKhxpLJiTnO5bekZg91v7Dck3j7c7a94VptQWaD
 Yw9dzHLaeUq56DKqmH0X1N
X-Received: by 2002:a53:bd4e:0:b0:671:1256:56f2 with SMTP id
 956f58d0204a3-672ece3f118mr1991409d50.0.1790265574335; 
 Thu, 24 Sep 2026 08:59:34 -0700 (PDT)
X-Received: by 2002:a53:bd4e:0:b0:671:1256:56f2 with SMTP id
 956f58d0204a3-672ece3f118mr1991386d50.0.1790265573893; 
 Thu, 24 Sep 2026 08:59:33 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d81e102asm2271003d50.19.2026.09.24.08.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 08:59:33 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Date: Thu, 24 Sep 2026 21:29:10 +0530
Subject: [PATCH v9 1/2] dt-bindings: display: bridge: lontium,lt9211: Add
 lt9211c support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-add-lt9211c-bridge-v9-1-d78b39677a61@oss.qualcomm.com>
References: <20260924-add-lt9211c-bridge-v9-0-d78b39677a61@oss.qualcomm.com>
In-Reply-To: <20260924-add-lt9211c-bridge-v9-0-d78b39677a61@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yi Zhang <zhanyi@qti.qualcomm.com>,
 Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790265554; l=1545;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=7XMiXr7D3fC2Of65x2F+DhMxVAnk7abheQMCzBYJB9E=;
 b=hEeFDcepPc6JFQoICcwq7lno6RBFKeTfIcn1bnp+3lE4885PlNlYhbqK5Pn7DeS4NvFmTpvmr
 7zcnS/3EDKDDJKytCQK1aa9uvp6JMXmxLiA8E4NeEPYD3ZQhTlSx+q0
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-GUID: 2bjD8xaPCBKd8IO6CLW3o4ToewVPQFki
X-Authority-Analysis: v=2.4 cv=U/MHnuru c=1 sm=1 tr=0 ts=6ab548e6 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=UcubZVdaWCKl6vSfqw4A:9
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NSBTYWx0ZWRfX4vXEEJR13vZK
 1cb6wHpuOOapKuLLTYANDB00PTVuDqvSW9O7MBW0u664ffVZuHokC01ReW51GrTeaIvTENT/HuM
 sk2gBdswdDy3sQF/gSslbuHOAwGvee77VJ+oGjmf8RLGglbgaJ6hIh8A8N3RfS4UiRQsU8etaSt
 H5t7t/gkcTz0TnWki/wA+8bQuIwGc7ueNTEbjVGzCNVOol287jiQpyi1DpakoEmpqoFHSOeukxU
 s2uXSVLk2wW0x2QuemU/eErMxBvcPg5JIGRhm0spkuaJz/O2mbQlTKSPEW8mkd9tVMLV4mcMok3
 Vzkbe09n1D6QaSrYb5ghXcdUknV6kXeLVUSWvCh1J54CCt7ubowYim2j4vK4WO0xGzODc1mwzZr
 moPxuN0yJ7NdUnWCCGAHw1+pRl03CWHIaFBF10JPiPIosJVa8g9LDHx6BOg8HOoM3R8VpqcUaey
 jiqh06dBBD8Fecsu6gA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NSBTYWx0ZWRfX7LeQOpOVPf3/
 YZN8ErqnE9oxxTfW4t84fuFhWq+mv05K736PosjNE6EA12gG5OLNZQ1FpLQNbC4aEEGR7uXYIF7
 gT39PdpRgNrVpy0HXMr85Aa9eO/2/pU=
X-Proofpoint-ORIG-GUID: 2bjD8xaPCBKd8IO6CLW3o4ToewVPQFki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240065
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

From: Yi Zhang <zhanyi@qti.qualcomm.com>

Add binding for the Lontium LT9211C bridge chip.

Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
index 7cfe92a8bcd7..de61bda09db9 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
@@ -4,19 +4,20 @@
 $id: http://devicetree.org/schemas/display/bridge/lontium,lt9211.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Lontium LT9211 DSI/LVDS/DPI to DSI/LVDS/DPI bridge.
+title: Lontium LT9211/LT9211C DSI/LVDS/DPI to DSI/LVDS/DPI bridge.
 
 maintainers:
   - Marek Vasut <marex@denx.de>
 
 description: |
-  The LT9211 are bridge devices which convert Single/Dual-Link DSI/LVDS
+  The LT9211 and LT9211C are bridge devices which convert Single/Dual-Link DSI/LVDS
   or Single DPI to Single/Dual-Link DSI/LVDS or Single DPI.
 
 properties:
   compatible:
     enum:
       - lontium,lt9211
+      - lontium,lt9211c
 
   reg:
     maxItems: 1

-- 
2.34.1

