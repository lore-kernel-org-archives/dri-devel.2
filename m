Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FD4C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 17:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC2510E57B;
	Fri,  4 Sep 2026 17:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="inya1+Uq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qm/nIoU3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B344C10E57B
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 17:29:43 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684HIAUU208815
 for <dri-devel@lists.freedesktop.org>; Fri, 4 Sep 2026 17:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nMeeDoM5kZU/bqV8HBx/kQzsngPCM+3poCWoyr7i+Wc=; b=inya1+UqMsJliKpr
 w+dFfqK1aasCj7jZifHiYaM9epQDYIZfPlOJ9avj/iSA1c1ya/JKtaMP0ztLn1EA
 TFRgguJLw40IAQ6fkxRWvEz3X1YPULLazXZWA2ybehn8jJ4w4gK14YyWpdJYIa7H
 4ucKFX4L4z4UlkDPg0chXvj50FhuoY0IWr0Et5WhkgDY2ZQTkonlfAntXUhdAAEv
 lI2yVxkE3+9waYaHOe7m0QwOR9sG91nVCj/8VdyX2JsBC3DkBaHZ/sx4S/nUhhOh
 /DucsJ1Gj22f3LiM2we7aDGBdCkAqlKBGIecEsoNWo65XYk0n2aUCkuoJW1NbQQ4
 CGSHCQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp783w2v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 17:29:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-396e5cc1846so286181a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788542981; x=1789147781;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nMeeDoM5kZU/bqV8HBx/kQzsngPCM+3poCWoyr7i+Wc=;
 b=Qm/nIoU3NAmH0wtbFhdlHoJTBMy/YdLHo5qhFchOkZlcQrCQ8dCWy5Cc+2K9P9Sq5R
 2fyR6dUZxzmz4Noilc50uUUMRzHhMg+ybN+quYG1xIkPGCQmUteNmzrCiutp8tCixca1
 ultAB4GzymYNJd1EPvXU44wtl8gat0L2gZHdqsEfQ/QT9seGKXituhFE62Pf7qDEfHYr
 dDntixcazLTtrgwvUoZhN1Pw2CJBJj3iqqq+43wOPu4VhHdNlNNSk4AS7sKrlq1xR5NI
 xHfPE/C4uD2/J1RLlL9XvZf6FYZrm7l+Zg1EqbQL/fkPqhBCy/pVGZpwNYt7w0dnWPOC
 BKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788542981; x=1789147781;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nMeeDoM5kZU/bqV8HBx/kQzsngPCM+3poCWoyr7i+Wc=;
 b=XPT9r2T0pGIeoUuRMi2kibDUGX8YOvjG16M3qr3wCouoefxUJXUvzCCjY7BGPImF6O
 ZXBGLQ2P//xTUfDFjyzZskQ5Q/SlTkODTVaOgotDyLNFNhurU5Kz5NFQca83uRdM89ed
 A4cU8Z377qiEQ3eu9/XWEevFD6xgD64tHqLfwv1XdjtANxpFCeqJ7uhq9RdRtA90zMZT
 dJwlWa/7fEAYwD8wMDuEj2jLMvSWbfpFv+oggSKTnSfQBYQy1nB1YtLcrqgRwWeShJdN
 9BgAC8XiKAuD4qq6OBZ43Rr1pt3e/A/Js2N2FclAZ2X7cv28RAY+yTIomwuT1ODhPNIc
 NebA==
X-Gm-Message-State: AFuF++m//jVDZhSV3qJIpdjUEZFqBA+UT2ngj25YuQP7kO2p8sbzbqIU
 v1HRaOvzQm1zVRhmh4ZynfyiX0rdC+nwUUC1hJoAqIDUEtU+YLnuQ5HGEQCxSPIbdbPXLfjvq1B
 302tlYxGwtN3kHDE1VfjWMgVC2PM4wrJvsnFwowCPR9QEeGm7fxRuiyiDAQuADjUSuDL+sl0=
X-Gm-Gg: AYBFou0jOmCdVy02QDBN48S/DzgMEWEY3pW2fBA68hYfHb2UGJ5WowTpyf9cEiYjZr5
 RtVyxe9kYQFuegpMlElPaqVHpdkXy4hgHIJxyT2xKXJeQfO9kDNK6zN6/fuPA6xLmwQGYBs7Vi3
 KkMAMc4EGKKR8bMNwuuIC59WNeASmzd0EXHyxbg/37I0FSo/S4+O6mev6N4vNzSDgit9uyE4JpH
 pwgjbswx3Gu792+tveGhAl1/C8ZosHOZOG+qNA1K3l/qRjmoUa2aiUKanv+g/Xzo9ukrrUCaZ7F
 Z6BY7+IcLrGfPxE/AnENCNGSsCx/JBubsGGes64LL0r085ZkkzGON6ktfA2K+WG/+jNteApr3qy
 lR+vgQ6bzGN2rV04NTPMbdgWUZFvIrlO3TNuSLJjcn1/Y6luqQWQC0V2i/oPuVVYNu0Ifid4U4s
 EuH1rxIbOn4YPOtHb1FiGl
X-Received: by 2002:a17:90b:1e04:b0:396:463e:2eeb with SMTP id
 98e67ed59e1d1-39b264b24e2mr7080384a91.0.1788542981164; 
 Fri, 04 Sep 2026 10:29:41 -0700 (PDT)
X-Received: by 2002:a17:90b:1e04:b0:396:463e:2eeb with SMTP id
 98e67ed59e1d1-39b264b24e2mr7080342a91.0.1788542980707; 
 Fri, 04 Sep 2026 10:29:40 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14324356931sm12396019c88.4.2026.09.04.10.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 10:29:40 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Date: Fri, 04 Sep 2026 22:59:21 +0530
Subject: [PATCH v8 1/2] dt-bindings: display: bridge: lontium,lt9211: Add
 lt9211c support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-add-lt9211c-bridge-v8-1-36d66168e176@oss.qualcomm.com>
References: <20260904-add-lt9211c-bridge-v8-0-36d66168e176@oss.qualcomm.com>
In-Reply-To: <20260904-add-lt9211c-bridge-v8-0-36d66168e176@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788542964; l=1545;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=7XMiXr7D3fC2Of65x2F+DhMxVAnk7abheQMCzBYJB9E=;
 b=kYhjbJfhi4tdf5UoHfJgq76far9xQsD3X5MeAsAZnleqmu4fUPtdapPrjfXwWRK0+aVjZlLwa
 g07Orgf2xqXC3UjbnwoncdZU6X7jFoBMm8eokQWf+KGd3Ypsenq9Ca9
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE1OSBTYWx0ZWRfXy6UWw7JHP4Jn
 6EWvZ472TW+QIipQ35658+ESEMOqg3yuqZPAJ+9zQG7GBkDFvJEYHQ0Llp9lxr/IvNNtG2+vyNV
 xCTK0vbqD35yJLsxtT4G3SG6M1g7lrE=
X-Proofpoint-ORIG-GUID: VHw3Orste5ON4gVbMg0hfYgaXuKHdJgR
X-Authority-Analysis: v=2.4 cv=ab5RWxot c=1 sm=1 tr=0 ts=6a9b0006 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=UcubZVdaWCKl6vSfqw4A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: VHw3Orste5ON4gVbMg0hfYgaXuKHdJgR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE1OSBTYWx0ZWRfXyex7kO/M48IB
 30EJ/U+jaC9jPH/zUtXGmvCqPMqENXo+qoLVMD+CQeKLjMd1zR4O4GtA6YmNfQNnzEuJRLEi7IJ
 fP+QLbXIjk3U0OQWpvIpLE4EiEhBJQ66mePZph/Ph5xyiqo5eZhiL4bvwM28V3BxCNW4Njv7TlX
 nQiVNIRil0485QiyVY4CVXl0K+ClXzzXWg7Gsh4zIRi8BogI7sM4QRdnrNgBxK3Ttqv0hzPLVZ7
 T5WO6wmllNuTLiI2/NXRjkfmLi/E7MhTUINOpMrpoxHj03gqFSVQm2/+fyy3WDvV8+lpcPHDwC6
 1GlZp8s9H+HJZjNjkopZkIogwZiZKWFxIz7I1dmfNmbCH7YBk4i49T5i29jledm25w4brW3U3oh
 ZPTLKNlhF/NdIbrQjtLxu2MWlC2NaizXTGTr/o8AEK8YyL+BvduB7keDGub+qfAN2anHCGcugeH
 /RSviNtMpm90W/phZSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040159
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

