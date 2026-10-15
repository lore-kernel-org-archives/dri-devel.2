Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80772CC6B3B
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0150A112206;
	Thu, 15 Oct 2026 08:59:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F93A10E848
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3xFU91640591
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 equqiGAhmOZQXvgP538lDruLxutucFc7FG2MtjjMsWo=; b=YuakJ8ifv35R8wVt
 Q8wqWgC1QeaAz5/OLHZs/77SSnm408SyO9sXuhjYJqrtH1G3E9XJeR8rpTFkKS9N
 VH3oJadrZMIUxe/8rJQbRi7Q/yjxUiKilh6bhBJVVgUEPL1mWKKMa3WMQK617i+e
 mEZey4ehkW7OcrWUMhs6xgD9YTXaQ5CYlRlKU2vFbdLq6kVpOxiR5wyFkJEA3V46
 ChxrjGefcOcQc5BaXFigEyfRFSpeIPsluS0x/76OC2DrBfyFE8smccnLc5lN7Z8D
 2mzpyNrc7Av6lQCmVD/Yig9bzRe/t8RUX7Zuu0GuN2L3pcquRZq6PjZvwO+3LfXd
 rJx9nA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhh5v1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939c30aa9a0so138615285a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792054741; x=1792659541;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=equqiGAhmOZQXvgP538lDruLxutucFc7FG2MtjjMsWo=;
 b=LQ7TfJLUF4XmHZHPmOdFbgGXS88Uw6ZxL0oAFGjIm7gdCe2N7qvrDHangmSXI/iqaW
 +nZ7RfZm7D20fUEiX/3Qmrfb4zl+1Ju1dVt88XlQgceFc+wVxfXGTLRB3qk1YPL2Vbvo
 0FfON8nY6Y6fsIGO6jqOqAlg5MUa1a6h4q8FOh6ZmW6Evxl/dUagAtrRxrka73wwNg7p
 0TGBvOP99TocXqh64vP/9iaSHD9Li2pHMbiscYE43Ct9DBXYg6VMYyBx8OP5hiFXHcbF
 HzHgXBxr0HOJBAOm9hN5glkoYo8hGg/IUoCItsBXYqebwenjTyHFSsZQbcTSiEfT6Qlv
 TdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054741; x=1792659541;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=equqiGAhmOZQXvgP538lDruLxutucFc7FG2MtjjMsWo=;
 b=eQmmZXck0DuHQthR9Oz5OIVtk2+JM6pfTOxYvdEoQ/YdsCO4BYT3z/AXGMpYZBl2DV
 +l+8ub7OpxjWvBuwRppQAigd058SMwpm78lOoIqBf7e3gpLHhnJ9q/EJsyV7pobu2ijI
 nBLZtpqhtt84RRfgOzImidvWEZuuGDNB9GRrOpsyZudKYzyr8WPmwUD0ZfN1eMTEHh/4
 gTOM41BYsn51gNVVR4EFCM1cP2386NvWajT+vb/+5SG9LMzSoY28EavM3MWHhfw1SPQ9
 2VEo4A2UpjeN5vLOiwaqZ4mDyRq2tureUoh7Yjk1uuuleH34xHIj+2yFz04GvTSaoRMg
 tGVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDqAbi7RELD4SAVW3H4bN7sTGsL5i6/0t2l2mThmRb1QKkLZHQXSSho3ihC/pgL38G2AKqQcPriNM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKYImCv32hVfBYGulhOUHIKURW2lqQoZeTloWjfEzkiFKSCkU3f
 rJZ64wH6SAgO1VvnjCFnvfmJfNtE5LStega7SKnYCs8J+cPGyNOdTktSGWd/9P2ykABcxd6TDZS
 u2cZS5EYZlrDm6P8AkHtNLBR07oy1ozAi1g2QSWAfJn8pI4AtYLAPs4JIR3mnvWVFxQU4NSM=
X-Gm-Gg: AYBFou0+ziPGH62UmmrVlazFpqkVHiwkyaZeDmJ7fW8xwuZSFf4YYdK7iD6JdB6ViHO
 CfA68n31iMbHEUhPBtPLHlCN2Ast3TlmIXxB3JCgBNeaurxDQZOtvbInNfKIdJHwgFu6JkJf7mc
 qAxpQkpJLgwlvJ/FR8mTAlNj2o6wgiTvGxd0svBio5szEy6xfkX7agZ7jGOmdmwajSgW6PISmFQ
 9Ey5FYwS3CYicJ20N6mz3zASPVXLJ5yUCBonMvyIK7WOf4apPalIeEPg5MUrKlmiCQp91Ut6CkK
 tstbgQ3u6DSjvA1IHTPTS77AjPT6mb0XcHCA7JtQuu7brfrHniMv8n8hqjUru2DQ2BYOXhs4SXw
 DrWNVDXYk3YBCy60eiCbBi8JXVkYZvKWa8lS7VjXL6sYCFMaRP/85KUwlJVeSUkS/sjwO7w7TOg
 D8BE+PQactRTcZ
X-Received: by 2002:a05:620a:6188:b0:93e:ad16:9590 with SMTP id
 af79cd13be357-93ebd24a4d6mr2883281685a.36.1792054741133; 
 Thu, 15 Oct 2026 01:59:01 -0700 (PDT)
X-Received: by 2002:a05:620a:6188:b0:93e:ad16:9590 with SMTP id
 af79cd13be357-93ebd24a4d6mr2883278885a.36.1792054740570; 
 Thu, 15 Oct 2026 01:59:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:58:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:42 +0300
Subject: [PATCH 5/9] regulator: add Qualcomm LCDB driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-5-5c14928cef29@oss.qualcomm.com>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15237;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=fD9NAkngKsBPywoGpoYBtQ9ZW5qvPaiTmwDMbIhV1bU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXFj8OMV+s9I8RvL2klgRW3Oy0cg//mpatXi
 uJRpco2N8GJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVxQAKCRCLPIo+Aiko
 1YWgB/0Q+GtDVRI1mSfYjw7TUvbPPPQDpb7TRExzhoAPJ/JpFk9G8caaC8Q6DIN3y3S8t7q1he1
 FztUapdQZOKFnBlbX4oHH7wRh5As9O7WwF7IKr69OJXJ3D2+ON06GkmLibA1kYrzNJWGGCxbC+u
 TLdLjG+N7+dEApnEN8ipZe0FF5lPktqg5ja/LXhLkna58yfZMtnwj8vOdpeRYMy8LThcpKULq43
 lb7oW/a5OX8wuX8JNu+9z0b4gu4Tvcjk/fW26lqLWH7U/TZN3wraSNZPXnwyw1q+u0oSItYMGIN
 YwyskBDBeuVDks0LfYlAppEKeVYlqjabVa9Q8KAMl3M7gZUM
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX6hxyqlCILBvm
 RKhESDQeDL2OOq0x+CyqG8AsZvDubTCkGOFsguRyWVNA3aKNLRkAMFuiGlqft7PRZOpTctqoW5l
 huW96SUmXIjFUwHpQJnZUk+JpODz6t18c4vJU86NfkE8uvmotKd5v0IKeyVkCLlkQrrqRoKCFeE
 T0W3J4dmmACHoHpbgxvLGUq3H172IGCWZNA2Jxu1hWC5EAjPNBUp0k13luutA+v+QJPhJwwBSm8
 8NEP0hNQ6/0B0f7OwcvLuy06WuiiCCH8iWMc+KSARCAFhvwpZlDWgdzUzMtx42xgy2TwTnfPp+M
 T3Ic1nP4cbmhl3TTBAvOS5/hXi5R4hy3fCk7zjTS0nuS9JschWEdvL4vtkUXestkwDecUKWrNc5
 s4V+4N+8lpaUi7yMED3dyn+aLZLYdpjMKvr8O09xzm+61RWuJerobtxpZLfMbhgTo/HcrYTimyS
 X8AVmavXt2quDTBC7Wg==
X-Proofpoint-GUID: U81xN2fgUzVg315WHDtlujHTkjBqBM7X
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad095d6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=g7T4oR2AxEylw3ofldQA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX2F3yXoLHf5aL
 I8x+wr3ZX4/kwiCcFb59NSf9tqtOP0AKopKOgoTTTa0fqc5FtanMeiP167hEGNNfy3z1Run9xRp
 b5g+hAPR1HW9DgCuds+f0UEm48VQfCI=
X-Proofpoint-ORIG-GUID: U81xN2fgUzVg315WHDtlujHTkjBqBM7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150035
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

LCD panels on boards with PMI632, PM6150L or PM8150L take their bias
rails from the LCDB block. Without a driver they only work as long as
the bootloader has enabled it and nothing turns it off.

Both rails sit behind a single module enable, so the module is kept on
while at least one of them is in use. The boost output is not exposed,
it follows the higher of the two rails plus the headroom. Enabling
starts at a lower voltage and ramps up in steps, and the LDO pull-down
is forced while disabling, both as done by the vendor driver.

Touch-to-wake, current limit and soft start tuning and PM660L are not
supported.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/regulator/Kconfig               |   8 +
 drivers/regulator/Makefile              |   1 +
 drivers/regulator/qcom-lcdb-regulator.c | 475 ++++++++++++++++++++++++++++++++
 3 files changed, 484 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index be6b72daa76f..9fd3f2c7e365 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1915,4 +1915,12 @@ config REGULATOR_QCOM_LABIBB
 	  boost regulator and IBB can be used as a negative boost regulator
 	  for LCD display panel.
 
+config REGULATOR_QCOM_LCDB
+	tristate "Qualcomm LCDB regulator support"
+	depends on SPMI || COMPILE_TEST
+	help
+	  This driver supports the LCDB (LCD bias) block found on Qualcomm
+	  PMICs such as PMI632, PM6150L and PM8150L. It provides the positive
+	  (LDO) and negative (NCP) bias rails for LCD panels.
+
 endif
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 6aabcc54382a..84164d2b6c45 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_MTK_DVFSRC) += mtk-dvfsrc-regulator.o
 obj-$(CONFIG_REGULATOR_NEX10000UB) += nex10000ub-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_LABIBB) += qcom-labibb-regulator.o
+obj-$(CONFIG_REGULATOR_QCOM_LCDB) += qcom-lcdb-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_PM8008) += qcom-pm8008-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_REFGEN) += qcom-refgen-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
diff --git a/drivers/regulator/qcom-lcdb-regulator.c b/drivers/regulator/qcom-lcdb-regulator.c
new file mode 100644
index 000000000000..45b3b7118e31
--- /dev/null
+++ b/drivers/regulator/qcom-lcdb-regulator.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/ktime.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define LCDB_INT_RT_STS			0x10
+#define  LCDB_VREG_OK_RT_STS		BIT(0)
+#define  LCDB_SC_ERROR_RT_STS		BIT(1)
+
+#define LCDB_BST_OUTPUT_VOLTAGE		0x41
+#define  LCDB_BST_OUTPUT_VOLTAGE_MASK	GENMASK(5, 0)
+
+#define LCDB_MODULE_RDY			0x45
+#define  LCDB_MODULE_RDY_BIT		BIT(7)
+
+#define LCDB_ENABLE_CTL1		0x46
+#define  LCDB_MODULE_EN			BIT(7)
+
+#define LCDB_LDO_OUTPUT_VOLTAGE		0x71
+#define LCDB_LDO_FORCE_PD_CTL		0x79
+#define  LCDB_LDO_FORCE_PD_EN		BIT(0)
+#define  LCDB_LDO_FORCE_PD_MODE		BIT(7)
+
+#define LCDB_NCP_OUTPUT_VOLTAGE		0x81
+
+#define LCDB_OUTPUT_VOLTAGE_MASK	GENMASK(4, 0)
+
+#define LCDB_MIN_UV			4000000
+#define LCDB_STEP_100MV_UV		100000
+#define LCDB_50MV_MIN_UV		4950000
+#define LCDB_STEP_50MV_UV		50000
+#define LCDB_50MV_MIN_SEL		10
+#define LCDB_N_VOLTAGES			32
+
+#define LCDB_BST_MIN_UV			4700000
+#define LCDB_BST_MAX_UV			6275000
+#define LCDB_BST_STEP_UV		25000
+#define LCDB_BST_HEADROOM_UV		150000
+
+#define LCDB_RAMP_START_UV		4500000
+#define LCDB_RAMP_STEP_UV		500000
+
+#define LCDB_OFF_ON_DELAY_US		20000
+#define LCDB_VREG_OK_TIMEOUT_US		50000
+
+#define LCDB_SC_RESET_CNT_DLY_US	1000000
+#define LCDB_SC_CNT_MAX			10
+
+enum {
+	LCDB_LDO,
+	LCDB_NCP,
+	LCDB_NUM_RAILS,
+};
+
+struct qcom_lcdb {
+	struct device *dev;
+	struct regmap *regmap;
+	u32 base;
+
+	struct mutex lock;
+	struct regulator_dev *rdev[LCDB_NUM_RAILS];
+	int uV[LCDB_NUM_RAILS];
+	unsigned int enabled_mask;
+	ktime_t off_time;
+
+	bool sc_disabled;
+	int sc_count;
+	ktime_t sc_time;
+};
+
+static const u8 qcom_lcdb_vreg[LCDB_NUM_RAILS] = {
+	[LCDB_LDO] = LCDB_LDO_OUTPUT_VOLTAGE,
+	[LCDB_NCP] = LCDB_NCP_OUTPUT_VOLTAGE,
+};
+
+static unsigned int qcom_lcdb_uV_to_sel(int uV)
+{
+	if (uV < LCDB_50MV_MIN_UV)
+		return (uV - LCDB_MIN_UV) / LCDB_STEP_100MV_UV;
+
+	return LCDB_50MV_MIN_SEL + (uV - LCDB_50MV_MIN_UV) / LCDB_STEP_50MV_UV;
+}
+
+static int qcom_lcdb_sel_to_uV(unsigned int sel)
+{
+	if (sel < LCDB_50MV_MIN_SEL)
+		return LCDB_MIN_UV + sel * LCDB_STEP_100MV_UV;
+
+	return LCDB_50MV_MIN_UV + (sel - LCDB_50MV_MIN_SEL) * LCDB_STEP_50MV_UV;
+}
+
+static int qcom_lcdb_write_voltages(struct qcom_lcdb *lcdb, int ldo_uV, int ncp_uV)
+{
+	const int uV[LCDB_NUM_RAILS] = { ldo_uV, ncp_uV };
+	unsigned int bst_sel, cur_sel;
+	int bst_uV, ret, i;
+
+	bst_uV = clamp(max(ldo_uV, ncp_uV) + LCDB_BST_HEADROOM_UV,
+		       LCDB_BST_MIN_UV, LCDB_BST_MAX_UV);
+	bst_sel = DIV_ROUND_UP(bst_uV - LCDB_BST_MIN_UV, LCDB_BST_STEP_UV);
+
+	ret = regmap_read(lcdb->regmap, lcdb->base + LCDB_BST_OUTPUT_VOLTAGE, &cur_sel);
+	if (ret)
+		return ret;
+	cur_sel &= LCDB_BST_OUTPUT_VOLTAGE_MASK;
+
+	/* The boost has to stay above both outputs while they are changing */
+	if (bst_sel > cur_sel) {
+		ret = regmap_update_bits(lcdb->regmap,
+					 lcdb->base + LCDB_BST_OUTPUT_VOLTAGE,
+					 LCDB_BST_OUTPUT_VOLTAGE_MASK, bst_sel);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < LCDB_NUM_RAILS; i++) {
+		ret = regmap_update_bits(lcdb->regmap,
+					 lcdb->base + qcom_lcdb_vreg[i],
+					 LCDB_OUTPUT_VOLTAGE_MASK,
+					 qcom_lcdb_uV_to_sel(uV[i]));
+		if (ret)
+			return ret;
+	}
+
+	if (bst_sel < cur_sel)
+		ret = regmap_update_bits(lcdb->regmap,
+					 lcdb->base + LCDB_BST_OUTPUT_VOLTAGE,
+					 LCDB_BST_OUTPUT_VOLTAGE_MASK, bst_sel);
+
+	return ret;
+}
+
+static int qcom_lcdb_write_limited(struct qcom_lcdb *lcdb, int limit_uV)
+{
+	return qcom_lcdb_write_voltages(lcdb,
+					min(lcdb->uV[LCDB_LDO], limit_uV),
+					min(lcdb->uV[LCDB_NCP], limit_uV));
+}
+
+static int qcom_lcdb_module_disable(struct qcom_lcdb *lcdb)
+{
+	int ret;
+
+	/* Force the LDO pull-down to discharge the output quickly */
+	ret = regmap_write(lcdb->regmap, lcdb->base + LCDB_LDO_FORCE_PD_CTL,
+			   LCDB_LDO_FORCE_PD_EN | LCDB_LDO_FORCE_PD_MODE);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(lcdb->regmap, lcdb->base + LCDB_ENABLE_CTL1, 0);
+	if (ret)
+		return ret;
+
+	lcdb->off_time = ktime_get();
+
+	usleep_range(10000, 11000);
+
+	return regmap_write(lcdb->regmap, lcdb->base + LCDB_LDO_FORCE_PD_CTL, 0);
+}
+
+static int qcom_lcdb_module_enable(struct qcom_lcdb *lcdb)
+{
+	int target_uV = max(lcdb->uV[LCDB_LDO], lcdb->uV[LCDB_NCP]);
+	int uV = LCDB_RAMP_START_UV;
+	unsigned int val;
+	s64 off_us;
+	int ret;
+
+	off_us = ktime_us_delta(ktime_get(), lcdb->off_time);
+	if (off_us < LCDB_OFF_ON_DELAY_US)
+		usleep_range(LCDB_OFF_ON_DELAY_US - off_us,
+			     LCDB_OFF_ON_DELAY_US - off_us + 1000);
+
+	/* Start low and ramp the outputs up in steps to limit the inrush current */
+	ret = qcom_lcdb_write_limited(lcdb, uV);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(lcdb->regmap, lcdb->base + LCDB_ENABLE_CTL1,
+			   LCDB_MODULE_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(lcdb->regmap,
+				       lcdb->base + LCDB_INT_RT_STS, val,
+				       val & LCDB_VREG_OK_RT_STS,
+				       1000, LCDB_VREG_OK_TIMEOUT_US);
+	if (ret) {
+		dev_err(lcdb->dev, "outputs failed to come up: %d\n", ret);
+		goto err_disable;
+	}
+
+	usleep_range(10000, 11000);
+
+	while (uV < target_uV) {
+		uV += LCDB_RAMP_STEP_UV;
+
+		ret = qcom_lcdb_write_limited(lcdb, uV);
+		if (ret)
+			goto err_disable;
+
+		usleep_range(1000, 1100);
+	}
+
+	return 0;
+
+err_disable:
+	qcom_lcdb_module_disable(lcdb);
+
+	return ret;
+}
+
+static int qcom_lcdb_enable(struct regulator_dev *rdev)
+{
+	struct qcom_lcdb *lcdb = rdev_get_drvdata(rdev);
+	int ret = 0;
+
+	guard(mutex)(&lcdb->lock);
+
+	if (lcdb->sc_disabled)
+		return -EIO;
+
+	if (!lcdb->enabled_mask)
+		ret = qcom_lcdb_module_enable(lcdb);
+	if (ret)
+		return ret;
+
+	lcdb->enabled_mask |= BIT(rdev_get_id(rdev));
+
+	return 0;
+}
+
+static int qcom_lcdb_disable(struct regulator_dev *rdev)
+{
+	struct qcom_lcdb *lcdb = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&lcdb->lock);
+
+	lcdb->enabled_mask &= ~BIT(rdev_get_id(rdev));
+	if (lcdb->enabled_mask)
+		return 0;
+
+	return qcom_lcdb_module_disable(lcdb);
+}
+
+static int qcom_lcdb_is_enabled(struct regulator_dev *rdev)
+{
+	struct qcom_lcdb *lcdb = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&lcdb->lock);
+
+	return !!(lcdb->enabled_mask & BIT(rdev_get_id(rdev)));
+}
+
+static int qcom_lcdb_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
+{
+	struct qcom_lcdb *lcdb = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&lcdb->lock);
+
+	lcdb->uV[rdev_get_id(rdev)] = qcom_lcdb_sel_to_uV(sel);
+
+	return qcom_lcdb_write_voltages(lcdb, lcdb->uV[LCDB_LDO],
+					lcdb->uV[LCDB_NCP]);
+}
+
+static int qcom_lcdb_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct qcom_lcdb *lcdb = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&lcdb->lock);
+
+	return qcom_lcdb_uV_to_sel(lcdb->uV[rdev_get_id(rdev)]);
+}
+
+static const struct regulator_ops qcom_lcdb_ops = {
+	.enable			= qcom_lcdb_enable,
+	.disable		= qcom_lcdb_disable,
+	.is_enabled		= qcom_lcdb_is_enabled,
+	.set_voltage_sel	= qcom_lcdb_set_voltage_sel,
+	.get_voltage_sel	= qcom_lcdb_get_voltage_sel,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+};
+
+static const struct linear_range qcom_lcdb_ranges[] = {
+	REGULATOR_LINEAR_RANGE(LCDB_MIN_UV, 0, LCDB_50MV_MIN_SEL - 1,
+			       LCDB_STEP_100MV_UV),
+	REGULATOR_LINEAR_RANGE(LCDB_50MV_MIN_UV, LCDB_50MV_MIN_SEL,
+			       LCDB_N_VOLTAGES - 1, LCDB_STEP_50MV_UV),
+};
+
+static const struct regulator_desc qcom_lcdb_descs[LCDB_NUM_RAILS] = {
+	[LCDB_LDO] = {
+		.name			= "lcdb_ldo",
+		.of_match		= "ldo",
+		.id			= LCDB_LDO,
+		.ops			= &qcom_lcdb_ops,
+		.type			= REGULATOR_VOLTAGE,
+		.linear_ranges		= qcom_lcdb_ranges,
+		.n_linear_ranges	= ARRAY_SIZE(qcom_lcdb_ranges),
+		.n_voltages		= LCDB_N_VOLTAGES,
+		.owner			= THIS_MODULE,
+	},
+	[LCDB_NCP] = {
+		.name			= "lcdb_ncp",
+		.of_match		= "ncp",
+		.id			= LCDB_NCP,
+		.ops			= &qcom_lcdb_ops,
+		.type			= REGULATOR_VOLTAGE,
+		.linear_ranges		= qcom_lcdb_ranges,
+		.n_linear_ranges	= ARRAY_SIZE(qcom_lcdb_ranges),
+		.n_voltages		= LCDB_N_VOLTAGES,
+		.owner			= THIS_MODULE,
+	},
+};
+
+static void qcom_lcdb_handle_sc(struct qcom_lcdb *lcdb)
+{
+	int i;
+
+	guard(mutex)(&lcdb->lock);
+
+	if (!lcdb->enabled_mask || lcdb->sc_disabled)
+		return;
+
+	qcom_lcdb_module_disable(lcdb);
+
+	if (ktime_us_delta(ktime_get(), lcdb->sc_time) > LCDB_SC_RESET_CNT_DLY_US) {
+		lcdb->sc_count = 0;
+	} else if (lcdb->sc_count > LCDB_SC_CNT_MAX) {
+		dev_err(lcdb->dev, "persistent short circuit, keeping the outputs off\n");
+		lcdb->sc_disabled = true;
+
+		for (i = 0; i < LCDB_NUM_RAILS; i++)
+			regulator_notifier_call_chain(lcdb->rdev[i],
+						      REGULATOR_EVENT_FAIL, NULL);
+		return;
+	}
+
+	lcdb->sc_count++;
+	lcdb->sc_time = ktime_get();
+
+	if (qcom_lcdb_module_enable(lcdb))
+		dev_err(lcdb->dev, "failed to recover from a short circuit\n");
+}
+
+static irqreturn_t qcom_lcdb_sc_irq(int irq, void *data)
+{
+	struct qcom_lcdb *lcdb = data;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(lcdb->regmap, lcdb->base + LCDB_INT_RT_STS, &val);
+	if (ret || !(val & LCDB_SC_ERROR_RT_STS))
+		return IRQ_HANDLED;
+
+	/* Blanking time, a real short circuit is still reported afterwards */
+	usleep_range(2000, 2100);
+
+	ret = regmap_read(lcdb->regmap, lcdb->base + LCDB_INT_RT_STS, &val);
+	if (ret || !(val & LCDB_SC_ERROR_RT_STS))
+		return IRQ_HANDLED;
+
+	qcom_lcdb_handle_sc(lcdb);
+
+	return IRQ_HANDLED;
+}
+
+static int qcom_lcdb_hw_init(struct qcom_lcdb *lcdb)
+{
+	unsigned int val;
+	int ret, i;
+
+	for (i = 0; i < LCDB_NUM_RAILS; i++) {
+		ret = regmap_read(lcdb->regmap, lcdb->base + qcom_lcdb_vreg[i], &val);
+		if (ret)
+			return ret;
+
+		lcdb->uV[i] = qcom_lcdb_sel_to_uV(val & LCDB_OUTPUT_VOLTAGE_MASK);
+	}
+
+	ret = regmap_read(lcdb->regmap, lcdb->base + LCDB_ENABLE_CTL1, &val);
+	if (ret)
+		return ret;
+
+	if (val & LCDB_MODULE_EN) {
+		lcdb->enabled_mask = GENMASK(LCDB_NUM_RAILS - 1, 0);
+		return 0;
+	}
+
+	return regmap_set_bits(lcdb->regmap, lcdb->base + LCDB_MODULE_RDY,
+			       LCDB_MODULE_RDY_BIT);
+}
+
+static int qcom_lcdb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regulator_config cfg = {};
+	struct qcom_lcdb *lcdb;
+	int irq, ret, i;
+
+	lcdb = devm_kzalloc(dev, sizeof(*lcdb), GFP_KERNEL);
+	if (!lcdb)
+		return -ENOMEM;
+
+	lcdb->dev = dev;
+
+	lcdb->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!lcdb->regmap)
+		return dev_err_probe(dev, -ENODEV, "failed to get the parent regmap\n");
+
+	ret = device_property_read_u32(dev, "reg", &lcdb->base);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get the base address\n");
+
+	ret = devm_mutex_init(dev, &lcdb->lock);
+	if (ret)
+		return ret;
+
+	ret = qcom_lcdb_hw_init(lcdb);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read the initial state\n");
+
+	cfg.dev = dev;
+	cfg.regmap = lcdb->regmap;
+	cfg.driver_data = lcdb;
+
+	for (i = 0; i < LCDB_NUM_RAILS; i++) {
+		lcdb->rdev[i] = devm_regulator_register(dev, &qcom_lcdb_descs[i], &cfg);
+		if (IS_ERR(lcdb->rdev[i]))
+			return dev_err_probe(dev, PTR_ERR(lcdb->rdev[i]),
+					     "failed to register %s\n",
+					     qcom_lcdb_descs[i].name);
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	return devm_request_threaded_irq(dev, irq, NULL, qcom_lcdb_sc_irq,
+					 IRQF_ONESHOT, "lcdb-sc", lcdb);
+}
+
+static const struct of_device_id qcom_lcdb_match[] = {
+	{ .compatible = "qcom,pm8150l-lcdb" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qcom_lcdb_match);
+
+static struct platform_driver qcom_lcdb_driver = {
+	.driver = {
+		.name = "qcom-lcdb-regulator",
+		.of_match_table = qcom_lcdb_match,
+	},
+	.probe = qcom_lcdb_probe,
+};
+module_platform_driver(qcom_lcdb_driver);
+
+MODULE_DESCRIPTION("Qualcomm LCDB (LCD bias) regulator driver");
+MODULE_LICENSE("GPL");

-- 
2.47.3

