Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27205606A322
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jT42H1qg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JfFb8BLg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B654810F2DE;
	Mon, 16 Nov 2026 16:23:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F410810F2D4
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:23:25 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGIRbo1580616
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0iSH72bVkOb
 J6XNgFyC1IcqJNSUQhJ9lsse8nsmCQfg=; b=jT42H1qgiCDlGxRcRtQEi/B2bZF
 tLeo0XIzsD2ZzgGZ1ADa12XsOqaBp9cyGCq2p8uUk9/rm6Ajr+wzl+cz8hcddcZp
 hzpH2Vsnb5uMlvHk44AZdco3mxi6g3/9PHpgZl9fO+Ih+thxJf0sIyf0Z+FZ4ez9
 RhwtNAbAgQb9Nk2HMrAXhEsY4F7bFlhgg/F3Ro31pX9QZG2JTH9erOosOgvrXur0
 mHSqdEjqpV2gdc3j+3jJ/TLHjb7e0iObiLwLdFyHy3jLD4pgLJ1yA66kgMKT7sr+
 1gdxzWxHrdVqc3jen4OUX4MTUHuwz2YmiLSVsvByZIHt40MK+IdJ9javByA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j000g1csp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:23:25 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1a71dd190b0so5167082c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794846204; x=1795451004;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0iSH72bVkObJ6XNgFyC1IcqJNSUQhJ9lsse8nsmCQfg=;
 b=JfFb8BLg6pTIZfc36Kpv5bNyy/8w8ceSPLRLErmVUG1VTnjnG082iyuxnehaZsTel0
 /0quKOZRjwXdXjR5iuvG+95+uk0xrM6C/OJdeUbpFm1s6pOVqHQI2FfTJSc2SBVKME1A
 D71kz7SPsrZWLQrkTJ6mAK5njE7QLWPqe70gV8e0RXRJFf794ca4fGr6L/OvoUF9zsYR
 91ZnvRVyWCtkzEvTn0KifabJ7YWHm+63SG0dA7n4Qc1ndtiSO2cMHsfxGovzV8vjUi7Y
 xORJsDJE3sDUPQC+EiP5odF7MWRV1XqYpNEin0nYBkpJg/G5KtrNiVgne06r5Ahjb2lO
 XptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794846204; x=1795451004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0iSH72bVkObJ6XNgFyC1IcqJNSUQhJ9lsse8nsmCQfg=;
 b=f/veKwK0SdcYPyi8vOgq2Rq5jeE1ldL25HSCRP+frhPpXHP7zN+5Fc8F7RoTNx7UqM
 t8ldUZPAQhAKUzG1UUB7SPnRDa0lMCcUWzJBw5Ywe3/4PTqWscbO5gsss27f+6AwMBWf
 GXcE71fmnPFTVjAM/SFl3+Nw/HxIwYWenOmIlXmShmIyyM/KmklPaCTNz9TPR739Q6o9
 sTvHvyc14oGZHU2stpTf0jjKu+iqcRPrA14QR0GoeSJCfP9w4S4DhXcX3BVBawldBMQs
 fb1wmthvWlwrz52aIf0z+4ghdon2ZDdxuXykMWPA8cpmli23ens9hw+RpO9b8FkoHoa/
 iSzA==
X-Forwarded-Encrypted: i=1;
 AL+hErE7MvXblC8brovbB2z/8R2jpIzdMBWCOdGPe3gELhdWWGrRmLMdG/318/7ekLzhJpSaPKC7T3bTrlY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z96gMPOWoz07SbAZlSFX6XCw7+JZDqHFkVSy/YQ45OebWtJFmlj
 4Z2gwVVWPuUb1p9aRoNGpqGAZzA/kSASodkINfSHZShWacTfUQ9d5DXPzO042KptqfyHdiUwXDc
 7fw5iNvbuQSW3PgoNE8wGZe51fBRuBWSOmuMK+A2kJ7Duogf9jAL5GdtcltICuNP0aew0Uu0=
X-Gm-Gg: AYBFou3trPBIeWwF6/oV55VNm810WXYtA2hthJjwFciFtzNZiP1f5n9UjZ2YvV1yuMQ
 eyNOY4DG/YtD4CS5IrzfjjGdeTZb7aPaXBOemyzC1gO809p2BiPhmQdNotNqjYCHrPcZcd/HcPX
 t8y/1hK7UUHWFnOWkeHt2rU60tAFQJ0XVppy7SclrHgcSFFsJ75Vr9JBbnkPFG31ub7A/fSesGg
 BYM3LyMx3YfRuW7G53UgNBPPMGBAiapBDG9ql5FolnVeNt6D5ZhBaCg+ThN7hHAOiw+1mzffniJ
 pGfl+VuEy4RLWwZv+f2fSCea8XUBHsAll8yz5ztMO3j5FpTOkn5uscirK+CN7OtKOtHha/RyrmC
 IkBwPHTlxyKC/+VJEbIOG2trwzcFUJ8QoAT6hLcoillSoKhTqmuxOk0pak3San1VcakhUrt4eEd
 FJ
X-Received: by 2002:a05:701b:2802:b0:1a7:78a3:bda8 with SMTP id
 a92af1059eb24-1b50318d7abmr10284796c88.27.1794846204118; 
 Mon, 16 Nov 2026 08:23:24 -0800 (PST)
X-Received: by 2002:a05:701b:2802:b0:1a7:78a3:bda8 with SMTP id
 a92af1059eb24-1b50318d7abmr10284757c88.27.1794846203416; 
 Mon, 16 Nov 2026 08:23:23 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031468b7sm38623826c88.5.2026.11.16.08.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 08:23:23 -0800 (PST)
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
Subject: [PATCH v3 8/9] soc: qcom: mdt_loader: remove qcom_mdt_load()
Date: Mon, 16 Nov 2026 21:51:47 +0530
Message-ID: <20261116162148.2864501-9-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfXwaczwwEMekvb
 ZFETMLG7KJb4hEAYyzb9pf5/7YuXeCF8oi3+fzZA3oQQ+vNZM7NfFMaFTFJC0Dbqg+Mua4e4p8N
 cq1+WAOhb8BOUafQAnbJRGTcqgOnFlC3vQROU6DHcQbixglqw4D63SBubdKv6b2x/X+1/OLn1xT
 Stl+XvV3Z/lpQXW6wusi/27BUGvysXOx+4Iv6y/ZOgRGyCdqyxBgcJocaujHaXZZBjXlazTj0Zq
 J40KJdyI/rpx+GKJnnuFOqbnUPr/zaDqMxHogbtZxGriPr8FqCJXrrZyBS0oWeK1iqAOTGDUWOC
 Z6BYkUQnkD72p4asud+HklCon9Aq/dkhWhMmbY2nX7HBR1m8HCt1j8rCxYMh2pRAifRWJpxE/eK
 ZIKcbkJAQm0qVqyXr5P88jNmwoRiQm5scHVO/fY3388r7eU5IOj8yPnrJTLRUjsdosAPfXm17lI
 xtr/xgiqECkJNadDI6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfXyLQpjWHs6iM2
 dWM3krf1kXtVZu0BjUWAdhSoMiwPoKof+UJa+4nNeRxgPat5TdqiAXuE4g8qg4I8DigL9+t+LMP
 iLvhVYbCpmVy3O/b6pxWOudLxblV1Ps=
X-Proofpoint-GUID: ay0ir_wfdRr3npL0oYDL0Zmegt-u9hVs
X-Proofpoint-ORIG-GUID: ay0ir_wfdRr3npL0oYDL0Zmegt-u9hVs
X-Authority-Analysis: v=2.4 cv=Vdtir1p9 c=1 sm=1 tr=0 ts=6afb2dfd cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=GTbpKQ6npsRNubDcNtEA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
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

All callers have been migrated to qcom_mdt_pas_load(), which takes an
explicit qcom_pas_context instead of a raw pas_id and delegates memory
setup to the context.  Remove the now-unused qcom_mdt_load() wrapper
along with its EXPORT_SYMBOL_GPL and header declaration.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/soc/qcom/mdt_loader.c       | 59 ++++++++++-------------------
 include/linux/soc/qcom/mdt_loader.h | 12 ------
 2 files changed, 19 insertions(+), 52 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index c6ec67e1da09..fd638833b17e 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -329,7 +329,8 @@ static bool qcom_mdt_bins_are_split(const struct firmware *fw)
  * @dev:	device handle to associate resources with
  * @fw:		firmware object for the mdt file
  * @fw_name:	name of the firmware, for construction of segment file names
- * @mem_region:	allocated memory region to load firmware into
+ * @mem_region:	virtual address of the memory region to load firmware into,
+ *		or NULL to have the region mapped internally with ioremap_wc()
  * @mem_phys:	physical address of allocated memory region
  * @mem_size:	size of the allocated memory region
  * @reloc_base:	adjusted physical address after relocation
@@ -344,6 +345,7 @@ int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
 	const struct elf32_phdr *phdrs;
 	const struct elf32_phdr *phdr;
 	const struct elf32_hdr *ehdr;
+	void __iomem *mapped = NULL;
 	phys_addr_t mem_reloc;
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	ssize_t offset;
@@ -353,12 +355,22 @@ int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
 	int ret = 0;
 	int i;
 
-	if (!fw || !mem_region || !mem_phys || !mem_size)
+	if (!fw || !mem_phys || !mem_size)
 		return -EINVAL;
 
 	if (!mdt_header_valid(fw))
 		return -EINVAL;
 
+	if (!mem_region) {
+		mapped = ioremap_wc(mem_phys, mem_size);
+		if (!mapped) {
+			dev_err(dev, "unable to map memory region: %pa+%zx\n",
+				&mem_phys, mem_size);
+			return -ENOMEM;
+		}
+		mem_region = (__force void *)mapped;
+	}
+
 	is_split = qcom_mdt_bins_are_split(fw);
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(fw->data + ehdr->e_phoff);
@@ -437,39 +449,13 @@ int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
 	if (reloc_base)
 		*reloc_base = mem_reloc;
 
+	if (mapped)
+		iounmap(mapped);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);
 
-/**
- * qcom_mdt_load() - load the firmware which header is loaded as fw
- * @dev:	device handle to associate resources with
- * @fw:		firmware object for the mdt file
- * @fw_name:	name of the firmware, for construction of segment file names
- * @pas_id:	PAS identifier
- * @mem_region:	allocated memory region to load firmware into
- * @mem_phys:	physical address of allocated memory region
- * @mem_size:	size of the allocated memory region
- * @reloc_base:	adjusted physical address after relocation
- *
- * Returns 0 on success, negative errno otherwise.
- */
-int qcom_mdt_load(struct device *dev, const struct firmware *fw,
-		  const char *fw_name, int pas_id, void *mem_region,
-		  phys_addr_t mem_phys, size_t mem_size,
-		  phys_addr_t *reloc_base)
-{
-	int ret;
-
-	ret = __qcom_mdt_pas_init(dev, fw, fw_name, pas_id, mem_phys, NULL);
-	if (ret)
-		return ret;
-
-	return qcom_mdt_load_no_init(dev, fw, fw_name, mem_region, mem_phys,
-				     mem_size, reloc_base);
-}
-EXPORT_SYMBOL_GPL(qcom_mdt_load);
-
 /**
  * qcom_mdt_pas_load - Loads and authenticates the metadata of the firmware
  * (typically contained in the .mdt file), followed by loading the actual
@@ -489,21 +475,14 @@ EXPORT_SYMBOL_GPL(qcom_mdt_load);
 int qcom_mdt_pas_load(struct qcom_pas_context *ctx, const struct firmware *fw,
 		      const char *firmware, phys_addr_t *reloc_base)
 {
-	void __iomem *mem_region;
 	int ret;
 
 	ret = __qcom_mdt_pas_init(ctx->dev, fw, firmware, ctx->pas_id, ctx->mem_phys, ctx);
 	if (ret)
 		return ret;
 
-	mem_region = qcom_pas_ctx_map(ctx);
-	if (!mem_region)
-		return -ENOMEM;
-
-	ret = qcom_mdt_load_no_init(ctx->dev, fw, firmware, (__force void *)mem_region,
-				    ctx->mem_phys, ctx->mem_size, reloc_base);
-	iounmap(mem_region);
-	return ret;
+	return qcom_mdt_load_no_init(ctx->dev, fw, firmware, NULL,
+				     ctx->mem_phys, ctx->mem_size, reloc_base);
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_pas_load);
 
diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
index 74886f772d46..f49de7b388bc 100644
--- a/include/linux/soc/qcom/mdt_loader.h
+++ b/include/linux/soc/qcom/mdt_loader.h
@@ -15,10 +15,6 @@ struct qcom_pas_context;
 #if IS_ENABLED(CONFIG_QCOM_MDT_LOADER)
 
 ssize_t qcom_mdt_get_size(const struct firmware *fw);
-int qcom_mdt_load(struct device *dev, const struct firmware *fw,
-		  const char *fw_name, int pas_id, void *mem_region,
-		  phys_addr_t mem_phys, size_t mem_size,
-		  phys_addr_t *reloc_base);
 
 int qcom_mdt_pas_load(struct qcom_pas_context *ctx, const struct firmware *fw,
 		      const char *firmware, phys_addr_t *reloc_base);
@@ -37,14 +33,6 @@ static inline ssize_t qcom_mdt_get_size(const struct firmware *fw)
 	return -ENODEV;
 }
 
-static inline int qcom_mdt_load(struct device *dev, const struct firmware *fw,
-				const char *fw_name, int pas_id,
-				void *mem_region, phys_addr_t mem_phys,
-				size_t mem_size, phys_addr_t *reloc_base)
-{
-	return -ENODEV;
-}
-
 static inline int qcom_mdt_pas_load(struct qcom_pas_context *ctx,
 				    const struct firmware *fw, const char *firmware,
 				    phys_addr_t *reloc_base)
-- 
2.55.0

