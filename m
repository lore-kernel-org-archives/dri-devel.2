Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FECD606E526
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ChOArK5W;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FgpTH5Sj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F59B10E4AD;
	Sun,  1 Nov 2026 22:23:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4BC510E4AD
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:22:58 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KK3gO835101
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QzJZ2BcidzT4ISYjzhL7JV9DbvORXIU2G7T+Ba5JI9Y=; b=ChOArK5WAaHq7hGi
 YakHkYVMPJOC02eg1CDoYz/Ff7HQSI0XKqkSdQtxfPHfThcpLpn+gciEWFyrfl+z
 8S8bMjztTvj4HMNlAXnWrunHOYwnMmgXwebSsc7lNmY+wVDO6DNI9pe+nWW524Oa
 InhIrzpefGJRyi0wP303EwJFhvsLTuW3HD7r8lGdeOC6Sa0snhr5ZmtJLdLlvP9d
 IdjhT8NniM1qH2wGjpSRDaqseZ/ltmmuaeJFO9sSwwuhkXRl7XeJgeUJ6JDJqMWK
 cv2+8FW6NtUtL5z88WHlY4gpUE7Okvm5doyY0YsB+YX/JTPNmBwWHZTk3rpmdM9z
 xH3RTw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9m9c4s5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:22:58 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-14373747468so2441037c88.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571777; x=1794176577;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QzJZ2BcidzT4ISYjzhL7JV9DbvORXIU2G7T+Ba5JI9Y=;
 b=FgpTH5SjnYXkukW7WWLtLZZiGbmwvKiyefD2skTtp5FjvlOxYMus8tenE1KrToSUyH
 fJfc39AGCRaVpr5SK1IWAUmNW4kfiOJSPXX3lgxIFrBqX4BXM0gG6LO7u1XMYQTIzw7/
 sHh5X2Zbti5Poxub3PdcQWkwctHuIl9YQvpZ3EaGjMO6Ki1oz4bC7/nuO6FpKHnEXYGS
 PM3RCb5GvC+QEXHRAxwZQcWQilNIkXrTXllrKmgUSy2wSRNw+UdjdwNd3aVLk/759E06
 6R3Qklyj/fRRs21z+5BdgZvZ9inqGXt4AcalGu9o7IwYlHVWjmrZtxxVbGhpOdlp3W00
 WpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571777; x=1794176577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QzJZ2BcidzT4ISYjzhL7JV9DbvORXIU2G7T+Ba5JI9Y=;
 b=H/zeRgzc8gKirr2sCYeN9qeuhT66vjfDEihHnOVUwHOQbFrgJfJrxKdC7NZSmqUJNH
 /MU1q+xX4IPocDXlRkMw4vddnUWJ1b1nNMLImzY3g8+6E6A+N2LHUSv+zoCmYpFen8BW
 su+kAwncp6NG8ypvGo6qv9UJGmEGUJAFisuppKRkq91DaS7vuJWKgDGbOIaHYNzlhdpI
 dMKd4PouP01/zaKf9Rje10oNiwoVCozUVgvwbzD8arEDq/ShdLJBqxoG+exrF/nwSh2K
 QkoiNa6OerG+KeQt/UP7xuERN9ULWtdLxESs1HHX4e53mjVr2T38mbwE4XWUYGi+xcDm
 RpKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPuIssZ/3di8w6FhYCQnZ59a8dFDeP1S7rpVGK+mdHnivEpoOSL8oTYJXWMQz/yAyAIhPWiq22LQc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIIL9Sargix6n1cYzwFSi9hHKJ7fNQeP6tDKpcHuBOlD3Aa8dpm
 CEOTUq3eGQPDK+0IG8BQVYLkP9SWH/dny+2lutDO0mkIJ7MnJYT7TSmRIiqI6bTX12ktXbDt8+y
 8RoCeznDzBduYIfq62Ige1mdICODvKLMkcZGvx9EGz8X7bVELRf4ezSxHWyPVQsdlRcVewC0=
X-Gm-Gg: AYBFou01rd6MQ4KKXdFxukTlvfCva+ZgDI6+wcX33uj1E3VsJ8tiZiEEyWMbTI5ib1g
 q+EFz9JsfO5OEJ8CV6NO5vYSHwGf7leaqlzTSrzV7jkffFEXVHLF7NesibpcfT7t91aoGB+VznY
 ZtM/irBYW/N0+uZYfd5zKqOQQgs6MFxdlYfW5HkO4E6FXzd31xbvjbEibljfZ9tELf41aRtlu8b
 Kaf7WEmO/hdaeMhmGYvBOejUIEVOxVyb4Cx06jv6m1YPAEAmUArv0YsAWRn5iLWVom4RpSa/tmA
 ZHcAHQPA+NAKCFJwVkyqGN2XOMtnUn8obTbP86ZEoxNXRFrOgrAyDEgGEQE4PB5V0tTHb1RWaFO
 1wEyUjvezQUSiUzf5w3xAFkED+fXKus6rv9K9/QFIvw4QmUzoEQG5cC1ojiVWXRpn101TdkN9Lq
 v9JOl2nQ==
X-Received: by 2002:a05:7022:1509:b0:195:9228:50a0 with SMTP id
 a92af1059eb24-1ac5d3ba9f2mr14632946c88.42.1793571776878; 
 Sun, 01 Nov 2026 14:22:56 -0800 (PST)
X-Received: by 2002:a05:7022:1509:b0:195:9228:50a0 with SMTP id
 a92af1059eb24-1ac5d3ba9f2mr14632885c88.42.1793571776189; 
 Sun, 01 Nov 2026 14:22:56 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:22:55 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:21 +0530
Subject: [PATCH v4 08/25] accel/qda: Add legacy ops base and auxiliary device
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-8-88f2f24a5f0b@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=16111;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=tJ56OicBjzqOAJbg765udfwE3azsMq9/1F/R/iYRhwQ=;
 b=H/cH8IjyD5JbjN1TocakKmA92lGHrxzWQvX6gaOYO0DXn6o6Lh/PT+au5DvBgOPuDx+oVhDse
 yOr0fIfwk+MADtVcENCazqd2VR8J78ZHiVx4vxy2ssI4jAnfPeN+JT1
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: HScQjIvdKU6lRVMY6sbfcNUHUIyaE7ta
X-Proofpoint-GUID: HScQjIvdKU6lRVMY6sbfcNUHUIyaE7ta
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX3a9f4aVARhZf
 DU6jB4sAmzA7487mV8glNY3oHmW38A65hx4kh5eJ0QPsx404B+P7wkQ+kSXUIogQaq10YLruV77
 pD6cKSUOPRuJ/eZgeGWuiGeLfwrQez7IvvxNO9G/ieZc0o0JmYoLr996OYLUeGg9aMOyom13Hxv
 HFt/Dv5sjr5NDkGqA1wEaqHilh0lTZbQDNzAn4IAShHMq+ZflSeIUN7qwchuNB+E4uULfQdZFj/
 mpqItbHVlsOV9vhU4caryRdtERvMEo3pD19Ab+r9znrOPo51LE3+jdNVSpCyZxTZTJTFn6GwVra
 L6DZr4FFHrvkEnBe1+huLDyatRXIlwP5AAxfOdAFg5Mb6GTekaVsobmQZ3JlWimBsCFA/MZOOHb
 R4l3dtcX1wuRxlgxTcNfCar9SIUtd8fMFLQ5U4JD/IGAiJFF8DflIyz2mcg86KvpgGwCHwJdN8v
 KplBmolxIarH05jZwkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfXwIDxWV8v/jPV
 CxlE88KT7si5j3nGZWP+ulhelZBmTKHPtkvavArQOTzOd8ijWvR4UeIXYDe1FAMSlY6oy/TNazA
 dTpO/JUCeFFwJw/fZLHohlBbUP46MiA=
X-Authority-Analysis: v=2.4 cv=cfVHPXDM c=1 sm=1 tr=0 ts=6ae7bbc2 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=BD9PkF2Qa3Gb5rzLt0MA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
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

The /dev/fastrpc-* interface of the driver this one replaces is to be
served by a separate compatibility module, so existing user space keeps
working. That module needs two things from here: a device per DSP domain
to bind to, and a way to use the same session and buffer handling as the
accel UAPI rather than reimplementing it.

Create an auxiliary device per domain for it to bind, rather than
keeping a private registry and a notifier callback. Domains appear as
each one's rpmsg channel probes and the module may load at any point in
that, which is exactly what the driver core already handles: it matches
devices to the driver whichever order the two arrive in, and autoloads
the module from the device's modalias. The module is optional, so
failing to create the device is not fatal to the accel interface.

The device is destroyed explicitly on rpmsg remove rather than through
devres, so that the legacy nodes are taken away before the DRM device is
unplugged and nothing can open one during teardown.

Collect the entry points the module needs into one table exported only
to it, so this driver does not depend on the module. Start with session
create/destroy and DMA-BUF allocation/import; further ops arrive with
the code that uses them.

A session the module creates has no DRM file behind it, so nothing else
holds the DRM device. Take a reference when it is created, or the device
could be freed on rpmsg remove while a legacy file is still open. For
the same reason, buffers are exported and imported as DMA-BUFs without
a GEM handle, and struct qda_session gains a ->file that is NULL for
such sessions. Code that resolves handles can only be reached from the
accel UAPI.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/Kconfig          |  1 +
 drivers/accel/qda/Makefile         |  1 +
 drivers/accel/qda/qda_drv.c        | 48 +++++++++++++++++++++--
 drivers/accel/qda/qda_drv.h        | 31 +++++++++++++--
 drivers/accel/qda/qda_legacy_ops.c | 80 ++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_legacy_ops.h | 41 +++++++++++++++++++
 drivers/accel/qda/qda_prime.c      | 33 ++++++++++++++++
 drivers/accel/qda/qda_prime.h      |  4 ++
 drivers/accel/qda/qda_rpmsg.c      |  3 ++
 9 files changed, 235 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
index e2f3f01016c6..c174f9edf2d5 100644
--- a/drivers/accel/qda/Kconfig
+++ b/drivers/accel/qda/Kconfig
@@ -8,6 +8,7 @@ config DRM_ACCEL_QDA
 	depends on DRM_ACCEL
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on RPMSG
+	select AUXILIARY_BUS
 	help
 	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
 	  This driver provides a standardized interface for offloading computational
diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
index 01c0319da900..a867a888c5f5 100644
--- a/drivers/accel/qda/Makefile
+++ b/drivers/accel/qda/Makefile
@@ -10,6 +10,7 @@ qda-y := \
 	qda_drv.o \
 	qda_gem.o \
 	qda_ioctl.o \
+	qda_legacy_ops.o \
 	qda_memory_dma.o \
 	qda_memory_manager.o \
 	qda_prime.o \
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index 5e953d1f98bf..21113deceaad 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/auxiliary_bus.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <drm/drm_accel.h>
@@ -14,7 +15,13 @@
 #include "qda_ioctl.h"
 #include "qda_prime.h"
 
-static struct qda_session *qda_session_alloc(struct qda_dev *qdev)
+/**
+ * qda_session_alloc() - Create a session on a device
+ * @qdev: Device to create the session on
+ *
+ * Return: The new session, or ERR_PTR on failure
+ */
+struct qda_session *qda_session_alloc(struct qda_dev *qdev)
 {
 	struct qda_session *session;
 
@@ -26,6 +33,7 @@ static struct qda_session *qda_session_alloc(struct qda_dev *qdev)
 
 	return session;
 }
+EXPORT_SYMBOL_FOR_MODULES(qda_session_alloc, "qda_fastrpc_shim");
 
 static int qda_open(struct drm_device *dev, struct drm_file *file)
 {
@@ -42,13 +50,18 @@ static int qda_open(struct drm_device *dev, struct drm_file *file)
 	return 0;
 }
 
-static void qda_session_free(struct qda_session *session)
+/**
+ * qda_session_free() - Release a session and whatever it still holds
+ * @session: Session to release
+ */
+void qda_session_free(struct qda_session *session)
 {
 	if (session->assigned_iommu_dev)
 		qda_memory_manager_release_device(session->assigned_iommu_dev);
 
 	kfree(session);
 }
+EXPORT_SYMBOL_FOR_MODULES(qda_session_free, "qda_fastrpc_shim");
 
 static void qda_postclose(struct drm_device *dev, struct drm_file *file)
 {
@@ -117,10 +130,37 @@ int qda_register_device(struct qda_dev *qdev)
 	int ret;
 
 	ret = drm_dev_register(&qdev->drm_dev, 0);
-	if (ret)
+	if (ret) {
 		drm_err(&qdev->drm_dev, "Failed to register DRM device: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * The legacy FastRPC interface is served by a separate module, which
+	 * needs a device per DSP domain to bind to. Put one on the auxiliary
+	 * bus and let the driver core handle discovery, ordering and module
+	 * loading; the module is optional, so failing to create it is not
+	 * fatal to the accel interface.
+	 *
+	 * The auxiliary bus names devices <modname>.<name>.<id> and requires
+	 * the name to be unique across the bus, so every DSP domain needs its
+	 * own id. The accel minor index is unique per registered device.
+	 */
+	qdev->legacy_auxdev = auxiliary_device_create(qdev->dev, KBUILD_MODNAME,
+						      QDA_LEGACY_AUXDEV_NAME, qdev,
+						      qdev->drm_dev.accel->index);
+	if (!qdev->legacy_auxdev)
+		drm_warn(&qdev->drm_dev, "Failed to create legacy FastRPC device\n");
 
-	return ret;
+	return 0;
+}
+
+void qda_unregister_device(struct qda_dev *qdev)
+{
+	if (qdev->legacy_auxdev) {
+		auxiliary_device_destroy(qdev->legacy_auxdev);
+		qdev->legacy_auxdev = NULL;
+	}
 }
 
 MODULE_AUTHOR("Qualcomm AI Infra Team");
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index 31aad9057e28..c04f19e5a91b 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -6,6 +6,7 @@
 #ifndef __QDA_DRV_H__
 #define __QDA_DRV_H__
 
+#include <linux/auxiliary_bus.h>
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -20,15 +21,29 @@
 /* Driver identification */
 #define QDA_DRIVER_NAME "qda"
 
+/*
+ * Name of the auxiliary device the legacy FastRPC module binds to, one per
+ * DSP domain. Combined with this module's name it forms the match name
+ * "qda.fastrpc", which that module lists in its id_table.
+ */
+#define QDA_LEGACY_AUXDEV_NAME "fastrpc"
+
 /**
- * struct qda_session - Per-open-file private data
+ * struct qda_session - One user of a DSP
  *
- * Allocated in qda_open() and stored in drm_file::driver_priv.
+ * Created either by the accel UAPI, one per open DRM file, or by the legacy
+ * FastRPC compatibility shim, one per open /dev/fastrpc-* file with no DRM
+ * file behind it at all. The core is keyed on this rather than on struct
+ * drm_file so that it can serve both.
  */
 struct qda_session {
 	/** @qda_dev: Back-pointer to device structure */
 	struct qda_dev *qda_dev;
-	/** @file: The drm_file this session belongs to */
+	/**
+	 * @file: The DRM file this session belongs to, or NULL for a session
+	 * the legacy shim created. Anything that resolves a buffer handle
+	 * needs this, so those paths are only reachable from the accel UAPI.
+	 */
 	struct drm_file *file;
 	/** @assigned_iommu_dev: Context bank owned by this session, or NULL */
 	struct qda_iommu_device *assigned_iommu_dev;
@@ -64,6 +79,11 @@ struct qda_dev {
 	const struct qda_soc_data *soc_data;
 	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
 	const char *dsp_name;
+	/**
+	 * @legacy_auxdev: Auxiliary device the legacy FastRPC module binds
+	 * to, or NULL if it could not be created
+	 */
+	struct auxiliary_device *legacy_auxdev;
 };
 
 /**
@@ -84,5 +104,10 @@ struct qda_dev *qda_alloc_device(struct device *dev);
 int qda_init_device(struct qda_dev *qdev, int num_cbs);
 void qda_deinit_device(struct qda_dev *qdev);
 int qda_register_device(struct qda_dev *qdev);
+void qda_unregister_device(struct qda_dev *qdev);
+
+/* Sessions, shared with the legacy shim */
+struct qda_session *qda_session_alloc(struct qda_dev *qdev);
+void qda_session_free(struct qda_session *session);
 
 #endif /* __QDA_DRV_H__ */
diff --git a/drivers/accel/qda/qda_legacy_ops.c b/drivers/accel/qda/qda_legacy_ops.c
new file mode 100644
index 000000000000..3566a10c6488
--- /dev/null
+++ b/drivers/accel/qda/qda_legacy_ops.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/dma-buf.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/fcntl.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_prime.h>
+#include "qda_drv.h"
+#include "qda_gem.h"
+#include "qda_legacy_ops.h"
+#include "qda_prime.h"
+
+/*
+ * A session the shim creates has no DRM file behind it, and so nothing
+ * holding the DRM device. Take a reference here: the device is allocated
+ * against the rpmsg device and would otherwise be freed on remove while a
+ * /dev/fastrpc-* file is still open on it.
+ */
+static struct qda_session *legacy_session_create(struct qda_dev *qdev)
+{
+	struct qda_session *session;
+
+	session = qda_session_alloc(qdev);
+	if (!IS_ERR(session))
+		drm_dev_get(&qdev->drm_dev);
+
+	return session;
+}
+
+static void legacy_session_destroy(struct qda_session *session)
+{
+	struct drm_device *drm_dev = &session->qda_dev->drm_dev;
+
+	qda_session_free(session);
+	drm_dev_put(drm_dev);
+}
+
+/*
+ * As the GEM_CREATE ioctl, but exporting a DMA-BUF rather than installing a
+ * handle: a session the shim created has no DRM file to hold handles, and the
+ * legacy interface hands buffers to user space as file descriptors anyway.
+ */
+static struct dma_buf *legacy_alloc_dmabuf(struct qda_session *session, u64 size)
+{
+	struct qda_dev *qdev = session->qda_dev;
+	struct drm_gem_object *gem_obj;
+	struct dma_buf *dmabuf;
+
+	gem_obj = qda_gem_create_object(&qdev->drm_dev, qdev->iommu_mgr, size, session);
+	if (IS_ERR(gem_obj))
+		return ERR_CAST(gem_obj);
+
+	/* O_RDWR so the fd can be mapped writable */
+	dmabuf = drm_gem_prime_export(gem_obj, O_RDWR);
+
+	/* The DMA-BUF took its own reference if the export succeeded */
+	drm_gem_object_put(gem_obj);
+
+	return dmabuf;
+}
+
+/*
+ * As the PRIME import path, without the handle: same reason as above. The
+ * caller owns the returned reference.
+ */
+static struct drm_gem_object *legacy_import_dmabuf(struct qda_session *session,
+						   struct dma_buf *dmabuf)
+{
+	return qda_prime_import_dmabuf(&session->qda_dev->drm_dev, session, dmabuf);
+}
+
+const struct qda_legacy_ops qda_legacy_ops_table = {
+	.session_create = legacy_session_create,
+	.session_destroy = legacy_session_destroy,
+	.alloc_dmabuf = legacy_alloc_dmabuf,
+	.import_dmabuf = legacy_import_dmabuf,
+};
+EXPORT_SYMBOL_FOR_MODULES(qda_legacy_ops_table, "qda_fastrpc_shim");
diff --git a/drivers/accel/qda/qda_legacy_ops.h b/drivers/accel/qda/qda_legacy_ops.h
new file mode 100644
index 000000000000..76b80dc87a4b
--- /dev/null
+++ b/drivers/accel/qda/qda_legacy_ops.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_LEGACY_OPS_H__
+#define __QDA_LEGACY_OPS_H__
+
+#include <linux/types.h>
+
+struct dma_buf;
+struct drm_gem_object;
+struct qda_dev;
+struct qda_session;
+
+/**
+ * struct qda_legacy_ops - What the legacy FastRPC shim may call
+ *
+ * The shim serves the /dev/fastrpc-* interface of the driver this one
+ * replaces, on top of the same session and buffer handling the accel UAPI
+ * uses. It is a separate module, so the entry points it needs are collected
+ * here and exported as one table: that way the driver does not depend on the
+ * shim, and neither module has to reimplement what the other does.
+ *
+ * Ops are added as the shim grows to need them.
+ */
+struct qda_legacy_ops {
+	/** @session_create: Open a session on @qdev */
+	struct qda_session *(*session_create)(struct qda_dev *qdev);
+	/** @session_destroy: Close a session */
+	void (*session_destroy)(struct qda_session *session);
+	/** @alloc_dmabuf: Allocate a buffer and export it as a DMA-BUF */
+	struct dma_buf *(*alloc_dmabuf)(struct qda_session *session, u64 size);
+	/** @import_dmabuf: Map a DMA-BUF into a session's context bank */
+	struct drm_gem_object *(*import_dmabuf)(struct qda_session *session,
+						struct dma_buf *dmabuf);
+};
+
+extern const struct qda_legacy_ops qda_legacy_ops_table;
+
+#endif /* __QDA_LEGACY_OPS_H__ */
diff --git a/drivers/accel/qda/qda_prime.c b/drivers/accel/qda/qda_prime.c
index 7a709e3000d8..128d4ab2cf64 100644
--- a/drivers/accel/qda/qda_prime.c
+++ b/drivers/accel/qda/qda_prime.c
@@ -181,4 +181,37 @@ int qda_prime_fd_to_handle(struct drm_device *drm_dev, struct drm_file *file_pri
 	return ret;
 }
 
+/**
+ * qda_prime_import_dmabuf() - Import a DMA-BUF without installing a handle
+ * @drm_dev: DRM device
+ * @session: Session to import into
+ * @dma_buf: Buffer to import
+ *
+ * As qda_prime_fd_to_handle(), but stopping at the GEM object: a session the
+ * legacy shim created has no DRM file to install a handle in. The caller owns
+ * the returned reference.
+ *
+ * Return: The new GEM object on success, ERR_PTR on failure
+ */
+struct drm_gem_object *qda_prime_import_dmabuf(struct drm_device *drm_dev,
+					       struct qda_session *session,
+					       struct dma_buf *dma_buf)
+{
+	struct qda_dev *qdev = qda_dev_from_drm(drm_dev);
+	struct drm_gem_object *gem_obj;
+	int ret;
+
+	ret = qda_memory_manager_assign_device(qdev->iommu_mgr, session);
+	if (ret)
+		return ERR_PTR(ret);
+
+	guard(mutex)(&qdev->import_lock);
+
+	qdev->importing_session = session;
+	gem_obj = qda_gem_prime_import(drm_dev, dma_buf);
+	qdev->importing_session = NULL;
+
+	return gem_obj;
+}
+
 MODULE_IMPORT_NS("DMA_BUF");
diff --git a/drivers/accel/qda/qda_prime.h b/drivers/accel/qda/qda_prime.h
index eb2d8cbc8cd3..c5e2f7ffa882 100644
--- a/drivers/accel/qda/qda_prime.h
+++ b/drivers/accel/qda/qda_prime.h
@@ -12,6 +12,7 @@
 
 struct dma_buf;
 struct dma_buf_attachment;
+struct qda_session;
 struct sg_table;
 
 struct drm_gem_object *qda_gem_prime_import_sg_table(struct drm_device *drm_dev,
@@ -21,5 +22,8 @@ struct drm_gem_object *qda_gem_prime_import(struct drm_device *drm_dev,
 					    struct dma_buf *dma_buf);
 int qda_prime_fd_to_handle(struct drm_device *drm_dev, struct drm_file *file_priv,
 			   int prime_fd, u32 *handle);
+struct drm_gem_object *qda_prime_import_dmabuf(struct drm_device *drm_dev,
+					       struct qda_session *session,
+					       struct dma_buf *dma_buf);
 
 #endif /* __QDA_PRIME_H__ */
diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
index 2c9d79937b10..14034e250555 100644
--- a/drivers/accel/qda/qda_rpmsg.c
+++ b/drivers/accel/qda/qda_rpmsg.c
@@ -50,6 +50,9 @@ static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct qda_dev *qdev = dev_get_drvdata(&rpdev->dev);
 
+	/* Take the legacy nodes away first, so nothing new opens during teardown */
+	qda_unregister_device(qdev);
+
 	/*
 	 * Unplug before clearing @rpdev: once there are ioctls that reach the
 	 * DSP, this is what stops a new one from starting and waits for the

-- 
2.34.1

