Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153D0CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBAA710EB8F;
	Mon, 19 Oct 2026 11:26:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D97810EAA0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:25:57 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P5lO1896537
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xpTZBuo4GWUkvLx9haahL/OS0k1KfhQyJgJvKZBWP9U=; b=feU0h8ZeXYHiiH9X
 eoKb3NhJ76nB1ofJYJQssWZIzNApbA3KKqsXVseIty9J0jFcSv9g57EgVjfIJ80V
 FXF1Hd7oBkvES3EuJ97hzcScQqjy/4+Ujm0vN/RTFWqiAXXNKR+sH5svsvsdYuj/
 V0aEoLQNvg7offPJn2HUFrfukei0vorwjdLg6kpHozhUmvN3y3gxbwz0HoGqTTBV
 JxnVsLZ+XOkaUd9dvnSQ0vEPaWCKPC4tO6XzOoojuGgBmpdPpBt8pHpPFzWh9Rzl
 WqZpNTwPjIp0Glf6uX/xdypLAwGlPgb86GMDl+JtvOF8tLZDnro00oY3qJvpu8hi
 l2Utgg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr9m82-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:25:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb71b1443so434289085a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792409155; x=1793013955;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xpTZBuo4GWUkvLx9haahL/OS0k1KfhQyJgJvKZBWP9U=;
 b=jW5ucsNsHwqK4H9lHqdruMqpKhLB9ErDBzTDFYPsFJS12qqqMt7rtjF13IHliGvT2u
 hodXByIFnEKNBA9XPr7tAjhkhLlVpLrpZqjFQTZjwa+8TanXetgMja17kapPAiX6qJ7r
 Cn5IrpA0Hqz3EMoh3roRdlMNHq5Gu+KaJb+8Kl1p9jUZwlJrR8BOewTr9QTrGcTC4cVi
 FEIhupP/VkECRRebfHjjc45QkLkW6QcY/kLkOz77dfSmUSQIqTXWTVA0SdXJWb+Wm30d
 oAUwRLq2uATowRqVqX0dg7P0jI97tNmI1raNNCejD2eJXo1uGsXfjhlnVJGfIk5x6ILC
 A2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792409155; x=1793013955;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xpTZBuo4GWUkvLx9haahL/OS0k1KfhQyJgJvKZBWP9U=;
 b=aCsvbbJ55Rphl0y03xvE1snceoDLqJpa6O57TsWgQCjRneg0PTYVy9QJUUEQ6yrwHl
 ipiJ5Eobs3pbPE3lkoBtnvam7hLU7du+Y7aXDLmBr11tskK20utJw+Z91q9vGntUUfZ6
 MrQiZrcZe2FN8NMT2DU1wjbJTzP59/fabQWAhpbbyIlpsiyb3FXpHN8gQEBPr6X0pgUM
 /6RCh/YZTKSy7LtgMFz+djvxQbkhsvGVdwEk3TguSpPiaZiUtbahM4DyUO0cRwcbP8E3
 uRtQwpkdV9CG8hY2YxA93q61CDclaSheL9M8ytT9CDa1Bg41+wHJq5bty1oyxvC2GLma
 0Hsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmbq2ldUkVThXTo0uFIekkdjHbnOXf9WGiTXvWjI1sWZKR69Pg+dEaS14Pep85p61RkmJ8KAcWkaM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIh/w3dILZvl7RWEL55xadBCYOb5ESeCkKyJhR5NedW0OyRrJaz
 7RB7E8qyXKUvx1xjrQi49lxDYAgWNizuxleU2wDvKPcm0Ya26W9vejrl0Nf5hYuC2sdLn3Pfj7A
 zfBdLOAi4hckOSO/eNKitlvft/xMUmPzvUBT/J94hOVCVYVC8QPaVWtDy62LDT8EFLmqHSPQ=
X-Gm-Gg: AYBFou3ckUpwzO0WZNfMV54pCcRr38YAvqZsAjIH8ZwC2e3YrFpxwNLeA/UdecK3jeM
 XfRoaFaHFUJFN26RlR91EwpjLFV/lre1Qj/hB+rERFRtQUVpLKo9A2jiQYXaXd7u4L3l5wG2xKp
 Z9ukDs59tV+eH06keqYemnw03igkLnKoUIK7Yv9nFioWNRp1l14OyEvVEOXMgwQcA3JnP2ovaK6
 T+/5FhANe4tAzBzysoKtpaWTyUYqWlb94oaIxzKlJBVbtq5p4jRn4HgpnQjhf8UP5BWAOwlgMfy
 VRb4jfcYafVu9PYUEjRg10l3ueBDdr3r6P3EOexkIjTPPFrugSRSt9tyiGl4ntip8XLBQw454V8
 lIGVqX2JkoxanZHcWY1gvNR6P1KgYc7C1J5muK5LelUyuynRJ2/0psbfQe7lRQLqdshRFxP3NKx
 Avw0T1Ylb8zDFT
X-Received: by 2002:a05:620a:3181:b0:93e:bcbf:88 with SMTP id
 af79cd13be357-93f29b65959mr1138655685a.4.1792409155419; 
 Mon, 19 Oct 2026 04:25:55 -0700 (PDT)
X-Received: by 2002:a05:620a:3181:b0:93e:bcbf:88 with SMTP id
 af79cd13be357-93f29b65959mr1138653785a.4.1792409154919; 
 Mon, 19 Oct 2026 04:25:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:25:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:39 +0300
Subject: [PATCH v2 3/8] dt-bindings: mfd: qcom,spmi-pmic: add LCDB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-3-86c05068efc5@oss.qualcomm.com>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=889;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5j1+5gWDZPo/v74nUWVlDehbVbzgsxlj7niMYz5yZPc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f45YrRHdCDK8bawXDs3JDG84GqSMd55FbwB1
 iURRmnFbeKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OQAKCRCLPIo+Aiko
 1fmSCACAe6SmTmaJZaTQrBt+Dfdyi5ffb1oQGY06s4FGLcr2y3TVD+8a1QPhWLOWpgLyWsvQ1dJ
 jahbLyMnTOxozSmpGz+gew9jTiT4esexYWMS0nC89rt9jGjG1x7x7OCYq7GMERuAU/vAuDCu9Pc
 TuLeJ+iiw1RtveSf+2Ed9fIaDS2lR9Dj7TcZedIQlLMf5mbHvhx3EIQkCLghCmCr5c2wxsjSCLr
 Nsno2PH+h51Q1ID9bhpYT0Bd6I3/XgILhRdD8VV6rNZ6sTFGfpNN3ETS3x1T1ih/1rAW9SNstDF
 UGBPaqAFev1GoAyStjNrsmNmIbfvJHAl5gRMokBuFfe6H8fK
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX/Q0EwMcWH4zP
 ui0EN6dxutZAlbYiySN2SkiCGUGOSNEFu21jTfo/FupR9XlcSHIZrdAJYcS2f+gw7Fp1Sodd3WK
 IUlalMdOrsQkHatPG+aJT2uq0XnCNwi66bWLonNVj32bKDc9PAoa/vJk9g02fKsbcqAcN9yZgEG
 u+TbxHslTTOJRfviQYczPbW6PaoX7CiljlhcwkWrq/kZYne/grtif7hKAA3gExvYwJkFSAUZyMS
 ETZjWt5yCFiDjF0F8U2H6z7Ew9XwoU8AxuzNnVUbUTESJLX5MdZwAULUTgMs/bMILAPrePGk3W7
 3DVqORmxKrGTgkqhyH/pgOEZq1+qZaRgWdj4eU4p+PCWnnb/zbjmAjvFRlWY4lr+MRtGqR+mQIa
 h+BQSevni3cj+iXgPs0Fhal0X9gfzrETi0Pef+3sAoIZGoJKUyzu5Kdh8lJ/fYsV6jIPJNqUXU3
 kG9km6tWPSecm8gVT3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXxU/FIJ6AKBCr
 N5jViZVdXoroEOqkYwPc9BLONItMMp39v7b2vatWH12bQIZeOEDeFjjnIKCtf8Ag9kZ8zr0SEtQ
 fl+ugQnUXa3IXU2rAFBNGQ+O32JRm3s=
X-Proofpoint-GUID: qQap5xHQ_9PAfdJQKa0mdA6j9pnrHO55
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad5fe44 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Pve-c2K1UEanVU4iL48A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: qQap5xHQ_9PAfdJQKa0mdA6j9pnrHO55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190045
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

Allow the LCDB regulator block as a child of the SPMI PMIC node.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index f6534e9e9912..3ca32d741e68 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -191,6 +191,10 @@ patternProperties:
     type: object
     $ref: /schemas/power/reset/qcom,pon.yaml#
 
+  "^regulator@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/regulator/qcom,pm8150l-lcdb.yaml#
+
   "^rtc@[0-9a-f]+$":
     type: object
     $ref: /schemas/rtc/qcom-pm8xxx-rtc.yaml#

-- 
2.47.3

