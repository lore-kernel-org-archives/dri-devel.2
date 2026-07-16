Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62301C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C239E10F2E7;
	Thu, 16 Jul 2026 12:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TNdTbLyI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BSjnXfXn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325F910F2E2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:10 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBiqP32355571
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nAzeN59J0azB7+VxlBwnfSfYuZUkQq63rtSgGfRJFeY=; b=TNdTbLyIq3C8GHoH
 CMM24CYvyIJ0onFcZGEHOXDBs86sHKm9oQp6ToM+qOwxNYpR8sa2LidfgHfEGNUX
 79c2zsCtt8YmREygJCHEQ+wqFoQe0SzBZQS0t+uUqVRqWj7aT+nsFAzxVo0GXDt+
 aZiBzXhI1/E+0Cptt0hWRdwDDU0qMZ9owG2Q2mPbhjQdo+J+R6EpXN7jv/Op9lv9
 bZpeAmLkdst/CPN9aGkm7GzdrmVMCDHKmdB+gLeh4ELFhCt8tzfL+YtdRGDHl5xZ
 8bUWeZQfBCdToOmZiD9KfJMH/sS1KvHOdr4EO6DIVi8+C6+j5X/NPhqDcUiAHFEa
 WilE1Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fed064br1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-517e054fe07so137059091cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 05:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205128; x=1784809928;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nAzeN59J0azB7+VxlBwnfSfYuZUkQq63rtSgGfRJFeY=;
 b=BSjnXfXnu7p+mBZmB0wIE7wQ+Hdm9bZw9JDd5gAPXiVUaXJrp0OkmJUEkNvKL9yyeW
 3JshpN/onFlhNU0cjDn1h/lxwBOXo5CCdkjwy7cXy5ZLPtlAzxAPwr0KdHrr8G1/oHy8
 7J48NWs6bb6NooRxsfpvlvqCzmPtsQTFdgiicQ2Ydw+nBDSsLOGYL+QP+i50JP5Fdh8e
 MHHOt3lb1/S8qZzrSu34TDmhfNy4jjqQedU5/GwDNafIglpVmjqP4ZKuBGeqRWL2c8Na
 F1aN1qSLtJmN0KpsmTUlRN4C77gubqNP7Dr9jaGFEF+1uZ9HFfJTbCTcyS5YPP2JtO9k
 ZfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205128; x=1784809928;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nAzeN59J0azB7+VxlBwnfSfYuZUkQq63rtSgGfRJFeY=;
 b=F/01rf0B2cVv9wcGVCjO3acHakiE7y5H+JyDIFMiUbWwG5mZmu0IIYjR+BZqUj0ZCe
 mfqeUGaKyDCLc5uF3c8HDscOewL5p8mgPVhdlE5MVxy4hwSCZ71afe0DIDpYQdvEErpn
 7tH/8bWTwZ87buMjT3BnBxVZOMc//LTmxI/MNb42Kehz2Q2I/VqtUVuPOXwLLDA6hImI
 WpPbTmu0DtoV/hKnRu3NI80RSo6g+Co6egHAp7iEj043AsFGx7WhM2BslkfYE0s3Te0P
 s7gSzlcNEbibI5oh2Qh0T4jP2ApZvsnonNCiMeU6iMXiY4GKWkFdGN+nlfUpiUe3FGvk
 saUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+XWooJyY/bhaZy6z9Gp0vTR/Th3KBz5Zn8WMXZqgVyQE7dpaT8s4+HkGIg9ytLECdqSfzcKRbYvM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3Zl0NSbaBDFSwM76+r1gG3LOpIZdOySebp87v7UIHIlfgsvOO
 xq6bdGfAJ24PEGEbfvGkUiVZBtr2N7qOYXD2iZV9ySjc36B8D72vxEpR/1Cu/jMSedI3aXUOv0k
 K8j+wAt6v/jZra+c3+yx1008yYgbqJGtuk+lUiMn03+DjEocd933R7Fpc0QT9ttRK8YHiJF8=
X-Gm-Gg: AfdE7cnI8LHM3mMfO2j5pmnwYDWSSODffRw4YmFLnPb4gKR6idBpsd/vWZieueh76Q7
 1pGqo5U2NMbS5uzdbnW0+cTC+1+FE2fwu5F5LgzUD9EVrjdJvPm67PuGzb4thDqhVaQ6F3u1Wgw
 3rlNpJg+p6viuIDZgzEC9/8zdHLaFKVVCscFKn9oH+QLXwO6cS0IEW69Bd9D3erBJfH4xW/21ot
 24T8XUPLLw/ZCw7avyGyYYtIZVVGC4PH13M2cJS+QWUjXmjD2Ya6bWJQphlY57YPR7l7oZLXPG4
 eMoJ+k4qQLHNnBBDV85yT57oXo1qDpiAL99aW9m1iQBcSwdDksZreyuP1jeapidInHSr6eoocM1
 I5Oba8cfdqn6QWulov5xCfiuVVyA=
X-Received: by 2002:a05:622a:a15:b0:51c:7b11:419d with SMTP id
 d75a77b69052e-51e4f12d97cmr73023221cf.74.1784205128415; 
 Thu, 16 Jul 2026 05:32:08 -0700 (PDT)
X-Received: by 2002:a05:622a:a15:b0:51c:7b11:419d with SMTP id
 d75a77b69052e-51e4f12d97cmr73022841cf.74.1784205127901; 
 Thu, 16 Jul 2026 05:32:07 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:76f:d108:485:5b34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c7c96sm23766635f8f.33.2026.07.16.05.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:32:06 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 14:31:40 +0200
Subject: [PATCH v8 5/5] driver core: platform: tests: add test cases for
 correct swnode removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-swnode-remove-on-dev-unreg-v8-5-5c2b8cc38c28@oss.qualcomm.com>
References: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
In-Reply-To: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
To: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: brgl@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6684;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=oLwa7pZUr6doS0kE5wIzyXtRk9PkNeS7cvA7R3LQYdg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqWM86rjx7q8yriQSpjvNMvC+uK23KVDXnrN70X
 cPCoyYSQM6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaljPOgAKCRAFnS7L/zaE
 w+FlD/oCqR5yg8/HruSl6XV9Qef9k8PuUl3pCHhLlXI07rbwdFQ4r4DuXSoLJD9zG7k3+gK6fXH
 I5bgglPrpf0qPsrPVAB66suKg1ixVCgnIY/eXMCDP7sLqbgYmwHfg6ODp0mSvq63BKb0LllZmUD
 tVflkqY1g6iE4zfyeGRmDgxVlzR2q700GyVziNMgQ77nbpdOfhLxzBEsK2SBEUgavZKW4WWMK1z
 nXUODe7S2WhvCsBOXoPPAsMQ5665zHGAlR5Cdu7OMNh4Jv/tEbxzXbXtK5JCDdeFA6F3SF8zL8c
 I0IFzaNs0Pr9yGiFr5y1cWsWUdskLIYbxBVYeWifMFmIQIBBmQSMiHurxjJbbY5l3uk1HYqrk8n
 XVr05SZI/QAwwRBN/SUKKDyD5Px0ZE2py4Qjwpg6u5zKCyRw31a9diFe02yNqfxz8TpCjTtYEQN
 HHAcSA1uN2exfHsAD1lRh3/o5LBOgKVfKLkjM/A9CPkLY9KbhF9C7pXip/0Y0OwDhiDvTo9C0qe
 4hzinbfM8/xAuJCzv6yBN9rAYDzpa+a4IbPtSpu8w/dlmHpmf4GSVJNox5uWrvx6yLbITA7JGJU
 +or7SktwGZcaBXv3oMa/Soao8cZ0SRM0Ha589ZYyHXqqn+Vpb5ngifohdPZFxu4iXmSYwBOXrY0
 yBTebxLn8QuNCyg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX0pgwlTG9eHDS
 2WzUNJsjbqZcAXSRnCUvd4jmCWDRXElDITvxbHAukcFWPYJ5YodOPNZ+NFIaP8f7wSR72s6LoTy
 qDP0RQyO7gTARg/k+bNEM/nGDnBY6BU=
X-Proofpoint-GUID: 0lToN1TqVwuuiFqvadofj9QbtvdEGapf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX3VXUj6GTF+c0
 Bcb/bDYoiCv3nrVnLOb9hr8VD6BtOWpjvBct/rvHPLAyqjDrDM1sXzacnOsHTIpZrJpswmbrQZl
 wyfhBDfQY9p2MepYm4HmkcGkUPCOe11DQ896r2pVuLBraTccPNUuXPJWPt9BUiCAROajLBiiwAQ
 mOWtxgNePo08ASXGooY4VZOhgxojHcowETIutO6r9QWyAqgGBI9e9cDxdSFy3Flyz+PSKkX3PeQ
 hFZNJlx1Nhn5GmOLIeJBQws8qupS0nqyLKuccZtQZ3ASZTTF4KpmA0+MAuK10LlDQVMfFnWd89C
 ptF2oWylD/SFgXuijtDele+ku+566fYle7JG3EDMHdGKQn2TObD1sK7cJwNt8eid/cvkY09ZqaW
 fog9ffRj1Cag2BMkPh11gPvSilXlbG/oS2kYVfgTB4bFEtNzWUuu3+lzbEZ0kUdyaDkvhkOJcAG
 b/h65iHzY//5KKoTa2w==
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a58cf49 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=zydxXWD-JFuk5BhJ14wA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 0lToN1TqVwuuiFqvadofj9QbtvdEGapf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
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

Extend the kunit module for platform devices with test cases verifying
that the same software node can be added to platform devices repeatedly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/test/platform-device-test.c | 180 +++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
index 6355a2231b741791b54eb78af42e13f31f745184..9ce563f76aad6943472dc78f3639ea1a2d72dbde 100644
--- a/drivers/base/test/platform-device-test.c
+++ b/drivers/base/test/platform-device-test.c
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <kunit/fwnode.h>
 #include <kunit/platform_device.h>
 #include <kunit/resource.h>
 
 #include <linux/device.h>
 #include <linux/device/bus.h>
+#include <linux/fwnode.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #define DEVICE_NAME "test"
 
@@ -253,9 +256,186 @@ static struct kunit_suite platform_device_match_test_suite = {
 	.test_cases = platform_device_match_tests,
 };
 
+static int platform_device_swnode_test_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver platform_swnode_test_driver = {
+	.probe = platform_device_swnode_test_probe,
+	.driver = {
+		.name = DEVICE_NAME,
+	},
+};
+
+static const struct software_node platform_device_test_swnode = { };
+
+/*
+ * Check that reusing a software node works correctly. If the call to
+ * platform_device_register_full() fails after adding the secondary firmware
+ * node, the software node must be unregistered in the device's release()
+ * callback or the subsequent call to platform_device_register_full() will fail
+ * with -EBUSY due to the software node already having been registered.
+ */
+static void platform_device_swnode_add_twice(struct kunit *test)
+{
+	struct platform_device_info pdevinfo;
+	struct platform_device *pdev;
+	struct fwnode_handle *fwnode;
+	bool bound = false;
+	int ret;
+
+	fwnode = kunit_kzalloc(test, sizeof(*fwnode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
+
+	ret = kunit_platform_driver_register(test, &platform_swnode_test_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fwnode_init(fwnode, NULL);
+	pdevinfo = (struct platform_device_info){
+		.name = DEVICE_NAME,
+		.id = PLATFORM_DEVID_NONE,
+		.fwnode = fwnode,
+		.swnode = &platform_device_test_swnode,
+	};
+
+	pdev = platform_device_register_full(&pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	wait_for_device_probe();
+	scoped_guard(device, &pdev->dev)
+		bound = device_is_bound(&pdev->dev);
+
+	KUNIT_ASSERT_TRUE(test, bound);
+
+	platform_device_unregister(pdev);
+
+	pdev = platform_device_register_full(&pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	wait_for_device_probe();
+	scoped_guard(device, &pdev->dev)
+		bound = device_is_bound(&pdev->dev);
+
+	KUNIT_ASSERT_TRUE(test, bound);
+
+	platform_device_unregister(pdev);
+}
+
+/*
+ * Check that passing a software node as the primary firmware node of the
+ * platform device does not result in it being unregistered by the call to
+ * device_remove_software_node() in its release path.
+ */
+static void platform_device_swnode_as_primary(struct kunit *test)
+{
+	struct platform_device_info pdevinfo;
+	struct platform_device *pdev;
+	struct fwnode_handle *fwnode;
+	bool bound = false;
+	int ret;
+
+	ret = kunit_platform_driver_register(test, &platform_swnode_test_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fwnode = kunit_software_node_register(test, &platform_device_test_swnode);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
+
+	pdevinfo = (struct platform_device_info){
+		.name = DEVICE_NAME,
+		.id = PLATFORM_DEVID_NONE,
+		.fwnode = fwnode,
+	};
+
+	pdev = platform_device_register_full(&pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	wait_for_device_probe();
+	scoped_guard(device, &pdev->dev)
+		bound = device_is_bound(&pdev->dev);
+
+	KUNIT_ASSERT_TRUE(test, bound);
+
+	platform_device_unregister(pdev);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, software_node_fwnode(&platform_device_test_swnode));
+}
+
+/*
+ * Check that passing two software nodes to platform_device_register_full()
+ * fails.
+ */
+static void platform_device_two_swnodes(struct kunit *test)
+{
+	static const struct property_entry properties[] = {
+		PROPERTY_ENTRY_U32("foo", 42),
+		{ }
+	};
+
+	struct platform_device_info pdevinfo;
+	struct platform_device *pdev;
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	ret = kunit_platform_driver_register(test, &platform_swnode_test_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fwnode = kunit_software_node_register(test, &platform_device_test_swnode);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
+
+	pdevinfo = (struct platform_device_info){
+		.name = DEVICE_NAME,
+		.id = PLATFORM_DEVID_NONE,
+		.fwnode = fwnode,
+		.swnode = &platform_device_test_swnode,
+	};
+
+	pdev = platform_device_register_full(&pdevinfo);
+	KUNIT_ASSERT_TRUE(test, IS_ERR(pdev));
+	KUNIT_ASSERT_EQ_MSG(test, PTR_ERR(pdev), -EINVAL,
+			    "Expected errno == -EINVAL, got: %pe", pdev);
+
+	pdevinfo = (struct platform_device_info){
+		.name = DEVICE_NAME,
+		.id = PLATFORM_DEVID_NONE,
+		.swnode = &platform_device_test_swnode,
+		.properties = properties,
+	};
+
+	pdev = platform_device_register_full(&pdevinfo);
+	KUNIT_ASSERT_TRUE(test, IS_ERR(pdev));
+	KUNIT_ASSERT_EQ_MSG(test, PTR_ERR(pdev), -EINVAL,
+			    "Expected errno == -EINVAL, got: %pe", pdev);
+
+	pdevinfo = (struct platform_device_info){
+		.name = DEVICE_NAME,
+		.id = PLATFORM_DEVID_NONE,
+		.fwnode = fwnode,
+		.properties = properties,
+	};
+
+	pdev = platform_device_register_full(&pdevinfo);
+	KUNIT_ASSERT_TRUE(test, IS_ERR(pdev));
+	KUNIT_ASSERT_EQ_MSG(test, PTR_ERR(pdev), -EINVAL,
+			    "Expected errno == -EINVAL, got: %pe", pdev);
+}
+
+static struct kunit_case platform_device_swnode_tests[] = {
+	KUNIT_CASE(platform_device_swnode_add_twice),
+	KUNIT_CASE(platform_device_swnode_as_primary),
+	KUNIT_CASE(platform_device_two_swnodes),
+	{}
+};
+
+static struct kunit_suite platform_device_swnode_test_suite = {
+	.name = "platform-device-swnode",
+	.test_cases = platform_device_swnode_tests,
+};
+
 kunit_test_suites(
 	&platform_device_devm_test_suite,
 	&platform_device_match_test_suite,
+	&platform_device_swnode_test_suite,
 );
 
 MODULE_DESCRIPTION("Test module for platform devices");

-- 
2.47.3

