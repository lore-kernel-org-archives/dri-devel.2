Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036E606A883
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iaOQbQ/V;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ChNNHH9A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B11210EE8A;
	Mon, 16 Nov 2026 16:22:37 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3041610E1A0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:16 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGISQU2790077
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=k5XQA/BMzue
 iAfY2ScGRfdX/31fwXQIQ8yG08xIXEKI=; b=iaOQbQ/VnwK28Q7DB7onLCF1Vyv
 PQESzDoSFO1a/4RMUY/krilKAOkTsodyyfsg7daDC6nWKq9wBQINmJI4VospHbQu
 v4AvglZihlgUcqU0u8uidncVsg//B3evdhwddZuDa2qW8Sl/Ydbslys2C7JihE9b
 Ehd4oFDFdgQGVzgVIGxsKlcnIhBP9OljwUArJxBY53yks6K/IVXxiKaBrnsV5g0V
 +jBey2O14f2+UkW6oAtbZttFS9buS3FX5nOhyFT0AbtX0kepV8qrBdWEXTnO2m+b
 3o3dBNvbZgBtrcbRlwaXQan6GqLEDs/0yFEA3NOfdGK6LczaMljfKnoYqQw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j00nfh7rh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:14 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso1724577c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794846134; x=1795450934;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k5XQA/BMzueiAfY2ScGRfdX/31fwXQIQ8yG08xIXEKI=;
 b=ChNNHH9AXoL7dLOX38OmiZjBwMtJknaTLtmlMO44Q1o1/w+ykqvftcgg1f9A4FZVT1
 e3Q2deV+1bLCossK0Fq2uK+Z9p1Vr5Ny/mVcM/Am/QUhPkyguwvvfSKjGQoO79gL11/u
 ZkC2xO51sMPAGkDkgIoHX4uvHHO0JoH5UrSw1BEQ/vFypgjex9m3IYRIqwJ1DRkEpBQu
 XRgNefxA+GIGllpwO5R2DCSAUUJ1f99ONZ6h3jz/Qx7du2w8/EaI/hUQzoLMWtNsQDie
 rna6265mxYljpUL+tgjOVttbb5FJxujaIGGXNi7fCzupg+PDxgMpIR8f/WE+FkjWbNZu
 9nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794846134; x=1795450934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k5XQA/BMzueiAfY2ScGRfdX/31fwXQIQ8yG08xIXEKI=;
 b=E6cS27ub0fmXxR37C3N7bffLMXlC/bGnZ6UPZj/xdeJbDBeoyUf/8xU2sWzEJoOh0z
 NutQu6/uMpPSHPOqBVR0PjbEzQ4l+tJoNu6EC0z3txkEes7RVQySRwer8j+lSCGAhtD8
 SNcJ2HMBQkWDeWp/diW5P6IkSlGBzt8Bnt3QU30xCkmXm6tyJLKR8czKw2hwaN3SFcHu
 0NWBmac0UIMdNShMmq7HUF5xcGnQ+J/gQl/hRpVx8115++E5/gF31/3BG2Glj6dwZYeG
 9REQgwZRt1aF6z+5oW7UQ79BW5UBqPr07X+2oRg++8dK55g/2abxEv1F/7GhnzSv/gzs
 LHWg==
X-Forwarded-Encrypted: i=1;
 AL+hErF6CeVi6bV0j+BC+8TeRVUIgeH1mTfO85rA2gSgLYaKMHxRwgFOclxGP8ki7vkCfFByCNkse/6yAm4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9PNzMFgM7txqm3CfiRr45g7d3JFMcpkFYrcWsAVKw6YFA1J3Dv
 zDLCV8QaJjb7BSgLxaDrFyAwlTHe1/HLNJApqxw/QUp7AIgQP7zeG7wPkfj5FGvKoG4JowQ8Mir
 3pzKXx+0Ih07Xq3ivwgCzZTXSFdFe9bFQAneiiOJvO37JjYlqvpBxKAQ9/F0OfXubeLWqkRM=
X-Gm-Gg: AYBFou3KGxtiUFh+h2sNy7kXSo9ftSt+jRbkkTXfBgUHYT//Y3hjvemekCq4z7psguK
 pfvNxZM3MHnL5ea54la1NNNm///xxN89u52ijfapW8UM3/p4qWUcKVlaXnhEqw64Qdy+qjoWiFV
 U8ji+7NTSkmla+0T14044Qq2wGpZikMsywamQFHccgoVNgD+bhDjYswG+cbwJVeZAyjlspEBOv9
 dA4oAd7X+pgAzCNkV3mn+UzNyIXCQDx+9cehpoKgykmxBF0co0pdL039RP/P5wQU7nXGUykC62L
 iYO30A9A8vw07emBJz/uf3L8ReW1GZhLhQvZui4aYL+aAyTCWYAVuVsAbT0WYdM9vXJmgNZDktu
 LKA+oow9NmhEMwSdtJRSLniWZWQvgEa4iZbFSwnlpG1ArIzVYzSe/sEvrj440AZJwAHt0Gne7KZ
 dU
X-Received: by 2002:a05:7023:a4b:20b0:149:1feb:6d9d with SMTP id
 a92af1059eb24-1b5030fb74emr12065907c88.19.1794846133566; 
 Mon, 16 Nov 2026 08:22:13 -0800 (PST)
X-Received: by 2002:a05:7023:a4b:20b0:149:1feb:6d9d with SMTP id
 a92af1059eb24-1b5030fb74emr12065862c88.19.1794846132861; 
 Mon, 16 Nov 2026 08:22:12 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031468b7sm38623826c88.5.2026.11.16.08.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 08:22:12 -0800 (PST)
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
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Alex Elder <elder@riscstar.com>
Subject: [PATCH v3 1/9] firmware: qcom: pas: add qcom_pas_context_init() for
 pre-allocated context
Date: Mon, 16 Nov 2026 21:51:40 +0530
Message-ID: <20261116162148.2864501-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BrEIUoX5 c=1 sm=1 tr=0 ts=6afb2db6 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=ee_2aqc6AAAA:8
 a=EUspDBNiAAAA:8 a=A8JJMgtFIkyHT4jqAlUA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX/gXDG0SxJh2K
 FBvWz4FqgdR1zXFpox68oTtAIEH6m/U3QpOmOtJp9u/HukOh0cvnhN9TDQcrH+hdholnGJptVlL
 GejDzz2VwNMezDtUT/M8NZWWt+L5wDs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX1S4zHoMgdzkN
 gktYlMk2lVbvkmJ2JIU6qNhJ6UR9k9yWYydXAM9RDTvhT5DDGOT8Byk5P54Z5CDNJ9cvAg3qQoK
 hd/ZWF/xFENn0Owon+K/I+bWn9ZRaKZHwHBzL8+Ata24/xDlcJIDoR9/bmmRg2BfhpwWTvg33ld
 Z0uoVQlBmH3juH6Yaj/IMZnhkmRlVBfY8sSx3sjdFn5a1O1PYuTpxw0MmSKz096UVbvr/fHERYz
 vvRk4a7O8nsHO85kbbIX6ssgw1MffDp+eMShYH7TbizfTSfnCC5Ym9CauGrUa+uq4N/4HuO4y4G
 GZBWV76moDyulEVOO+84x5NPra2K5QQCKyst2rx7ISR5QChTNGc4cUFzoilg08WDlpRQa/6+iq2
 NbDe4GhdGq6NPm5ufxmMgzDDoLcyDqeX1RAkTAjaAPE5OPiHdamwljI8YUj0TM5ov6+rvRJju5f
 IYp40WD8tIyiADSPDPQ==
X-Proofpoint-ORIG-GUID: 4KQoHx6WLvGurzQm_VGwnLxnUQ0rDYIt
X-Proofpoint-GUID: 4KQoHx6WLvGurzQm_VGwnLxnUQ0rDYIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160064
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

Signed-off-by: Alex Elder <elder@riscstar.com>
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

