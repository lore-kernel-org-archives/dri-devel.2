Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB94ECD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5152010EF04;
	Wed, 13 May 2026 15:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fIwAsONb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y74oa6Dr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A1E10EF11
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAVpJT978420
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cgh4QSLn17J1vANVwWglRn08I0SloVcQwiRt7QECtys=; b=fIwAsONbzLCkXtYa
 KNPlSOOqNAe4a7eV25WrOsZNkAMwnBRCwGJW0f72LtbvhF701i2hs//5C9ug1O52
 Cezkr9qa1gLF137cR+2GT7wARtjoEftddoBKFyMBYIFeATgpJUvNy2Hv7DveHgtC
 5VkysksqreuXTQLbqoR4KSyQArbPBWpLS+JECRBUTsC7pIldtjM/ewvqCCsAUwQP
 pXxa4w44Y0oHU5hy4nKkZ5D4HK+jRLQk2KCX/sH9T2vZWjx+l3BDNjgfzfz5vXVv
 STlF2fXaEB8yWu0oKF6/h6sYrydwrSNTuC2g1kBlqIre/cr5mguxaLVBHB/s2HPg
 rUtFtg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e46s9vuqm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:24 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6961163ad6aso12631937eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778684723; x=1779289523;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cgh4QSLn17J1vANVwWglRn08I0SloVcQwiRt7QECtys=;
 b=Y74oa6DrptcSCI1yR9DkxoAn66HDwX4p0+qDO6P4fC80BWItJPVt2hiAge6/Z8ySNW
 uOtMxGDvGSjt22wcPO7cKQ76A19t5S0ctGAAHuNV4fHhn6JDo7BOqxTX6ZuuABgjppzv
 58mIGgRmAx4yUpEDZIDn7z4yIYA5BvgYHJ7fGVRtdxqq0tcDmT9jrDIHwHQL8JPQk3zO
 AegeKcXvpGXor03YZO69tgbZA/RTf8j+X5RYaXVvGLx6xuxElBlw/+IVAW3sefRf6hc0
 5oCW3qSlbRDM8GA0Uhe+oNH3/yW9so3JqiA8FRXUrUnvSUfYesl04IPAYCBPCuQBy+TN
 CF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778684723; x=1779289523;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cgh4QSLn17J1vANVwWglRn08I0SloVcQwiRt7QECtys=;
 b=GEA0TCmRJibwKocm37x9xHoQGCrt5ngzxEtQvkmuN5gDNbULPE6qsoczU5omRAxTOV
 whHy1PaPjuv4sts3hLW9dZaEvxbBOUGOGHjY6+CyoRLOcH0w4LOujf7/T66MSzN/EjFf
 pwLpYTGfwf1q+yDpXmKRilm7Fsq8S9L7HEp9EyPUXmEH/5XNuggBpCaPx0NlZsnYuBtf
 OIk3bVeRsOhZLn6tmrBaL2XTrbzxr4dDbb5JiguOESxZUpl3kQsd2hGFDgQemC8oTPS/
 5BO1wFVvHqmHXZGgbNp9UUVrVS+YjdPltt2RFgNBWnx+3syReC/k/5HmoVOZbd7bN5lO
 myVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+INTuLiOuYZn8VeGyrm+RHHWeJUKhL9QiKQILYHL8a8WFWUpZsxJC32jeVjRNQlb/I1NvURKoOJ/A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnbWK/IEmTDMXvvS/2UxDm92rXse48+jV3JyghaC2vw+zxZ+2U
 HCi2TqFpnDqgfwI9Z/YEwQlNM1Kn9MPZt0dQrQIoR4wI6ytRLhagem/gQJtBULdY9fBn+dQwsj2
 y38egFtPzgkCCzjtu0QAeSMuZjVNdHST0jPU6Hu00St6CSUoiRemM4kiwauGNTb+gieo8nns=
X-Gm-Gg: Acq92OEbBsCz476OHrTQpAK1fluyfNpoMXsCJwKOSXdHt/gUgL7LCALTj5HI6XUWEt/
 ZonKC8XeXV6RWjb+HRtBNwCO5zOsMqv8Rpw9K7hbDo3lnm/dTbvsJuZknJk02dv+xkAchVgmaTF
 +BSMu7NMV6p1yXo8oHu5dmHyXcYk46dCv2v4nx74jgXx1ig7BrosCYtU4gsBdQ4223U5L+i9u2W
 BhF7L7nlrONuecoc8MlyjTCTLusOtnqWZ1mMDsL96YnOLVPcgb72US+TMXC7YlKy4h2aEKuE7yV
 4WMCW/XzczRRoXirZXgpS5pnzMz0pYa5A0LVJKnnRan4wIU/K3ccv4e8ZBsdlvIMlk9zt3lIMsr
 CQFXj+KVUJP7y37urpFi+z/lAIZIONSMHGBRMHcdXp508hgOLQQ==
X-Received: by 2002:a05:6820:188d:b0:69b:544f:b2e1 with SMTP id
 006d021491bc7-69b78d497f2mr2330085eaf.2.1778684723507; 
 Wed, 13 May 2026 08:05:23 -0700 (PDT)
X-Received: by 2002:a05:6820:188d:b0:69b:544f:b2e1 with SMTP id
 006d021491bc7-69b78d497f2mr2330022eaf.2.1778684722980; 
 Wed, 13 May 2026 08:05:22 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:63ec:4acc:c4f6:423])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f542e56sm43216455e9.34.2026.05.13.08.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 08:05:22 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 13 May 2026 17:04:49 +0200
Subject: [PATCH v6 2/6] platform/surface: gpe: use
 platform_device_register_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-swnode-remove-on-dev-unreg-v6-2-f9c58939df27@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=8YXXx+c7Bfn1zIL1XiDsFM7WtZrjadc3NSaS7UHHFkI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqBJMl2Rv+Zsya8pgVoXljSmeDSjKOIFoePae2P
 wqY8CfPQXSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagSTJQAKCRAFnS7L/zaE
 w3CuD/98ugd/Cm4ouSqqIrpnFdGzXCZq235gFk9owOU/zFx+CoQTW5DwiQs2+zWJPfopBalIUME
 xllUWojs8pk6AXWy0bLhJ8zpleeq5qpzciSpxHU4Ox66qfOsbYs1Nf9DEbUTMsmre2IWFMuKCit
 lbARISHLXyEqKBji0cGiUsppbj8U6v9R2zWub4w6fJmFh4T0oJhIw9AgxBK6RRG24AWBHPBiXvf
 CTPZ25F2LLehNMX0T+Ju3IJfP+ohgaSYt/bze8gFxBb4O+dRQsKZsTOiBtR7rFzF7TQZJlevuVB
 W0FWbgZ2uFIdHSw2/nyYT+T3EowHBJ1Xcf4tVhvidSBFrhio06ERNni6e34XyhP3V3hNX2Y3ylh
 JILB7jqFDOd8r0gKUkx1bC/+xt4pTD80KpXdbXMF028sk4C2ItXFTZxeqPHqYoI8fo6mKY89z0d
 X9pFFWf+lAk8EfToQUr8hMYfxnHeqyTmL4UhzKGdq2scsEwAHIFXS9UsFouJiA26z6pTcU/R39Y
 5ofXM3GpgBV1jjMwVRSKLhsMqpEMSbkebl8kzR2Y5ttzc9swYZhOwSrrM7CK2excO5pyytVVN70
 5Samp3Z3aZATl7T1tj6zWcXGCPgxxIc4MZvaf5nmXS9neEb/fGL/byvOi4PRUI/SLF8ZcNCeth+
 ap34w4jYSGt1xsQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE1NCBTYWx0ZWRfX1ND8fB4V4gDs
 GhhVYBco07vboTUxbsgmqBQvWq7bszp7eeEk9GQJhQyTLisjfRyXHpNUbN1YIPRju1bPeOGV4Uk
 +Jz8gx9jMOpVV47Z+US1NfXZ8jOya+hCJ49bWpZC8VXA1NwqlWzbsNN7IEbJJkFcQwVsS0IANb7
 iKznDezHvBCC6hkbmmFPhFUcpKAXh+p62nZM9bKM2Y7Ynlv2hfcMRKDM/qnMHTz/UUERKOyc5Fw
 DNb+Q2rFxbcM4sBj72OxM/C4BvM/Xa2BBoJS5n9j2MaJK8A/0PKsn2gkIlwP79cahZjnaQj0yby
 s2jhvzx+GOZGdoN3EKaBFWFekmFjh5LtON8xD11nDa0+Lr3TWnFg7u141Gs1B6bclPbW37J19Lw
 bikHBnli72NrJjBXkdouLhvbLkKsp33iGBJl//1gxiCyl/aHoSiZp9fMANRi6xk0ive5JPToZpn
 pETgvKRBH03a0eH5Jtg==
X-Proofpoint-GUID: MsHOfxhYsyjBiehgq68v8qemu1lsHUaj
X-Authority-Analysis: v=2.4 cv=L68theT8 c=1 sm=1 tr=0 ts=6a049334 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=vKDqCkOE6BQjc6v61vgA:9 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: MsHOfxhYsyjBiehgq68v8qemu1lsHUaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
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

Creating a software node for a given set of properties and adding it to
a platform device can be achieved with a single call to
platform_device_register_full(). There's nothing in this driver that
suggests using the more fine-grained interfaces was intentional so
switch to using the high-level helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/platform/surface/surface_gpe.c | 36 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
index b359413903b13c4f8e8b284ef7ae6f6db3f47d72..b8bb47b0d91f036ee5073d21534f8f26a4d5ed15 100644
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
@@ -305,34 +305,20 @@ static int __init surface_gpe_init(void)
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
 
-	pdev->dev.fwnode = fwnode;
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
 

-- 
2.47.3

