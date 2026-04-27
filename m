Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB39FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D0C10E08E;
	Mon, 27 Apr 2026 19:09:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lNcNrHwP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FV6swgQU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6134B10E0BF
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 19:09:23 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RFLLcf440889
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 19:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=VN5/vWSpUfq9bwbzgEQDNDzFZoAHnVwNNTG
 Tid3qqrU=; b=lNcNrHwPgkYTE0JzH8D6ZgdLbLGqDJcXiBBbQzzczaX367p7Ock
 6lHWXieQlV0UD6yDfiFUyFsAyNX7JKVqCT5EFmooGCIT6aN23s2SY/Ad77E3RC1C
 25Y4OpxHbv5jc6oBStM1ja314LA+V5TepKxT4wL0s9Hj6xohxuaDDXVGRADr7age
 NgiR45Z6gF32Go07coLsoRkXGSXGK2eBhuNSm0drsY2VC4AcukKhg7vauw68MUMc
 Nu9xk/cbFSy/aXNyvuarOMIeyRpWfFPnDe3HlNei2k90/WiKQoH8XKK+jPBTwuN9
 muq9fVFWRjDw3f3jW0RR6DzeXMe0e8bmbnA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtac40uhs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 19:09:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2e8bba2e6so150892505ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777316962; x=1777921762;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VN5/vWSpUfq9bwbzgEQDNDzFZoAHnVwNNTGTid3qqrU=;
 b=FV6swgQUi4Qd0cE1T0/mFId+TTnTZ1h7E5+haloeicDYhgpGlMxtmpSVTGQFHZ/2yN
 rCVMm00uRPAYnzjDHaOypseLF7Pkf7EfvgoD2DTyB0+Y+OXqgfk6t8wn9g3S8QAsmcsr
 BfZ7ge6DxtMwiS6k1D7J+SgNibElF1/nx4y5t3kwMqpDYYxOzRIaAKnMuIfPYlt2zDy5
 psXD8+upK6oHd5+FVwWE2jihc58nDY/jx2kIiEFlHKsTRCgoTcKKJupm7jhrghrigOGK
 k2rVYEx+hbFEjZ1Vgfm/w8/NK5h3VDNuFlymoYKWVVE/QQvmRL6zMWTt923sI/a/eO23
 wT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777316962; x=1777921762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VN5/vWSpUfq9bwbzgEQDNDzFZoAHnVwNNTGTid3qqrU=;
 b=h0MRNVLQCTVZZfJI1cq5gNKznqrvGgWCaRkIwWo5DiR2hUEqnV6BhhG8CDsja9lAvn
 KlpDe0X9ESvbpqDn4Jwi0wvGrOOdF4GCF0ZmzIgk6Bdycn2j1igg/3CtXi6DLB4hwxBK
 XzseCMvbCC1yjE+YULsiOEO7E/A62OqKAFhyy1vjnuqdQYaG74QT402nc16C8NZwbTCJ
 VpkkDF7c3nBcVYas0mNfRLZnv/IGp8Spc6VriMswlMCNKl1RbVOZQAMqF7n7QD1S6FPS
 rBTcO6o30xZTIPl3JWSMUtNKM7kJOfcBxwX70jp3ks7KEiaZdTGf1biTrJh0kA3UkMU2
 FWQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rR0IgA/QENILPVG3TliyN39W5CTplbzL/2RpTXL8dkrb161KXL9H6WYToXEB8SZJWGClUAo6f4JY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiD4fTgblBFygUmv8GmnNX4xyB177VXcjqf8DIAtOAjKnD7/Sd
 B7MXOyBLQsaLOHw6pxzXdw1eRSx5i1CAA+XzujBdSV4YKOfTOU8ydXDrT0bmLRicJPI12ZdFFYe
 wVzzH9d02DnoL2qN0W4vp+TIeeZuCQprH6NYynfcTBrldrIL9F0qMjHL5szA3Ld9gprDgTrg=
X-Gm-Gg: AeBDiesXoVo+nM+GHcyEHPmwMhlnGReu9+jWFnId7kiYOjqO5WfKoLwQbaUtGkniDIF
 6hshorO8wv+EPO/tMwaRgfqi4oo16qy6U30esaQq5bZzXXj4W2SDlCZSxi+xunGE/yLc5RENGkc
 8s/g/kd2TLhT8PkRgGzhDawDY/em8ffVyKt37vbc0VLs4apQjJziLGpD9FZOkPOKxduNeS+rKTJ
 leMNGXjKBLdjpzrUTBUr4lB/vexMU2JKyIhCtQg7mgCUThyBBD+DCpCY/2BfNj+fGLpf0jSt6uY
 LjIEj9QZSMGu4tIMDeCVEKn4jtWkkQJmfKqaxefcWXeCIdDp0ii1yqvVflo2a/lcES5Zu8YXn7Q
 /Le5denygjJmmEZhjx9ZFOoy1U0ZbsNoOjmLgrzw7nRlTNk4ucv3RSxMWUw0=
X-Received: by 2002:a17:903:22c2:b0:2b2:489a:f46a with SMTP id
 d9443c01a7336-2b97a97298dmr4981575ad.36.1777316962151; 
 Mon, 27 Apr 2026 12:09:22 -0700 (PDT)
X-Received: by 2002:a17:903:22c2:b0:2b2:489a:f46a with SMTP id
 d9443c01a7336-2b97a97298dmr4981065ad.36.1777316961476; 
 Mon, 27 Apr 2026 12:09:21 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97aa95a7fsm2232335ad.24.2026.04.27.12.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:09:20 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: misc: qcom,fastrpc: Add compatible for Hawi SoC
Date: Tue, 28 Apr 2026 00:39:13 +0530
Message-ID: <20260427190913.3680717-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: L0GYBmxvfDk9HzbeF9PD2AN-ag_tQ8-m
X-Authority-Analysis: v=2.4 cv=D7J37PRj c=1 sm=1 tr=0 ts=69efb462 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=vdJOUiAGeZ4XVXUCxO0A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: L0GYBmxvfDk9HzbeF9PD2AN-ag_tQ8-m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIwNCBTYWx0ZWRfX+DTALyqaOtp4
 EX1lPEhBlfL0y/MIKMMz6L4XoTPhVgJqwUY57CBpDGO9WL/Eg87/AcIoEsEVvpXo2vMyBJx1/am
 J1vr6MJe+LS1YWiEw+y1axvlAxURrNCQ18rqsbibnlMpgCUDVyEtUw8oTpmQ3aryuszlfHCWLSx
 i2DcD6ma/y3WN6OVEB4yCm6YKqofQyBzEKMWrrPRaSrFAe4+vEv1amGZSgvewyNQWvZqkHkQxGy
 8kCj5d7we/eUt43rJ+w2XkeOqBepmtLXXUXNi4rybQ42iZaepKBJoKdqcaMreosj4bS5IDPfCqT
 8B/AeUmKFfQL5MKX4FAPWJskUljHwLYSrQ51vWrFtE+lDpddiwnvLVhhGzSK7IOaDJstVeZqQ2o
 cpd4uKqEICwSiP/FwqqT1kQZYc9kBDR1p4lOYze/RRE3DcwJf18Nyn0iVfi1abP64OGQ6XB/PcE
 dSlhlZGx/jSgRZS047w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270204
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

Document compatible for Qualcomm Hawi fastrpc which is fully
compatible with Qualcomm Kaanapali fastrpc.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index ca830dd06de2..2876fdd7c6e6 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - qcom,glymur-fastrpc
+              - qcom,hawi-fastrpc
           - const: qcom,kaanapali-fastrpc
 
   label:
-- 
2.53.0

