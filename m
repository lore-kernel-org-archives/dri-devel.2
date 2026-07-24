Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A7AC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAD510E028;
	Fri, 24 Jul 2026 08:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AU/3rh5M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fDuu2S2n";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EBF010E028
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:57:04 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lbpY2125326
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=uY9uni8DTsA+d0nJwe4VSgTG9ecNhKhf3SZ
 5YEfrVf8=; b=AU/3rh5MIlTkbR4RMxO7rHPnflCK/iTZXjU2Ysf0Gs1pYnivCxM
 h56IlvmzNfhOoW3a7DPnsconuHvFjfieROSfubRXF8bFJ9IKMOoxZAz4H8oQWYbd
 D+pVh3ZYEA56q/I2jxoA0jGXUzRgmd/jA61p3u3A38JupT2Rf9gTWuhQSOtUobqy
 iB+x/1EC3hQtteBCI37Q1XPo8FbSPE+Cf//tu3lfw+YYhrrzmgw0tkmohuhVkGly
 opX0OESFwyGAa537pyLc8Hs9iL/F19yWu+sNh8754wFPDIqSV5h0KjoytS3YZ9Wg
 vUlT0/CUTyOQRzWNpfFbS5vRlccqsSUH47A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqamtwn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:57:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c860544c077so489515a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 01:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784883422; x=1785488222;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uY9uni8DTsA+d0nJwe4VSgTG9ecNhKhf3SZ5YEfrVf8=;
 b=fDuu2S2ntW+aGppIi5vU3R5t4Cjo0qYR9q05gxMAo30+kvTCspKZ5FPosYicdBDXIp
 zS99jo9tmJLv95fCWfLH8t9SyfTPl2GEyGWtDsnLS4EaBAPvvC+jMDZpMJULcTH9wu4K
 xEqHvPARtrHFW4WhXzFUmCjNhVdvso0sp2p3BJrrLOk3B0tOn/LXJ+RKygJr4sDS8yaY
 Y4cir5/e1mFIYcA2ny6NN7YnlMI+WRmQMCNQkVAJGtQu3n1PAFjHiLLkq2kp0nHyMmTX
 lQ1Cg6DnTKVTSxXJCtM9+bEZhCDOKu4os3PyED8kchwf3r1+vWAaMmQoXfxsqZFx3CpU
 IagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784883422; x=1785488222;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uY9uni8DTsA+d0nJwe4VSgTG9ecNhKhf3SZ5YEfrVf8=;
 b=Vh+ShfA3BUFSqfsT7p1ZrzNSXNv+btJ5+xskILoTMEnE9VzRoQ2qG+SYQlOLxBebwK
 L3q5kbc4reLiHKWkvRMzSARZVVGeygrZXsjSuT9blk3Pr7RVNJq0sqCplHMeYSc2cnmW
 vIEUBf1lyp9JyNDHcIKNFNA+3Q95Xe4Xx0gMQdSEjYDebDPdhQ0e8gGfffr3OWVSsBTM
 uvIQeBb6tboS+I7a41EfcWCytYU4zRamSssE16G/8wDz9NSMBUfpX+y1MetMVv9J+rAt
 Lnl3InXU+sH5orJcce5Mf7WS/j5vMal55V35eONpOcq4N+KD4TG42luGwAMEmoc/tX5O
 BD7A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqxn1cfavguKDprW2ixPukH5uUHRPKaHrWX2Gqdz/JwkRAlLFe3iLqN4d/cZwXcsOpuEN4cO1TuenA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQTgrGM08p/k9Vdo753h+SAd62a80qTtro8U9+IG3UOKo2iBDA
 dItPGplrjLqGYs1XF2JfivuWn4x83nSjRMQpFaZK7lcJc37vwZvvHPVsUmaKzwvOmULv8cr3HyC
 0SqzehBjB+2AL12LMvzJNLzC92rJ/hAd2uVwQMryaySo27UJCn7e6kTd+EoG6fkqsGGojeMo=
X-Gm-Gg: AR+sD12uM4FZ/sna31nLZRrdhBHJf/j2Ee1KUtIslT3jq0e68cLNGYKoAwEi53p3+e5
 U7E6xtV8oQXfzwMUxk5ZHcyOs9kKoTjqMlYfHwFBtg1PPvX+JoQ+jKa0rqo+FUCBxWaogSTH1NC
 ba8I+ZIWEoIiaIEl09FerZoTcPQweGlJOQxnxhcjHAa6zm5Wjx3u3tXDUoQJFSntHSe4EkB0SZK
 u4HH1+vf2S2+x8e39DL9L3owX5wbgteSUQmLoJakMyh92FPMKReXpINe1YxFZRzMGrvPoBOifjJ
 vogpO0ZWaIrPdcSFMywFWtVUQ0w53DW34qSs7I3gk1aLW4RUWUqSnkcNJHRaAurBpvtLhBybvdP
 nNB9pli13wUYRGEI/NbcwoYhim5RR3Ivr8KoHYQY1AklB29/VTDtdzNaW3zi4
X-Received: by 2002:a05:6a21:7002:b0:3c3:6528:c87 with SMTP id
 adf61e73a8af0-3c44afb5083mr7791392637.1.1784883422464; 
 Fri, 24 Jul 2026 01:57:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:7002:b0:3c3:6528:c87 with SMTP id
 adf61e73a8af0-3c44afb5083mr7791366637.1.1784883422090; 
 Fri, 24 Jul 2026 01:57:02 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com.
 [199.106.103.52]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e070538sm27742661eec.20.2026.07.24.01.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 01:57:01 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2] dt-bindings: misc: qcom,fastrpc: Document Nord FastRPC
Date: Fri, 24 Jul 2026 16:56:50 +0800
Message-ID: <20260724085650.224899-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4MSBTYWx0ZWRfXyw4VrkkW1poC
 vdCtq04jTBUDHLs7XmlBeB7V8Kg/bq1uQtPZQ3NHFV9Q45BRZaUiVDqdJkRfyO8YTHKpPm5pBZP
 UdHlAAL2D1bEpy10ugHWTEnr0xHIQQM+lb5t6PPeKZ2HdwkbUw1Jq20eaFDPAWOto2c28I8ZCnb
 3dt7YHnTCdKL87R4PUfMU9hISGuxyfu/AyklfNJLzpxiH1+NwdYwDFUQoL2D5EEeOacCOGaqQak
 los/5CirNggJ7WbzJdMlK5sx0j04Dk8hiAPAQUgE3w7Zpkar2kNJIbkJUeTp+n8S9bcRXVjIlFc
 evqznHf1Uwd1wXY5SDstzlao7EjY+J5y4KOABhnCzIoFo36iavcjV7rUcBGZqNR+C9D5zr/Fdr5
 nfwUxkQJmZUyMGxVXXwvi6WSi84oWzxBkKsepv2htVgA05o1bs1SCz6tps9qPtwfCrYpWZUobKl
 bzZGLcg0kmiEBGqJq1g==
X-Proofpoint-GUID: HUmyQl68SJMpJucSRbhNzjnvRxdE-Clq
X-Authority-Analysis: v=2.4 cv=DfAnbPtW c=1 sm=1 tr=0 ts=6a6328df cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hLNpwyK-Jy1qmYTIU6kA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4MSBTYWx0ZWRfXzKXDIfl2CMvQ
 vILWACJg/rSB/Jn6pX8f/h/D78xF42qGLjU6j3ZPiMNu+x+Y6k2kuNxw3KYJ6qO/7XMkjout0Au
 s8lmVKJlgn5+ZERpMKf32lcqqbROrww=
X-Proofpoint-ORIG-GUID: HUmyQl68SJMpJucSRbhNzjnvRxdE-Clq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240081
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

Add compatible for Qualcomm Nord FastRPC which is compatible with
Kaanapali FastRPC.

As there are 4 CDSPs on Nord, add label for cdsp2 and cdsp3 as well.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
Changes for v2:
- Add label for cdsp2 and cdsp3
- Link to v1: https://lore.kernel.org/all/20260709082040.4070711-1-shengchao.guo@oss.qualcomm.com/

 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 2876fdd7c6e6..47e5976c8743 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -26,6 +26,7 @@ properties:
           - enum:
               - qcom,glymur-fastrpc
               - qcom,hawi-fastrpc
+              - qcom,nord-fastrpc
           - const: qcom,kaanapali-fastrpc
 
   label:
@@ -35,6 +36,8 @@ properties:
       - sdsp
       - cdsp
       - cdsp1
+      - cdsp2
+      - cdsp3
       - gdsp0
       - gdsp1
 
-- 
2.43.0

