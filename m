Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803FC60A263B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HkPJt1Mn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MqSi51iG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB7BD112747;
	Fri, 13 Nov 2026 18:53:33 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2969F112598
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:53:22 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRE4u1190175
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Kz3mFGDHm3Y
 L3jNa7eKBXnIcdFzL2ogUPI5D76TH/G0=; b=HkPJt1Mnex7OSeyub8dctliLFSn
 urMff/xho4+9KuVSN2Bo+BeIoscTfRbdl9rpqLpsaeHb+gQ6IvqcFvUOAdD9mM3S
 dQSIXqAfcnTtLccXZz63HzodmTRDoMvuLDElNxh25ME5na/vFTfEm+PiSDmMFXFl
 doT07fDHnAEC+0dUKnq4D/AFKZ46uJQis49y35PuJyDKpgtbuH5BhTfMcGXNHd+v
 lyDVfQky/EpgemZtLok45+BYeqfExpyEeP+UzDB45iogzvx5G53QzM6d3tD32bU6
 /aSkyLD3Qg0ZSPFwCt9jUDxnWL/nkGkd1bcHx/bN8LOPK31STXQiBacWdng==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufkr6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:53:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so1566938eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 10:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794596000; x=1795200800;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kz3mFGDHm3YL3jNa7eKBXnIcdFzL2ogUPI5D76TH/G0=;
 b=MqSi51iGxG0RqrNX7rqYKUBMnSq1l5E8eR0iWyjV5cQHQM7Ed503iVJG7DmFQnTHN5
 JXUBnpCNVApnR2lH//6x7LF9+PURG+7mH7fmEe2m+eHysmd6rlUZRVnmeEZwALKfy1Aw
 BFMcII7tZB3giAoUW10h672DX3cMD6M0r7FRGyPdyurkrbLi5zwwL5d9ZYqxY3g/RtZ9
 EVEtWytZO6Wt9yfBvnIy8fQ4ohhJPBLvVUEExONoKhgop2PRrXxTnrWFa5UKPt+J5goG
 Ar9tvUg+D+SML0sBj8s7DHp179eKSGzUICF1SejpCl1+XsUiITJy7D2LD1wUyUYGdtsV
 694g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794596000; x=1795200800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kz3mFGDHm3YL3jNa7eKBXnIcdFzL2ogUPI5D76TH/G0=;
 b=zObDjyaD9FJSHsSGeLabFP4/hN4/QJ/5TppKda+B/jZgUDRxUf9ofLxyB2cWSZeOBX
 yuLaFuXGSA4TNaB00SkyG6My1ZEXFKGeUCPkNrJIcBrj0pCKadvMB3yKDfYFrLU/Ozuw
 IWyGU2Ilit8qoYDiqbii9lsXWuP0eirTpParpoc3E/A6KInJgaOIGOjKK0Isk3Bmao5r
 aTmHKM+aVRpPrdF3J2UFgZwupWQuwrVtQ+ucTHChn6wNL555T6rMnTutrQxMnKb55qRk
 5wkKbfKHCX76Ztc+fYsR6E7jmMZxYuj8V+WcontsM2gWk3Z3Qe9SX1sh378c7HQVvl/1
 sjYA==
X-Forwarded-Encrypted: i=1;
 AL+hErGUEZ8TtdBFknGmJBDb/dvNQovMUUb/TEpQF6nRg9vlawpf+04Y8/M2363Yv0LsqoxLLEVRZAsVEDM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9yuZUHfyJFLXl8Att/aUZ6Xx21sLMYJKTl79OtB6tQOxLx8Ix3
 ZwY9ivGrD4fNn6hdr81ZEZZ5kElYmGZKQP/WOKISfI4JHVL0ouMHGxQaXgiF8AWjf3OMp3QATax
 C76b8FIREAvTGUQD28qa9jV5+qAS8L09tp92S32zNF5k/eWnTRBKSFsHtfKKNfoC4pd6XXSg=
X-Gm-Gg: AYBFou2KzriCdWDjEXPv37/nVYCVU+OUvvwKHmclq8ZPJE7IjaoehfyjMu8Lru9ZKjb
 Hc3MCPlqnKDBOfczhJ90pvJFR1Fg1LcaWdc1NCooWucbnWziPfURHTc96ktgsMTCHNsUW2McoLM
 mX5F3C8GhvGR0IfJjuIagRWzCoePv47EoowP7wZLK63Isvoisj+2LWXBKO5MdGmCUKio+jXMwZ7
 FIiEH4g/HJ8tuu3FrGewQ8ezBB5G7hyTmOo3GfLwVKJOFYCIWW5dGgpv/i1Tzl7XumyfKWIF+p7
 RzzHyom6SXk1vC7rjiPtKa3BTXGPEY7lE0PpZiAkTYfMP5Fe6Dp5cBEjdc33CabSOH4CBczQR+9
 a23Em0xzhjWKMhU6aS9/fqCo5N7FRE/FK8K/wJpjfThh9wafWu0qR8Dl+SF92N9DgxZouefJlJc
 Q=
X-Received: by 2002:a05:701b:4504:10b0:15c:1679:1cc7 with SMTP id
 a92af1059eb24-1b50313d80bmr2955474c88.37.1794595999661; 
 Fri, 13 Nov 2026 10:53:19 -0800 (PST)
X-Received: by 2002:a05:701b:4504:10b0:15c:1679:1cc7 with SMTP id
 a92af1059eb24-1b50313d80bmr2955427c88.37.1794595998965; 
 Fri, 13 Nov 2026 10:53:18 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:53:18 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 1/9] firmware: qcom: pas: add qcom_pas_context_init() for
 pre-allocated context
Date: Sat, 14 Nov 2026 00:20:01 +0530
Message-ID: <20261113185009.157893-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bmc1rpiVfWUHjG3XAliBq6lmfvIwzFDA
X-Proofpoint-ORIG-GUID: bmc1rpiVfWUHjG3XAliBq6lmfvIwzFDA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX7uN+iSBP+0v8
 1/g0aPFiixxuwiwI9E5EkX7ov/Minv9/1ALWmIxUdPbVeUUsG7Mxv/yo14/FoDNz0BW0Lh3h7SN
 22pMdkBHUWDO/FdeuA74fU4njuVJZ5sfKoNSInzwjmGt4uBKZn+k5eabduakuvDQ5AcSvCTvAvv
 E2WAZ/MBua6JBi30AO5yVOI1XYlGjRK5yYtmQGAz5OP+/exGGA/RS9jXQigTOH/qlYGBobqhuHU
 7rNOu26Gpdx0ZukjTaVcdjKoDAKEc054HGPDuvbEtQwebf1wn+pc41jWc+HwJlRsfMcJc4x/8kz
 ofTXlGUoZ1I+/vtXRhpf2vSJ2vTWasfVLEhYXRdQ/fB6OCq34W34bP3jzVT1rayR2FT0jjfq1o3
 e2PWioxXVCn3iv+8HvFgXPcKjmBfa4MGa2r8OiAdgXfBGIc+bt+ys8W6+t8FMip9GKkJ6wVFF2a
 1WvVWqzd1Oq6NofteCQ==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af75ca1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=O747SXQATtv6IwqlEkcA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX7Oe9bD+Df5Sz
 DUvxQZ7JgMp0Md6oKiWn23b42948LiLyKtCk9WfWP+Vwt8Nayr/VdhJt8g2S4VTODxMK3aLX7T+
 +z4LYHU92UDbGtUB381LaucdzXr6miw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130075
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

devm_qcom_pas_context_alloc() allocates and initializes a struct
qcom_pas_context using devres.  Several callers, however, either live
entirely on the stack (short-lived helper functions) or embed the
context in a larger structure that is already managed by other means.
Forcing those callers through the devm allocation path is wasteful and,
in the case of functions called on every power cycle, causes a devres
entry to accumulate on every invocation.

Add qcom_pas_context_init() that initializes a caller-supplied struct
qcom_pas_context in place using memset + field assignment, with no
allocation at all.  Rework devm_qcom_pas_context_alloc() to delegate
to qcom_pas_context_init() after the kzalloc, so both helpers share
the same initialization logic.

Update the kernel-doc for qcom_mdt_pas_load() to reflect that the PAS
context may now be initialized by either qcom_pas_context_init() or
devm_qcom_pas_context_alloc().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_pas.c       | 26 ++++++++++++++++++++++----
 drivers/soc/qcom/mdt_loader.c          |  4 ++--
 include/linux/firmware/qcom/qcom_pas.h |  2 ++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
index d74dd7b4f332..fdf62003fbf1 100644
--- a/drivers/firmware/qcom/qcom_pas.c
+++ b/drivers/firmware/qcom/qcom_pas.c
@@ -14,6 +14,27 @@
 
 static struct qcom_pas_ops *ops_ptr;
 
+/**
+ * qcom_pas_context_init() - Initialize a peripheral authentication service
+ *			     context for a given peripheral
+ *
+ * @ctx:	  Caller-provided PAS context to initialize
+ * @dev:	  PAS firmware device
+ * @pas_id:	  peripheral authentication service id
+ * @mem_phys:	  Subsystem reserve memory start address
+ * @mem_size:	  Subsystem reserve memory size
+ */
+void qcom_pas_context_init(struct qcom_pas_context *ctx, struct device *dev,
+			   u32 pas_id, phys_addr_t mem_phys, size_t mem_size)
+{
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->dev = dev;
+	ctx->pas_id = pas_id;
+	ctx->mem_phys = mem_phys;
+	ctx->mem_size = mem_size;
+}
+EXPORT_SYMBOL_GPL(qcom_pas_context_init);
+
 /**
  * devm_qcom_pas_context_alloc() - Allocate peripheral authentication service
  *				   context for a given peripheral
@@ -39,10 +60,7 @@ struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	ctx->dev = dev;
-	ctx->pas_id = pas_id;
-	ctx->mem_phys = mem_phys;
-	ctx->mem_size = mem_size;
+	qcom_pas_context_init(ctx, dev, pas_id, mem_phys, mem_size);
 
 	return ctx;
 }
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 0d55e9e0af3f..c6ec67e1da09 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -476,8 +476,8 @@ EXPORT_SYMBOL_GPL(qcom_mdt_load);
  * firmware segments (e.g., .bXX files). Authentication of the segments done
  * by a separate call.
  *
- * The PAS context must be initialized using devm_qcom_pas_context_alloc()
- * prior to invoking this function.
+ * The PAS context must be initialized using qcom_pas_context_init() or
+ * devm_qcom_pas_context_alloc() prior to invoking this function.
  *
  * @ctx:        Pointer to the PAS (Peripheral Authentication Service) context
  * @fw:         Firmware object representing the .mdt file
diff --git a/include/linux/firmware/qcom/qcom_pas.h b/include/linux/firmware/qcom/qcom_pas.h
index 1d132e89536e..458075868bf5 100644
--- a/include/linux/firmware/qcom/qcom_pas.h
+++ b/include/linux/firmware/qcom/qcom_pas.h
@@ -36,6 +36,8 @@ static inline void __iomem *qcom_pas_ctx_map(struct qcom_pas_context *ctx)
 }
 
 bool qcom_pas_is_available(void);
+void qcom_pas_context_init(struct qcom_pas_context *ctx, struct device *dev,
+			   u32 pas_id, phys_addr_t mem_phys, size_t mem_size);
 struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
 						     u32 pas_id,
 						     phys_addr_t mem_phys,
-- 
2.55.0

