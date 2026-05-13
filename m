Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6955CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ABD510EF09;
	Wed, 13 May 2026 15:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jo+Ul1LW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aKQjii0m";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A868010EF11
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:33 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64D9je2V3007155
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sKKql0vh/Nr4+jL7SLsLVXl/MczXH430C80D/Yrjpr8=; b=jo+Ul1LWRR5iviyZ
 qLUx6IUh9CqgAMkRLobae3Aj0krsT7uGIoY5CzUkECDWyEZZyQUxECDJFz+4QVts
 5A9m+84/fE7PET0ZmQuetwPhPFfb21FyNCpzuljbPd2ETpf46FzRP0CBj0IXZCVI
 15WU153OC7ix1C+tCNXQStuR3VxMh8cLoMj0H6quIEuE1H0WBQSAy+g/fnULLjQu
 tOjAfSkbWpMwrNj7beT903Vawbo+RoFiNNV+LdpuD2kO+fTwFLSN+MT38NHc1D7C
 UnmNzymi6hC6lgQPRJ9/27KCvR2fnYjWclcm5G9k1Nd5dEe6PEMkX4zq5q+NKTYl
 5dQIVQ==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4py0h6r2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:32 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-696233b2816so12842914eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778684732; x=1779289532;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sKKql0vh/Nr4+jL7SLsLVXl/MczXH430C80D/Yrjpr8=;
 b=aKQjii0mLkrZOMmucD7EinS+2Kp3y6qhEyrdYW+5CcTufKiU7BF7grzlI6VoOoVL6U
 fxh3pFfHepoA9IxMsY1sU8IGWYrMtQsUcUGKaEgt+dNIFvTrub41LzFCAPMg2SvGVzk9
 Rem7D7ERYuM0+ypEDQ+v7846PvZE3Y1aUHeoSeNL2iRteLwicFDevIO+RKihRjpdNWMX
 WW100vOug180RvjWU8tFC0e4VsJeqrc+hF6he+7pFVkUdM+pBGYg20znx/QZbTCd/9NQ
 wH1AsyCUJQtey3feYp3UwOOgb4MB17lu/Qm5P5vxbUBycLxxWVjHhLWknMY8AxSLOlLa
 yuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778684732; x=1779289532;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sKKql0vh/Nr4+jL7SLsLVXl/MczXH430C80D/Yrjpr8=;
 b=sOHaba+FqC3is2Db/5Pzc8keBWsic1KSHuVCZ9YpWTQNNP5rkmZUh5oaiRndmtB62M
 2X9sBxFJM5oC0J/h9mRGJClD0Wm4BagUq2gSKQYwi59IH06dPiftCdCx8RWsgD4Roakz
 CLO/KlmAeejYhKUwjRkJ5Z2p9RXVcFx/0fMx61u2u+ePbxm5148bScGQm3Gvw00nx5La
 nWRR2ov71yg2Ff2lru4+RP+N5mdzoM3ULy4gJIsOoE/YGG4qAH8P6uOTjWjSw853e1Xq
 iCQlchTf317WI9N384/o5HPY7kAxh8CVpTWVoBsF7KxAF9R5Bbo6XK9zYKW6u74WN6SF
 8QfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ//ihK+9Wyg1tv47jMbt+IjQz9h/HBeK9kSoZzNgrIKuaHWPtMR9vEZVg2DgY/nl987ew9fdv+9aUc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMjF0i0B+kY4NtPnjtCFweY42PLKuHxv75FB6EtTFdyX6rbV37
 r4W1284aWYmas1sUl6L5Sdv0UgKUDbH1kKw6VdElpCTJsFfbW3BeW43pokX2ybjp2ru8DCavzxu
 a2ZWzX3jVTjzdHDLsf++XxgW2aG/Gdeae5dj3sN19qrVcTuql5rUEeNLDuWvGFEht+nfq8x0=
X-Gm-Gg: Acq92OFnm+mQi/BiHn5F+nkqCs54QWAjKN3hQPzJrx/i1s6GFC7y6a3jXCzonu/uQ/7
 M0BxxyPGiqoYPoyfgRauYsZmb1iLNKQbZrrr5HIt6s7v71NOrYTFQUGhrkMWb3eRnBEBM7UMF0v
 K81D86ikJCI9IvbHIfQP9nLX7f4+HzjYPZm+Ue1TYsLObsgdjFvPcUpyAzPJt1k7M+1YXFGQO3x
 zlEE59UlA5wsce0vMQcVwBeknfFFPmC+BMkP3snAAMLF8VXgCOlVvDvO8l5tmMtv4Y5g5uv4x5Q
 hshL8NZaNVXF3Ohi1T36WCuvet5DD08SKBRlJL7j4t7NgyFOoa2V/DPcH1GrPrQvOMcgRuAq1fv
 9+qZN+hHe4cMm6n11EXueBdWWEMzY7735j2JQ3FCHx6DHXr+k4Q==
X-Received: by 2002:a05:6820:81cb:b0:696:1a85:5873 with SMTP id
 006d021491bc7-69b78e116bamr1863279eaf.31.1778684731898; 
 Wed, 13 May 2026 08:05:31 -0700 (PDT)
X-Received: by 2002:a05:6820:81cb:b0:696:1a85:5873 with SMTP id
 006d021491bc7-69b78e116bamr1863208eaf.31.1778684731249; 
 Wed, 13 May 2026 08:05:31 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:63ec:4acc:c4f6:423])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f542e56sm43216455e9.34.2026.05.13.08.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 08:05:30 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 13 May 2026 17:04:52 +0200
Subject: [PATCH v6 5/6] kunit: provide kunit_software_node_register()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-swnode-remove-on-dev-unreg-v6-5-f9c58939df27@oss.qualcomm.com>
References: <20260513-swnode-remove-on-dev-unreg-v6-0-f9c58939df27@oss.qualcomm.com>
In-Reply-To: <20260513-swnode-remove-on-dev-unreg-v6-0-f9c58939df27@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=TN3rwCiI8I0/geUE/YlaOBRn/fGhaU1EpgPqlk5aLxI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqBJMo2xq6fi/uo8K/0LGlBjhlkl317KmZZ3X2c
 J8MKavEKAOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagSTKAAKCRAFnS7L/zaE
 w8hkD/9/IGJadpEJ5ke4yZkGtfmJ4R8w3TmhY6kcA40le/WTJyx80wQ+gjd5lru5gAsV0mAbnof
 XlyvWqO7ruMYDglY9A5H4F+J+nFvOMS/sUYYgt0yPaVGTicqBTBWFC6bg/VswcDXVZvsK5n1Nzz
 PCJz61LAkMZN6yu5dGlnVkv1Z9wUF+aNXja6Vvug7TQBJLWauOa/06K9pqw8z4TEyTOhg3YUc7M
 5DLMNS/QvMr7Iqq2uFkoo0s3SbwIwikDbryC2u9yF+E6+QnUWaJk52TJAWLNzXC5EZwrTrnEk3a
 CZoeQM8C9vyN+27aSWqpUvl8kSy0U+hkRb0WRYWt1T7s+0vLN193mOc3HV7/G2huwCv6+3rkdth
 kAOlFHrUFOqEpv1IhZalUWt2t1BpB8wsM+fDWUcOof6J0dknJN15mlfITcaKXciSsq+RLYuACPn
 WUfMSLBQ3qg9+ucgaiArHiS7SjMH2OkMqm66GaahYTvvgdVFbUZPHRdUSoas0OQ+k+Td7xd+EGm
 iabYBmPyPsgm75klBfAYPT9P1VJXgyZVAXfx0DrrKKc6pfbqb2ilDJHPjhlgCKKvgeTKj3DJYdA
 j7yHuEsWVjtJosH8fzkOssRL7Fk3I4zjoAYKZ0d5CKBMu6IO8I4HSyY1HM9+ZRhnj+Hagi5RQlC
 KBAl1lO+06kg5bA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE1NCBTYWx0ZWRfX4EYy4XfW5AxQ
 SWFNbIHd8atyn67w5GOp1CS/qxHZXrb1xeqvPu8aFKkrgEY+qXILSfdR61Uxw8bakcldfe3UhsV
 QqnJOFQYDD+Xyyldwaglga5u1qY5LWb3JctvJFSQ2Jg/lJ1DlSmRiSPPbKjQ8NeLDVrWULoN8yA
 mgNFZQd/6fAUq8aLCJ+lDIIfcZwCoWRuGFOfl+ZzYXI8arxU/NWPxl/Bp9QBXJIXNEy/RnxT3oW
 3tLm4bl1iK+wk8z7rBMQjFxxasPQDd0xfUyNYVGO6c/rWxQv7aTb+oCwKNMEqZpQ6/2BqlPaD4F
 VnHELoy+8/dqPHmfz691xkwnQbB3K+FUFD/dCXWKIHbjfCG7Pu1UrX1kt5mT80xSOkbl/CkZw45
 MAdtTos8qG653wA9sdi3NFb+FkQbVwfxauU02pz1mkEVM8+cuGmrvWzyYDOzeYKlKtBIrZWMF3o
 5EH+pdrpViwqofMaFAA==
X-Authority-Analysis: v=2.4 cv=XqXK/1F9 c=1 sm=1 tr=0 ts=6a04933c cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=zroAqjQEQs_9sBr7nkcA:9 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: bfniH5QF1dB9w2jLf07OEO6jEHDy3Umm
X-Proofpoint-GUID: bfniH5QF1dB9w2jLf07OEO6jEHDy3Umm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130154
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
index 0000000000000000000000000000000000000000..48ad79f3e193ad932cd943aadf159a57149223d8
--- /dev/null
+++ b/include/kunit/fwnode.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit resource management helpers for firmware nodes.
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

