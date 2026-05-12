Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAA4CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 12:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7110710EA5C;
	Tue, 12 May 2026 12:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nE37I/Ho";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QUh6Oeq/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C77D10EA5C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:59:59 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CARoPO2519168
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gn6K0alRO0I+gqc5hvCv/EA/xYHUJ6n4NNziUoaD22s=; b=nE37I/HofdSHCsev
 jOF859YTErogyCaMLEGhAoXMKmFjUf6CR1xMWI9X6hdsRxbdQ0USkEK42xDkpjxh
 YKT+3Wne8BxEI/LOz/1YQu/4/yi+QChNBgIIWU0bxa80ig/P3yuYNow8h+sprdfj
 arEplIdAw+T96EQFOzpEE5jhPEN2MdhcVv1wPgj7swEDVs/dhmpMK/MtxZ913MhB
 XEtXBhTOZF6MTwIxvtKmtTmCo3JYEOVUvc1oTCGKSHRD0QNksXEJUTPc3YwpMgRC
 uRmy0lLSF2H27PqGBLl3yJq/vhlzXTwmiAKSw99CplmKL4GhYFEoezbrcoyMGaKE
 wWLfPQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1k66h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:59:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b5f089a5c3so102262616d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778587198; x=1779191998;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gn6K0alRO0I+gqc5hvCv/EA/xYHUJ6n4NNziUoaD22s=;
 b=QUh6Oeq/4gP73olmHd5ydAQD3IycEb0tTI0smAqAqGE2Uk/zg4ytau89hxgBqGmh4p
 fumd1L2LxZImLKoaQLqQOTpBrRXYtL/woWKuphG7kmY4ya96XroPAvk3M7tKFH2/Nc7v
 s5yhF5YQSRB0VkNyf3DjMPWpLBYqDIBnZw7FP7t/MVnEKF3mTo/DozI8UEqeLUaBf9uM
 AehYWKELPF8fKT4mmkOg8LAYjpK0ra4YialXPb8qJwnDZe0tWQdj0sQH0vIbzSkzC69H
 Bv+u4GNkXC/RAPkQXehW8AnL1w5d3zTUyWLKlbO5BZzG8lO7reuWR2sfIWzfWCHBL6Vp
 HCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778587198; x=1779191998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gn6K0alRO0I+gqc5hvCv/EA/xYHUJ6n4NNziUoaD22s=;
 b=rIr/jSw4lmZHSv3M9sSDl0d3JHBjcpE7zQCcQ/nD94FPbk4Qh+t81hBVyP15zt3fqJ
 gk5t7sMp1aiSBDqKhwOko8Xnkb8vSw7I1TW/G2r174ezH0Vefd/IyzJiLmCELrsZVC/M
 thlcpVbU/0Jj1S6Nq1YF8Ga0rLP8rGg8mXHmY3uVd49qYNf4+qPx6Ax3cWYjHJLBUrP2
 OSMQtPl/3CLFjO+3yjB9fFIfqbz5gAL6cifVL6mnAR0W1rvu8NYnzj1jnifJxDpWqULN
 x9cY7qs809BG0mzlGFPVNv4McLQVBqGFMC/a1EkWa2/IAAeKdHKLHGmiVoauEZWmBCK8
 7ZGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dtaf8ELMV3BsH2zToBxVuSLNwELb/0SxrT90ZzBT1K2sxAl/cE2kmDzrodeXhCPphg/MEy9ZXcWA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvH3gAyoGAVrIkbK8PfMHemwUTtpagfGfhBnjVgy0o+xe8yaCf
 RmixaL9taT5J10zlHHxzyonu56PRgHmqJQqf6EM3IXsNAIk2MeWX49wR/Sd9OT+4DRVJfezTSQQ
 w83RoKido876D6UEMeQ8kgzQ70/aHDsOORhlXE/EMA781Abk3/9ahQjSLa4BBwlnpO3OC8E8=
X-Gm-Gg: Acq92OG9I6j+jSzjHWuwtRX3CbBLDszC1szBCyJdjLtV+68qUa103BN02OFQ5VSpMSk
 UV+vpjtMufM50zG0YOlwejAB0zHRBnZVheMvjWNnkBpfkYPcal7MhCUt9vCjD6J5nytyNybcO7O
 idwUZ6h3oZkCOMNYJM6geIr0RzclH4vSZIjAGEH2gi2DHQCrBvKmp9VNCX88Arb/cU+GtJOby5E
 0Uf/5TvuAuamC7zRkrybb5kL3OGf0Q1LPLhuZuNnN2DZYnh/DD2pHkVViF/2P8c3OoglEZLm43E
 7iW5kxzTKBJWX1EZfHixiyALaM7y+0keHV7X5j2wAKTHIpTLWxC1SJiP24iQqYFuBitSN2x0Psk
 qE8IOZ894rE8lkIDk2RLje4O0kmfns8hhMm4VTczILqrFuMQFJjU=
X-Received: by 2002:ac8:5fc1:0:b0:50e:6135:f27d with SMTP id
 d75a77b69052e-514a0baf33dmr202421401cf.53.1778587198297; 
 Tue, 12 May 2026 04:59:58 -0700 (PDT)
X-Received: by 2002:ac8:5fc1:0:b0:50e:6135:f27d with SMTP id
 d75a77b69052e-514a0baf33dmr202420971cf.53.1778587197795; 
 Tue, 12 May 2026 04:59:57 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:74a7:1c82:3f14:b431])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e9067811dsm73933355e9.9.2026.05.12.04.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 04:59:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 12 May 2026 13:59:25 +0200
Subject: [PATCH v5 3/7] driver core: platform: provide
 platform_device_add_software_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-swnode-remove-on-dev-unreg-v5-3-0035eff63812@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3870;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1hMeu1gCq3SSoVTeNvEzPugi/vqYRk+rwkD702lzSJ0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqAxYv3GAv2eZuGcQuN3eqfuoVY689gc9gsWBu+
 YITubifYASJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagMWLwAKCRAFnS7L/zaE
 w6BGD/0RRzcGDUT1rhONtHIRmNB6WOnJ3706An57VS2M4of4c5Goyy6PGimVshH/GIISNiMllA5
 A+KR/P1hnT+piwAECznIeztfxsH9b6O2KgxpEv7Pe2DBZkwpFQLRJ1eOAypZ3P6SoN27BKK1xi2
 JiKCS8W993kMveLuhFRw0eZtKXXtlBdtWl5zKw2IcwQkdqtkZ0CHevEFq2+hKn1Nt7jRIW/u8bd
 GJkjJuE7a0+fGAXiN4nyYGqdjTn8cjIwO1hsA/S2Z/qbw9wjk0dVMzNz4w+m9aiXOlXtLsxHE4a
 6bhj6GH2Pw0ojuHYB6Qv6dHYkKpsvav/uRy6k8qNZkbv44fUhGT5ytZe9sWG/Vl8JEY8BEMUf7s
 Qq9S9pnAYLL0tvdETWPI0t8R1K093TbTAUYCy3ECON9EMH/uzZWKRLzfxpbSRiVVesCyJdti987
 4IHGaQ90OygyC7CvDSknVUTFbyHQM8IFyJOXMNwFRx/cKE44lebECUFc8Q32dDMV2VSJesUIaru
 ZUHnNIO9Kf7aLso1DRWYryI6+qHoLh0gJETcCkvSjpzo/++uxEzX4Xs300MzzDHsox+mBiiNSDs
 BBqtytrbSkbBWad/CBk1DHnwywe3Bsrv2nM58wVgEIWsW1ml7A+ZuTMkMVe5YYGeTLBBxCaHzNZ
 yrT5web3qDg+Zdw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: IAD0kQ3WFxxBBMV-C2VHVQuExDq5EQxo
X-Proofpoint-ORIG-GUID: IAD0kQ3WFxxBBMV-C2VHVQuExDq5EQxo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyNCBTYWx0ZWRfXz6s11cqQSpm8
 rDv4mue7NChCV0Me8rJEAYe1G3h230dz7grya+ch6riVPTxKGDXI5s/UsZp88pry9U3M95KkCxS
 CXq6YrCi2pKvtG/47pW3AEnt65w4/iF+ftUarGzbUa2OMdJt3EuMRqXp2EBfK8jcBSBfNv0SptN
 n2AySQ3ZfFovr/WrR0t2KTIiy1w/JF8gBS66sKpiRf1XIV3NMLxy2hY9gYrF1o4CQ4sKJ2XOXEr
 2S8aZRCiWx1Vm2XJymSJBeicP3JXm6Ew67jWWKUhGq68PAgzm+xJZUxCvMsanRX4w8GAFY/uR+X
 bNbSj1ThgPcPTG3Yjw9DGIviVO6K15Wg9aSeVvaPdqk9hzssvHCHS7zAq6IEwTak1MpkVjwtfho
 uBFdJcDxD+C7Hki4C71kETPWJbkf2XKujyjVYVSn2lyRBq+IfXFngHiQVtrl8Ot3Ek+H9JbdmYe
 supUiRfKMTUb20cv5Pg==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a03163e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=9foaQtFGGNcyJ0tOL8QA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120124
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

The software node added to the platform device in
platform_device_register_full() is currently not removed on device
release. In order to fix this, we need to first convert all drivers that
use platform_device_alloc() and then assign a software node as the
primary firmware node to using device_add_software_node() for correct
reference counting.

To that end: provide platform_device_add_software_node() in line with
other existing helpers like platform_device_add_data().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 25 ++++++++++++++++++++++++-
 include/linux/platform_device.h |  3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 18f33bec36726490255bc7ca3c4ab07d9b7606b0..f617e02b171f6e59a3c40504a71f8915a41e8514 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -613,6 +613,10 @@ static void platform_device_release(struct device *dev)
  *
  * Create a platform device object which can have other objects attached
  * to it, and which will have attached objects freed when it is released.
+ *
+ * Note: devices allocated with this function must not have the following
+ * members assigned manually: swnode, resources and dev->platform_data.
+ * Please use the provided helper interfaces.
  */
 struct platform_device *platform_device_alloc(const char *name, int id)
 {
@@ -687,6 +691,25 @@ int platform_device_add_data(struct platform_device *pdev, const void *data,
 }
 EXPORT_SYMBOL_GPL(platform_device_add_data);
 
+/**
+ * platform_device_add_software_node - add a software node to a platform device
+ * @pdev: platform device allocated with platform_device_alloc()
+ * @swnode: software node to assign to this device, does not need to be registered
+ *
+ * If this device is already associated with a primary firmware node, add the
+ * software node as the secondary firmware node. Otherwise, make it the primary
+ * firmware node. Register the software node if needed.
+ *
+ * Returns:
+ * 0 on success, negative error number on failure.
+ */
+int platform_device_add_software_node(struct platform_device *pdev,
+				      const struct software_node *swnode)
+{
+	return device_add_software_node(&pdev->dev, swnode);
+}
+EXPORT_SYMBOL_GPL(platform_device_add_software_node);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
@@ -881,7 +904,7 @@ struct platform_device *platform_device_register_full(const struct platform_devi
 		goto err;
 
 	if (pdevinfo->swnode) {
-		ret = device_add_software_node(&pdev->dev, pdevinfo->swnode);
+		ret = platform_device_add_software_node(pdev, pdevinfo->swnode);
 		if (ret)
 			goto err;
 	} else if (pdevinfo->properties) {
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 975400a472e30e2f98cc8f13bc36a63129bd4fcf..bd421506e98fc293c97121693e4bd18b703e41fa 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -19,6 +19,7 @@ struct irq_affinity;
 struct mfd_cell;
 struct property_entry;
 struct platform_device_id;
+struct software_node;
 
 struct platform_device {
 	const char	*name;
@@ -262,6 +263,8 @@ extern int platform_device_add_resources(struct platform_device *pdev,
 					 unsigned int num);
 extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
+int platform_device_add_software_node(struct platform_device *pdev,
+				      const struct software_node *swnode);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3

