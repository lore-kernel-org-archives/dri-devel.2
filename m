Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDCA606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T4VOQp4a;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cmmHAdRO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D1710FC4F;
	Wed, 18 Nov 2026 13:09:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE08F10FC4F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:09:01 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AICLktF1179228
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2uypBfXz8UgmtHwzBAp3Qn7tdU0dST+3c5sXLO043nI=; b=T4VOQp4auuCF9d9K
 dBHRh2NPdzXmVqAAFD0hc2u62KM5OEl7D568svnolivrwWvMGWT4YAkLqRQKL3ys
 2ONpsT87RsvGWKuaMSSxGuCSVvyySbpvhFVJZQaw+M15oSC7M1jdg7/rdGLkVhdB
 r6ZwcAEKkdDARSpjU3xymD6vzpyeFcfjGJsWs6PVDfKkstEXieTD3yo22KeDKEpq
 B3Hjd0fdDwKy01K5vd1/AXNlfevRivlMG+/7stxrYdNKoxf1KP7i7HwXzy3wWPE2
 8Rg2caG//hOPQPoAxKTiGpawn5X8toF3PfsOVk8urDTKSgKZERlh0UNI39aM6fOO
 2wFb1g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvck3sw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:09:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3b3c3a75d9bso164711a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795007340; x=1795612140;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2uypBfXz8UgmtHwzBAp3Qn7tdU0dST+3c5sXLO043nI=;
 b=cmmHAdRO+8QjuPP6kTLy01JqTleOmmGgoqLwY+h1FRtt6dIp5hYpm/6WFAM27g/Sse
 Sa1EoutswyIQDPIneYXfIncGe8TSxPEbgRFvU80uMnbmwMM5xChFjOfKqhc7qCbI9eXW
 s0hIxWkqwwjFiS23FnzYjHA0b++KyatNlorGUzHbRfn/Cbao8uyyKJKghMI1c/vQWHtY
 ovn0Ag301lgNoqj7i0hnWZtHBeom/80mXOKZlJs0s/xsnkrj3qemK4Stv9NNOHF0UUDF
 fmqjWcQRZgq7tFBrkYRzHs4P/sHvmmHevpyN0vT4jTcRQu7wxuauZT55+CJhmqB+314J
 SFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795007340; x=1795612140;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2uypBfXz8UgmtHwzBAp3Qn7tdU0dST+3c5sXLO043nI=;
 b=CpUSP9Y8Homyy2m9sHYHS577CLGb2l7FmPRWJ2ht1hMmuqzsVYJ/u+88m+js7XN2ce
 BUkkOibsU5iuSyKORwKsHXvoEFs7LDhPPTNvl4LkFK0ySm3scRKne1jDKYiCffBTeKLC
 eXELteydrWQ+D5tKqJdmf7cVg3S6x1lGJfWcvJK4pepDrk/r136Jk7xNRlMOYDw3MeMP
 OuIKntKKgk+pFJG7QGdZS1nsSTTG8qyeGS3kdfjuT3Sy2JDuZdmmTdu8GCL/jod8QTXW
 x4FhpMkWSNgVhZ9zBzHxpkczoxq/mNCEd+/6quVqcyjv8f4ln9ib0nU9jK+3xfjTb+6g
 qkOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEFePzTfWykqhD30yqHxwbIH+J+pH3kAbYJti8yhn4xYvmcdcMekQXGD5BxMCmWqTE2U9WEpICCKyw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8r9fuadMIEeBZrv+6L3klsKM/+0WyEg1FzpUsuymAzP4ut3WtS
 MLlfTzu2HxUoLFkCVbL+3fcuay663eVf9VayN7zaz2sAKB6p9C3iPWWgn14XQZ44YwxCtdBacKJ
 XIhZ3+zyHUo3s1PqtPN4pvwUb6X1Ls9Agh8XFVxLJfxg8Gtxp35Nk6m6/PfMSEvcSJl/pvoY=
X-Gm-Gg: AZFdTZdBJ/Q+t8PuJ1+PTvPVtBQdyFkA5++MqgSRCcDej7/4ObEMI83akOHB8oqnZIR
 /2xH+CCuo1SL6+Kd79wAxxyfP6v83KYuYJLy1DIY6YcCf57f0/nYM27c+wClN1zLU7Q607ilII/
 DG9SI2LnEQlgeGLQpQ3LWf0tuylScZcAZYyuK4F/FHxTQ9gpUDsepvuEAhmuBiszrhU1zETfd+e
 OFlP+RKu5tPtJHP4ttIPZPrfxdPSC7OGC9xpJqp+dOq9GNae/7kAXfwEen/0b6CDj76O3x8EkCh
 gnCKam14DgOBlw4iv3RHtz9HVeyojfxNUnvZgDhf8ST59LUGU4MEWj+cAhoxYE0m1o9XeqAVFn2
 kj+tpYmFA4lLuSS89Tzds9Gu9NiZSWjruS4FaBGxwBvnDnO5IaU0ShEfey1+bKGzk9qmaKNle34
 ndqbHtWu4X
X-Received: by 2002:a17:90b:4acc:b0:3a6:e1d1:e511 with SMTP id
 98e67ed59e1d1-3b3d07cf0e1mr4603052a91.4.1795007339485; 
 Wed, 18 Nov 2026 05:08:59 -0800 (PST)
X-Received: by 2002:a17:90b:4acc:b0:3a6:e1d1:e511 with SMTP id
 98e67ed59e1d1-3b3d07cf0e1mr4602998a91.4.1795007338997; 
 Wed, 18 Nov 2026 05:08:58 -0800 (PST)
Received: from hu-pvgtejas-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d187dc82sm4909533a91.6.2026.11.18.05.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:08:58 -0800 (PST)
From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 18:38:27 +0530
Subject: [PATCH 3/6] dt-bindings: display/msm: gpu: Document the CX SMMU
 aperture region
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-adreno-scm-fallback-v1-3-e99cdbf3121d@oss.qualcomm.com>
References: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
In-Reply-To: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007310; l=1153;
 i=puranam.tejaswi@oss.qualcomm.com; s=20261118; h=from:subject:message-id;
 bh=syT63WlPX5IX60Og46wRhxhDoNsMAf3uqJqj378LbFs=;
 b=AwXTBw49z4p7aFFLjQBcN1LRUTfdmns5P5yqUq3KJultc0/Mn8btNjKyQknvqqXpLMd/RFbYB
 QRYATkxT2w2CoLGoDSZtDBtxz0JBVYCOFRfjbzMfF/Oal9q7m7cP4tu
X-Developer-Key: i=puranam.tejaswi@oss.qualcomm.com; a=ed25519;
 pk=I7kFxZ7dcroo7ZWUatk8fR/J/KVbRzZq4ZBLhRRGpJo=
X-Authority-Analysis: v=2.4 cv=R5OWitRX c=1 sm=1 tr=0 ts=6afda36c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=kkdt65S5UFh8r35K3toA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Oh5fuhyr461wSVWfE0jq7prjVScZv0Ds
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfX+21coN2S//Xc
 0mR9aE1XFm8Moqs/qJneHH/Iy6C/WlMzQ3MCCGsHcelrZCRIPZ7rY2tvea5mWAC27QYXV+HTZF1
 1yLxGCOWFkRNUxcPNv1pzO/7MEosDGo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfX+yx/MNS4JNe2
 Tpibzxe/VH/8sI3mh2OstFoz8rJFDNUCFPsAGrhA3+lreBjAiZKYe45OG/UAwjDBh8396PDo2/4
 b/3JcAcLye50hk+W0r6qcraVtaEmYQ2cimziZLI1aAPL6Ol8oA1ImaN4KCvS1AsRjMcofCmLe3y
 1NcOcYTaHfJ4kvYkK+uEfGclWCjfBjVU0zO0C3osBpD5cJ1bs3gpSlqIqVzWGY7J7XdWO1q4SOw
 dpb5NIHn5Zwx8/of1btngiOJ/pOreSRTXo14qwPpAz/4GgkQVQK4rOAh8C8/zSxQB6iOqj2WacG
 0wtS5xRCnghb5iCvBmEkqfbi6dVmjuN7+Hdd6+bTiA5cqfY7M6siLb242r3nYzdLrm1Fw3r6fin
 e8tD6J4o1PbUY8C9ZYZorInAoO8qrurAZUf65x9fR0rtTxAL/lKYk6SSoUir4LeeuPyhtKU9vfw
 u+qizB+2KWMjICadusA==
X-Proofpoint-ORIG-GUID: Oh5fuhyr461wSVWfE0jq7prjVScZv0Ds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180052
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

The CX SMMU aperture is a register block in the GPU. It holds the
location of the GPU SMMU context banks that the CP uses for pagetable
switching.

On some GPUs the block lies outside the existing GPU register regions.
Add it as an optional aperture region, so the driver can program it on
platforms where the secure world does not.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 3c90a09febe7..5e4f3149839e 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -54,7 +54,7 @@ properties:
 
   reg:
     minItems: 1
-    maxItems: 3
+    maxItems: 4
 
   reg-names:
     minItems: 1
@@ -62,6 +62,7 @@ properties:
       - const: kgsl_3d0_reg_memory
       - const: cx_mem
       - const: cx_dbgc
+      - const: aperture
 
   interrupts:
     maxItems: 1

-- 
2.34.1

