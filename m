Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DB5CA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 02:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC0410E735;
	Sat,  3 Oct 2026 02:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lHZPvL3j";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TaIWtPAd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CDB810E735
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 02:39:32 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeaG81956821
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 02:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Xl0XIvIGaHU
 gokNEPlpzOm5Y0YuFUhgfwpa57b3H480=; b=lHZPvL3jpcFR/NJ6+8jbtpR6VLw
 nq7UUCc3ru/+7p7cTz59M+Wo6nntcIvAhT9wfkOlwHTfyJx4oqMbMFPy91x4lzf4
 vZhGFlifA+8FFSHWcnGORerNg0i9lVWPYkRq1GiYCetuMJ7Dg91yjjR17MhoT+wd
 QHdWDMQ3PuiLF8I9kbm3AS0aH/9Fv/TVDwdSzy51C9FZ/qNV4sFTwrmYivgSuy4S
 J8dekgA/BnaQ4m8m4i6a9LCVDchYfCNJcxOifVq0rNL6HXgAXynDM7zv7kLWY7wA
 QVYb+U0E+x+UbdSkzeMpTdPzleTEWyBhHx26vZKjfpHV9Xfpav+njXj/ITQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2j0ksbpf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 02:39:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3282d5302ffso265970eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 19:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790995170; x=1791599970;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xl0XIvIGaHUgokNEPlpzOm5Y0YuFUhgfwpa57b3H480=;
 b=TaIWtPAdwsYoLIoRoehNvQYlAYKiJssoSsX8qYaGgU63VusAxLKZzNnSrtXsJJgb7+
 BJeFAMwT7JICQ6e3hEiBvljxXZVEjFf1rlSl2U1FUgA93SDzt8oDfIWiTxFUFBRT5APD
 Emo7sBHG7QYLmVqXvL0a+/fJ6K1/asTBgMieE39MSsB6/7nOTG16o3pbJm+7oaLJMcg5
 MDoHF0GeoroyHajTdfsJUgjwSfW2O4FqUrdj2WgW8xEZg3e5d71QiInSLbMDAO2Bylzo
 1J7KluuaU95OxtXLma9S8B4/46jRVwFyrhNmq8hETQ77QjpeW1u3MFm2AJ11JfUtwWzG
 F5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995170; x=1791599970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xl0XIvIGaHUgokNEPlpzOm5Y0YuFUhgfwpa57b3H480=;
 b=Nsw75Sf4QYk7Jlr7q0kLDUbTW3G+y0hCPzIqxLJwzIoDZyjun9g8Dbz82x3Y3BwYeL
 kvjhDt4kGxI/jkdEVIwrqyw1Tcrc/VDo0s/xeW5gNXz+dYHlMwTnFU8ZkX2xSd8Jdqq8
 PXH1ZXDtye0XAT9VG7wQ3ldO8Bm4yiEhSQvbzsNnVQyRsxap3umtgITslTTLjqGnHhOa
 jrdHuSglAzztKnpKLlgPyIgBoii1x53qkjiKuBjl8hluJJmxSFqCe27JrCaw16pEitIn
 2hTqbyXC92R3fi8rHIRHzacSNNsjwRSA9+eYQdXdpTEOofmdJf1vA89SHGMEqGpxGRmb
 Xf4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIouhLwZYMVNoRcDt38yRez5XKwK6GTgMVRhBKo3douCb1JPRq92IVtdqRal66lSlLufA8ns2SNIQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLzNF8l206JGoEl6iv2dMi5A91RW0dy8WDdOEncCmSofItIJ5v7
 KtcF8/n9ZtgLSQ8M0HxcHx7FBOErGvIMLJfuRscj0zBWgw+A7ixWKY9YGXR9l4N6yTePtT7zyP3
 taK0qKnp+qZ5tKa1RjSuJDoN4oeqfe1zAIgMVsQdzm3t5v1+/jvtq2VCUBOgibGibTfU3XAE=
X-Gm-Gg: AYBFou2w/arkm3Wnd3mQJ179vnwu8/BWSZ4YXRAQqJFW0fMhpnrplYcfYzzi/38kPHj
 l+Kc0DHxWj/xnSl5s53ktvgqbKRWlgTl2mNZzXdz3cLaAyTLLF17a52bE/nE1dIpiLEWvCmk0Io
 YfkVXuTZEh7JWWmKLxG+6l0K5En7TNsyctMAf2pBJHXnrVVszAh/WcvhQstFXMmLUX2zg+8ccJv
 +NUAFc1zAOmkxvOmLJ5pnGg5FKXRntGagWxlM8QNC2nLKpcHhEfZ+2m9ZlcVMnkvCjTCRUOkK1A
 axo4+cuojzvjuQU2oj7QhERkgDFxiJhyfWw/XaT+78Pg47uzF9pk7+7ZIhb8Aiy5PuX48LjxYRz
 d6QqyphprArWv1gE6f+Q/vPsoLDjqs1nivuLYL9j9gDQcreLPFRltXNHi
X-Received: by 2002:a05:7301:90e:b0:34c:9b33:f384 with SMTP id
 5a478bee46e88-34db66065d7mr7911845eec.11.1790995169951; 
 Fri, 02 Oct 2026 19:39:29 -0700 (PDT)
X-Received: by 2002:a05:7301:90e:b0:34c:9b33:f384 with SMTP id
 5a478bee46e88-34db66065d7mr7911823eec.11.1790995169385; 
 Fri, 02 Oct 2026 19:39:29 -0700 (PDT)
Received: from carlv-linux.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3510752b575sm7665736eec.6.2026.10.02.19.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 19:39:29 -0700 (PDT)
From: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6/6] accel/qaic: Use reduced size allocation for FIFOs
Date: Fri,  2 Oct 2026 19:38:18 -0700
Message-ID: <20261003023818.1161666-7-carl.vanderlip@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
References: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAxMCBTYWx0ZWRfX5tJMnZqTcFmV
 BHvlg3xkOFwNFNz9ClgOz1lhrO9UpxuSFBlaqkNQ9EpMOBCH56xEbwTMrRzvoRuIAxVtGv650AG
 fN7Pnw0GlJ2N4WdnGR8ndnZHS/4WmkKMJ7GIgXsC+FrdtKYIzdwpIEKMOTg7Cku9zchk7rUyUR8
 WLFRX7duTKxNc1u2zDYVh9tRkmAU9WskNPW0kfwLDfazCDlmRdsOZx/IsjX8fQK48kSVBgzegBk
 b+2J8oPPCoNcR5wlPNb5wELWkdi+jNWvJLQwNxU6yQJH+FfMtVKdxIJzSJW0gsWownZiBgP3ofO
 q3793io5QvkhaRU2uXDxwBqzGME2LhSvb9pc8otd/Uv4owNhmbWwOOaGwHsEqEXqqehzfDzoMK6
 2Iypd5ju4Zkxv7tD4BHQJ6msaEudJEmSKlAenP0dNHWV/R6xR8pIKIEqTlxx3KRzyz9k1ypGYDK
 w9Mhbth/KcPlIVtLiPw==
X-Proofpoint-GUID: c-zxNpPgrKPW_-mu3V2MpdrEP7lCdhxD
X-Authority-Analysis: v=2.4 cv=Z8B5j3RA c=1 sm=1 tr=0 ts=6ac06ae3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=idRyZ63dR-ApLRvqdSoA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAxMCBTYWx0ZWRfXwiSnVhnxiJGY
 NC4WRtTQWjJXO0mjSgHmsbvjw6wplnJTYXvE+i/LZ/AsHCddYzxkPX7QLip1UAiDIkanJv09w6l
 i6H83qru3akwrwI2vfhoczt/ULiykZQ=
X-Proofpoint-ORIG-GUID: c-zxNpPgrKPW_-mu3V2MpdrEP7lCdhxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030010
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

On memory limited systems, large allocations from the DMA coherent pool are
likely to fail (especially as memory becomes framgented). Leverage the DRM
Scheduler to be able to break up submissions and make them fit within
available allocation.

Signed-off-by: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
---
 drivers/accel/qaic/qaic_control.c | 31 ++++++++++++++++---------------
 drivers/accel/qaic/qaic_sched.c   |  2 --
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_control.c
index 9c4400c0fd17..7619f87043d2 100644
--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -30,7 +30,12 @@
 
 #define MANAGE_MAGIC_NUMBER		((__force __le32)0x43494151) /* "QAIC" in little endian */
 #define QAIC_DBC_Q_GAP			SZ_256
-#define QAIC_DBC_Q_BUF_ALIGN		SZ_4K
+#define QAIC_DBC_Q_MAX_SIZE		SZ_256K
+#define QAIC_DBC_Q_MIN_SIZE		(ALIGN(2 * (get_dbc_req_elem_size() + \
+						    get_dbc_rsp_elem_size()) + \
+					       QAIC_DBC_Q_GAP, SZ_4K))
+#define QAIC_DBC_NELEM(size)		(((size) - QAIC_DBC_Q_GAP) / \
+					(get_dbc_req_elem_size() + get_dbc_rsp_elem_size()))
 #define QAIC_MANAGE_WIRE_MSG_LENGTH	SZ_64K /* Max DMA message length */
 #define QAIC_WRAPPER_MAX_SIZE		SZ_4K
 #define QAIC_MHI_RETRY_WAIT_MS		100
@@ -635,13 +640,13 @@ static int encode_activate(struct qaic_device *qdev, void *trans, struct wrapper
 	struct qaic_manage_trans_activate_to_dev *in_trans = trans;
 	struct wire_trans_activate_to_dev *out_trans;
 	struct wrapper_msg *trans_wrapper;
+	u32 size = QAIC_DBC_Q_MAX_SIZE;
 	struct wrapper_msg *wrapper;
 	struct wire_msg *msg;
 	dma_addr_t dma_addr;
 	u32 msg_hdr_len;
-	void *buf;
 	u32 nelem;
-	u32 size;
+	void *buf;
 	int ret;
 
 	wrapper = list_first_entry(&wrappers->list, struct wrapper_msg, list);
@@ -657,20 +662,16 @@ static int encode_activate(struct qaic_device *qdev, void *trans, struct wrapper
 	if (in_trans->pad)
 		return -EINVAL;
 
-	nelem = in_trans->queue_size;
-	if (check_mul_overflow((u32)(get_dbc_req_elem_size() + get_dbc_rsp_elem_size()),
-			       nelem,
-			       &size))
-		return -EINVAL;
-
-	if (size + QAIC_DBC_Q_GAP + QAIC_DBC_Q_BUF_ALIGN < size)
-		return -EINVAL;
-
-	size = ALIGN((size + QAIC_DBC_Q_GAP), QAIC_DBC_Q_BUF_ALIGN);
-
-	buf = dma_alloc_coherent(&qdev->pdev->dev, size, &dma_addr, GFP_KERNEL);
+	while (size >= QAIC_DBC_Q_MIN_SIZE) {
+		buf = dma_alloc_coherent(&qdev->pdev->dev, size, &dma_addr, GFP_KERNEL);
+		if (!buf)
+			size >>= 1;
+		else
+			break;
+	}
 	if (!buf)
 		return -ENOMEM;
+	nelem = QAIC_DBC_NELEM(size);
 
 	trans_wrapper = add_wrapper(wrappers,
 				    offsetof(struct wrapper_msg, trans) + sizeof(*out_trans));
diff --git a/drivers/accel/qaic/qaic_sched.c b/drivers/accel/qaic/qaic_sched.c
index ded0bdccdfdb..20ad8c13cf26 100644
--- a/drivers/accel/qaic/qaic_sched.c
+++ b/drivers/accel/qaic/qaic_sched.c
@@ -95,8 +95,6 @@ void set_dbc_scaling_ratio(struct dma_bridge_chan *dbc, u32 nelem)
 		dbc->credit_ratio = QAIC_CREDITS;
 		return;
 	}
-	if (QAIC_CREDITS % nelem != 0)
-		pr_debug("Credits not evenly divisible by queue size: size = %d\n", nelem);
 	dbc->credit_ratio = DIV_ROUND_UP(QAIC_CREDITS, nelem);
 }
 
-- 
2.43.0

