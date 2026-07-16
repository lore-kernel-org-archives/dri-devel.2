Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71939C44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3DF610E357;
	Thu, 16 Jul 2026 12:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NzcA/YnU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OzT2atfO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BB110F2D4
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBjAiI2506736
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9l0T0GCUa4XXTn8B4it8C3G46rwuAieDuTvkXQVUEaQ=; b=NzcA/YnUIFTOOyx7
 6f90moPDulXAs6HdrfRjnL8ufIMakApXtUwSx6wEybdv18wjncn1AKp7xMoe/dXB
 FDlhFvPFLeDp4J4p8u7rfIAwTG1MScJHwOOwnFgmysl/FDfYZ5SrSNE3juIQ/7pp
 MaMGUEzghiXsUDnT4MGKzBIIB1p1NovjRen1C/gMPEbBiUSRYUEe/58875T/RWcp
 GXX4l/6MJrWTNzVSiirqEJh7j+WFr7CFT4qgBZQsHvF8hqHhOwQXK7IAJXBMW/I3
 jQjiUgyJnZtF26R6zwungofLPQ5Zicsu5MBNc3Ueb7GpytHRdpuMP4/nH+14RG/w
 BsmlXA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feehvbsdd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso46757621cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205124; x=1784809924;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9l0T0GCUa4XXTn8B4it8C3G46rwuAieDuTvkXQVUEaQ=;
 b=OzT2atfOtMQvUnJy1CSdCVssgk38Pk/P/eGkrNtixq9oPt8nNWPWujii8jdjnb9tdH
 Xi8QtvR+OWDspP/O0ceYU+XOKfQJF6JO/CBiZVmBoukgmOmQ2h4zRD2Ven7mKgbGZAd1
 GK5gfqi+U4LXNnOh10nauHausS7C/VXcx0vz4W/FJRUljMcsLCWsXoH6AqkW+nhtG1it
 YPdfWH/aYfusHMriKaXpI2BbgXSr4L9+xWVhS/2RuhMS7Dh0ngjxPuDFN80RhclB+J2l
 C7ra4qaR9WCYVH7RqXolKTHL1KFQBr167Gla/Ee9Om0LoFg+PxXBdf4kcjJ6nnDFfJ/v
 LrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205124; x=1784809924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9l0T0GCUa4XXTn8B4it8C3G46rwuAieDuTvkXQVUEaQ=;
 b=KmoaLW4J2KZG/Juu0A8UH3miLRjfKxsJvu7xY4YjYStYitdLvT5bnC0pOD53V866U5
 Iidfe946kDeowyOLEvaXUdEbJbDHvuBMxp94B+QBHmo74/gHlplhNf/0Q41WYucSgoiL
 pfANuftTqmxVCqTYQyWfvnVzHddZzYV9EijIIog1uKo8uw5vIOvaK6HgfTQy66gCOa0N
 9EUTOrn93gr2LRdtEzxlyFEsBRkJSG5CIr/DomU1ra8UNkCAFiDEeDUsCTPbffADKzwm
 OZdxOGIJYr9mmc0CvkJOFrjCQOtZ+ZvSB4W6xFsZF2DosSiLs+w8bH9Pwlqyll70Kyjt
 zqHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhZOpTjGViZiBpJn7ojJWr9uo07kIqdPNspP7T6TgBTRyKj0YoSv5w4M9assnzVFKMzvQG37WgAs0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhKq5TOEAQY1ELlk4nAVRTxRapZUMKeE+L0u8437bfrXDcBZf6
 HUqqtw48gl71cCvLz4URoFxjLvbvlpWsiXa2U9H5/qUgHRGGrKd6YDc69aRo/AqgUsakeVk7+Qh
 D4PFFC7xbPguciOFIz5K9OfyOTrtzqD7RqEQ6SfdjaxrqCb6ISJJso6ReWZ+PEl/9Plw47caNhP
 uoXwM=
X-Gm-Gg: AfdE7cnWSvF3djxrVdxezPC6AzgA0OdralrA4Az0u5luZqHakhWDZ/YfOC/5oXQDYQB
 PC9Jv3p1MLjea2/BpIswmL/QdkZIEv5bbbbxHhJBOV8mdKMaOjD/a5RqeBIhFg9GWbo15YkTFVT
 9en5BbAQIDEhdlXbjQRsY0W9Nm6RT17b8l7wAMKfuqGKzlSvnNXt8wRoDB+DZOpGXfXBqwPnR/e
 4wqiegSD32g/WXfaKMO5yoYoV3o5+sTiYQnGBl6edU8+gm0PhhgKL5irNPCy0QusUSc20Ty2mmX
 SDGok4Nny1T8I+ZVQ1KZsa48tvDfHyQLKGi6KdvjLTDRfV3Lnp1Q4wHIaMsMV7oNttNKp/NLLGV
 bmmnoMeez3nsZ0GFC146Uj2f8wGo=
X-Received: by 2002:ac8:6f16:0:b0:519:f59e:8108 with SMTP id
 d75a77b69052e-51cbf1601a5mr221553321cf.31.1784205123959; 
 Thu, 16 Jul 2026 05:32:03 -0700 (PDT)
X-Received: by 2002:ac8:6f16:0:b0:519:f59e:8108 with SMTP id
 d75a77b69052e-51cbf1601a5mr221551271cf.31.1784205121589; 
 Thu, 16 Jul 2026 05:32:01 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:76f:d108:485:5b34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c7c96sm23766635f8f.33.2026.07.16.05.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:32:00 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 14:31:37 +0200
Subject: [PATCH v8 2/5] platform/surface: gpe: use
 platform_device_register_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260716-swnode-remove-on-dev-unreg-v8-2-5c2b8cc38c28@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=V/KoRkaS+83usWGN912iUHUZ0L9VCW5/9FGQG/93XDA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqWM83p9RhBwshF4v+CF7UXRSRfhDVORsXqTwJU
 8v1VZYWbjyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaljPNwAKCRAFnS7L/zaE
 w6bLEACeQ+4V/bJNhB1WQ2H6dfrwOUnKDGZwjMD2bpdwuqfEUzAcCRev4jXklTgd3KmKQmjvjJ5
 V3bviQgXPe1vcVXP7uUFN79OgQBkLMfH5mKJ62AcgOSKTLmBFYF60GRZ1XMuQkUpRP/Ambd4vzE
 TaTvXhASUgCDA32nnOTZgkLMvUPoGv5kLBBdOBsUBXGin7coEH2npQP3i8dsVUByeNzfnmmzVys
 isOEE3p8B4BKITgqM3lZ3dOSqEjGBHyoXvQouFqUgJuoEou30Dk/QYEmb79qDfFl7hbdrITIOgG
 S+bLySv/eAgRKWYiy20yFKIxiJPzWIFLXt1FhfL0TNnmH6AnV7XNaUH93hbP2OGsngqLePWyVhC
 KA/Zvzt22eJFPxOgiwvvyFlHxVcqqQ5Ss3OvTXhhBcQa1TKI5nKm/QKZOaBwSm/ADdeVso2VXJO
 kyI6h1udNzdLEk2RY8ueGxWZXQDO93MXaJDTajfwCcL00Ndx3wlylUSeX30NeIEkZ3wVEBT15ep
 A8epEbSZnjjNd2P7VgEy0e8Qp+qVu6zAuF4GIwwtOZOshdSxyM6rpOvY3N71NS7IS2ZpLH2kJ7L
 dIPr9hKSDR5eA9cYQNyAlbPDR05FixCknh3x1NSyMUCBws7Xd7DO0JhORd/gGknYTDtwuKgN9tp
 c/13CIP8A7ARwlQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=ZpDd7d7G c=1 sm=1 tr=0 ts=6a58cf44 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=vKDqCkOE6BQjc6v61vgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX5FmkQ+ViB4pr
 VHxI9IAIE9MRVnOOXL97swNN8cb2GZMVJxWmXZHSil/XqP9SA9K1M3qSFG5jrhqMu+KKLHAhz+A
 RyU79dHXVNiOXxbVTMVvrM8qHkKPExZAzp8DylZjryIzBLS33iN8m7eXYtHBB6LS2NGKMODkFLX
 vFXrztC3v6z6LxqTJ72Q+uzdFdo0AYwFwh3K9by13Ktd/7cBDZiHwZBeUfCsbpBy5UICkxgrMY0
 VP9wJNgxHqPzRg6FHbiRNMJx/iuAbIGrbTGgJtmsklpTI117weJ/1xUB6W3gflOEQvlc0XBYSU+
 rZUHwpo0b2j1e/gLGEcJLi/TrAwn/jazTauod9QunMuiaPgIokURzYxScrMZXOYXujIGWyKRfGB
 u0wgXtRp8KIVq1RXw6EONV1HfnKKFmdRoda3/szCQO9wTElPFwamdHa0XIwFuS2E9UEhBaP0Er5
 uNeoSVsBb7iJDoFt/uA==
X-Proofpoint-GUID: vYLgq7dyzR7d5euCV5cfOV9GXdCELS7I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX9G9ZdY7PMQ6d
 HhDThYKp98QVW23dY68nX4fYvH1X8Ch1afZc2cjr+wUkaqK6uJzFv+vT+yg36VrjyQkwykwkwrn
 erPG4vqq/5CFaEOkf473CIm+09lhORU=
X-Proofpoint-ORIG-GUID: vYLgq7dyzR7d5euCV5cfOV9GXdCELS7I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
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

Creating a software node for a given set of properties and adding it to
a platform device can be achieved with a single call to
platform_device_register_full(). There's nothing in this driver that
suggests using the more fine-grained interfaces was intentional so
switch to using the high-level helper.

Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/platform/surface/surface_gpe.c | 39 ++++++++++------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
index 40896a8544b0a4da4261ea881b1eaed62d93b32b..4ca7ad76f3b9d2b6c455a5d5b37f23a85eb69c69 100644
--- a/drivers/platform/surface/surface_gpe.c
+++ b/drivers/platform/surface/surface_gpe.c
@@ -290,9 +290,9 @@ static struct platform_device *surface_gpe_device;
 
 static int __init surface_gpe_init(void)
 {
+	struct platform_device_info pdevinfo;
 	const struct dmi_system_id *match;
 	struct platform_device *pdev;
-	struct fwnode_handle *fwnode;
 	int status;
 
 	match = dmi_first_match(dmi_lid_device_table);
@@ -305,44 +305,27 @@ static int __init surface_gpe_init(void)
 	if (status)
 		return status;
 
-	fwnode = fwnode_create_software_node(match->driver_data, NULL);
-	if (IS_ERR(fwnode)) {
-		status = PTR_ERR(fwnode);
-		goto err_node;
-	}
-
-	pdev = platform_device_alloc("surface_gpe", PLATFORM_DEVID_NONE);
-	if (!pdev) {
-		status = -ENOMEM;
-		goto err_alloc;
+	pdevinfo = (struct platform_device_info){
+		.name = "surface_gpe",
+		.id = PLATFORM_DEVID_NONE,
+		.properties = match->driver_data,
+	};
+
+	pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(pdev)) {
+		platform_driver_unregister(&surface_gpe_driver);
+		return PTR_ERR(pdev);
 	}
 
-	platform_device_set_fwnode(pdev, fwnode);
-
-	status = platform_device_add(pdev);
-	if (status)
-		goto err_add;
-
 	surface_gpe_device = pdev;
 	return 0;
-
-err_add:
-	platform_device_put(pdev);
-err_alloc:
-	fwnode_remove_software_node(fwnode);
-err_node:
-	platform_driver_unregister(&surface_gpe_driver);
-	return status;
 }
 module_init(surface_gpe_init);
 
 static void __exit surface_gpe_exit(void)
 {
-	struct fwnode_handle *fwnode = surface_gpe_device->dev.fwnode;
-
 	platform_device_unregister(surface_gpe_device);
 	platform_driver_unregister(&surface_gpe_driver);
-	fwnode_remove_software_node(fwnode);
 }
 module_exit(surface_gpe_exit);
 

-- 
2.47.3

