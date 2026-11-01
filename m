Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB056070E95
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QkYCekao;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gRxnUADm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70AF010E4A6;
	Sun,  1 Nov 2026 22:22:49 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F49010E49F
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:22:38 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KJx4r1801066
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hlMIPaqL+PvZiEzvjUKnDJLcYNTC0KyJ3MSRD4Nn57k=; b=QkYCekaoPzP4LePQ
 5RQvM1fi93ByBcAKPIvHgo6Pk8mJx5EMSKAXJEoW8AaTQDozDxOLbgQT+UR3orAD
 36H496t25PfKQDJbJgnRJ38iiHK2YeEcHMfEUHdUKYpQqdykqI+L++lGvDaGuaSm
 xwfi6NIxMJ8keWSyS8hIic/ou4M1/oOfvl83VcKndO0hxyqif2hw4VbbyBbu7d8u
 9DCa9qSRH2m+DlclAbjyHH0Tew8yvXdr+t20MEHD6Tu5dKyxswJ4OorIhA9FpwNt
 ASO8z//nfr1aQUn+2EN9HGbKiRd9+j/fV1hV3Z/kojoxQ6TkVTTxAdjhFBxJbnHD
 Q8yTvg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8duca14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:22:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so4798078eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571756; x=1794176556;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hlMIPaqL+PvZiEzvjUKnDJLcYNTC0KyJ3MSRD4Nn57k=;
 b=gRxnUADmjldIASusuGeOsYDMQDagu0NBeqaUiFOEOY2l9Ed0aoGQxHeo5c9IwPiQ9e
 RytlhHNBLF0KdUqEbq+Jj5Fj5w0LAsqNZGCzWRPTQyPpyAl2PGlLejX64kwOOn+IzCja
 BejBwRsvWBiyh4kgzh9RbLmGd3Ws1XoLpnEFGSyBMWgLroPoogi5kIKhubEGnOqTkTaj
 teZ+oUr2VATfWjrxLwUf6x/dlHpKv8Y3JhQf/7Yl0FAm9bpD0AcedJdwW/TA23kIoUc1
 M8yPzTSrscu8yEtDzMrIIWqEfdZ3lvS/SQ5OVuJVNi8ClFx19Pp4tLDvGJBh/rGNmM5C
 ehyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571756; x=1794176556;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hlMIPaqL+PvZiEzvjUKnDJLcYNTC0KyJ3MSRD4Nn57k=;
 b=SNpLwxDS42gi9ruI7p00H5hsIO0NqkEbbH7P2e8xRl/5iC8pIrP8ZP/LPqIhKn7M+3
 BZ0e5LYsQG7dmGBFOmoA6OZkm5f6BvP/uzXGPGFq+KxKSim56q7HRjkCbNlrfHVCpuEN
 AzJ69mceA+P8hQh16Yh922DMkv/xZMRzEu2omd4PXaxf6L4NddAIhzrrqm7qsdDBiHqr
 L1C/KCR/jIWRqp426Xc/R3/0lb3Mzk1Lyh7XHzkmaUu+6a/JC+IgmRvU0WvWgy5yFLYY
 +Et5QiKPcXTBODHBhNq4o9EXDxGwJN6tdRMziqy3hrE7HiXQI+RS7xdhACfwbes+TSYp
 yYGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1WkSsbDR376wNrMC0fm1gO2CbcOk4WWATHd2wdmtDnbUxQU0I9scsuJ2gD57lNaCG5Tms8xuYqjU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI3wvmjxnzLJHjMqnluIBm7y2PG6TDVZUvdsppntxWgcRhOY8U2
 XCaJLvgVvOf/7zk260HauQcgbqhVLXHJm2iSUL5/d8ybm5er6jVXq1BKMH1s7cXlHwCYtM7zU17
 Q4L+bbTRjMZVJQmMSU/lmm8dCGdR07lrHFyTJ99flvhkjeyZYwKsvlj15i1HRlB5FmILcZSg=
X-Gm-Gg: AYBFou2vh2eMmRpiql9gs1ozlBu94xokoW5Y+oAdPEVetfGE13bu6luMkJe47p2rD7C
 COlk9+1u67F88YlBzs4hRhLMpY3ARSk8V4jDIr8CFh6tFoJor6UZx/yDL0HfdyT2UjUwYiKDJOz
 LYU2cuNWi1X9odrMuCOZixowphXDiDCY9yc3fAV+11h4o17LHd8F4bp3rxyBSDm+2iKr+YwZT+i
 zrW3PHz9eSktY0gZgoBLqv0AiEjzF1d2MRlyPSiJNTg0tUO8ejeDtkVaoj+eYzss3ngs6VFLduK
 ZqR7lBjCoLqtTRbuUm5XtF5BcbN778TtxlcBQL2QpO4MWnlbchcF3/2kXXn7GtHRgdw+vb4bhW+
 3DVbfXul+6eTFVOhJo9feS1y1gorSQyAHlzWH2yqu1293ylj4+BzSZgDz9lILcIVH9wKlrIPtFP
 LyYtmL4w==
X-Received: by 2002:a05:701a:ca8a:b0:19a:e0eb:6916 with SMTP id
 a92af1059eb24-1ac5de540bbmr13846318c88.42.1793571755282; 
 Sun, 01 Nov 2026 14:22:35 -0800 (PST)
X-Received: by 2002:a05:701a:ca8a:b0:19a:e0eb:6916 with SMTP id
 a92af1059eb24-1ac5de540bbmr13846252c88.42.1793571754510; 
 Sun, 01 Nov 2026 14:22:34 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:22:34 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:19 +0530
Subject: [PATCH v4 06/25] accel/qda: Add buffer allocation for the DSP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-6-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
In-Reply-To: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, krzk@kernel.org, rob.clark@oss.qualcomm.com,
 jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=22657;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=9N7TA+2+W2UMqqUbpDveakcIuPYFd1QiXRGu8XhwegQ=;
 b=8EiGFSt0lrBCW9rknddsEQwOjs/FssaDo6qOXZepRJhsJ5qeh8WVSO/E1Ko/1FU3wh4sn8UyQ
 hrw+Wr4TM9hAtc8MqJqHL9hv+ZKadEItfFLo8FTDf6/fSrwqElgILHJ
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Authority-Analysis: v=2.4 cv=O6esLx9W c=1 sm=1 tr=0 ts=6ae7bbad cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=7z_tYdm8GhO2maLBuF0A:9 a=bEKAsToG59ufCy0w:21
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: -bvUSwJp5iY4VDZm8sZprcWn2VtTNLos
X-Proofpoint-GUID: -bvUSwJp5iY4VDZm8sZprcWn2VtTNLos
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX8T2/0/fz54B9
 1S+n+m9gOcDmB9dAUehRoFrCxbvEO+8z/BppYnEaGIoodqMvX2aW6Bvhzl8ehXbtqIC+1Ny5tFl
 d/fUZQDhi88XSCUCsZbWc08Qek8j5GwCHbtL1X3gQwy5wopkmeqhzfip05HFP0EGLzcQIKpMuLP
 uCymmVIWixgsTJ2iRWUcEUb4QzjWisY/HB+12KA+WTUbSMsTQ2iBOiXImMFRAJT5Vb0ToYrddgH
 QfHrNATJ7CJ6EuzT5+Cfr7AmmZZK5X3/FHxrzkPqSunI3AQEVn3obaA407FTUkLODjE4xutx74j
 QTba1+bYSFh5BXFyFJOEOzFqGp0FBX/HxUr3t44s+2JULnzeupv0+J2XaOG5t2pDgAmuWrIAEgo
 6dkcIb62ba84DJ77owFlnLpmEprdb2ZCOlIrFlFGafPJ9wgytfFDozP17+pi+uNHdFAQQ4UewmX
 6FXEUZDViKdPHNl2HBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX9c8k5D5xOX3Y
 fZ0olcj0HTj+48/vYuCRUOCTu+A6zZ6bmoCAbiEA09wBSzPIdcWuHKAR42Pz8e+7IUEQVcS9D52
 evoZdc76bVOZd6qgDJbFH6ELCxODiVs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010089
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

Offloading work to the DSP means handing it buffers, and the DSP can
only reach memory mapped into one of its context banks. Allocate those
buffers as GEM objects so that user space gets the usual handle-based
lifetime and the usual mmap path, and so that buffers can later be
shared with other drivers through PRIME.

Buffers are allocated with dma_alloc_coherent() from the context bank
the session owns, which is assigned on the session's first allocation.
Coherent memory avoids explicit cache maintenance on every invocation,
at the cost of uncached CPU access.

The DSP does not take a context bank identifier alongside an address.
It derives the context bank from the upper bits of the address itself,
so the stream ID of the bank is folded into every address handed to it,
at a bit position that differs between SoCs. The DMA API must never see
those bits, so they are stripped again before each free and mmap. This
is also why the context bank devices are given a DMA mask covering only
the lower bits: the allocator must not hand back an address that would
overlap the stream ID field.

Add DRM_IOCTL_QDA_GEM_CREATE to allocate a buffer and
DRM_IOCTL_QDA_GEM_MMAP_OFFSET to find the offset to mmap() it at.
Nothing passes these buffers to the DSP yet; that comes with the
invocation path.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/Makefile             |   2 +
 drivers/accel/qda/qda_cb.c             |  14 ++++-
 drivers/accel/qda/qda_drv.c            |   4 +-
 drivers/accel/qda/qda_gem.c            | 108 +++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_gem.h            |  44 ++++++++++++++
 drivers/accel/qda/qda_ioctl.c          |  45 ++++++++++++++
 drivers/accel/qda/qda_ioctl.h          |   2 +
 drivers/accel/qda/qda_memory_dma.c     |  72 ++++++++++++++++++++++
 drivers/accel/qda/qda_memory_dma.h     |  20 ++++++
 drivers/accel/qda/qda_memory_manager.c |  37 +++++++++++
 drivers/accel/qda/qda_memory_manager.h |   8 +++
 drivers/accel/qda/qda_soc.c            |   2 +
 drivers/accel/qda/qda_soc.h            |  28 +++++++++
 include/uapi/drm/qda_accel.h           |  38 +++++++++++-
 14 files changed, 420 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
index 402e7dbebbf0..2d3bcc3050eb 100644
--- a/drivers/accel/qda/Makefile
+++ b/drivers/accel/qda/Makefile
@@ -8,7 +8,9 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
 qda-y := \
 	qda_cb.o \
 	qda_drv.o \
+	qda_gem.o \
 	qda_ioctl.o \
+	qda_memory_dma.o \
 	qda_memory_manager.o \
 	qda_rpmsg.o \
 	qda_soc.o
diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
index 6f1cff1133f9..033d1502282a 100644
--- a/drivers/accel/qda/qda_cb.c
+++ b/drivers/accel/qda/qda_cb.c
@@ -10,7 +10,7 @@
 #include "qda_memory_manager.h"
 #include "qda_soc.h"
 
-static int qda_cb_setup_device(struct qda_dev *qdev, struct device *cb_dev)
+static int qda_cb_setup_device(struct qda_dev *qdev, struct device *cb_dev, u32 sid)
 {
 	struct qda_iommu_device *iommu_dev;
 	int ret;
@@ -21,6 +21,7 @@ static int qda_cb_setup_device(struct qda_dev *qdev, struct device *cb_dev)
 
 	iommu_dev->dev = cb_dev;
 	iommu_dev->qdev = qdev;
+	iommu_dev->sid = sid;
 
 	ret = qda_memory_manager_register_device(qdev->iommu_mgr, iommu_dev);
 	if (ret) {
@@ -50,8 +51,17 @@ static int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_nod
 	struct qda_cb_dev *entry;
 	struct platform_device *pdev;
 	u32 dma_bits;
+	u32 sid = 0;
 	int ret;
 
+	/*
+	 * The stream ID identifies the context bank to the DSP. A node without
+	 * one is accepted so that buffers can still be allocated from it, but
+	 * the DSP will then see every such bank as stream ID 0.
+	 */
+	if (of_property_read_u32(cb_node, "reg", &sid))
+		drm_info(&qdev->drm_dev, "No stream ID in %pOFn, using 0\n", cb_node);
+
 	pdev = of_platform_device_create(cb_node, NULL, qdev->dev);
 	if (!pdev) {
 		drm_err(&qdev->drm_dev, "Failed to create CB device for %pOFn\n", cb_node);
@@ -66,7 +76,7 @@ static int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_nod
 		goto err_destroy;
 	}
 
-	ret = qda_cb_setup_device(qdev, &pdev->dev);
+	ret = qda_cb_setup_device(qdev, &pdev->dev, sid);
 	if (ret)
 		goto err_destroy;
 
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index e722135238f3..37019ff38ecb 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -58,10 +58,12 @@ DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
 
 static const struct drm_ioctl_desc qda_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
+	DRM_IOCTL_DEF_DRV(QDA_GEM_CREATE, qda_ioctl_gem_create, 0),
+	DRM_IOCTL_DEF_DRV(QDA_GEM_MMAP_OFFSET, qda_ioctl_gem_mmap_offset, 0),
 };
 
 static const struct drm_driver qda_drm_driver = {
-	.driver_features = DRIVER_COMPUTE_ACCEL,
+	.driver_features = DRIVER_GEM | DRIVER_COMPUTE_ACCEL,
 	.fops = &qda_accel_fops,
 	.open = qda_open,
 	.postclose = qda_postclose,
diff --git a/drivers/accel/qda/qda_gem.c b/drivers/accel/qda/qda_gem.c
new file mode 100644
index 000000000000..864bac914e48
--- /dev/null
+++ b/drivers/accel/qda/qda_gem.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <drm/drm_gem.h>
+#include "qda_drv.h"
+#include "qda_gem.h"
+#include "qda_memory_dma.h"
+#include "qda_memory_manager.h"
+
+static void qda_gem_free_object(struct drm_gem_object *gem_obj)
+{
+	struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(gem_obj);
+
+	if (qda_gem_obj->virt)
+		qda_memory_manager_free(qda_gem_obj);
+
+	drm_gem_object_release(gem_obj);
+	kfree(qda_gem_obj);
+}
+
+static int qda_gem_mmap_obj(struct drm_gem_object *gem_obj, struct vm_area_struct *vma)
+{
+	struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(gem_obj);
+	int ret;
+
+	/* The fake offset only identifies the object, it does not index into it */
+	vma->vm_pgoff = 0;
+
+	ret = qda_dma_mmap(qda_gem_obj, vma);
+	if (ret)
+		return ret;
+
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
+
+	return 0;
+}
+
+static const struct drm_gem_object_funcs qda_gem_object_funcs = {
+	.free = qda_gem_free_object,
+	.mmap = qda_gem_mmap_obj,
+};
+
+/**
+ * qda_gem_create_object() - Allocate a buffer the DSP can access
+ * @drm_dev: DRM device
+ * @iommu_mgr: Memory manager to allocate from
+ * @size: Requested size in bytes
+ * @session: Session the buffer belongs to
+ *
+ * Return: The new GEM object on success, ERR_PTR on failure
+ */
+struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
+					     struct qda_memory_manager *iommu_mgr,
+					     size_t size, struct qda_session *session)
+{
+	struct qda_gem_obj *qda_gem_obj;
+	size_t aligned_size;
+	int ret;
+
+	aligned_size = PAGE_ALIGN(size);
+	if (!aligned_size)
+		return ERR_PTR(-EINVAL);
+
+	qda_gem_obj = kzalloc_obj(*qda_gem_obj);
+	if (!qda_gem_obj)
+		return ERR_PTR(-ENOMEM);
+
+	ret = drm_gem_object_init(drm_dev, &qda_gem_obj->base, aligned_size);
+	if (ret) {
+		kfree(qda_gem_obj);
+		return ERR_PTR(ret);
+	}
+
+	qda_gem_obj->base.funcs = &qda_gem_object_funcs;
+	qda_gem_obj->size = aligned_size;
+
+	ret = qda_memory_manager_alloc(iommu_mgr, qda_gem_obj, session);
+	if (ret) {
+		drm_gem_object_release(&qda_gem_obj->base);
+		kfree(qda_gem_obj);
+		return ERR_PTR(ret);
+	}
+
+	return &qda_gem_obj->base;
+}
+
+/**
+ * qda_gem_create_handle() - Give user space a handle to a GEM object
+ * @file_priv: DRM file to install the handle in
+ * @gem_obj: Object to install
+ * @handle: Returned handle
+ *
+ * Consumes the caller's reference on @gem_obj: the handle holds one of its
+ * own, so on success the object stays alive until user space closes it, and
+ * on failure it is destroyed here.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_gem_create_handle(struct drm_file *file_priv, struct drm_gem_object *gem_obj, u32 *handle)
+{
+	int ret;
+
+	ret = drm_gem_handle_create(file_priv, gem_obj, handle);
+	drm_gem_object_put(gem_obj);
+
+	return ret;
+}
diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
new file mode 100644
index 000000000000..af3b9dfc7509
--- /dev/null
+++ b/drivers/accel/qda/qda_gem.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef __QDA_GEM_H__
+#define __QDA_GEM_H__
+
+#include <linux/dma-mapping.h>
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
+
+struct qda_iommu_device;
+struct qda_memory_manager;
+struct qda_session;
+
+/**
+ * struct qda_gem_obj - A buffer the DSP can access
+ */
+struct qda_gem_obj {
+	/** @base: DRM GEM object base; must be first member */
+	struct drm_gem_object base;
+	/** @iommu_dev: Context bank this buffer is mapped into */
+	struct qda_iommu_device *iommu_dev;
+	/** @virt: Kernel virtual address of the buffer */
+	void *virt;
+	/** @dma_addr: Address of the buffer as the DSP sees it */
+	dma_addr_t dma_addr;
+	/** @size: Size of the buffer in bytes */
+	size_t size;
+};
+
+/**
+ * to_qda_gem_obj - Cast a drm_gem_object pointer to qda_gem_obj
+ * @gem_obj: Pointer to the embedded drm_gem_object
+ */
+#define to_qda_gem_obj(gem_obj) container_of(gem_obj, struct qda_gem_obj, base)
+
+struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
+					     struct qda_memory_manager *iommu_mgr,
+					     size_t size, struct qda_session *session);
+int qda_gem_create_handle(struct drm_file *file_priv, struct drm_gem_object *gem_obj, u32 *handle);
+
+#endif /* __QDA_GEM_H__ */
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index 380c2526d9d2..b11743ab791e 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -3,8 +3,10 @@
 #include <linux/string.h>
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
+#include <drm/drm_gem.h>
 #include <drm/qda_accel.h>
 #include "qda_drv.h"
+#include "qda_gem.h"
 #include "qda_ioctl.h"
 
 /**
@@ -28,3 +30,46 @@ int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_pr
 		return -EINVAL;
 	}
 }
+
+/**
+ * qda_ioctl_gem_create() - Allocate a buffer the DSP can access
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_gem_create)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct qda_dev *qdev = qda_dev_from_drm(dev);
+	struct drm_qda_gem_create *args = data;
+	struct drm_gem_object *gem_obj;
+
+	if (args->pad)
+		return -EINVAL;
+
+	gem_obj = qda_gem_create_object(dev, qdev->iommu_mgr, args->size,
+					file_priv->driver_priv);
+	if (IS_ERR(gem_obj))
+		return PTR_ERR(gem_obj);
+
+	return qda_gem_create_handle(file_priv, gem_obj, &args->handle);
+}
+
+/**
+ * qda_ioctl_gem_mmap_offset() - Get the mmap offset of a buffer
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_gem_mmap_offset)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_gem_mmap_offset *args = data;
+
+	if (args->pad)
+		return -EINVAL;
+
+	return drm_gem_dumb_map_offset(file_priv, dev, args->handle, &args->offset);
+}
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
index b8fd536a111f..d1cbbfb6d965 100644
--- a/drivers/accel/qda/qda_ioctl.h
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -9,5 +9,7 @@
 #include "qda_drv.h"
 
 int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv);
 
 #endif /* __QDA_IOCTL_H__ */
diff --git a/drivers/accel/qda/qda_memory_dma.c b/drivers/accel/qda/qda_memory_dma.c
new file mode 100644
index 000000000000..0f4715a55b9d
--- /dev/null
+++ b/drivers/accel/qda/qda_memory_dma.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/dma-mapping.h>
+#include "qda_drv.h"
+#include "qda_gem.h"
+#include "qda_memory_dma.h"
+#include "qda_memory_manager.h"
+#include "qda_soc.h"
+
+/*
+ * The DSP identifies the context bank a buffer belongs to from the upper bits
+ * of its address, so the stream ID is folded into every address handed to it.
+ * The DMA API only ever sees the plain address, which is why the context bank
+ * devices are created with a mask that covers just those lower bits.
+ */
+static dma_addr_t qda_gem_dma_addr(struct qda_gem_obj *gem_obj)
+{
+	return qda_soc_dma_addr(gem_obj->iommu_dev->qdev->soc_data, gem_obj->dma_addr);
+}
+
+/**
+ * qda_dma_alloc() - Allocate a buffer from a context bank
+ * @iommu_dev: Context bank to allocate from
+ * @gem_obj: GEM object to back with the allocation
+ * @size: Size to allocate in bytes
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
+		  struct qda_gem_obj *gem_obj, size_t size)
+{
+	dma_addr_t dma_addr;
+	void *virt;
+
+	virt = dma_alloc_coherent(iommu_dev->dev, size, &dma_addr, GFP_KERNEL);
+	if (!virt)
+		return -ENOMEM;
+
+	gem_obj->virt = virt;
+	gem_obj->dma_addr = dma_addr +
+			    qda_soc_sid_offset(iommu_dev->qdev->soc_data, iommu_dev->sid);
+	gem_obj->iommu_dev = iommu_dev;
+
+	return 0;
+}
+
+/**
+ * qda_dma_free() - Release a buffer back to its context bank
+ * @gem_obj: GEM object to free
+ */
+void qda_dma_free(struct qda_gem_obj *gem_obj)
+{
+	dma_free_coherent(gem_obj->iommu_dev->dev, gem_obj->size,
+			  gem_obj->virt, qda_gem_dma_addr(gem_obj));
+
+	gem_obj->virt = NULL;
+	gem_obj->dma_addr = 0;
+	gem_obj->iommu_dev = NULL;
+}
+
+/**
+ * qda_dma_mmap() - Map a buffer into user space
+ * @gem_obj: GEM object to map
+ * @vma: Virtual memory area to map into
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_dma_mmap(struct qda_gem_obj *gem_obj, struct vm_area_struct *vma)
+{
+	return dma_mmap_coherent(gem_obj->iommu_dev->dev, vma, gem_obj->virt,
+				 qda_gem_dma_addr(gem_obj), gem_obj->size);
+}
diff --git a/drivers/accel/qda/qda_memory_dma.h b/drivers/accel/qda/qda_memory_dma.h
new file mode 100644
index 000000000000..f4d76b806df6
--- /dev/null
+++ b/drivers/accel/qda/qda_memory_dma.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_MEMORY_DMA_H__
+#define __QDA_MEMORY_DMA_H__
+
+#include <linux/mm_types.h>
+#include <linux/types.h>
+
+struct qda_gem_obj;
+struct qda_iommu_device;
+
+int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
+		  struct qda_gem_obj *gem_obj, size_t size);
+void qda_dma_free(struct qda_gem_obj *gem_obj);
+int qda_dma_mmap(struct qda_gem_obj *gem_obj, struct vm_area_struct *vma);
+
+#endif /* __QDA_MEMORY_DMA_H__ */
diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
index 87e8d3485e81..ccab85c17203 100644
--- a/drivers/accel/qda/qda_memory_manager.c
+++ b/drivers/accel/qda/qda_memory_manager.c
@@ -5,6 +5,8 @@
 #include <linux/spinlock.h>
 #include <drm/drm_print.h>
 #include "qda_drv.h"
+#include "qda_gem.h"
+#include "qda_memory_dma.h"
 #include "qda_memory_manager.h"
 
 static void iommu_device_free(struct kref *ref)
@@ -86,6 +88,41 @@ void qda_memory_manager_release_device(struct qda_iommu_device *iommu_dev)
 	kref_put(&iommu_dev->ref, iommu_device_free);
 }
 
+/**
+ * qda_memory_manager_alloc() - Allocate a buffer for a session
+ * @mem_mgr: Memory manager of the device
+ * @gem_obj: GEM object to back with the allocation
+ * @session: Session the buffer belongs to
+ *
+ * Allocates from the context bank the session owns, assigning it one on its
+ * first allocation.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr, struct qda_gem_obj *gem_obj,
+			     struct qda_session *session)
+{
+	int ret;
+
+	ret = qda_memory_manager_assign_device(mem_mgr, session);
+	if (ret)
+		return ret;
+
+	return qda_dma_alloc(session->assigned_iommu_dev, gem_obj, gem_obj->size);
+}
+
+/**
+ * qda_memory_manager_free() - Release a buffer
+ * @gem_obj: GEM object to free
+ *
+ * The buffer remembers the context bank it was allocated from, so no
+ * memory manager is needed here.
+ */
+void qda_memory_manager_free(struct qda_gem_obj *gem_obj)
+{
+	qda_dma_free(gem_obj);
+}
+
 /**
  * qda_memory_manager_register_device() - Add a context bank to the registry
  * @mem_mgr: Memory manager of the device
diff --git a/drivers/accel/qda/qda_memory_manager.h b/drivers/accel/qda/qda_memory_manager.h
index 13354158674b..d2ca6682d58b 100644
--- a/drivers/accel/qda/qda_memory_manager.h
+++ b/drivers/accel/qda/qda_memory_manager.h
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 
 struct qda_dev;
+struct qda_gem_obj;
 struct qda_session;
 
 /**
@@ -31,6 +32,8 @@ struct qda_iommu_device {
 	struct device *dev;
 	/** @qdev: Back-pointer to the parent QDA device */
 	struct qda_dev *qdev;
+	/** @sid: Stream ID the DSP identifies this context bank by */
+	u32 sid;
 	/** @assigned_session: Session owning this device, or NULL if free */
 	struct qda_session *assigned_session;
 	/** @ref: Reference count controlling when the object is freed */
@@ -66,4 +69,9 @@ int qda_memory_manager_assign_device(struct qda_memory_manager *mem_mgr,
 				     struct qda_session *session);
 void qda_memory_manager_release_device(struct qda_iommu_device *iommu_dev);
 
+int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr,
+			     struct qda_gem_obj *gem_obj,
+			     struct qda_session *session);
+void qda_memory_manager_free(struct qda_gem_obj *gem_obj);
+
 #endif /* __QDA_MEMORY_MANAGER_H__ */
diff --git a/drivers/accel/qda/qda_soc.c b/drivers/accel/qda/qda_soc.c
index 323b620b8adb..fb316b74103d 100644
--- a/drivers/accel/qda/qda_soc.c
+++ b/drivers/accel/qda/qda_soc.c
@@ -5,11 +5,13 @@
 #include "qda_soc.h"
 
 const struct qda_soc_data kaanapali_soc_data = {
+	.sid_pos = 56,
 	.dma_addr_bits_cdsp = 34,
 	.dma_addr_bits_default = 32,
 };
 
 const struct qda_soc_data default_soc_data = {
+	.sid_pos = 32,
 	.dma_addr_bits_cdsp = 32,
 	.dma_addr_bits_default = 32,
 };
diff --git a/drivers/accel/qda/qda_soc.h b/drivers/accel/qda/qda_soc.h
index b052964f11ae..fb5b786d0928 100644
--- a/drivers/accel/qda/qda_soc.h
+++ b/drivers/accel/qda/qda_soc.h
@@ -6,6 +6,8 @@
 #ifndef __QDA_SOC_H__
 #define __QDA_SOC_H__
 
+#include <linux/bits.h>
+#include <linux/dma-mapping.h>
 #include <linux/types.h>
 
 struct qda_dev;
@@ -16,6 +18,8 @@ struct qda_dev;
  * Selected by OF match on the fastrpc node; see qda_rpmsg.c.
  */
 struct qda_soc_data {
+	/** @sid_pos: Bit position of the stream ID in DSP-visible addresses */
+	u32 sid_pos;
 	/** @dma_addr_bits_cdsp: DMA address width of CDSP context banks */
 	u32 dma_addr_bits_cdsp;
 	/** @dma_addr_bits_default: DMA address width of all other context banks */
@@ -27,4 +31,28 @@ extern const struct qda_soc_data default_soc_data;
 
 u32 qda_soc_dma_addr_bits(const struct qda_dev *qdev);
 
+/**
+ * qda_soc_sid_offset() - Stream ID bits to fold into a DSP-visible address
+ * @soc_data: SoC parameters of the device
+ * @sid: Stream ID of the context bank
+ *
+ * Return: @sid shifted to its SoC-specific position
+ */
+static inline u64 qda_soc_sid_offset(const struct qda_soc_data *soc_data, u32 sid)
+{
+	return (u64)sid << soc_data->sid_pos;
+}
+
+/**
+ * qda_soc_dma_addr() - Recover the DMA API address from a DSP-visible address
+ * @soc_data: SoC parameters of the device
+ * @iova: Address with the stream ID folded in
+ *
+ * Return: @iova with the stream ID bits cleared
+ */
+static inline dma_addr_t qda_soc_dma_addr(const struct qda_soc_data *soc_data, u64 iova)
+{
+	return iova & GENMASK_ULL(soc_data->sid_pos - 1, 0);
+}
+
 #endif /* __QDA_SOC_H__ */
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index b9dc4787bd42..8e64480cdd82 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -12,10 +12,16 @@
 extern "C" {
 #endif
 
-#define DRM_QDA_QUERY		0x00
+#define DRM_QDA_QUERY			0x00
+#define DRM_QDA_GEM_CREATE		0x01
+#define DRM_QDA_GEM_MMAP_OFFSET		0x02
 
 #define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
 					 struct drm_qda_query)
+#define DRM_IOCTL_QDA_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_CREATE, \
+					 struct drm_qda_gem_create)
+#define DRM_IOCTL_QDA_GEM_MMAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_MMAP_OFFSET, \
+					 struct drm_qda_gem_mmap_offset)
 
 /* Query type definitions for drm_qda_query */
 #define QDA_QUERY_DSP_NAME		1
@@ -34,6 +40,36 @@ struct drm_qda_query {
 	__u8 dsp_name[16];
 };
 
+/**
+ * struct drm_qda_gem_create - Buffer allocation parameters
+ * @size: Size of the buffer to allocate in bytes (input)
+ * @handle: Handle of the new buffer (output)
+ * @pad: Must be zero
+ *
+ * Allocates a buffer the DSP can access and returns a handle to it. The
+ * handle identifies the buffer in later ioctls, and the buffer is released
+ * when the last handle to it is closed.
+ */
+struct drm_qda_gem_create {
+	__u64 size;
+	__u32 handle;
+	__u32 pad;
+};
+
+/**
+ * struct drm_qda_gem_mmap_offset - Buffer mmap offset query
+ * @offset: Offset to pass to mmap() (output)
+ * @handle: Handle of the buffer (input)
+ * @pad: Must be zero
+ *
+ * Returns the offset at which a buffer can be mmap()ed on the accel node.
+ */
+struct drm_qda_gem_mmap_offset {
+	__u64 offset;
+	__u32 handle;
+	__u32 pad;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.34.1

