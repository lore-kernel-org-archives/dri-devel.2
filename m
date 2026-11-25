Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA5606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fri0xDPv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WpEjIlyV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D320610E250;
	Wed, 25 Nov 2026 00:07:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46FB10E250
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:06:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AONXiSB2288525
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WwclLV7cw7J/crM0GWJq1PEWnv/bEeY2FOqZV8eVA5M=; b=Fri0xDPvMdwITMwp
 +bydIZrpDuNbf7OQkwNvzYyc2j+A400KekCCNNLYlY3tn17LNhJavm7QCq6q2CKG
 64MGxx97JdYg6mo83SeHkdktKVMkog40m9KPq0awR4Lq1d7raaU6/ReCC0ifMBfA
 tQzDPfBDeUCRfHwcY3yOehb5YO0X1/XhizX8ahhPlWL9qjSUppIGD0Ytvu3uOUNj
 2su0Y5Uu7kqV31GF49zCWfxpZHYXLagsSuOtQEGOG2b0cwjg6njngIdWbROQRV9g
 YgUazp6zU6Yi/aQl1putHweeh/QPHk5EVuOMfas63I2OYtAAM772LJRKkXB5xQ/A
 5p8SoA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mc282y4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:06:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-384c78aa0dbso7037947eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795565215; x=1796170015;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WwclLV7cw7J/crM0GWJq1PEWnv/bEeY2FOqZV8eVA5M=;
 b=WpEjIlyVY/fJisPpl5FokADWl2kER2h1umVJy949bt99i3BuydT+9Q7qVWKOBDXugF
 SCMBqelwzFtxakQxgqbSoZCAV4syUU63uEFWfUAAgKHHWTDfj+xR5xqhb09qZZC5M9mT
 nNRe3/kKyBO5efNt2mXtuDOrxHlsXQzBL5PE8N2pisLW/mfWbef/T3M7/FbSW/vCGn38
 s4FQqEFUlJJFF8rRkR6twgUZu7hEMHhd71+tOCulW/Vrbno/qBYSoMwsjt0K50daoHRq
 GLUGzp1EY6G2QMNYxFOwkvzqjcCUWUCrWL14FmkDID070i5PXFyJnWIxiGJLn76lB1g7
 Zo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795565215; x=1796170015;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WwclLV7cw7J/crM0GWJq1PEWnv/bEeY2FOqZV8eVA5M=;
 b=mwCoWRSpk5wLNG9RfxmGzd64wzIkrg+Pb17VEK6ozxzeLoVJ0T2PuCyHBbsT4XH/OT
 aPn+TGzaKxLa1w2hDUXaJ/lnxyh9T1Sg6JaSyGygF7GWNhvR8VOoXmFUcCRyUD0t4ikh
 e9exEvsl2YbKtiRQM2cV8ulwB+vc2xXNtVmyYNqRcQX1bV/OKunpRsZv5zUPAK08HG7e
 JGc5RJys+bbdKhM8C3frEgJB+J1kIBzr9AvT/XurRpbIcFlKOD1qG4xaOi/mD2V81bNG
 1kldllp8NSpWvLaVYHueveP+ThsEiMd07dDA5B0h/6FOUgcZAIY4Syvw+E7bxxIH8+3T
 H4Mw==
X-Forwarded-Encrypted: i=1;
 AL+hErGLDEbkiCEHD71d3F2fRCB3JnBBlqvpVtPBETAWuLyiYmtfvkNx9nr/ElhMj+/YiKUBxgN3j1Ibvvk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+IzpY5b5bvUZvY7P7JWdxRHAN/piAGbL9870UXRcb+KNtzunYV
 dYiWnAp4EqmeVVvTuW4T1LkbXekuSBw9zqnGGrV7UlWummvjfZP8JjsVFn3LtYX/7mIIibuAg56
 B5Oxpg2EKT463FfoUFiQ9CXFhQOiFjog0DjIXdjx4Yoj0H19uXWIHABx4fcbMzBeH3RCvePk=
X-Gm-Gg: AZFdTZcobM9g+tQdt2I9BKCL3ISScnYpKY9FX9t5r2y16UokA311XsPWyfWMkE9BTJ7
 tU0YqkyIvpxcway22k2dW3JIFjEYk1yix4uffbTndpFpPTjfzlqN3vKTBuFgFR64t7FvNFlwJsy
 8Wl/l7DlMQHygq7dCynf81KPWKEuIjZagoCCY7YEFTIhF4TpmaLoozuIDPSIOlSRKRG9heLefN1
 bIQXOhLRgl+q7myROvg4PyHk99tFrecgt/tjv3TkuVZCuqOGG6hETsHc/I9hajvrZUPgsm9Vmsk
 xblYxwzSv+tSztuLePe6z5sGkbXTHfg3Cx6pAP+Y0F74zKnS9KtzuG68SDDzDSp1GHlcxKjXhVN
 kTYYWRbkp4VqlRcsaBE3kyTHvR+SvQSxNr3b8pSFXx8zB7QEfQ4WyOWWgKw==
X-Received: by 2002:a05:693c:8953:20b0:386:a70b:75dc with SMTP id
 5a478bee46e88-386a70b7837mr9602078eec.11.1795565214608; 
 Tue, 24 Nov 2026 16:06:54 -0800 (PST)
X-Received: by 2002:a05:693c:8953:20b0:386:a70b:75dc with SMTP id
 5a478bee46e88-386a70b7837mr9602057eec.11.1795565213947; 
 Tue, 24 Nov 2026 16:06:53 -0800 (PST)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c371esm47494708eec.23.2026.11.24.16.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 16:06:53 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 05:36:41 +0530
Subject: [PATCH 1/4] dt-bindings: misc: qcom,fastrpc: add hpass label
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-fastrpc-hpass-support-v1-1-cb1d46b29e3b@oss.qualcomm.com>
References: <20261125-fastrpc-hpass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com>
In-Reply-To: <20261125-fastrpc-hpass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, quic_bkumar@quicinc.com,
 quic_chennak@quicinc.com, dmitry.baryshkov@oss.qualcomm.com,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=aPJlOr9m c=1 sm=1 tr=0 ts=6b06269f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=EyBXVfs1xlidXAZbQhwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: aDseq1Nv_j1CgoxcZoMzpJ5HcVzPJzIh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAwMCBTYWx0ZWRfX5DYc8p4IN/lQ
 gnT10fJ95AZHLXFsb/2fSBe1mBGh87doexyUDWEAb7EVeQRvXoSx0pw7sMgcmhXbTrVxCoktaXk
 FG22FUsza2jVWKZh7zUPR25Yy5rT6g9EhhpX0fBygUnypXag3ZsrqUlCr3wt4DWYYrsxeabTse4
 8sDrNihty2l8MkPqAff35hgyqgp7LcUj5hfrP70o+iAQtKjXmlrYYr709ib6EVNNqbTpTCikNef
 k5UjV3B+712qUdyitVrsbi8awWX3VBTWA5bpRav5xYCEvVlhE3/Lbs346HLMQxUKfYgfL+JA9uz
 w+SrNuStUjvWfFzlSLVuIzHeQJT+VYj01EtWEjqM091pNdRhGnHxCquUM92b57SF/5uD0aeBswn
 3YhUZRrrD38jMHj32Etk1AjLxeXSohR/1lxkLhCm9elt2b97WwihhFTe3Nxa9SkJ6nCzEgEm9OM
 nAba5AD/LcZK7Rwbp5Q==
X-Proofpoint-ORIG-GUID: aDseq1Nv_j1CgoxcZoMzpJ5HcVzPJzIh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAwMCBTYWx0ZWRfXyktcm44Fn/8d
 num/Px+AfjtYWpEZ+56OvvTKHb07X8sq7JAPhD7g4V7zRQWTZsUDV2SkdMkKkMwmixZAJofx2mw
 2IshtMNlNskkfeOqO4OaEfNtOhnEdsw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250000
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

Add "hpass" as a valid value for the fastrpc node "label" property so
that a fastrpc instance can be attached to the HPASS (High-Performance
Audio SubSystem) remote processor domain.

Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 6b6ad95d5cf4..a7f7504897a5 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -41,6 +41,7 @@ properties:
       - cdsp3
       - gdsp0
       - gdsp1
+      - hpass
 
   memory-region:
     maxItems: 1

-- 
2.34.1

