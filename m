Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654E6C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C77FC10E62E;
	Mon, 17 Aug 2026 04:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oMjmn0fo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wq9CIeRU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC90110E62E
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLDQ4k4059911
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZKM+NHQSKUoH1D1TCU7lY/FLmcqsBBdoLfIBHv/qw2c=; b=oMjmn0fowl74M5yb
 ZJKjiJ0YUk2BSHptzmOBpVa7u+8SkltvKGuTBZznLRo+J+XV0YJFBB4VuHFhpO9l
 /TaDsSsKOtQD9sgka52g36QJeqC5cgReCbwR2gIL9K2DvOAQHc61IVi/2v+lSMsN
 Jt90WfnHGc4YThjkdBycPPOGJtsFE05B5+MuHRLmVWLKFlCQrNcSjJZTDa8/7khw
 vzMsmqcrIoVcExgwe8yZNx5nJ++T7HotMEXAyyVZhThFf1pBF/WGF53Qb6L3Sb6i
 5cm9fswu3qBM+J45F0SRmIXBsVTYweq/emcAOui/FSb+Ofjru6H1JQhBZn/8qYNn
 NIRrHg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2hd7w20b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84fa3b14ed2so2584284b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 21:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786942153; x=1787546953;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZKM+NHQSKUoH1D1TCU7lY/FLmcqsBBdoLfIBHv/qw2c=;
 b=Wq9CIeRUiQeXc/C1uo9JNUSFYTRf4KqVwwZtPwzNbRAusgkalE79lr6dyTbR9LETFq
 CqAYaXACu4K7W1rAa9yxQsQxtwRPgjWdDzODC6ThiSjnMEHL1bbN9GLJIWz8n7eZtS8I
 WY6nIUboKuBZlqMZabMYTQI/Lj4pOOIr+dskeqgAlS9FLdLieuHLOVZ/g+aeowavqu4Z
 0L0lNkjZG7t6j9hzWFsM0XwuDzrgggvdj/gXI7ZgNAVTjdieKOgY5XhSbnl2aJ7C/+NF
 yx9qfXS81/Q4zKV2TxDvnLr6tS3dRWcfEC+dVUoihOHca0dRx+QCw/cXmYAyxBCysT/4
 WUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786942153; x=1787546953;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZKM+NHQSKUoH1D1TCU7lY/FLmcqsBBdoLfIBHv/qw2c=;
 b=mgddweBiumTLbufHhYYEwtelUvYBOcJtutUTM8b8trgvctiBhKU03eVFn2ZvT/+mo2
 jFLVL9y90p+gMssWrBpM3L3YIHjSVL5GMjHTe+L6ghIZ4Odp1JAsbmFwCMvKWSQNhC8M
 fsJtX1dGfdzwCLfzzO0D/I41z6vhYYikW3r1Q7514VrKJDqAn0NO02QwwgdmkG4WpxU5
 mXn7zVApJfn5yCFUZAHMsoFNOBaxiz3yRzb1dfUT4Q0ibeeiUPbqCff5sTQbXPiOvY7b
 4IWdfMgMMCjzZU5UexefQSUwRJu9eXmo9UceVqegw3ztna3QMm/e5+ld6pEmVHS31U0H
 4g3g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqm74Cd7YFyJd7JHA0++6TJhJXlVbEm50/GCWJdWdNj/5QHJsrF86U46jCXlTUI3KmEYpzqHzxEIg4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBwp18cmEMQWfiNwMHGyNn4MBXjyJx7PhpFO7eU8w/BVvSVq/x
 0Eh5td/YDgVdkttUSyM+IheNumpTFKh21IY8A9ykl51zt+z+SzyGDCh6of0dOVT2uSOgwbAxbFF
 t3VvobyxIYfrvRJDkwnMsAHpknsle9CJ8EPHdSF9IpD56rZJblW4QJJjO4/nvfjY8SUJAAZE=
X-Gm-Gg: AR+sD12QtjppE8lbVFE4lyj8lyZnKJRdec5sYjLD6fkH7aatChKLmQY+YUGNg3jSxd6
 TnmSeMIKqJkH6aQHVwkDUAhDQwElLHHfo+JE+tvNdGkVzJA/acPpVkWQ/1LKppWtOYNR7D3WL22
 wc7sFz/0Hq/VjtgBiKPBonYZk35aRCBFunOAWFMDarNd1d0NFbKmGJNMCKNmJqkK52czunhBLve
 yIAJmMOkU5yjT82ncOW4gi1FKoiHkYod4PUKReTiSurNgF/8dN7O3x2dLABC2zWFChDLy5rwjfM
 hviLIdlR4FS1NnMuQ/Q27qISQZ5INMxUqxXlodevQq7WZljsbLuVnhOG8d9KzXX/WMtbNnLfb4k
 /y1uHIL/NariFCztSu6dDSvGWjtPwtd2l
X-Received: by 2002:a05:6a00:4396:b0:845:4126:222b with SMTP id
 d2e1a72fcca58-84fde25d9ccmr22328228b3a.28.1786942153370; 
 Sun, 16 Aug 2026 21:49:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:4396:b0:845:4126:222b with SMTP id
 d2e1a72fcca58-84fde25d9ccmr22328162b3a.28.1786942152849; 
 Sun, 16 Aug 2026 21:49:12 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d046638sm2149250b3a.27.2026.08.16.21.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 21:49:12 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 10:17:45 +0530
Subject: [PATCH v2 10/15] accel/qda: Add GEM_CREATE and GEM_MMAP_OFFSET IOCTLs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-qda-v2-v2-10-69a02e9090d4@oss.qualcomm.com>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
In-Reply-To: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786942058; l=6314;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=KEBIosjw/s1lnBO4y/mJV8X8bDe3iDhKZiDM+pg6MiM=;
 b=jGowoRNLuIyio1nIsF99A5b2Ay3Koxj/Exi5tF704xes4levIn1jfrSZ7D8eehElavHpXCS1W
 z0sWqFB+784AnVoSsoDt1bxTVCrrdNpkz+pSfgJ7Gp92V8lDvWyuYbX
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX/g+dvcq5pYHJ
 iaB37Qj7B6N+ZGs1FOzba8YihIhh33ajmFq05+VG6h2TzGb922Dk4n5MMLuDwTBHZY39EzHKi+R
 6UrfPw4FjhbMBWQh9rIdkzmC08Pf8VQ4VmkmL9s/Ku+vy9zjHDAySXBrj8EkyezVM1T2tlICIDc
 V5s1Bm7+san7pUz59wf7Bw+t8NjYrMG37nLHiytKVgUdbP9M3QAzzMjBJZhXEj4Z/ybhsMRf5CY
 mPQYWx7mtTu9+PwGqFGEIGRaaVytOkgJbCkZX2+sDd0zlLe34Io5LjEkQOEdo3wWn0UXZEzMCYx
 TIU9nUR1u5PpjXWHfpKhNOt48TVx2P2CrAqFJsZqH4fklfzJ6ZL8IMog9yU7p+XTn6dKh6JY/se
 oZ4IIKlK3kX5OiYvdKgZ9SiR+SNkM4mvNnbwXM6Tx3HSt6Y7myShi+iwAdv2S6Hzg57mNxxNJdP
 Z8gAU58LiY4uIBNW0aA==
X-Proofpoint-GUID: P5PCe6yu4MS5EjglZzMU0MMrPHZfmfCY
X-Authority-Analysis: v=2.4 cv=Ja2Ma0KV c=1 sm=1 tr=0 ts=6a8292ca cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=lxwWJKsBKUC9JqiFEVgA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: P5PCe6yu4MS5EjglZzMU0MMrPHZfmfCY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX5p6yV8aTFX18
 5RosA8hjuGf7kZpSSzhg5QKSNDFxafHjpVxmCUfkADkWLBgiA0tb3bmqyMqOgyy2Mi5xZabOZo2
 RZeVbnTsgd3DYQYSwvtP/z0y2Rg+pAQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170033
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

Expose two new DRM IOCTLs that allow user-space to allocate DMA-backed
GEM buffer objects and retrieve their mmap offsets.

DRM_IOCTL_QDA_GEM_CREATE (drm_qda_gem_create)
  Allocates a DMA-coherent GEM buffer of the requested size. The
  memory manager assigns an IOMMU context bank to the calling process
  on first use and performs the DMA allocation against that bank.
  Returns a GEM handle that identifies the buffer for subsequent
  operations.

DRM_IOCTL_QDA_GEM_MMAP_OFFSET (drm_qda_gem_mmap_offset)
  Returns the mmap offset for an existing GEM handle. The offset can
  be passed directly to mmap() to map the buffer into user-space.
  Imported DMA-BUF objects are rejected by drm_gem_dumb_map_offset().

DRIVER_GEM is added to driver_features now that GEM IOCTLs are
present.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/qda_drv.c   |  4 +++-
 drivers/accel/qda/qda_ioctl.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_ioctl.h |  2 ++
 include/uapi/drm/qda_accel.h  | 36 +++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index 2b14dab95507..d22c2c66ffc4 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -43,10 +43,12 @@ DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
 
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
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index c1d6c9bc0465..f65325c80a12 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -3,6 +3,7 @@
 #include <drm/drm_ioctl.h>
 #include <drm/qda_accel.h>
 #include "qda_drv.h"
+#include "qda_gem.h"
 #include "qda_ioctl.h"
 
 /**
@@ -33,3 +34,52 @@ int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_pr
 
 	return 0;
 }
+
+/**
+ * qda_ioctl_gem_create() - Create a GEM buffer object
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_gem_create)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_gem_create *args = data;
+	struct drm_gem_object *gem_obj;
+	struct qda_dev *qdev;
+
+	if (args->pad)
+		return -EINVAL;
+
+	qdev = qda_dev_from_drm(dev);
+	if (!qdev->iommu_mgr)
+		return -ENODEV;
+
+	gem_obj = qda_gem_create_object(dev, qdev->iommu_mgr, args->size, file_priv);
+	if (IS_ERR(gem_obj))
+		return PTR_ERR(gem_obj);
+
+	return qda_gem_create_handle(file_priv, gem_obj, &args->handle);
+}
+
+/**
+ * qda_ioctl_gem_mmap_offset() - Get the mmap offset for a GEM object
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_gem_mmap_offset)
+ * @file_priv: DRM file private data
+ *
+ * Uses drm_gem_dumb_map_offset() which rejects imported dma-buf objects
+ * (mmap of imported objects is not allowed).
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
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index fe695347762c..1d699f00e7be 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -19,6 +19,8 @@ extern "C" {
  * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
  */
 #define DRM_QDA_QUERY		0x00
+#define DRM_QDA_GEM_CREATE		0x01
+#define DRM_QDA_GEM_MMAP_OFFSET	0x02
 
 /*
  * QDA IOCTL definitions
@@ -29,6 +31,10 @@ extern "C" {
  */
 #define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
 					 struct drm_qda_query)
+#define DRM_IOCTL_QDA_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_CREATE, \
+					  struct drm_qda_gem_create)
+#define DRM_IOCTL_QDA_GEM_MMAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_MMAP_OFFSET, \
+					  struct drm_qda_gem_mmap_offset)
 
 /* Query type definitions for drm_qda_query */
 #define QDA_QUERY_DSP_NAME	1
@@ -48,6 +54,36 @@ struct drm_qda_query {
 	__u8 dsp_name[16];
 };
 
+/**
+ * struct drm_qda_gem_create - GEM buffer object creation parameters
+ * @size: Size of the GEM object to create in bytes (input)
+ * @handle: Allocated GEM handle (output)
+ *
+ * This structure is used with DRM_IOCTL_QDA_GEM_CREATE to allocate
+ * a new GEM buffer object.
+ */
+struct drm_qda_gem_create {
+	__u64 size;
+	__u32 handle;
+	__u32 pad;
+};
+
+/**
+ * struct drm_qda_gem_mmap_offset - GEM object mmap offset query
+ * @offset: mmap offset for the GEM object (output)
+ * @handle: GEM handle (input)
+ * @pad: Padding for 64-bit alignment
+ *
+ * This structure is used with DRM_IOCTL_QDA_GEM_MMAP_OFFSET to retrieve
+ * the mmap offset that can be used with mmap() to map the GEM object into
+ * user space.
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

