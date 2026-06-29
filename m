Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A8FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD9A10E4FE;
	Mon, 29 Jun 2026 15:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="RNeNIY8y";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209D110E2C6;
 Mon, 29 Jun 2026 15:48:00 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATKNC3000395; Mon, 29 Jun 2026 16:47:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=D
 ijOK/LXcfqczJQhyEEnk5RIdPK7dRxz0Uv6YYn+vmI=; b=RNeNIY8yoZj4j+ltA
 5GaJL0LZRMiU9Udl9A445Mqi2gY1JytjIowJSASUlTLcIaYBuRHKK57NphAG1N21
 A7smo9/f3kmka56QfTwHOQkmaRBCZFGvz2gcLchzimquhOl6glkGSV3KKUuMmWDY
 cajbMJpA2p+DdcmqHZvmUsUDXFcVVSMzfR0pB5zBei408MCuDmDc0L+SL0MUU109
 H5y9OvYl1CQxBqu1ft/wfVFctWKeiqs00CtYfG7B1M2SOIKBUNViuHWOReKZKR0R
 k20DsvURkhH7iOfZONW1VzoAXDHlHyDxCz70ZutXyQ1g6/oQDUf74JrdMs8k3gtE
 A335g==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f26kuj3rr-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 16:47:59 +0100 (BST)
Received: from [127.0.1.1] (172.25.6.219) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 29 Jun
 2026 16:47:50 +0100
From: Matt Coster <matt.coster@imgtec.com>
Date: Mon, 29 Jun 2026 16:47:30 +0100
Subject: [PATCH 2/2] dt-bindings: gpu: img,powervr-*: Remove Matt Coster as
 maintainer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260629-goodbye-v1-2-3bab53a80c53@imgtec.com>
References: <20260629-goodbye-v1-0-3bab53a80c53@imgtec.com>
In-Reply-To: <20260629-goodbye-v1-0-3bab53a80c53@imgtec.com>
To: <imagination@lists.freedesktop.org>
CC: Matt Coster <opensource@mtcoster.net>, Alessio Belle
 <alessio.belle@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=6YBVrSMUXze77+Xd/FL5lyc2twQbOub7RcX+7ZKQHSU=;
 b=owGbwMvMwCVWuUfy8817WRsYT6slMWQ5TV768r/3Vk2ZoMo7LTNlV7vPfqMTZdKgl/34wA/ZY
 H61gDP8HaUsDGJcDLJiiiw7VliuUPujpiVx41cxzBxWJpAhDFycAjARp6uMDCtO35xYWNQ6o1xW
 TEFrdq9DF8vZcs4FH2ucpp6oz7m3vp+RoYW1/LlmWeRRn2Xvzt1af9MmPGVOqcGhs0uq81sPOIo
 u4QAA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-Originating-IP: [172.25.6.219]
X-Authority-Analysis: v=2.4 cv=epXvCIpX c=1 sm=1 tr=0 ts=6a4293af cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=UteWFfMXGp8A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=gEfo2CItAAAA:8 a=r_1tXGB3AAAA:8 a=8QhHSuk9faHXqeo9-7sA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: Q10Qk_iM9ovGIHtbfURw8_mlCk8m8lPG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEzMSBTYWx0ZWRfX3vGlLiiSVy6P
 4GpCBHFWe8jQUOxZ5igqi2YEyKwhCHdCauq7vDhmKpwrLNnGYIq0teFEjiqVMxo/1JIizKBJU+6
 J0kqeWYMGhHBOvKhGA1pZeEs8enDlws57CghA+5hxFboviF6Jb4CW7ZnQ4J8jcrBgAkekK4VCKo
 X/kWZY6Msf/5L89CehGTp1Xvb8iiqZ1A6BA2vSv7o6mL7AalNTsSP7bopplnBqEQemCeFjKRNzy
 EeUhlL7iuLvrQSNw6hJJ1L2og1+MxSAiTyBQ9xuuBT2v5jO35yFqPnOZO/+k9bdXpvBXhJxHBlz
 PA3I5EYqyZZm1P3FvxR2HtoA6oaeZxNfUjo3/HJx8xDU/npTAR9Az0ww81wedEFxI2SLYJZQy30
 G3CB3NUioVO4UUB0LTRTy4Bfh/iKbDhNp/x3/tC53TnFhBN0W11q0SBK5lqUzhW6q5MNWQOf6pt
 DivJLr6FNJ3bET880Bg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEzMSBTYWx0ZWRfX/fyGBTSOF7Sx
 Ta5aREdNzQ7qhJQNxxSZKjpUhPSyFeX9jJ35J9C68bo6vwscNDgF4UbMTT0GV3p2TwyEqhU3gWG
 f3315imdxr4die+GuLWfuzw6wZPZd0o=
X-Proofpoint-GUID: Q10Qk_iM9ovGIHtbfURw8_mlCk8m8lPG
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

I'm leaving Imagination; remove myself as a maintainer. A separate patch
leaves a personal forwarding address in the .mailmap.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 1 -
 Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 91e4ff61b394..a6bccb600a57 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -8,7 +8,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Imagination Technologies PowerVR and IMG Rogue GPUs
 
 maintainers:
-  - Matt Coster <matt.coster@imgtec.com>
   - Alessio Belle <alessio.belle@imgtec.com>
   - Luigi Santivetti <luigi.santivetti@imgtec.com>
 
diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
index 3e7df7344430..58b799b8e96e 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
@@ -9,7 +9,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Imagination Technologies PowerVR SGX GPUs
 
 maintainers:
-  - Matt Coster <matt.coster@imgtec.com>
   - Alessio Belle <alessio.belle@imgtec.com>
   - Luigi Santivetti <luigi.santivetti@imgtec.com>
 

-- 
2.48.1

