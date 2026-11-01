Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C0960701E7
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JUdj004o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dUscj1Z+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7033B10E487;
	Sun,  1 Nov 2026 22:22:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36BA610E487
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:22:26 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KJpSv1769961
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jpC/IYqlEQIVEU6VUo3DLK+z4bU8wLdRauEXeVFTtZk=; b=JUdj004ofQSpv/lc
 p4kMNW23ZOBcmj1c+iyNBR6pVE5gsNK4/R3Qimsqn4Fta3uc661bROTDev4UMclU
 KKOnhRF2ccirsg8XbClfhVpo28DIrtsf8x9DDPwEB1wWbSUSys2LmduTVBry6Kus
 L0hihUVYeFvvYusOOgCtTuxGD+LIsyFc5LLxkjdgrBCYAmyFjy9G6o7mC2c4jANT
 E2aEmYQY8BiusgEHf2AMICO/lJergTyqZ4TiFERw9svMr81ZWHXu/WGJk+0mr8a9
 qwqUAGKO6c54XrNjtOPAJrVPUqThD2FcTfCuH8JWZzNKRb0AALIRYjLVj/P/lwA8
 z0bTZg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8j2vbc1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:22:25 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-147be78cd56so5121238c88.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571745; x=1794176545;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jpC/IYqlEQIVEU6VUo3DLK+z4bU8wLdRauEXeVFTtZk=;
 b=dUscj1Z+Qe55/6cit+iNMO5F965V0q4mgxyjiP5+tMtcnX2eapgHG3yFMiy6VQ/f2i
 K9uDr4/KZDbo1ccd0lnJm3sTvJSrnv5ZdkWxWrlDN31Q6s2TCHbwfb9UHOHSnAdLWXvY
 rgOGfoscErCme7Uk4y6IfjWfLTFl84jEwRLee1i3Gp8B7spz/LCJzTipXH+9G7z0KfIo
 yhRrdWoaFkOSmjl3YwZTXSfId8CBbXuFM1bQI0g5RuC8PuzfBjt98KiovYB3tnGvazRU
 9dUcHhtVQxtVyK+qOxzlSo0NQCS3motXBGCU8NbY/R2KLGwJS2ZUdsjKpp/tbpU1euLr
 n12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571745; x=1794176545;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jpC/IYqlEQIVEU6VUo3DLK+z4bU8wLdRauEXeVFTtZk=;
 b=giXI7E5/gmJQd8xMYIymPq2sWuXyR1a50K7jN4CvcOfAEvUD35iOMn833AsyaYFw0u
 s1i9WtArEsyMs5PFYspmrK3c/7SkVzjDj+AIGEIzn1FdCl258wb1HoFW51+2dESuZzQh
 ou9gUWPoLF+2Ms0gBNxZ/UBq1B4Yv4IembDsUc+EKBWAUjBT70kIKXVp/bUNDC2wCCFt
 d8HSHwzqOVD5BVHnxoOaAgabTbLjL+0miWZexVyboP5s6C2f+tUR5fBLYPbp4EmGko/r
 8jmWZX2SX8m6YuEuWWb5g+kSu+jJyAsaMJre2pqI4EQLahZuOFo63zWD+7MKi+hvJaeK
 zQhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2hHL3IoxJMeKsgY8wE6peOfTxMrlk71dyBfGy0+cUzHQeO3Rmc1opAWP9mUyRGv3iFSJOYKE1iRU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK0vgrEfC9NddG6ZjNIEky82NJQSgr2MrTPfR3H524LpiZc1hbr
 So/sDJx3Eo6ZoUJ729AU5+MOAXPR6/mmCuJMW6CBHhXSIwfNJcnE86Xf3AI00RtEuDuQre0kmi4
 WrO52XuODfbhm9g5JIsZW0IPhIcOXYfBuK3zWi1AaOZFWPNQUy1JQlSgSWQVg9EuTFl1Eeok=
X-Gm-Gg: AYBFou0AzEqmctOx1/lAqh1Zg85XslrDGqwE/DWrpqHqmRt19iMdyQYLv1HHdHw2RHs
 xEzBVkNp+QLMWcjETNZLhZGf4RL0+hIkRxSpoutYEa2bZ/Dxa1bKPkdPfbRzMyiAQyIsj140uKl
 5/XkpxE1LGlFL8+vu0Zxn+JQO4YIGhIu2tOlQCtO7PWaN7fAN2LB7wgUZrGZFOUxC1MLE02/Sd/
 zFv4rIFdp4bslBf79IsrXLL2vwT7l7d7U+WpP6v9Kcxra+/KY3Tjxe3dA/1NKGN9XpZt+NgeUtV
 tA2LWfJjvM1eBCK5BJgyoU7mWKPXTNukhC3m4kRSSUodFzhRcxCBkhlvsIV5rtNaj1jddfNkxZQ
 fnZqTy+lxJAtdwo7DuydY1lkoApe3Vc2AeUA5M3MkwotRBSXBcvZsKorvkS5Om7Us3VXc8Uu6Nd
 cRlfO23A==
X-Received: by 2002:a05:7022:e27:b0:14d:cb67:afc4 with SMTP id
 a92af1059eb24-1ac5e8e1e4bmr16809703c88.41.1793571744453; 
 Sun, 01 Nov 2026 14:22:24 -0800 (PST)
X-Received: by 2002:a05:7022:e27:b0:14d:cb67:afc4 with SMTP id
 a92af1059eb24-1ac5e8e1e4bmr16809589c88.41.1793571743786; 
 Sun, 01 Nov 2026 14:22:23 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:22:23 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:18 +0530
Subject: [PATCH v4 05/25] accel/qda: Add UAPI header and DSP query ioctl
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-5-88f2f24a5f0b@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=5862;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=FEMAhmI+29jlqJnKsKpFRXXV2+SDwS5N0khfFCto3EI=;
 b=CiORchHpsSEp682EW8iJpuxw2yAvzjmIGDci/Gq73YkHBlvgwyHOKFGV0OkjrhatzXjEGGkMP
 BFFyVOEixgXAvgZsUUTISTQcfbeJZPi4nnOJTcHfRscrXyEujVm2DxB
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-GUID: fqQ5t83VSWXyTHNu5cgD_ZDfw1mKnZSk
X-Proofpoint-ORIG-GUID: fqQ5t83VSWXyTHNu5cgD_ZDfw1mKnZSk
X-Authority-Analysis: v=2.4 cv=S5RMU4sP c=1 sm=1 tr=0 ts=6ae7bba1 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=SLfWgZofmqkV2j7029kA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX9DO49jBsI/34
 8HUDot4hNiMMV4oPxscULBqmRyXN6OzbHda7yozIFvagw+XLTve0ImVf1/eozPhQDXdobLfFDus
 QPl4rAuBh//E6CgqxxSAE85gXlZIIoA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfXxrA3eJS57H+r
 4U4cM3Cy8zrZUK1BdXnf/z816oAf7AWIiRDHFOlsvkXMvaOpSLNnNM1CaXC9g/O8tPhYdZEjftu
 2H/p1l+qhUOaJGCcGX/nJCmbcXNvLfi9v5aFg4nh1ZQxE1oC21NgzcId8GPmw3kQDMsaGAsqnLK
 DvpaKw7DXPDcZxTV7+32ZttWqnkHmQYpRQQWFErdfYfZ1U06ACtz3iPBOsLsJ+MJEuDsjTdo7LK
 dGkAKx6OOB46bTlOuErqtQmh7mtInFoxAoYcu/5UlG0O+9pnRN4LZKn2HqXFDwUraew9nrMIqil
 b0PmfF1iOor0Ie/4Ai34aRJpmAhIUPHAQvsBvW8bPnfATw9xpoSwwa9E6JnNeIM3tvelM3GsgMg
 Cdo9FdERN/tHkdVOyWfMRYvFRjljPTD5TfTSVFavxTJa6yGYNgTZfyY10MxLK2Ykc72Iz8BWFgv
 ceEyAwrICmWYpGH5vfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
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

A system has one accel node per DSP domain, and which node is which is
not something user space can tell from the node name: /dev/accel/accel0
may be the CDSP on one platform and the ADSP on another. An application
that wants a particular DSP has to open the nodes and ask.

Add DRM_IOCTL_QDA_QUERY, which returns the name of the DSP behind a
given node, taken from the "label" property of its device tree node.
The ioctl takes a query_type selector so that later additions (DSP
capabilities, attributes) do not each need an ioctl of their own, and
is DRM_IOWR rather than DRM_IOR so that the selector reaches the
kernel.

Unknown query types are rejected with -EINVAL rather than returning
zeroes, so that user space can tell an unsupported query on an old
kernel apart from a query that legitimately returned nothing.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 MAINTAINERS                   |  1 +
 drivers/accel/qda/Makefile    |  1 +
 drivers/accel/qda/qda_drv.c   |  8 ++++++++
 drivers/accel/qda/qda_ioctl.c | 30 ++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_ioctl.h | 13 +++++++++++++
 include/uapi/drm/qda_accel.h  | 41 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 94 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77687a35ac13..1316e63c1151 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22982,6 +22982,7 @@ S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/accel/qda/
 F:	drivers/accel/qda/
+F:	include/uapi/drm/qda_accel.h
 
 QUALCOMM EMAC GIGABIT ETHERNET DRIVER
 M:	Timur Tabi <timur@kernel.org>
diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
index 1ca991e198ed..402e7dbebbf0 100644
--- a/drivers/accel/qda/Makefile
+++ b/drivers/accel/qda/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
 qda-y := \
 	qda_cb.o \
 	qda_drv.o \
+	qda_ioctl.o \
 	qda_memory_manager.o \
 	qda_rpmsg.o \
 	qda_soc.o
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index a99e23933f6b..e722135238f3 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -8,8 +8,10 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
 #include <drm/drm_print.h>
+#include <drm/qda_accel.h>
 
 #include "qda_drv.h"
+#include "qda_ioctl.h"
 
 static struct qda_session *qda_session_alloc(struct qda_dev *qdev)
 {
@@ -54,11 +56,17 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
 
 DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
 
+static const struct drm_ioctl_desc qda_ioctls[] = {
+	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
+};
+
 static const struct drm_driver qda_drm_driver = {
 	.driver_features = DRIVER_COMPUTE_ACCEL,
 	.fops = &qda_accel_fops,
 	.open = qda_open,
 	.postclose = qda_postclose,
+	.ioctls = qda_ioctls,
+	.num_ioctls = ARRAY_SIZE(qda_ioctls),
 	.name = QDA_DRIVER_NAME,
 	.desc = "Qualcomm DSP Accelerator Driver",
 };
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
new file mode 100644
index 000000000000..380c2526d9d2
--- /dev/null
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/string.h>
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+#include <drm/qda_accel.h>
+#include "qda_drv.h"
+#include "qda_ioctl.h"
+
+/**
+ * qda_ioctl_query() - Query a property of the DSP
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_query)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct qda_dev *qdev = qda_dev_from_drm(dev);
+	struct drm_qda_query *args = data;
+
+	switch (args->query_type) {
+	case QDA_QUERY_DSP_NAME:
+		strscpy(args->dsp_name, qdev->dsp_name, sizeof(args->dsp_name));
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
new file mode 100644
index 000000000000..b8fd536a111f
--- /dev/null
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_IOCTL_H__
+#define __QDA_IOCTL_H__
+
+#include "qda_drv.h"
+
+int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
+
+#endif /* __QDA_IOCTL_H__ */
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
new file mode 100644
index 000000000000..b9dc4787bd42
--- /dev/null
+++ b/include/uapi/drm/qda_accel.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_ACCEL_H__
+#define __QDA_ACCEL_H__
+
+#include "drm.h"
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#define DRM_QDA_QUERY		0x00
+
+#define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
+					 struct drm_qda_query)
+
+/* Query type definitions for drm_qda_query */
+#define QDA_QUERY_DSP_NAME		1
+
+/**
+ * struct drm_qda_query - Device information query structure
+ * @query_type: Type of query (input)
+ * @dsp_name: Null-terminated name of the DSP (returned when query_type is
+ *            QDA_QUERY_DSP_NAME)
+ *
+ * This structure is used with DRM_IOCTL_QDA_QUERY to query device attributes
+ * based on @query_type.
+ */
+struct drm_qda_query {
+	__u32 query_type;
+	__u8 dsp_name[16];
+};
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* __QDA_ACCEL_H__ */

-- 
2.34.1

