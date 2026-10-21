Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB03606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=plflsPsJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XbPaZYkL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7FA610FD03;
	Wed, 21 Oct 2026 09:26:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C3A10FD1D
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:26:19 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j6AN793374
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hnuqUzzjgSEBIaiHp/opE7urPU3XKVrRGqxwgy1tl/U=; b=plflsPsJl/slmmFd
 8laA/Z9kJZCWStJMxXQOkcWyDay+oJ2fEmOmVFeKTM4jYKgyhr3OrHifdPCQYz8l
 mpXyze+EiZJb6FHt78FWA+PuJy0BCL+4klqDsWFo2hKVNTUSs2gNS/pg+VEjqlLb
 WhyqkgAUms2zus4Z4QV2LDQU/PxgPO9dofMjBkbpmCRqDFV978rX03HjsyE8LwB+
 q3U/wtYQtwu1/bI0KkUirRdiaX+3Den2B2EG/NT5iCvdGMqG9vhHvFQE5hMIcEr4
 bWJg2YBpg+RhOUsh2TCM0vcOjOaTjJQrUfPFnRm6yBqvwA9Tq4/eOQoEzjv095ea
 xP7I9w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabk8q8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:26:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so908430eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792574778; x=1793179578;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hnuqUzzjgSEBIaiHp/opE7urPU3XKVrRGqxwgy1tl/U=;
 b=XbPaZYkLQFdCF+G6/Xv5aYgXUI11AYlfOAV5QEUwoqmJEMr0OdZSrvG7EdN+0o/jxe
 uZK32xg4exfGdV041aNNf6+jEhS+I/f5XwYMIVM2tuuU0fcidaJy5cutCxIy2uhXo+r1
 yDUAyPQP0Fr8RgRYv6RIklIkxF+LrDCoqyDcGDyl0/0280cp/kbcu/krKwk1h/afCfTr
 5lfOeFQzH7Ka5yyXkbp6wzhs+0MUmGQyCskk1esL3lZaRfoDLTkaC+lLMH/718EoSlRR
 wJz6yaGGGPecaHgpQSLg8D6RG+8+wobvNlq/AhXAfkSb4uFG1gUGhuFsWUulVzOf4wux
 6XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792574778; x=1793179578;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hnuqUzzjgSEBIaiHp/opE7urPU3XKVrRGqxwgy1tl/U=;
 b=cwhnP/KKmO9wPwyQa/G5X44VP4OZszIGT2JVotSycn0rfLeCsPGOMTEKg+x9wXCP9a
 zWi2enfcCRrQs8RfNaiOlDx1PuqCLXNO8I1L1GCpoEati4ePz9amEdGI4knCHcH59sBt
 ainIvOgfbi5SsZzpXk3n9EL8hoBAMXDFv0owSA7T2wQjxGr1DmT2BPQcFthOeV5+e2WQ
 nIH+eOeqfBf1c6lAaYQkq2U8XRwU8ZZylJHKvsj8ia5CSfl41w2ueMF3rE25nQcIWg7S
 REV5XczF0r9KrO7sGpgEJIbpss//YR1DmjIQBDOQR17ms+xTTjw5ouWNm1v3fTsDTggA
 F8TQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9pPnxpFpN3y63pr1ZSLUb/0DZ1+r1yWZZH0Mvy8SzqPQ7gaFpucqMRFfZAm8AMM8/vhN1iex/5JU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJaXlWE8Yn2HHSpVctZ+1ZH6xE9n6kFbw+i+M4bBoMmsXl2OtT6
 0DpNzW29P0GLAiLDpiypo/10MLz6Ov3UeE2wA+X5ALh9xg7+uJVOnszq5yW9Gf2olGUxAfnsFZQ
 vkC/rUZaZEr4Uc+4ex0c1Jae4hou7K5jZXY/wZnBzKCTXLilQ7ztXhwq+Jyi+97VV+KOYDwA=
X-Gm-Gg: AYBFou00lgvn3iIlmWKkvXB1kASXuSfUUXAbGo6znG4JRo4udZIAnZBPWKcJG5iIOEf
 2Utt7pITe9vw4LQJOhasHKE0IujgAQUbX9RiXq/gRXz3U9MCi0ebkmBO4yh3oDbXWQUOH5liEZz
 rahfUpuDVq8pxLiN6KfCuP8oeqiG/XZMfTy/dqs44njm/1SXDaifuWHKwoW+VaYPq4uTv8dVVYQ
 OIS8p5DOx9vzh/5CUyBllUtvJcpXyCd/vm4nPwDztPuB08qtxleD/QNtm51X8bxPg2BFTeh9rnF
 mNqkuSZLtIVdQGD/WoUqpzaQwv+DhFGNIe3ZrqPeRe1KPgzj9aRXDmxgOJ3ip7ZZpj5UHfO3yai
 bHjip4tHEb0n8Z1VaapckfMrCO9MHKvpo
X-Received: by 2002:a05:693c:2a0b:b0:351:bb8f:540c with SMTP id
 5a478bee46e88-3674df47953mr2657638eec.35.1792574777872; 
 Wed, 21 Oct 2026 02:26:17 -0700 (PDT)
X-Received: by 2002:a05:693c:2a0b:b0:351:bb8f:540c with SMTP id
 5a478bee46e88-3674df47953mr2657610eec.35.1792574777323; 
 Wed, 21 Oct 2026 02:26:17 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc8439sm6155671eec.11.2026.10.21.02.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:26:16 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 14:55:49 +0530
Subject: [PATCH v6 3/3] dt-bindings: misc: qcom,fastrpc: deprecate
 qcom,nsessions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-dup-sessions-v6-3-578ab52ba66c@oss.qualcomm.com>
References: <20261021-dup-sessions-v6-0-578ab52ba66c@oss.qualcomm.com>
In-Reply-To: <20261021-dup-sessions-v6-0-578ab52ba66c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792574754; l=1219;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=VMGzKTCz/azLzKyF9qh0sYFoOD2oiutFm8UHF1H6/Mk=;
 b=RHAEq1iBAsEUcfhN5ifaU3s8lvFXOfr2CVxuqoWhnvopFuaiUrJQ7klbFFiD8K7RDMfsHBm+u
 5aoeemGEKNdCeJWePMuVPimsjC5W+qMQiJMLN4JEAGi8CTSjmPNb7oN
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNyBTYWx0ZWRfXwvGXz9wvmCzq
 Pl6+X2p0yKC4cgwT5zGEeIblzhAXV0LC8pNlAELc28158C7Pe5GS1illX0dr6m16PLDYCNio6U+
 yoy0m0So/DCw2M2jXGEIvj3icTpCAkg=
X-Proofpoint-ORIG-GUID: 0mTX8N-YQuQfaleBhdmLDA9e9mL-expX
X-Proofpoint-GUID: 0mTX8N-YQuQfaleBhdmLDA9e9mL-expX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNyBTYWx0ZWRfX7ovxui9Ott/G
 xxZbVbTxa92artTn2zZQ5fDJ/zMp0j6WOR+vxVFlfMIG89730VhIHoX/mhJpK1/XDvDSHHHOatP
 wcMphR0RLBZUmrDtU5PEvoC3y8aSXPpMvH90OHUN/8ZWjTUpceTtCPRihJVYspRg1LheE/eL6bl
 Mc1IDrKtLd+1GN4yILmUmZSsUQwYGVYuJKyAlEQ0ewRNJwYMRm7ipZAAuZtqdjWjwG+iTJUk75i
 754ozRR65nVMojWipvVpkl3wK87rs7w9jltHfVM8UZdAqZSnJt3QGcW2CV0QoP+B1e0A7GRdjeH
 jbbWWVQuThm/sXcm8jjQ4PtB6/t39pCE04TPOxVPYs4PHPgHYoAKGjjSA9cflcSEo1stfl0zMZu
 FWDRsNcK9uo8HmoWid/HPY1tp/Nbr9PAKBliKjWRV++IyGtug9fpL7iCaIB2wV+zlhYVgD+UwtZ
 /4yz2mzc/MM3qh2AroA==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad8853a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=e51zU0WOd6sbzzcJbsAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210037
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The qcom,nsessions property was used to duplicate FastRPC sessions
inline during context bank initialisation. Session duplication is now
handled at the driver level, making this DT property redundant. Mark
it deprecated.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
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

