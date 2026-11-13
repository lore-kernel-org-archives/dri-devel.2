Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19664606B357
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nMKw03Ef;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sdsg1Zzo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48453112760;
	Fri, 13 Nov 2026 18:54:45 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B9E112760
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:54:33 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRLs21725171
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0iSH72bVkOb
 J6XNgFyC1IcqJNSUQhJ9lsse8nsmCQfg=; b=nMKw03EfbnLviR49OfokSBHZcX1
 3teGDzpcCErjbqy9PXFzmTwRaCV4+5x73O2NLnI/SKSfL4f2qZCpqc1QgU1yTAzZ
 bohP8oY2w7ysZYL4GeijVUVGjZY7i2fnxwZk4l3Y/fDVLpLWCVutBIrsxHb731+o
 cuGLy05Q3tQXaVx6N9MSEc6TSvYZ0Xwd7O4lyB85OjohreZ1Syo+huuxomIbZpA2
 lqiWOG+DWIpRlTAc9+m3ZF92IJCT954ZJedL0k4CgQ5wYF0T/Cb1c5E4opbQy3g+
 fr3Er1PGcfsphCEtqUsbEpgch8yp6k9CapUKDewaQDt+WybJVlFtR8LyAlA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx1bp9q7f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:54:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36d1353fdcdso5685952eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 10:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794596072; x=1795200872;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0iSH72bVkObJ6XNgFyC1IcqJNSUQhJ9lsse8nsmCQfg=;
 b=Sdsg1ZzoAwsP7Zl6aZQnKxJLxGSpmqPl7/ae9egIon5JvctT45cAFvfJG3qYkLbf6/
 3UKBXfHKZ5v/Jd33svGLJ1+P1CuahTUJiW943J++14lGnrsn/2oLHcxtmZ/ar7aWqm5T
 iohwywsKrlSpfeb42zcWULciEguNqq053zKUG6lJK8h3Pn6qQcKMmyHYrtC2jRKCwCK8
 nFLK/1KdIA//UEZQlBaUdJg6bMdB4MT29CJhwTTSNxrSgIApOR3Ktk6neqh9GepNpDM2
 ZnY1yRNJIAyQj+TC0VwFdjNmFuzVHTjtRpsgl3WijqhZJ2hQz6i9MqHPKf3tkJwGOjev
 iRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794596072; x=1795200872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0iSH72bVkObJ6XNgFyC1IcqJNSUQhJ9lsse8nsmCQfg=;
 b=wN+t3QE9puDYJCd3ONXtYzi0MUFLKjKCmoe9xgy2JKE1wntA9iR/k8Ut/7wfVdd9We
 TAwE2wwoHeDxviyx0ZsyhjdRcN+q0O0qd9zLRE+c8sKTl/4JDE7rYFo9fzRUdVXU4+K2
 nxJwbhfdPvOc/0qfCjvTdYjU50GV7QDFf1l3a2R3CzoT6XAqTMnvN1a8q+IMzHVF6/8F
 g70wUK1Oy//j+VFABzNlxhr2J+KO1wbcJPQo02J+kS7XYrDXLRhOUI81UyVwPFJAfG7F
 pl2V+xqZSCwC//edLHr6D/JeU9AAd4b4taRKyeuTdOt1/yPp5zkAaNI27do1enHTJfGH
 nMjg==
X-Forwarded-Encrypted: i=1;
 AL+hErFmhbcrYJ+wyvMML4PuuNXUyzhyyBvSUAB3FjccG2j30/TkHQK4z09hcDKNZ9LIpM1rqMV2MvjGmlA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8w3hP7OGbvslikybLkXNbGFCbqPTErHpTvd1jQTOV44n32gdbX
 OF/z+Xb9a+PsM3eaV68uHL0Th7qz5NBAgyO1vbpijbD1Jm7H5a4HcrpQZp7OH3i2B+F0dZs/I7y
 eMhO+Atw8qHo2t40kq9h+gWYNPFHZnvtg4FZpAaKIn2+So4MrS+JURD3IotA84WpnHrpI1wE=
X-Gm-Gg: AYBFou3R6HJdGGO6IIEtmtbV6vDyTjpZ29vtgDMgEVIdI6ffN+zWsNu83qA4gVUPSy3
 r2M7QjqRG9jbCVRoLbk1hkQpTByKNakfFN6R7O8n4MsxoZCvVd04szqKteCykhq/zPY2HueroYl
 5UKv4c0CTbkKRjdHJe/K51Yvn5vY34n+tR8Yqud6E4NFsB1dqWvPoUIhGLGWaNGL0l60vY3utmS
 f4ktsqmZA+qcHVtCiEDZUicNiKa2vHerkFs923yGyO99kOOQOYt1K137C0ER5aVdprYgby7Jze0
 RyCJxbdqdw+TucU97IdA/WFsuTmUox0Mm2T1TP4Ms6E2buZTDEATPpgZnR4aQskDLy7jzGPXPbj
 MkSZW3aaQArgiUC6AdwARGwuW56E+WtzabjSYn8mnur/9/AuPKAjw05RArfO1wwZmsf9SoWwuRp
 o=
X-Received: by 2002:a05:7300:c594:b0:36f:a72d:29f with SMTP id
 5a478bee46e88-37967ae6bf2mr3452334eec.34.1794596071753; 
 Fri, 13 Nov 2026 10:54:31 -0800 (PST)
X-Received: by 2002:a05:7300:c594:b0:36f:a72d:29f with SMTP id
 5a478bee46e88-37967ae6bf2mr3452284eec.34.1794596071051; 
 Fri, 13 Nov 2026 10:54:31 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:54:30 -0800 (PST)
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
Subject: [PATCH v2 8/9] soc: qcom: mdt_loader: remove qcom_mdt_load()
Date: Sat, 14 Nov 2026 00:20:08 +0530
Message-ID: <20261113185009.157893-9-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W9ytxhWk c=1 sm=1 tr=0 ts=6af75ce9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=GTbpKQ6npsRNubDcNtEA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: BfXoIxI3ie9VMb5W58dkMfAJpB3BhLLj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX0/t3vIE6Der2
 gUBxI8ClC2FhiPGoxdUjPknmZhyXxKwxETD10dVcNfXevzdqK/mF/DY+2mHaM05XGIfP3WIw4s8
 6Tat4zxRLODF3ha6QiQfP1vEtitnAIo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX2eBMX04YENOW
 xLHMs/+T3D0rx0R8zC7RQUqJbnk+tO9gNAu7iJlF8IGtWSR8SYXFkahIDzoiY0ypa7VgNvpGA0M
 3g8oJnf7XuqJgI+kxGgGCGBjDKJAAtu7jI48k2VHf7cFPh9LLKuoxjhvihztftKDWho4MrFg058
 VlzFaMJdYKXwB9X8WTqs6EnHpwJ5xvcdsbs3Lnq/xuz1nCMSMZaaGiMFY2d4xdWmVVl3TKi3vBh
 jBBOrRU+bNoucCRsvk0hDJODnIYJ+MBOo3JNs4goJAN9WqkZgBpTjJNvhMiJLJ0Iyp1RaA8BRp+
 VH/1H5x1ayOiAVtncZf2jJazehrNTSEIgSvRA/hqoYxAI1JYCs1zXhfpBocRzjRIPj34In375Vz
 0lxMqmw3A3D4nSjmj3GcGAy/mqudreVF8PiiNI0xpXP5XzmdDmJYEq1DbXBZtBr2ER7bCfQdTmO
 Z7rXq60lU+neJ0cOH0Q==
X-Proofpoint-ORIG-GUID: BfXoIxI3ie9VMb5W58dkMfAJpB3BhLLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
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

