Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDC5CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 12:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF6910EA66;
	Tue, 12 May 2026 12:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PT9onUSc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cmoeL64P";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F0110EA5F
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:00:01 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CB0diV2519114
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VOna9W5wpCKqk8fmVtBrEqEi7COqbhaHvWRa0Wuj+6U=; b=PT9onUSc5JUQ2Fv9
 klheK/WVRS4OuWtLDwTjyzQgQVRWiBzHsHJLHkeZ2mNDGZf7AOZKAe4i8U34YzKR
 a7KuH78hWjKDqz0a0lsxhP0cgOZKzkIOkzkX08dRxzFEycr9b6t1UXopRx6DrqXX
 OwdHaLRVCJ3rSk9TXICDQ1poendojpV08Os3soz8mbeeUlM+9UuUaLvRMj5xyE1V
 2cA6mCFNgR8Wtjmfoco/GbUTKL4A4CTBlXqqo4BN50+Bjv2Lm9x7Z0CW0w2h5/Ul
 4PxfuWv5tUfyinHuvyxV8SHGUCP/ypbPd/H5Gd47tru6fSmYi67WBS6BcG34ZD5X
 cvDfXg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1k66s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:00:00 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8bcb482b185so95841576d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778587200; x=1779192000;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VOna9W5wpCKqk8fmVtBrEqEi7COqbhaHvWRa0Wuj+6U=;
 b=cmoeL64PvSNUSm59j8q+J6w2Btm0sBg+NNknDRyqWDmxuDu/gp1mOcFPljjeyIZTeX
 0dqPjiW75mo4WSMfFQtGtTg//wkV9E3EETLKu5v7yHO4QtsHIRfkRyIozkw2As21a+Xs
 g4wQMxSD+Vyhq3k/tSViEmCWaM033DNp7l8hBYZ1ZGTye5nKd0pgwBJHgkbeQ/NrA6p2
 UhE5bFg7MKb1MndiuqisLi7qMcH1W/bcsKCGVbubMdRlS3PHBZVgKtn9E87qERhvYq9P
 pdIDkBHx4ymvi6lX0mBKb3OC1ZIEZ7HAALADs6QxRM/5kmJyHaqqhyDI5bpWKvTSFmT5
 z2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778587200; x=1779192000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VOna9W5wpCKqk8fmVtBrEqEi7COqbhaHvWRa0Wuj+6U=;
 b=lXRUawyGpwqzgYykJaI42F1yn7rmJif2gQm+fmCRJe7cRILduT3fSOtiylVBPhHo+U
 DpWAYxHOtHKcn/edwmGngmtsWp/UR2AQDxNY72shtZulsGyj3FcZ/ygpStUVCEbeWJhE
 Zutly8tyU40gRiJTtnRhc7mPpAv8wdmN/SSvJLK0yQ6uh4FxiZMLmyW28nlOiPzoo5se
 Zrs7452FEBnheDnUDi5gMcw7wzezM72WWAjonkbBtUQ1WabjTAXW6I4gWmfR4cN7uF51
 WIV3InVe0xtx3Z/FuRJ1ooKqN7uWkb+A549HQ7C0Bq/4Gax5Zd4rcBe7psWc0iekNSuH
 3cmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ywsgACLDRxsCzdFzTIe9yulSfnHro8ye/xXOm696LGoHECj2wvUx/3CasLGGjo8gibGgXEMAKx08=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUn1FhWh9vOOu4BerY6BAKTQwLieJAeQ5FpZHDjffeAwh/RDr3
 TZfG/P9PRF2IGj+o6Ty0fwhVbQj0emdpAK82Wkc01MCXBEeLDqZ1ScAerGQkx/J7elEQBjvi7Fa
 6r5qTeHVjADXm+XhUD4ecdr/GIDGpiPchRuu54dI+6W2AHkNuRMe59CI0PSKr0Lc/YPdt1GQ=
X-Gm-Gg: Acq92OEoY9w+adRSLFt091KgP9JdlVlU4M1UZhQyn5n/6ishFhp0O8ryz9EbxVOogao
 hktSz/PY+RLmsqKbsdKoIzk68UQWVGcAL/Tzs7hh5pcalaXSF0pndy8bvgLcECHV2775cE2N7hy
 r6f/lLlB75MnF6wnoCSxHbD8b0zu4Emqqp5r7QNo8CF9Zk8EdRvV+nYVGEw7mTOsW86ICHX9PO3
 tTqI9pdzRifFJVzLg7/czaBcCbSi2hXQhwTyo+jl+risEPMlsz2IS39R+WTiMtUsDKbVJom5dOn
 XEb5okxDFD9h4H1gzW/RRD0T11L7/ZAawLO9vTtVzVapqfp7VZzV4rClUC9he8evsh/bamqq2hx
 sEGtpUWdIFr+s+h+7BjevR95iYVXR4bZ8jw3dLlerOTy1G6c1ODs=
X-Received: by 2002:a05:622a:5a0c:b0:50d:e471:2d1e with SMTP id
 d75a77b69052e-514a0b162bbmr197710441cf.35.1778587200187; 
 Tue, 12 May 2026 05:00:00 -0700 (PDT)
X-Received: by 2002:a05:622a:5a0c:b0:50d:e471:2d1e with SMTP id
 d75a77b69052e-514a0b162bbmr197709991cf.35.1778587199702; 
 Tue, 12 May 2026 04:59:59 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:74a7:1c82:3f14:b431])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e9067811dsm73933355e9.9.2026.05.12.04.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 04:59:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 12 May 2026 13:59:26 +0200
Subject: [PATCH v5 4/7] drm/xe/i2c: use platform_device_add_software_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-swnode-remove-on-dev-unreg-v5-4-0035eff63812@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=WGHMjJxrf7oH7IgvHdLBFYDNllKP66ZEIO8mfOfwUTA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqAxYx2ZLKH2mMb9P0WlhVjxpG0796FSFhzeTYC
 sdRRHe05rSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagMWMQAKCRAFnS7L/zaE
 w8a7D/wIiiIDPJH/+iIMwIbha36LuO+N7wt5BKJwiQ1mnZGHaHUaehld6NCSuZ/+zP4sy1QO4VP
 HHMfo0uxwui4fTa1wEUyzrNRv9nqpCxdndVr74+DDugDpBmNpyLFl6dPKGIt3To4Z3VKBRvsWo6
 Le9q32W2epex6IrbhcIctSDzDTWFt5Owm1xmpXYy2qOM4N2rydeVx6Ok9gTCc9blWXYoJSVQd7G
 RaknUUAdAZmDTMzHZjTUu8BCF6TBbbRHKR+53IgdZn3D+i1XpDEHa+qQVsh2eL/Xi0DucI3YTKw
 IEVWs5dl5ep08Z7MtIBOf8DO9OMQXYpsWk/oMF61GL3iGo3E4MT0OyhrMY47FroSexr0iqCZ+WX
 zoYqJ+XnlaD5UHY5yNdVVEwqlBG1O/XUHFR9BpE+V7a4rCDliiV3rO12Pw7ZAemlzzJFS61fgVu
 CBPkleiltRXrUQ4wOWhue5GWWoiQn8rHnsPMmNsBp2Dnn3siL0aB8FLCL1WNE54Qw9T4xlyIQCQ
 OhpuZYuSSZmL9nmxOtqiwuHeVNThzm9A7jLkx1lWyJCCMTvRfPEuLQ9YdK/09iZv+DdmlSXVQ8x
 qrVc8Mmws39mPN7uCAd+8FMJ9ejfDq0AnLKPM2/qQO6yAsEYyf90nrFz58gE0rftVCAhvpHX1Tx
 qdjUUPNn62OIujw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: VqDsX562IW0m_BBNyX92dHooVULiuamX
X-Proofpoint-ORIG-GUID: VqDsX562IW0m_BBNyX92dHooVULiuamX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyNCBTYWx0ZWRfX8dHZRkRnFYR7
 8qVYfzZzj4Z3P9njp3t55Mc+ziSAWdeMbiLWXXJUNqrggylb3SkkbY/+CbWB9qCPVzCJz75Hc3J
 JgcceuNfxRRuZo1fJhLC3LvZFVRubYiIH7UWrgWivqBbmhs02di4sAXAnh891JcmxVJg9K60yUW
 EspT4UjFQlnR4067p+l9oOtS00dI1ksX84KIAMSZzb9ndNGSSM6kr8TobdVlsEnp+3pDYK8EvqL
 gVYUGv/p2XDPUHvH2CZYxosnY6c8LJHrAtaXgNE6eoJHfXGD+zt24ja7DUsjkns+JxirjwR3GNE
 RxSbeOMjOoFlyZQHX5MkIrau+BaFoTO9JT+7Amxu63ms51jJ1zF6CeOM3weO61nimKj5d1GxEE6
 r4iCApM6WS8/DKYDs8K8Z5TeBkeoQ3/3Lc4k5Kj05YBvT1PozMXsYEznoe4YQf4TzPaHRTso7tf
 czAu7M0Dy55KEuhtlKw==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a031640 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=583x_htki4uszOnHNJQA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
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

This driver intentionally uses the fine-grained approach to creating
platform devices. It assigns a software node as the primary firmware
node of the device it creates. Ahead of improving the reference counting
of platform device software nodes, switch to the new interface that
internally uses device_add_software_node(). While at it: define a static
software node with the provided set of properties instead of allocating
it dynamically and simplify the error path.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpu/drm/xe/xe_i2c.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 706783863d07d66b4685005d6649b3cd143ecc3b..7f4295e7dc74f112abff8427485b5c8a5ad71383 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -53,6 +53,10 @@ static const struct property_entry xe_i2c_adapter_properties[] = {
 	{ }
 };
 
+static const struct software_node xe_i2c_adapter_swnode = {
+	.properties = xe_i2c_adapter_properties,
+};
+
 static inline void xe_i2c_read_endpoint(struct xe_mmio *mmio, void *ep)
 {
 	u32 *val = ep;
@@ -96,10 +100,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 	struct fwnode_handle *fwnode;
 	int ret;
 
-	fwnode = fwnode_create_software_node(xe_i2c_adapter_properties, NULL);
-	if (IS_ERR(fwnode))
-		return PTR_ERR(fwnode);
-
 	/*
 	 * Not using platform_device_register_full() here because we don't have
 	 * a handle to the platform_device before it returns. xe_i2c_notifier()
@@ -107,10 +107,12 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 	 * platform_device_register_full() is done.
 	 */
 	pdev = platform_device_alloc(adapter_name, pci_dev_id(pci));
-	if (!pdev) {
-		ret = -ENOMEM;
-		goto err_fwnode_remove;
-	}
+	if (!pdev)
+		return -ENOMEM;
+
+	ret = platform_device_add_software_node(pdev, &xe_i2c_adapter_swnode);
+	if (ret)
+		goto err_pdev_put;
 
 	if (i2c->adapter_irq) {
 		struct resource res;
@@ -123,7 +125,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 	}
 
 	pdev->dev.parent = i2c->drm_dev;
-	pdev->dev.fwnode = fwnode;
 	i2c->adapter_node = fwnode;
 	i2c->pdev = pdev;
 
@@ -135,8 +136,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 
 err_pdev_put:
 	platform_device_put(pdev);
-err_fwnode_remove:
-	fwnode_remove_software_node(fwnode);
 
 	return ret;
 }

-- 
2.47.3

