Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89BCCA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 10:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF25310E36E;
	Tue,  6 Oct 2026 10:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hE5fHE62";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jdMb91Ef";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA5510E36E
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 10:26:22 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A5nNc361686
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 10:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 khd4SWMiVisNAdlrl7UTiMFxLmDsEifcq/cNJK4NIZo=; b=hE5fHE62ncNuhWU2
 p8j4Y/eaKp9NNV5DX+gT5LYQKfymej5RuOjZNCy7YAx1XOn9+3kMH+hAT2C2ZgP4
 PHEVUjjyo3/xl4KQxXrQS7W3DB9F170Q765dH2DvVFxoBYnZrorywI0hhdcWEyWe
 jYDAMc8RVRcntb7lpPOiNhQPV+7hJ/rgYBU8pf5LSAdOStjy37/Xlbu3NYMj3RPB
 ZZi8dd4qe2I31Dd7x9NKU3ZihOXvckT7W+cwCMlUmEc2Cl/pNAQFsxiTqwbTVkkc
 nG6YIAe66M7cjElAhmXEJykS3swl3s3QDUHRS4kLRGDLNEeBrYrPt7iLpoXIOEva
 l0CbUw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr0b4p9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 10:26:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39deda201bcso4397143a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791282380; x=1791887180;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=khd4SWMiVisNAdlrl7UTiMFxLmDsEifcq/cNJK4NIZo=;
 b=jdMb91Ef/CIsXAY9GyUNov2Pt82vyoeTi0xtSDrsJ79XQ5fjmoWuzm8PMaWV61BJuR
 6uGuznmoZbJDL/qU7V2f/fuSRQPL9spddJUfqHl2Tzv+E3ZRJ3q6dVCfglhs+qsGIdIv
 GqvjM/cQaQrnRwL0UQ2Mn2QDRVzV1Lwbk7lLuyGp4IDP7z2lzuz4X5j/o15hulwxYjbG
 vmWgWSOAnDTpG1OKbg1IOLrRAkwiDXSrU6fViT5nO0uZ6OwQ9HUURoOagbGD+Shrtt0K
 IuQb3L1j7EraZamCK9mTNxUnBAdazNJ7bUNK4UQKEgTgFze9xtmv7rvhau4KXKa8fK2P
 LY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791282380; x=1791887180;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=khd4SWMiVisNAdlrl7UTiMFxLmDsEifcq/cNJK4NIZo=;
 b=ssU+0jgW8H5Ps0yJXSRDFcWU++HUiT+ijeblK1y6ffm/odGyiDYZSONtQ11UT5et9i
 1KZAUwU91JNfbuR5TdG+Bn4ijibuaKBVzrhuNvuPGjXVxcYJIB6y5Eh/dXAs5lVMHAZh
 QXN2r944F29Y5GIFJoPQPJnaOJ8edAjmjdIaSg3K8racqDa+weHtULPUe9ptsQvfzzYF
 YR5yfOBemHri1xJVtvoPP/FYVquF/Hx9aqtbXE1BnJWAiGY5CNSsVaeiXIfrrW8RbKOl
 D0cbzcIGJXrTwP2X/HUzRE6GM84mLCUbocelblDYV7nYdxScLC3Haoc7AJoHbEpc06zf
 1b6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxN3GeZ43bh2rOkLg/vaIiUP/cwvUtg9O7mv+uq6zJD5j+4g0IUy4w2mN58bplj6DNWL7/AT59r5X0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLkkr8egiJq1r+fekEpYzuxjAlSt/2teY5d2KOGaRw4vE1IUeIq
 ob0Hec54hkTQ5mpu4ZFW8JqePCGs4WxKCrN68RZcJR4O4Rk0HSxFzQPp8JqynxHFYajqE+LWbaR
 jbQAuTMQZc8XGr1md5UCNFL1rZo1OsMpcQq+8xv67fOU3VmFIdBpfVVCRw8pn9znrcsJejqI=
X-Gm-Gg: AYBFou1XE9OANee/+LknErfT7mXmwVpB4wGoN9Er4PCz/wZ7FxnXhFo4IJOOsrLYfnK
 SdpZr3gW5EvesJEUtSyaiBD119S4FLdmGBjKinkB3UHfY9mZ0ThKDUCrXQ4ka5ZSCnzCheeqluZ
 F2IvwLI9trc1eZhcMOwkg9St6nvO4ODhusFDVPhBYUufWVx+JBUE1b5iDUsinntezYSb4nKObir
 wZr+sF9mgUtEUasviFXUuXQ5zmQUOoTW4mB+w2OXgLMdcomWIcAZJV/ieqdx0rTQfkfT1g4WcmR
 ivOrOPqdko3mJLgAPCMQxcw/I+OlcG1o7G20cwh2vAKLpiEL+vfrD+3p6C7mG3hZR/A4t6SBhJH
 FfeWjwlLhgpw96IfK34njEy4KNqRpPw0=
X-Received: by 2002:a17:90b:562f:b0:3a4:fe37:241a with SMTP id
 98e67ed59e1d1-3a8737cff8dmr721838a91.66.1791282380474; 
 Tue, 06 Oct 2026 03:26:20 -0700 (PDT)
X-Received: by 2002:a17:90b:562f:b0:3a4:fe37:241a with SMTP id
 98e67ed59e1d1-3a8737cff8dmr721820a91.66.1791282380052; 
 Tue, 06 Oct 2026 03:26:20 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a853e66d7fsm4088289a91.5.2026.10.06.03.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 03:26:19 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 15:56:06 +0530
Subject: [PATCH v3 1/2] dt-bindings: misc: qcom,fastrpc: Allow hex digits
 in compute-cb node names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-glymur-dtfix-v3-1-44e2bc5370c2@oss.qualcomm.com>
References: <20261006-glymur-dtfix-v3-0-44e2bc5370c2@oss.qualcomm.com>
In-Reply-To: <20261006-glymur-dtfix-v3-0-44e2bc5370c2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791282367; l=1204;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=21xqetrbQeUgnBKfuZyNE1NQqFmoX5IIsY/ucR0d3Yo=;
 b=CrUKDNdfF908aGpymN+DYfRNdfnYbgV0BGMX9u+YdojXL9vnwHahs5mixcI8pe3MaBmrVqJJm
 UhAxOAQ1/V2DkcGLQ8QBVxvX6ZQ2ZMTCOsQYZoRGwoWhooO1O1qaEze
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MSBTYWx0ZWRfX6qxZZC2CMbzB
 sf+ryVIi1elb8IMFFoIhuuiq7TcKALtevaQWIpE6iOTnWh4kzCgC3VtyuPJlnol2QQzOGzoXFN5
 8EMwbqJv+QYBXag/eHqAsIQUJtW7Y5KtPfHpyIHPLhxSXz24ynoZ3jW8/e7GMzVVbuQSbJMYtcY
 sRGterCqjdtXcuxVxrL7ouknhUl905TTRldJRbAHdFwwhcBA9bdDfFcoMzafmXwh2WJI34tNEZ9
 qnwI/vfN/TpApiEeCnLbbQfweXO3jx2xOCLclMXW4yzdOPE/xCC3AQHM/5pb3SrdpZscZaisjOx
 z6N7U4fIgp/FiIeSLqRgAiJ496012/jEEpt+TNa+n+VJ9rYwvzxVf95374+jCSt5DVT6967LBxG
 JBlC1NeTXTDUA6sMp0tfy5XXS5hJDha1idTN+vva+PAyp+khiMxxs/mFVdoLJPQ7AY9eQ/bOsjk
 caTl3HEg72XXWbpIQXA==
X-Proofpoint-GUID: HWHQ5ANlMYzQRV9Yg4Mo6Ho5tDsPezb8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MSBTYWx0ZWRfX7zE0z82UaUph
 Pyo+YPhF8E9oCsEJeeVbBgIsJhe4c4b3Z5Rs3XDuwSQtR1yVxeaKAjnjOh6TWsVgaY6zjyqdzdU
 0SFUvh6MY4YRETxMxFNZPEn7aBwTt/c=
X-Proofpoint-ORIG-GUID: HWHQ5ANlMYzQRV9Yg4Mo6Ho5tDsPezb8
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac4cccd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=C3F15k_13UMA7PaxDcEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060041
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

The patternProperties key for compute-cb subnodes used [0-9]* which
only matches decimal digits. However, per DTS convention, node unit
addresses must be the lowercase hexadecimal representation of the reg
value. For compute-cb nodes with reg values >= 10 (e.g. 12, 13, 14),
the correct node names are compute-cb@c, compute-cb@d, compute-cb@e
respectively, which are not matched by the current pattern.

Extend the pattern to [0-9a-f]* to allow lowercase hex digits, making
it consistent with DTS unit address conventions.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 49d2a5e8ba39..14fed91fee50 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -79,7 +79,7 @@ properties:
     const: 0
 
 patternProperties:
-  "(compute-)?cb@[0-9]*$":
+  "(compute-)?cb@[0-9a-f]*$":
     type: object
 
     description: >

-- 
2.34.1

