Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43756CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F84D10EBF0;
	Wed, 10 Jun 2026 21:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IBsiYPpk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jZcSfmaR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC77310EBF0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:15 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJZWuH2559588
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 glU2Zdl+5BB7aU0+/FquWdehxVMdTHFFprBfn6zocTo=; b=IBsiYPpkEZwZ+rOY
 Do1J8o9pnk2OlrCyjHJSYl+R53TXzWXNWLRtpH0/Tld0+WFiEkIE6HJ95ieikDTy
 lZcqU8OJcNaWPqjqS49rwu735T4aqU3ESCghHLFwD5b3OFluX0X2SaSI8cIZi2Hd
 9FCipzGfE6lg/KsbFXrPimy/pLsXmsVAMCGZ4iOaqCMzmKZVuv+eipE0vQQPtzGu
 jIvHqNZfTwL+xeofHuarj2HBr2WX/aWra3/yzPkfZmw8hICibWpV20r/HKwwaKn6
 ngEHd13dutET/uzy2UzlRLKtaC2PRj8nJGD0XThh6QTYuVlCpI1COQPVvn4A8KNM
 AlmFdQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe71gfqx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36d97955899so6819119a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781126114; x=1781730914;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=glU2Zdl+5BB7aU0+/FquWdehxVMdTHFFprBfn6zocTo=;
 b=jZcSfmaRc4DYtCcIeHTtsnnW3XpWrN7Bn+bcb3ooGR4e+L9cSsDfPybPZAGTqLRbe8
 rsJuzODpw/wxJBPSfB91SqGIpBWiehcuS7ygIsqZrRDkzcD6bJGJctwD5QahNieAbwAL
 ceC/wyAUoBuPsH3AiqwpB/rrPqJvZRb/nOw7/lHh9Xg0FLWQBry5IOPmm3MINxUxI9fz
 3RdXCZSr6A6XWONAFCwy6PhwoxRO3wKE8dJ/WuxVXpRkjo35dybifigMXNoDGApz9cYZ
 7KHYBvH/VkakcI+QxkW64bWiw3KfL4ujS78RxWev+ccM4OuSKYk782IUo30f57DEvLFR
 gfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781126114; x=1781730914;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=glU2Zdl+5BB7aU0+/FquWdehxVMdTHFFprBfn6zocTo=;
 b=e22F6HFW0rC0ul78Z7CzmVmBxuIBtWzFNERde5lM7zJnxosB8jBxOKOwUmGrAyI2SK
 n84jIdxL8/DRc88W1XtdJC7QH1S2iedvDX0xPJcXEQaxcQxSS/S4fAaunp/tS97Fp23q
 dmTFN2i+rGNx9hIJzPINnto4P+w9qr8xWMrULr0klvlo7rbLMHVqSAnQBFbkYB3h4xHr
 c+DfwJ+BFQfv35xWQait3lUXsjSCzpjZEGcfsDQM5ytBGU5CBmwOud6ObiofjQ02sboH
 yGJeMc0ub8pdxCQentpz46JZ6pn2F8ycvidQkmMMTQ5TvA/HajivjcOjKuLY462WOS8s
 Z6pw==
X-Gm-Message-State: AOJu0Yw4pPbQ2Z+gpNVmbRE2pIqxmAkdG7a2Bm/WD9mn/04twGaOtftx
 f+ZqAkUu6iPKqHvGdhZTuatLvi/6oG8VzBtvbHuRdZ5X45TX6a5gTsbBK03P2jJc/GmXSrkZ0at
 vY52FxIAAaJysrbaQizUsIeS+tbg467grmJq4N/zMdvrxDcGtRhGUwNN8Yw36u24pxN5wFIE=
X-Gm-Gg: Acq92OEEiLq8tqwiDELJj7udtBkVvZdXZUgwzO+Td4yVDvyNMCZfoDi031eMPYu1TOJ
 l6lAqF6FWYv6L9NzLjdfk6gXGyqs0JdDdfJAv8iALMPwqxcZhkON4vWoRXl1SCFAHVcsOSUr/WU
 HJBH3jH2MJo45Cq57tLp5O27LQBSwjIPZ0L425bqRx2hzd8qA/lBBoYeRoEiWjk3k/PzyVj/54D
 FWLu2ZElaudQ1B+74ssapyuJT8KiqQKS8EEBXe4uf12b0h98ADWMVSJcuaN/JxP6pt8M4vgVpc0
 ZUdREUpNsjuE+PNb5aIuXqH/zEDz01JJfBFQ841eQftLq758YH2yw8JXezQuX3n8Ths3swy6zij
 mZuNQriPTczdNYqz0PEGpM2uTPEpAmAnp5+ucjxGqp4aAZff3xD3BsVRFnw==
X-Received: by 2002:a17:90b:2e08:b0:36d:a510:f908 with SMTP id
 98e67ed59e1d1-3751f35bddbmr10020890a91.5.1781126113599; 
 Wed, 10 Jun 2026 14:15:13 -0700 (PDT)
X-Received: by 2002:a17:90b:2e08:b0:36d:a510:f908 with SMTP id
 98e67ed59e1d1-3751f35bddbmr10020848a91.5.1781126113068; 
 Wed, 10 Jun 2026 14:15:13 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37753d01cc6sm309490a91.11.2026.06.10.14.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:15:12 -0700 (PDT)
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 02:44:56 +0530
Subject: [PATCH 1/4] dt-bindings: brige: lt9611c: add port-select property
 for LT9611C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-lt9611-b4-send-v1-1-42abbcd3bb1e@oss.qualcomm.com>
References: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
In-Reply-To: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 boss@oss.qualcomm.com, qc-display-maintainer@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: 0fcujL2xd9AIbqjs-pcZmXjwXT97kAv-
X-Proofpoint-GUID: 0fcujL2xd9AIbqjs-pcZmXjwXT97kAv-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwNCBTYWx0ZWRfXw4Uxrp2ciPaE
 u8Py1udqVz1NOfG07g3Gftp1S+j+0+qyN+wdXzbxuV5dKC5RhdXvRaDLw+Yn0NLEWEG35BZAess
 f8xdjeuEjpx+FvBYWVsiSFhT8/xPgFTJl5vpCj+K2o1X/g/o7r/Lyv5/6nqs5IarRy+cbUI3Jst
 OpyTcvh9xovYegQ/f2nvkDXuIzMNf0efJGB+k6QUwDZ/C6r0w15fMdxYAD+7rqZaeZHWtEAPqQk
 7vVfBH1BTDDsVRgzlXLdCaW2iOqpXv4bHZrqi8VjOV+wAzFHvQpH9iwVQnqrOWquRyCCmEz8foA
 BQ9H2zdUjax366v9sl2Dyz4j+yXswnls+pwmDlVB6fH98fsMj8KTgXyZHgw13VswGFlyqwHXPND
 OZ8zvunr5pcEKXck5Q6T8KZ/Mh81WTHxt2ZbTjgjWvuQbP57JCvULUAmlEdvRUB1BJmamckVP+3
 JNU0PZMtyS3rUV5SuAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwNCBTYWx0ZWRfX83Ru7iYKfuEJ
 2K4Z1uo3ktSUDEbMsj6hH3JwvKqeS4FcNX+OvTuLSXgFTU9p0oYMmfzQp61A5chzPQQJWz2EJJK
 56zU57Sv+vT0XX46EB6z8FiZDA6Sjbo=
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a29d3e2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=SIeAQ9iB8I19DNjXgjYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606100204
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

Add a new optional `lontium,port-select` property to describe the DSI
input port configuration for the LT9611C variant, which supports
single-port (A or B) and dual-port (A+B) operation.

This property allows explicitly selecting the active DSI input port(s):
  0 = port A (default)
  1 = port B
  2 = ports A and B (dual-port)

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 .../devicetree/bindings/display/bridge/lontium,lt9611.yaml  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
index e0821a63d9d7..77220f893bf8 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
@@ -41,6 +41,17 @@ properties:
   vcc-supply:
     description: Regulator for 3.3V IO power.
 
+  lontium,port-select:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 0
+    description: |
+      Selects which DSI input port(s) the bridge uses. Only relevant for
+      the lontium,lt9611c compatible.
+        0 = PORT_SELECT_A  - single DSI port A (default)
+        1 = PORT_SELECT_B  - single DSI port B
+        2 = PORT_SELECT_AB - dual DSI ports A and B
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -104,6 +115,8 @@ examples:
         vdd-supply = <&lt9611_1v8>;
         vcc-supply = <&lt9611_3v3>;
 
+        lontium,port-select = <1>;
+
         ports {
           #address-cells = <1>;
           #size-cells = <0>;

-- 
2.34.1

