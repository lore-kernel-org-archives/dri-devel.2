Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27FDCA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED9E10E452;
	Wed,  7 Oct 2026 11:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R8y/tst5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BRi1JqaR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B77610E452
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 11:38:14 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BV7NG3687343
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 11:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cbMzmwWaBO70zBSqQ/eHNfR6dBbEZw3DRlvo6abDoF0=; b=R8y/tst5xDAb7+uN
 5evKUt2hHCiP/Ez2SOi4tvh9TOw8DmBEsJVy7sdJ8PSHkPY+Dd3DQMOhJ8h3FHE+
 gxhwM/FesRSOv8crZsJuyvPoe9QSj8O1j8YOVsFrc5dV9HQv+QzaFGKG8oxgHTmn
 /6TUDOG0cZiLB76XVslpNDeUy7uMv1KDkuUgXPmuIXTTOAS3WlPgRqwbeXe4/Zay
 YuqayptvA/zBdXhkLmp/8oRa8o0bES259p4f6l9rK1/hl0vqhui5anu5Xg6gwpDN
 dM+PktZ/tkztt00XkMeKQMyrNA0f4zcf94wINDoTvrFrloN9rIjPHp9OgsmKvuPQ
 xKDmCQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5mgr8665-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 11:38:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a4aa263a4aso4048652a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 04:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791373092; x=1791977892;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cbMzmwWaBO70zBSqQ/eHNfR6dBbEZw3DRlvo6abDoF0=;
 b=BRi1JqaRB3ze4UbZ3PXJsQR8Q9oKWYhW7KezD8e7egjJZ7pKQVIZvh5NRZaKAE8RJK
 B7Mos34sGOsAcj3oxEp0C0VuXuceTp/l0Ash4IhC5DRkeJ60XDdWpuFae/JAdTkIv0ti
 cRkgIaH/MJ02v5mEmH7HNfkQBntFQkC/CYD7pUY/B0j2m5xjz77YBQoM6BNCJ+xF7xZo
 GYiIem2s3EgngEC170DVesa7MPE1tfnxXHc0YrXiUVglb4g+7UX8fd7hVhDbYX0Pcb1d
 miyZU/sGy+cqNswAzcfJR35dyiA1Tv7RVqDgOhlQFIYgL2EEF+fOZIXwtA5TXKCKgqvh
 RQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791373092; x=1791977892;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cbMzmwWaBO70zBSqQ/eHNfR6dBbEZw3DRlvo6abDoF0=;
 b=UVCHrWMP5gpr9ZKL0e1C5jYdqa3c1CExu3ip/GBtAAJcwM2e+c647VnQhfdNIUXs9B
 U0F0wAQumX92nPFevzwtDxoljvxW5VYeHtuBTN/FA15DTbPHk0+ay0LbhPq6N4LLC+lK
 +tz7g9YYJUMctG8B1J1J8Vn1wjRTp6n2ePfYFfdWu2c977HIhMmyXbuufpJ0Cp0evGeN
 /LUjm5/dSCz9zcgBL4DXDxY/k5XQ9pr0YqNu7AuQIcfb3uY16fuOJBsbsYlKws13zLak
 1BzuYjw7PSy80XPVL/G+hEPZdpmaJRu6pg4KdSJGZwDOB7xK/iLAwiyuA8g3SyFsiHWM
 OsaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYt5H7OlF9RQen9M19KOvXzQbGOu4cbjuq8MIztMYvwcT8GVQ4GrZ+0mFojUMQes7CHmxobXBNHZM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIQleWU74FtcTlfKO8yub5w5EsWzy8/KW7CBQ3GQBBJZ+dsO4Xk
 HGiKWbdOETd/cXb+gmRnV4TGWt4Ww+ThyQOIbE8Q4r17nM8eANWlAJB5BCMqpgvBXrr8j6ADVNY
 np+1u55+BOFJKG0yA87U4cHVzRbZkLN9y5qTDT5hcQJU4e5yy6MfK2aqzUUTGD2GAQqnN5mg=
X-Gm-Gg: AYBFou1J4st7eHO0y4YDqZaQleEtZ2IiEzcBv8qf8uRocDgxmEoRmCTJiv6V6xh/9DG
 LNOYh1lJ9LaM+GtC6Yqh9LI9VPkMkrwj6GCZjKlX18TRtMelO73nmhTQeaX+4gwW6bDNpaMghKI
 mwBz+x4z4sIcrqYrTxTp4yP+VByUFOr5qTkL9g5WKVDRXgyOcUPo2nQvNzXSHXYDt7qZVLUiays
 y2xgnLolQr8PCldd3DyD3+1XKXmfIkjOCg1aPrPpDcTZyMHeRxdehLS4fO/Am0NUaGEV+09sf0u
 Sy0iBUddTuRUcNsWG2mLeaemhaLBZiVnce+UuxvIMCgvPMTGLnPHvzf05pzBX+UuZtNsww5o3XK
 DXVfImE0+D/nUyH25z+AxD/qqyK9ypLc3
X-Received: by 2002:a17:90b:3810:b0:3a8:92a3:8baa with SMTP id
 98e67ed59e1d1-3a8a1ac0576mr1503976a91.27.1791373092300; 
 Wed, 07 Oct 2026 04:38:12 -0700 (PDT)
X-Received: by 2002:a17:90b:3810:b0:3a8:92a3:8baa with SMTP id
 98e67ed59e1d1-3a8a1ac0576mr1503945a91.27.1791373091681; 
 Wed, 07 Oct 2026 04:38:11 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8a5e0eeb6sm1454001a91.2.2026.10.07.04.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 04:38:11 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 17:07:48 +0530
Subject: [PATCH v2 1/4] dt-bindings: misc: qcom,fastrpc: add iommu-ranges
 support for context bank
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-extended-mapping-v2-1-5dca3aa2c2d3@oss.qualcomm.com>
References: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
In-Reply-To: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791373080; l=1504;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=DQ9EWfGPZKBvqgp9iN4lMDE2hFQ8EQVewPUivJN4wLE=;
 b=GV1ceQclqogtYmo10/6T4mCwskpqqXIPQeE7GCWzFuSg+BY3H8rik8OVHxlOofeI7rsa4U/aG
 ZaNYfBp253+CdVa99pZaoaV18JjUpdyY9D4enQFCBlmwss+njwFv6UG
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX94RfXLEqsnnJ
 14sQUadhm2hK4MpjeV1aJw1R3wkGgJ22ZY0hbz4sO/hux6XQMQR6yAP4f5pwdmbsI9D4K5GaBol
 VaeiTkdyOby0KvIHiebK3sicWwszM7qo6uQqTfj+S3j6fTiV3HbOkrM4wEBc7b8sqzmHcy3eh8b
 xdI/fBqO5X6HPgRTYw2kosLJ0h3NJSa5Va+A11Yj8HvLIS1o7zihhBzHLpUfEJ8MUWsnJSA8F2b
 wxUeGzk9CBWJnJiuZ3BEMmi7H8yG8u0d06mC62HtazUewvp60V7NGaX4EY+HIjCEe3ptycmhwSY
 SizK2qiPsMcYJLZnNsRaBHxlRfyQHSvCvENHdLMPeP6yp2UOuHS2ZbUzNRXgwrRs2NG60N8D33J
 g6Ztr04GhYnCLCV7R0FjL4RdfMUvJeha1iNnAcD32lmJ0cG7YUZ9LslZXXLy9LyUPi7nfMrUGpt
 /+MewcDNCSLaZLI7ntA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX1vhj53PwdVM1
 C95L9YMDmMAKQ7ww3gs0bkEgsjQZc15AnqUTGwOVg4LFTCoDpZTYnVgi6ubBOlF31ww0mj2KNcY
 aqUz2TrwyyXfpIYix3uz58kVnvDkeJY=
X-Proofpoint-ORIG-GUID: uRTKkJe6MLMJIpLcUXosK-4wmw_oLjh_
X-Proofpoint-GUID: uRTKkJe6MLMJIpLcUXosK-4wmw_oLjh_
X-Authority-Analysis: v=2.4 cv=OYkNnRTY c=1 sm=1 tr=0 ts=6ac62f25 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=OJl0ziJC5c_Yx6648RIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046
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

The driver uses the presence of iommu-ranges on a context bank node to
identify it as dedicated for extended IOVA mapping. iommu-ranges lists
the IOVA ranges the IOMMU allocator may use for that device; any range
not listed is left unused.

Add iommu-ranges to the compute-cb subnode properties so the DT
validator accepts it on context bank nodes.

Relax #address-cells to enum: [1, 2] and #size-cells to enum: [0, 2] to
allow platforms that require 64-bit values in iommu-ranges to pass
binding validation.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index e945c8ba75e3..f4ca9a767255 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -73,10 +73,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
   "#address-cells":
-    const: 1
+    enum: [1, 2]
 
   "#size-cells":
-    const: 0
+    enum: [0, 2]
 
 patternProperties:
   "(compute-)?cb@[0-9]*$":
@@ -98,6 +98,8 @@ patternProperties:
         minItems: 1
         maxItems: 10
 
+      iommu-ranges: true
+
       qcom,nsessions:
         $ref: /schemas/types.yaml#/definitions/uint32
         default: 1

-- 
2.34.1

