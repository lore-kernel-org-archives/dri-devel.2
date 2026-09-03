Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27348C624DA
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 639CF10F720;
	Thu,  3 Sep 2026 18:37:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hQVJWhZS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QjyfMPS/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C41510F72B
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 18:37:33 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3GfQ417597
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 18:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=t7Ub3ljv+unfOsu5RVQH5xhiC5eIDsoAHAo
 5/jO6LDQ=; b=hQVJWhZSaMMioFE9tU79LGAzhDAgQag8kowwAgcLElWAXE0vI+s
 coirHixObD7rrLlB+VnK6coKaZMj/A1w8prqypCRTVwJC5RXJZjkmcFYlhdKXQ+7
 tEaxXV0oKze9NJBYKGycMeaYVeXMxgoA2FSRpOisSE/7nejxf8M3sQyhEUNjPJE3
 nw02BaUU5XJZDKw325IVZe2UiGpJ0F8BymAU7leSZRzRPakRM2nGnG/Ne2LdmLIB
 ZsitnjudIt+TEO+4gTZtV+YyPlJOsUNbzkvZAaIKJx/lC4UFn3+SHfexlBveTkSd
 V0C8KDck16MXWne8Dbbrgi6FcC2z/VB/CWQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m2ufs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 18:37:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1c1cc5206so261856a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 11:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788460652; x=1789065452;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t7Ub3ljv+unfOsu5RVQH5xhiC5eIDsoAHAo5/jO6LDQ=;
 b=QjyfMPS/+5cLDCBy2s0nDzp/RJsl4LP/51tqZoTGiKFTX8E4ADkSJujUbn9OAxSHvJ
 fjIe6wT9agCDmtyGSaMheVwWwNhiqRUXhCFWS3TiQHKbS7GChY8Vy08GKG45MlYcAGwL
 EGD0tPZkO+DhqPOoEnsHf3G5WvNQaZ33GQ/aXpy1r3VKoujbWEHxQzFUKLsV4WFjUwIf
 yFcA16UzbPJ0q4LHhJWy7kzyAYxtBSdHhMdWYTL3Q9RHlR8uO3jApkBTk1Dsn6jxda+R
 ZXS3TX3y6BzeUJObV9fWIXk0X3H6rZ7q15WG/AMvWmMYq1eauc9R3QZNiMdV11fRL1y0
 fW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788460652; x=1789065452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t7Ub3ljv+unfOsu5RVQH5xhiC5eIDsoAHAo5/jO6LDQ=;
 b=rr6/e3aPFlnKeYQaaIOJL6YtVYGM03aO9mYXVK+cgTEdlE4Uo2ZdB07hObc5xsXWdC
 rAmNz4smuPlXAoxQb8wUUfxgloQVilQDMI9lr7QPLqkX9sgNLZmee0tSljfIF/qjfkh6
 srfjiXitZavEQpEvrXrAbuTUDnaOr1VvXJ0XI1FAyC0b0RD6c/XNdcKksspo65l2oYXl
 QtMGB1I8LN4DYHRK69iK7OEOG5+xzl3hH9qB2YnAIYciYT/FMkWPGL7dWxFGsNns6QHs
 G4BmICxVRhgebAYbEqmobnregGmHlYZKDsHtH/bcEdZYC5e714uBP58pCZl8fN70deg3
 R0eg==
X-Gm-Message-State: AFuF++k5fK5W0d8sKjFs8cfxXqbEqE4JftXspPvYcEvGAWBolOk606rs
 5NjjBtfxV9QoiZAoBfOCwiZEQHEINIbcxjsIcI3o3W68sB12O9ghQfA7OJdPDOY1LQr+faAixig
 KhyTKdvv4oHbqUmK4TB9jLGflJHdw2UXzHfC3xfuw9690/3TgEvL654y3L/kQBigflFuiopWgCg
 TSi/w=
X-Gm-Gg: AYBFou0d0l8g/craYAZlMZHInQC4xzxHF+rnZ2Lrm2eqoQLqo5T2+RWhF7dIfgDSKC2
 KDHbs10i/axFhIqkAdZZgQpeLQZ9z3iGPSxEohryHbYCObWLFW/LF5pYvRq5xflLHgax+6oIiw0
 XzXKvjb+Hx2ct1V6vsrRa3u1AvxhHMsNyJl+BVm3vbVrLeEFtwRyfgFGWLQuSHs95/W7i2O8iqN
 nl0yolzKEbScGOMvTEtZHcuDROm2FMnWzfrYVWzlnbIMN+gRmijL7OTBJIBS/I/Itau7Nn4/qNm
 9Gv3Z1pbMtCzk0oWyTfd/QBbJCViQ1foXpEFVw1gJqZtrdQObTO/3NGFaa8bM9PymVp26kGc7zM
 Pc33fsiuhIn2SLkPoS1fe86/fwOpFTu/M1mfnWOPmYG9ojvY=
X-Received: by 2002:a05:6a20:2583:b0:3bf:7bf7:7913 with SMTP id
 adf61e73a8af0-3da39ff4716mr523040637.14.1788460651588; 
 Thu, 03 Sep 2026 11:37:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:2583:b0:3bf:7bf7:7913 with SMTP id
 adf61e73a8af0-3da39ff4716mr522983637.14.1788460651127; 
 Thu, 03 Sep 2026 11:37:31 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc45515436asm10903a12.3.2026.09.03.11.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:37:30 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm: Enable THP for GEM buffers
Date: Thu,  3 Sep 2026 11:37:24 -0700
Message-ID: <20260903183725.15835-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: j48A2DQLiWQ33F-UWlCTk7CSOhphZVSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2MyBTYWx0ZWRfX70O2WzUppgOT
 ldR5AMq+i525uSnil+UQ+m/10O7UJqL8hPWiSfSM4Z7KzXZ9zBYhQFSmw+qvdHAY16EyFgMZGzN
 qybHoNB96yK7Uzl8LryYTrIQD8Apr57C5KSW8HxynGujvKiHfMK0v5UjTXSAGu3XPCgop8T1m7z
 wsTsI4rhddrb+XSKUpCCkY4JcwnEaI1n4JnCmzo/p4Y5hxH5lJeKIBD1a0A7VJedhkI++WaFMc+
 YEUPg59i5O0isQx5pcy0xeXNTrCWKa2rItWJLvlESuvdSV6er/eYo5uX5wjsp11oBbsyxlw+TpP
 rKqTDkArSqf9KvHJCmo6zBRboUP1uT+GOLLqduaKuewUa9wGa1fO6N1a0dZNQyuRfky52/a9zI5
 ToGKrbOX8D4AA5AP6KXcs79dA295KV+hAUTuS0/p7MjoXC6iRlTsp/eXxMGVBurtxwglBjyd8Uf
 BhjsSHkMbcKyTorTiAQ==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a99be6c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=bo7bELecpVJEBXAwH0gA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2MyBTYWx0ZWRfX07U6aQEvcItP
 cIdiDe084HsWQ84v24Lxm1Tp5ud1A6QYN40Txhd1QNvrf8u+EHhe78tN2rmOGza3U5yM7UQZWXX
 gmayhfqFj/PYum86F+nB1vppW0uDC/M=
X-Proofpoint-ORIG-GUID: j48A2DQLiWQ33F-UWlCTk7CSOhphZVSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030163
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

More than 2x speedup on darktable benchmark which was bottlenecked on
page allocation/pinning.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 73d99bde26f1..8129e7d229d9 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -58,9 +58,29 @@ static bool separate_gpu_kms;
 MODULE_PARM_DESC(separate_gpu_drm, "Use separate DRM device for the GPU (0=single DRM device for both GPU and display (default), 1=two DRM devices)");
 module_param(separate_gpu_kms, bool, 0400);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static bool transparent_hugepage = true;
+module_param(transparent_hugepage, bool, 0400);
+MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount point with Transparent Hugepage enabled (true = default)");
+#endif
+
 DECLARE_FAULT_ATTR(fail_gem_alloc);
 DECLARE_FAULT_ATTR(fail_gem_iova);
 
+static void msm_gem_thp_init(struct drm_device *dev)
+{
+	int err;
+
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && !transparent_hugepage)
+		return;
+
+	err = drm_gem_huge_mnt_create(dev, "within_size");
+	if (drm_gem_get_huge_mnt(dev))
+		drm_info(dev, "Using Transparent Hugepage\n");
+	else if (err)
+		drm_warn(dev, "Can't use Transparent Hugepage (%d)\n", err);
+}
+
 bool msm_gpu_no_components(void)
 {
 	return separate_gpu_kms;
@@ -178,6 +198,8 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv,
 	if (priv->kms_init)
 		msm_drm_kms_post_init(dev);
 
+	msm_gem_thp_init(ddev);
+
 	return 0;
 
 err_msm_uninit:
-- 
2.55.0

