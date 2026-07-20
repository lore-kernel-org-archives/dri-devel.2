Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA97EC4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D77E78952F;
	Mon, 20 Jul 2026 08:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EGMJqpy5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FYaJhy/5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A377410E822
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:44:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K76xZi1896179
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FmZRJE3QliI8ngRIiweIPhnI7WNysb4MqIkWbp6/7E0=; b=EGMJqpy5bickj1U2
 wqpYD6Mz/+LG3HGmNiikXcYyegf8lJ1s+gOgwpUdvB1hBNAZ63AILLteSh1aFWIS
 Wgyy79mDvEaKoI84LSC6nHkYmuqPh5uRCADez7isy2IEeLxDlGqP5zVB634nnPCt
 Skrc89jLWDcKDZTHq4JykbqtN94xX1ZgNXlD+W49KCxmqcGzkI6AKS7YmlEa6V/F
 PuMov1OfUUSfNjYWpqAgR4EGHa5qhq5mxkdoj7/A9/6WMpxXA1vNBzRihrhy2Fho
 LNCJN6hXP70WiTF6IE0rKE9fqzxtgEgfSP4+oclUBB5wTsdP7DMm4e9JKyTP0Jyz
 rS/ukQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0krcgt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:44:24 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f113592bf3so145479556d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537063; x=1785141863;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FmZRJE3QliI8ngRIiweIPhnI7WNysb4MqIkWbp6/7E0=;
 b=FYaJhy/58xF8pdX/qM2SzuLukiFnjv+7sU7qy79l/RNtHHfU1TFGyr5VDE1Vb4kLFZ
 D2fx52SsxXMfjYGrB8ejNqWOJuxxTQowIRMIh3VpA010E5vxIxRBXkHxTR6AkPRbYSvK
 IX787r2acrcYKex3cs2bnrpsDNI0qxKKecKtX5LnwLamdBUJyilHpbDfTD4ZJxycnl7x
 hvimbLuyOi+zJQ+R7anKESTcL9XouR8jCapVXlEtd542RiVlyZNWOJI0r7Q5id5ZxuJS
 soRIe6Hwi5ujVeldUUZP+V4DoFyo0KaWrVDHwAFHYtytZvapzRpK1K/RiIr9T7ozXt5v
 jUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537063; x=1785141863;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FmZRJE3QliI8ngRIiweIPhnI7WNysb4MqIkWbp6/7E0=;
 b=rTDeFVlMfOgsqsg/Tay4WNoQVMv//BlDkmc38vcpw5XxVTFxAWux9yrvxoAbd36F2R
 iPHj5PikP1Z/bGKWs2Vin2XZnGUFhNXXrP2uAxgHH4o3c+WA8dqtu9F/sIusglQgHZRo
 jn8i5YdbUVzkNkU53Xd2PRlCOXwOHORPmE1n5AUpKzDuyTPcXHX2L0LJwZgh25ycgwKN
 jBKwhoeH+Ik+70CNkjv3/x7VpqcCyocgBds+288QMBzDTtYqIH8FnX0qp5+5MDeZQjz6
 +l5+OsWo1LjwD6KSvwOsxf0vQU3MQhlFgBFIIYzFHjflCWznkeIrg4tcY1hvYkjNGP5J
 eSEg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8O1VFVTcQjXWUFiBYd8pvijPHUW2W3qwyI6p8gVcVDyRUbwx/PYIhjuZfm14YmFtMgBOKsMcPem0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLNf8SiWtJVnkxz5YKLQmf7DUx+z5NsYlLbgpEhafMFz/uZ2tZ
 Alr/OkB351jNpxLT2cXwuiw5kdvylhiJ2c8kzU/FaBshA4cI3X5uNzzqBv9/YAXy2QAoZu51Ubn
 5jYK/ePxy3oa9CmIFVFnpKpOUOMocmvq87KcWIUl73lcZ6VsICWa/ga6OX4n6YcAclws/dy4=
X-Gm-Gg: AfdE7ckRntKAs4NNYgkgJTFKYXu6N5RJxoqNBrLEM+pINo3hqOJeyjSjB6RjfBzf35A
 e+H8Hfd/GL77p6DKHindlJs3lQPu7rwKVHxGR2I3Wky+Vnd/xUl/478FfDlQ4qqWJ2nq4aqnF2t
 Owbo57MQAGBLk/pKPTeO/KFVuLEk0UMc9vBcvFmimAeeNGw1qHcAHJKXJ1ensHPRaUj44dwdXVG
 1zXIcGLqadjlIvw+y6MSh44w0esEchEshFOGUkMdVYGRCr3OrbRSPYzdVt6L6Xj4d83q5NI6Nsa
 bqlEKfJDEaGBASxQhubW6DciVjmYjr5W4GAbV758bqt5sUSbkAAx+IA7s6jc5QkuTY0V3nFIxdS
 6fG1lrn0EOiD4Nu+wESFAv380cKKsCffggSfTcAWWxg9DdOuEEf3sy0rlVGPtUT8=
X-Received: by 2002:a05:6214:400d:b0:8dd:d13a:8c84 with SMTP id
 6a1803df08f44-90778310a4dmr138933876d6.8.1784537063454; 
 Mon, 20 Jul 2026 01:44:23 -0700 (PDT)
X-Received: by 2002:a05:6214:400d:b0:8dd:d13a:8c84 with SMTP id
 6a1803df08f44-90778310a4dmr138933686d6.8.1784537063073; 
 Mon, 20 Jul 2026 01:44:23 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9077871f650sm87061716d6.45.2026.07.20.01.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:44:22 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:43:54 +0800
Subject: [PATCH 2/3] drm/msm/mdss: Enable INT2_GDSC alongside CORE_GDSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-msm_gdsc2-v1-2-4687866d6cb0@oss.qualcomm.com>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
In-Reply-To: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784537040; l=4105;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=av9Af9qA3AYN0apNWa1HvbDsYAoNsAS/A1GCOMQG84o=;
 b=M7+jWI9nwqNMj7No0I4fwFmPw508sY6MGQZXxwx4HRg5+Gxw2C7V6UwlFoWHTyj1PllZFQLuJ
 EIGc4pTbn/CDzTDxo5E+tcOczC4FerzgzxkDoDNjolTBGyBX2UUE+Rf
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: nb5xV2FZFoPNEayPn4G_KlKrGNUK4Jwb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfXyRGO7Nzwn97f
 Gq4O0EJI9CUFEY1T7q8KxfZatCGwcLHYTTNAnbBynQvT4c/iW6rc/l9nPM3WVGHf4gaIcHsuMpk
 I8wcEk0faZ9pvWV16GzG0/C3ejBg5SQ=
X-Authority-Analysis: v=2.4 cv=G58s1dk5 c=1 sm=1 tr=0 ts=6a5ddfe8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=f82__hHJf2zzz38AdHIA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfXxc7+Gy/dYerX
 jIaa6AvBqUbMzUiSLC+slJoWt6RgY7esjdJ564QxZYry8woyJPe/Ja6dcEf6QNMGdMfy4eZOVj5
 y5EVreKnXjsl4IH7lyz497ZEOnSEjfOFhNmgfv+fDVFdNAFG2slJYsiCpwXdZ008wiE3ULos+M0
 omDxteab4Qv1duZtq7wNA7X9MTLyXLh3M4t80GZ3Y13CFupwjhz6giJCLre38i2Y0KSsmuKvdd8
 kgzxuq/R1hCrMTZ/O8PJdGWJ03YIzX5HgSMNERu9ITJCMRC0wxmWMCesQs0YgKCL7l8Ktx0Smhd
 nQVYpViHJUZBfVNgztLX2aW342Z7ibrvxracUK0Z05ycQ7bgQV3nc1vlWyieLn1TnQLxg0w55YE
 RKGkhhQXavJFNdO7wO0M2rE8SCUpPc8xxkqFe0pyM23nTAf7mfbvwWupncZT3t6MrO91q8ksvyz
 A15XS3fGhV9va6c7ieA==
X-Proofpoint-GUID: nb5xV2FZFoPNEayPn4G_KlKrGNUK4Jwb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200096
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

Kaanapali (SM8750) and Glymur use two display power domains.
CORE_GDSC powers the main display hardware while INT2_GDSC powers
a subset of SSPP blocks (VIG2/VIG3/DMA5/DMA6).

The MDSS driver currently relies on the default runtime PM handling
and does not enable the secondary INT2_GDSC. As a result, display
pipes backed by INT2_GDSC remain inaccessible.

Attach and manage both power domains explicitly and enable them
during MDSS runtime PM activation.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 53 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9087c4b290db..63ece55c4f2e 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -13,6 +13,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
@@ -44,6 +45,7 @@ struct msm_mdss {
 	struct icc_path *mdp_path[2];
 	u32 num_mdp_paths;
 	struct icc_path *reg_bus_path;
+	struct dev_pm_domain_list *pd_list;
 };
 
 static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
@@ -233,6 +235,21 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 	int ret, i;
 	u32 hw_rev;
 
+	/*
+	 * Platforms with two power domains (e.g. Kaanapali, Glymur) need both
+	 * GDSCs enabled explicitly; the core framework only auto-attaches a
+	 * single power domain.
+	 */
+	if (msm_mdss->pd_list) {
+		ret = pm_runtime_resume_and_get(msm_mdss->pd_list->pd_devs[0]);
+		if (ret < 0)
+			return ret;
+
+		ret = pm_runtime_resume_and_get(msm_mdss->pd_list->pd_devs[1]);
+		if (ret < 0)
+			goto err_put_core;
+	}
+
 	/*
 	 * Several components have AXI clocks that can only be turned on if
 	 * the interconnect is enabled (non-zero bandwidth). Let's make sure
@@ -255,7 +272,7 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 	ret = clk_bulk_prepare_enable(msm_mdss->num_clocks, msm_mdss->clocks);
 	if (ret) {
 		dev_err(msm_mdss->dev, "clock enable failed, ret:%d\n", ret);
-		return ret;
+		goto err_put_int2;
 	}
 
 	/*
@@ -276,6 +293,14 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 	/* else UBWC 1.0 or none, no params to program */
 
 	return ret;
+
+err_put_int2:
+	if (msm_mdss->pd_list)
+		pm_runtime_put_sync(msm_mdss->pd_list->pd_devs[1]);
+err_put_core:
+	if (msm_mdss->pd_list)
+		pm_runtime_put_sync(msm_mdss->pd_list->pd_devs[0]);
+	return ret;
 }
 
 static int msm_mdss_disable(struct msm_mdss *msm_mdss)
@@ -290,6 +315,11 @@ static int msm_mdss_disable(struct msm_mdss *msm_mdss)
 	if (msm_mdss->reg_bus_path)
 		icc_set_bw(msm_mdss->reg_bus_path, 0, 0);
 
+	if (msm_mdss->pd_list) {
+		pm_runtime_put_sync(msm_mdss->pd_list->pd_devs[1]);
+		pm_runtime_put_sync(msm_mdss->pd_list->pd_devs[0]);
+	}
+
 	return 0;
 }
 
@@ -421,6 +451,27 @@ static struct msm_mdss *msm_mdss_init(struct platform_device *pdev, bool is_mdp5
 	irq_set_chained_handler_and_data(irq, msm_mdss_irq,
 					 msm_mdss);
 
+	/*
+	 * When two power domains are listed in DT, the core framework does not
+	 * auto-attach either of them.  Attach and manage both explicitly so
+	 * that INT2_GDSC (needed for VIG2/VIG3) is enabled alongside the main
+	 * CORE_GDSC.  Single-domain platforms are unaffected.
+	 */
+	if (of_count_phandle_with_args(pdev->dev.of_node, "power-domains",
+				       "#power-domain-cells") > 1) {
+		static const char * const mdss_pd_names[] = { "core", "int2" };
+		static const struct dev_pm_domain_attach_data pd_data = {
+			.pd_names = mdss_pd_names,
+			.num_pd_names = ARRAY_SIZE(mdss_pd_names),
+			.pd_flags = PD_FLAG_NO_DEV_LINK,
+		};
+
+		ret = devm_pm_domain_attach_list(&pdev->dev, &pd_data,
+						 &msm_mdss->pd_list);
+		if (ret < 0)
+			return ERR_PTR(ret);
+	}
+
 	pm_runtime_enable(&pdev->dev);
 
 	return msm_mdss;

-- 
2.43.0

