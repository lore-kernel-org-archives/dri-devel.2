Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37302C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 896F010E85B;
	Wed, 23 Sep 2026 08:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YtcMmpo6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J99XZO27";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE5310E857
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:40:14 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8JO672854134
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KQXRpTTPtzwVRvlOFmFAjbS+ReLpP/eRuTZel+cLkNE=; b=YtcMmpo60xktOfVa
 5mQhINctQVE8nlltFUfINfnW064drKr8RIoYmnWHU+gviCv0D4gRNJ5EtiC1wedq
 0lvEJqtQ1nRYS7ZVV4G/tlE9F2xZdVg77oVW9MPuNv2qimpfNdEtfoFMcdw0z9QQ
 c3V/2ZFqnEQZ7t4NFqVYRX15SObz4g8jyJmRw2Q92s87JqIkrRU1Kbc6Ru/OHe3j
 MBEtb1DiCOhQTMou/fNeZc13nMMN4B5Ne2w6sJvA0QLq/lZdysoHW5Fa0Kp43NaN
 In5WySVIwztYi4ewBdwJXlODVqUCRujVqk4jfghUKhHav06dyxXRHMYObNjmeu7m
 DX+uEA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guymw2ytu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:40:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-333543ac378so765443eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 01:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790152813; x=1790757613;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KQXRpTTPtzwVRvlOFmFAjbS+ReLpP/eRuTZel+cLkNE=;
 b=J99XZO275zU4axV+AWQ93U4I3OMp+eEh+1ifKy7AifGvtqzi9VYG+JqRoJZctWQcbj
 gfszCBzdi09f3SS4qAgaXJQrsqoDnPswIcc7kMCSxb9hOFuVIcAWIecMEHFLJEGYBC5z
 lPmbw70UFLUSw7r3o2uIMl0RFbtEv9e22wXZ/YGiP3q84WtKpZxvqy6goW9uGW/FV78L
 hu3d+uTDvFt34BVxOMK5m6K/z1hHB1ZPPve5tkK3ZARRMNeqTjvlKxsGimyu6ZndtuFy
 s6OCprtiNoBY4VhRPaomWP1PjWaEoa5yo1un//UurEqs25L0O3m74HKnQMStjGJRmxgj
 J/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790152813; x=1790757613;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KQXRpTTPtzwVRvlOFmFAjbS+ReLpP/eRuTZel+cLkNE=;
 b=KBC9NRJwjmFa3Zbxu2l6z7LnJnw4EdP5+tU4qZ7z/FUZhe2TBlYlsigfVq7AC/rzQk
 SpJGizVOceLvw98ucprQUQmyvze4kssY/b3Sk5Td2t7glyywm0nMaBArx3b1Hix6knaj
 esftpSSMPn/nje6H61iP0CfRbdUz1O0l4ogf6wRW2229POjqWbThrC+ujQrmYGyhrD0P
 58oDYUmBi63E16HqHZLnTfGijVgZZQm++UteGVwEvze/WQnZaGnQAsAQJpT7v6qogQa1
 e04kjQQPjghwa8RxIkJvTx2uUqr16Gx5tPo42Znd2+5/oVZwswDtIZu7E+R9hUjGn+Zo
 34kQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByz/ZxgncegZyiPwX3msCnlkn1PONYDHnHp/IbChsAv1XsiuiIhV08SGFTWx3DbJDxH1PSr/rK/GLo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++myGnZblBma/NnQBC/NssfURcQ3Xfolk6Yjy587xX5K+vbWC21D
 L8V+QAeQbnr1L1Kq23V/ZEITueySI6vpeuqD60Fy/3zenWsfm3QAhz+KMNJneTclUG0uLpUbFrh
 tiXr3o24d03XzJP/vbeM35tqMkICCjf3uiusEjieYSyXDQh9RF4+PwDEUU8sqZ03w0kdQ0LE=
X-Gm-Gg: AYBFou2pSmT3dS0xbcE6apeov6VWrXZSokH8PM+/s1FJf1EORXLTBa2bmyc6PBuUdAF
 t3YK5zaPI8RcbMSiXcQHjY+ZAzRFGpShSj4JajKEqhhVcdX9nPeUjip/fIkf/X3nH734ybbjdJg
 JIKETxO3Q1xR+oMjg3HvUusP05ChEelB92j8RgQkI8kIkDC6P7uzj0iiFXMgxluWnay+0v78mXx
 XYZ+MivuwqlNxM1bfSnY/VyCkWAGGOlv9UhDZSkVz4uufGOmHOQmhQgZig8jczgzLhztlmcabBI
 Z8cqHyNn2RYPdLXIKx3e3cBMDum8DwPYSF46uTYJ/FLOsubUpQb22EJ9pnaVehgs3dfcIAIAldL
 dQE1qscFFDbR/6WaRiqRkPBn/XcOJ18BA
X-Received: by 2002:a05:693c:87c3:20b0:33b:f5b7:f4b3 with SMTP id
 5a478bee46e88-33ea647e619mr1704603eec.27.1790152813189; 
 Wed, 23 Sep 2026 01:40:13 -0700 (PDT)
X-Received: by 2002:a05:693c:87c3:20b0:33b:f5b7:f4b3 with SMTP id
 5a478bee46e88-33ea647e619mr1704574eec.27.1790152812628; 
 Wed, 23 Sep 2026 01:40:12 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96d497e1sm4701275eec.25.2026.09.23.01.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 01:40:12 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:09:35 +0530
Subject: [PATCH v5 3/3] dt-bindings: misc: qcom,fastrpc: deprecate
 qcom,nsessions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dup-sessions-v5-3-e953133a1827@oss.qualcomm.com>
References: <20260923-dup-sessions-v5-0-e953133a1827@oss.qualcomm.com>
In-Reply-To: <20260923-dup-sessions-v5-0-e953133a1827@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, devicetree@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790152791; l=1160;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=4EJ+Dqj+1p2e3D/bJWAuULr9rdv/qA1bb0r2/Z+2fTQ=;
 b=e0MgaiZWsc2oUknzB47/o7/O9yahDPbB/eRXHGFyGweqtgG5dEQKiMCoL6vwICumPCsRUFTil
 krWQU6b6EpwBpTcLD+l0jsxvh2hMEnmvNvfNnKFQlbB1YCmBV1FNbCV
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfX+DHs9y4H+gZr
 G7QU5TMa7OMUm3UL1HX7MsUssgtgqrzBTvP0gMG2TkEFDLYzUzMM++9+53t1hOOZgtScUeR58AW
 SpxKtAqOU/JXbyU8LcQttBhTrmkog6dZfzi7wq46buTbYHfUcZg/eUJySZpbHL59fRGTEo4JxVP
 eIVbLknDc4Dw99V3vfPgSPD2eRNN4ieEnes+e66dMX2eVeuiQvHd8PH7ER55yVzWdEuNWKK/1Ix
 5rDMS4GNG8NGFqn8ES7BWH8MEblFBTzEEDoQy/ZL8gqtrt1nyUYbV713/MU2e5NTs7sKp63GTwc
 1wr7hWs/KOi8A38ohonVqTyNf9v9dmgUgo/3hRAD62yV0heM6X7I0/B/k6DW5zCgG8oE2ERaZtv
 oEgHJzpZfFGVJ+rA6izhB8NllrJE8f4c23NQ9DjHVaygCxBxgz9HBxcGsErfA2OkhyAHu6/rnfg
 NpsQDRRViUV2BSrOegw==
X-Authority-Analysis: v=2.4 cv=feI4WEQF c=1 sm=1 tr=0 ts=6ab3906d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=e51zU0WOd6sbzzcJbsAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: GXh4S_GcrdQwPcKyo6wRl5MwYbIGXp7M
X-Proofpoint-ORIG-GUID: GXh4S_GcrdQwPcKyo6wRl5MwYbIGXp7M
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfXxmmSevmGnqd2
 5bGj2Hadeh57swHVBaxseCelxkEgKH4SbY4XMgC1FZYN6EAFW/j30jGRACSpG8yZf7aqmT025BP
 vfgSlt7ivJselDYst06xaF372y+T9LA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230034
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

The qcom,nsessions property was used to duplicate FastRPC sessions
inline during context bank initialisation. Session duplication is now
handled at the driver level, making this DT property redundant. Mark
it deprecated.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 49d2a5e8ba39..e945c8ba75e3 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -101,8 +101,10 @@ patternProperties:
       qcom,nsessions:
         $ref: /schemas/types.yaml#/definitions/uint32
         default: 1
+        deprecated: true
         description: >
           A value indicating how many sessions can share this context bank.
+          Session duplication is now handled by the driver.
 
     required:
       - compatible

-- 
2.34.1

