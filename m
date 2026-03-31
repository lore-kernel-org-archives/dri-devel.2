Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE981061B2D
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 03:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEA310E850;
	Tue, 31 Mar 2026 03:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jOA5CxKH";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LmeYPgu7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA55910E850
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 03:21:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UL4GgF1842632
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 03:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=/6hTUIUuvrbheX/Urbiq81lb23LEfZHvDxd
 xPJ4VLuo=; b=jOA5CxKHtH8mpMgK9FkWN1sUUXCHt6E5FferrwxoCPtzo5OYpWy
 hgBH8QVmqMhAkq0h/bth34fC4ImWxTvCVrt2JoTn9ULANkI1AOcHVA0iL9dohYHw
 8KQa1WN3k238LPa/ujnB39NdJxX8YGNr/JEXIqFAJmp2cb6Xn2SVZ1TaPotGAhK8
 TzmnN3EyCcwx/pDrFwtpaj5DP9Slo7uHK0Ygshsc8av2olxT0W5A873i8Mllo8up
 Ubk0bL/8oONk1bUyuebDeQppeLXHRnIP5dVenlEfKa+Wis1/A7Nz0t5gBlBak+4n
 oumUwSE4hzfXKtepFPaLkPF/vqayQ8Dig7Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80rsh14p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 03:21:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b0c30b51bfso139663355ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774927295; x=1775532095;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/6hTUIUuvrbheX/Urbiq81lb23LEfZHvDxdxPJ4VLuo=;
 b=LmeYPgu7W1t66RMHhP0pekSYz6m8FoeLHISlF03lOHdVxSly3xaGLDP+Tjg3SK+b4p
 mU57HAvC1kjcq/E8IPx/Rx/htL8xR0+hLSBGUcKRg1prExCJ92QakfhqlONkRbgvoqKS
 KYdYl+zrhqTElo591z0+wfyAIqqv4wlQMZNT/Kkv4ZMpFXGZDWLTv8r11O2FPtCjB70U
 SP8XfIWInsJmiIVASKECYpTO9ZrRhkc8KRkMK8d3QF1M8MNi06yxqp6JsRUa7f9SdfJ/
 MLsnAqZbA32PrO1wn9J6c6SrSPgdyqUSdxgkwZfStCKvt5ZveZVtTgjii4Fdljmb8ZUe
 nQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774927295; x=1775532095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6hTUIUuvrbheX/Urbiq81lb23LEfZHvDxdxPJ4VLuo=;
 b=mHNKGK4TCL7gKQVU7vancvlWMzcQX6gbcXrzAhxZeXMzhpBOhIXSP9md4UqSpEVhDS
 S3lqeHsqgipro7HClRzYmdLSd8nzULOQo3vbveWDJRslfN/8WQCXf+hfce2fNhkWu2ts
 nNOiM0xYrgD2YTS/PKEFRrGN/JiIn73ojPhSGqfTR6/IAJ5dqRjXnYmOXSBKquB1xVuB
 9Z+5KRpjhEOqB6KzvVbhA7aX/EakxmgFYGxh4mKID27Edt3xxNKYTlW2gVoKr8aPSYkq
 ySqKOcB8yhIBMWsOVfwvGHaLS1AuGdpWfxH6Ie012IdP2EOS6kyuCmaq1X8J+5kKvSY4
 G2XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6kexFh+1dB6eQ1Cb4CpgOwZgeO7FgE7EutmuVufq1xqN6eEVIK/DYSliIMVPRAxfzMfyIcnmNX2g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKTSetRRGAh7FLlPEiC2XYiFq8LLasoODeFG3WxBymoHxV16w0
 oJVD8COVj3lUE3Ze8VD+hGtnGyL9jARhjq/SWNwVJzg/6ijisf11i9vkIsdeQzb2ZFjPvgqA8xk
 7syh1aIadcNVj2WO4u6LXQXxxshgnwS7mvYpcb8wy9zBsTkJD/mY78oAbYR12br2yyIzl610=
X-Gm-Gg: ATEYQzyd7ECVYDbHZmMFhXA129GCzvmJy4BkFhwud5JAwB3gq6+4f6gqU7XOhtNCXrV
 CXs7AnJC/LS+g/9dRDHoMX3c9vttU138xz4cHWg5VBczQeCcsK7xS6iLTROSWfzlEM5lbY2G4Tc
 ZVAQbvXf9FcGSr/OuE0cNlvJASByPzchzXkQKt9tWhLpjnpMAXfB8TjTHUB2+5NpFg4EEm0DnQ2
 ognWEHeC8vMOxxYTJ4jltszAo7NdUzii8SwoRdLzOeBU6avUPv/e6tPeW0M+c0Daj0vVi9CuVpW
 5PUvxmr6qgw5mDuWcgg/9CoxiNV9i2NJf0nfN9gdalrCgqYjY9n/XCVdzgpFWXAnXZJ3SxVWDPE
 AInS112DMgLjqHqPhF4u3o3lejmzXVdSNh/63z4NzC+6NUkOdZyrIaPU2Sp9OYndZVa71L15U9U
 gYAwOd35XvIybzrE8WHPAauiqRUQM/94iIwLc2
X-Received: by 2002:a17:903:41ce:b0:2b2:470d:6d0d with SMTP id
 d9443c01a7336-2b2470d6f7cmr104282495ad.9.1774927294755; 
 Mon, 30 Mar 2026 20:21:34 -0700 (PDT)
X-Received: by 2002:a17:903:41ce:b0:2b2:470d:6d0d with SMTP id
 d9443c01a7336-2b2470d6f7cmr104282165ad.9.1774927294267; 
 Mon, 30 Mar 2026 20:21:34 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b25ca51aefsm21104875ad.16.2026.03.30.20.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 20:21:33 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: gregkh@linuxfoundation.org, robh@kernel.org, srini@kernel.org,
 amahesh@qti.qualcomm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V7] dt-bindings: misc: qcom, fastrpc: Add compatible for Glymur
Date: Tue, 31 Mar 2026 08:51:21 +0530
Message-Id: <20260331032121.1279203-1-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K5xQ0NGFX1O0HSaW0BuhvxM-yKAFcyUf
X-Authority-Analysis: v=2.4 cv=VInQXtPX c=1 sm=1 tr=0 ts=69cb3dbf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=nXg5SIL9QfFqj7ZtGcoA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: K5xQ0NGFX1O0HSaW0BuhvxM-yKAFcyUf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAyOSBTYWx0ZWRfX9RA1U1zDox6q
 mB1rABS0nKoJUGc2QKpMZWSw+8XxvC6cXlV6XcTrNBKyMuXrjQw2H2lgxb33jiNNddkFnJj58A7
 4FHBfDjwfUzsCZJGcgnwLrt8re9w5rX/Ul/LlwUbkMCgZwHuzb8Chc8frxOE6AkBUBHBHU8qinP
 GDm8MQGHya6MWccTWvN2eyBvf5uMQjmnckGye1WGPc6hp2gx61lWqNzZVp5DrZF6f9SybocnAep
 JRQGDiOd23kK8IfOX440HjfLOiQCFCsFDjqOYy7z38u3+nPesOxFdNiH6fmJDfY+dEJC3n0gTK0
 6TDP1r3Up5HYsiyDEpEaExjSG4kMJ3dxbO2I65/nTTVkPogrl892rvdnCjcljB3kSxGOAQ1SigY
 dBMrQMq4bG2qpxKYf26syJmJ/Ew88R7B5BHPyHgVnxZx0j0YbXgOdVcBsdTPs3bVrA5LG9QO8um
 1dt+uHCDjR96I92h3Zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310029
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

Document compatible for Qualcomm Glymur fastrpc which is fully compatible
with Qualcomm Kaanapali fastrpc.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

Greg if you are still picking up patches can you please this
as well.

Changes in v7:
- Rebased on the latest Linux-next
- Split patch series so that Greg can pick this one up so that
  the dt changes can be picked up by Bjorn.
- Link to v6: https://lore.kernel.org/lkml/20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com/

Changes in v6:
- Pick the audio series up. [Srini]
- Pickup Rbs from the list.
- Rebase on top of the lastest linux-next.
- Fix up address size and other misc fixes. [Konrad]
- Fix the ordering the various audio nodes. [Sibi]
- Link to v5: https://lore.kernel.org/lkml/20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com/
- Link to v0 audio series: https://lore.kernel.org/lkml/20260311124230.2241781-1-srinivas.kandagatla@oss.qualcomm.com/

Changes in v5:
- Fix commit messages (patch 1/2) to accurately describe compatibility [Krzysztof]
- Link to v4: https://lore.kernel.org/lkml/20260310033617.3108675-1-sibi.sankar@oss.qualcomm.com/

Changes in v4:
- Fix SID used in ADSP/CDSP for correctness [Konrad]
- Link to v3: https://lore.kernel.org/lkml/20260129001358.770053-1-sibi.sankar@oss.qualcomm.com/

Changes in v3:
- A few variants of the SoC are expected to run Linux at EL1 hence the
  iommus properties are left optional.
- Add fastrpc bindings and nodes.
- Link to v2: https://lore.kernel.org/all/20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com/

Changes in v2:
- Combined into Kaanapali series since they are fully compatible.
- Link to v1: https://lore.kernel.org/all/20250924183726.509202-1-sibi.sankar@oss.qualcomm.com/

 .../devicetree/bindings/misc/qcom,fastrpc.yaml        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index d8e47db677cc..ca830dd06de2 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -18,9 +18,14 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,kaanapali-fastrpc
-      - qcom,fastrpc
+    oneOf:
+      - enum:
+          - qcom,kaanapali-fastrpc
+          - qcom,fastrpc
+      - items:
+          - enum:
+              - qcom,glymur-fastrpc
+          - const: qcom,kaanapali-fastrpc
 
   label:
     enum:

base-commit: cf7c3c02fdd0dfccf4d6611714273dcb538af2cb
-- 
2.34.1

