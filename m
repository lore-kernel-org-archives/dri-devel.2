Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A37C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F01D10FB5C;
	Fri, 25 Sep 2026 15:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QI86Rg99";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D2+G/Ysp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A968710E539
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:59:25 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PD8vdH289418
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9+1rwJEQXq1
 lO/cD3GiWTUUYzCO5JaKWtBAY2RhYZaI=; b=QI86Rg99O/cQBiooeAMdGH6d2qr
 /2ApE7DEiMzD3YrXNmwz+AFIQiuSiyeU538+94tBUEGoj2itMo2gej/TfPXlqIaF
 zZ72GNYlwbjhiqHnwtDgSSGltE9iecu43LiWKRH0DKQEAzXnXEZewprdY2FRNWfm
 3wweR+e6s0j74nJNxeHevQQbBp3T3hxokyJL8PRt6yueJf2AFuxy/RkmsnSgBBNn
 TXc9twwC6JYh28lCZk+wcQNgeeVN+eTQiS0oTdNHyZe+4VJlNRsnfvPoTUwC1OCN
 6/DfLq+X7JrgAdJpeU7WAmXzD0xZrYB28w+K3rYTyvBwyJiFwLIJro0IqDg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw881vb24-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:59:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8716b158692so467459b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790351964; x=1790956764;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9+1rwJEQXq1lO/cD3GiWTUUYzCO5JaKWtBAY2RhYZaI=;
 b=D2+G/Yspa8jraxuqUqIX3+cn0/ex5ldNER9Fmqi4NdPYAr0+agXFkoZ+fixebiMKSo
 HXOerndAZM+otr9DiaNzg0MlKnLkhpM90bHE6f1YjMyxifvKzQw0puutHt+PjCoJWrAp
 LOPsm6+0uEn4Ukexkjt89u5HdAUNOpG8rNRwU70rGiyhqK6yfADJl+udRJ6SPcu//bah
 UPx0fmlUsP3z4LHBPXvQBEBAMsyZ9MjyFSsUqQ0X1hY6tHIBrHmBLpvxDcmaMPgb9qnw
 FBaLj8mQaKLbzLXgcBktE5IZypJ4F8t7yvkYIMRlOUmPlPzPYtk6JnHAksy7I9LG3qia
 RlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351964; x=1790956764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9+1rwJEQXq1lO/cD3GiWTUUYzCO5JaKWtBAY2RhYZaI=;
 b=N7eRNQ9vt21WYxUWhZseR5SVZV/smDVqdB6gD+YEqNfV2K0vHFr+9T1CDuN9oQqflN
 5ksSy0pcce9t1HxaPOWh4QY8Bna0Hjl2OCUnoS/SZ3kbPyBoqQnG+J4k/cG02QMrdVaw
 0/NkghTB9r6BA6DJrJq/vDAuz9XS8xAN93f8eX7inxwtP7fVnxl7S/Wo8lOGj3e8gBY2
 gckx2MmlgwDVcZri/ooWxr357NXLJQrUaLzVqBEDmH3qhiMMznZ+AOVZDOFXouH09pfN
 jSMAUUPGHZqBxczrN6aYhG3r8s9yEyqTLwqMrfKFT0lwDfis0xUpc3rWlrP/5UXq83qy
 CJWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCeCQQ80Nf+/KS8+yW1pGY1XGoCsQeRj/bOlg7d1jVDjCAEy8hy5PPXBqmqNr4wrvJcPTy/SnfCh4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5ontlIOVN58+o/WdCGCLOQJm09gRvvKLEk7Y6gailGtlbDjNZ
 PXDFQmrYH9Hh5iodk29LQE5kDQ5Hb8gqL8gUmZdsIxbn2MWnxS/mQQuSuFk/M77bzyyYY8usTvq
 DmY5Vyx8ooZbp9ZOka/jAU3jXwM007jcw1hegU1p3NMAbmpnCJ9zNrE4Yn3oQPCYYZnWTuBs=
X-Gm-Gg: AYBFou3+1VymWMflQw6hq9zn2oxW4PCRhX21M8PIlNYrSMm8kn9g5EFBEbkALnqRi8+
 Y+GRcG8HyfHn5NELR5K3ieQCmJr1vR0JpY5BYdhmbqk6fQe/7KdiZGLMtakl8kaCWKTYC32aGWO
 rM4ypoJJSZUoMSeT9tfIOfAiEhrySNS/06niTlF76GAvXvtqjS6+78cRdI2OnsnPPyZZSe5+5C4
 gymiDOnOzNLBUoKpmCYaaqsnHiNfXRBz+YdnVkHVGkHyYN0+raqUN3Zn44HbgOfFqwJpxrm8kyr
 pojPET7cNHvfHwJJqIVGvp1O4LkyGxFhH+p8Hax/5aJ9PLXrYmvaWOAQoMDFoEL3KztpZ9st2HE
 UyU0evDqqvrtlCio85hfV+Uus0ts=
X-Received: by 2002:a05:6a00:6f12:b0:880:a842:bb06 with SMTP id
 d2e1a72fcca58-880a842c13cmr905902b3a.45.1790351963319; 
 Fri, 25 Sep 2026 08:59:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:6f12:b0:880:a842:bb06 with SMTP id
 d2e1a72fcca58-880a842c13cmr905860b3a.45.1790351962748; 
 Fri, 25 Sep 2026 08:59:22 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87ff354d854sm1361299b3a.2.2026.09.25.08.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:59:21 -0700 (PDT)
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
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH 8/8] firmware: qcom: pas: remove qcom_pas_auth_and_reset()
Date: Fri, 25 Sep 2026 21:27:37 +0530
Message-ID: <20260925155737.4161358-9-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6ab69a5c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=sV0Ut8U-cAKt8JUqj3YA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfXzdHrYrxpvxjp
 O4A8G2MJFx6+WBXdj2zxahPYapl6In7fH3ANUigklywkey+5vwHqfYHVI4U38Z7TLc+dtZVsf6r
 iLjaIDAnpWzp95zkrBy7hG9AyJHZLx2yx2VHmgC0Qt9Tss8WoJ/iOqFsyEWuvp7Rkf+kvvEAAyp
 uJMfGCtWJuH+sxjarca3Wp1kdCDNZ0qCdVZt0RX3s8ETQwwsoJyMNs74LjHfDvzphJZ44kxW0lc
 Inkb84ozn/cmO/gaq2ixNOwS8ELX4SUXzAjIsVgSFLBx4mYXNisR6PQ2OaUZgkN61lgY37hEeQ2
 T4qpwgiIbKDyqQ2mTlbt/krP8aDzJQplDDhQyvpKp64GfitQt9WY5fYisIfZXcESsR8ucNU76Jy
 XciKzgCi+tIg8IK13AhOf9c1+3w+U+aj3AO/C/11F7n6bf+YibIyO3yhXvX1d67izqdZhDaW9Rs
 l+l5KItHPN88HWt5pfA==
X-Proofpoint-ORIG-GUID: Sbf9LOTwUxC0cJcopl_xNYVDz1fvhEVT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX+mTDLNOjRRJu
 yhhfIpuCT7zkcAYPZhXpKGCTGGw52WIOX1r0/CH8HK5CGsjtJNn/gx16EyzArv9gYXlSeCMHfrj
 LgFQoBWI2UUdNbY0HY07yusPD0Z85Kk=
X-Proofpoint-GUID: Sbf9LOTwUxC0cJcopl_xNYVDz1fvhEVT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250063
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

All callers have been migrated to qcom_pas_prepare_and_auth_reset(),
which additionally sets up a shmbridge over firmware memory before
TrustZone authentication.  Remove the bare pas_id-only wrapper, its
EXPORT_SYMBOL_GPL, the header declaration, the auth_and_reset ops slot
from struct qcom_pas_ops and both backend implementations.

The internal helper functions (__qcom_scm_pas_auth_and_reset,
__qcom_pas_tee_auth_and_reset) remain as they are called directly by
their respective prepare_and_auth_reset implementations.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_pas.c       | 16 ----------------
 drivers/firmware/qcom/qcom_pas.h       |  3 ---
 drivers/firmware/qcom/qcom_pas_tee.c   |  6 ------
 drivers/firmware/qcom/qcom_scm.c       |  7 +++----
 include/linux/firmware/qcom/qcom_pas.h |  1 -
 5 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
index 93d78a5c1201..6de6d62adfde 100644
--- a/drivers/firmware/qcom/qcom_pas.c
+++ b/drivers/firmware/qcom/qcom_pas.c
@@ -166,22 +166,6 @@ struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
 }
 EXPORT_SYMBOL_GPL(qcom_pas_get_rsc_table);
 
-/**
- * qcom_pas_auth_and_reset() - Authenticate the given peripheral firmware
- *			       and reset the remote processor
- * @pas_id:	peripheral authentication service id
- *
- * Return: 0 on success.
- */
-int qcom_pas_auth_and_reset(u32 pas_id)
-{
-	if (!ops_ptr)
-		return -ENODEV;
-
-	return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
-}
-EXPORT_SYMBOL_GPL(qcom_pas_auth_and_reset);
-
 /**
  * qcom_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
  *				       remote processor
diff --git a/drivers/firmware/qcom/qcom_pas.h b/drivers/firmware/qcom/qcom_pas.h
index 8643e2760602..a296be2be8c0 100644
--- a/drivers/firmware/qcom/qcom_pas.h
+++ b/drivers/firmware/qcom/qcom_pas.h
@@ -18,8 +18,6 @@ struct device;
  * @get_rsc_table:		Peripheral get resource table callback.
  * @prepare_and_auth_reset:	Peripheral prepare firmware authentication and
  *				reset callback.
- * @auth_and_reset:		Peripheral firmware authentication and reset
- *				callback.
  * @set_remote_state:		Peripheral set remote state callback.
  * @shutdown:			Peripheral shutdown callback.
  * @metadata_release:		Image metadata release callback.
@@ -37,7 +35,6 @@ struct qcom_pas_ops {
 			       size_t *output_rt_size);
 	int (*prepare_and_auth_reset)(struct device *dev,
 				      struct qcom_pas_context *ctx);
-	int (*auth_and_reset)(struct device *dev, u32 pas_id);
 	int (*set_remote_state)(struct device *dev, u32 state, u32 pas_id);
 	int (*shutdown)(struct device *dev, u32 pas_id);
 	void (*metadata_release)(struct device *dev,
diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
index ac33a00687aa..dbab9a43e6ca 100644
--- a/drivers/firmware/qcom/qcom_pas_tee.c
+++ b/drivers/firmware/qcom/qcom_pas_tee.c
@@ -320,11 +320,6 @@ static int __qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id,
 	return ret;
 }
 
-static int qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id)
-{
-	return __qcom_pas_tee_auth_and_reset(dev, pas_id, 0, 0);
-}
-
 static int qcom_pas_tee_prepare_and_auth_reset(struct device *dev,
 					       struct qcom_pas_context *ctx)
 {
@@ -401,7 +396,6 @@ static struct qcom_pas_ops qcom_pas_ops_tee = {
 	.init_image		= qcom_pas_tee_init_image,
 	.mem_setup		= qcom_pas_tee_mem_setup,
 	.get_rsc_table		= qcom_pas_tee_get_rsc_table,
-	.auth_and_reset		= qcom_pas_tee_auth_and_reset,
 	.prepare_and_auth_reset	= qcom_pas_tee_prepare_and_auth_reset,
 	.set_remote_state	= qcom_pas_tee_set_remote_state,
 	.shutdown		= qcom_pas_tee_shutdown,
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index dc57c87870cf..08b9c5049dd9 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -845,7 +845,7 @@ static void *qcom_scm_pas_get_rsc_table(struct device *dev,
 	return ret ? ERR_PTR(ret) : tbl_ptr;
 }
 
-static int qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
+static int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -886,7 +886,7 @@ static int qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
 	 * memory region and then invokes a call to TrustZone to authenticate.
 	 */
 	if (!ctx->use_tzmem)
-		return qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
+		return __qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
 
 	/*
 	 * When Linux runs @ EL2 Linux must create the shmbridge itself and then
@@ -896,7 +896,7 @@ static int qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
+	ret = __qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
 	qcom_tzmem_shm_bridge_delete(handle);
 
 	return ret;
@@ -977,7 +977,6 @@ static struct qcom_pas_ops qcom_pas_ops_scm = {
 	.init_image		= qcom_scm_pas_init_image,
 	.mem_setup		= qcom_scm_pas_mem_setup,
 	.get_rsc_table		= qcom_scm_pas_get_rsc_table,
-	.auth_and_reset		= qcom_scm_pas_auth_and_reset,
 	.prepare_and_auth_reset	= qcom_scm_pas_prepare_and_auth_reset,
 	.set_remote_state	= qcom_scm_pas_set_remote_state,
 	.shutdown		= qcom_scm_pas_shutdown,
diff --git a/include/linux/firmware/qcom/qcom_pas.h b/include/linux/firmware/qcom/qcom_pas.h
index 1d132e89536e..07d0f1fad85f 100644
--- a/include/linux/firmware/qcom/qcom_pas.h
+++ b/include/linux/firmware/qcom/qcom_pas.h
@@ -46,7 +46,6 @@ struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
 					      void *input_rt, size_t input_rt_size,
 					      size_t *output_rt_size);
 int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
-int qcom_pas_auth_and_reset(u32 pas_id);
 int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx);
 int qcom_pas_set_remote_state(u32 state, u32 pas_id);
 int qcom_pas_shutdown(u32 pas_id);
-- 
2.55.0

