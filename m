Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D70CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 11:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C94F10E4AD;
	Tue, 26 May 2026 11:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KAUF2vQD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MREjB3S3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1F110E4AD
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:11:46 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q8ss4G3658101
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=h2rbBUksZJT
 YcjdAJliGesa3QsJPl7wEGaGM4JyELQc=; b=KAUF2vQDBbaZGwDuqkg+NtXqbh2
 pJVpFT4JzXSXLkb/67qx6MkDXZUu5zL9kJmAGswpFaU8qqn0aNqWltwON9gbIrp3
 sdiJhfNKcwKB3N2kk1Cq4GhlEprFMStaqnDWc8Z6DooCx+/y2dYZmJLU8svprSBa
 pbIfA2kZfYqkKVOY/T4ThwIsljlGrT0Bbezorpk37O0OISvBD9WixWB6Ikv+w8rS
 yuDGX1rQv/ZMtl9y3MiE9SDwFYUw52v1528IgHGh9yQYpLI2LkGEfpDa+FPIGpdF
 AxSexWs49jCBucPZPqBtreXhXIiuLUmucRWowy28iZ7dmlR1N5s9JhXK/Sg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqynbgc8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:11:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-368edd5fec4so11559280a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779793905; x=1780398705;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2rbBUksZJTYcjdAJliGesa3QsJPl7wEGaGM4JyELQc=;
 b=MREjB3S3aZzcWLxueI6TKA0PQkIzoE6wSb54b9mOgnxNbltm53LkCDac5YQwDEpdlD
 RYPqfMaew/YH196eCeEX6vtAO752SLAPD71doQvxHpbGXtWEUg77Ztr97DiXCNN+fgAM
 mu+aOR8n2v51sCeB6JYWsKzRcsq4Tc73ZpkqbKEaWjPK3kRIsQBavmf2///nZqduNH3g
 ov/xzBesJS0gjprulzPtXbUxo3Rir75Yj6brmwvVNAv/3dnxByTnaZ5FHk0FNuA7QMR+
 cbEZev5u8oQEMYk40XuPBq7mpLNOy9LMf5EBnCZHKMNH247AtUCDefSL1z6BYH7tvChw
 qrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793905; x=1780398705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h2rbBUksZJTYcjdAJliGesa3QsJPl7wEGaGM4JyELQc=;
 b=CNsNOi29R/lsynWZ32gZU7jIjTXCp50OYcAy+xQcTiWFFj9+FikCIVCkO8XJvjlokj
 TmQDCiDpsVlpkcbuG9jIrQpkEJHEUj6URnSFK5xce0GlOwVTJracqeKUBJp3Erx+r/rM
 0oW1EMuiq2AUjfS52kjteA1DdR5M+2SynoxxVxBmU2O8HO9IGzzGVqtfMterlIBW6Rfy
 UGXMe6FLXh/iRlAOfLs2xrd7RxUB9E9YoJaDPIEl2wZrM/ZPGXowL3YsPo0x6HU5sP1t
 lafRkllgWW158fA9tRRYeopOtpeegD259wLq//qfoim6R7/VFYbyUneXA+SYPFT72kGy
 y/6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qWCNJwrbMRZx7EuOz9py0nTYtZ6Dx4btQBvqh8qbDWV6V+h4mGIf+MAWmQsOqL86yHXoyvkqSygg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yws6Oif2ux1fM2RoDWRjqsTo9+ImBOT9MJqSP6C6qcPtId8Dyy7
 WZUBFAQ/alF4ki/x98ukgfirdZ9GH8rEGs19V9wHT8zxivPjzUmxI1cwFL1ZgWHxEpi4IRsrig4
 1R4/yUbEsHeizkFpXrb1Si+8lG7Ub3qGILM9I/32POu3X0uSus3wp0ZuwESHxCgigoS/x21I=
X-Gm-Gg: Acq92OHf3wxdh4f9KNFhltF4xpEp/IRHgGBnHN2AoEnvZjLjHgIxEwFX1o0onf831HI
 ouLyFpRp6TXSIfpMqYMJ03TuVsRgQywbrmM/W7b+nyrxoHurQkmKF0gbqQc5NrSNsEPDMzL4lIz
 8mLqjTaumRqfTa73hrgovAc+qtXN7xekvpP4LzquOPTmQgBHTMRqxSWDi4/hVe0i9r/7HZKq26D
 qVOeRK7QKFnBmJxq3+T9Zn3InhtWBo0QUdMxf2BL3whDTl5yxzh/Z8P91lMcFkDmokmAfCFrykO
 vIeKZlX6nXV18ajF/dgaz+Mrm3JLLGhpo9Hbs2FqiINyBPwcUpX8na30TwELudxYw9mI+xzFsSn
 C4+QJxufYoS6FuMg3zGbPu54g+h+6t7cgo2dkAlsS9I8s8WOwL0GgeWQUYStIPgmekYTEnhqm+l
 eRQzTKIg8BmnOgNiHz5g==
X-Received: by 2002:a17:90b:58c4:b0:36a:2a9b:3fb5 with SMTP id
 98e67ed59e1d1-36a677f4ba2mr16425713a91.18.1779793904684; 
 Tue, 26 May 2026 04:11:44 -0700 (PDT)
X-Received: by 2002:a17:90b:58c4:b0:36a:2a9b:3fb5 with SMTP id
 98e67ed59e1d1-36a677f4ba2mr16425670a91.18.1779793904174; 
 Tue, 26 May 2026 04:11:44 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a72c4ce6bsm12104253a91.11.2026.05.26.04.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:11:43 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 stable@kernel.org, Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v6 2/5] misc: fastrpc: Remove buffer from list prior to unmap
 operation
Date: Tue, 26 May 2026 19:11:21 +0800
Message-Id: <20260526111124.515-3-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526111124.515-1-jianping.li@oss.qualcomm.com>
References: <20260526111124.515-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Wpwb99fv c=1 sm=1 tr=0 ts=6a157ff1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=8ZZxLbFAX5vHFMKIXQAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: i8JsPPKu8i-8hgzlOeD0XCtVm8XGDC_h
X-Proofpoint-ORIG-GUID: i8JsPPKu8i-8hgzlOeD0XCtVm8XGDC_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5NyBTYWx0ZWRfXzcXsEi2guqh4
 2Jf0HtiuxcEtz+oPDg4EEkXVi/MIVCpszUY9Su3EkZf4AmF7fYE3gAO01HlkI+Afr/xFBuxIKGx
 tQ+be23TnwKZd56fWvN+KzMFQwXUuW5F3MYRYb40H2J1Zg8iHpUM5aFvwxrXjCvFiLrZFPgGACJ
 7wtULj/hy4isrRr4KnmWzAH5YrhPyoXnY36Q28eJ3oOSBbytG88UN9H5pcIgc+OZrpLbmoz3I/u
 4oqNadoXsKIEr4XqPemDu/aLPbrBaGBuU1nPXsCk1m4gnETLY/x5ZQ9tv3amEc9E0fgWfIM28iG
 XLKbLj3+uW1M9ytPJ1L8gWbLb5A6QnTZC/dlYSEhiC1pjQym61j3YhkOTu6N6vCrdA8RWBHSXTE
 is5+/TJK5JgRfXZayqmP7e9IxBajZ8aBCkZLouoyH4heNnx6L6DH+3Sq3sSNHqK7V3E2uAEnv/a
 Ae1bS1Acjjhpm7a3gpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260097
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

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
getting removed from the list after it is unmapped from DSP. This can
create potential race conditions if multiple threads invoke unmap
concurrently, where one thread may remove the entry from the list while
another thread's unmap operation is still ongoing.

Fix this by removing the buffer entry from the list before calling the
unmap operation. If the unmap fails, the entry is re-added to the list
so that userspace can retry the unmap, or alternatively, the buffer
will be cleaned up during device release when the DSP process is torn
down and all DSP-side mappings are freed along with remaining buffers
in the list.

Fixes: 2419e55e532de ("misc: fastrpc: add mmap/unmap support")
Cc: stable@kernel.org
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 80a636962357..a8a58f889d07 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1892,9 +1892,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 				      &args[0]);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
-		spin_lock(&fl->lock);
-		list_del(&buf->node);
-		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
@@ -1908,6 +1905,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1915,6 +1913,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	spin_lock(&fl->lock);
 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
 		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			list_del(&iter->node);
 			buf = iter;
 			break;
 		}
@@ -1927,7 +1926,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	return fastrpc_req_munmap_impl(fl, buf);
+	err = fastrpc_req_munmap_impl(fl, buf);
+	if (err) {
+		spin_lock(&fl->lock);
+		list_add_tail(&buf->node, &fl->mmaps);
+		spin_unlock(&fl->lock);
+	}
+
+	return err;
 }
 
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
-- 
2.43.0

