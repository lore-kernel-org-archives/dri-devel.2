Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B84C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D9910E097;
	Wed, 26 Aug 2026 13:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hsKk+H57";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DCFxwnjc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EBB010E097
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:26:19 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCCG55882046
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KQXRpTTPtzwVRvlOFmFAjbS+ReLpP/eRuTZel+cLkNE=; b=hsKk+H5771OI9it5
 He3g3qO48bKWwCjKTk57F13lpBTMKXDbRsry1qFscqo9CQORgDq96B+L/xt29p+p
 KaCUQeQez85fjB9H1sjmt8vYsYrwk9ThOSiW/ZmSm6KNk5DgMg227B4LGVQMu1vO
 VNumkbXgSynlrKXipFBhY7i1v0Ex9EwNzt38x/dhE8CB1Gqgzz60CbBigJ9UoNNP
 xYi+prkWXzy3YRTdKb2p3S3OcivPceA09E5BN193wQRLt/DqMoTraEiUDedSujGl
 xJ3y670j4kTl9kWOfvgluQlzZ4iXmZ5q/PV/JXJidtTRkrrYqDIEChxwsDAlPZot
 tE1Ahg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k2apg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:26:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e11baa66eso2012194a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787750778; x=1788355578;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KQXRpTTPtzwVRvlOFmFAjbS+ReLpP/eRuTZel+cLkNE=;
 b=DCFxwnjcpdy0IdjAvENa7RSzxbv9Uh/IeSREF17YnUd4rQ7Zm7nITskTdP/TCMSK3a
 i+HiOKGatt2pwBEZG7uerFtAl8IjNZdv5CE2IdhpBpgXg1r0UV0ADXn0QYkDffgbdRWu
 twy/lKs+ehfkl/e2sEQSP129MMqqQ2ybDMSUZhmbxUDVB6rpNSHnG70mZk6Jk/VXbgrD
 22bYx1Y2M7q8+6/tx12CqbymaWxFZ0mLrrBUPTJm44eCunRgs0/8CU0pqKrcz7wnHYNK
 co4zPxwgsFu8xrS9tssY7mo6BX2uUdwbNs994eFsy2xY/AZgIQQlwFA+S1x+Ze/RRv88
 uhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787750778; x=1788355578;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KQXRpTTPtzwVRvlOFmFAjbS+ReLpP/eRuTZel+cLkNE=;
 b=GzGqcr5L3BiFTGkNMKHZOz2QAESEmJeZxoNhKsgC+KtpicYDfv9XwdJudR4TS03etU
 WvS13CwjQJzuQuYYToGytdwI9ktgoVNsLXsWfjNRhgV8l5m5d29mk+k20gujOIhR0hf0
 BxH/UoDnMUTTVMi6N9eMR5ZQ5g2vccfCC452Joe1/oubkjArvFnULTZ/BCs1WVokD0GM
 Srcyws52Ah4F8HbWpF4Y3G9FHspM0Bcv56/wtlEzaH95/39FA+oJwEAXa9GpVZjAgXih
 UvAjWEr6tD6yw1H8H8L1cfxU0z67D2WhrcKZQelEhzF/B8keW7xYFJq9gi2IfUi29Bed
 4L9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RotKJJTm0qU1R+rAQNnJ7OZFkoMW86Gv2HzecZZTF9cVdfA9sUQBB0DJWbz4oBltmzHQPOU9ht06zc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kZsK+BBbJQwv42qTGDG2sR1ahJXFT+fR9YUxf7xgznPxMelnhl
 S1MSt11JXLLRcayn5HKxNO7YTaRl5U8ZWkdq/qzDNSH/hXkrNGKOJ8mkHKzyUYINQ55ZALBp6Oj
 ZnzCFu/xvxsRcR/S4a+p/WK8p5JgVUFYLBK9vr0r42eZFtPA+CPXN4YoJivILjHWaZMLCHJX0LE
 q6Lm4=
X-Gm-Gg: AR+sD10Y76v8+wXm3TLZM1iHA6iZ7nMjuvAKNeiHObBQH70SQSCBP9RsxO9djqEtr9H
 NUTczTW/QNERpZRbhIoiNx51Mx5YOGHgHvUnLzgjdYMiVbFsY6zQ8YNLgYAzYbMhlZEpAOZVgA0
 eL+wy1Gm4yAxa1i7PDgzi3/qRKmZnbDpN6k8vG3cRlO1ymJjEiZMQ7TQyJfQYqZ34gYTCLMky+f
 f+KvpZN7YcxkaK9XRSi8sSRhZe6444vZSTN2JqwsBd41EFDR4k5EAxXM47FueAMVZuVituKOuUQ
 RiPFvZ8Vfed1XOR6N6GOkNkFwgNpMzWf5KPis9t2BBRy9sKtLI5ImIjIwBZnPlT5jFe50bYlxp0
 nK3MvgYIsCmlqwy3AVmH+D9xa63pma1OJrQ==
X-Received: by 2002:a17:90b:380b:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-3966d13a242mr13700632a91.1.1787750778401; 
 Wed, 26 Aug 2026 06:26:18 -0700 (PDT)
X-Received: by 2002:a17:90b:380b:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-3966d13a242mr13700517a91.1.1787750777930; 
 Wed, 26 Aug 2026 06:26:17 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668767d65sm4581108a91.8.2026.08.26.06.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:26:17 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 18:55:51 +0530
Subject: [PATCH v4 3/3] dt-bindings: misc: qcom,fastrpc: deprecate
 qcom,nsessions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-dup-sessions-v4-3-35555d2bfed4@oss.qualcomm.com>
References: <20260826-dup-sessions-v4-0-35555d2bfed4@oss.qualcomm.com>
In-Reply-To: <20260826-dup-sessions-v4-0-35555d2bfed4@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, devicetree@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787750757; l=1160;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=4EJ+Dqj+1p2e3D/bJWAuULr9rdv/qA1bb0r2/Z+2fTQ=;
 b=hKxSee3N2j6JpSIoiOSL9OI3eog6VQciN937QQPsq8R6UpGZiEJT1MF6VHtqLnTOd6+nbzI5I
 NdgVHbZYUk4AbjVTUiUcHFN9x1kRhlDqJimg15aDP30ZsTFUanOgEcJ
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8ee97a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=e51zU0WOd6sbzzcJbsAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMSBTYWx0ZWRfX6Q/qS6YjSDCE
 OsOcDmhk9yoaydc+ZUS2mIrDo8OCVnrw/2tPgEzMuvUN0SwTTaR3Ch3x1K4v0gqwywtDscZn/P1
 qgYIs48IN2KSPW4/q0ZBCUGHhNL/NPA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMSBTYWx0ZWRfX+lqYbn49Ux7f
 BvfrkJUnHKbaTH16n0WXJ9j64OMOaJJotxC7qHmZSZzAHRq98Gic31GVX+RuEjOZ2gRR9oXB8dT
 hcDpQQyd4Z7FAmy/sDvw7Jn44/6zwWQ02j/nxRmCyg5/qjLZ8jo27LRoKlS+BsoFDQ/g8AVnaNX
 iXT7J71OdKeOekfzAD0uWaWrMm4jot48qHB64hfvSXkUMCLjzhArWLRRGy6Q0lOqM8nri7g2tyS
 tOKNZXmc8VEwGPi5ksb9sNnQaDs+xO8V6ST31d1fa93GLLHCztMGVkwp8PmC/UCpu45Q1KNiBJu
 OpvhMN/iMtQ3IF4uwc14y0MLY4eEFrce7uqlhu89nflA5jiZwo/muM22VL08XhI1o2UiphM/B9p
 6OG9YOVqviZr3lk9YYMplHaCSTsK5kTI2QKYr6JGt2b200H4Vd2u5FN619aPh3Qs87tkEfW87H2
 +m95yuoJKU6MDQ6baVg==
X-Proofpoint-ORIG-GUID: xRW3nObc1Y9ZxufmwZIlR903VHi1fQo1
X-Proofpoint-GUID: xRW3nObc1Y9ZxufmwZIlR903VHi1fQo1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260111
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

