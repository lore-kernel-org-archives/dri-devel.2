Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC8FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441E110EA12;
	Mon, 13 Jul 2026 15:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jcRCB/7D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NwXpppQV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442D310EA30
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 15:12:28 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF85Qd1701335
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 15:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nAzeN59J0azB7+VxlBwnfSfYuZUkQq63rtSgGfRJFeY=; b=jcRCB/7DvOW944R/
 sn83hdNJaSiW5aSaS+Bk7JS92KHNJVniy45ohZWgZim+NDIyllXCfeL0643JD6OB
 jQiUD3NiPCq/ZkcQu6fwgtnRHKfOFfAbldYKMowgpaFzhNoFlNVI3ahliyR2ffYc
 PaViAW2GryjCL39Tsb8bOCkcAxbkRhLEaV320yapgpfF90WqOXk+YG8VONOv061v
 Q6wx5YdLDB/+iafOVGq6gd07pz+87PclsfgfoXKc1ZWdXY5kdD2TzCR6PquRcfnd
 xGjxEdVIjtb4cPrwiAdZdhm0Hfqe2uNaWXfGvh03KDCXkvjygTm4Qw4+pH9saWbB
 umxn8A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk3ha1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 15:12:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so44975451cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783955547; x=1784560347;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nAzeN59J0azB7+VxlBwnfSfYuZUkQq63rtSgGfRJFeY=;
 b=NwXpppQVUh2+KIxbGD+Z20pqlAqv4ER3X0XeBuaMiP+sEOgao4DH4C1FfE0/R4UWdc
 vDK+ElG3Ilpz4BXu5sEMEsdBeP8/9i5iwnxd0/Cqbzh1LhcJ3O8J957DOZ1UOaHjRm83
 bO0mVUgHq/HsFQ2A43gu3a7dOtJqhiXjhYg0k6iiv2UYRaXyAscs/xRJGewmw+h/ubsp
 5F+2rIoA9p5qrkaClTDtor9gb821RTqXh5NJCsargDcnXyTJOLRN9IYXgrDsZmrQfWsr
 Oi3mIC3LiHG3wLv5dCjAOLoE3NyofEYZ7J6dVrtjegn1elGmcMN8jNtv5GGByAhh1V6F
 80Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783955547; x=1784560347;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nAzeN59J0azB7+VxlBwnfSfYuZUkQq63rtSgGfRJFeY=;
 b=MdCppB/rWYm8mM8uGaktqM7tEMM5QbwhjoNgxwmEndRbzleWkaJYZHIY9EEXtPvThz
 Rb2GzKbgJn3Ga2UiFNMHcDc3dhYZvRdF9aRnIAf9x6XldT0wGTrlN3L48fjoXY7NprRj
 +UZuCSaMJJyo0tpxKA4yxyEhIab0C2BCs9yyuJMSgWPniMRmhlKraW9oVmrcEGTJPMNJ
 2lhvYHzUFOA0xTIJqmTpmmTXj+J4dv/euywAwBhhiw2J7kwSh9tlWZkZ0tjh7IFYKPMN
 mEM644KFd2N6JUX7GLs4fOBFSZSi7csO6LuOO/Rnq/mg22f3HxwFqvPXD3il3ey3urYZ
 1W0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKnNBXdRn9wKn28x08kC8ZUTCZWX+8LUgz5YJadNP2qHubokbejS2hoGA2lnw9yEBMNhXFrl9lJMg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjmG0jfC5w6dDM7wK0hjk+RY3hI/RgX1boPMvVadVhD++Ly9oJ
 PHBI2myFFF0aHTCaaeGS9Ct5M3HeXUmDgYmaaR1rp9dOPG9ztnb/XP2rbBljBJmZ7p+4hM3vizB
 41NeN1lpMza70GIew3GYVgRYbL7pdtnp5Iqtmqb6EBJ2sDT7eaWO6zRgX7//rx8a8+jHuHkg=
X-Gm-Gg: AfdE7cllmgjMAuukG1hZzDn7QU1vyLktNhAq8Jtfz0EA5vm9EqgPQKONu03dVqPdJIl
 atmhMWUi4ku2AUw8xwBbtleLmwHuhYJ9QK7E7urB9TZreUyLegwtQ+wyJELCEdDTe6CxdR/DDOG
 6v2wwfWSyOvleLaGlVVhwzYf5AwLM8Sr7pHq9BdQzCYNk/KH6meD9F8xX0+exAwl43GtuGputwJ
 gJAzMOOT/ZTpzirfsu5QKTYs1nZHeabkAtGwv4gLqJqIVd8fE2lzeOmjIR98b48GCR1XqKEqAdz
 RYHhw0UF8Lx0wU37R4C7LNEf8jyEsI3sNmyOGYoOQQvl3SvoxrsKHGygPzFZtqUo2xVRGOKnoTM
 7Yv+NZi7cVll0m787T6R6e49XbmGC6qSqgR35LS/Z
X-Received: by 2002:ac8:7f89:0:b0:51a:8c97:938e with SMTP id
 d75a77b69052e-51cbf287e88mr96882241cf.69.1783955546690; 
 Mon, 13 Jul 2026 08:12:26 -0700 (PDT)
X-Received: by 2002:ac8:7f89:0:b0:51a:8c97:938e with SMTP id
 d75a77b69052e-51cbf287e88mr96881541cf.69.1783955546045; 
 Mon, 13 Jul 2026 08:12:26 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a558easm87956664f8f.27.2026.07.13.08.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:12:24 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 17:12:00 +0200
Subject: [PATCH v7 4/4] driver core: platform: tests: add test cases for
 correct swnode removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-swnode-remove-on-dev-unreg-v7-4-6d6bc448427a@oss.qualcomm.com>
References: <20260713-swnode-remove-on-dev-unreg-v7-0-6d6bc448427a@oss.qualcomm.com>
In-Reply-To: <20260713-swnode-remove-on-dev-unreg-v7-0-6d6bc448427a@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVQBNIfBh8eZoHsF8HLG+w8cZbCKKmZx4hpanR
 IC0jnASC8GJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalUATQAKCRAFnS7L/zaE
 w+m4EACj7kCadQtPriMiLBsyh/UeZju0w3Z5woybvD2DUOzj/3xS8OhVCjG1jw4pXEMNjsWF7FE
 25xld9nm/Vx8CURMNnyrdYLYP4sA9rMpvH09dbxgUyWKwAaX/0dTTfWITqeCgtVJpMvpy/gWt+i
 1vBo0H/Xk/T9WpvZrUvwzsEdKd17lRXlSv+iu3JaIHmhHidGgkoN6pYxPyMNEjYO2jmXFbgtuso
 Co9zq0hChPyBScaGES4XUgTFXApYLBq1nHUc1MihSUrYvIXtOxs4c6KdHtzEwoGaWTzHukHKg5D
 eIXHliyqoXlTq8iUhPv+zWryvHiffyPz+ovpcHvjee9f4Sh6hgHTEmV5xNwi39W1sddnYQF5AoP
 a1rZT8YCTX+cb+e9tbb1u+7ICiZTmtjNi4/jGvpnilQ6dbB594mrW0VRESqh0GzV4B5YsScNhWC
 Ua+5s5CevweEZkMCVPyPokbahXHn1KH8jE6HXwB70l+/FzOuKmUC8C6trPXKcsYAxeWEOQtur5K
 UTchmQxsvIsB46bDeB4DYkcRiOSziygrE7nM+V3XI2qJqT7o4ASHt7NPxuQO5UccqU/4KIO9Rof
 K/sCY9GMVcEDo+EETlPdMj/xppbFdYHiUPbFv0rDYsrt0oIZXV0B63G9BEs5izCGywK8RvFRvqA
 kgq4M6heDWFlefg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: nt2Biy6JxWf76LYFnPJtawrADhmI2L_v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1OCBTYWx0ZWRfX9GkMRvJVNHDc
 7KzcweiLXak8xQfn8ZfRL1NDdzRscdVIfLJoEfFnYeXZqnPkF4+O7YXwWF99Jhc47Fs2QTAb1YK
 Ha5X2WfFsSB0xd8eLupwxF0PyoVHWYo=
X-Authority-Analysis: v=2.4 cv=e6c2j6p/ c=1 sm=1 tr=0 ts=6a55005b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=zydxXWD-JFuk5BhJ14wA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1OCBTYWx0ZWRfX2Rj2lhByQrva
 fyK2DUdIlUqzR+ZD+7p0G89mBJ4c5btHuNNDetOTGWTenxVMNppR0WtT6Bjk7XGdUQ/zeUfKVKi
 VrVUj0bhRmNAu0JKcjxw6xlRd0/T/2xobduLZX8QqnxtrfjSPNjFW+MkN3ao0ZqzgRybhrBIDT7
 1nzOnAyvCxfkdlNv7xgljJlWl+6dAWOm1XOnhvnhUox4XIpgBOQHLNv56Gi06NowHnMoTM3UeBq
 +YFJqP0A0Lw4hDnast/mwjplgxsrbC6p6dm/7s7k4u3SkTC4djNpji7mPIHimIRh76oLxtcJDOV
 XnRlrhqEYJ4NFJknmDtD9eADWR7yQJ9H1mkLAFa4dTARzLLypAkYWk+BrXrWBggxB9intOv3JDW
 Yb6Or7jp3zibtWqEGZHmviEHKaSGv+sBWfOn1sD00pU+GGdoB/MVtod8R7KwaMq7CgzKNzASEd+
 Vbj7KEnxpkaOyKphvPA==
X-Proofpoint-GUID: nt2Biy6JxWf76LYFnPJtawrADhmI2L_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130158
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

