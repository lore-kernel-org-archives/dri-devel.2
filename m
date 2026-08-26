Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37395C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757E610ED48;
	Wed, 26 Aug 2026 13:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mtdrn14t";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VdwdY7X3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789E010ED48
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:36 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCBvvg3898994
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zjJpwZr0X/rEPVNLxx/hrvAZWJJ6N6W56ZMy3AjrV+c=; b=mtdrn14tf6yVUBdZ
 16DFhyOeDo7Z1akK/FUPqYuJjVMlGL3K/RKjy3OsPp+PhpuPAsrhM9QxokOZkDr/
 FkXXk5ZGHK1aUI+6/IZjZWbzDI2zmRWTJOF9LrGUHhlEZgi6iNOGsZidWB0wb8MN
 NHJUAnsRvfjwJIGzpZgFbgJvrZIbNnEsjXhs41xdYYTbK5k2812y64G27FVD7xlY
 Bj2nLPnKCbKU9iwvADYBkYcDq0+eKk9/B/5KhZ0NCCHQTWHRbILNIRsu4Sa9FpAc
 TK+VV9/O6Qof2sqpqg2YaRjRkzNEiYs+XBtpHQz0jWjYgdjOLRKJfwYrZwH8dakV
 rBwP+Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uthsdsp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so2033817a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787751994; x=1788356794;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zjJpwZr0X/rEPVNLxx/hrvAZWJJ6N6W56ZMy3AjrV+c=;
 b=VdwdY7X3fpjR7eVS4UXeFzcRs8lejy9TB4qXnmPtkB25BabrMLGZRKn66/VegQBzfa
 vmXkhWVNKwdVqWFeN+5RBa0wV9JFSind57aGPfiMxMedakUGR9LtD3x/fy10hQmTmZ5T
 V2goFp2FrsYNW+A/UPXX0T5bp9GK6RRv7NcpZpVP8+aW0zcrZK7X1UonHYuHMOxZO/qu
 dK5dG1mTYwnefVHhSn6/U+P6cAfd6ssWfWQkUQ3A2M7YRyH61lqa8hsd9S9+YZIobfGO
 BSYJV+EjCl0FR+Ne+hDntA/uFkO6c2wQ4g0xbP6VuuYfhXoRLnkXzJLKOh5BolwYPrTJ
 7XyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787751994; x=1788356794;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zjJpwZr0X/rEPVNLxx/hrvAZWJJ6N6W56ZMy3AjrV+c=;
 b=OtU8UrJK+Ogr4bMJK7AndGbhueOc8S1RXThnN6WNan6Ku5ksrkugr2dq/XzSh1F2Rl
 J7YZ2UYoQxzl69Vduk+XRsc0j/ezca3B8yToASjbKjOHJMb3vpIPh+eG+weQYAS8f5H/
 kDn/F4qoMBmBaI6ZMfemsab0n8MX9SSgLTHNG8G1kHz7JqfTaLT+l/7WgKNJlXcaatHn
 x9DnxbQr05Hm4ormQrWGO107l2ZvY4becpnzljk0QAIorz1jbiBfvubrDBdNnAiAbclQ
 hQFekPQwGFCjWNaESOPJTmVrYMWdfB4RHqjbIqWKguNdVsmdzbT1nmbtvknoSwDRIXFW
 S0yA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoESafTO9NRThkLGnIN8BEVSQfFybjs4YTbkNqGV2gFL63uU11vdaPu2RwFpRKxmNIfDW/GnvgTzSc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mFEJTRrG8Ar6O5vpJZ37o4C+nmpHGduFN1wZRrWTO6lbvqDNSB
 WGay+MyLjeqYyoGW0AFXsU1Pnd9dWKLLUbrD42QDSQHLBKxOiOcWAuwQe3Wt5WBSVRjI152ZRRO
 28nHkzsgkIVcObcq4Z0PXR/3fHpwSLzZNlPODpxB7/MauPmxhYmySwhN3odG4clflOh+u+S8=
X-Gm-Gg: AR+sD10ILRKY2qSJBA3+pUECXlDCTiRCOEotE46wAkmivQlUdFncxUrANnvAfqnBEtH
 /6jolc5YgQhSacdtSF8o/4N3MZbWRB+ynyiEgh5vz7hXPmuB0wMwIIxhk1aCMa26sJslIR4NJQI
 dldMfBQImQVnpMwxquQkyjN+GGZ7cSD3K9EfbLnH7DyuQHE14nbmf1+5HMXH4aQ46ik5SoO307M
 DXxaXGU+lz2qQvjcq2FhsHvsFncQnHcLMuY/DKvQAd8oZjY7FltEh8Jketxn1/oZbZ0iV/0qha+
 n/orgZ78H6tiQje7NMn9iLuyQmgUNUTsunVlQoE8arER0crkU+f2LKGU+vRqACSGTC/KVKmXkjK
 DJYiqd8vuQQ5AILC2806/qs/lpioutfm/nQ==
X-Received: by 2002:a17:90b:5890:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-3966d83231cmr15765876a91.13.1787751991847; 
 Wed, 26 Aug 2026 06:46:31 -0700 (PDT)
X-Received: by 2002:a17:90b:5890:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-3966d83231cmr15764798a91.13.1787751984994; 
 Wed, 26 Aug 2026 06:46:24 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b64c48sm8179696a91.8.2026.08.26.06.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:46:24 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:15:47 +0530
Subject: [PATCH 5/6] misc: fastrpc: Add extended context bank support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-extended-mapping-v1-5-d046c1cb9a9f@oss.qualcomm.com>
References: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
In-Reply-To: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787751952; l=3115;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=7DmLl0ksHTt+4g/zhx1HwQyTDE+jC4CaVjooDl20Glc=;
 b=eLDthfmrsR+fwIgIfMaggDJuyvAv2B3Y2sgoB+KV+fWPIJ17X/egI/M/27Yhh4jZRbxxJv4cW
 92npmr17qpeAtMfX7EI+2EoGiTEDIS5HlO6ZpeqWRzQj4FbF73KVslN
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8eee3b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=K--tOdr6QUUB7xZ2f28A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Y3UzXbnvpTzVoY4GWWbBeCSY4R1wSaJn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExNCBTYWx0ZWRfX/i1qkVNL3uKJ
 AOWLzg1wehD5CNoOAI1cPUyISrKv/BQw1yMgvEazU+ZEld+RFYscH0tvLfN4KcctvNGpySFqi9/
 neC5lpgPqmv7s9GoTkLshN9oXaAf7SPZ3bCl2z1eCNMJjRGdUx9LCtHaFX0VO3bL75ohYQMtGVo
 hF1PUEz37JA01pJNCsjgsIe9ozFJwPfKow+HJDjedqk21vApuqSOD6nMOZVhvmJOclWFhrOErr5
 F0QGCHqixKy8JzcEVdXAniujW+7yEghXyBgUWSDogUWo8Twk30l43ijED9Dq0mU5ZPUeVrfZyU8
 wjmAqylKVOd/889oZuwCEF992AwcO3GnOPhEimCxUVUO2AuVQ2Xeo0zXe3foqbUfFsQ26L3plbm
 pxSgegbCLmehEx0Qv1ISPgkuy5831YGKbtIs+KIss3EehzUTQKJ/1kWFG3fucyfA6LXPXOAHWeZ
 w8N+92DWqZHyYlxe6tA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExNCBTYWx0ZWRfX6upealPcf693
 qG4Bam+IzSsE9N2iLyThLTT8JI4Io/9Bqv7bLZuQzKcv4W1QfObUiGDhA3O+SN/adN1QIgrx/Ye
 99x7mSDHNtHpn3VdUbWZg2TCCUmeQBY=
X-Proofpoint-GUID: Y3UzXbnvpTzVoY4GWWbBeCSY4R1wSaJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260114
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

Extended context banks carry a 40-bit DMA mask and are shared across all
open sessions rather than exclusively owned by one. They are a
fundamentally different resource from normal CBs and do not belong in
the session[] pool.

Maintain a separate dynamically allocated cctx->ext_cb[] array instead.
Extended CBs are detected at probe time by the presence of a
memory-region phandle and routed there, leaving session[] and the normal
allocation path unchanged.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 07a0f2b229b4..28d89fd9cbbc 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -309,6 +309,8 @@ struct fastrpc_channel_ctx {
 	struct qcom_scm_vmperm vmperms[FASTRPC_MAX_VMIDS];
 	struct rpmsg_device *rpdev;
 	struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
+	struct fastrpc_session_ctx **ext_cb;
+	int ext_cb_count;
 	spinlock_t lock;
 	struct idr ctx_idr;
 	struct list_head users;
@@ -536,9 +538,13 @@ static int fastrpc_remote_heap_alloc(struct fastrpc_user *fl, struct device *dev
 static void fastrpc_channel_ctx_free(struct kref *ref)
 {
 	struct fastrpc_channel_ctx *cctx;
+	int i;
 
 	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
 
+	for (i = 0; i < cctx->ext_cb_count; i++)
+		kfree(cctx->ext_cb[i]);
+	kfree(cctx->ext_cb);
 	idr_destroy(&cctx->ctx_idr);
 	kfree(cctx);
 }
@@ -2373,6 +2379,8 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	u32 dma_bits;
 	u32 sid = 0;
 	int rc;
+	bool is_extended_cb = false;
+	struct device_node *mem_np;
 
 	cctx = dev_get_drvdata(dev->parent);
 	if (!cctx)
@@ -2382,6 +2390,45 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 				       of_n_addr_cells(dev->of_node) - 1, &sid))
 		dev_info(dev, "FastRPC Session ID not specified in DT\n");
 
+	mem_np = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (mem_np) {
+		is_extended_cb = true;
+		of_node_put(mem_np);
+	}
+
+	if (is_extended_cb) {
+		struct fastrpc_session_ctx **new_ext;
+
+		sess = kzalloc_obj(*sess);
+		if (!sess)
+			return -ENOMEM;
+
+		spin_lock_irqsave(&cctx->lock, flags);
+		new_ext = krealloc(cctx->ext_cb,
+				   (cctx->ext_cb_count + 1) * sizeof(*cctx->ext_cb),
+				   GFP_KERNEL);
+		if (!new_ext) {
+			spin_unlock_irqrestore(&cctx->lock, flags);
+			kfree(sess);
+			return -ENOMEM;
+		}
+		cctx->ext_cb = new_ext;
+		sess->valid = true;
+		sess->dev = dev;
+		sess->sid = sid;
+		dev_set_drvdata(dev, sess);
+		cctx->ext_cb[cctx->ext_cb_count++] = sess;
+		spin_unlock_irqrestore(&cctx->lock, flags);
+
+		rc = dma_set_mask(dev, DMA_BIT_MASK(40));
+		if (rc) {
+			dev_err(dev, "40-bit DMA enable failed\n");
+			return rc;
+		}
+
+		return 0;
+	}
+
 	spin_lock_irqsave(&cctx->lock, flags);
 	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
 		spin_unlock_irqrestore(&cctx->lock, flags);

-- 
2.34.1

