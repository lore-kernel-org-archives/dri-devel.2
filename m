Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D621EC43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377E810EADF;
	Tue, 30 Jun 2026 06:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PmKdbvoY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jI8jpZWh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3C210EADF
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 06:34:19 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CIqw1073738
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 06:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Lkk1aid6VSjCiAh0RBtC69AWGsaj2zmcu8D
 ZktAdjhA=; b=PmKdbvoYoQGt6wie3aKrjDVrvI47ima6lzT04Aznd9GbfdlaeF4
 wbLUBZVHd3yuMJbkZ2XdOvgeTkpbMCoZJ3lo6xkj30XLC9CvHNOaWm5Qhfwmd90D
 S9oztBzB4PT15/qpxqn7NFoiQuolBcy+sUBCk/GxxbMhVLCwwDHRi5XSCeeZdMUE
 mU66hWnt77zqT6n58ZgUIEQAqrC0bOkr+4LW0jamt2QeTcztvhU5y7AGsoV+7CpT
 c5gjKIZ+Z5Wr7zAWJrT6SYYd3JykFRXRWA+gNelZiu3YbydjZUzK2sOTMybEzFY8
 GrMGwQLKDtC9xxnTHMnjwKfYRoi8OT0oHSQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k1vyg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 06:34:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ca0331d0b1so23550365ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 23:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782801257; x=1783406057;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lkk1aid6VSjCiAh0RBtC69AWGsaj2zmcu8DZktAdjhA=;
 b=jI8jpZWhvLc7eFrFN0KdwaPrBAtjdgs1Xpj5dZS2MUuhyB3/nnHEyQiX11AqC97g5N
 rJp2wCwCzhUZVHJgrAHo3HhxdYBE3Iv8RTse+JMrTsbdkvbwxCZkO5ICt/I4LsXaTHnI
 sE671yTA9ITbvXaKt1E64yqUfF/1bby4reHhUy8GooT3y5Ml+Y8pApBhOEP14DLx1yRr
 4kWxYkuMcx6NFgrv5lB5HCAPfY9iIc1Goz6R/XovusIJUZ2Et0U4067KcNRtZ/EZH8r6
 BF9ZW3zlIj9zdxIMxbr4pNgEacIvDYqd638iyH/dwoisvCNpYp94vtLleoHwg4Gdw7Wg
 dyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782801257; x=1783406057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lkk1aid6VSjCiAh0RBtC69AWGsaj2zmcu8DZktAdjhA=;
 b=Z1pwvekPgLKMYvMaVCWeHlg9NIku5mDr2QIaEb43+Z5BNOOTyNCGde79HPH+uYuC0u
 6fbJ3CWviQOzXi+y8lCYfkJkFEgk9BcSQc5cqS3swLqoSAd/a6HiC9mDoL370/NFsZcX
 +XH478V8SmA34vIqtyUy2xgQs27tvVGX120I5yK3NtwU3XTQrOgACo/g1pjXkegp0X71
 edgaHJFqk9UvxEY74rnsVnpzBMUzijMKWzawi8JSPtCEuHF/6L5xujW8V1kgNfjUtfoS
 yGd35G1TdYnXnrLTEa5RU7tWe282xkh2V5W9EULnIoJS4gAwm2qpFd+bPl3+uo/R39TA
 pKHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBrmIxDvWTAdmjlOzEtWBlbkzo9DKblTrLHggm6uLs++vTBq3LUUn29+eluC7v87PFm2ML/3o2X7Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXdNo8N/r05XdmHlaFm4tCClPyEvwJfUMwEBwSljxuTkiDaVSA
 lZtY9FKwCGLtpoGJL5AYFVqpa6HFVcSjeFssOYRvd7Q7yzqJsNTh9y2xO40t9CE4hD1+LAunkHa
 826RLiJEu9qrkakJSirrtn6SWbYy+bXFDxz5UCpqyh2Ql0q3g4FJYa6YdLJQW40zWI2X6j+s=
X-Gm-Gg: AfdE7clHpgrXygyfBLK9z2N/DfxX7TIMJ2aZVEk2kCkRHZb2zl69nHCMBwCyOpSXC8P
 HUQysWM3Df+f7A4GMrLbY1UEf7ZL6O6xOlxaw9IQC2tfzEcDUPWat3mTlwW9kLL/l5C0DlXCF3s
 fZKT2XiCR+cRi2uxHYCzi6i52uQtwQGutRI+qjINCXflQc0CJw6aBEzY6+rg+uvSzg4Av0o1zRB
 ZEaN8MgKTPB8o5PNjD1I74jYKyiO0+b8oiFNVYgKEBeWO3VEv6NMtFD/Ii7hshbCyZPKPGkhfho
 ifj6bBoyrWaXHUceoXVno304blXZWDEBiqrVraYoEPZnEoiarADTOmDErtXYwMuy8pL+LVva1g1
 sfPchx6NgUMAcsgQG81iZgjhws65oRru8bB51MMEVKEvWAe/CsbBzCqs1hd09kTVdo3AngLKPFa
 a9pDzzO1E=
X-Received: by 2002:a17:903:4b2f:b0:2ca:11fd:659d with SMTP id
 d9443c01a7336-2ca2ea238ccmr19680535ad.34.1782801256820; 
 Mon, 29 Jun 2026 23:34:16 -0700 (PDT)
X-Received: by 2002:a17:903:4b2f:b0:2ca:11fd:659d with SMTP id
 d9443c01a7336-2ca2ea238ccmr19680235ad.34.1782801256193; 
 Mon, 29 Jun 2026 23:34:16 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca382d0d22sm6646345ad.80.2026.06.29.23.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 23:34:15 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v2] misc: fastrpc: fix UAF and kernel panic during cleanup on
 process abort
Date: Tue, 30 Jun 2026 14:34:09 +0800
Message-Id: <20260630063409.475-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA1NCBTYWx0ZWRfX1d0bieNCa+AY
 OYzVtMuGFEjAfsX7lfvaEVYTaM0AzeB/Vu1lcyy+oTgqYAbqtkMVJxp3nzgKVlRQtWgMlDU8LSL
 v0LKnu6u+m+y3r4w0EaZTgWYdZelKFk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA1NCBTYWx0ZWRfX3tC0uXuWD9Oj
 DIHvEWVfRD3xSCe6f1EOzzKQaC8NjJdluSj+Hb5vnBrhlBWgu14vrxv7c9Zu1MhhHxcQn5MnKHO
 yp5IzLAGdnIXTmafVSqKDq+UN/QoRCXGh4g6CDi+oupzyQ07Wom6RmYZ0CHhIehmZO3gdHSte2i
 B/bgNzy/gvSzHwY0H3wzMvjJ6VUPWF6zz7d9DrAqEiHGmhIBi137GHWtSE++baYyqqtv5hWyTLW
 tlUuhzAxBNtuTKPGZrOJZmK6p381Hf2+FyUMwWd8+cRtzRntMs7wZGSxFnrVS1ZtlORGnYngveB
 ipTvaOzg6FRdxa4Y6csKeDLQDYO2EckXFEiFzo6J39svEOSWt0nPgFysUDQi5ldIwW4soeO/POj
 AOoSLKrqnqvug7GqSCjRHYmPA31Qe/bzRrm1amStpXEw6CGZbA7C1FKkwa+/Gea7V5AItpjqHJ+
 cg03HEzpQo7INEEQ4tA==
X-Proofpoint-ORIG-GUID: JKsmXkyMYXa5Lvz13YV8SayFtNmR7Faj
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a436369 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7UBpWWJXUKeOLZOJV8wA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: JKsmXkyMYXa5Lvz13YV8SayFtNmR7Faj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300054
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
 drivers/misc/fastrpc.c | 57 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a9b2ae44c06f..3521518f9fe5 100644
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
@@ -335,9 +337,14 @@ static inline u64 fastrpc_sid_offset(struct fastrpc_channel_ctx *cctx,
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
@@ -356,10 +363,16 @@ static void fastrpc_free_map(struct kref *ref)
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
@@ -422,9 +435,18 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 
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
+				  fastrpc_ipa_to_dma_addr(buf->fl->cctx,
+							  buf->dma_addr));
+		kfree(buf);
+	}
+	mutex_unlock(&fl->sctx->mutex);
 }
 
 static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
@@ -447,8 +469,11 @@ static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 	buf->dev = dev;
 	buf->raddr = 0;
 
-	buf->virt = dma_alloc_coherent(dev, buf->size, &buf->dma_addr,
-				       GFP_KERNEL);
+	mutex_lock(&fl->sctx->mutex);
+	if (fl->sctx->dev)
+		buf->virt = dma_alloc_coherent(dev, buf->size, &buf->dma_addr,
+					       GFP_KERNEL);
+	mutex_unlock(&fl->sctx->mutex);
 	if (!buf->virt) {
 		mutex_destroy(&buf->lock);
 		kfree(buf);
@@ -491,6 +516,10 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
 	struct fastrpc_channel_ctx *cctx;
 
 	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
+	for (int i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
+		if (cctx->session[i].allocated)
+			mutex_destroy(&cctx->session[i].mutex);
+	}
 
 	kfree(cctx);
 }
@@ -855,19 +884,28 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 		goto get_err;
 	}
 
+	mutex_lock(&fl->sctx->mutex);
+	if (!fl->sctx->dev) {
+		err = -ENODEV;
+		mutex_unlock(&fl->sctx->mutex);
+		goto attach_err;
+	}
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
@@ -2246,6 +2284,8 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	sess->used = false;
 	sess->valid = true;
 	sess->dev = dev;
+	mutex_init(&sess->mutex);
+	sess->allocated = true;
 	dev_set_drvdata(dev, sess);
 	sess->sid = sid;
 
@@ -2260,6 +2300,8 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 				break;
 			dup_sess = &cctx->session[cctx->sesscount++];
 			memcpy(dup_sess, sess, sizeof(*dup_sess));
+			mutex_init(&dup_sess->mutex);
+			dup_sess->allocated = true;
 		}
 	}
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -2282,6 +2324,11 @@ static void fastrpc_cb_remove(struct platform_device *pdev)
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

