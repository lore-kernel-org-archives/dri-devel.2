Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40C6FF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C58310E6A0;
	Mon, 27 Apr 2026 10:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K5X0HsRW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fzohl7Pr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7916D10E6A0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:53:26 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RA3p1q3123642
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=0ji/W5Knfx89fcuTargogWia1K/65u9oFmR
 3dCs3hcw=; b=K5X0HsRWNUEcNTiGmaED/Ss6KNMLvY7+MIjI/9t8VoxCxFzMK4f
 2jeu41OezpZjuTi4MDdQUATlq5CGXRDmSvWPO1VqjdMx5M9Qhf+V9sHyPeTf+A5w
 5NWUtTEBJMh4kWLfY7eUTmZLwPN3n/ic23wXYSU5aEVJLoObMXFi17hmHgvTtzNU
 3olcp2zw2ozpm6UqnN48faWqUUSCHsITFd3HphqKa4T/JCgxcS9OPeZO6dw7Qa97
 +4UfaORX+d6yG11hIXdUVEl/YB8VP7bCTACU/rMJrZyWFWx2UFqrQGLxij3TKETk
 kt9SkoRRnYtMtjiqZmSb4N+lSa3Mp3VpTNw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5qgg5gj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:53:25 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f756ebd0dso6650495b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 03:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777287205; x=1777892005;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ji/W5Knfx89fcuTargogWia1K/65u9oFmR3dCs3hcw=;
 b=Fzohl7PryjvCnFhpaVpa0/Y9NUvVPvi8ByAdT9Ei5iPCxscmHDuct40f2sh1ettKay
 kRvA3IwnXGWdxraxq4A3cXmPFyepRyrdHjbtzJ9XaVp4vQkruJMMn1LsvUwj8Ij+hkak
 ueKR3l5a/YWh0iwK8oY1crUa4wc2O5miAoujWnJjdqOLbPzIwG8eH+azDyAVITdScOE8
 Ofj0iZUgT+S7KPn2GA7TQJL2cjWJsad0iJYuMztdJnKpfFhjOac5+lmcgTShYYyBTPw4
 9YydpRfSb92rnxkV0eRRstgNgnC2vd0+/vTpoFU3PHtNWyVRZTpz3Ne0wPEouLWjVaxb
 IPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777287205; x=1777892005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ji/W5Knfx89fcuTargogWia1K/65u9oFmR3dCs3hcw=;
 b=UgM5mmjKpv22MEYttxARn/ahtNKco0TtPDtpRtxhjdbbHElviCheye/bcF3tcILZvX
 QN+sYrRGuFRbVwec2s1XU3r0bULmS2YYZRvrRvlh8HbBg2E9kDMIdmW18auoZwwXwXW4
 gqedd381Pw7W4Woz4y6TC6dMsLXCnIIeWgdy35ueTl15oyIdJNDm4omiDgyGZz4PLS9j
 SkkDXuuHseP6LfbUbZVFjG88UkmIPNsQtSUuptRZ4xEPVHF8JbBDBXaJyCEbNa07Krgo
 gMM2ZfAeTI0Wag7Q0Xee7jEfVkablPgGkxLifReeHLB0Ow3BfZnKAxJNLQE45ex89bUi
 NNmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Jccprd2tfM1rhc8yF7rqxyv2mbiuS929jxoPCw4XaVSlFojaVUQu3rMi1cE0y5FOvNq+ntRpFUCM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqMYXqhCv50UkOgcGffTazWT56w2A9SnZg+u257BlZabPdlWi6
 SEVldd1Mzxbu2j7D8zHB1KQlLHsf/zHbeJ0F/w0wJn9MrYfGUMQ3tKBDW4xDpQwHRkij2KNnb/h
 ZxlTPBakR9a/tsJBBhocNofpJguYe8oJx/wXwARR1enbPy8KhEvqWrm9ug4Xp5PTUXV1Zi1Q=
X-Gm-Gg: AeBDiesmSrWQmtr92J2c83dkqzOjG7PuPITV9zObffADv1fAKhrMiNbFI9QXISm1kOK
 cQMl1vE+0DdwINSCUH6p5hWARmNxRq/zXHtL9HnmnG6kb049Qa/DxZlgK5bPtp21NWJfUv7MBes
 9sLNif1SEVqtQwZsKMvuT2n9Z3H2r6wkKKHk9kER4HAPSGxe+YhFUalkHRKmVy7BJREVs2MYFm0
 CKPpsidkHvKAl6EX6I/9Z+9sOTU6w9oPqzuKrLFvBsVKesq1l68ROMc4FCmnaQZmGTZUvkNeVlf
 t5R4kfnsxbAg1evTw1cayNQLLCIJyhj5lwR96Xx2GKAD3MhPJF+GfW92HYq/ppqqnTbIn+wmtwZ
 BcIsjysdiFf2DPncJFHLii5cOvaECj8LqGmmOMXaKr/LB+FbvfFigJPAGxOqwSUp+wk+0M+dXHF
 VNetXoi/Ce+XEwMed0e/Y67/sZGENX
X-Received: by 2002:a05:6a00:408a:b0:82f:4a53:a95b with SMTP id
 d2e1a72fcca58-82f8c99177bmr47464176b3a.37.1777287205086; 
 Mon, 27 Apr 2026 03:53:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:408a:b0:82f:4a53:a95b with SMTP id
 d2e1a72fcca58-82f8c99177bmr47464150b3a.37.1777287204607; 
 Mon, 27 Apr 2026 03:53:24 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebba485sm39724655b3a.38.2026.04.27.03.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 03:53:24 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, thierry.escande@linaro.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH] misc: fastrpc: fix UAF and kernel panic during cleanup on
 process abort
Date: Mon, 27 Apr 2026 18:53:09 +0800
Message-Id: <20260427105310.4056-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDExNSBTYWx0ZWRfX5JeG6Vb0E/DC
 N7OzrWJeubzmlSWwLqh7+CDubbfdRyynhGKMNbzwihVp3+B4qEsGlhRX/Utr/IUXx2fISOFMU6y
 dROGvPjzEZz0kiWEauBhYx2K3cKAqcbPcbKWxHGQrUstnXUO54Ud1FGQ2H7W6EpHwByqaVvhoUr
 vtlaXItTNuRGK7X5Pi/kMaEtabszKqN9OkmEg0yqGYRTCWrG3VWmYFUJstHZ6QmnzCLOgbzS/Uc
 eQP+QvgVn6dl0BMLM1acuYPAuDpaoYHexL+MbNFH4yalmT7427pIIW7b0vgvBb6pzUkTd/VUB2X
 k4YsOxQ1cO+btkHAhbks/Dn7UM+PVb2yzwFZhmgvBbSwtcBXn+pUPRHJpT0H84t01IP89T48z0t
 Zr6w9roT6V9olov2H0fqRP/NA1XJGAWirxAITL9v9dhv4YG4KUm/hcFhgPuPzu1Wu4Au7P3GRft
 SxLRacU4F/Qxz/pX1Sg==
X-Authority-Analysis: v=2.4 cv=V69NF+ni c=1 sm=1 tr=0 ts=69ef4025 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7UBpWWJXUKeOLZOJV8wA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: _l42csLNL-8TT58810IF9K1xqx2SjXBD
X-Proofpoint-ORIG-GUID: _l42csLNL-8TT58810IF9K1xqx2SjXBD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270115
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

When a userspace FastRPC client is abruptly terminated, FastRPC
cleanup paths can race with device and session teardown.

This results in kernel panics in different release paths:
- fastrpc_release() when using remote heap, originating from
  fastrpc_buf_free()
- fastrpc_device_release() when using system heap, originating from
  fastrpc_free_map()

In addition, fastrpc_map_put() may trigger refcount use-after-free
due to concurrent cleanup without proper synchronization.

The root cause is that buffer and map cleanup paths may access map
and buf resources after the associated device or session has
already been released.

Fix this by:
- Introducing mutex protection for map and buf lifetime
- Serializing buffer and map cleanup against device teardown
- Skipping buffer and map operations when the device is already gone

These changes ensure cleanup paths are safe against unexpected
process aborts and prevent use-after-free and kernel panic scenarios.

Fixes: c68cfb718c8f9 ("misc: fastrpc: Add support for context Invoke method")
Cc: stable@kernel.org
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 56 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..3df771a4a216 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -255,6 +255,8 @@ struct fastrpc_session_ctx {
 	int sid;
 	bool used;
 	bool valid;
+	bool allocated;
+	struct mutex mutex;
 };
 
 struct fastrpc_soc_data {
@@ -333,9 +335,14 @@ static inline u64 fastrpc_sid_offset(struct fastrpc_channel_ctx *cctx,
 static void fastrpc_free_map(struct kref *ref)
 {
 	struct fastrpc_map *map;
+	struct fastrpc_user *fl;
 
 	map = container_of(ref, struct fastrpc_map, refcount);
 
+	fl = map->fl;
+	if (!fl)
+		return;
+
 	if (map->table) {
 		if (map->attr & FASTRPC_ATTR_SECUREMAP) {
 			struct qcom_scm_vmperm perm;
@@ -354,10 +361,16 @@ static void fastrpc_free_map(struct kref *ref)
 				return;
 			}
 		}
+		mutex_lock(&fl->sctx->mutex);
+		if (!fl->sctx->dev) {
+			mutex_unlock(&fl->sctx->mutex);
+			return;
+		}
 		dma_buf_unmap_attachment_unlocked(map->attach, map->table,
 						  DMA_BIDIRECTIONAL);
 		dma_buf_detach(map->buf, map->attach);
 		dma_buf_put(map->buf);
+		mutex_unlock(&fl->sctx->mutex);
 	}
 
 	if (map->fl) {
@@ -414,9 +427,17 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 
 static void fastrpc_buf_free(struct fastrpc_buf *buf)
 {
-	dma_free_coherent(buf->dev, buf->size, buf->virt,
-			  fastrpc_ipa_to_dma_addr(buf->fl->cctx, buf->dma_addr));
-	kfree(buf);
+	struct fastrpc_user *fl = buf->fl;
+
+	if (!fl)
+		return;
+	mutex_lock(&fl->sctx->mutex);
+	if (fl->sctx->dev) {
+		dma_free_coherent(buf->dev, buf->size, buf->virt,
+				  FASTRPC_PHYS(buf->phys));
+		kfree(buf);
+	}
+	mutex_unlock(&fl->sctx->mutex);
 }
 
 static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
@@ -439,8 +460,10 @@ static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 	buf->dev = dev;
 	buf->raddr = 0;
 
-	buf->virt = dma_alloc_coherent(dev, buf->size, &buf->dma_addr,
-				       GFP_KERNEL);
+	mutex_lock(&fl->sctx->mutex);
+	if (fl->sctx->dev)
+		buf->virt = dma_alloc_coherent(dev, buf->size, (dma_addr_t *)&buf->phys, GFP_KERNEL);
+	mutex_unlock(&fl->sctx->mutex);
 	if (!buf->virt) {
 		mutex_destroy(&buf->lock);
 		kfree(buf);
@@ -483,6 +506,10 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
 	struct fastrpc_channel_ctx *cctx;
 
 	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
+	for (int i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
+		if (cctx->session[i].allocated)
+			mutex_destroy(&cctx->session[i].mutex);
+	}
 
 	kfree(cctx);
 }
@@ -800,19 +827,29 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 		goto get_err;
 	}
 
+	mutex_lock(&fl->sctx->mutex);
+	if (!fl->sctx->dev) {
+		err = -ENODEV;
+		mutex_unlock(&fl->sctx->mutex);
+		goto attach_err;
+	}
+
 	map->attach = dma_buf_attach(map->buf, sess->dev);
 	if (IS_ERR(map->attach)) {
 		dev_err(sess->dev, "Failed to attach dmabuf\n");
 		err = PTR_ERR(map->attach);
+		mutex_unlock(&fl->sctx->mutex);
 		goto attach_err;
 	}
 
 	table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);
 	if (IS_ERR(table)) {
 		err = PTR_ERR(table);
+		mutex_unlock(&fl->sctx->mutex);
 		goto map_err;
 	}
 	map->table = table;
+	mutex_unlock(&fl->sctx->mutex);
 
 	if (attr & FASTRPC_ATTR_SECUREMAP)
 		map->dma_addr = sg_phys(map->table->sgl);
@@ -2217,6 +2254,8 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	sess->used = false;
 	sess->valid = true;
 	sess->dev = dev;
+	mutex_init(&sess->mutex);
+	sess->allocated = true;
 	dev_set_drvdata(dev, sess);
 
 	if (cctx->domain_id == CDSP_DOMAIN_ID)
@@ -2233,6 +2272,8 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 				break;
 			dup_sess = &cctx->session[cctx->sesscount++];
 			memcpy(dup_sess, sess, sizeof(*dup_sess));
+			mutex_init(&dup_sess->mutex);
+			dup_sess->allocated = true;
 		}
 	}
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -2255,6 +2296,11 @@ static void fastrpc_cb_remove(struct platform_device *pdev)
 	spin_lock_irqsave(&cctx->lock, flags);
 	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
 		if (cctx->session[i].sid == sess->sid) {
+			spin_unlock_irqrestore(&cctx->lock, flags);
+			mutex_lock(&cctx->session[i].mutex);
+			cctx->session[i].dev = NULL;
+			mutex_unlock(&cctx->session[i].mutex);
+			spin_lock_irqsave(&cctx->lock, flags);
 			cctx->session[i].valid = false;
 			cctx->sesscount--;
 		}
-- 
2.43.0

