Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD38CD4F35
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 12:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 161D810EA5F;
	Tue, 12 May 2026 12:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TcdXeMA2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y3QWFjIh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2399610EA61
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:00:06 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CB5HZY1184120
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 34bMm2QC5D3vRxjYjMA8BCTGNq2X+nM48LZ6CVNLD7Q=; b=TcdXeMA24SddLE3F
 SfH1/E+iui1tlbkeFLLtpgiUiLCtbId1GDQjdU2rJ3xECSnZkOkOXIhFkbNF5drM
 /SiB6NoYCIUE4Nv49Clxx4GLYv1fcpHhQUgjfRLhl5g+hbKskItfjdTnTS11jYZu
 OzcPRe3m4hu2A6Y08pUPeYow5P/1unahYPu7nCf1umJ/rZKdAvUJphkZq5/gPl7q
 +CMvNiX5zMQz/UJ5Tsxzta28ke9FGUy9MwUagt3H3d3ezwg44M2qFXL1ugL7TpTM
 pKZBVNINGhXHJlntJORNa3qkFfb8Y2MqUidsuOAJERTSPFYP5ZyzRjC2AdavdTis
 v7XbTg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuyb55y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:00:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5156c85538cso2277711cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 05:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778587205; x=1779192005;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=34bMm2QC5D3vRxjYjMA8BCTGNq2X+nM48LZ6CVNLD7Q=;
 b=Y3QWFjIh1WwLGBkHFH/2QpY8jNeGYPvhZUMgQNu21YI9sAXu04ajLRIoaYhZmw+ocX
 k/6YaXXOJJz1cHZMeFOyQkx2hlYWaJHSUu2NF9OfRFNlq3D1v5ftj933cbo19SPEGD+s
 VCUxNx2gLIQdPEjt3w6NrVLU7uN/8UwOuE9SWlKN7MPMCoxdxh4MqysygmGanqe8i5tU
 SxL40B88JLZfm66LCrKIIponJGEAlf7EbLO1ga7jzr6Zbyjyavj6a2ynV1lXn/bG/zjC
 lVTpOO68tjC1pVOwyRJWimFcV6SmAnGqxx7/1wSv1l2/VikqT/89+wl345fcMfghg2SA
 Fv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778587205; x=1779192005;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=34bMm2QC5D3vRxjYjMA8BCTGNq2X+nM48LZ6CVNLD7Q=;
 b=WCZAnz2FWJhUm4DzBYNfGHyISyz2ZGmZoZ7KU57dLUXbllWn9uQdtP/oWBUVL1XMl6
 7g/169byQVXYExOwTPIvrYAIAOQwqGDCupMI4q5j+W/V0oHNFKvC+XaSjZYwFrWC9vIg
 FJVJH4r0Dgh/qiVqazvHiKxIIzuavJxqO3xyejG3865fwkR3aL1RcLHxRq7XjkKP/a3M
 7dJSF064CXW8zcrMr6fnFcOkBU7EFwFt82eN9C0puMJXH7tDqZf7uhzpjx5UtTYtS/bn
 GIlylUVWP0TmZKr2dgG/sliqHVR+y85/D+ytN1p7rWobHpLZxDX8IBYlOolbXCe00/0v
 zRGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dnWUHVvtLpbNXPHneQybcxenwSqGoflEtSx35iCjY/Em+mL30E8Z2ncY0bTAjlVlw2V5IMUqXpNQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIgO1I3AVQfWig3zds7QAWr9dPzHhSV2vmCZAvxnB2zTWT7ttX
 hnrBNXFDSgfYb3NIOzEHRByQfBwQUQF4gRS6HiQJ9xzMz6rOb629I2Q6fLOZAZ1FHxI+QRjDPXg
 3nQzC6SYqkTKNIjSG92XrdxGo0F1+apBCDLcwBumLDg2yZKQN6WaR9NbSd+uttRn1FFZ/jAY=
X-Gm-Gg: Acq92OEqXZyVWglvEK1YYbkpBBvzJlGoLNl9YpxZZoRTzlFgo4GPX1rm6LD6nfQGI79
 JFCxQIsEDpPkKIqmrbVzR6O93scZFjkFVEz+o2nzviCCk4685Rug56jygvGBXO9l9GFLievqinU
 ZHoLLhnGUCDVAEPzsmxDSL4liQ+Rvhn6NIEq4KfFB/cOPa0u/zGn0cFrvhuub1n/voW2Xs/hib3
 ALVUlsSNpBX9cD8HUfkKWhERQMLgxPLoE9AXhTyUYpunhz/taAt145uMKrmh3Y3FZke7HnVCavo
 96a/qyno214UOILURnpUu9R/RWPS9Syut6wq8l+Pj0t/XJRXHIsmUm8HEat1KhUGeoWK062nmNI
 WtsdbUF/0q11MRq6S3fcoFw6dzf3H1NcEbWeXDlcQhApYDLoivrQ=
X-Received: by 2002:ac8:57d3:0:b0:50d:912c:c2cb with SMTP id
 d75a77b69052e-514d22159aemr34005451cf.42.1778587204396; 
 Tue, 12 May 2026 05:00:04 -0700 (PDT)
X-Received: by 2002:ac8:57d3:0:b0:50d:912c:c2cb with SMTP id
 d75a77b69052e-514d22159aemr34004721cf.42.1778587203664; 
 Tue, 12 May 2026 05:00:03 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:74a7:1c82:3f14:b431])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e9067811dsm73933355e9.9.2026.05.12.05.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 05:00:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 12 May 2026 13:59:28 +0200
Subject: [PATCH v5 6/7] kunit: provide kunit_software_node_register()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-swnode-remove-on-dev-unreg-v5-6-0035eff63812@oss.qualcomm.com>
References: <20260512-swnode-remove-on-dev-unreg-v5-0-0035eff63812@oss.qualcomm.com>
In-Reply-To: <20260512-swnode-remove-on-dev-unreg-v5-0-0035eff63812@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Andy Shevchenko <andy@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3107;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=DeQzfE7uEw87FoNwrajQBxkZ/sMoxBLsCBYIPXjNSsI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqAxYz9AUQJYLx8Gjc9Aw9y61bGXtDlL8RtTsEq
 ZrS1S1vhtuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagMWMwAKCRAFnS7L/zaE
 wxhHD/90KCisG8rjredY8t0hKDZvnfuJKDb5Ib1/NvR2zJgo5hYH+7sRtl3DPo+ZdBdf09AufUQ
 Y6B+WgCIiaMT77J009hTBYLY7I74tS5YrnoSmpsLeXoVTr1PqwE5OUrzYsCKQUJX56izRh6ayEn
 CcX7Olv7f140cVo6FBRP2rLpld5eTf6pSYVRXl1OMlrFt+2QUqjIYFXIi4b6pm8Jn8+pINaSrdS
 IcNeRyKb+yf0pXxNYMqWpn/HYdMMTjV0NoTu2Dz/+LNF1BKbyJgPtsQyl7JRD3RFCPMIJ7oaA1T
 UR0FISiBtF/x4Hkcxz1Mx764PbpImB6T7j3C2KK3jMpCxuKmTqZ6I9BVCebYtIpn0yY62WouzT+
 JPpGErbBgfUWIHUqdif653NyT4C4pQ837yvUsdz05uK0vhzvztBadDV9+xwe7rSUkinK5dG5WEO
 Af+gpi+zob8FyLwUgCtjs0wpHbvP/lxOBhVWAo9tULjQTHZD03dl1D344A8oHqS9yIyFOMyxOkU
 fGHnEjIfRuOM4DPXpdYUIyyFwtcfMhw0eyy0HAHfmkLACZtShOD9lj77RzE/m8u0MRgflgt+msw
 KdaBL2/2Wil0qqPX+fUjCB1+IyQtt14dw3dEVRjsVtr8CCwqwqIW0DjKz+s1R1VF8TRn96Y0EYH
 NKZMo+uDfbAxm7A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: F-D7fX1B3H9Grr0r605rnqzy5pibcl7w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyNCBTYWx0ZWRfX6+tpdJYERWBQ
 HNnlJx5FzjVCXF57UcsXNXV7zG5CQSWeKvEDXIG6Df+RUF4gSOtFwRloZGambrfjxclXZPlPAmI
 bA3qHIpxjuhe5d7BR9Fs2qG2QgAPHY1J0/Hri2A9Bd+iHefYQFoWtmIScjXaeQCRWDgal5rfygc
 vnHmlNkkp3qn4Bag7vtirgjdcMJI9NTKoeIsmhlK6B4z3RV7bSfDXj52wXU/oxzdz19JFJ4p4Ub
 Ac5SxrU6V6gpHivqPUv03Y3JJar3l0z1htemv8h9sY/KYhXV1+Q8VJogvL/lXozeLiO2Q+RX0YL
 44/Lzm2Aqvb6jXNq0rHcd21G7IwE4ByBJ3F3eS6qz1VRb+0NBopAgoqVT74u+0WxcjxfS4x85TG
 z4kyOeLrAQGb1SMgM5gJZ0F2O+GSEsxeiLSvpU1M1Sfd+JAZIQuCXig0cPpy5zOcZh5Y//HC+pk
 PzzBh90VB63qxAXDaAg==
X-Authority-Analysis: v=2.4 cv=UZ5hjqSN c=1 sm=1 tr=0 ts=6a031645 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=0NWOcHYCwBz2ZqcsIPkA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: F-D7fX1B3H9Grr0r605rnqzy5pibcl7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120124
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

Implement a helper for registering kunit test-managed software nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/kunit/fwnode.h | 19 ++++++++++++++++++
 lib/kunit/Makefile     |  3 ++-
 lib/kunit/fwnode.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/kunit/fwnode.h b/include/kunit/fwnode.h
new file mode 100644
index 0000000000000000000000000000000000000000..e1554ace64b8a5899aff9f4b4247e5157826a49b
--- /dev/null
+++ b/include/kunit/fwnode.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit resource management helpers firmware nodes.
+ *
+ * Copyright (C) Qualcomm Technologies, Inc. and/or its subsidiaries
+ */
+
+#ifndef _KUNIT_FWNODE_H
+#define _KUNIT_FWNODE_H
+
+struct kunit;
+struct fwnode_handle;
+struct software_node;
+
+struct fwnode_handle *
+kunit_software_node_register(struct kunit *test,
+			     const struct software_node *node);
+
+#endif /* _KUNIT_FWNODE_H */
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 656f1fa35abcc635e67d5b4cb1bc586b48415ac5..7549a701791b5b7eaa8e0637b6818cdfd0b655a8 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -10,7 +10,8 @@ kunit-objs +=				test.o \
 					executor.o \
 					attributes.o \
 					device.o \
-					platform.o
+					platform.o \
+					fwnode.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
diff --git a/lib/kunit/fwnode.c b/lib/kunit/fwnode.c
new file mode 100644
index 0000000000000000000000000000000000000000..bc8bf06762dd71a741a3419c1ca04028d6ad3ec8
--- /dev/null
+++ b/lib/kunit/fwnode.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Qualcomm Technologies, Inc. and/or its subsidiaries
+ */
+
+#include <kunit/fwnode.h>
+#include <kunit/test.h>
+
+#include <linux/fwnode.h>
+#include <linux/property.h>
+
+static void kunit_software_node_unregister(void *data)
+{
+	const struct software_node *swnode = data;
+
+	software_node_unregister(swnode);
+}
+
+/**
+ * kunit_software_node_register() - Register a KUnit-managed software node
+ * @test: test context
+ * @swnode: Software node to register
+ *
+ * Register a test-managed software node and return its firmware node handle.
+ * The software node is unregistered after the test case completes.
+ *
+ * Return: Firmware node handle of the registered software node or IS_ERR()
+ * on failure.
+ */
+struct fwnode_handle *
+kunit_software_node_register(struct kunit *test,
+			     const struct software_node *swnode)
+{
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	ret = software_node_register(swnode);
+	if (ret)
+		return ERR_PTR(ret);
+
+	fwnode = software_node_fwnode(swnode);
+	if (WARN_ON(!fwnode))
+		return ERR_PTR(-ENOENT);
+
+	ret = kunit_add_action_or_reset(test, kunit_software_node_unregister,
+					(void *)swnode);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return fwnode;
+}
+EXPORT_SYMBOL_GPL(kunit_software_node_register);

-- 
2.47.3

